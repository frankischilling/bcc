"""Deterministic byte fixtures for runtime selection, including long lines."""
import random


def cases():
    primitive = (b'_putchar:\n.+2\n/ bcc-meta-begin\n_time:\n.+2\n/ bcc-meta-end\n'
                 b'/ bcc-exec-begin\n_execv:\n.+2\n/ bcc-exec-end\n')
    library = b'_printf:\n.+2\n_getstr:\n.+2\n'
    programs = [b'', b'_printf:\n.+2\n', b'\t.globl _printf\n', b'_time\n', b'_execv\n',
                b'x_execv\n', b'_execvx\n', b'0\n' + b'x' * 1039 + b'\n',
                b'x' * 1039, b'x' * 1040, b'x' * 5000 + b'\n',
                b'\t_printf:\t \r\n', b'_f:\n', b'_f:\r\n', b'_f:\r \n']
    rng = random.Random(1)
    for _ in range(100):
        names = rng.sample([b'_printf', b'_getstr', b'_time', b'_execv', b'_putchar',
                            b'_abcdefgh', b'_abcdefghi'], rng.randrange(8))
        programs.append(b''.join(rng.choice([b'', b' ', b'\t']) + name +
                                 rng.choice([b':\n', b':\r\n', b'\n', b'x\n', b':\t\n'])
                                 for name in names))
    result = [(f'names/{i}', p, primitive, library) for i, p in enumerate(programs)]
    result += [(f'library/{i}', b'_printf\n', primitive, extra)
               for i, extra in enumerate((library + b'_time\n', library + b'_execv\n',
                                           library + b'x' * 1040, library + b'x' * 1039))]
    result += [(f'long/{n}', b'', b'x' * n + b'\n' + primitive, library)
               for n in (1038, 1039, 1040, 2080, 5000)]
    result.append(('binary', b'', primitive + b'\0xyz\n', library))
    return result


def rejections():
    return [
        ('unterminated', b'', b'/ bcc-meta-begin\n', b'unterminated runtime group'),
        ('unmatched', b'', b'/ bcc-meta-end\n', b'unmatched runtime group end'),
        ('nested', b'', b'/ bcc-meta-begin\n/ bcc-exec-begin\n', b'nested runtime group'),
        ('symbols', b''.join(f'_n{i:04d}:\n'.encode() for i in range(513)), b'',
         b'runtime definition table full'),
    ]
