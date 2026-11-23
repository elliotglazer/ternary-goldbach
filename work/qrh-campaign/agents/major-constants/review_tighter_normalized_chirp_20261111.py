"""Independent formal-coefficient and fixed rational checks; no inventory."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json
HERE=Path(__file__).resolve().parent; AG=HERE.parent
pins={
 'prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F',
 'prime-estimates/tighter_normalized_chirp_constant_20261111.py':'7ECE987A0A0B8435B1F3B50D2DF44F6C2E68D4A51AFD1BCEC015377928A59A0E',
 'prime-estimates/tighter_normalized_chirp_constant_20261111.json':'638560280015BAC11419FFD4E00DDA00F65641C2681BBBAAE9217A5B7BB12FCF',
 'audit/SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'08A06A83C73DBE295DD389F96D316F52C4DEFE7EE1B2243D2B04635B38AC786F',
 'prime-estimates/REVIEW_SHARPER_NORMALIZED_TRANSFORM_PRECISION_RULE_2026-11-11.md':'3ADEA1B5860DA35E5BBF6DF26CEC3A005300096E60CA23BFE52EA3C084C9E9A3',
 'independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md':'FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9',
 'integration/REVIEW_BLUESTEIN_CACHED_NORMALIZATION_2026-11-11.md':'09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA',
 'zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md':'4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for rel,h in pins.items():ck(hashlib.sha256((AG/rel).read_bytes()).hexdigest().upper()==h)

# Independently expanded formal coefficients. Variables n,P,R are not sampled.
def clean(d):return {k:F(v) for k,v in d.items() if v}
def lin(*terms):
 d={}
 for factor,obj in terms:
  for mon,c in obj.items():d[mon]=d.get(mon,F(0))+factor*c
 return clean(d)
E=clean({'nPR':9,'nP':4,'P':2,'n2R':2,'nR':-1,'PR':2})
twonsharp=clean({'nPR':27,'nP':12,'n2R':6,'nR':24,'n':28})
ck(lin((1,twonsharp),(-3,E),(-1,{'n':2,'one':2}))==clean({'nR':27,'PR':-6,'n':26,'P':-6,'one':-2}))
Cold=clean({'PR':18,'P':6,'nR':4,'R':2,'one':8})
Csharp=clean({'PR':F(27,2),'P':6,'nR':3,'R':12,'one':14})
ck(lin((1,Cold),(-1,Csharp))==clean({'PR':F(9,2),'nR':1,'R':-10,'one':-6}))
ck(lin((1,Csharp),(F(-3,4),Cold))==clean({'P':F(3,2),'R':F(21,2),'one':8}))
ck(F(1,2)+F(3,2)==2)
ck(F(3,2)*300+1>300+2)
ck(F(4,3)/2==F(2,3)<1)
ck(2-F(3,4)*2==F(1,2))

rows=[]
for n,P,k in [(2,4,2),(3,8,3)]:
 R=2*k+4;A=3*R+1;q=3*n*A+n+2
 num=P*q+R*(n*(2*n-1)+2*P);X=F(num,n)
 co=6*P*A+2*R*(2*n+1)+8
 cs=F(9*P*A+3*P,2)+3*R*n+12*R+14
 ct=-((-num)//n)+2
 D=max(1,2*k,P*A,3*n*P*A+1);Dt=max(D,2*co)
 ck(2*n<=P<4*n and X>=300)
 ck(X<cs<co and ct<=cs)
 ck(ct-2>=X and ct-3<X)
 ck(X+X*F(1,Dt)+F(n+1,n)<=ct)
 rows.append(dict(n=n,E=num,X=str(X),old=co,sharp=str(cs),tight=ct,D=D,Dt=Dt))
ck(rows[0]['D']==601 and rows[0]['old']==688)
ck(F(1,1024)<=F(1,601))
ck(F(688,1024)>F(1,2))
ck(rows[1]['X']=='2582/3' and rows[1]['tight']==863)

out=dict(scope='Eight pins, three independent formal coefficient identities and two fixed length illustrations; no inventory/values.',
 checks=checks,pins=pins,formal_identities=3,fixed_parameter_rows=rows,
 general_CT_and_selector_proof='Review text; fixed examples are not the general proof.',production_selected=False)
dest=HERE/'review_tighter_normalized_chirp_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=checks,sha256=hashlib.sha256(dest.read_bytes()).hexdigest().upper())))
