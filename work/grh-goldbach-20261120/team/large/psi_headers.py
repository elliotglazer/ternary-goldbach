"""Unchain independent theta-sieve certificates by changing import headers only."""

import re


PREFIX = 'TernaryGoldbach.Prelim.PsiSieve'
DATA = re.compile(r'TernaryGoldbach\.Prelim\.PsiSieveData([1-9][0-9]*)\Z')
ALL_DATA = [PREFIX + 'Data' + str(i) for i in range(1, 283)]


def replace_header(module, raw):
    if module != PREFIX + 'Main' and not DATA.fullmatch(module):
        return raw
    original, separator, body = raw.partition(b'\n\n')
    if not separator:
        raise ValueError(f'Missing import block in {module}')
    if module == PREFIX + 'Main':
        want = [PREFIX + 'Data' + str(i) for i in (86, 279, 280, 281, 282)] + ['TernaryGoldbach.Prelim.SmallPsiTableMain']
        imports = [*ALL_DATA, 'TernaryGoldbach.Prelim.SmallPsiTableMain']
    else:
        i = int(DATA.fullmatch(module)[1])
        want = [PREFIX + '2' if i == 1 else PREFIX + 'Data' + str(i-1) if i <= 86
                else PREFIX + '3' if i <= 90 else PREFIX + 'Data' + str(i-4)]
        imports = [PREFIX + ('2' if i <= 86 else '3')]
        definitions = re.findall(rb'^def gs(\d+) : List \(.+?\) := \[\([\d (),]+\)\]$', body, re.M)
        local_checks = re.findall(rb'^theorem chunk(\d+) : resEqT \((outerT[23]?) [\d ]+ gs(\d+)\)\n'
                                  rb'    [\d ]+ = true := by\n  decide \+kernel$', body, re.M)
        if not definitions or len(definitions) != body.count(b'\ndef ') or len(local_checks) != body.count(b'\ntheorem '):
            raise ValueError(f'Unexpected declarations in {module}')
        if definitions != [n for n, fn, arg in local_checks] or any(n != arg for n, fn, arg in local_checks):
            raise ValueError(f'Certificate references a different chunk in {module}')
        if any(fn not in ([b'outerT', b'outerT2'] if i <= 86 else [b'outerT3']) for n, fn, arg in local_checks):
            raise ValueError(f'Unexpected verifier in {module}')
    def header(mods):
        return b'\n'.join(b'import ' + m.encode() for m in mods)
    if original != header(want):
        raise ValueError(f'Unexpected upstream imports in {module}')
    return header(imports) + separator + body


def separate_table_chunks(raw, module):
    """Place each original data definition and its two proofs in one Lean process."""
    begin = b"set_option maxRecDepth 100000 in\ndef gs"
    end = b"end TernaryGoldbach.Prelim.SmallTab"
    header, body = raw.split(begin, 1)
    body, trailer = body.rsplit(end, 1)
    if trailer.strip() or not body:
        raise ValueError(f"Unexpected table data in {module}")
    result = {}
    for chunk in body.split(begin):
        number = re.match(rb"(\d+) :", chunk)
        if number is None:
            raise ValueError(f"Invalid chunk declaration in {module}")
        k = number.group(1)
        if (chunk.count(b"theorem chunk" + k + b" :") != 1 or
                chunk.count(b"theorem sum" + k + b" :") != 1 or
                chunk.count(b"decide +kernel") != 2):
            raise ValueError(f"Unexpected proof bodies in {module} chunk {k!r}")
        part = module + "Chunk" + k.decode()
        if part in result:
            raise ValueError(f"Duplicate chunk {part}")
        result[part] = header + begin + chunk + end + trailer
    result[module] = "".join(f"import {p}\n" for p in result).encode()
    return result
