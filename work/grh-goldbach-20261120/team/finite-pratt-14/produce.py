"""Prespecified high interval with explicit Lucas primality certificates."""
from pathlib import Path
import json, os, subprocess, sys
from time import process_time
from flint import fmpz

HERE=Path(__file__).resolve().parent
TEAM=HERE.parent
SMALL=TEAM/"small-prefix"
sys.path.insert(0,str(SMALL))
from generate import primes_through,odd_sieve,bitmap,cover_tail

W,H=524288,4096
hi=10**14+2
lo=hi-2*W
base=lo-3-2*H
start=process_time()
flags=odd_sieve(3,W+H,primes_through(1100))
bits,rev=bitmap(flags),bitmap(flags[::-1])
avail=[fmpz(base+2*i).is_prime() for i in range(H+1)]
left=(1<<W)-1
ss=[]
for s,ok in enumerate(avail):
    if ok:
        delta=(bits>>(H-s)) & left
        if delta:
            left^=delta
            ss.append(s)
            if not left: break
            if len(ss)%4==0 and left.bit_count()<=192:
                ss.extend(cover_tail(left,avail,rev,len(flags),H,True))
                break
covered=0
for s in ss: covered|=bits>>(H-s)
assert covered&((1<<W)-1)==(1<<W)-1
roots=[base+2*s for s in ss]
cov=process_time()-start
cert={}
def visit(p):
    if p in cert: return
    if p==2:
        cert[2]=(0,[])
        return
    fac=[(int(q),int(e)) for q,e in fmpz(p-1).factor()]
    for q,e in fac: visit(q)
    a=2
    while pow(a,p-1,p)!=1 or any(pow(a,(p-1)//q,p)==1 for q,e in fac): a+=1
    cert[p]=(a,fac)
for p in roots: visit(p)
prefix=["import PrimeSupport","namespace Pratt14","set_option maxRecDepth 20000","set_option maxHeartbeats 0"]
for p,(a,fac) in sorted(cert.items()):
    if p==2:
        prefix+=["theorem p2 : Nat.Prime 2 := Nat.prime_two"]
        continue
    fs=[q for q,e in fac for _ in range(e)]
    prod=str(fs[-1])
    for q in reversed(fs[:-1]): prod=f"{q} * ({prod})"
    prefix += [f"theorem p{p} : Nat.Prime {p} := by",
               f"  apply lucasNat {p} {a} (by decide) (by decide +kernel)",
               "  intro q hq hd",f"  rw [show {p}-1 = {prod} by decide] at hd",
               "  simp only [Nat.Prime.dvd_mul hq, "+", ".join(f"Nat.prime_dvd_prime_iff_eq hq p{q}" for q,e in fac)+"] at hd"]
    if len(fs)==1: prefix+=["  subst q","  decide +kernel"]
    else: prefix+=["  rcases hd with "+" | ".join(f"h{i}" for i in range(len(fs))),"  all_goals subst q; decide +kernel"]
prefix+=["end Pratt14"]
(HERE/"Pratt14.lean").write_text("\n".join(prefix)+"\n",encoding="utf8")
original=(SMALL/"PrefixCheck.lean").read_text(encoding="utf8")
lemmas=original[original.index("private theorem translates_witness"):original.index("/-- A producer supplies")]
out=["import Pratt14","import SampleBits","namespace Pratt14Cover","open SmallGoldbach WideGoldbach PrimeCoverage",
     "set_option maxRecDepth 20000","set_option maxHeartbeats 0",lemmas,
     f"def offsets : List Nat := [{','.join(map(str,ss))}]",
     f"private def P (s : Nat) := Nat.Prime ({base}+2*s)",
     "private theorem extend {s : Nat} {ss : List Nat} (hs : P s) (ht : âˆ€ u âˆˆ ss, P u) : âˆ€ u âˆˆ s::ss, P u := by",
     "  intro u hu","  rcases List.mem_cons.mp hu with rfl | h","  Â· exact hs","  Â· exact ht _ h",
     "private theorem anchors : âˆ€ u âˆˆ offsets, P u := by","  unfold offsets"]
for s,p in zip(ss,roots,strict=True): out.append(f"  apply extend (s := {s}) Pratt14.p{p}")
out+=["  simp",f"theorem interval : Covered {lo} {hi} := by",
      f"  have ht := tile (a := {base}) (skip := {H}) (width := {W}) SampleWindow.source anchors (by decide +kernel)",
      f"  exact binaryGoldbach_interval {lo} {W} (by decide) ht","#print axioms interval","end Pratt14Cover"]
(HERE/"Pratt14Cover.lean").write_text("\n".join(out)+"\n",encoding="utf8")
(HERE/"producer.json").write_text(json.dumps(dict(lo=lo,hi=hi,evens=W,roots=roots,nodes=len(cert),
    coverage_cpu=cov,total_cpu=process_time()-start),indent=2))
for name in ("SampleBits","FastHex"):
    src=TEAM/"finite-interval-sample"/(name+".olean")
    if not (HERE/src.name).exists(): os.link(src,HERE/src.name)
subprocess.run([sys.executable,str(HERE/"shard.py")],check=True)
