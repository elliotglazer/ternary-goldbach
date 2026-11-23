"""Formal row identities and syntax counts; no numeral/product instances."""
from pathlib import Path
import hashlib,json
AG=Path(__file__).resolve().parent.parent;ROOT=AG.parents[2]
PINS={
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md':'71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC',
 'work/qrh-campaign/agents/prime-estimates/radix256_product_row_syntax_20261111.py':'776BAEB7AE70115601404BB86207D9499D64246E11EACCBABDC7981BE178A176',
 'work/qrh-campaign/agents/prime-estimates/radix256_product_row_syntax_20261111.json':'3C3372F84D1AA46997E98DC7C101C75DE13F6BA9A2B0710ADAA6EA5C0BE8430B'}
checks=0
def ck(v):
 global checks
 assert v
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
author=json.loads((AG/'prime-estimates/radix256_product_row_syntax_20261111.json').read_text(encoding='utf-8'))
for p,h in author['pins'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def atom(x):return {(x,):1}
def add(*ps):
 out={}
 for p in ps:
  for m,c in p.items():out[m]=out.get(m,0)+c
 return {m:c for m,c in out.items() if c}
def neg(p):return {m:-c for m,c in p.items()}
def sub(p,q):return add(p,neg(q))
def mul(p,q):
 out={}
 for m,c in p.items():
  for n,d in q.items():
   key=tuple(sorted(m+n));out[key]=out.get(key,0)+c*d
 return {m:c for m,c in out.items() if c}
v={s:atom(s) for s in ['x','Y','l','P','A','y','B','d','beta','Yn','ln','Pn','Ytotal','Z']}
x,Y,l,P,A,y,B,d,b,Yn,ln,Pn,Ytotal,Z=[v[s] for s in v]
old=sub(add(l,mul(P,A)),mul(x,Y))
cell=sub(add(mul(x,y),A),add(mul(b,B),d))
bindY=sub(Yn,add(Y,mul(P,y)))
bindl=sub(ln,add(l,mul(P,d)))
bindP=sub(Pn,mul(P,b))
new=sub(add(ln,mul(Pn,B)),mul(x,Yn))
ck(new==add(old,neg(mul(P,cell)),bindl,mul(B,bindP),neg(mul(x,bindY))))
lastY=sub(Ytotal,add(Y,mul(P,y)))
lastZ=sub(Z,add(l,mul(P,d),mul(mul(P,b),B)))
ck(sub(mul(x,Ytotal),Z)==add(mul(P,cell),neg(old),mul(x,lastY),neg(lastZ)))
ck(add(mul(P,add(A,mul(x,y))),l)==add(l,mul(P,A),mul(x,mul(P,y))))

def t(op,*args):return (op,args)
def plus(a,b):return t('add',a,b)
def times(a,b):return t('mul',a,b)
def eq(a,b):return t('eq',a,b)
def lt(a,b):return t('lt',a,b)
def conj(a,b):return t('and',a,b)
def I(x,Y,l,P,A):return conj(eq(plus(l,times(P,A)),times(x,Y)),conj(lt(A,x),conj(lt(l,P),lt('zero',P))))
def size(z):return 1 if isinstance(z,str) else 1+sum(size(a) for a in z[1])
def beta_count(z):return int(z=='beta') if isinstance(z,str) else sum(beta_count(a) for a in z[1])
E=eq(plus(plus(times('x','y'),'A'),'zero'),plus(times('beta','B'),'d'))
rows={
 'inner_base':(2,[],eq(plus(plus(times('zero','y'),'zero'),'c'),'c')),
 'initial_outer':(1,[lt('zero','x')],I('x','zero','zero','one','zero')),
 'intermediate_row':(11,[I('x','Y','l','P','A'),E,lt('y','beta'),lt('d','beta'),
   eq('Yn',plus('Y',times('P','y'))),eq('ln',plus('l',times('P','d'))),eq('Pn',times('P','beta'))],I('x','Yn','ln','Pn','B')),
 'terminal_row':(10,[I('x','Y','l','P','A'),E,eq(plus('Y',times('P','y')),'Ytotal'),
   eq(plus(plus('l',times('P','d')),times(times('P','beta'),'B')),'Z')],eq(times('x','Ytotal'),'Z'))}
outrows={}
for name,(a,hyps,conclusion) in rows.items():
 trees=[conclusion]+hyps;h=len(hyps)
 counts=dict(a=a,h=h,tree_sizes=list(map(size,trees)),beta_occurrences=sum(map(beta_count,trees)),
  unshared_header_commands=sum(map(size,trees))+8*sum(map(beta_count,trees))+h+1,
  cached_call_commands=a+h+2,fresh_call_commands=a+h+size(conclusion)+1)
 for k,value in counts.items():ck(value==author['interfaces'][name][k])
 outrows[name]=counts
ck(4*13*3+13*3+3+2+1+1==202)
ck(9*13*3+7*3-2==370)
ck(16*13*3+15*3+1==670)
ck(370+670+2==25*13*3+22*3+1==1042)
# n=1 has an inner base, a terminal row, and an initial outer state.
ck(1+0+1+1==2*1+1)
source=(ROOT/'work/mm0-efficient/toolchain-sources/examples__peano.mm1').read_text(encoding='utf-8')
for snippet in ['theorem anli ', 'theorem anri ', 'theorem iani ', 'theorem lemuld ',
 'theorem ltmul2:', 'theorem mulpos:', 'theorem mul01:', 'theorem mul02:',
 'pub theorem pow0:', 'theorem powS2:']:
 ck(snippet in source)
result=dict(status='PASS_STATIC_ROW_BASE_IDENTITIES_AND_SIGNATURES',checks=checks,pins=PINS,
 upstream_pins=author['pins'],interfaces=outrows,example=dict(m=13,n=3,events=202,H=370,R_without_D=670,commands_without_D_C=1042),
 scope='Formal polynomial identities and exact syntax/count metadata only; source/range/binding producers remain outside the conditional core. No author script execution, numeral values or proofs.')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps(dict(status=result['status'],checks=checks,output=str(dest))))
