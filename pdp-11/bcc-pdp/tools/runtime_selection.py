"""Prefer source-defined external cells without moving retained library code."""
import re

PUBLIC = re.compile(rb'^[ \t]*(_[A-Za-z0-9_]{1,8}):[ \t]*\r?$', re.M)
LABEL = re.compile(rb'^[ \t]*(_[A-Za-z0-9_]{1,8}):[ \t]*\r?\n?$')


def select_runtime(program, runtime):
    definitions = set(PUBLIC.findall(program))
    selected = []
    for line in runtime.splitlines(keepends=True):
        label = LABEL.fullmatch(line)
        if label and label[1] in definitions:
            continue
        selected.append(line)
    return b''.join(selected)


B_LIBRARY_REFERENCE = re.compile(rb'(?<![A-Za-z0-9_])_(?:printn|printf|getstr|ctime)(?![A-Za-z0-9_])')


def needs_b_library(program):
    """Keep the whole B library if any of its public cells appear in the program."""
    lines = program.split(b"\n")
    split_line = any(len(line) >= 1039 for line in lines[:-1]) or len(lines[-1]) > 1039
    return split_line or B_LIBRARY_REFERENCE.search(program) is not None
