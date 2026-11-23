"""Independent integer conductor/grid inventory; no characters, values or zeros."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial,prod
import json,hashlib

limit=400000
phi=list(range(limit+1)); smallest=[0]*(limit+1)
for p in range(2,limit+1):
    if smallest[p]:continue
    for n in range(p,limit+1,p):
        phi[n]-=phi[n]//p
        if not smallest[n]:smallest[n]=p
phi[1]=1
# Primitive labels obtained by divisor subtraction, independently of the
# author's local multiplicative formula.
primitive=phi.copy()
for d in range(1,limit+1):
    for n in range(d+d,limit+1,d):primitive[n]-=primitive[d]

def description(c):
    n=c;axes=[];real=1
    while n>1:
        p=smallest[n];power=1;e=0
        while n%p==0:n//=p;power*=p;e+=1
        if p==2:
            if e==2:axes.append(2)
            else:axes.extend([2,power//4])
            real*=1 if e==2 else 2 if e==3 else 0
        else:
            axes.append(power-power//p);real*=int(e==1)
    assert prod(axes)==phi[c]
    b=x=0
    for axis in axes:
        copies=phi[c]//axis
        if axis & (axis-1)==0:b+=copies*(axis//2)*(axis.bit_length()-1)
        else:
            length=1
            while length<2*axis-1:length*=2
            b+=copies*length*(length.bit_length()-1)
            x+=copies*(length+2*axis)
    return axes,real,b,x
def height_num(c):return max(100000000,200*c+75000000) if c%4==0 else 100000000
def empty():return dict(conductors=0,primitive=0,real=0,units=0,nodes=0,residues=0,butterflies=0,products=0,direct_terms=0,naive_head=0,max_nodes=0)
out={}
cohorts={t:empty() for t in (0,450,500,1000,2000,5000,10000)}
for domain,oddmax,evenmax in [('reduced',150000,300000),('declared',300000,400000)]:
    total=empty();large=empty();small=empty()
    for c in range(3,evenmax+1):
        if not ((c%2==1 and c<=oddmax) or c%4==0):continue
        assert primitive[c]>0
        axes,real,butterflies,products=description(c)
        num=height_num(c);J=(64*num+5*c-1)//(5*c)+1
        contribution=dict(conductors=1,primitive=primitive[c],real=real,units=phi[c],nodes=primitive[c]*J,
            residues=phi[c]*J,butterflies=butterflies*J,products=products*J,
            direct_terms=primitive[c]*phi[c]*J,naive_head=phi[c]*J*((num+c-1)//c+40))
        for target in (total,large if c>10000 else small):
            for k,v in contribution.items():target[k]+=v
            target['max_nodes']=max(target['max_nodes'],J)
        if domain=='reduced' and c>10000:
            for t,row in cohorts.items():
                if num>=t*c:
                    for key in ('conductors','primitive','real','units'):row[key]+=contribution[key]
    out[domain]={'total':total,'large':large,'small':small}
base=Path(__file__).resolve().parents[1]
source=base/'zero-sum/nonprincipal_platt_schedule_metadata_20261111.json'
author=json.loads(source.read_text())
mapping={'conductors':'conductors','primitive':'primitive_labels','real':'real_primitive_labels','units':'unit_coefficients',
    'nodes':'positive_grid_outputs','residues':'residue_grid_inputs','butterflies':'character_transform_butterflies',
    'products':'character_transform_point_products','direct_terms':'direct_character_dot_products',
    'naive_head':'naive_independent_EM_head_terms'}
comparisons=0
for domain in ('reduced','declared'):
    for ours,theirs in [('total','totals'),('large','large_conductor_schedule')]:
        for k,v in mapping.items():
            assert out[domain][ours][k]==author['profiles'][domain][theirs][v]
            comparisons+=1
for row in author['large_reduced_height_cohorts']:
    ours=cohorts[row['height']]
    for k,v in [('conductors','conductors'),('primitive','primitive_labels'),('units','unit_coefficients')]:
        assert ours[k]==row[v];comparisons+=1
nodes=out['reduced']['large']['max_nodes'];index=0;seed=0
for V,D in [(500,512),(1000,1024),(2000,2048),(5000,4096),(10000,8192)]:
    end=min(nodes-1,64*V//5)
    count=max(0,end-index+1);seed+=count*(D+1)*24;index=end+1
    assert F(V+24,2*D)<F(2,3)
assert seed==author['adaptive_alpha_lattice_total_slots']==17223585528
assert F(1266)*F(2,3)**24/factorial(24)<F(1,2**82)
large=out['reduced']['large']
assert 8*large['nodes']-7*large['primitive']==author['ordinary_refinement_bookkeeping']['refined_union_slots']
out.update(scope='integer metadata and isolated scalar tail only; no function/character/zero evaluation',
    matched_author_fields=comparisons,alpha24_seed_slots=seed,source_metadata_sha256=hashlib.sha256(source.read_bytes()).hexdigest().upper())
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS_INDEPENDENT_METADATA','matched_fields':comparisons,'alpha24_seed_slots':seed}))
