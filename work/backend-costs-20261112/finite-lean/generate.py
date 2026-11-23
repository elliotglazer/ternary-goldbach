"""Generate complete finite Goldbach block certificates; proposed primes are untrusted."""
import hashlib
import json
import math
import sys
import time
from pathlib import Path
from flint import fmpz

H=Path(__file__).resolve().parent
SOURCE=H.parents[1]/'formal-goldbach-bench/prime-cover/lean_fixtures.json'
width=int(sys.argv[1])
f=next(f for f in json.loads(SOURCE.read_text()) if f['width']==width)
namespace=f'FiniteP0N{width}'
data=f'FiniteData{width}'
bits=int(f['source_hex'],16)
indices=[j for j in range(f['source_bit_length']) if (bits>>j)&1]
source_primes=[f['source_first_odd']+2*j for j in indices]
assert all(fmpz(p).is_prime() for p in source_primes+f['anchors'])
assert len(f['anchors'])==len(f['shifts'])
assert all(f['source_first_odd']+2*s+q==f['target_origin'] for s,q in zip(f['shifts'],f['anchors']))
roots=sorted(set(source_primes+f['anchors']))
nodes={2:dict(prime=2,factors=[],base=None)}
def make(p):
    if p in nodes:return
    factors=[(int(q),int(e)) for q,e in fmpz(p-1).factor()]
    assert math.prod(q**e for q,e in factors)==p-1
    for q,e in factors:make(q)
    a=2
    while not (pow(a,p-1,p)==1 and all(pow(a,(p-1)//q,p)!=1 for q,e in factors)):
        a+=1
    nodes[p]=dict(prime=p,factors=factors,base=a)
start_cpu=time.process_time();start=time.perf_counter()
for p in roots:make(p)
producer_cpu=time.process_time()-start_cpu;producer_wall=time.perf_counter()-start
lines=['import PrimeSupport','set_option maxRecDepth 65536','set_option maxHeartbeats 0',f'namespace {namespace}']
for p,c in sorted(nodes.items()):
    if p==2:
        lines.append('theorem prime_2 : Nat.Prime 2 := Nat.prime_two')
        continue
    factors=[q for q,e in c['factors'] for _ in range(e)]
    factor=str(factors[-1])
    for q in reversed(factors[:-1]):factor=f'{q} * ({factor})'
    lines += [f'theorem prime_{p} : Nat.Prime {p} := by',
              f'  apply lucasNat {p} {c["base"]} (by decide) (by decide +kernel)',
              '  intro q hq hd',
              f'  rw [show {p} - 1 = {factor} by decide] at hd',
              '  simp only [Nat.Prime.dvd_mul hq, '+', '.join(f'Nat.prime_dvd_prime_iff_eq hq prime_{q}' for q,e in c['factors'])+'] at hd']
    if len(factors)==1:
        lines += ['  subst q','  decide +kernel']
    else:
        lines += ['  rcases hd with '+' | '.join('h'+str(i) for i in range(len(factors))),
                  '  all_goals subst q; decide +kernel']
lines.append(f'end {namespace}')
(H/f'Primes{width}.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
lines=['import PrimeBitmap',f'namespace {data}',
       f'def first : Nat := {f["source_first_odd"]}',
       f'def target : Nat := {f["target_origin"]}',
       f'def source : Nat := {hex(bits)}',
       f'def shifts : List Nat := {f["shifts"]}',
       f'end {data}']
(H/f'Data{width}.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
def tree(items):
    if len(items)==1:
        j=items[0];p=f['source_first_odd']+2*j
        return f'(2 ^ {j})',f'(PrimeBitmap.singleton {data}.first {j} prime_{p})'
    n=len(items)//2
    a,ap=tree(items[:n]);b,bp=tree(items[n:])
    return f'({a} ||| {b})',f'(PrimeBitmap.union {ap} {bp})'
expr,proof=tree(indices)
lines=[f'import Primes{width}',f'import Data{width}','set_option maxRecDepth 65536',
       'set_option maxHeartbeats 0','open PrimeCoverage',f'namespace {namespace}',
       f'theorem source_primes : PrimeBitmap {data}.first {data}.source := by',
       f'  have h : PrimeBitmap {data}.first {expr} := {proof}',
       f'  have heq : {expr} = {data}.source := by decide +kernel',
       '  rw [heq] at h','  exact h',
       f'theorem anchor_primes : ∀ s ∈ {data}.shifts, ({data}.target - ({data}.first + 2 * s)).Prime ∧ {data}.first + 2 * s ≤ {data}.target := by',
       '  intro s hs',f'  simp only [{data}.shifts, List.mem_cons, List.not_mem_nil, or_false] at hs',
       '  rcases hs with '+' | '.join(f'h{i}' for i in range(len(f['anchors'])))]
for s,q in zip(f['shifts'],f['anchors']):
    lines += ['  · subst s',f'    exact ⟨prime_{q}, by decide⟩']
lines += [f'theorem coverage : (shiftedUnion {data}.source {data}.shifts &&& (2 ^ {width} - 1)) = 2 ^ {width} - 1 := by decide +kernel',
          f'theorem binary_index : ∀ j < {width}, BinaryGoldbach ({data}.target + 2 * j) :=',
          f'  binaryGoldbach_of_bitmap {data}.first {data}.source {data}.target {width} {data}.shifts source_primes anchor_primes coverage',
          f'theorem binary_interval : ∀ n : Nat, {f["target_origin"]} ≤ n → n < {f["target_origin"]+2*width} → n % 2 = 0 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n :=',
          f'  binaryGoldbach_interval {data}.target {width} (by decide) binary_index',f'end {namespace}']
(H/f'Block{width}.lean').write_text('\n'.join(lines)+'\n',encoding='utf-8',newline='\n')
(H/f'Replay{width}.lean').write_text(f'import Block{width}\nimport Replay\nset_option maxRecDepth 65536\nset_option maxHeartbeats 0\n#replay_stage "Finite" 0 {width} 1 [{namespace}.binary_interval]\n',encoding='utf-8',newline='\n')
(H/f'Audit{width}.lean').write_text(f'import Block{width}\n#print {namespace}.binary_interval\n#print axioms {namespace}.binary_interval\n#print axioms PrimeCoverage.binaryGoldbach_of_bitmap\n',encoding='utf-8',newline='\n')
out=dict(width=width,source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
         first=f['source_first_odd'],target=f['target_origin'],end_exclusive=f['target_origin']+2*width,
         source_bits=f['source_bit_length'],source_positive_bits=len(indices),anchors=len(f['anchors']),
         prime_roots=len(roots),prime_nodes=len(nodes),producer_cpu_seconds=producer_cpu,
         producer_wall_seconds=producer_wall,indices=indices,roots=roots,certificates=list(nodes.values()),
         fixture=f)
(H/f'fixture{width}.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:v for k,v in out.items() if k not in ('indices','roots','certificates','fixture')}),flush=True)
