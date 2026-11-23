"""Exact formal-polynomial and conductor-class metadata, without function values."""
from pathlib import Path
from fractions import Fraction as R
from math import factorial
import hashlib,json

BASE=Path(__file__).resolve().parents[1]
PINS={
 'major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md':'6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C',
 'independent-feasibility/CLARIFICATION_OCCUPANCY_EVEN_HEIGHT_SCALE_2026-11-11.md':'33B70DABD780D347D183196D7A40D8D0958B264C6D1165EAF515DE366CE24384',
 'major-constants/RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'AFA91F89C51BFC62FAB135997C6ED9FC7FCEAE3FBF6062F973F65AE69ADAC054',
 'independent-feasibility/REVIEW_RESIDUE_DIFFERENCE_TEN_GUARD_EXTENSION_2026-11-11.md':'0FC1801726CE19F28E0B512C3B24FA8D88B1531E3360E8566A1A799A8F955711',
 'prime-estimates/NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'55576F70A22E3B94108C80CE6255D312437085E08281EFC6FBA34E65147E22BC',
 'moebius/REVIEW_NEWTON_RESIDUE_DIFFERENCE_INITIALIZATION_2026-11-11.md':'995BADD0DDBA1F915A768DC34AAEE70BD9E356EE73A665594A6871ECAC83E234',
 'prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md':'99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1',
 'zero-sum/FINAL_ROUND_DENOMINATOR_DIGIT_REUSE_2026-11-11.md':'E5622749AB1A5A9D91743586B17DCE8C3E10C87237E2F48168CD47D7064385BF',
}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((BASE/p).read_bytes()).hexdigest().upper()==h)
def nu(n):
 assert n>0
 return (n & -n).bit_length()-1
def ceil(x):return -((-x.numerator)//x.denominator)
def add(a,b):
 z=a.copy()
 for k,v in b.items():z[k]=z.get(k,0)+v
 return {k:v for k,v in z.items() if v}
def scale(a,s):return {k:v*s for k,v in a.items() if v*s}
def qmul(a):return {(n,q+1,v):c for (n,q,v),c in a.items()}
def update(state,i,step,mode):
 old=state
 out=[{} for _ in range(i+1)]
 if mode=='plain':top=i*step
 elif mode=='two':top=i//(2**nu(i))
 else:top=1
 out[i]=scale(old[i-1],top)
 for j in range(1,i):
  low=j*step if mode=='plain' else (j//2**nu(j) if mode=='two' else 1)
  out[j]=add(add(qmul(old[j]),scale(old[j],j*step)),scale(old[j-1],low))
 out[0]=add(qmul(old[0]),{(19-i,0,i):1})
 return out

# q, v and every n_j are indeterminates; step is an exact integer parameter.
width_rows=[]
for delta in range(15):
 step=2**delta
 plain=two=full=[{(19,0,0):1}]
 for i in range(1,20):
  plain=update(plain,i,step,'plain')
  two=update(two,i,step,'two')
  full=update(full,i,step,'full')
  for j in range(i+1):
   lam=j*delta+nu(factorial(j))
   ck(plain[j]==scale(two[j],2**lam))
   ck(plain[j]==scale(full[j],step**j*factorial(j)))
 gamma=max(j-j*delta-nu(factorial(j)) for j in range(20))
 ck(gamma==(4 if delta==0 else 0))
 power_raw=max((R(1,4)+R(3*j,40))*R(2)**(j-j*delta-nu(factorial(j))) for j in range(1,19))
 # Constants multiply 256*C*Q'.  Include D0 and new-top bounds.
 power_raw=max(power_raw,R(65,256),max(R(j,40)*R(2)**(j-j*delta-nu(factorial(j))) for j in range(1,20)))
 full_state=max(R(2)**j/(step**j*factorial(j)) for j in range(20))
 full_raw=max((R(1,4)+R(3*j,40))*R(2)**j/(step**j*factorial(j)) for j in range(1,19))
 full_raw=max(full_raw,R(65,256),max(R(j,40)*R(2)**j/(step**j*factorial(j)) for j in range(1,20)))
 ck(power_raw<(32 if delta==0 else 1))
 ck(full_state==(2 if delta==0 else 1))
 ck(full_raw<1)
 for j in range(19):
  lam=j*delta+nu(factorial(j));nextlam=(j+1)*delta+nu(factorial(j+1))
  ck(nextlam-lam==delta+nu(j+1))
  ck(3*R(2)**(j-lam)<(64 if delta==0 else 4))
  ck(3*R(2)**j/(step**j*factorial(j))<(8 if delta==0 else 4))
 width_rows.append({'delta':delta,'power_two_state_exponent':28 if delta==0 else 24,
                    'power_two_Newton_raw_exponent':29 if delta==0 else 24,
                    'power_two_traversal_raw_exponent':30 if delta==0 else 26,
                    'factorial_state_exponent':25 if delta==0 else 24,
                    'factorial_Newton_raw_exponent':24,
                    'factorial_traversal_raw_exponent':27 if delta==0 else 26})

# Metadata classes use only floor division, not prime or unit enumeration.
def valuation_class(lo,hi,s):
 if hi<=lo:return None
 a=lo//(2**s)+1;b=hi//(2**s)
 if a%2==0:a+=1
 if b%2==0:b-=1
 if a>b:return None
 count=(b-a)//2+1
 direct=hi//2**s-hi//2**(s+1)-lo//2**s+lo//2**(s+1)
 ck(count==direct)
 return count,a*2**s,b*2**s
starts=[0,6401,12801,25601,64001]
classes=[];summary=[]
for extra in (0,167,320,640):
 for band,(f,start) in enumerate(zip(range(10,15),starts),1):
  F=2**f
  totals={'odd':0,'four_divisible':0};rows=[]
  for odd in (True,False):
   cap=132900 if odd else 265800
   floor_height=440 if odd else 455
   A=R(3927,1250)*(R(96,5) if odd else R(191,10))*(531600 if odd else 1063200)
   required=(5*(start-extra-1))//64+1
   if required>floor_height:
    cap=min(cap,ceil(A/(required-201))-1)
   lo=max(10000,10*F)
   for s in ([0] if odd else range(2,19)):
    group=valuation_class(lo,cap,s)
    if group is None:continue
    count,first,last=group
    for c in (first,last):
     H=ceil(200+max(floor_height-200,A/c))
     final=ceil(R(64,5)*H)+extra
     ck(c>10*F and c>10000 and final>=start)
    totals['odd' if odd else 'four_divisible']+=count
    parity=[]
    for even_k in (False,True):
     t=min(f,s+int(even_k));dlt=f-t
     ck(t==min(f,s+1,s+(1 if even_k else 0)))
     vp=(2*last)//2**t
     ell=(vp**19).bit_length()
     ck(ell==((2*last)**19).bit_length()-19*t)
     wr=width_rows[dlt]
     parity.append({'anchor_parity':'even' if even_k else 'odd','t':t,'delta':dlt,
        'uniform_state_bits_removed':19*t,'max_reduced_v19_bits':ell,
        'b100_power_state_signed_bits':100+ell+wr['power_two_state_exponent']+1,
        'b100_power_Newton_raw_signed_bits':100+ell+wr['power_two_Newton_raw_exponent']+1,
        'b100_power_traversal_raw_signed_bits':100+ell+wr['power_two_traversal_raw_exponent']+1})
    rows.append({'s':s,'conductors':count,'first':first,'last':last,'parities':parity})
  classes.append({'extra_nodes':extra,'band':band,'F':F,'classes':rows})
  summary.append({'extra_nodes':extra,'band':band,**totals,'total':sum(totals.values())})

# Symbolic valuation classifications are backed by small integer fixtures only.
for f in range(2,6):
 for s in range(7):
  c=2**s*3;F=2**f
  for k in range(5):
   t=min(f,s+int(k%2==0))
   ck((2*c)//2**t>0)
   for a in (1,3,5):
    q=F*a-k*c
    ck(q%2**t==0 and F%2**t==0 and 2*c%2**t==0)
    p=s+1 if q==0 else min(s+1,nu(abs(q)))
    ck(p==t+int(s==f and k%2==1))

init_extra=sum((20-j)*(j.bit_count()-1) for j in range(1,20))
advance_extra=sum(j.bit_count()-1 for j in range(1,20))
ck(init_extra==167 and advance_extra==21)
ck(7*21<167<8*21)
result={'scope':'formal integer-state identities and valuation/height metadata only; no actual polynomial or spectral values',
 'checks':checks,'pins':PINS,'width_exponents_above_reduced_Q':width_rows,'class_summaries':summary,'classes':classes,
 'equal_addition_price_only':{'initializer_additions_saved_by_full_factorial':167,'extra_additions_per_advance':21,
 'factorial_fewer_additions_for_L_at_most':8,'power_two_fewer_additions_for_L_at_least':9}}
dest=Path(__file__).with_name('residue_power_two_normalization_final_20261111.json')
with dest.open('x',encoding='utf-8') as stream:json.dump(result,stream,indent=2);stream.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper(),'summary':summary}))
