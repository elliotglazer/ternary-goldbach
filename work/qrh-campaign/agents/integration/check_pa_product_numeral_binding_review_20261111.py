"""Independent static signature, symbolic identity and length-count review.
No author import, proof/declaration emission, digit enumeration or arithmetic instances.
"""
from pathlib import Path
from hashlib import sha256
import json,re
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AUTHOR='work/qrh-campaign/agents/independent-feasibility/'
pins={
 AUTHOR+'PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md':'67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59',
 AUTHOR+'pa_product_representation_syntax_20261111.py':'8793BCCB4D8988DCC986A41503D3343CF556A7FD3032097C2E7AC5D4D84C1719',
 AUTHOR+'pa_product_representation_syntax_20261111.json':'B522D12703201099B8148D09643F860DA6AD6D74A62CB24BFA03D62C8D1185A3',
 'work/qrh-campaign/agents/prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md':'F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2',
 'work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md':'DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
receipt=json.loads((ROOT/(AUTHOR+'pa_product_representation_syntax_20261111.json')).read_text())
for p in receipt['source_pins']:pins[p['path']]=p['sha256']
for p,h in pins.items():ck(sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)

# Parse independent prefix notation; B expands to the source's fixed nine-node radix.
def tree(s):
 tokens=re.findall(r'\(|\)|[^\s()]+',s);i=0
 def rec():
  nonlocal i
  x=tokens[i];i+=1
  if x!='(':return x
  head=tokens[i];i+=1;children=[]
  while tokens[i]!=')':children.append(rec())
  i+=1
  return (head,*children)
 t=rec();ck(i==len(tokens));return t
B='one'
for _ in range(8):B=('b0',B)
def expand(t):
 if isinstance(t,str):return B if t=='B' else t
 if t[0]=='I':
  x,Y,l,P,A=t[1:]
  return ('and',('=',('+',l,('*',P,A)),('*',x,Y)),('and',('<',A,x),('and',('<',l,P),('<','0',P))))
 return (t[0],*(expand(v) for v in t[1:]))
def nodes(t):return 1 if isinstance(t,str) else 1+sum(nodes(v) for v in t[1:])
signatures={}
def spec(name,a,hyps,con):
 hs=[expand(tree(x)) for x in hyps];c=expand(tree(con));h=len(hs);sz=nodes(c)
 value={'args':a,'premises':h,'header':sum(map(nodes,hs))+sz+h+1,'cached_call':a+h+2,
 'fresh_call':a+h+sz+1,'conclusion_constructor_edges':sz-1,'HR':a+h+1}
 ck(value==receipt['signatures'][name]);signatures[name]=value
spec('reflexive',1,[],'(= T T)')
spec('zero_word_step',1,['(= T 0)'],'(= (+ (* B T) 0) 0)')
spec('initial_carry_transport',2,['(I x 0 0 one 0)','(= A 0)'],'(I x 0 0 one A)')
spec('concat_start',1,[],'(= (+ 0 (* one Z)) Z)')
spec('concat_step',5,['(= (+ L (* P (+ (* B T) d))) Z)'],'(= (+ (+ L (* P d)) (* (* P B) T)) Z)')
spec('concat_finish',3,['(= (+ L (* P 0)) Z)'],'(= L Z)')
spec('positive_transport',2,['(= xs x)','(< 0 xs)'],'(< 0 x)')
spec('final_transport',6,['(= xs x)','(= ys y)','(= z zs)','(= (* x y) z)'],'(= (* xs ys) zs)')
spec('padded_inner_base',2,[],'(= (+ (+ (* 0 y) 0) c) (+ (* B 0) c))')
spec('bit_affine_start',1,[],'(= T (+ (* one T) 0))')
for e in ('0','1'):
 spec('bit_affine_'+e,4,['(= S (+ (* P T) D))'],f'(= (b{e} S) (+ (* (b0 P) T) (b{e} D)))')
 spec('bit_congruence_'+e,2,['(= T U)'],f'(= (b{e} T) (b{e} U))')
 spec('bit_range_'+e,2,['(< D P)'],f'(< (b{e} D) (b0 P))')
spec('byte_glue',4,['(= S (+ (* B T) d))','(= T U)'],'(= S (+ (* B U) d))')
spec('zero_bit_step',1,['(= T 0)'],'(= (b0 T) 0)')
spec('symmetry',2,['(= T U)'],'(= U T)')
spec('transitivity',3,['(= S T)','(= T U)'],'(= S U)')
spec('positive_b0',1,['(< 0 T)'],'(< 0 (b0 T))')
spec('positive_b1',1,[],'(< 0 (b1 T))')
ck(set(signatures)==set(receipt['signatures']))

# Formal polynomial normalization of C, PB and the two generic affine identities.
# This is symbolic ring algebra, not testing concrete digits or products.
def padd(a,b):
 d=dict(a)
 for k,v in b.items():d[k]=d.get(k,0)+v
 return {k:v for k,v in d.items() if v}
def pmul(a,b):
 d={}
 for k,v in a.items():
  for l,w in b.items():
   key=tuple(sorted(k+l));d[key]=d.get(key,0)+v*w
 return d
def poly(t):
 if isinstance(t,str):
  if t=='0':return {}
  if t=='one':return {():1}
  return {(t,):1}
 if t[0]=='+':return padd(poly(t[1]),poly(t[2]))
 if t[0]=='*':return pmul(poly(t[1]),poly(t[2]))
 if t[0] in ('b0','b1'):return padd(pmul({():2},poly(t[1])),{():1} if t[0]=='b1' else {})
 raise AssertionError(t)
for left,right in [
 ('(+ L (* P (+ (* B T) d)))','(+ (+ L (* P d)) (* (* P B) T))'),
 ('(+ (+ (* 0 y) 0) c)','(+ (* B 0) c)'),
 ('(b0 (+ (* P T) D))','(+ (* (b0 P) T) (b0 D))'),
 ('(b1 (+ (* P T) D))','(+ (* (b0 P) T) (b1 D))'),
 ('(+ 0 (* one Z))','Z'),('(+ L (* P 0))','L')]:ck(poly(tree(left))==poly(tree(right)))

def word(ds,tail='0'):
 for d in reversed(ds):tail=('+',('*',B,tail),d)
 return tail
# Length-only symbolic objects: no byte values or byte tables.
for n in range(1,25):
 ys=[f'y{i}' for i in range(n)];ds=[f'd{i}' for i in range(n)]
 P='one';Y='0';low='0';tail=word(ys)
 for i in range(n):
  ck(tail[0]=='+' and tail[1][0]=='*' and tail[1][1]==B and tail[2]==ys[i])
  tail=tail[1][2];Y=('+',Y,('*',P,ys[i]));low=('+',low,('*',P,ds[i]));P=('*',P,B)
 ck(tail=='0')
 ck(Y[0]=='+' and P[0]=='*')
 for m in range(1,25):
  high=[f'h{j}' for j in range(m-1)]+['c_top']
  carry=word(high)
  ck(word(ds,carry)==word(ds+high))
  ck(word(high[:-1],('+',('*',B,'0'),'c_top'))==carry)
  uses={'reflexive':3*(n-1)+1,'zero_word_step':m,'initial_carry_transport':1,
        'concat_start':2,'concat_step':2*n,'concat_finish':1,'positive_transport':1,'final_transport':1}
  V=sum(uses.values());H=sum(uses[k]*signatures[k]['premises'] for k in uses)
  HR=sum(uses[k]*signatures[k]['HR'] for k in uses)
  C=sum(uses[k]*signatures[k]['conclusion_constructor_edges'] for k in uses)
  ck(V==5*n+m+4 and H==2*n+m+9 and HR==20*n+3*m+26)
  ck(C==46*n+14*m+36)
  reserve=10*n+4*m+4*n*(m+1)
  binding=HR+C+reserve
  ck(binding==4*m*n+21*m+80*n+62)
  decoders=sum(622*l+200 for l in (m,n,m+n));positive=48*m+6
  ck(binding+decoders+positive==4*m*n+1313*m+1324*n+668)
for L in range(1,65):
 ck((8*L+2)+(8*L+2)+(10*L+1)+2 <= 26*L+8)
 ck(23*(26*L+8)+24*L+16==622*L+200)
ck(signatures['padded_inner_base']['header']-10==12)
ck(signatures['padded_inner_base']['fresh_call']-12==12)
binary=['reflexive','bit_affine_start','bit_affine_0','bit_affine_1','bit_congruence_0','bit_congruence_1','byte_glue','zero_bit_step','symmetry','transitivity']
ck(max(signatures[k]['HR'] for k in binary)==7)
ck(max(signatures[k]['conclusion_constructor_edges'] for k in binary)<=16)
ck(max(signatures[k]['HR']+signatures[k]['conclusion_constructor_edges'] for k in ('positive_b0','positive_b1'))==6)
pa=(ROOT/'work/mm0-efficient/toolchain-sources/examples__peano.mm1').read_text()
for name in ['eqid','add01','add02','mul01','mul02','mul11','addass','addcom','muladd','addmul','mulass','b00','b10','b0mul21','b1mul21','lt01','lt01S','ltmul2','mulpos']:
 ck(re.search(r'\btheorem '+name+r'\b',pa) is not None)
verifier=(ROOT/'work/formal-goldbach-bench/mm0/src/verifier.c').read_text()
for text in ['case CMD_UNIFY_REF:','case CMD_PROOF_THM:','run_unify(UThm,','g_stack_top -= t->num_args;']:
 ck(text in verifier)
out={'verdict':'PASS at bounded paper/source and static-metadata scope','checks':checks,'pins':pins,
 'signatures':signatures,'binding_HR_C':'4mn+21m+80n+62','three_decoder_and_positive_upper':'4mn+1313m+1324n+668',
 'scope_exclusions':['no emitted or checked PA/MMB theorem','no digit/table enumeration','no arbitrary-expression decoder','range and alternate cache-representation producers separate','no stock-store fitting or runtime assertion']}
dest=HERE/'pa_product_numeral_binding_review_20261111.json'
with dest.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha256(dest.read_bytes()).hexdigest().upper()}))
