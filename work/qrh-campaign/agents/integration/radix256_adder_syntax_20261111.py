"""Paper statement-tree/header counts and source hashes only. No proofs/digits."""
from pathlib import Path
import hashlib,json
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[3]
PINS={
 'work/mm0-efficient/toolchain-sources/examples__peano.mm1':'13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm0':'463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052',
 'work/formal-goldbach-bench/mm0/src/mmb.md':'E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0',
 'work/formal-goldbach-bench/mm0/src/verifier.c':'71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5',
 'work/formal-goldbach-bench/mm0/src/types.c':'B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1',
 'work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md':'E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6',
 'work/qrh-campaign/agents/major-constants/REVIEW_MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md':'70A5D74BF6D4A5D6FF38B85B3D85F528D7E33E8E49329AF114DD1B4CED0F493C',
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md':'3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E',
 'work/qrh-campaign/agents/prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md':'F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2',
}
checks=0
def ck(x):
 global checks
 assert x
 checks+=1
for p,h in PINS.items():ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
def node(op,*args):return (op,*args)
def add(a,b):return node('add',a,b)
def mul(a,b):return node('mul',a,b)
def eq(a,b):return node('eq',a,b)
def lt(a,b):return node('lt',a,b)
def size(t):return 1 if isinstance(t,str) else 1+sum(size(x) for x in t[1:])
def leaves(t):return 1 if isinstance(t,str) else sum(leaves(x) for x in t[1:])
def replace(t):
 if isinstance(t,str):return beta if t=='beta' else t
 return (t[0],*(replace(x) for x in t[1:]))
beta='d1'
for _ in range(8):beta=node('b0',beta)
ck(size(beta)==9)
E=eq(add(add('x','y'),'c'),add(mul('beta','k'),'d'))
H=eq(add(add('X','Y'),'k'),'Z')
C=eq(add(add(add(mul('beta','X'),'x'),add(mul('beta','Y'),'y')),'c'),add(mul('beta','Z'),'d'))
base=eq(add(add('zero','zero'),'c'),'c')
ranges=[lt('x','beta'),lt('y','beta'),lt('c','d2'),lt('k','d2'),lt('d','beta')]
carry=lt('k','d2')
adapter_in=eq(add(add('x','y'),'zero'),'z');adapter_out=eq(add('x','y'),'z')
specs={
 'equation_lift':(8,[E,H],C),
 'range_checked_lift':(8,[E,H]+ranges,C),
 'terminal_base':(1,[],base),
 'carry_bound':(5,[E,ranges[0],ranges[1],ranges[2]],carry),
 'remove_zero_incoming_carry':(3,[adapter_in],adapter_out),
}
rows={}
for name,(a,prem,concl) in specs.items():
 h=len(prem);L=leaves(concl);T=size(concl)-L
 # beta/zero/d2 are already saved whole terms for these fresh-call counts.
 cached=a+h+2;fresh=a+h+L+T+1
 header_nodes=sum(size(replace(t)) for t in prem+[concl])
 row=dict(expression_arguments=a,proof_premises=h,conclusion_atomic_nodes=size(concl),
  conclusion_leaf_refs=L,fresh_binary_terms=T,cached_call_commands=cached,fresh_call_commands=fresh,
  unshared_header_expression_nodes=header_nodes,unshared_header_commands=header_nodes+h+1,
  cached_body_bytes_upper=3*(a+h+1)+5,fresh_body_bytes_upper=3*(a+h+L)+5*(T+1),
  conditional_fresh_expression_bytes=24*T)
 rows[name]=row
ck([size(C),size(E),size(H),size(base)]==[19,11,7,7])
ck([rows[k]['unshared_header_commands'] for k in specs]==[72,116,8,52,14])
ck([rows[k]['fresh_call_commands'] for k in specs]==[30,35,9,13,10])
ck([rows[k]['cached_call_commands'] for k in specs]==[12,17,3,11,6])
ck(rows['equation_lift']['fresh_body_bytes_upper']==110)
ck(rows['range_checked_lift']['fresh_body_bytes_upper']==125)
# Symbolic coefficient vectors for H+R+C+2, ordered (length,D0,C,constant).
eq_body=(2+9,1,1,2+2);checked_body=(7+9,1,1,2+2)
ck(eq_body==(11,1,1,4) and checked_body==(16,1,1,4))
source=(ROOT/'work/mm0-efficient/toolchain-sources/examples__peano.mm1').read_text(encoding='utf8')
for snippet in ['theorem add4:', 'theorem muladd:', 'theorem addass:', 'theorem leadd:', 'theorem lemul2a:', 'theorem leltsuc:', 'theorem ltirr:', 'theorem d0lt2:', 'theorem d1lt2:', 'pub theorem modlt', 'def b0 (n: nat): nat = $ n + n $;']:
 ck(snippet in source)
out=dict(scope='Syntax/header/hash checks only; paper templates unimplemented; no byte enumeration or arithmetic proof emission.',
 checks=checks,pins=PINS,beta_tree=beta,rows=rows,
 body_command_vectors=dict(equation=eq_body,range_checked=checked_body),
 D0_scope='Only newly applied closed zero-argument zero-premise facts. Parameterized range/binding helpers require their full arities and DAG edges.')
dest=HERE/'radix256_adder_syntax_20261111.json'
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'rows':rows,'sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()},indent=2))
