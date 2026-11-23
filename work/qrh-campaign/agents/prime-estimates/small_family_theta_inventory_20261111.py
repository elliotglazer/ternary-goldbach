"""Whole small-family integer/rational inventory. No analytic-value evaluation."""
from pathlib import Path
from fractions import Fraction as F
from functools import lru_cache
from collections import Counter
import hashlib,json
HERE=Path(__file__).resolve().parent
A=HERE.parent
PINS={
HERE/'NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md':'6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043',
A/'integration/SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md':'A8AC4A3B594C8671476FCC92C67A45DCF42EFF0060F522023F929BA440835A4B',
HERE/'REVIEW_SMALL_CONDUCTOR_SHARED_ELEMENTARY_CIRCUIT_2026-11-11.md':'4642186F50141A6918D80F662C5550DF4E3B481A3CE1D9CCD3035CB7A59009C8',
A/'major-constants/ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md':'C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D',
A/'moebius/EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md':'D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B',
A/'major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md':'6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C',
A/'independent-feasibility/REVIEW_COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md':'F32FABEF789BEF16B64D16040C1FE48D324F0D84DDBA1FF47F0D30DE2C3A6EAA',
A/'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4'}
checks=0
def ck(b):
 global checks
 assert b
 checks+=1
def ceil(x):return -(-x.numerator//x.denominator)
def bits(x):
 b=max(0,x.denominator.bit_length()-x.numerator.bit_length())
 if F(1,1<<b)>x:b+=1
 assert F(1,1<<b)<=x and (b==0 or F(1,1<<(b-1))>x)
 return b
def factors(n):
 ans=[];p=2
 while p*p<=n:
  if n%p==0:
   e=0
   while n%p==0:n//=p;e+=1
   ans.append((p,e))
  p+=1
 if n>1:ans.append((n,1))
 return ans
def mu(n):
 fs=factors(n)
 return 0 if any(e>1 for p,e in fs) else (-1)**len(fs)
def data(c):
 fs=factors(c);phi=n=1;axes=[]
 for p,e in fs:
  phi*=(p-1)*p**(e-1)
  n*=p-2 if e==1 else (p-1)**2*p**(e-2)
  if p!=2:axes.append((p-1)*p**(e-1))
  elif e==2:axes.append(2)
  elif e>=3:axes.extend([2,2**(e-2)])
 difference=mu(c)+(mu(c//2) if c%2==0 else 0)
 ck(n>=abs(difference) and (n+difference)%2==0)
 even=(n+difference)//2;odd=n-even
 ck(phi==__import__('math').prod(axes))
 return dict(c=c,phi=phi,n=n,even=even,odd=odd,h=int(even>0)+int(odd>0),axes=axes,factors=fs)
def height(c):
 band=0 if c<100 else 1 if c<1000 else 2 if c<10000 else 3
 if c%2:u=[F(21),F(20),F('19.5'),F('19.2')][band];dc=F(531600,c);floor=240;base=27000000
 else:u=[F('22.6'),F('21.1'),F('20.1'),F('19.1')][band];dc=F(1063200,c);floor=255;base=54000000
 hp=ceil(200+max(F(floor),F('3.1416')*u*dc))
 hb=ceil(F(base,c));hs=ceil(max(F(300),F(704,343)*dc))
 ck(hp>=hb and hp>=hs)
 return hp
@lru_cache(None)
def axis(d):
 if d&(d-1)==0:
  k=d.bit_length()-1
  return dict(butterflies=d*k//2,products=0,C=2*k+4,safe=max(1,2*k),roots=d,kernel_butterflies=0,kernel_entries=0)
 P=1<<(2*d-2).bit_length();k=P.bit_length()-1;R=2*k+4;aa=1+3*R
 return dict(butterflies=P*k,products=P+2*d,C=6*P*aa+2*R*(2*d+1)+8,safe=max(1,2*k,P*aa,3*d*P*aa+1),roots=P+2*d,kernel_butterflies=P*k//2,kernel_entries=P)
def select(theta,odd):
 W=F(40000000 if odd else 80000000,theta);eps=F(1,2**80*4*3**theta);r=F(3,8)
 K=L=X=1
 while 32*W**2*r**K>=eps/4:K+=1
 while 12*W*r**L>=eps/4:L+=1
 while F(8,3)**(2*X)<W*(2*X+L):X+=1
 C=4*(X+1);n0=1
 while True:
  v0=3*n0*n0/W;z0=3*(2*n0+1)/W-F(1,n0)
  if v0>=2 and z0>0:
   tail=C*2*n0*(1+1/z0)*r**(v0.numerator//v0.denominator)
   if tail<eps/8:break
  n0*=2
 Bpref=2*3**(3*(X+1));p=bits(eps/(192*C*Bpref*n0**4));delta=F(1,2**p)
 B=3**(X+1);M=B+1;epref=eps/(64*C*(n0*n0+2));D=min(delta/16,1/W)
 sigma=min(F(1,4),D/(64*M**4),epref/(16*M**3),F(1,16*n0))
 ck(F(5,64)*X<=1)
 ck(6*delta<=eps/(32*C*Bpref*n0**4))
 ck(15*M**4*sigma<D and 7*M**3*sigma<epref and 4*n0*sigma<=F(1,4))
 return dict(theta=theta,odd=odd,W=W,eps=eps,K=K,L=L,X=X,C=C,n0=n0,Bpref=Bpref,p=p,B=B,M=M,sigma=sigma,tail=tail)
for p,h in PINS.items():ck(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
family=[data(c) for c in range(3,10001) if c%2==1 or c%4==0]
ck(len(family)==7499 and sum(r['n'] for r in family)==18477108)
ck([(r['c'],r['even'],r['odd']) for r in family if r['h']==1]==[(3,0,1),(4,0,1),(12,1,0)])
for r in family:r['H']=height(r['c'])
params={(theta,odd):select(theta,odd) for theta in [64,128] for odd in [True,False]}
results=[];examples=[];allhash=hashlib.sha256()
for extra in [0,167,320,640]:
 for theta in [64,128]:
  totals=Counter();by_parity={str(o):Counter() for o in [True,False]};ranges={};hist=Counter();comparisons=Counter()
  rootorders=set();unique_axes=set();local_time_lengths=set()
  for row in family:
   c,v,n,h=row['c'],row['phi'],row['n'],row['h'];o=int(row['odd']>0);t=params[theta,c%2==1]
   top=ceil(F(64*row['H'],5))+extra;V=F(5*top,64);Jout=top+1;W=c*V/theta
   ck(V>=2*theta and 1<=W<=t['W'])
   need=max(2*V*t['K']/theta,V+2*t['K'],F(6));N=max(8,1<<(ceil(need/F(5,64))-1).bit_length());period=F(5*N,64)
   R=ceil(period*t['X']/6)+1;J=R-1
   ck(period>=need and J<N//2 and Jout<=N)
   T=ceil(t['n0']*(1+period/3)+R)
   g=sum(v//d*axis(d)['butterflies'] for d in row['axes']);p=sum(v//d*axis(d)['products'] for d in row['axes'])
   blue_scale=sum(v//d*(1<<(2*d-2).bit_length()) for d in row['axes'] if d&(d-1))
   S=sum(axis(d)['C'] for d in row['axes']);safe=max(axis(d)['safe'] for d in row['axes'])
   uchar=min(F(1,safe),F(1,2*S),t['eps']/(128*t['C']*t['Bpref']*v*S*(t['n0']**2+2)))
   sigma=t['sigma'];dr=sigma/(4*t['B']*max(1,J));k0=min(dr/16,sigma/(16384*c*c));eta=sigma/256
   ugauss=min(F(1,safe),F(1,2*S),eta/(256*v*S))
   utime=min(F(1,2*(N.bit_length()-1)),t['eps']*F(5,64)/(56*(2*(N.bit_length()-1)+4)*(2*t['W']**2+2)))
   escale=F(1,2**80)/(4*(2*t['W']**2+1));ds=escale/(8*3**theta*max(1,top))
   ck(J*dr<=F(1,2) and k0<=eta/(8*c) and 3*k0<=eta/(32*v))
   ck(top*ds<F(1,2) and uchar>0 and ugauss>0 and utime>0)
   ds_unique=set(row['axes']);lengthlog=N.bit_length()-1
   count=dict(conductors=1,primitive_labels=n,even_labels=row['even'],odd_labels=row['odd'],unit_residues=v,
    conductor_grid_nodes=Jout,primitive_grid_outputs=n*Jout,Gaussian_terms_upper=T,Gaussian_unit_gates_upper=2*T,
    bucket_additions_upper=h*T,odd_integer_scales_upper=o*T,outer_complex_exp_upper=R,Gaussian_seed_unit_contractions_upper=R,real_exp_seed_certificates=2,
    main_character_calls=h*R,main_character_butterflies=h*R*g,main_character_point_products=h*R*p,main_character_inverse_dyadic_scales=h*R*blue_scale,
    prefactor_contraction_complex_products=n*R,radial_argument_prefactor_real_products=J+(4+o+2*n)*R,
    cutoff_rational_divisions=R,tilt_cis_certificates=1+h,conductor_positive_roots=2,
    phase_positive_roots=n,phase_divisions=n,K_complex_products=n,eighth_root_undo_complex_products_upper=n,
    fixed_setup_arithmetic_upper=16+12*n,gauss_character_calls=1,gauss_character_butterflies=g,gauss_character_point_products=p,gauss_character_inverse_dyadic_scales=blue_scale,
    additive_root_cis=v,character_root_cis_upper=sum(axis(d)['roots'] for d in ds_unique),eighth_root_cis_upper=8,
    time_root_cis_upper=N//2,blue_kernel_builds=sum(d&(d-1)!=0 for d in ds_unique),
    blue_kernel_butterflies=sum(axis(d)['kernel_butterflies'] for d in ds_unique),blue_kernel_entries=sum(axis(d)['kernel_entries'] for d in ds_unique),
    time_butterflies=n*(N//2)*lengthlog,time_dft_complex_outputs=n*N,
    omega_complex_scalings=n*Jout,positive_scale_real_updates=top,final_Y_real_products=n*Jout,
    frequency_conjugate_copies=n*J,zero_imaginary_projections=n,
    point_EM_character_calls=Jout,point_EM_character_butterflies=Jout*g,point_EM_character_point_products=Jout*p,
    point_EM_formal_P20_contractions=20*v*Jout)
   totals.update(count);by_parity[str(c%2==1)].update(count);hist[N]+=1
   comparisons['theta_fewer_character_calls' if h*R<Jout else 'theta_at_least_character_calls']+=1
   for name,val in dict(V=V,N=N,R=R,T=T,seed_bits=t['p'],sigma_bits=bits(sigma),radial_bits=bits(dr),setup_bits=bits(k0),character_bits=bits(uchar),gauss_bits=bits(ugauss),time_bits=bits(utime),scale_bits=bits(ds),transpose_complex_cells=n*R).items():
    if name not in ranges:ranges[name]=[val,val]
    else:ranges[name]=[min(ranges[name][0],val),max(ranges[name][1],val)]
   for d in ds_unique:unique_axes.add(d)
   local_time_lengths.add(N)
   allhash.update(json.dumps([extra,theta,c,row['H'],top,N,R,T,count],sort_keys=True).encode())
   if c in [3,4,5,8,12,100,101,1000,10000] and extra in [0,640]:examples.append(dict(c=c,extra=extra,theta=theta,H=row['H'],top=top,V=str(V),N=N,R=R,T=T,parities=[row['even'],row['odd']],sigma_bits=bits(sigma),setup_bits=bits(k0)))
  # An alternative shared cache count, valid only at the finest admitted precision.
  shared=dict(time_root_cis_upper=sum(N//2 for N in local_time_lengths),character_root_cis_upper=sum(axis(d)['roots'] for d in unique_axes),blue_kernel_builds=sum(d&(d-1)!=0 for d in unique_axes),blue_kernel_entries=sum(axis(d)['kernel_entries'] for d in unique_axes),blue_kernel_butterflies=sum(axis(d)['kernel_butterflies'] for d in unique_axes),eighth_root_cis_upper=8)
  results.append(dict(extra_nodes=extra,theta=theta,totals=dict(totals),by_conductor_parity={k:dict(v) for k,v in by_parity.items()},ranges={k:[str(x) for x in v] for k,v in ranges.items()},time_length_conductors=dict(sorted(hist.items())),call_comparison=dict(comparisons),optional_global_finest_precision_cache=shared))
out=dict(status='PASS_WHOLE_SMALL_FAMILY_CONDITIONAL_METADATA',checks=checks,pins={str(p):h for p,h in PINS.items()},
 family=dict(conductors=len(family),primitive_labels=sum(r['n'] for r in family),even_labels=sum(r['even'] for r in family),odd_labels=sum(r['odd'] for r in family),single_parity_conductors=[[r['c'],r['even'],r['odd']] for r in family if r['h']==1]),
 parameters=[{k:str(v) if isinstance(v,F) else v for k,v in t.items()} for t in params.values()],
 scenarios=results,examples=examples,all_rows_digest=allhash.hexdigest(),
 scope='No analytic values, signs, prime candidates, transforms or builds. Conditional combined height profile and fixed tau=2^-80. Whole-axis radix2/Bluestein character schedule; all elementary counts are certificate calls, not constant-cost operations.')
with HERE.joinpath('small_family_theta_inventory_final_20261111.json').open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(status=out['status'],checks=checks,family=out['family'],parameters=out['parameters'],scenarios=[dict(extra=r['extra_nodes'],theta=r['theta'],totals=r['totals'],ranges=r['ranges'],calls=r['call_comparison']) for r in results]),indent=2))
