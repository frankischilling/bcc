"""Copy a seed's known files after checking the producer's manifest hashes."""
import hashlib
import json
from pathlib import Path

from build_toolchain import FILES


def copy_seed(source, output):
    """Make a private, manifest-consistent snapshot; never modify the input."""
    source, output = Path(source), Path(output)
    if output.exists() or output.is_symlink():
        raise ValueError('seed snapshot destination already exists')
    manifest_path = source / 'seed.json'
    if manifest_path.is_symlink() or not manifest_path.is_file():
        raise ValueError('missing regular seed manifest')
    if manifest_path.stat().st_size > 1048576:
        raise ValueError('seed manifest is too large')
    with manifest_path.open('rb') as stream:
        raw_manifest = stream.read(1048577)
    if len(raw_manifest) > 1048576:
        raise ValueError('seed manifest is too large')
    manifest = json.loads(raw_manifest)
    if not isinstance(manifest, dict):
        raise ValueError('invalid seed manifest')
    groups = {
        'sources': {pair[1] for pair in FILES.values()} | {'vm.b', 'bdrv.b'},
        'seed_inputs': {'bmain.s', 'brt.s', 'libb.s', 'libb.b'},
        'images': {pair[0] for pair in FILES.values()},
        'native': {'engine', 'driver'},
    }
    contents = {}
    for group, names in groups.items():
        records = manifest.get(group)
        if not isinstance(records, dict) or set(records) != names:
            raise ValueError('unexpected seed manifest entries: ' + group)
        for name in sorted(names):
            path = source / name
            if path.is_symlink() or not path.is_file():
                raise ValueError('missing regular seed file: ' + name)
            if path.stat().st_size > 65535:
                raise ValueError('seed file exceeds guest file limit: ' + name)
            with path.open('rb') as stream:
                data = stream.read(65536)
            if len(data) > 65535:
                raise ValueError('seed file exceeds guest file limit: ' + name)
            record = records[name]
            digest = record
            if group in ('images', 'native'):
                if not isinstance(record, dict) or type(record.get('bytes')) is not int:
                    raise ValueError('invalid seed image record: ' + name)
                if record['bytes'] != len(data) or not data:
                    raise ValueError('seed image length mismatch: ' + name)
                digest = record.get('sha256')
            if not isinstance(digest, str) or hashlib.sha256(data).hexdigest() != digest:
                raise ValueError('seed hash mismatch: ' + name)
            contents[name] = data
    # No caller-owned output is created until all input bytes have been checked.
    output.mkdir(parents=True, exist_ok=False)
    for name, data in contents.items():
        path = output / name
        path.write_bytes(data)
        path.chmod(0o755 if name in groups['native'] else 0o644)
    (output / 'seed.json').write_bytes(raw_manifest)
    return manifest
