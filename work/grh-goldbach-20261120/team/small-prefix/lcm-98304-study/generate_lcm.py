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


def most_frequent(choices):
    """Find the smallest bit position present in the most candidate sets."""
    # Each bit position counts independently. Three equally weighted masks
    # reduce to a parity mask and a carry mask of twice the weight.
    level = list(choices)
    digits = []
    while level:
        next_level = []
        while len(level) >= 3:
            a, b, c = level.pop(), level.pop(), level.pop()
            ab = a ^ b
            level.append(ab ^ c)
            next_level.append((a & b) | (ab & c))
        a = level.pop()
        if level:
            b = level.pop()
            digits.append(a ^ b)
            next_level.append(a & b)
        else:
            digits.append(a)
        level = next_level
    best = 0
    for digit in reversed(digits):
        if best == 0:
            best = digit
        elif best & digit:
            best &= digit
    return best & -best


def cover_tail(uncovered, available, reverse_bits, source_len, skip, greedy=False):
    """Group the remaining targets that admit a common prime anchor."""
    candidates = bitmap(available)
    choices = []
    while uncovered:
        bit = uncovered & -uncovered
        target = bit.bit_length()-1
        shift = source_len-1-(target+skip)
        if shift < 0:
            raise ValueError("target is outside the source table")
        possible = candidates & (reverse_bits >> shift)
        if not possible:
            raise ValueError(f"no prime anchor for residual position {target}")
        choices.append(possible)
        uncovered ^= bit
    if greedy:
        while choices:
            best = most_frequent(choices)
            yield best.bit_length()-1
            choices = [possible for possible in choices if not possible & best]
        return
    while choices:
        common = choices[0]
        retry = []
        for possible in choices[1:]:
            intersection = common & possible
            if intersection:
                common = intersection
            else:
                retry.append(possible)
        yield (common & -common).bit_length()-1
        choices = retry


def lean_list(name, typ, values, lines):
    # Small literals keep the elaborator's list notation shallow.
    chunks = []
    for i in range(0,len(values),32):
        part = f"{name}Part{i//32}"
        lines.append(f"def {part} : List {typ} := ["+",\n  ".join(values[i:i+32])+"]")
        chunks.append(part)
    lines.append(f"def {name} : List {typ} := "+" ++ ".join(chunks))


def build(k, width=None, halo=None, out=HERE, fast_inverse=False, tail_size=0, fast_hex=False,
          greedy_tail=False):
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
    reverse_bits = bitmap(flags[::-1]) if tail_size else 0
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
    fac = __import__("math").lcm(*range(1,cutoff+1))
    if fast_inverse:
        from flint import fmpz
        inverse_base = fmpz(fac)
        def inverse(modulus):
            return int(pow(inverse_base,-1,fmpz(modulus)))
    else:
        def inverse(modulus):
            return pow(fac,-1,modulus)
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
            shift = s-skip
            shifted = bits >> -shift if shift < 0 else bits << shift
            part = shifted & uncovered
            if part:
                offsets.append(s)
                uncovered ^= part
                if not uncovered:
                    break
                if tail_size and len(offsets)%4 == 0 and uncovered.bit_count() <= tail_size:
                    offsets.extend(cover_tail(uncovered, available, reverse_bits, len(flags), skip, greedy_tail))
                    uncovered = 0
                    break
        if uncovered:
            j = (uncovered & -uncovered).bit_length()-1
            raise ValueError(f"widen halo for {origin+2*j}")
        roots = [base+2*s for s in offsets]
        inv = 0 if base == 3 else inverse(prod(roots))
        rows.append(f"⟨{w}, {len(offsets)}, {hex(pack(offsets))}, {hex(inv)}⟩")
        anchors += len(roots)
        max_anchors = max(max_anchors,len(roots))
    producer_cpu = time.process_time()-start
    name = f"Power{k}"
    dependency = "PrefixFactorial" if k>=9 else "PrefixJoin" if k>=7 else "PrefixSource"
    lines = ["import LcmBridge","namespace SmallGoldbach."+name,
             "open PrimeCoverage SmallGoldbach","set_option maxRecDepth 20000",
             "set_option maxHeartbeats 0"]
    lean_list("segments","Segment",segments,lines)
    lines += [f"def bits : Nat := {hex(bits)}",
              "theorem certifiedSource : PrimeBitmap 3 bits := by",
              "  have h : sourceBits segments = bits := by decide +kernel",
              "  exact h ▸ source_sound segments (by decide +kernel)",
              f"def fac : Nat := {hex(fac)}",
              f"theorem fac_eq : SmallGoldbach.LcmExperiment.support {cutoff} fac = true := "+
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
                      f"  SmallGoldbach.LcmExperiment.checked_interval (halo := {halo}) certifiedSource fac_eq {group}",
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
    source = "\n".join(lines)+"\n"
    if fast_hex:
        from split_power import packed_literals
        source = "import FastHex\n" + packed_literals(source)
    (out/(name+".lean")).write_text(source,encoding="utf-8",newline="\n")
    meta = dict(k=k,bound=bound,even_targets=total+1,width=width,halo=halo,rows=len(rows),
                marked_source_primes=sum(flags),source_slots=len(flags),segments=len(segments),
                anchor_occurrences=anchors,max_anchors=max_anchors,source_cpu=source_cpu,
                generator_cpu=producer_cpu,write_inclusive_cpu=time.process_time()-start,
                inverse_backend="python-flint" if fast_inverse else "python")
    if tail_size:
        meta["tail_size"] = tail_size
    if greedy_tail:
        meta["greedy_tail"] = True
    if fast_hex:
        meta["fast_hex"] = True
    (out/(name+".input.json")).write_text(json.dumps(meta,indent=2)+"\n")
    print(meta,flush=True)


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("k",type=int,nargs="+",choices=range(1,13))
    ap.add_argument("--width",type=int)
    ap.add_argument("--halo",type=int)
    ap.add_argument("--fast-inverse",action="store_true",help="use optional python-flint for modular inverses")
    ap.add_argument("--tail-size",type=int,default=0,help="group this many remaining targets by common anchor (zero disables)")
    ap.add_argument("--greedy-tail",action="store_true",help="choose the anchor covering the most remaining targets at each step")
    ap.add_argument("--fast-hex",action="store_true",help="use FastHex.lean for long numerals")
    ap.add_argument("--out",type=Path,default=HERE)
    args = ap.parse_args()
    if args.tail_size < 0:
        ap.error("--tail-size must be nonnegative")
    if args.greedy_tail and not args.tail_size:
        ap.error("--greedy-tail requires a positive --tail-size")
    for k in args.k:
        build(k,args.width,args.halo,args.out,args.fast_inverse,args.tail_size,args.fast_hex,args.greedy_tail)
