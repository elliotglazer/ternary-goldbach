"""Generate the five fixed sample intervals with the existing PrefixJoin predicate."""
from pathlib import Path
from math import factorial, isqrt, prod
from time import process_time
import json
import sys

HERE = Path(__file__).resolve().parent
SMALL = HERE.parent / 'small-prefix'
sys.path.insert(0, str(SMALL))
from generate import primes_through, odd_sieve, bitmap, pack, cover_tail, lean_list
from split_power import packed_literals

WIDTH = 1 << 19
HALO = 4096
STARTS = [10**10 - 2*WIDTH, 97_000_000_000, 98_000_000_000, 99_000_000_000, 10**11 - 2*WIDTH]

def main():
    stats = {}
    start = process_time()
    primes = primes_through(isqrt(10**11+2*HALO+4))
    flags = odd_sieve(3, WIDTH+HALO, primes)
    bits = bitmap(flags)
    rev = bitmap(flags[::-1])
    segs = []
    i = 0
    while i < len(flags):
        first = 3+2*i
        end = min(i+512, len(flags), ((first*first-1)-3)//2+1)
        offsets = [j-i for j in range(i,end) if flags[j]]
        if offsets:
            segs.append(f'⟨{i}, {isqrt(3+2*(end-1))}, {len(offsets)}, {hex(pack(offsets))}⟩')
        i = end
    lines = ['import PrefixFactorial', 'import FastHex', 'namespace SampleWindow', 'open PrimeCoverage SmallGoldbach', 'set_option maxRecDepth 20000', 'set_option maxHeartbeats 0']
    lean_list('segments','Segment',segs,lines)
    source_parts = [line.split()[1] for line in lines if line.startswith('def segmentsPart')]
    assert source_parts
    for part in source_parts:
        lines.append(f'theorem {part}_ok : {part}.all segmentOK = true := by decide +kernel')
    lines += ['theorem segments_ok : segments.all segmentOK = true := by',
              '  simp [segments, List.all_append, '+', '.join(p+'_ok' for p in source_parts)+']',
              f'def bits : Nat := {hex(bits)}', 'theorem source : PrimeBitmap 3 bits := by',
              '  have h : sourceBits segments = bits := by decide +kernel',
              '  exact h ▸ source_sound segments segments_ok','end SampleWindow']
    (HERE/'SampleBits.lean').write_text(packed_literals('\n'.join(lines)+'\n'),encoding='utf-8')
    stats['source_setup_cpu_s'] = process_time()-start
    for level, starts, cutoff in [('Lower',STARTS[:1],100000),('Higher',STARTS[1:],isqrt(10**11))]:
        t = process_time()
        fac = factorial(cutoff)
        name = 'Sample'+level+'Factorial'
        common = ['import SampleBits','namespace '+name,'open SmallGoldbach','set_option maxRecDepth 20000','set_option maxHeartbeats 0',f'def fac : Nat := {hex(fac)}', f'theorem fac_eq : fac = Nat.factorial {cutoff} := factorial_of_product {(cutoff//32).bit_length()} (by decide +kernel)', 'end '+name]
        (HERE/(name+'.lean')).write_text(packed_literals('\n'.join(common)+'\n'),encoding='utf-8')
        stats[level+'_factorial_setup_cpu_s'] = process_time()-t
        for parts in (1,4):
            filename=f'Sample{level}Parts{parts}'
            lines=['import '+name, 'namespace '+filename,'open SmallGoldbach PrimeCoverage','set_option maxRecDepth 20000','set_option maxHeartbeats 0']
            report=[]
            for index,lo in enumerate(starts):
                t=process_time()
                rows=[]
                counts=[]
                check_counts=[]
                w=WIDTH//parts
                for k in range(parts):
                    org=lo+2*k*w
                    first=org-3-2*HALO
                    avail=odd_sieve(first,HALO+1,primes)
                    mask=(1<<w)-1
                    left=mask
                    offsets=[]
                    for s,v in enumerate(avail):
                        if v:
                            delta=(bits>>(HALO-s)) & left
                            if delta:
                                left ^= delta
                                offsets.append(s)
                                if not left:
                                    break
                                if len(offsets)%4==0 and left.bit_count()<=192:
                                    offsets.extend(cover_tail(left,avail,rev,len(flags),HALO,True))
                                    break
                    # Independently check the producer's returned set, including the optimized tail.
                    covered=0
                    for s in offsets:
                        covered |= bits>>(HALO-s)
                    check_counts.append((covered&mask).bit_count())
                    assert check_counts[-1]==w
                    roots=[first+2*s for s in offsets]
                    modulus=prod(roots)
                    inverse=pow(fac,-1,modulus)
                    assert (fac*inverse)%modulus==1
                    rows.append(f'⟨{w}, {len(offsets)}, {hex(pack(offsets))}, {hex(inverse)}⟩')
                    counts.append(len(offsets))
                hi=lo+2*WIDTH
                lines += [f'def rows{index} : List Row := ['+',\n'.join(rows)+']',f'theorem interval{index} : Covered {lo} {hi} :=',f'  checked_interval (halo := {HALO}) SampleWindow.source {name}.fac_eq rows{index}', '    (by decide) (by decide) (by decide +kernel) (by decide +kernel)',f'#print axioms interval{index}']
                report.append(dict(lo=lo,hi=hi,parts=parts,anchors=counts,verified_even_counts=check_counts,producer_cpu_s=process_time()-t))
            lines.append('end '+filename)
            target=HERE/(filename+'.lean')
            target.write_text(packed_literals('\n'.join(lines)+'\n'),encoding='utf-8')
            stats[filename]=dict(intervals=report,source_bytes=target.stat().st_size)
    (HERE/'generator.json').write_text(json.dumps(stats,indent=2)+'\n',encoding='utf-8')

if __name__=='__main__':
    main()
