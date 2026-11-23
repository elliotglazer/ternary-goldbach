"""Independent exact full-family metadata and universal-bound checks only."""
from pathlib import Path
from fractions import Fraction as F
from functools import lru_cache
from collections import Counter
import json, hashlib

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents'
source=BASE/'prime-estimates/small_family_theta_inventory_final_20261111.json'
EXPECTED='26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69'
checks=0
def ck(b):
 global checks
 checks+=1
 assert b,checks
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
ck(sha(source)==EXPECTED)
data=json.loads(source.read_text())
for p,h in data['pins'].items():ck(sha(Path(p))==h)
packet_pins={
 'WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md':'74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE',
 'small_family_theta_inventory_20261111.py':'4FD7D0F84E3057F74B7F151ABEA73A392739CEA48B12B0B04F1A3F71913A98C2',
 'small_family_theta_choice_20261111.py':'9BA5645C165FD51CBFADCF867B1A877F821F894624C51BD4A6DFA99051947794',
 'small_family_theta_choice_final_20261111.json':'FB20993DD8C1186E06B4B22D07DBC40CDCA38D7AD3D2503F8E17469648A1FCF4',
}
for p,h in packet_pins.items():ck(sha(BASE/'prime-estimates'/p)==h)
def ceil(x):return (x.numerator+x.denominator-1)//x.denominator
def bits(x):
 ck(x>0)
 return ((x.denominator-1)//x.numerator).bit_length()
def pow2ceil(n):return 1<<(n-1).bit_length()

# Ordinary character counts followed by conductor divisor inversion. This
# avoids using the producer's primitive-count product or parity-difference
# formula as the reconstruction method.
limit=10000
phi=list(range(limit+1)); phi[1]=1
mu=[1]*(limit+1); spf=list(range(limit+1))
for p in range(2,limit+1):
 if spf[p]==p:
  for n in range(p,limit+1,p):
   phi[n]-=phi[n]//p;mu[n]=-mu[n]
   if spf[n]==n:spf[n]=p
  for n in range(p*p,limit+1,p*p):mu[n]=0
prim=[0]*(limit+1);even=[0]*(limit+1)
for d in range(1,limit+1):
 ordinary_even=phi[d] if d<=2 else phi[d]//2
 for n in range(d,limit+1,d):
  prim[n]+=mu[n//d]*phi[d]
  even[n]+=mu[n//d]*ordinary_even
family=[]
for c in range(3,limit+1):
 if not (c%2 or c%4==0):continue
 factors=[];x=c
 while x>1:
  p=spf[x];e=0
  while x%p==0:x//=p;e+=1
  factors.append((p,e))
 axes=[]
 for p,e in factors:
  if p>2:axes.append((p-1)*p**(e-1))
  elif e==2:axes.append(2)
  else:axes.extend((2,2**(e-2)))
 product=1
 for d in axes:product*=d
 ck(product==phi[c] and 0<=even[c]<=prim[c])
 odd=prim[c]-even[c];channel=int(even[c]>0)+int(odd>0)
 band=sum(c>=b for b in [100,1000,10000])
 U=([F(21),F(20),F(39,2),F(96,5)] if c%2 else [F(113,5),F(211,10),F(201,10),F(191,10)])[band]
 dc=F(531600 if c%2 else 1063200,c)
 H=200+ceil(max(F(240 if c%2 else 255),F(3927,1250)*U*dc))
 ck(H>=ceil(F(27000000 if c%2 else 54000000,c)))
 ck(H>=ceil(max(F(300),F(704,343)*dc)))
 family.append((c,phi[c],prim[c],even[c],odd,channel,axes,H))
fam=dict(conductors=len(family),primitive_labels=sum(r[2] for r in family),even_labels=sum(r[3] for r in family),odd_labels=sum(r[4] for r in family),single_parity_conductors=[[r[0],r[3],r[4]] for r in family if r[5]==1])
ck(fam==data['family'])

# Universal envelopes include all main ceiling and grid/auxiliary overshoots.
for odd in [True,False]:
 cmax=10000; floor=240 if odd else 255
 up=F(21) if odd else F(113,5); dc_num=531600 if odd else 1063200
 bound=F(201)*cmax+max(F(floor*cmax),F(3927,1250)*up*dc_num)+F(3205,64)*cmax
 ck(bound<(40000000 if odd else 80000000))

params={}
for theta in [64,128]:
 for odd in [True,False]:
  W=F(40000000 if odd else 80000000,theta); eps=F(1,2**82*3**theta); r=F(3,8)
  K=L=X=1
  while 128*W*W*r**K>=eps:K+=1
  while 48*W*r**L>=eps:L+=1
  while F(8,3)**(2*X)<W*(2*X+L):X+=1
  C=4*(X+1);n0=1
  while True:
   v0=3*n0*n0/W;z0=3*(2*n0+1)/W-F(1,n0)
   if v0>=2 and z0>0:
    tail=2*C*n0*(1+1/z0)*r**(v0.numerator//v0.denominator)
    if tail<eps/8:break
   n0*=2
  Bpref=2*3**(3*X+3);p=bits(eps/(192*C*Bpref*n0**4));B=3**(X+1);M=B+1
  delta=F(1,2**p);epref=eps/(64*C*(n0*n0+2));D=min(delta/16,1/W)
  sigma=min(F(1,4),D/(64*M**4),epref/(16*M**3),F(1,16*n0))
  t=dict(theta=theta,odd=odd,W=W,eps=eps,K=K,L=L,X=X,C=C,n0=n0,Bpref=Bpref,p=p,B=B,M=M,sigma=sigma,tail=tail)
  ck({k:str(v) if isinstance(v,F) else v for k,v in t.items()}==next(v for v in data['parameters'] if v['theta']==theta and v['odd']==odd))
  ck(5*X<=64 and 6*delta<=eps/(32*C*Bpref*n0**4))
  ck(15*M**4*sigma<D and 7*M**3*sigma<epref and 4*n0*sigma<=F(1,4))
  params[theta,odd]=t

@lru_cache(None)
def axis(d):
 if d&(d-1)==0:
  k=d.bit_length()-1
  return dict(butterflies=d*k//2,products=0,scales=0,C=2*k+4,safe=max(1,2*k),roots=d,kb=0,ke=0)
 P=pow2ceil(2*d-1);k=P.bit_length()-1;R=2*k+4;A=1+3*R
 return dict(butterflies=2*(P*k//2),products=P+2*d,scales=P,C=6*P*A+2*R*(2*d+1)+8,safe=max(1,2*k,P*A,3*d*P*A+1),roots=P+2*d,kb=P*k//2,ke=P)

summaries=[];examples=[];digest=hashlib.sha256();choice={e:[[],[]] for e in [0,167,320,640]};chosenN={};earlier_rows={}
for extra in [0,167,320,640]:
 for theta in [64,128]:
  totals=Counter();by={str(o):Counter() for o in [True,False]};ranges={};hist=Counter();comparisons=Counter();unique=set();lengths=set()
  for c,v,n,ev,od,h,axes,H in family:
   odd=bool(c%2);o=int(od>0);t=params[theta,odd]
   top=(64*H+4)//5+extra;V=F(5*top,64);nout=top+1;W=c*V/theta
   ck(V>=2*theta and 1<=W<=t['W'])
   need=max(2*V*t['K']/theta,V+2*t['K'],F(6))
   N=max(8,pow2ceil(ceil(need*F(64,5))));period=F(5*N,64)
   J=ceil(period*t['X']/6);R=J+1
   ck(period>=need and J<N//2 and nout<=N)
   # Closed grid includes the integer endpoint and every auxiliary node.
   ck(V>=H+F(5*extra,64) and V-H-F(5*extra,64)<F(5,64))
   T=ceil(t['n0']*(1+period/3)+R)
   g=sum(v//d*axis(d)['butterflies'] for d in axes);p=sum(v//d*axis(d)['products'] for d in axes);scale=sum(v//d*axis(d)['scales'] for d in axes)
   S=sum(axis(d)['C'] for d in axes);safe=max(axis(d)['safe'] for d in axes)
   uchar=min(F(1,safe),F(1,2*S),t['eps']/(128*t['C']*t['Bpref']*v*S*(t['n0']**2+2)))
   sigma=t['sigma'];dr=sigma/(4*t['B']*max(1,J));k0=min(dr/16,sigma/(16384*c*c));eta=sigma/256
   ugauss=min(F(1,safe),F(1,2*S),eta/(256*v*S))
   k=N.bit_length()-1
   utime=min(F(1,2*k),t['eps']*F(5,64)/(56*(2*k+4)*(2*t['W']**2+2)))
   escale=F(1,2**82)/(2*t['W']**2+1);ds=escale/(8*3**theta*max(1,top))
   ck(J*dr<=F(1,2) and k0<=eta/(8*c) and 3*k0<=eta/(32*v) and top*ds<F(1,2))
   ds_axes=set(axes)
   count=dict(conductors=1,primitive_labels=n,even_labels=ev,odd_labels=od,unit_residues=v,
    conductor_grid_nodes=nout,primitive_grid_outputs=n*nout,Gaussian_terms_upper=T,Gaussian_unit_gates_upper=2*T,
    bucket_additions_upper=h*T,odd_integer_scales_upper=o*T,outer_complex_exp_upper=R,Gaussian_seed_unit_contractions_upper=R,real_exp_seed_certificates=2,
    main_character_calls=h*R,main_character_butterflies=h*R*g,main_character_point_products=h*R*p,main_character_inverse_dyadic_scales=h*R*scale,
    prefactor_contraction_complex_products=n*R,radial_argument_prefactor_real_products=J+(4+o+2*n)*R,cutoff_rational_divisions=R,
    tilt_cis_certificates=1+h,conductor_positive_roots=2,phase_positive_roots=n,phase_divisions=n,K_complex_products=n,eighth_root_undo_complex_products_upper=n,
    fixed_setup_arithmetic_upper=16+12*n,gauss_character_calls=1,gauss_character_butterflies=g,gauss_character_point_products=p,gauss_character_inverse_dyadic_scales=scale,
    additive_root_cis=v,character_root_cis_upper=sum(axis(d)['roots'] for d in ds_axes),eighth_root_cis_upper=8,time_root_cis_upper=N//2,
    blue_kernel_builds=sum(bool(d&(d-1)) for d in ds_axes),blue_kernel_butterflies=sum(axis(d)['kb'] for d in ds_axes),blue_kernel_entries=sum(axis(d)['ke'] for d in ds_axes),
    time_butterflies=n*N//2*k,time_dft_complex_outputs=n*N,omega_complex_scalings=n*nout,positive_scale_real_updates=top,final_Y_real_products=n*nout,
    frequency_conjugate_copies=n*J,zero_imaginary_projections=n,point_EM_character_calls=nout,point_EM_character_butterflies=nout*g,point_EM_character_point_products=nout*p,point_EM_formal_P20_contractions=20*v*nout)
   totals.update(count);by[str(odd)].update(count);hist[N]+=1
   comparisons['theta_fewer_character_calls' if h*R<nout else 'theta_at_least_character_calls']+=1
   values=dict(V=V,N=N,R=R,T=T,seed_bits=t['p'],sigma_bits=bits(sigma),radial_bits=bits(dr),setup_bits=bits(k0),character_bits=bits(uchar),gauss_bits=bits(ugauss),time_bits=bits(utime),scale_bits=bits(ds),transpose_complex_cells=n*R)
   for name,value in values.items():
    if name not in ranges:ranges[name]=[value,value]
    else:ranges[name]=[min(ranges[name][0],value),max(ranges[name][1],value)]
   unique.update(ds_axes);lengths.add(N)
   digest.update(json.dumps([extra,theta,c,H,top,N,R,T,count],sort_keys=True).encode())
   if c in [3,4,5,8,12,100,101,1000,10000] and extra in [0,640]:examples.append(dict(c=c,extra=extra,theta=theta,H=H,top=top,V=str(V),N=N,R=R,T=T,parities=[ev,od],sigma_bits=bits(sigma),setup_bits=bits(k0)))
   tolerances=[F(1,2**t['p']),sigma,dr,k0,uchar,ugauss,utime,ds]
   if theta==64:
    chosenN[extra,c]=N
    earlier_rows[extra,c]=(count,tolerances)
   else:
    ck(chosenN[extra,c] in [N,2*N]);choice[extra][int(chosenN[extra,c]==2*N)].append(c)
    if chosenN[extra,c]==N:
     old_count,old_tolerances=earlier_rows[extra,c]
     ck(count==old_count)
     for new_t,old_t in zip(tolerances,old_tolerances):ck(new_t<=old_t)
  shared=dict(time_root_cis_upper=sum(N//2 for N in lengths),character_root_cis_upper=sum(axis(d)['roots'] for d in unique),blue_kernel_builds=sum(bool(d&(d-1)) for d in unique),blue_kernel_entries=sum(axis(d)['ke'] for d in unique),blue_kernel_butterflies=sum(axis(d)['kb'] for d in unique),eighth_root_cis_upper=8)
  result=dict(extra_nodes=extra,theta=theta,totals=dict(totals),by_conductor_parity={k:dict(v) for k,v in by.items()},ranges={k:[str(x) for x in v] for k,v in ranges.items()},time_length_conductors={str(k):v for k,v in sorted(hist.items())},call_comparison=dict(comparisons),optional_global_finest_precision_cache=shared)
  saved=next(r for r in data['scenarios'] if r['extra_nodes']==extra and r['theta']==theta)
  ck(result==saved);summaries.append(result)
ck(examples==data['examples']);ck(digest.hexdigest()==data['all_rows_digest'])
choice_data=json.loads((BASE/'prime-estimates/small_family_theta_choice_final_20261111.json').read_text())
ck(choice_data['input_sha256']==EXPECTED)
for row in choice_data['rows']:
 same,half=choice[row['extra']]
 ck(row==dict(extra=row['extra'],same_N=len(same),half_N=len(half),same_N_conductors=same,half_N_conductors=half))
ck(sha(source)==EXPECTED)
out=dict(status='PASS exact whole-family reconstruction; no analytic values',checks=checks,input_sha256=EXPECTED,input_pins=data['pins'],packet_pins=packet_pins,family=fam,all_rows_digest=digest.hexdigest(),scenarios=summaries,choice_counts={str(e):dict(same=len(v[0]),halved=len(v[1])) for e,v in choice.items()})
with Path(__file__).with_name('review_small_family_theta_final_20261111.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(f'PASS {checks} checks; all eight full-family scenarios and every row digest match.')
