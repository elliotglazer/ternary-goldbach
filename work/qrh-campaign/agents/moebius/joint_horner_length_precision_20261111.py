"""Bounded rational length/grid tradeoff. No analytic function values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
PINS={
 'work/qrh-campaign/agents/prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A',
 'work/qrh-campaign/agents/integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E',
 'work/qrh-campaign/agents/prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'work/qrh-campaign/agents/major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
 'work/qrh-campaign/agents/moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md':'96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3',
 'work/qrh-campaign/agents/moebius/SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md':'531DD23307CED3ED958198C750393D933287809B9E42EF738888370AA4DE4474',
 'work/qrh-campaign/agents/independent-feasibility/REVIEW_SIGNED_HORNER_SCHEDULE_AND_BREAK_EVEN_2026-11-11.md':'40AE12EEFE142B932820F6462E6DE7CE127679A0CE220010148C698E984BBFF1',
 'work/qrh-campaign/agents/moebius/signed_horner_schedule_costs_20261111.json':'0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37'}
PROFILES={'uniform':[100]*20,'linear':[100,100]+list(range(98,80,-1)),
 'fixed':[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]}
SCENARIOS=[('band1',F(500),512,'first'),('band2',F(1000),1024,'first'),
 ('band3',F(2000),2048,'first'),('band4',F(5000),4096,'first'),
 ('band5_declared',F(7000),8192,'final'),('band5_actual',F(424195,64),8192,'final')]
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
def bits(x):
 ck(x>0)
 w=0
 while F(2)**w<=x:w+=1
 while F(2)**(w-1)>x:w-=1
 ck(F(2)**(w-1)<=x<F(2)**w)
 return w
def nb(w):return max(1,(w+7)//8)
def mul(a,b):
 m,n=sorted((nb(a),nb(b)),reverse=True)
 return 5*m*n+2*n+1
def add(w):return 2*nb(w)+1
def main():
 for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
 eta=F(1,2**100);ut=F(1,2**110);em=F(1,2**116)
 W=4*eta+330*ut;flat=2**27*(eta/4+330*ut)
 Z={'first':[5170+em+W]+[6*F(5,4)**j/factorial(j)+min(4**j*W,flat) for j in range(1,20)],
    'final':[F(9023,2)+em+eta]+[F(15,2)*F(7,8)**j/factorial(j)+eta for j in range(1,20)]}
 shifts={'first':1266*F(15,16)**27/factorial(27),
         'final':1266*F(5*7028,8*4096)**28/factorial(28)}
 coeff={'first':2532*eta+633*330*ut,'final':844*eta}
 old=json.loads((HERE/'signed_horner_schedule_costs_20261111.json').read_text(encoding='utf-8'))
 results={}
 for name,V,D,band in SCENARIOS:
  byprofile={}
  for profile,shape in PROFILES.items():
   candidates=[]
   for K in range(10,21):
    target=1266*(F(V+K,4*D))**K/factorial(K)
    for b0 in range(90,101):
     grids=[b+b0-100 for b in shape[:K]]
     ck(grids[0]==b0 and min(grids)>=61 and all(grids[j]>=grids[j+1] for j in range(K-1)))
     eps=[F(3,4)*F(2)**(-b) for b in grids]
     evaluation=sum((2 if j<K-1 else 1)*eps[j]*F(1,4)**j for j in range(K))
     total=target+shifts[band]+coeff[band]+633*evaluation
     C=[Z[band][j]+eps[j] for j in range(K)]
     A=[F(0)]*K;A[-1]=C[-1]
     T=[F(0)]*(K-1)
     for j in range(K-2,-1,-1):
      T[j]=A[j+1]/4+eps[j];A[j]=C[j]+T[j]
     stages=[]
     for j in range(K-2,-1,-1):
      m=A[j+1]*2**grids[j+1];ell=T[j]*2**grids[j]
      delta=grids[j]-grids[j+1]
      x=132900*m*2**delta;lv=531600*ell;r=x+lv
      wm,wl=bits(m),bits(ell)
      ck(wm>=1 and wl>=1)
      widths=[bits(r),bits(2*r+531600),22,bits(A[j]*2**grids[j])]
      P=2*(mul(18,wm)+mul(20,wl));AA=2*sum(add(w) for w in widths)
      stages.append(dict(j=j,grids=[grids[j+1],grids[j]],Mbits=wm,Lbits=wl,
          add_magnitude_bits=widths,raw_X_signed=bits(x)+1,raw_Lv_signed=bits(lv)+1,
          doubled_residual_signed=bits(2*r)+1,product_events=P,addition_events=AA))
     P=sum(r['product_events'] for r in stages);AA=sum(r['addition_events'] for r in stages)
     if K==20 and b0==100:
      oldband='first_four' if band=='first' else 'final'
      oldprofile={'uniform':'uniform100','linear':'root_linear','fixed':'fixed_15442'}[profile]
      pr=old['results'][oldband][oldprofile]['uncancelled']
      ck(P==pr['product_template_events'] and AA==pr['add_template_events'])
     candidates.append(dict(K=K,b0=b0,min_grid=min(grids),grids=grids,
       admitted=total<F(1,2**82),alpha_ratio=str(total*2**82),
       target_ratio=str(target*2**82),evaluation_ratio=str(633*evaluation*2**82),
       evaluation_factor=str(evaluation*2**b0),product_events=P,addition_events=AA,
       template_sum=P+AA,initial_signed_bits=bits(A[-1]*2**grids[-1])+1,
       output_signed_bits=bits(A[0]*2**b0)+1,
       reencoded_output_signed_bits=bits(A[0]*2**100)+1,
       output_reencoding_shift=100-b0,conversion_coordinate_count=2*K,
       signed_add_bridges=6*(K-1),signed_product_bridges=4*(K-1),
       range_implications=2*(K-1),real_add_instances=8*(K-1),
       alignment_shift_instances=sum(2 for r in stages if r['grids'][1]>r['grids'][0]),
       alignment_bit_distance=sum(2*(r['grids'][1]-r['grids'][0]) for r in stages),
       stages=stages))
   admitted=[r for r in candidates if r['admitted']]
   ck(admitted)
   best=min(admitted,key=lambda r:(r['template_sum'],r['product_events'],r['K'],r['b0']))
   bestP=min(admitted,key=lambda r:(r['product_events'],r['template_sum'],r['K'],r['b0']))
   oldshort=min((r for r in admitted if r['b0']==100),key=lambda r:r['K'])
   minK=min(r['K'] for r in admitted)
   sameK=min((r for r in admitted if r['K']==minK),key=lambda r:(r['template_sum'],r['b0']))
   def key(r):return {k:r[k] for k in ('K','b0','min_grid','alpha_ratio','product_events','addition_events','template_sum','output_reencoding_shift')}
   byprofile[profile]=dict(best_template=key(best),best_product=key(bestP),
       shortest_at100=key(oldshort),best_at_shortest_K=key(sameK),
       extra_stage_vs_shortest=best['K']-sameK['K'],
       price_reserve_vs_shortest={'products':sameK['product_events']-best['product_events'],
                                 'additions':sameK['addition_events']-best['addition_events']},
       candidates=candidates)
  results[name]=dict(V=str(V),Dout=D,source_class=band,fixed_shift_ratio=str(shifts[band]*2**82),
       fixed_coefficient_ratio=str(coeff[band]*2**82),profiles=byprofile)
 out=dict(status='PASS_BOUNDED_JOINT_PARAMETER_METADATA',checks=checks,pins=PINS,
     candidate_count=2178,scope='Six worst-height cases; K10..20,b0 90..100,three fixed shifted shapes; no new arbitrary-grid optimization or function values.',results=results)
 dest=HERE/'joint_horner_length_precision_20261111.json'
 with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
 print(json.dumps({'checks':checks,'summary':{n:{p:{'best':{k:v for k,v in r['best_template'].items() if k!='alpha_ratio'},'shortest':{k:v for k,v in r['best_at_shortest_K'].items() if k!='alpha_ratio'}} for p,r in s['profiles'].items()} for n,s in results.items()}}))
if __name__=='__main__':main()
