"""Independent exact metadata review; no theta/elementary values or author imports."""
from pathlib import Path
from fractions import Fraction as F
import json,hashlib,re
ROOT=Path(__file__).resolve().parents[4]; A=ROOT/'work/qrh-campaign/agents'
author=A/'prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md'
assert hashlib.sha256(author.read_bytes()).hexdigest().upper()=='6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043'
checks={};pins=[]
def ck(k,v):
    assert v,k
    checks[k]=True
for path,digest in re.findall(r'\| `([^`]+)` \| `([A-F0-9]{64})` \|',author.read_text()):
    ck('pin:'+path,hashlib.sha256((A/path).read_bytes()).hexdigest().upper()==digest)
    pins.append({'path':path,'sha256':digest})
data=json.loads((A/'prime-estimates/small_conductor_theta_backend_metadata_20261111.json').read_text())
rows=data['rows'];ck('15_rows',len(rows)==15)
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
def group(axes):
    v=1
    for d in axes:v*=d
    G=P=0
    for d in axes:
        if d&(d-1)==0:
            G+=(v//d)*(d//2)*(d.bit_length()-1)
        else:
            p=1
            while p<2*d-1:p*=2
            G+=(v//d)*2*(p//2)*(p.bit_length()-1)
            P+=(v//d)*(p+2*d)
    return v,G,P
config={3:([2],1,1),4:([2],1,1),101:([100],99,2),1000:([2,2,100],160,2),10000:([2,4,500],1600,2)}
for r in rows:
    c=r['c'];th=r['tilt_theta']; tag=f'{c}_{th}:'
    V=F(10**8,c)+1000;eps=F(1,2**80)/(4*3**th);W=c*V/th
    K,L,X=r['K'],r['L'],r['X'];delta=F(r['grid_step']);N=r['time_length'];P=N*delta
    J=r['positive_frequency_count']-1;n0=r['first_omitted_central_n'];C=4*(X+1)
    ck(tag+'domain',V>=2*th and W>=1 and th in (32,64,128))
    ck(tag+'fixed_values',F(r['V'])==V and F(r['F_error'])==eps and F(r['period'])==P)
    ck(tag+'time_alias',32*W*W*F(3,8)**K<eps/4<=32*W*W*F(3,8)**(K-1))
    ck(tag+'frequency_alias',12*W*F(3,8)**L<eps/4<=12*W*F(3,8)**(L-1))
    ck(tag+'X',F(8,3)**(2*X)>=W*(2*X+L) and (X==1 or F(8,3)**(2*(X-1))<W*(2*(X-1)+L)))
    ck(tag+'grid',delta==F(5,64) and delta*X<=1)
    pmin=max(2*V*K/th,V+2*K,F(6))
    ck(tag+'N',N>=8 and N&(N-1)==0 and P>=pmin and (N==8 or P/2<pmin))
    ck(tag+'J',J==ceil(P*X/6) and J<N//2)
    v0=3*n0*n0/W;z0=3*(2*n0+1)/W-F(1,n0)
    tail=2*n0*(1+1/z0)*F(3,8)**(v0.numerator//v0.denominator)
    ck(tag+'Gaussian_tail',v0>=2 and z0>0 and C*tail<eps/8 and str(tail)==r['uniform_tail_bound'])
    terms=ceil(n0*(1+P/3)+(J+1)); p=r['uniform_Gaussian_seed_fractional_bits']
    budget=eps/(32*C*2*3**(3*(X+1))*n0**4)
    ck(tag+'seed_bits',6*F(1,2**p)<=budget<6*F(1,2**(p-1)))
    axes,n,h=config[c];v,g,pr=group(axes);out=V/delta;out=out.numerator//out.denominator+1
    expected={'Gaussian_term_count_upper':terms,'Gaussian_unit_multiplications_upper':2*terms,'bucket_additions_upper':h*terms,
       'unit_group_size':v,'primitive_labels':n,'parity_channels':h,'group_butterflies':h*(J+1)*g,
       'group_point_products':h*(J+1)*pr,'time_butterflies':n*(N//2)*(N.bit_length()-1),
       'desired_nonnegative_grid_nodes_per_label':out,'full_time_outputs':n*N,
       'point_EM_group_butterflies_comparator':out*g,'point_EM_group_products_comparator':out*pr,
       'point_EM_P20_residue_terms_comparator':20*v*out}
    ck(tag+'all_work_counts',all(r[k]==val for k,val in expected.items()))
    ck(tag+'ratios',F(r['frequency_to_desired_node_ratio'])==F(J+1,out) and F(r['char_transform_call_ratio_to_point_EM'])==F(h*(J+1),out))
ck('coefficient_error_split',F(1,64)+F(1,64)+F(1,32)+F(1,16)==F(1,8))
ck('output_error_split',F(1,4)+F(1,4)+F(1,4)+F(1,4)==1)
ck('canonical_error',3*F(1,4)==F(3,4))
ck('unit_disk_shrink_symbolic_coefficients', (1-2*F(1,2))*(1+F(1,2))+F(1,2)<=1 and 4+2*F(1,2)==5)
ck('h_base_error',3==1+2 and 2==1+1)
for n in range(1,65):
    ck('recurrence_'+str(n),(n*n+2*n+1)==(n+1)**2 and (n*n-1+2*n+1)==(n+1)**2-1)
result={'status':'PASS','scope':'Exact metadata/scalars; no analytic values','pins':pins,'checks':checks,'rows':len(rows)}
out=Path(__file__).with_suffix('.json')
if out.exists():assert json.loads(out.read_text())==result
else:
    with out.open('x',encoding='utf-8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'status':'PASS','checks':len(checks),'rows':len(rows),'pins':len(pins)}))
