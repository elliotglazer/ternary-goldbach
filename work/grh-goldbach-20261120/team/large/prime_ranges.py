"""Split the upstream literal prime-table equalities into kernel-checked ranges."""

import re


def prime_table_modules(raw, *, module, table, predicate, limit, namespace, marker, bound, prefix="primeRange",
                        first=0, base_header=None):
    source = raw.decode()
    before, after = source.split(marker)
    if bound:
        original = "  decide +kernel"
        if not after.startswith(original):
            raise ValueError("The source proof of membership has changed")
        after = after[len(original):]
    match = re.search(rf"def {table} : List ℕ := \[([0-9, ]+)\]", before)
    if not match:
        raise ValueError(f"Expected a literal table for {table}")
    values = [int(x) for x in match[1].split(",")]
    if values != sorted(set(values)) or values[-1] >= limit:
        raise ValueError(f"Invalid range for {table}")
    base = module + "RangeBase"
    end = f"\nend {namespace}\n"
    join = """theorem primeRangeAppend {p : ℕ → Bool} {s m n : ℕ} {x y : List ℕ}
    (hl : x = (List.range' s m).filter p)
    (hr : y = (List.range' (s + m) n).filter p) :
    x ++ y = (List.range' s (m + n)).filter p := by
  rw [← List.range'_append_1, List.filter_append, ← hl, ← hr]
"""
    modules = {base: ((before if base_header is None else base_header) + join.replace('primeRangeAppend', prefix+'Append') + end).encode()}
    scopes = "\n".join(row for row in before.splitlines() if row.startswith(("namespace ", "open ")))
    imports = []
    ranges = []
    body = []
    chunk_size = 128
    for start in range(first, limit, chunk_size):
        size = min(chunk_size, limit - start)
        chunk = [v for v in values if start <= v < start + size]
        name = f"{prefix}_{start}_{size}"
        body.append(f"theorem {name} : {chunk} = (List.range' {start} {size}).filter {predicate} := by decide +kernel")
        ranges.append((start, size, chunk, name))
        if len(body) == 4 or start + size == limit:
            part = module + f"RangePart{len(imports)+1:02}"
            imports.append(f"import {part}")
            modules[part] = (f"import {base}\n\n{scopes}\n\n" + "\n".join(body) + end).encode()
            body.clear()
    joined = []
    while len(ranges) > 1:
        next_level = []
        for index in range(0, len(ranges), 2):
            s, m, left, a = ranges[index]
            if index+1 == len(ranges):
                next_level.append(ranges[index])
                break
            t, n, right, b = ranges[index+1]
            assert t == s+m
            name = f"{prefix}_{s}_{m+n}"
            chunk = left + right
            joined.append(f"private theorem {name} : {chunk} = (List.range' {s} {m+n}).filter {predicate} :=\n"
                          f"  {prefix}Append (s := {s}) (m := {m}) (n := {n}) {a} {b}")
            next_level.append((s, m+n, chunk, name))
        ranges = next_level
    assembly = ("\n".join(imports) + f"\n\n{scopes}\n\nsection\nset_option maxRecDepth 100000\n\n"
                + "\n\n".join(joined) + "\nend\n\n")
    result = f"by\n  rw [List.range_eq_range']\n  exact {ranges[0][3]}"
    if base_header is not None:
        result = ranges[0][3]
    if bound:
        assembly += f"private theorem primeTable_eq_range : {table} = (List.range {limit}).filter {predicate} := {result}\n\n"
        assembly += marker + "  intro n hn\n  rw [primeTable_eq_range, List.mem_filter]\n  simp [hn]"
    else:
        assembly += marker.removesuffix("by decide +kernel") + result
    modules[module] = (assembly + after).encode()
    return modules


def sieve_prime_table(raw):
    return prime_table_modules(raw, module="TernaryGoldbach.Prelim.PsiSieve", table="PS",
        predicate="isPrimeSlow'", limit=7101, namespace="TernaryGoldbach.Prelim.SieveTab",
        marker="set_option maxRecDepth 100000 in\ntheorem PS_eq : PS = (List.range 7101).filter isPrimeSlow' := by decide +kernel", bound=False)


def sieve3_prime_table(raw):
    module = 'TernaryGoldbach.Prelim.PsiSieve3'
    namespace = 'TernaryGoldbach.Prelim.SieveTab'
    source = raw.decode()
    before, checks = source.split('set_option maxRecDepth 100000 in\ntheorem PS3b0_eq', 1)
    checks, tail = ('set_option maxRecDepth 100000 in\ntheorem PS3b0_eq' + checks).split('theorem PS3_eq', 1)
    scopes = '\n'.join(s for s in before.splitlines() if s.startswith(('namespace ', 'open ')))
    base = module + 'Tables'
    result = {base: (before + f'\nend {namespace}\n').encode()}
    imports = []
    for i, marker in enumerate(checks.strip().split('\n\n')):
        start, size = i * 4000, min(4000, 31623 - i * 4000)
        table = f'PS3b{i}'
        expected = f'set_option maxRecDepth 100000 in\ntheorem {table}_eq : {table} = (List.range\' {start} {size}).filter isPrimeSlow3 := by decide +kernel'
        if marker != expected:
            raise ValueError(f'Unexpected pinned range declaration for {table}')
        part = module + f'Block{i}'
        result.update(prime_table_modules((before + marker + f'\nend {namespace}\n').encode(),
            module=part, table=table, predicate='isPrimeSlow3', limit=start+size, first=start,
            namespace=namespace, marker=marker, bound=False, prefix=f'primeRange{table}',
            base_header=f'import {base}\n\n{scopes}\n\n'))
        imports.append(f'import {part}')
    if len(imports) != 8:
        raise ValueError('Expected all eight PS3 block checks')
    result[module] = ('\n'.join(imports) + f'\n\n{scopes}\n\nset_option maxRecDepth 100000 in\ntheorem PS3_eq' + tail).encode()
    return result


def mu_prime_table(raw):
    return prime_table_modules(raw, module="TernaryGoldbach.Prelim.SmallMuWalk", table="P1470",
        predicate="isPrimeSlow38", limit=1471, namespace="TernaryGoldbach.Prelim.SmallMu",
        marker="set_option maxRecDepth 10000 in\ntheorem P1470_complete : ∀ n ∈ List.range 1471, (n ∈ P1470 ↔ isPrimeSlow38 n = true) := by\n", bound=True)


def sieve2_prime_table(raw):
    return prime_table_modules(raw, module="TernaryGoldbach.Prelim.PsiSieve2", table="PS2",
        predicate="isPrimeSlow2", limit=14143, namespace="TernaryGoldbach.Prelim.SieveTab",
        marker="set_option maxRecDepth 100000 in\ntheorem PS2_eq : PS2 = (List.range 14143).filter isPrimeSlow2 := by decide +kernel",
        prefix="primeRangePS2", bound=False)
