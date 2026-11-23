"""Integer-only conductor/grid/circuit inventory; no characters or L-values evaluated."""
from pathlib import Path
import json
from fractions import Fraction as F
from math import factorial

LIMIT=400000
spf=list(range(LIMIT+1))
for p in range(2,LIMIT+1):
    if spf[p]==p:
        for k in range(p*p,LIMIT+1,p):
            if spf[k]==k: spf[k]=p

def factors(c):
    out=[]
    while c>1:
        p=spf[c];k=0
        while c%p==0: c//=p;k+=1
        out.append((p,k))
    return out

def data(c):
    v=n=real=1;dims=[]
    for p,k in factors(c):
        v*=(p-1)*p**(k-1)
        n*=p-2 if k==1 else (p-1)**2*p**(k-2)
        if p==2:
            real*=1 if k==2 else 2 if k==3 else 0
            if k==2:dims.append(2)
            elif k>=3:dims.extend([2,2**(k-2)])
        else:
            real*=int(k==1);dims.append((p-1)*p**(k-1))
    assert n>0
    prod=1
    for d in dims:prod*=d
    assert prod==v and (n-real)%2==0
    bf=pm=0;kernel=set()
    for d in dims:
        lines=v//d
        if d&(d-1)==0:
            bf+=lines*(d//2)*(d.bit_length()-1)
        else:
            length=1<<(2*d-2).bit_length()
            # Two transforms per input; chirp transform cached by axis length.
            bf+=lines*length*(length.bit_length()-1)
            pm+=lines*(length+2*d)
            kernel.add(d)
    return dict(v=v,n=n,real=real,dims=dims,butterflies=bf,point_products=pm,kernels=kernel)

def height(c):
    if c%2 or c<=125000:return 100000000,c
    return 200*c+75000000,c
def samples(c):
    a,b=height(c)
    return (64*a+5*b-1)//(5*b)+1
def allowed(c,profile):
    return (c%2 and c<=(150000 if profile=='reduced' else 300000)) or (c%4==0 and c<=(300000 if profile=='reduced' else 400000))

ranges=[(3,10000),(10001,50000),(50001,100000),(100001,150000),(150001,300000),(300001,400000)]
records={}
for profile in ('reduced','declared'):
    rows=[]
    for low,high in ranges:
        a=dict(range=[low,high],conductors=0,primitive_labels=0,real_primitive_labels=0,
               unit_coefficients=0,positive_grid_outputs=0,residue_grid_inputs=0,
               character_transform_butterflies=0,character_transform_point_products=0,
               direct_character_dot_products=0,alpha_length16_contributions=0,
               max_grid_samples=0,naive_independent_EM_head_terms=0)
        for c in range(low,high+1):
            if not allowed(c,profile):continue
            d=data(c);j=samples(c);num,den=height(c)
            em_n=(num+den-1)//den+40
            a['conductors']+=1;a['primitive_labels']+=d['n'];a['real_primitive_labels']+=d['real']
            a['unit_coefficients']+=d['v'];a['positive_grid_outputs']+=d['n']*j
            a['residue_grid_inputs']+=d['v']*j
            a['character_transform_butterflies']+=d['butterflies']*j
            a['character_transform_point_products']+=d['point_products']*j
            a['direct_character_dot_products']+=d['n']*d['v']*j
            a['alpha_length16_contributions']+=16*d['v']*j
            a['max_grid_samples']=max(a['max_grid_samples'],j)
            a['naive_independent_EM_head_terms']+=d['v']*j*em_n
        rows.append(a)
    totals={key:sum(r[key] for r in rows) for key in rows[0] if key not in ('range','max_grid_samples')}
    large=rows[1:]
    large_totals={key:sum(r[key] for r in large) for key in totals}
    large_totals['shared_height_nodes']=max(r['max_grid_samples'] for r in large)
    large_totals['length16_D2048_lattice_slots_over_all_heights']=large_totals['shared_height_nodes']*2049*16
    records[profile]=dict(regimes=rows,totals=totals,large_conductor_schedule=large_totals)

assert records['reduced']['totals']['conductors']==149999
assert records['reduced']['totals']['primitive_labels']==5543640187
assert records['declared']['totals']['primitive_labels']==18068152605

cohorts=[]
for t in (0,450,500,1000,2000,5000,10000):
    cs=[c for c in range(10001,300001) if allowed(c,'reduced') and height(c)[0]>=t*height(c)[1]]
    cohorts.append(dict(height=t,conductors=len(cs),unit_coefficients=sum(data(c)['v'] for c in cs),
                        primitive_labels=sum(data(c)['n'] for c in cs)))
examples={str(c):{k:sorted(v) if isinstance(v,set) else v for k,v in data(c).items()} for c in (5,8,10007,65536,100003,131072,150000,262144,300000)}
max_index=records['reduced']['large_conductor_schedule']['shared_height_nodes']-1
prev=-1;alpha_bands=[]
for V,D in ((500,512),(1000,1024),(2000,2048),(5000,4096),(10000,8192)):
    last=min(max_index,64*V//5);count=max(0,last-prev)
    assert F(V+24,2*D)<F(2,3)
    alpha_bands.append(dict(upper_height=V,D=D,length=24,time_nodes=count,lattice_slots=count*(D+1)*24))
    prev=last
assert sum(r['time_nodes'] for r in alpha_bands)==max_index+1
assert factorial(24)>2**79 and F(2,3)**24<F(1,2**14) and 2*633<2**11
assert F(2*633)*F(2,3)**24/factorial(24)<F(1,2**82)

def ratio_box(a,b,den=10**6):
    return [str(F(a*den//b,den)),str(F((a*den+b-1)//b,den))]
ra=records['reduced']['large_conductor_schedule'];de=records['declared']['large_conductor_schedule']
ratios={k:ratio_box(ra[k],de[k]) for k in ('primitive_labels','positive_grid_outputs','residue_grid_inputs','character_transform_butterflies','character_transform_point_products','naive_independent_EM_head_terms')}
ratios['independent_EM_head_to_alpha24_terms']=ratio_box(ra['naive_independent_EM_head_terms'],24*ra['residue_grid_inputs'])
ratios['direct_character_terms_to_butterflies']=ratio_box(ra['direct_character_dot_products'],ra['character_transform_butterflies'])
out=dict(status='PASS_INTEGER_SCHEDULE_INVENTORY',scope='Specified nominal positive grid/circuit and isolated alpha-tail scalar bound; no auxiliary heights, signs, complete accuracy, runtimes or spectral assertions.',
         grid_step='5/64',samples='ceil(64 H(c)/5)+1',alpha_length=16,alpha_cells=2048,
         common_switch=10000,profiles=records,large_reduced_height_cohorts=cohorts,examples=examples,
         large_ratio_boxes=ratios,adaptive_alpha_lattice_bands=alpha_bands,
         adaptive_alpha_lattice_total_slots=sum(r['lattice_slots'] for r in alpha_bands),
         ordinary_refinement_bookkeeping=dict(factor=8,coarse_output_slots=ra['positive_grid_outputs'],
             refined_union_slots=8*ra['positive_grid_outputs']-7*ra['primitive_labels'],
             new_interpolated_slots=7*(ra['positive_grid_outputs']-ra['primitive_labels']),
             scope='If every consecutive nominal coarse interval receives seven new nodes; not new character FFT outputs, no guard or auxiliary nodes.'),
         alpha_tail_only='For sigma=1/2, |t|<=V, M=1, nearest cell, P24 and listed D, character-summed interpolation tail<2^-82 for c<=400000. Seed and arithmetic errors separate.',
         exclusions='Conductor1 and c=2mod4; all costs omit root phases, lattice generation, elementary leaves, interpolation, repairs and completeness unless separately specified.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf8',newline='\n')
print(json.dumps(dict(totals={k:v['totals'] for k,v in records.items()},large={k:v['large_conductor_schedule'] for k,v in records.items()},cohorts=cohorts),indent=2))
