"""Formal syntax/polynomial checks only; no digit instances or emitted proofs."""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
checks = 0
def ck(value):
    global checks
    assert value
    checks += 1
def sha(path): return hashlib.sha256(path.read_bytes()).hexdigest().upper()
def node(head, *args): return (head, *args)
def add(a,b): return node('add',a,b)
def mul(a,b): return node('mul',a,b)
def eq(a,b): return node('eq',a,b)
def size(t): return 1 if isinstance(t,str) else 1+sum(map(size,t[1:]))
def occurrences(t,v): return int(t==v) if isinstance(t,str) else sum(occurrences(a,v) for a in t[1:])
def leaves(t): return {t} if isinstance(t,str) else set().union(*(leaves(a) for a in t[1:]))

b='beta'; z='zero'
E=[eq(mul('x','y'),add(mul(b,'u'),'v')),
   eq(add(add('v','a'),z),add(mul(b,'e'),'w')),
   eq(add(add('w','c'),z),add(mul(b,'f'),'d')),
   eq(add(add('u','e'),'f'),add(mul(b,z),'k')),
   eq(add(add(mul('X','y'),'A'),'k'),'B')]
conclusion=eq(add(add(mul(add(mul(b,'X'),'x'),'y'),add(mul(b,'A'),'a')),'c'),add(mul(b,'B'),'d'))
args=['X','x','y','A','a','c','u','v','e','w','f','d','k','B']
trees=[conclusion,*E]
ck(set().union(*(leaves(t) for t in trees))-{b,z} == set(args))
sizes=list(map(size,trees)); ck(sizes==[21,9,11,11,11,9])
bc=sum(occurrences(t,b) for t in trees); ck(bc==7)
ck(sum(occurrences(t,z) for t in trees)==3)
header=sum(sizes)+8*bc+len(E)+1
cached=len(args)+len(E)+2
fresh=len(args)+len(E)+size(conclusion)+1
ck((len(args),len(E),header,cached,fresh)==(14,5,134,21,41))
ck(182-header==48 and 26-cached==5 and 46-fresh==5)
ck(size(conclusion)==21)  # unchanged ten binary constructors and eleven leaf uses

# Formal commutative-polynomial arithmetic checks no instantiated digit values.
def plus(*ps):
    o={}
    for p in ps:
        for m,a in p.items(): o[m]=o.get(m,0)+a
    return {m:a for m,a in o.items() if a}
def neg(p): return {m:-a for m,a in p.items()}
def times(p,q):
    o={}
    for a,x in p.items():
        for c,y in q.items():
            m=tuple(sorted(a+c));o[m]=o.get(m,0)+x*y
    return {m:a for m,a in o.items() if a}
def poly(t):
    if isinstance(t,str): return {} if t==z else {(t,):1}
    if t[0]=='add': return plus(poly(t[1]),poly(t[2]))
    if t[0]=='mul': return times(poly(t[1]),poly(t[2]))
    if t[0]=='eq': return plus(poly(t[1]),neg(poly(t[2])))
    raise AssertionError(t)
res=list(map(poly,E))
raw=eq(add(add(mul('x','y'),'a'),'c'),add(mul(b,'k'),'d'))
ck(poly(raw)==plus(*res[:3],times(poly(b),res[3])))
ck(poly(conclusion)==plus(poly(raw),times(poly(b),res[4])))
ck(poly(conclusion)==plus(*res[:3],times(poly(b),plus(res[3],res[4]))))

# Fixed signature counts, with n intermediate/base roles exactly as in the row packet.
# m,n remain formal polynomial variables, not product witnesses.
core_old = plus(times({('m','n'):1},{():25}),{('n',):22,():1})
core_new = plus(times({('m','n'):1},{():20}),{('n',):22,():1})
ck(plus(core_old,neg(core_new))=={('m','n'):5})
ck(25*13*3+22*3+1==1042)
ck(20*13*3+22*3+1==847)
ck(1042-847==195)
ck(48+39*(14+5)==789) # row signatures left symbolic in the earlier formulation

expected={
'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md':'3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E',
'work/qrh-campaign/agents/prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md':'F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2',
'work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md':'DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA',
'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md':'71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC',
'work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md':'E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6',
'work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md':'3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227',
'work/mm0-efficient/toolchain-sources/examples__peano.mm1':'13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079',
'work/mm0-efficient/toolchain-sources/examples__peano.mm0':'463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052',
'work/formal-goldbach-bench/mm0/src/verifier.c':'71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5',
}
for rel,h in expected.items(): ck(sha(ROOT/rel)==h)
out={'status':'PASS_FORMAL_ALGEBRA_AND_STATIC_SYNTAX_ONLY','checks':checks,
 'arguments':args,'premises':E,'conclusion':conclusion,'tree_sizes_atomic_beta':sizes,
 'beta_occurrences':bc,'expanded_header_commands':header,'cached_call_commands':cached,'fresh_call_commands':fresh,
 'row_core':'20mn+22n+1+D+C','row_core_13_by_3_constant':847,
 'scope':'No numeral/digit assignments, enumeration, table facts, proof emission, declarations or builds. Row/base composition remains conditional.',
 'pins':expected}
dest=HERE/'pa_zero_carry_cell_syntax_20261111.json'
with dest.open('x',encoding='utf8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':sha(dest)}))
