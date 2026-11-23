"""Compare per-row and grouped factorial certificates for 256 neighboring rows."""
from math import factorial, prod
from pathlib import Path
from statistics import median
from time import process_time
import json
import sys
from flint import fmpz

here=Path(__file__).resolve().parent
small=here.parent/'small-prefix'
sys.path.insert(0,str(small))
from generate import primes_through, odd_sieve, bitmap, pack, cover_tail
from split_power import packed_literals
start=612_345_678_900
width=1<<19
count=256
halo=4096
cutoff=1_000_000
def bound(r):
    return start+2*width*r
def write(name,lines):
    (here/(name+'.lean')).write_text(packed_literals('\n'.join(lines)+'\n'),encoding='utf-8')
def join(xs):
    if len(xs)==1: return xs[0]
    m=len(xs)//2
    return '(SmallGoldbach.join '+join(xs[:m])+' '+join(xs[m:])+')'
initial=process_time()
primes=primes_through(cutoff)
flags=odd_sieve(3,width+halo,primes)
bits,rev=bitmap(flags),bitmap(flags[::-1])
fac=fmpz.fac_ui(cutoff) if hasattr(fmpz,'fac_ui') else fmpz(factorial(cutoff))
setup=process_time()-initial
rows=[]
mods=[]
mask=(1<<width)-1
cache=[]
moduli=[bound(k)-3-2*halo for k in range(count)]
sieve_cost={}
tic=process_time()
for base in moduli:
    cache.append(odd_sieve(base,halo+1,primes))
sieve_cost['full']=process_time()-tic
for cutoff_small in (257,4093):
    few=[q for q in primes if q<=cutoff_small]
    tic=process_time()
    for base,expected in zip(moduli,cache):
        filtered=odd_sieve(base,halo+1,few)
        for s,keep in enumerate(filtered):
            if keep and not fmpz(base+2*s).is_prime():
                filtered[s]=0
        assert filtered==expected
    sieve_cost[str(cutoff_small)]=process_time()-tic
start_cover=process_time()
for k in range(count):
    base=moduli[k]
    available=cache[k]
    left=mask
    offsets=[]
    for s,v in enumerate(available):
        if v:
            delta=(bits>>(halo-s))&left
            if delta:
                offsets.append(s)
                left^=delta
                if not left: break
                if len(offsets)%4==0 and left.bit_count()<=192:
                    offsets+=cover_tail(left,available,rev,len(flags),halo,True)
                    break
    covered=0
    for s in offsets: covered|=bits>>(halo-s)
    assert covered&mask==mask
    rows.append((len(offsets),pack(offsets)))
    mods.append(fmpz(prod(base+2*s for s in offsets)))
selection=process_time()-start_cover

# Alternate group order to reduce dependence on warmup.
timings={s:[] for s in [1,4,8,16,32]}
allw={}
for order in ([1,4,8,16,32],[32,16,8,4,1],[8,1,32,4,16]):
    for group in order:
        tic=process_time()
        xs=[]
        for k in range(0,count,group):
            modulus=prod(mods[k:k+group],start=fmpz(1))
            xs.append(pow(fac,-1,modulus))
        timings[group].append(process_time()-tic)
        allw[group]=xs
for group,zs in allw.items():
    assert all(zs[k//group]%mod==allw[1][k] for k,mod in enumerate(mods))

# Keep every Lean row identical in every variant, down to the old inverse field.
# The grouped verifier reads one group inverse and ignores the per-row field.
lines=['import FastHex','import PrefixFactorial','namespace BandRows','open SmallGoldbach',
       'set_option maxRecDepth 20000']
for n in range(0,count,4):
    lits=[f'⟨{width},{rows[i][0]},{hex(rows[i][1])},{hex(int(allw[1][i]))}⟩' for i in range(n,n+4)]
    lines+=[f'def part{n//4} : List Row := ['+',\n'.join(lits)+']']
for group in [4,8,16,32]:
    for j,z in enumerate(allw[group]):
        lines.append(f'def witness{group}_{j} : Nat := {hex(int(z))}')
write('BandRows',lines+['end BandRows'])

for group in [1,4,8,16,32]:
    name='BandBaseline' if group==1 else f'BandGroup{group}'
    leaf=8 if group==1 else group
    lines=['import BandRows','import BatchWitness','import SampleBits','import BandMillionFactorial',
           'namespace '+name,'open SmallGoldbach', 'set_option maxHeartbeats 0','set_option maxRecDepth 20000']
    for k in range(0,count,leaf):
        data='('+' ++ '.join(f'BandRows.part{j}' for j in range(k//4,(k+leaf)//4))+')'
        lines += [f'theorem piece{k} : Covered {bound(k)} {bound(k+leaf)} :=']
        if group==1:
            lines += [f'  checked_interval (halo := {halo}) SampleWindow.source BandMillionFactorial.fac_eq {data}',
                      '    (by decide) (by decide) (by decide +kernel) (by decide +kernel)']
        else:
            lines += [f'  BatchWitness.interval (halo := {halo}) SampleWindow.source BandMillionFactorial.fac_eq {data} BandRows.witness{group}_{k//group}',
                      '    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)']
    lines+= [f'theorem covered : Covered {bound(0)} {bound(count)} :=',
             '  '+join([f'piece{k}' for k in range(0,count,leaf)]), '#print axioms covered', 'end '+name]
    write(name,lines)
stats=dict(lo=bound(0),hi=bound(count),width=width,rows=count,evens=count*width,cutoff=cutoff,
           flint_version=__import__('flint').__version__,shared_setup_cpu=setup,selection_after_sieve_cpu=selection,
           candidate_sieve_cpu=sieve_cost,
           total_anchors=sum(a for a,_ in rows),inverse_cpu_trials=timings,
           inverse_cpu_median={s:median(v) for s,v in timings.items()})
(here/'producer.json').write_text(json.dumps(stats,indent=2)+'\n')
