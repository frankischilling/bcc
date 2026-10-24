"""Frame one guest command without confusing its output with the shell prompt."""
import re


def command_line(command, marker):
    if not re.fullmatch(r'[A-Za-z0-9_]+', marker):
        raise ValueError('invalid console completion marker')
    return f'{command}; echo; echo {marker}'


def completion_pattern(marker):
    return re.compile(rb'\r?\n' + re.escape(marker.encode('ascii')) + rb' ?\r?\n# $')


def program_output(raw, line, marker):
    text = raw.decode('latin-1').replace('\r\n', '\n')
    echo = line + '\n'
    if text.startswith(echo):
        text = text[len(echo):]
    # The restored echo leaves a space after its final argument.
    suffix = re.search(r'\n' + re.escape(marker) + r' ?\n# \Z', text)
    if suffix is None:
        raise ValueError('guest command has no shell completion marker')
    return text[:suffix.start()]


def compile_failure(output, produced, diagnostic=None):
    """Require a driver failure, no executable, and any requested message."""
    failed = b'b: pass failed' in output or b'b: assembler failed' in output
    requested = diagnostic is None or diagnostic.encode('utf-8') in output
    return not produced and failed and requested
