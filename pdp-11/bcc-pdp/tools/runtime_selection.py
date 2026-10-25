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


EXEC_REFERENCE = re.compile(rb'(?<![A-Za-z0-9_])_(?:execl|execv)(?![A-Za-z0-9_])')


def needs_exec_runtime(program, library=b''):
    for text in (program, library):
        lines = text.split(b"\n")
        split_line = any(len(line) >= 1039 for line in lines[:-1]) or len(lines[-1]) > 1039
        if split_line or EXEC_REFERENCE.search(text) is not None:
            return True
    return False


META_REFERENCE = re.compile(rb'(?<![A-Za-z0-9_])_(?:fork|wait|chdir|link|chmod|chown|stat|fstat|stty|gtty|setuid|getuid|time|mkdir|makdir)(?![A-Za-z0-9_])')


def needs_meta_runtime(program, library=b''):
    for text in (program, library):
        lines = text.split(b"\n")
        split_line = any(len(line) >= 1039 for line in lines[:-1]) or len(lines[-1]) > 1039
        if split_line or META_REFERENCE.search(text) is not None:
            return True
    return False


def select_primitive_runtime(program, runtime, library=b''):
    selected = select_runtime(program, runtime)
    omitted = set()
    if not needs_exec_runtime(program, library):
        omitted.add(b'exec')
    if not needs_meta_runtime(program, library):
        omitted.add(b'meta')
    if not omitted:
        return selected
    output = []
    active = None
    markers = {b'/ bcc-' + group + suffix: (group, begin)
               for group in (b'exec', b'meta')
               for suffix, begin in ((b'-begin', True), (b'-end', False))}
    for line in selected.splitlines(keepends=True):
        marker = markers.get(line.rstrip(b" \t\r\n"))
        if marker:
            group, begin = marker
            if begin:
                if active is not None:
                    raise ValueError('nested runtime group')
                active = group
            else:
                if active != group:
                    raise ValueError('unmatched runtime group end')
                active = None
            if group in omitted:
                continue
        if active not in omitted:
            output.append(line)
    if active is not None:
        raise ValueError('unterminated runtime group')
    return b''.join(output)
