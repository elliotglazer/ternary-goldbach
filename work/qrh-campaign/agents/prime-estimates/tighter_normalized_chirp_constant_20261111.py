from pathlib import Path
from fractions import Fraction as F
import hashlib,json
base=Path('work/qrh-campaign/agents')
pins={
'audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F',
'prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3',
'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
'major-constants/CONDUCTOR_LOCAL_TRANSFORM_PRECISION_PREFLIGHT_2026-11-11.md':'1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A'}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for p,h in pins.items():
 b=(base/p).read_bytes();ck(len(b)<100000);ck(hashlib.sha256(b).hexdigest().upper()==h)
# Sparse formal polynomials in n,P,R; no specialization in the identities.
def add(*ps):
 d={}
 for p in ps:
  for m,c in p.items():d[m]=d.get(m,F(0))+c
 return {m:c for m,c in d.items() if c}
def scale(p,c):return {m:a*c for m,a in p.items() if a*c}
def mul(p,q):
 d={}
 for m,a in p.items():
  for n,b in q.items():
   k=tuple(x+y for x,y in zip(m,n));d[k]=d.get(k,F(0))+a*b
 return {m:c for m,c in d.items() if c}
def const(c):return {(0,0,0):F(c)} if c else {}
n={(1,0,0):F(1)};P={(0,1,0):F(1)};R={(0,0,1):F(1)}
A=add(const(1),scale(R,3));q=add(scale(mul(n,A),3),n,const(2))
E=add(mul(P,q),mul(R,add(mul(n,add(scale(n,2),const(-1))),scale(P,2))))
old=add(scale(mul(P,A),6),scale(mul(R,add(scale(n,2),const(1))),2),const(8))
sharp=add(scale(mul(P,A),F(9,2)),scale(P,F(3,2)),scale(mul(R,n),3),scale(R,12),const(14))
ck(add(sharp,scale(old,F(-3,4)))==add(scale(P,F(3,2)),scale(R,F(21,2)),const(8)))
ck(add(scale(mul(n,sharp),2),scale(E,-3),scale(n,-2),const(-2))==add(mul(R,add(scale(n,27),scale(P,-6))),scale(n,26),scale(P,-6),const(-2)))
ck(add(old,scale(sharp,-1))==add(mul(R,add(scale(P,F(9,2)),n,const(-10))),const(-6)))
rows=[]
for nn,pp,kk in [(2,4,2),(3,8,3),(5,16,4),(17,64,6)]:
 rr=2*kk+4;aa=1+3*rr;qq=3*nn*aa+nn+2
 ee=pp*qq+rr*(nn*(2*nn-1)+2*pp);xx=F(ee,nn)
 co=6*pp*aa+2*rr*(2*nn+1)+8;cs=F(9*pp*aa+3*pp,2)+3*rr*nn+12*rr+14
 ct=(ee+nn-1)//nn+2;db=max(1,2*kk,pp*aa,3*nn*pp*aa+1);dt=max(db,2*co)
 ck(2*nn<=pp<4*nn);ck(xx>=300);ck(xx<=co);ck(ct<=cs<=co);ck(cs>=F(3,4)*co)
 ck(xx+xx*F(1,dt)+F(nn+1,nn)<=ct)
 rows.append(dict(n=nn,P=pp,k=kk,E=ee,X=str(xx),C_old=co,C_sharp=int(cs),C_tight=ct,D_old=db,D_tight=dt))
ck(rows[0]['D_old']<=1024<2*rows[0]['C_old'])
ck(F(4,3)/2<1)
ck(F(3,4)*2+F(1,2)==2)
out=dict(scope='Formal polynomial identities and four fixed length examples only; no inventory, transform or values',checks=checks,pins=pins,polynomial_identities=3,rows=rows,local_D_does_not_imply_peak_example=dict(n=2,u='1/1024'),selected=False)
p=base/'prime-estimates/tighter_normalized_chirp_constant_20261111.json'
s=json.dumps(out,indent=2)+'\n';assert len(s.encode())<12000
with p.open('x',encoding='utf-8') as f:f.write(s)
print(json.dumps({'checks':checks,'bytes':len(s.encode()),'receipt':str(p)}))
