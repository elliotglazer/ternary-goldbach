"""Produce an exact prefix certificate. All arithmetic claims are replayed in Lean."""
import argparse
import json
from math import factorial, isqrt, prod
from pathlib import Path
import time


HERE = Path(__file__).resolve().parent


def primes_through(n):
    flags = bytearray(b"\1")*(n+1)
    flags[:2] = b"\0\0"
    for p in range(2, isqrt(n)+1):
        if flags[p]:
            flags[p*p::p] = bytes((n-p*p)//p+1)
    return [p for p, v in enumerate(flags) if v]


def odd_sieve(first, width, primes):
    flags = bytearray(b"\1")*width
    end = first+2*(width-1)
    for p in primes:
        if p*p > end:
            break
        if p == 2:
            continue
        k = max(p, (first+p-1)//p)
        k += 1-k%2
        i = (k*p-first)//2
        if i < width:
            flags[i::p] = bytes((width-1-i)//p+1)
    return flags


def bitmap(flags):
    buf = bytearray((len(flags)+7)//8)
    for j, flag in enumerate(flags):
        buf[j//8] |= flag << (j%8)
    return int.from_bytes(buf,"little")


def pack(offsets):
    return int.from_bytes(b"".join(s.to_bytes(2,"little") for s in offsets),"little")


def lean_list(name, typ, values, lines):
    # Small literals keep the elaborator's list notation shallow.
    chunks = []
    for i in range(0,len(values),32):
        part = f"{name}Part{i//32}"
        lines.append(f"def {part} : List {typ} := ["+",\n  ".join(values[i:i+32])+"]")
        chunks.append(part)
    lines.append(f"def {name} : List {typ} := "+" ++ ".join(chunks))


def build(k, width=None, halo=None, out=HERE):
    start = time.process_time()
    bound = 10**k
    total = (bound-6)//2+1
    cutoff = isqrt(bound)
    if width is None:
        width = min(total, max(2048, 1 << (4*cutoff-1).bit_length()))
    if halo is None:
        halo = min(1024 if k <= 6 else 32*k*k, max(1, width//2))
    if not (1 <= halo < 65536 and width > 0):
        raise ValueError("positive width and encodable halo required")
    primes = primes_through(isqrt(max(bound+2*halo+4,3+2*(width+halo))))
    flags = odd_sieve(3,width+halo,primes)
    bits = bitmap(flags)
    segments = []
    i = 0
    while i < len(flags):
        first = 3+2*i
        # Every marked prime must exceed the square-root cutoff for its chunk.
        end = min(i+512, len(flags), ((first*first-1)-3)//2+1)
        offsets = [j-i for j in range(i,end) if flags[j]]
        if offsets:
            d = isqrt(3+2*(end-1))
            assert d < first
            segments.append(f"⟨{i}, {d}, {len(offsets)}, {hex(pack(offsets))}⟩")
        i = end
    source_cpu = time.process_time()-start
    fac = factorial(cutoff)
    rows = []
    anchors = 0
    max_anchors = 0
    for pos in range(0,total,width):
        w = min(total-pos,width)
        origin = 6+2*pos
        skip = min(halo,pos)
        base = origin-3-2*skip
        # For the first tile all anchors are already in the source bitmap.
        available = flags[:halo+1] if base == 3 else odd_sieve(base,halo+1,primes)
        mask = (1<<w)-1
        uncovered = mask
        offsets = []
        for s, flag in enumerate(available):
            if not flag:
                continue
            part = ((bits<<s)>>skip) & uncovered
            if part:
                offsets.append(s)
                uncovered ^= part
                if not uncovered:
                    break
        if uncovered:
            j = (uncovered & -uncovered).bit_length()-1
            raise ValueError(f"widen halo for {origin+2*j}")
        roots = [base+2*s for s in offsets]
        inv = 0 if base == 3 else pow(fac,-1,prod(roots))
        rows.append(f"⟨{w}, {len(offsets)}, {hex(pack(offsets))}, {hex(inv)}⟩")
        anchors += len(roots)
        max_anchors = max(max_anchors,len(roots))
    producer_cpu = time.process_time()-start
    name = f"Power{k}"
    dependency = "PrefixFactorial" if k>=9 else "PrefixJoin" if k>=7 else "PrefixSource"
    lines = ["import "+dependency,"namespace SmallGoldbach."+name,
             "open PrimeCoverage SmallGoldbach","set_option maxRecDepth 20000",
             "set_option maxHeartbeats 0"]
    lean_list("segments","Segment",segments,lines)
    lines += [f"def bits : Nat := {hex(bits)}",
              "theorem certifiedSource : PrimeBitmap 3 bits := by",
              "  have h : sourceBits segments = bits := by decide +kernel",
              "  exact h ▸ source_sound segments (by decide +kernel)",
              f"def fac : Nat := {hex(fac)}",
              f"theorem fac_eq : fac = Nat.factorial {cutoff} := "+
              (f"factorial_of_product {(cutoff//32).bit_length()} (by decide +kernel)"
               if k>=9 else "by decide +kernel")]
    if k < 7:
        lean_list("rows","Row",rows,lines)
        certificate = f"prefix_of_rows (halo := {halo}) certifiedSource fac_eq rows (by decide +kernel) (by decide +kernel)"
    else:
        parts = []
        for i in range(0,len(rows),8):
            lo = 6+2*i*width
            hi = min(bound+2, lo+16*width)
            group = f"rows{i}"
            part = f"part{i}"
            lines.append(f"def {group} : List Row := ["+",\n  ".join(rows[i:i+8])+"]")
            lines += [f"theorem {part} : Covered {lo} {hi} :=",
                      f"  checked_interval (halo := {halo}) certifiedSource fac_eq {group}",
                      "    (by decide) (by decide) (by decide +kernel) (by decide +kernel)"]
            parts.append(part)
        while len(parts)>1:
            parts = [f"(SmallGoldbach.join {parts[j]} {parts[j+1]})" if j+1<len(parts) else parts[j]
                     for j in range(0,len(parts),2)]
        certificate = f"prefix_of_covered {parts[0]} (by decide)"
    lines += [f"theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^{k} →",
              "    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=",
              "  "+certificate,"end SmallGoldbach."+name]
    out.mkdir(exist_ok=True, parents=True)
    (out/(name+".lean")).write_text("\n".join(lines)+"\n",encoding="utf-8",newline="\n")
    meta = dict(k=k,bound=bound,even_targets=total+1,width=width,halo=halo,rows=len(rows),
                marked_source_primes=sum(flags),source_slots=len(flags),segments=len(segments),
                anchor_occurrences=anchors,max_anchors=max_anchors,source_cpu=source_cpu,
                generator_cpu=producer_cpu,write_inclusive_cpu=time.process_time()-start)
    (out/(name+".input.json")).write_text(json.dumps(meta,indent=2)+"\n")
    print(meta,flush=True)


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("k",type=int,nargs="+",choices=range(1,13))
    ap.add_argument("--width",type=int)
    ap.add_argument("--halo",type=int)
    ap.add_argument("--out",type=Path,default=HERE)
    args = ap.parse_args()
    for k in args.k:
        build(k,args.width,args.halo,args.out)
