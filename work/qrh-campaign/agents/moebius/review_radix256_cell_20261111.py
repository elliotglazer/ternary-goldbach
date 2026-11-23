"""Formal polynomial/syntax metadata only, without arithmetic instances."""
from pathlib import Path
import hashlib,json
AG=Path(__file__).resolve().parent.parent
ROOT=AG.parents[2]
PINS={
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md':'3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E',
 'work/qrh-campaign/agents/prime-estimates/radix256_product_cell_syntax_20261111.py':'66FE9884D12E841E103FD4BC9388114DC61F20A91906D3A990508521883E5828',
 'work/qrh-campaign/agents/prime-estimates/radix256_product_cell_syntax_20261111.json':'739294D73E02F394A616DE2B404DD07BF677BDE5B59953ED1C3B25BC4EBA0996',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm1':'13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm0':'463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052'}
checks=0
def ck(t):
 global checks
 assert t
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
author=json.loads((AG/'prime-estimates/radix256_product_cell_syntax_20261111.json').read_text(encoding='utf-8'))
for p,h in author['pins'].items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)

# Polynomial dictionary over symbolic variables. No variable is given a digit value.
def atom(a):return {(a,):1}
one={():1};zero={}
def plus(*ps):
 out={}
 for p in ps:
  for m,c in p.items():out[m]=out.get(m,0)+c
 return {m:c for m,c in out.items() if c}
def neg(p):return {m:-c for m,c in p.items()}
def sub(p,q):return plus(p,neg(q))
def times(p,q):
 out={}
 for a,c in p.items():
  for b,d in q.items():
   m=tuple(sorted(a+b));out[m]=out.get(m,0)+c*d
 return {m:c for m,c in out.items() if c}
V={a:atom(a) for a in ['beta','X','x','y','A','a','c','u','v','e','w','f','d','z','k','B','b']}
b=V['beta'];x=V['x'];y=V['y'];a=V['a'];c=V['c']
e1=sub(times(x,y),plus(times(b,V['u']),V['v']))
e2=sub(plus(V['v'],a),plus(times(b,V['e']),V['w']))
e3=sub(plus(V['w'],c),plus(times(b,V['f']),V['d']))
e4=sub(plus(V['u'],V['e'],V['f']),plus(times(b,V['z']),V['k']))
tail=sub(plus(times(V['X'],y),V['A'],V['k']),V['B'])
t=plus(times(x,y),a,c)
raw=sub(t,plus(times(times(b,b),V['z']),times(b,V['k']),V['d']))
ck(raw==plus(e1,e2,e3,times(b,e4)))
outer=sub(plus(times(plus(times(b,V['X']),x),y),times(b,V['A']),a,c),plus(times(b,V['B']),V['d']))
ck(outer==plus(times(b,tail),raw,times(times(b,b),V['z'])))
bb=V['b']
ck(plus(times(bb,bb),bb,bb,one)==times(plus(bb,one),plus(bb,one)))

def tree(op,*args):return (op,args)
def size(t):return 1 if isinstance(t,str) else 1+sum(size(x) for x in t[1])
def occurrences(t,v):return int(t==v) if isinstance(t,str) else sum(occurrences(x,v) for x in t[1])
def A(x,y):return tree('add',x,y)
def M(x,y):return tree('mul',x,y)
def E(x,y):return tree('eq',x,y)
trees=[E(A(A(M(A(M('beta','X'),'x'),'y'),A(M('beta','A'),'a')),'c'),A(M('beta','B'),'d')),
 E(M('x','y'),A(M('beta','u'),'v')),
 E(A(A('v','a'),'zero'),A(M('beta','e'),'w')),
 E(A(A('w','c'),'zero'),A(M('beta','f'),'d')),
 E(A(A('u','e'),'f'),A(M('beta','z'),'k')),
 E(A(A(M('X','y'),'A'),'k'),'B')]
trees += [tree('lt',v,'beta') for v in ['x','y','a','c']]
sizes=list(map(size,trees));nb=sum(occurrences(t,'beta') for t in trees)
ck(sizes==author['abstract_beta_tree_sizes']==[21,9,11,11,11,9,3,3,3,3])
ck(nb==author['beta_occurrences']==11)
ck(sum(sizes)+8*nb+10==author['unshared_header_commands']==182)
ck(15+9+2==author['cached_conclusion_call_commands']==26)
ck(15+9+21+1==author['fresh_call_commands']==46)
ck(39*(15+9)==936 and 48+936==984)
source=(ROOT/'work/mm0-efficient/toolchain-sources/examples__peano.mm1').read_text(encoding='utf-8')
for snippet in ['theorem sub1can:', 'theorem le11:', 'theorem leaddd ', 'theorem lemuld ',
 'theorem ltirr:', 'theorem addass:', 'theorem mulass:', 'theorem addmul:',
 'theorem muladd:', 'def b0 (n: nat): nat = $ n + n $;', 'theorem b0ne0:']:
 ck(snippet in source)
result=dict(status='PASS_FORMAL_CELL_IDENTITIES_AND_STATIC_COUNTS',checks=checks,pins=PINS,
 author_input_pins=author['pins'],arity=15,premises=9,formal_tree_sizes=sizes,
 beta_occurrences=nb,header_commands=182,cached_call_commands=26,fresh_call_commands=46,
 scope='Formal monomial dictionaries, source snippets and syntax counts only. No digit values, proof emission, compiler or checker execution. D-count domain is qualified in the paper review.')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps(dict(status=result['status'],checks=checks,output=str(dest))))
