"""Static natural expression/proposition syntax; no arithmetic instances."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
def n(head,*args):return (head,*args)
def add(a,b):return n('add',a,b)
def mul(a,b):return n('mul',a,b)
def eq(a,b):return n('eq',a,b)
def lt(a,b):return n('lt',a,b)
def conj(a,b):return n('and',a,b)
def I(x,Y,l,P,A):return conj(eq(add(l,mul(P,A)),mul(x,Y)),conj(lt(A,x),conj(lt(l,P),lt('zero',P))))
def size(t):return 1 if isinstance(t,str) else 1+sum(map(size,t[1:]))
def occ(t,s):return int(t==s) if isinstance(t,str) else sum(occ(x,s) for x in t[1:])
cell=eq(add(add(mul('x','y'),'A'),'zero'),add(mul('beta','B'),'d'))
specs={
 'inner_base':(['y','c'],[],eq(add(add(mul('zero','y'),'zero'),'c'),'c')),
 'initial_outer':(['x'],[lt('zero','x')],I('x','zero','zero','one','zero')),
 'intermediate_row':(['x','Y','l','P','A','y','B','d','Yn','ln','Pn'],
  [I('x','Y','l','P','A'),cell,lt('y','beta'),lt('d','beta'),eq('Yn',add('Y',mul('P','y'))),eq('ln',add('l',mul('P','d'))),eq('Pn',mul('P','beta'))],
  I('x','Yn','ln','Pn','B')),
 'terminal_row':(['x','Y','l','P','A','y','B','d','Ytotal','Z'],
  [I('x','Y','l','P','A'),cell,eq(add('Y',mul('P','y')),'Ytotal'),eq(add(add('l',mul('P','d')),mul(mul('P','beta'),'B')),'Z')],eq(mul('x','Ytotal'),'Z'))}
rows={}
for name,(args,hyps,conclusion) in specs.items():
 trees=[conclusion,*hyps]
 rows[name]={'args':args,'a':len(args),'h':len(hyps),'tree_sizes':[size(t) for t in trees],
  'beta_occurrences':sum(occ(t,'beta') for t in trees),
  'unshared_header_commands':sum(size(t) for t in trees)+8*sum(occ(t,'beta') for t in trees)+len(hyps)+1,
  'cached_call_commands':len(args)+len(hyps)+2,
  'fresh_call_commands':len(args)+len(hyps)+size(conclusion)+1}
assert [(r['a'],r['h']) for r in rows.values()]==[(2,0),(1,1),(11,7),(10,4)]
assert [r['unshared_header_commands'] for r in rows.values()]==[10,26,120,80]
assert [r['cached_call_commands'] for r in rows.values()]==[4,4,20,16]
assert [r['fresh_call_commands'] for r in rows.values()]==[12,24,40,20]
paths=['work/mm0-efficient/toolchain-sources/examples__peano.mm1',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm0',
 'work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md']
result={'scope':'Static syntax/hash checks only; no numeral instances, proof emission or builds.',
 'interfaces':rows,'beta_unshared_nodes':9,
 'connected_DAG_core':{'V':'mn+2n+1+D','H':'9mn+7n-2','R':'16mn+15n+1+D','commands_with_END':'25mn+22n+1+D+C',
 'conditions':'m,n>=1; D closed zero-argument zero-premise facts only; outside parameterized proof nodes and all new terms added separately.'},
 'pins':{p:hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths}}
with (HERE/'radix256_product_row_syntax_20261111.json').open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print('Four interface syntax/count checks passed; no arithmetic instances evaluated.')
