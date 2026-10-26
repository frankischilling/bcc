"""Records that exercise forwarding and function-scope name restoration."""


def opaque_records():
    letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_'
    return 'Adef main\n' + ''.join(letter + 'pass 123\n' for letter in letters) + 'Aend\n'


def shadowing_records():
    names = [f'n{i:07d}' for i in range(12)]
    lines = ['Agvec ' + name for name in names[:6]]
    for index in range(3):
        lines += ['Adef f' + str(index), 'Aarg ' + names[6] + ' 0', 'Aauto ' + names[0]]
        lines += ['Aextrn ' + name for name in names[1:6]]
        lines += ['Aauto ' + name for name in names[7:]]
        for name in names:
            lines += ['Rname ' + name, 'Rderef']
        lines += ['Aend', 'Rname ' + names[0], 'Rderef']
    return '\n'.join(lines) + '\n'
