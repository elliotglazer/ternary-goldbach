import csv
import json
import sys
from collections import Counter
from pathlib import Path
from time import perf_counter
here=Path(__file__).resolve().parent
p20=here.parent/'c10004-p20-source'
native=here.parent/'c10004-real-transform'
sys.path.insert(0,str(native))
from reference import tensor,ct
def rows(path):
    with path.open() as f:return list(csv.DictReader(f,delimiter='\t'))
def signed_pack(x,w):
    assert -(1<<(w-1))<=x<1<<(w-1)
    return x+(1<<(w-1))
def writefile(name,items):
    (here/name).write_bytes(('\n'.join(items)+'\n').encode('ascii'))
start=perf_counter()
coeff=json.loads((p20/'h1-mixed.json').read_bytes())
order=list(range(19,-1,-1))
grids=[94,94,94,94,91,89,89,89,83,81,81,81,75,73,73,73,65,65,65,65]
assert sorted(map(int,coeff))==list(range(1025))
width={j:max(abs(int(x)).bit_length() for cs in coeff.values() for x in cs[j])+1 for j in order}
blocks=[]
for k in range(1025):
    cs=coeff[str(k)]
    assert len(cs)==20
    z=0
    for j in reversed(order):
        w=width[j]
        x,y=map(int,cs[j])
        z=(z<<(2*w))+(signed_pack(y,w)<<w)+signed_pack(x,w)
    blocks.append(str(z))
writefile('coeffs.txt',blocks)
heads=rows(p20/'h1-rawhead.tsv')
fullref=rows(here.parent/'c10004-assembled-input/h1-heads.tsv')
direct=rows(here.parent/'c10004-reference/h1.tsv')
horner=json.loads((p20/'h1-horner.json').read_bytes())
ys=[]
head_blocks=[]
diff_arb=Counter()
diff_direct=Counter()
for idx,(h,ref,dr,shift) in enumerate(zip(heads,fullref,direct,horner,strict=True)):
    a=(2501*(1+2*(idx%2))+4880*pow(6,idx//2%40,41)+2624*pow(2,idx//80,61))%10004
    k=(2048*a+10003)//20008
    assert int(h['index'])==idx and int(h['a'])==a and (idx,a,k)==tuple(shift[:3])
    cs=coeff[str(k)]
    x,y=map(int,cs[19])
    r=1024*a-10004*k
    for j in order[1:]:
        d=1<<(grids[j]-grids[j+1])
        x=(r*x*d+10004)//20008+int(cs[j][0])
        y=(r*y*d+10004)//20008+int(cs[j][1])
    assert (x,y)==tuple(shift[3:])
    re,im=int(h['re']),int(h['im'])
    u,v=(re+64*x+(1<<18))//(1<<19),(im+64*y+(1<<18))//(1<<19)
    ys.append((u,v))
    diff_arb[max(abs(u-int(ref['assembled_re81'])),abs(v-int(ref['assembled_im81'])))]+=1
    diff_direct[max(abs(u-int(dr['re'])),abs(v-int(dr['im'])))]+=1
    if idx%16==0: z=0
    z|=(signed_pack(re,112)+(signed_pack(im,112)<<112))<<(224*(idx%16))
    if idx%16==15: head_blocks.append(str(z))
assert len(ys)==4800 and len(head_blocks)==300
writefile('heads.txt',head_blocks)
writefile('assembled.tsv',(f'{u}\t{v}' for u,v in ys))
spec=tensor(ys,lambda row:ct(row,True,Counter()))
original=rows(native/'h1-spectrum.tsv')
assembled=rows(here.parent/'c10004-assembled-input/h1-spectrum.tsv')
max_e=0
deltas=Counter()
for (u,v),orig,old in zip(spec,original,assembled,strict=True):
    max_e=max(max_e,int(orig['abs_error_grid_units'])+abs(u-int(orig['re']))+abs(v-int(orig['im'])))
    deltas[max(abs(u-int(old['re'])),abs(v-int(old['im'])))]+=1
writefile('spectrum.tsv',(f'{u}\t{v}' for u,v in spec))
params=(here.parent/'c10004-hol-shared-phase/h1-params.tsv').read_text().split()
raw_reference=rows(p20/'h1-rawspectrum.tsv')
assert all(y==(int(r['re']),int(r['im'])) for y,r in zip(spec,raw_reference,strict=True))
max_e=max(max_e,max(int(r['abs_error_grid_units']) for r in raw_reference))
assert all((1 if (int(params[-1])>>j)&1 else -1)==int(r['sign']) for j,r in enumerate(raw_reference))
params[-2]=str(max_e)
writefile('params.tsv',['\t'.join(params)])
bases=[1<<width[j] for j in order]
mult=[1<<(grids[j]-grids[j+1]) for j in order[1:]]
base_list=';'.join('(%s,%s)'%(b,m) for b,m in zip(bases[1:],mult))
defs=f"""Definition full_coeff_def:
  full_coeff z =
   (full_pair {bases[0]} z,
    full_stages [{base_list}] (z DIV {bases[0]**2}))
End
"""
(here/'coeff_definition.txt').write_text(defs)
print(json.dumps(dict(width_desc=[width[j] for j in order],radii=max_e,source_vs_direct=diff_direct,
    source_vs_direct_heads=diff_arb,spectrum_vs_direct_heads=deltas,source_spec_seconds=perf_counter()-start),indent=2))

for filename,zs in [('expected_sources.txt',ys),('expected_spectrum.txt',spec)]:
    payload=[]
    for j in range(0,len(zs),16):
        z=0
        for offset,(u,v) in enumerate(zs[j:j+16]):
            for d,x in enumerate([u,v]):
                assert -(1<<95)<=x<(1<<95)
                z|=(x%(1<<96))<<(96*(offset*2+d))
        payload.append(str(z))
    writefile(filename,payload)
prod=rows(p20/'h1-rawassembled.tsv')
assert all(y==(int(r['re']),int(r['im'])) for y,r in zip(ys,prod,strict=True))