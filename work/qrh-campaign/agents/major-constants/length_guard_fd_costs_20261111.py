"""Bounded geometry and rational width metadata; no coefficient/function values."""
from pathlib import Path
from fractions import Fraction as Q
from math import gcd,comb,factorial
import hashlib,json
B=Path(__file__).resolve().parents[1]
pins={
'major-constants/STAGEWISE_NEWTON_COEFFICIENT_WIDTHS_2026-11-11.md':'61A6DD47B1F86391BA731DAB7A97D2408D54C710BBDF34EA95C36FFD9762F7A0',
'major-constants/stagewise_newton_widths_20261111.json':'717D0A360AC84F0FE327F30C18B4821CF700054521B602FADCD6D49F44F0276C',
'audit/REVIEW_STAGEWISE_NEWTON_COEFFICIENT_WIDTHS_2026-11-11.md':'F8A063A5A1D523D6B804014D8E45245BFCAB686F1C66802423949942AB3136BA',
'integration/TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md':'5213690312A3A4C8BC262439844AF2BE227AF5D13635EEDADD3D720EEDAAAE3F',
'zero-sum/REVIEW_TRUNCATED_NEWTON_ALL_CELL_TRAVERSAL_2026-11-11.md':'365EA347A51CB0BE346A5C9447DABD0AC406379FB3871DBE224D6D3E7EDC4FF8',
'moebius/fixed_horner_degree_envelope_costs_20261111.json':'4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9',
'independent-feasibility/REVIEW_FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'57D7DEDBA4D5497861DD641F4CC68416CA89EEAD0358F2151DA005ABCE319468',
'major-constants/ROUNDED_INITIAL_DIFFERENCE_COST_COMPARISON_2026-11-11.md':'BB570E4A54C551C0CA4137CAD792548EC89D11594BC284D437AF01946C9BB6E0'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for path,h in pins.items():ck(hashlib.sha256((B/path).read_bytes()).hexdigest().upper()==h)
env=json.loads((B/'major-constants/stagewise_newton_widths_20261111.json').read_text())
hor=json.loads((B/'moebius/fixed_horner_degree_envelope_costs_20261111.json').read_text())
def nu(n):return (n&-n).bit_length()-1
def powcap(x):
 assert x>0
 q=x.numerator.bit_length()-x.denominator.bit_length()
 while x>Q(2)**q:q+=1
 while x<=Q(2)**(q-1):q-=1
 return q
def bits(x):return max(1,powcap(x))
def by(w):return (max(1,w)+7)//8
def add(w):return 2*by(w)+1
def mul(a,b):
 m,n=sorted([by(a),by(b)])
 return 5*m*n+2*m+1
def fresh():return dict(core=0,product_macros=0,adder_macros=0,shift_terms=[],signed_bridges=0)
def prod(d,a,b):d['core']+=mul(a,b);d['product_macros']+=1;d['signed_bridges']+=1
def plus(d,w,signed=True):d['core']+=add(w);d['adder_macros']+=1;d['signed_bridges']+=int(signed)
def shift(d,w,k):d['shift_terms'].append([max(1,w),k])
def roundgate(d,qbits,den,w,extra_shift=None,dyadic=False):
 db=den.bit_length()
 if dyadic:shift(d,qbits,nu(den))
 else:
  odd=den>>nu(den);prod(d,qbits,odd.bit_length())
  if nu(den):shift(d,qbits+odd.bit_length(),nu(den))
 plus(d,w);plus(d,db+3);plus(d,db+2,False)
 shift(d,db+1,1);shift(d,db,1)
 if extra_shift is not None:shift(d,*extra_shift)
def combine(*ds):
 r=fresh()
 for d in ds:
  for k in ('core','product_macros','adder_macros','signed_bridges'):r[k]+=d[k]
  r['shift_terms']+=d['shift_terms']
 return r
u=Q(1,2**100)
fixtures=[(10004,8192,1),(16388,8192,1),(20484,4096,1)]+[(L*1024+4,1024,1) for L in (10,11,20,21,40,80,130)]+[(265800,1024,1),(10004,16384,2)]
rows=[]
for c,F,k in fixtures:
 lo=max(1,((2*k-1)*c)//(2*F)+1);hi=min(c-1,((2*k+1)*c)//(2*F));L=hi-lo+1
 ck(L>=1 and F*(L-1)<c)
 units=[a for a in range(lo,hi+1) if gcd(a,c)==1];U=len(units)
 for a in range(lo,hi+1):ck((2*F*a+c-1)//(2*c)==k)
 mode='guard20' if L>=21 else 'guard10' if L>=11 else 'all_cell'
 ck(mode=='all_cell' or c>(20 if mode=='guard20' else 10)*F)
 cohort='final' if F==16384 else 'first_four'
 # Original reviewed combined even-height formula for these c>10000 fixtures.
 H=200+max(255,(191*3927*1063200+10*1250*c-1)//(10*1250*c))
 first={1024:0,4096:12801,8192:25601,16384:64001}[F]
 ck(Q(5*first,64)<H)
 st=env['rows'][cohort]['domains'][mode];coef=list(map(Q,env['rows'][cohort]['converted_coefficient_bounds']))
 E=lambda i,j:Q(st[i]['states'][j]['norm_bound'])
 raw=lambda i,j:st[i]['raw_updates'][j]
 m=min(20,L);p=102+sum(comb(L-1,j) for j in range(m)).bit_length()
 v=2*c;q0=F*lo-k*c
 t=min(nu(F),nu(c)+(k%2==0)) if mode!='all_cell' else 0
 vp=v>>t;Fp=F>>t;rp=q0>>t;delta=nu(Fp)
 lam=[j*delta+nu(factorial(j)) for j in range(20)] if mode!='all_cell' else [0]*20
 ck(q0==rp*2**t and v==vp*2**t and F==Fp*2**t)
 def mag(i,j,x):return bits(x*2**100*vp**i/Q(2)**lam[j])
 init=fresh();powers=fresh()
 for i in range(1,20):
  prod(powers,(vp**(i-1)).bit_length(),vp.bit_length())
  # Both coordinates of the new coefficient prescale.
  for z in range(2):prod(init,bits(coef[19-i]*2**100),(vp**i).bit_length())
  for j in range(min(i-1,m-1)+1):
   factor=rp+j*Fp
   for z in range(2):
    prod(init,mag(i-1,j,E(i-1,j)),max(1,abs(factor).bit_length()))
    plus(init,mag(i,j,Q(raw(i,j)['raw_absolute_sum']['norm_bound']))+1)
  for j in range(1,min(i,m-1)+1):
   scale=(j>>nu(j)) if mode!='all_cell' else j*F
   width=mag(i-1,j-1,E(i-1,j-1))
   sec=mag(i,j,Q(raw(i,j)['secondary_or_insert']['norm_bound']))+1
   for z in range(2):
    for b in range(scale.bit_length()):
     if (scale>>b)&1:shift(init,width,b)
    for _ in range(scale.bit_count()-1):plus(init,sec)
 advE=fresh();advR=fresh()
 for n in range(L-1):
  for j in range(min(18,L-2-n)+1):
   for z in range(2):
    if mode!='all_cell':shift(advE,mag(19,j+1,E(19,j+1)),lam[j+1]-lam[j])
    plus(advE,mag(19,j,E(19,j)+E(19,j+1))+1)
    plus(advR,bits((E(19,j)+E(19,j+1)+u/2)*2**p)+1)
 ir=fresh();frE=fresh();frR=fresh();D=vp**19
 for j in range(m):
  exponent=p-100+lam[j];cancel=min(exponent,nu(D));den=D>>cancel
  qb=bits((E(19,j)+Q(1,2**p))*2**p)
  xb=bits(E(19,j)*2**p*den);w=max(xb,qb+den.bit_length())+2
  for z in range(2):roundgate(ir,qb,den,w,(mag(19,j,E(19,j)),exponent-cancel))
 qout=bits((E(19,0)+u/4+u)*2**100)
 for a in units:
  r=F*a-k*c;tp=min(nu(v),nu(abs(r))) if r else nu(v)
  den=(v>>tp)**19
  for z in range(2):
   roundgate(frE,qout,den,qout+den.bit_length()+2)
   if tp>t:shift(frE,mag(19,0,E(19,0)),19*(tp-t))
   roundgate(frR,qout,2**(p-100),bits((E(19,0)+u/4)*2**p)+2,dyadic=True)
 hrows={}
 for profile,pr in hor['results'][cohort].items():
  h=fresh()
  for a in units:
   r=F*a-k*c;tp=min(nu(v),nu(abs(r))) if r else nu(v)
   rr=r>>tp;vv=v>>tp
   for sr in pr['stages']:
    b=sr['input_grid'];g=sr['output_grid'];align=g-b
    cancel=min(align,nu(vv));den=vv>>cancel;left=align-cancel
    inp=sr['input_magnitude_bits'];qb=sr['rounded_product_magnitude_bits']
    xb=max(1,abs(rr).bit_length())+inp+left
    w=max(xb,qb+den.bit_length())+2
    for z in range(2):
     prod(h,inp,max(1,abs(rr).bit_length()))
     roundgate(h,qb,den,w,(inp+max(1,abs(rr).bit_length()),left))
     plus(h,sr['output_add_and_state_signed_bits'])
  hrows[profile]=h
 rows.append(dict(c=c,F=F,k=k,lo=lo,hi=hi,L=L,U=U,m=m,p=p,domain=mode,cohort=cohort,t=t,
  source_height_example_index=first,target_height=H,
  cold_power_setup=powers,initialization=init,exact_advances=advE,rounded_advances=advR,
  initial_rounding=ir,exact_unit_rounding=frE,dyadic_unit_rounding=frR,
  exact_FD_core=combine(powers,init,advE,frE)['core'],
  rounded_FD_core=combine(powers,init,advR,ir,frR)['core'],horner=hrows,
  coefficient_complex_conversions_per_source_array=20,coefficient_prescales_complex=19,
  initial_complex_rounds=m,source_setup_scope='Geometry, normalization, conversions, shifts, bridges, bindings/cache/policy and proof library remain additional priced rows'))
out={'checks':checks,'pins':pins,'scope':'Twelve bounded geometry fixtures, magnitude-adder/product cores plus separate typed proof terms; no optimum or winner', 'rows':rows}
dst=Path(__file__).with_suffix('.json')
with dst.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dst.read_bytes()).hexdigest().upper(),'summary':[{k:r[k] for k in ('c','F','k','L','U','p','domain','exact_FD_core','rounded_FD_core')}|{'horner':{n:h['core'] for n,h in r['horner'].items()}} for r in rows]}))
