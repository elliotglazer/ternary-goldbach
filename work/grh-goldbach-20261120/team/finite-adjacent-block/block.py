"""Build a contiguous high binary Goldbach block from previously checked shared inputs."""
from hashlib import sha256
from math import factorial, isqrt, prod
from pathlib import Path
from time import process_time
import json
import shutil
import sys

HERE = Path(__file__).resolve().parent
PILOT = HERE.parent/'finite-interval-sample'
SMALL = HERE.parent/'small-prefix'
sys.path.insert(0, str(SMALL))
from generate import primes_through, odd_sieve, bitmap, pack, cover_tail
from split_power import packed_literals

ORIGIN = 99_250_000_000
WIDTH = 1 << 19
COUNT = 256
HALO = 4096
CUTOFF = isqrt(10**11)

def balanced(terms):
    if len(terms)==1:
        return terms[0]
    m = len(terms)//2
    return '(SmallGoldbach.join '+balanced(terms[:m])+' '+balanced(terms[m:])+')'

def interval_at(k):
    return ORIGIN+2*WIDTH*k

def main():
    reused = {}
    modules = ['FastHex','SampleBits',*[f'SampleHighProduct{j}' for j in range(4)],'SampleHigherFactorial']
    for name in modules:
        source=PILOT/(name+'.olean')
        expected=json.loads((PILOT/(name+'.json')).read_text())['olean_sha256']
        assert sha256(source.read_bytes()).hexdigest()==expected
        shutil.copyfile(source,HERE/source.name)
        reused[name]=expected
    begin = process_time()
    primes=primes_through(CUTOFF+1)
    flags=odd_sieve(3,WIDTH+HALO,primes)
    bits,rev=bitmap(flags),bitmap(flags[::-1])
    fac=factorial(CUTOFF)
    setup_time=process_time()-begin
    start=process_time()
    mask=(1<<WIDTH)-1
    rows=[]
    counts=[]
    for j in range(COUNT):
        base=interval_at(j)-3-2*HALO
        available=odd_sieve(base,HALO+1,primes)
        left=mask
        offsets=[]
        for s,valid in enumerate(available):
            if valid:
                covered=(bits>>(HALO-s)) & left
                if covered:
                    offsets.append(s)
                    left ^= covered
                    if not left:
                        break
                    if len(offsets)%4==0 and left.bit_count()<=192:
                        offsets+=cover_tail(left,available,rev,len(flags),HALO,True)
                        break
        tested=0
        for s in offsets:
            tested |= bits>>(HALO-s)
        assert tested & mask == mask
        modulus=prod(base+2*s for s in offsets)
        inverse=pow(fac,-1,modulus)
        assert fac*inverse%modulus==1
        rows.append(f'⟨{WIDTH}, {len(offsets)}, {hex(pack(offsets))}, {hex(inverse)}⟩')
        counts.append(len(offsets))
    elapsed=process_time()-start
    def write(name,lines):
        (HERE/(name+'.lean')).write_text(packed_literals('\n'.join(lines)+'\n'),encoding='utf-8')
    # Each row is stored exactly once. The alternate covering references identical row data.
    chunksize=8
    lines=['import SampleHigherFactorial','namespace AdjacentData','open SmallGoldbach',
           'set_option maxRecDepth 20000']
    for k in range(0,COUNT,chunksize):
        lines+=['def rows'+str(k//chunksize)+' : List Row := ['+',\n'.join(rows[k:k+chunksize])+']']
    write('AdjacentData',lines+['end AdjacentData'])
    def checked(name,k,size):
        refs=[f'AdjacentData.rows{i}' for i in range(k//chunksize,(k+size)//chunksize)]
        return [f'theorem {name} : Covered {interval_at(k)} {interval_at(k+size)} :=',
                f'  checked_interval (halo := {HALO}) SampleWindow.source SampleHigherFactorial.fac_eq',
                '    ('+' ++ '.join(refs)+') (by decide) (by decide) (by decide +kernel) (by decide +kernel)']
    names=[]
    for k in range(0,COUNT,64):
        name=f'AdjacentShard{k//64}'
        names.append(name)
        lines=['import AdjacentData','namespace '+name,'open SmallGoldbach','set_option maxHeartbeats 0','set_option maxRecDepth 20000']
        for u in range(k,k+64,chunksize):
            lines+=checked(f'piece{u//chunksize}',u,chunksize)
        lines += [f'theorem covered : Covered {interval_at(k)} {interval_at(k+64)} :=',
                  '  '+balanced([f'piece{i//chunksize}' for i in range(k,k+64,chunksize)]),
                  'end '+name]
        write(name,lines)
    write('AdjacentJoined',['import '+n for n in names]+['open SmallGoldbach',
      f'theorem adjacent_block : Covered {interval_at(0)} {interval_at(COUNT)} :=',
      '  '+balanced([n+'.covered' for n in names]),'#print axioms adjacent_block'])
    # Compare two kernel reductions on the same first 64 rows and module startup conditions.
    name='AdjacentSingle64'
    write(name,['import AdjacentData','namespace '+name,'open SmallGoldbach','set_option maxHeartbeats 0',
      'set_option maxRecDepth 20000']+checked('covered',0,64)+['#print axioms covered','end '+name])
    write('AdjacentImportOnly',['import AdjacentData','example : True := True.intro'])
    (HERE/'production.json').write_text(json.dumps(dict(lo=interval_at(0),hi=interval_at(COUNT),even_count=WIDTH*COUNT,
        halo=HALO,cutoff=CUTOFF,width=WIDTH,rows=COUNT,anchors=sum(counts),min_anchors=min(counts),
        max_anchors=max(counts),source_setup_cpu=setup_time,row_generator_cpu=elapsed,
        data_source_bytes=(HERE/'AdjacentData.lean').stat().st_size,shared_oleans=reused),indent=2)+'\n')

if __name__=='__main__':
    main()
