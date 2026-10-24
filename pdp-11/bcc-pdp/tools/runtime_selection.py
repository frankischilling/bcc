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
