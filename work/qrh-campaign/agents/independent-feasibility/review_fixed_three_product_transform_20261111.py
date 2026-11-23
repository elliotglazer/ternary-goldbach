"""Exact symbolic and pin checks only. No numerical complex values or transforms."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import re

BASE=Path(__file__).resolve().parent.parent
AUTHOR=BASE/'zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md'
checks=0
def need(p):
 global checks
 assert p
 checks+=1
def digest(p): return hashlib.sha256(p.read_bytes()).hexdigest().upper()
need(digest(AUTHOR)=='087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D')
pins={}
for name,sha in re.findall(r'^\| ([^|]+?) \| ([0-9A-F]{64}) \|$',AUTHOR.read_text(),re.M):
 path=BASE.parents[2]/name if name.startswith('work/') else BASE/name
 need(digest(path)==sha); pins[name]=sha
need(len(pins)==9)
# Sparse commutative polynomials in formal variables, not assigned values.
def add(*polys):
 r={}
 for p in polys:
  for k,v in p.items(): r[k]=r.get(k,0)+v
 return {k:v for k,v in r.items() if v}
def neg(p): return {k:-v for k,v in p.items()}
def mul(p,q):
 r={}
 for a,x in p.items():
  for b,y in q.items():
   key=tuple(sorted(a+b)); r[key]=r.get(key,0)+x*y
 return {k:v for k,v in r.items() if v}
A,B,C,D,EC,ED=({(x,):1} for x in ['A','B','C','D','EC','ED'])
T=mul(C,add(A,B)); U=mul(B,add(C,D)); V=mul(A,add(D,neg(C)))
real=add(T,neg(U)); imag=add(T,V)
need(real==add(mul(A,C),neg(mul(B,D))))
need(imag==add(mul(A,D),mul(B,C)))
need(add(T,neg(mul(B,add(C,D,EC))),neg(real))==neg(mul(B,EC)))
need(add(T,mul(A,add(D,neg(C),ED)),neg(imag))==mul(A,ED))
# Norm inequalities are checked after squaring nonnegative rational bounds.
need(F(2,4)<=F(9,16))
need(2*F(5,8)**2<1)
need(F(3,2)*F(5,8)==F(15,16))
need(F(15,16)<1)
G=1849018578634950; Acount=3808420069398260
counts={'G':G,'A':Acount,'real_products':3*G,'runtime_real_additions':2*Acount+3*G,
        'four_reference_products':4*G,'four_reference_additions':2*Acount+2*G}
# Extra multiplier factors 2 and4 are covered by the inherited +5 signed width.
need(2<2**3); need(4<2**4)
result={'status':'PASS_SYMBOLIC_REFINEMENT','checks':checks,'input_pins':pins,
        'author_sha256':digest(AUTHOR),'formal_real':str(real),'formal_imag':str(imag),
        'counts':counts,'scope':'Symbolic polynomial identities, rational norm inequalities and source pins only.'}
with Path(__file__).with_suffix('.json').open('x',encoding='utf8',newline='\n') as f:
 f.write(json.dumps(result,indent=2)+'\n')
print(json.dumps({'status':result['status'],'checks':checks,'counts':counts}))
