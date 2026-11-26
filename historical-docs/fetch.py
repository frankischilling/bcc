#!/usr/bin/env python3
"""Retrieve the cataloged historical originals and verify their SHA-256 hashes."""

import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import tempfile
from urllib.parse import urlsplit
from urllib.request import Request, urlopen


ROOT = Path(__file__).resolve().parent
DOWNLOADS = ROOT / 'downloads'


def sha256(path):
    digest = hashlib.sha256()
    with path.open('rb') as source:
        for block in iter(lambda: source.read(1024 * 1024), b''):
            digest.update(block)
    return digest.hexdigest()


def entries(group):
    seen = set()
    for catalog in sorted(ROOT.glob('*/sources.json')):
        if group and catalog.parent.name != group:
            continue
        for entry in json.loads(catalog.read_text(encoding='utf-8')):
            relative = PurePosixPath(entry['path'])
            if (relative.is_absolute() or '..' in relative.parts or
                    not relative.parts or relative.parts[0] != catalog.parent.name or
                    '\\' in entry['path'] or ':' in entry['path']):
                raise ValueError(f'Invalid archive path: {entry["path"]}')
            destination = DOWNLOADS.joinpath(*relative.parts)
            if not destination.resolve().is_relative_to(DOWNLOADS.resolve()):
                raise ValueError(f'Archive path escapes downloads: {relative}')
            if destination in seen:
                raise ValueError(f'Duplicate archive path: {relative}')
            seen.add(destination)
            digest = entry['sha256']
            if len(digest) != 64 or any(c not in '0123456789abcdef' for c in digest):
                raise ValueError(f'Invalid SHA-256 for {relative}')
            if urlsplit(entry['url']).scheme not in ('https', 'http'):
                raise ValueError(f'Unsupported source URL: {entry["url"]}')
            yield entry, destination


def retrieve(entry, destination, check):
    if destination.is_file():
        if sha256(destination) == entry['sha256']:
            return 'verified'
        raise ValueError('local file differs from catalog; preserve it and review')
    if check:
        raise FileNotFoundError('local copy missing')
    destination.parent.mkdir(parents=True, exist_ok=True)
    temporary = None
    try:
        request = Request(entry['url'], headers={'User-Agent': 'BCC historical archive/1.0'})
        with urlopen(request, timeout=60) as response:
            with tempfile.NamedTemporaryFile(dir=destination.parent, delete=False) as output:
                temporary = Path(output.name)
                while block := response.read(1024 * 1024):
                    output.write(block)
        if sha256(temporary) != entry['sha256']:
            raise ValueError('download differs from catalog')
        temporary.replace(destination)
        return 'downloaded'
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--group', choices=('b-language', 'pdp-11', 'unix'))
    parser.add_argument('--check', action='store_true', help='verify existing files only')
    args = parser.parse_args()
    selected = list(entries(args.group))
    if not selected:
        parser.error('no source catalog entries selected')
    passed = failed = 0
    for entry, destination in selected:
        try:
            result = retrieve(entry, destination, args.check)
            print(f'{result}: {entry["path"]}', flush=True)
            passed += 1
        except (OSError, ValueError) as error:
            print(f'failed: {entry["path"]}: {error}', flush=True)
            failed += 1
    print(f'{passed} verified or downloaded; {failed} failed')
    return bool(failed)


if __name__ == '__main__':
    raise SystemExit(main())
