"""Extend the prespecified trillion endpoint leftward by 256 consecutive proof rows."""
from pathlib import Path
from math import prod
from time import process_time, perf_counter
import hashlib
import json
import subprocess
import sys
from produce import HERE, TEAM, WIDTH, HALO, HIGH, primes_through, odd_sieve, bitmap, pack, cover_tail, fmpz

COUNT = 256
LOW = HIGH-2*WIDTH*COUNT
GROUP = 8


def pair(terms):
    if len(terms) == 1:
        return terms[0]
    mid = len(terms)//2
    return f"(SmallGoldbach.join {pair(terms[:mid])} {pair(terms[mid:])})"


def produce():
    begin, wall = process_time(), perf_counter()
    primes = primes_through(1_000_000)
    flags = odd_sieve(3, WIDTH+HALO, primes)
    bits, rev = bitmap(flags), bitmap(flags[::-1])
    fac = fmpz.fac_ui(1_000_000)
    setup = process_time()-begin
    lines = ["import SampleBits","import BandMillionFactorial","namespace TrillionRows","open SmallGoldbach"]
    proof = ["import TrillionRows","namespace TrillionBlock","open SmallGoldbach",
             "set_option maxHeartbeats 0","set_option maxRecDepth 20000"]
    mask = (1<<WIDTH)-1
    names,anchors,rows = [],[],[]
    last = json.loads((HERE/"producer.json").read_bytes())
    for i in range(COUNT):
        lo = LOW+2*WIDTH*i
        start = lo-3-2*HALO
        avail = odd_sieve(start,HALO+1,primes)
        left = mask
        offsets = []
        for s, valid in enumerate(avail):
            if valid:
                delta = (bits>>(HALO-s)) & left
                if delta:
                    left ^= delta
                    offsets.append(s)
                    if not left:
                        break
                    if len(offsets)%4 == 0 and left.bit_count()<=192:
                        offsets.extend(cover_tail(left,avail,rev,len(flags),HALO,True))
                        break
        cover = 0
        for s in offsets:
            cover |= bits >> (HALO-s)
        assert cover & mask == mask
        qs = [start+2*s for s in offsets]
        modulus = prod(qs)
        inv = int(pow(fac%modulus,-1,modulus))
        assert int((fac*inv)%modulus)==1
        if i==COUNT-1:
            assert qs==last["anchors"] and lo==last["low"]
        rows.append(f'⟨{WIDTH}, {len(qs)}, packedHex% "{pack(offsets):x}", packedHex% "{inv:x}"⟩')
        anchors.append(len(qs))
        if len(rows)==GROUP:
            g = i//GROUP
            lines.append(f"def rows{g} : List Row := ["+",\n".join(rows)+"]")
            rows.clear()
            name = f"part{g}"
            names.append(name)
            proof.extend([f"private theorem {name} : Covered {lo-2*WIDTH*(GROUP-1)} {lo+2*WIDTH} :=",
                          f"  checked_interval (halo := {HALO}) SampleWindow.source BandMillionFactorial.fac_eq TrillionRows.rows{g}",
                          "    (by decide) (by decide) (by decide +kernel) (by decide +kernel)"])
    assert not rows and len(names)*GROUP==COUNT
    proof.extend([f"theorem interval : Covered {LOW} {HIGH} := {pair(names)}",
                  "#print axioms interval","end TrillionBlock"])
    texts = {"TrillionRows":"\n".join(lines+["end TrillionRows",""]),
             "TrillionBlock":"\n".join(proof+[""]),"TrillionRowsImport":"import TrillionRows\n"}
    io = perf_counter()
    for name, data in texts.items():
        (HERE/(name+".lean")).write_bytes(data.encode())
    result = dict(low=LOW,high_exclusive=HIGH,evens=COUNT*WIDTH,groups=len(names),rows=COUNT,
                  grouped_rows=GROUP,anchor_counts=anchors,setup_cpu_s=setup,
                  write_wall_s=perf_counter()-io,cpu_s=process_time()-begin,wall_s=perf_counter()-wall,
                  files={k:dict(bytes=len(v.encode()),sha256=hashlib.sha256(v.encode()).hexdigest()) for k,v in texts.items()})
    (HERE/"block-producer.json").write_text(json.dumps(result,indent=2))
    print("PRODUCED",sum(anchors),result["cpu_s"],flush=True)


def verify():
    command = [sys.executable,str(TEAM/"small-prefix/check.py"),"--scope",str(HERE),"--memory","1750"]
    for module in ("TrillionRows","TrillionRowsImport","TrillionBlock"):
        subprocess.run([*command,module],check=True)
    assert "'TrillionBlock.interval' depends on axioms: [propext, Classical.choice, Quot.sound]" in (HERE/"TrillionBlock.log").read_text()


if __name__ == "__main__":
    if "--check-only" not in sys.argv:
        produce()
    verify()
