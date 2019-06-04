"""
IPython Magic to show sequence's indexes.

Useful to demonstrate how python indexes works with strings.

Example:

>>> %indexes henrique
 0  1  2  3  4  5  6  7
 h  e  n  r  i  q  u  e
-8 -7 -6 -5 -4 -3 -2 -1

This file should be copies to:

.ipython/profile_default/startup/

from: https://gist.githubusercontent.com/henriquebastos/3139b86b84f89997a454/raw/ab156640dcd8b7aa208f753289e0276eed2e2fc0/magic_indexes.py
"""
from IPython.core.magic import register_line_magic


def indexes_func(s):
    if not s: return
    l = len(s)
    h = [str(n) for n in range(l)]
    f = [str(n-l) for n in range(l)]
    w = len(max(f, key=len))
    r = lambda l: [c.rjust(w) for c in l]
    return '\n'.join([' '.join(r(h)), ' '.join(r(s)), ' '.join(r(f))])


@register_line_magic
def indexes(iter):
    '''Shows indexes of a sequence'''
    print(indexes_func(iter))
