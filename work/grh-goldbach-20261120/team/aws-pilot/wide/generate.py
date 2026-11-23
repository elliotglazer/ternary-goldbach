"""Generate two consecutive equal-width certified blocks sharing one source table."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import sys
from time import process_time

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent))
sys.dont_write_bytecode = True
from pilot import candidate, lucas_nodes


def write(path, lines):
    path.write_text("\n".join(lines)+"\n",encoding="utf-8",newline="\n")


def lean_tree(nodes):
    lines = []
    def go(xs):
        if not xs:
            return "BatchPrime.Tree.empty"
        mid = len(xs)//2
        p,a,fs = xs[mid]
        l,r = go(xs[:mid]),go(xs[mid+1:])
        term = f"(BatchPrime.Tree.node {l} {p} {a} {fs} {r})"
        if len(xs) >= 16:
            lines.append(f"def tree{p} : BatchPrime.Tree := {term}")
            return f"tree{p}"
        return term
    root = go(nodes)
    return lines+[f"def cert : BatchPrime.Tree := {root}"]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--width",type=int,choices=[8192,262144],default=8192)
    parser.add_argument("--out",type=Path,required=True)
    args = parser.parse_args()
    out=args.out.resolve()
    out.mkdir(parents=True,exist_ok=False)
    width=args.width
    first=4097
    halo=4096
    slots=width+halo
    upper=first+2*(slots-1)
    d=math.isqrt(upper)
    start=process_time()
    prime=bytearray(b"\x01")*(upper+1)
    prime[:2]=b"\x00\x00"
    for p in range(2,d+1):
        if prime[p]:
            prime[p*p::p]=b"\x00"*len(prime[p*p::p])
    chunk_size=512
    chunks=[]
    source_bytes=bytearray((slots+7)//8)
    for base in range(0,slots,chunk_size):
        ids=[j for j in range(min(chunk_size,slots-base)) if prime[first+2*(base+j)]]
        p0=first+2*base
        product=math.prod(p0+2*j for j in ids)
        assert math.gcd(product,math.factorial(d))==1
        bits=sum(1<<j for j in ids)
        source_bytes[base//8:(base+chunk_size)//8]=bits.to_bytes(chunk_size//8,"little")
        chunks.append((base,ids,bits))
    source=int.from_bytes(source_bytes,"little")
    (out/"source.bin").write_bytes(source_bytes)
    source_cpu=process_time()-start
    mask=(1<<width)-1
    stop=4*10**15
    origins=[stop-4*width+2,stop-2*width+2]
    blocks=[]
    start=process_time()
    for origin in origins:
        anchors,ss=[],[]
        filled=0
        for s in range(halo+1):
            q=origin-first-2*s
            if not candidate(q):
                continue
            gain=(source>>s) & mask & ~filled
            if gain:
                anchors.append(q)
                ss.append(s)
                filled |= gain
                if filled==mask:
                    break
        if filled!=mask:
            raise ValueError("anchor halo insufficient")
        blocks.append(dict(origin=origin,shifts=ss,anchors=anchors))
    search_cpu=process_time()-start
    start=process_time()
    roots={q for b in blocks for q in b["anchors"]}
    nodes=lucas_nodes(roots)
    anchor_cpu=process_time()-start
    checker=["Cover.lean","Table.lean"]
    for f in checker:
        (out/f).write_bytes((HERE/f).read_bytes())
    start=process_time()
    imports=[]
    for group in range(0,len(chunks),8):
        name=f"SourcePart{group//8:03d}"; imports.append(name)
        lines=["import Table","namespace UpperShared","open PrimeCoverage WideGoldbach",
               "set_option maxRecDepth 65536","set_option maxHeartbeats 0"]
        for base,ids,bits in chunks[group:group+8]:
            p0=first+2*base
            lines.extend([f"def offsets{base} : List Nat := {ids}",
                          f"theorem slice{base} : PrimeBitmap {p0} {hex(bits)} := by",
                          f"  have h := table_chunk {p0} {d} offsets{base} (by decide +kernel) (by decide +kernel)",
                          f"  have hv : marks offsets{base} = {hex(bits)} := by decide +kernel",
                          "  exact hv ▸ h"])
        write(out/(name+".lean"),lines+["end UpperShared"])
    aggregate=["import "+s for s in imports]+["namespace UpperShared","open PrimeCoverage WideGoldbach",
                                               "set_option maxRecDepth 65536","set_option maxHeartbeats 0"]
    def join(chunks):
        if len(chunks)==1:
            base,ids,bits=chunks[0]
            return (f"({hex(bits)} <<< {base})",f"(shift_chunk {first} {base} {hex(bits)} slice{base})")
        k=len(chunks)//2
        l,hl=join(chunks[:k]); r,hr=join(chunks[k:])
        # Persist each internal union, allowing reuse in the next level.
        part=f"union{chunks[0][0]}_{chunks[-1][0]}"
        aggregate.extend([f"def {part} : Nat := {l} ||| {r}",
                          f"theorem {part}_sound : PrimeBitmap {first} {part} := PrimeBitmap.union {hl} {hr}"])
        return part,part+"_sound"
    joined,proof=join(chunks)
    aggregate.extend([f"def source : Nat := {hex(source)}",
                      f"theorem source_sound : PrimeBitmap {first} source := by",
                      f"  have h : {joined} = source := by decide +kernel",f"  exact h ▸ {proof}",
                      "end UpperShared"])
    write(out/"Shared.lean",aggregate)
    lines=["import BatchPrime","namespace UpperAnchors","open BatchPrime",
           "set_option maxRecDepth 65536","set_option maxHeartbeats 0"]+lean_tree(nodes)
    write(out/"Anchors.lean",lines+["theorem valid : treeValid cert cert = true := by decide +kernel","end UpperAnchors"])
    for i,b in enumerate(blocks):
        o=b["origin"]
        write(out/f"Shard{i}.lean",["import Anchors","import Shared","import Cover",f"namespace UpperShard{i}",
              "open UpperShared UpperAnchors WideGoldbach","set_option maxHeartbeats 0",
              f"def shifts : List Nat := {b['shifts']}",
              f"theorem verified : ∀ n, {o} ≤ n → n < {o+2*width} → n % 2 = 0 → PrimeCoverage.BinaryGoldbach n :=",
              f"  block (origin := {o}) (width := {width}) (ss := shifts) valid source_sound",
              "    (by decide +kernel) (by decide +kernel) (by decide)",f"end UpperShard{i}"])
    write(out/"Combined.lean",["import Shard0","import Shard1", "namespace WideGoldbach",
          f"theorem endpoint_range : ∀ n : Nat, {origins[0]} ≤ n → n ≤ {stop} → n % 2 = 0 →",
          "    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by","  intro n hlo hhi he",
          f"  by_cases hm : n < {origins[1]}",
          "  · exact UpperShard0.verified n hlo hm he","  · exact UpperShard1.verified n (by omega) (by omega) he",
          "end WideGoldbach"])
    write(out/"WideAudit.lean",["import Combined","#print WideGoldbach.endpoint_range","#print axioms WideGoldbach.endpoint_range"])
    stages=["Table","Cover"]+imports+["Shared","Anchors","Shard0","Shard1","Combined","WideAudit"]
    metadata=dict(width=width,target_count=2*width,low=origins[0],high=stop,first=first,
                  slots=slots,halo=halo,sqrt_cutoff=d,source_primes=source.bit_count(),
                  bytes_source_bitmap=len(source_bytes),source_chunks=len(chunks),chunk_slots=chunk_size,
                  max_chunk_entries=max(len(ids) for _,ids,_ in chunks),anchor_roots=len(roots),lucas_nodes=len(nodes),
                  blocks=blocks,stages=stages,source_generation_cpu=source_cpu,anchor_search_cpu=search_cpu,
                  anchor_certificate_cpu=anchor_cpu,lean_export_cpu=process_time()-start)
    metadata["inputs"]={p.name:dict(sha256=hashlib.sha256(p.read_bytes()).hexdigest(),bytes=p.stat().st_size)
                        for p in sorted(out.iterdir()) if p.is_file()}
    (out/"workload.json").write_text(json.dumps(metadata,indent=2)+"\n")
    print(json.dumps({k:v for k,v in metadata.items() if k not in ["blocks","stages","inputs"]}))

if __name__=="__main__":
    main()
