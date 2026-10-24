#!/usr/bin/env python3
"""Prepare the published wiki from reviewed repository pages, without pushing."""
import argparse
from pathlib import Path
import re
import subprocess
from urllib.parse import quote

ROOT = Path(__file__).resolve().parents[1]
REPOSITORY = 'https://github.com/frankischilling/bcc'
# Keep existing page URLs, whose original filenames included an extra .md.
LEGACY = {'B_LANGUAGE', 'WIKI_ARRAYS_POINTERS', 'WIKI_CONTROL_STRUCTURES',
          'WIKI_DATA_TYPES', 'WIKI_EXAMPLES', 'WIKI_FILE_IO', 'WIKI_FUNCTIONS',
          'WIKI_IO_FUNCTIONS', 'WIKI_RUNTIME_LIBRARY', 'WIKI_STRING_OPERATIONS',
          'WIKI_SYSTEM_CALLS', 'WIKI_TESTS'}


def page_name(source):
    return source.name if source.stem in LEGACY else source.stem


def render(source, revision, pull_request=None):
    text = source.read_text()
    def link(match):
        title, target = match.groups()
        if target.startswith(('https://', 'http://', '#', 'mailto:')):
            return match[0]
        path, separator, fragment = target.partition('#')
        resolved = (source.parent/path).resolve()
        if not resolved.is_relative_to(ROOT) or not resolved.exists():
            raise ValueError(f'{source.name}: invalid local link {target}')
        if resolved.parent == ROOT/'wiki' and resolved.suffix == '.md':
            url = REPOSITORY+'/wiki/'+quote(page_name(resolved))
        else:
            kind = 'tree' if resolved.is_dir() else 'blob'
            url = f'{REPOSITORY}/{kind}/{revision}/'+quote(resolved.relative_to(ROOT).as_posix())
        if separator: url += '#'+fragment
        return f'[{title}]({url})'
    text = re.sub(r'\[([^\]\n]+)\]\(([^)\n]+)\)', link, text)
    status = f'Implementation notes reflect [revision {revision[:7]}]({REPOSITORY}/tree/{revision}).'
    if pull_request:
        status += (f' These changes are being reviewed in [PR #{pull_request}]'
                   f'({REPOSITORY}/pull/{pull_request}); this page does not claim they are merged.')
    status += '\n\n' 
    heading, newline, rest = text.partition('\n')
    return heading+'\n\n'+status+rest.lstrip('\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', type=Path, help='local checkout of bcc.wiki.git')
    parser.add_argument('--revision', required=True, help='commit containing the reviewed pages')
    parser.add_argument('--pull-request', type=int, help='unmerged PR containing this revision')
    parser.add_argument('--check', action='store_true', help='compare without writing')
    args = parser.parse_args()
    if args.pull_request is not None and args.pull_request < 1:
        parser.error("pull request number must be positive")
    revision = subprocess.check_output(['git', 'rev-parse', '--verify', args.revision+'^{commit}'], cwd=ROOT, text=True).strip()
    target = args.directory.resolve(strict=True)
    if target == ROOT or not (target/'.git').exists():
        parser.error('destination must be a separate Git checkout')
    pages = sorted((ROOT/'wiki').glob('*.md'))
    rendered = []
    for source in pages:
        committed = subprocess.check_output(['git', 'show', f'{revision}:{source.relative_to(ROOT).as_posix()}'], cwd=ROOT)
        if committed != source.read_bytes():
            parser.error(f'{source.name} differs from the requested revision; commit and review it first')
        rendered.append((target/(page_name(source)+'.md'), render(source, revision, args.pull_request)))
    changed = 0
    for path, content in rendered:
        if path.exists() and path.read_text() == content: continue
        changed += 1
        print(('DIFF: ' if args.check else 'WRITE: ')+path.name)
        if not args.check: path.write_text(content)
    print(f'{len(pages)} pages checked; {changed} changed')
    return bool(changed) if args.check else 0


if __name__ == '__main__':
    raise SystemExit(main())
