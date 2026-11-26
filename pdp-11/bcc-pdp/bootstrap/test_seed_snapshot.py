#!/usr/bin/env python3
"""Check reusable seed snapshots and bounded guest rebuild selections."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'tools'))
from build_toolchain import FILES
from seed_snapshot import copy_seed
from test_toolchain_v1 import rebuild_case


def fake_seed(path):
    path.mkdir()
    groups = {
        'sources': {pair[1] for pair in FILES.values()} | {'vm.b', 'bdrv.b'},
        'seed_inputs': {'bmain.s', 'brt.s', 'libb.s', 'libb.b'},
        'images': {pair[0] for pair in FILES.values()},
        'native': {'engine', 'driver'},
    }
    manifest = {'revision': '0'*40, 'worktree_dirty': False}
    for group, names in groups.items():
        manifest[group] = {}
        for name in sorted(names):
            data = name.encode()+b'\n'
            (path/name).write_bytes(data)
            digest = hashlib.sha256(data).hexdigest()
            manifest[group][name] = {'bytes': len(data), 'sha256': digest} if group in ('images', 'native') else digest
    (path/'seed.json').write_text(json.dumps(manifest))
    return manifest


class Snapshot(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='bcc-seed-snapshot-')
        self.work = Path(self.temp.name)
        self.seed = self.work/'source'
        self.output = self.work/'snapshot'
        self.manifest = fake_seed(self.seed)

    def tearDown(self):
        self.temp.cleanup()

    def save(self):
        (self.seed/'seed.json').write_text(json.dumps(self.manifest))

    def test_exact_private_copy(self):
        before = {p.name:p.read_bytes() for p in self.seed.iterdir()}
        self.assertEqual(copy_seed(self.seed, self.output), self.manifest)
        self.assertEqual({p.name:p.read_bytes() for p in self.output.iterdir()}, before)
        self.assertEqual({p.name:p.read_bytes() for p in self.seed.iterdir()}, before)
        self.assertTrue((self.output/'engine').stat().st_mode & 0o111)
        (self.seed/'bf.b').write_bytes(b'changed after snapshot')
        self.assertEqual((self.output/'bf.b').read_bytes(), before['bf.b'])

    def test_no_overwrite(self):
        self.output.mkdir()
        (self.output/'keep').write_bytes(b'keep')
        with self.assertRaises(ValueError):copy_seed(self.seed, self.output)
        self.assertEqual(list(self.output.iterdir()), [self.output/'keep'])
        self.assertEqual((self.output/'keep').read_bytes(), b'keep')

    def test_bad_files_leave_no_output(self):
        for change in ('missing', 'directory', 'symlink', 'hash', 'oversized'):
            with self.subTest(change=change):
                path = self.seed/'bf.b'
                original = path.read_bytes()
                path.unlink()
                if change == 'directory':path.mkdir()
                elif change == 'symlink':path.symlink_to(self.seed/'br.b')
                elif change == 'hash':path.write_bytes(b'changed')
                elif change == 'oversized':path.write_bytes(bytes(65536))
                with self.assertRaises(ValueError):copy_seed(self.seed, self.output)
                self.assertFalse(self.output.exists())
                if path.is_dir():path.rmdir()
                elif path.exists() or path.is_symlink():path.unlink()
                path.write_bytes(original)

    def test_bad_manifest(self):
        original = json.dumps(self.manifest)
        for change in ('missing-group', 'extra-name', 'missing-name', 'bad-hash', 'wrong-length', 'bool-length', 'wrong-type'):
            with self.subTest(change=change):
                self.manifest = json.loads(original)
                if change == 'missing-group':del self.manifest['sources']
                elif change == 'extra-name':self.manifest['sources']['../outside'] = '0'*64
                elif change == 'missing-name':del self.manifest['images']['front.vm']
                elif change == 'bad-hash':self.manifest['sources']['bf.b'] = None
                elif change == 'wrong-length':self.manifest['native']['engine']['bytes'] += 1
                elif change == 'bool-length':self.manifest['native']['engine']['bytes'] = True
                else:self.manifest = []
                self.save()
                with self.assertRaises(ValueError):copy_seed(self.seed, self.output)
                self.assertFalse(self.output.exists())

    def test_manifest_limits(self):
        for data in (b'not json', b'x'*1048577):
            (self.seed/'seed.json').write_bytes(data)
            with self.assertRaises(ValueError):copy_seed(self.seed, self.output)
            self.assertFalse(self.output.exists())

    def test_full_and_selected_rebuilds(self):
        _, console, _, references = rebuild_case(self.seed)
        self.assertEqual(len(console.splitlines()), 11)
        self.assertEqual(len(references), 12)
        wrapper, console, _, references = rebuild_case(self.seed, ['engine', 'image'])
        self.assertEqual(console, b'BCC_STAGE templates\nBCC_STAGE library\nBCC_STAGE image\nBCC_STAGE engine\n')
        self.assertEqual(set(references), {'bmain.s', 'brt.s', 'libb.s', 'imag.new', 'eng.new'})
        self.assertIn('"bi.b","imag.new"', wrapper)
        self.assertNotIn('"be.b","enco.new"', wrapper)

    def test_invalid_selections(self):
        for selected in ([], ['missing'], ['image', 'image']):
            with self.subTest(selected=selected), self.assertRaises(ValueError):
                rebuild_case(self.seed, selected)

    def test_cli_rejects_before_running_guest(self):
        for flags in (['--component', 'image'], ['--seed', str(self.seed)],
                      ['--self-test', '--component', 'image', '--component', 'image']):
            result = subprocess.run([sys.executable, str(ROOT/'test_toolchain_v1.py'), *flags],
                                    capture_output=True, timeout=15)
            self.assertEqual(result.returncode, 2, result)
            self.assertIn(b'error:', result.stderr)


if __name__ == '__main__':
    unittest.main()
