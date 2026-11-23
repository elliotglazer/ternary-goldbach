"""Exact parameter/operation metadata only; no coefficient or analytic values."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb,factorial
import hashlib,json
B=Path(__file__).resolve().parents[1]
pins={
'prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A',
'integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E',
'moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
'major-constants/STAGEWISE_NEWTON_COEFFICIENT_WIDTHS_2026-11-11.md':'61A6DD47B1F86391BA731DAB7A97D2408D54C710BBDF34EA95C36FFD9762F7A0',
'audit/REVIEW_STAGEWISE_NEWTON_COEFFICIENT_WIDTHS_2026-11-11.md':'F8A063A5A1D523D6B804014D8E45245BFCAB686F1C66802423949942AB3136BA',
'major-constants/ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md':'FB0B0F9AF9C53150E14C1F5FFDE7A39E78DD8A6BFA09FE7769BF234EBB965E46',
'moebius/REVIEW_ROUNDED_INITIAL_DIFFERENCES_EXACT_TRAVERSAL_2026-11-11.md':'B493A9965A8C9CCDBF138CD56FE322AEE7BC4DD75252AF538951D99709E5A40E'}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for f,h in pins.items():ck(hashlib.sha256((B/f).read_bytes()).hexdigest().upper()==h)
eta=Q(2)**-100;ut=Q(2)**-110
sf=1266*Q(15,16)**27/factorial(27)
sl=1266*Q(5*7028,8*4096)**28/factorial(28)
nf=2532*eta+633*330*ut;nl=844*eta
cases=[('band1',Q(500),512,'first'),('band2',Q(1000),1024,'first'),('band3',Q(2000),2048,'first'),('band4',Q(5000),4096,'first'),('band5_declared',Q(7000),8192,'final'),('band5_actual',Q(424195,64),8192,'final')]
lengths=[]; worst={}; candidates=[]
for K in range(18,21):
 n=K-1;ratios=[]
 for L in range(1,261):
  m=min(K,L);S=sum(comb(L-1,j) for j in range(m));ell=S.bit_length()
  ck(2**(ell-1)<=S<2**ell)
  G=sum(min(i,m) for i in range(1,n+1))
  ck(G==m*(2*n-m+1)//2)
  A=sum(min(n,L-1-r) for r in range(L-1))
  ck(A==(L*(L-1)//2 if L<=K else n*L-n*(n+1)//2))
  # All retained Pascal rows, not just the exported order zero.
  for j in range(m):
   t=L-1-j
   ck(sum(comb(t,r) for r in range(min(n-j,t)+1))<=S)
  secondary_add=sum((n-j+1)*(j.bit_count()-1) for j in range(1,m))
  secondary_shift=sum((n-j+1)*j.bit_count() for j in range(1,m))
  lengths.append(dict(K=K,L=L,m=m,S=S,bitlength=ell,p_by_b_d='b+bitlength+d',prescales=n,general_complex_products=G,initial_complex_additions=G+secondary_add,initial_shifted_operands=secondary_shift,advance_complex_additions=A,initial_complex_rounds=m,final_complex_rounds='U',export_coordinate_shifts='2U'))
  ratios.append((Q(S,2**ell),L))
 worst[K]=max(ratios)
 for b in range(93,101):
  for d in range(3):
   r,Lw=worst[K]
   Ecoef=1-Q(1,4**K)+Q(3,4)+Q(3,4)*r/2**d
   ck(Ecoef<Q(5,2))
   ck(Q(3,4)*r/2**d<Q(3,4)/2**d)
   for name,V,D,cl in cases:
    T=1266*((V+K)/(4*D))**K/factorial(K)
    total=T+(sf if cl=='first' else sl)+(nf if cl=='first' else nl)+633*Ecoef*Q(2)**-b
    candidates.append(dict(case=name,V=str(V),D=D,K=K,b=b,d=d,worst_length=Lw,evaluation_in_ulps=str(Ecoef),alpha_ratio=str(total*2**82),admitted=total<Q(2)**-82,maximum_p=b+lengths[-1]['bitlength']+d,output_grid100_shift=100-b))
    ck(total>0)
 # Exact Pascal identity at every small finite rank, independent of any values.
 for j in range(n+1):
  for r in range(1,n-j+1):ck(comb(n-j+1,r)==comb(n-j,r)+comb(n-j,r-1))
summaries=[]
for name,_,_,_ in cases:
 for K in range(18,21):
  for d in range(3):
   good=[r for r in candidates if r['case']==name and r['K']==K and r['d']==d and r['admitted']]
   summaries.append(dict(case=name,K=K,d=d,least_b=min((r['b'] for r in good),default=None)))
out=dict(scope='K18..20, b93..100, d0..2, all integer lengths1..260; exact rational sufficient alpha bound, no source-work change',pins=pins,checks=checks,worst_ratio_by_K={str(k):dict(ratio=str(v[0]),length=v[1]) for k,v in worst.items()},length_rows=lengths,candidates=candidates,summaries=summaries)
path=Path(__file__).with_suffix('.json')
with path.open('x') as f:json.dump(out,f,indent=2)
print(json.dumps(dict(checks=checks,rows=len(lengths),candidates=len(candidates),worst=out['worst_ratio_by_K'],summaries=summaries)))
