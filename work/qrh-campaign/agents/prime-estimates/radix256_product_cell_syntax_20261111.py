"""Static expression-tree counts only; no digit or arithmetic instances."""
from pathlib import Path
import hashlib, json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
def node(op, *args): return (op, *args)
def add(a,b): return node('add',a,b)
def mul(a,b): return node('mul',a,b)
def eq(a,b): return node('eq',a,b)
def lt(a,b): return node('lt',a,b)
def size(t): return 1 if isinstance(t,str) else 1+sum(size(x) for x in t[1:])
def count(t, atom): return int(t==atom) if isinstance(t,str) else sum(count(x,atom) for x in t[1:])
def constructors(t): return 0 if isinstance(t,str) else 1+sum(constructors(x) for x in t[1:])
B='beta'
premises=[eq(mul('x','y'),add(mul(B,'u'),'v')),
 eq(add(add('v','a'),'zero'),add(mul(B,'e'),'w')),
 eq(add(add('w','c'),'zero'),add(mul(B,'f'),'d')),
 eq(add(add('u','e'),'f'),add(mul(B,'z'),'k')),
 eq(add(add(mul('X','y'),'A'),'k'),'B'),
 *[lt(v,B) for v in ['x','y','a','c']]]
conclusion=eq(add(add(mul(add(mul(B,'X'),'x'),'y'),add(mul(B,'A'),'a')),'c'),add(mul(B,'B'),'d'))
trees=[conclusion,*premises]
pins={}
for relative in [
 'work/mm0-efficient/toolchain-sources/examples__peano.mm1',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm0',
 'work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md',
 'work/qrh-campaign/agents/major-constants/REVIEW_MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md',
 'work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md']:
 pins[relative]=hashlib.sha256((ROOT/relative).read_bytes()).hexdigest().upper()
arguments=['X','x','y','A','a','c','u','v','e','w','f','d','z','k','B']
result={'scope':'Static syntax and source hashes only; no digit facts/proof emission.',
 'arguments':arguments,'argument_arity':len(arguments),'premise_arity':len(premises),
 'abstract_beta_tree_sizes':[size(t) for t in trees],
 'beta_occurrences':sum(count(t,B) for t in trees),
 'beta_term':'eight nested existing b0 constructors applied to existing d1',
 'beta_unshared_nodes':9,
 'unshared_header_commands':sum(size(t) for t in trees)+8*sum(count(t,B) for t in trees)+len(premises)+1,
 'fresh_conclusion_binary_constructors':constructors(conclusion),
 'fresh_call_commands':len(arguments)+len(premises)+size(conclusion)+1,
 'cached_conclusion_call_commands':len(arguments)+len(premises)+2,
 'pins':pins}
assert result['abstract_beta_tree_sizes']==[21,9,11,11,11,9,3,3,3,3]
assert result['unshared_header_commands']==182
assert result['fresh_call_commands']==46
assert result['cached_conclusion_call_commands']==26
with (HERE/'radix256_product_cell_syntax_20261111.json').open('x',encoding='utf-8') as out:
 json.dump(result,out,indent=2);out.write('\n')
print('Static syntax checks passed; no arithmetic instances evaluated.')
