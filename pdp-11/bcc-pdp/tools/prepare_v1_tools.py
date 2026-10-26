#!/usr/bin/env python3
"""Relocate scratch names in staged historical tools without changing code."""
import argparse
from pathlib import Path

TEMPLATES = {
    'bin/as': [b'/tmp/atm1a\0', b'/tmp/atm2a\0', b'/tmp/atm3a\0'],
    'bin/cc': [b'/tmp/ctm0a\0'],
}


def relocate(data, templates):
    for original in templates:
        if data.count(original) != 1:
            raise ValueError(f'expected one scratch template {original!r}')
        replacement = b'/usr/' + original[5:]
        if len(replacement) != len(original):
            raise ValueError('scratch relocation must preserve binary offsets')
        data = data.replace(original, replacement)
    return data


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('root', type=Path, help='generated root tree, not the pinned source tree')
    args = parser.parse_args()
    prepared = []
    for relative, templates in TEMPLATES.items():
        path = args.root / relative
        prepared.append((path, relocate(path.read_bytes(), templates)))
    for path, data in prepared:
        path.write_bytes(data)
        print(f'Relocated scratch files onto /usr: {path}')


if __name__ == '__main__':
    main()
