"""Independent bounded rational grid/length and raw-cost review only."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
ROOT=Path(__file__).resolve().parents[4];B=ROOT/'work/qrh-campaign/agents'
pins={
'work/qrh-campaign/agents/moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
'work/qrh-campaign/agents/moebius/joint_horner_length_precision_20261111.py':'73B3A81B55707A6E3D419C2F479F34BEA162DB93C2C19FBD3781A131BDC63C09',
'work/qrh-campaign/agents/moebius/joint_horner_length_precision_20261111.json':'59EBE87D5E5B2623C8F40A1EADB0F7803106F5005F90826C35F5B08C69284742'}
data=json.loads((B/'moebius/joint_horner_length_precision_20261111.json').read_text())
pins.update(data['pins']);checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in pins.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def bit(x):
 k=x.numerator.bit_length()-x.denominator.bit_length()
 if F(2)**k<=x:k+=1
 ck(F(2)**(k-1)<=x<F(2)**k)
 return k
def nb(k):return max(1,(k+7)//8)
def mult(x,y):
 m,n=sorted((nb(x),nb(y)))
 return m*(5*n+2)+1
def add(w):return 2*nb(w)+1
shapes={'uniform':[100]*20,'linear':[100,100]+list(range(98,80,-1)),
'fixed':[100,100,100,100,97,95,95,95,89,87,87,87,81,79,79,79,71,71,71,71]}
cases={'band1':(F(500),512,'first'),'band2':(F(1000),1024,'first'),'band3':(F(2000),2048,'first'),
'band4':(F(5000),4096,'first'),'band5_declared':(F(7000),8192,'final'),'band5_actual':(F(424195,64),8192,'final')}
u=F(1,2**100);ut=F(1,2**110);R=F(1,2**116);W=4*u+330*ut;flat=2**27*(u/4+330*ut)
Z={'first':[5170+R+W]+[6*F(5,4)**j/factorial(j)+min(4**j*W,flat) for j in range(1,20)],
'final':[F(9023,2)+R+u]+[F(15,2)*F(7,8)**j/factorial(j)+u for j in range(1,20)]}
shift={'first':1266*F(15,16)**27/factorial(27),'final':1266*F(35140,32768)**28/factorial(28)}
numeric={'first':2532*u+633*330*ut,'final':844*u}
cache={};count=0;summary={}
for cname,(V,D,band) in cases.items():
 saved=data['results'][cname];ck((F(saved['V']),saved['Dout'],saved['source_class'])==(V,D,band))
 ck(F(saved['fixed_shift_ratio'])==shift[band]*2**82)
 ck(F(saved['fixed_coefficient_ratio'])==numeric[band]*2**82)
 summary[cname]={}
 for pname,shape in shapes.items():
  group=saved['profiles'][pname];rows=group['candidates'];ck(len(rows)==121)
  ck({(r['K'],r['b0']) for r in rows}=={(k,b) for k in range(10,21) for b in range(90,101)})
  for row in rows:
   K,b0=row['K'],row['b0'];g=[x+b0-100 for x in shape[:K]];ck(row['grids']==g)
   eps=[F(3,4)*F(2)**(-b) for b in g]
   ev=sum((2 if j<K-1 else 1)*eps[j]*F(1,4)**j for j in range(K))
   target=1266*(V+K)**K/F((4*D)**K*factorial(K))
   total=target+shift[band]+numeric[band]+633*ev
   ck(row['admitted']==(total<F(1,2**82)))
   ck(F(row['alpha_ratio'])==total*2**82 and F(row['target_ratio'])==target*2**82)
   ck(F(row['evaluation_ratio'])==633*ev*2**82 and F(row['evaluation_factor'])==ev*2**b0)
   key=(band,pname,K,b0)
   if key not in cache:
    C=[Z[band][j]+eps[j] for j in range(K)]
    A=[sum(C[k]*F(1,4)**(k-j) for k in range(j,K))+sum(eps[k]*F(1,4)**(k-j) for k in range(j,K-1)) for j in range(K)]
    T=[A[j+1]/4+eps[j] for j in range(K-1)]
    stages=[]
    for j in range(K-2,-1,-1):
     M=A[j+1]*2**g[j+1];L=T[j]*2**g[j];x=132900*M*2**(g[j]-g[j+1]);lv=531600*L
     wm,wl=bit(M),bit(L);widths=[bit(x+lv),bit(2*(x+lv)+531600),22,bit(A[j]*2**g[j])]
     stages.append({'j':j,'grids':[g[j+1],g[j]],'Mbits':wm,'Lbits':wl,'add_magnitude_bits':widths,
      'raw_X_signed':bit(x)+1,'raw_Lv_signed':bit(lv)+1,'doubled_residual_signed':bit(2*(x+lv))+1,
      'product_events':2*(mult(18,wm)+mult(20,wl)),'addition_events':2*sum(add(w) for w in widths)})
    cache[key]=(A,stages)
   A,stages=cache[key];ck(row['stages']==stages)
   P=sum(s['product_events'] for s in stages);AA=sum(s['addition_events'] for s in stages)
   ck((row['product_events'],row['addition_events'],row['template_sum'])==(P,AA,P+AA))
   ck(row['initial_signed_bits']==bit(A[-1]*2**g[-1])+1)
   ck(row['output_signed_bits']==bit(A[0]*2**b0)+1)
   ck(row['reencoded_output_signed_bits']==bit(A[0]*2**100)+1==114)
   ck(row['output_reencoding_shift']==100-b0>=0)
   ck(row['conversion_coordinate_count']==2*K and row['signed_add_bridges']==6*(K-1))
   ck(row['signed_product_bridges']==4*(K-1) and row['range_implications']==2*(K-1))
   ck(row['real_add_instances']==8*(K-1))
   ck(row['alignment_shift_instances']==sum(2 for a,b in zip(g,g[1:]) if a>b))
   ck(row['alignment_bit_distance']==2*(g[0]-g[-1]));count+=1
  admitted=[r for r in rows if r['admitted']]
  best=min(admitted,key=lambda r:(r['template_sum'],r['product_events'],r['K'],r['b0']))
  bestP=min(admitted,key=lambda r:(r['product_events'],r['template_sum'],r['K'],r['b0']))
  shortest=min((r for r in admitted if r['b0']==100),key=lambda r:r['K'])
  minK=min(r['K'] for r in admitted)
  same=min((r for r in admitted if r['K']==minK),key=lambda r:(r['template_sum'],r['b0']))
  for field,r in [('best_template',best),('best_product',bestP),('shortest_at100',shortest),('best_at_shortest_K',same)]:
   ck(group[field]=={k:r[k] for k in group[field]})
  ck(group['price_reserve_vs_shortest']=={'products':same['product_events']-best['product_events'],'additions':same['addition_events']-best['addition_events']})
  summary[cname][pname]=group['best_template']
ck(count==2178)
out={'status':'PASS_BOUNDED_JOINT_LENGTH_GRID_REVIEW','checks':checks,'pins':pins,'candidate_count':count,'summary':summary,
'scope':'Expanded rational envelopes, exact metadata only; no author program execution, numerical values, profile extension or builds.'}
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
