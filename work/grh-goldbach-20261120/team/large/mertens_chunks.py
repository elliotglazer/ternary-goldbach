"""Split the pinned Mertens walk at proposed, independently kernel-checked states."""
from math import isqrt
import re
from pathlib import Path


JOIN = """private theorem walkM_join {a b n : ℕ} {x y z : MS}
    (hx : walkM n a x = some y) (hy : walkM (n + a) b y = some z) :
    walkM n (a + b) x = some z := by
  induction a generalizing n x with
  | zero =>
    simp only [walkM, Option.some.injEq] at hx
    subst y
    simpa using hy
  | succ a ih =>
    rw [Nat.succ_add, walkM]
    rw [walkM] at hx
    split at hx
    next h =>
      rw [if_pos h]
      apply ih hx
      simpa only [Nat.succ_add, Nat.add_succ] using hy
    next => contradiction

"""
WALK = re.compile(r"(?m)^theorem (wk_\d+) : walkM (\d+) (\d+) (⟨[\d, ]+⟩) = some (⟨[\d, ]+⟩) := by decide \+kernel$")


def checkpoints():
    top = 10002
    prime = [n >= 2 and all(n % d for d in range(2, isqrt(n) + 1)) for n in range(top + 1)]
    powers = {p**k: k for p in range(2, 101) if prime[p] for k in range(2, 14) if p**k <= top}
    lo = hi = slo = shi = plo = phi = 0
    states = {1: (lo, hi, slo, shi, plo, phi)}
    scale = 10**30
    for n in range(1, top):
        odd = 2*n + 1
        inc = sum(2*scale // (d * odd**d) for d in range(1, 24, 2))
        lo += inc
        hi += inc + 13 + 3*scale // (25 * odd**25)
        m = n + 1
        if prime[m]:
            l, h = lo, hi
        elif m in powers:
            l, h = lo // powers[m], hi // powers[m] + 1
        else:
            l, h = 0, 0
        slo += l // m
        shi += h // m + 1
        plo += l
        phi += h
        states[m] = (lo, hi, slo, shi, plo, phi)
    return states


def split_mertens(raw, step=32):
    return split_walk(raw, step, 'walkM', JOIN, checkpoints(), 11)


def split_walk(raw, step, function, join, states, expected):
    src = raw.decode()
    pattern = re.compile(WALK.pattern.replace('walkM', function))
    if len(pattern.findall(src)) != expected:
        raise ValueError(f"Expected {expected} pinned {function} walks")

    def state(n):
        return "⟨" + ", ".join(map(str, states[n])) + "⟩"

    def rewrite(m):
        name, n, length, start, end = m.groups()
        n, length = int(n), int(length)
        stop = n + length
        if (start, end) != (state(n), state(stop)):
            raise ValueError(f"Original checkpoint mismatch at {name}")
        if length <= step:
            return m[0]
        pieces = []
        proof = None
        for a in range(n, stop, step):
            b = min(a+step, stop)
            part = f"{name}_step_{a}"
            pieces.append(f"private theorem {part} : {function} {a} {b-a} {state(a)} = some {state(b)} := by decide +kernel")
            if proof is None:
                proof = part
            else:
                joined = name if b == stop else f"{name}_upto_{b}"
                visibility = "" if b == stop else "private "
                pieces.append(f"{visibility}theorem {joined} : {function} {n} {b-n} {start} = some {state(b)} :=\n"
                              f"  {function}_join (a := {a-n}) (b := {b-a}) {proof} {part}")
                proof = joined
        return "\n".join(pieces)

    return pattern.sub(rewrite, src.replace("theorem wk_1 :", join + "theorem wk_1 :", 1)).encode()


def separate_modules(raw, original="TernaryGoldbach.Prelim.SmallMertensLower",
                     ns="TernaryGoldbach.Prelim.MertWalk", join=JOIN, expected=320):
    """Keep independent interval checks in separate compiler processes."""
    base = original + "Base"
    text = raw.decode()
    head, rest = text.split(join)
    pieces, tail = rest.split("theorem inv_1 :", 1)
    end = f"\nend {ns}\n"
    sources = {base: (head + end).encode()}
    ground = []
    assembly = []
    for line in pieces.splitlines(keepends=True):
        if re.match(r"private theorem wk_\d+_step_\d+ :", line):
            ground.append(line.removeprefix("private "))
        else:
            assembly.append(line)
    if len(ground) != expected:
        raise ValueError(f"Expected {expected} checked intervals, found {len(ground)}")
    imports = []
    for offset in range(0, len(ground), 8):
        name = original + f"Steps{1 + offset//8:02}"
        imports.append(f"import {name}")
        body = f"import {base}\n\nnamespace {ns}\n\n" + "".join(ground[offset:offset+8]) + end
        sources[name] = body.encode()
    opens = head[head.index("open Finset Real"):head.index("/-! ###")]
    sources[original] = ("\n".join(imports) + "\n\n" + opens + join + "".join(assembly)
                         + "theorem inv_1 :" + tail).encode()
    return sources


def ramare_modules(raw):
    scale=10**30
    lo,hi,hlo,hhi,plo,phi,nlo,nhi,tlo,thi=0,0,scale,scale,0,0,0,0,0,0
    states={1:(lo,hi,hlo,hhi,plo,phi,nlo,nhi,tlo,thi)}
    for n in range(1,20001):
        odd=2*n+1
        inc=sum(2*scale//(d*odd**d) for d in range(1,24,2))
        lo+=inc
        hi+=inc+13+3*scale//(25*odd**25)
        m=n+1
        hlo+=scale//m
        hhi+=scale//m+1
        if m<=2000:
            w=scale//(m*m)
            if m%2:
                plo+=lo*w
                phi+=hi*(w+1)
            else:
                nlo+=lo*w
                nhi+=hi*(w+1)
        if all(m%d for d in range(2,isqrt(m)+1)):
            v=scale//(n*m*(n+2))
            tlo+=lo*v
            thi+=hi*(v+1)
        states[m]=(lo,hi,hlo,hhi,plo,phi,nlo,nhi,tlo,thi)
    join=JOIN.replace('walkM','walkW').replace(': MS}', ': WS}')
    pattern=re.compile(WALK.pattern.replace('walkM','walkW'))
    checks=sum((int(m[2])+31)//32 for m in pattern.findall(raw.decode()) if int(m[2])>32)
    return separate_modules(split_walk(raw,32,'walkW',join,states,23),
        "TernaryGoldbach.Prelim.RamareWalk","TernaryGoldbach.Prelim.RamPf",join,checks)


def split_mu_phi_modules(raw):
    """Move 150 disjoint upstream checks into batches without changing any theorem."""
    module = "TernaryGoldbach.Prelim.SmallMuPhi"
    text = raw.decode()
    first = text.index("theorem w_0 :")
    last = text.index("theorem c_0 :")
    rows = text[first:last].strip().splitlines()
    assert len(rows) == 150
    for i, row in enumerate(rows):
        if not row.startswith(f"theorem w_{i} : walkS {1000*i} ") or not row.endswith(" := by decide +kernel"):
            raise ValueError(f"Unexpected mu-phi checkpoint {i}")
    base = module + "Base"
    end = f"\nend {module}\n"
    sources = {base: (text[:first] + end).encode()}
    imports = []
    for i in range(0, 150, 3):
        name = module + f"Steps{i//3+1:02}"
        imports.append(f"import {name}")
        sources[name] = (f"import {base}\n\nnamespace {module}\n\n" + "\n".join(rows[i:i+3]) + end).encode()
    sources[module] = ("\n".join(imports) + f"\n\nopen Finset\nnamespace {module}\n\n" + text[last:]).encode()
    return sources


def separate_literal_theorems(raw, *, module, namespace, first, expected, batch):
    """Move a contiguous list of independent one-line proofs to smaller modules."""
    text = raw.decode()
    head, tail = text.split("\ntheorem " + first + " :", 1)
    tail = "theorem " + first + " :" + tail
    theorem = re.compile(r"^theorem (\w+) : [^\n]+ := by decide \+kernel\n+", re.M)
    names, blocks = [], []
    while match := theorem.match(tail):
        names.append(match[1])
        blocks.append(match[0])
        tail = tail[match.end():]
    if names != expected:
        raise ValueError(f"The independent numerical declarations in {module} changed")
    scopes = "\n".join(r for r in head.splitlines() if r.startswith(("open ", "namespace ")))
    end = f"\nend {namespace}\n"
    base = module + "ChecksBase"
    result = {base: (head + "\n" + end).encode()}
    imports = []
    for offset in range(0,len(blocks),batch):
        part = module + f"Checks{1+offset//batch:02}"
        imports.append(f"import {part}")
        result[part] = (f"import {base}\n\n{scopes}\n\n" + "".join(blocks[offset:offset+batch]) + end).encode()
    result[module] = ("\n".join(imports) + f"\n\n{scopes}\n\n" + tail).encode()
    return result


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Materialize two diagnostic modules in a generated build.")
    parser.add_argument("directory", type=Path)
    out = parser.parse_args().directory.resolve()
    if not (out / ".goldbach-large-build").is_file():
        raise ValueError("Expected a generated large-theorem build")
    from prepare import REPO
    upstream = (REPO / "TernaryGoldbach/Prelim/SmallMertensLower.lean").read_bytes().replace(b"\r\n", b"\n")
    text = split_mertens(upstream).decode()
    end = "\nend TernaryGoldbach.Prelim.MertWalk\n"
    # Stop before the first exhaustive prime-power test, and after the first
    # checked 32-step interval, respectively.
    for name, marker in [("MertensPrimePrefix", "theorem PPL_complete_b"),
                         ("MertensFirstChunk", "private theorem wk_1_step_33")]:
        (out / (name + ".lean")).write_text(text[:text.index(marker)] + end)
