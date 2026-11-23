"""Independent paper syntax and formal-polynomial checks. No emitted proof/digit table."""
from pathlib import Path
from collections import Counter
import hashlib,json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AG=HERE.parent
checks=0;pins={}
def ck(x):
    global checks
    assert x
    checks+=1
def load(rel):
    p=AG/rel
    pins[str(p.relative_to(ROOT))]=hashlib.sha256(p.read_bytes()).hexdigest().upper()
    return json.loads(p.read_text(encoding='utf8'))
data=load('integration/radix256_adder_syntax_20261111.json')
for rel,h in {
 'integration/PA_RADIX256_ADDER_LIFT_BASE_2026-11-11.md':'B34EAE04F56C356894D87DF0FFD765D3403242A5E27257DF9078525D7A173C68',
 'integration/radix256_adder_syntax_20261111.py':'CA01670BC990B3C1955690FA65455D2CEE06533D32F4FC49C5623CBAD1176241',
 'integration/radix256_adder_syntax_20261111.json':'6E79205E694422F0CC66AD4294246B6369FE8BBE71801943F64BBB16B77C21BC',
}.items():
    p=AG/rel
    ck(hashlib.sha256(p.read_bytes()).hexdigest().upper()==h)
    pins[str(p.relative_to(ROOT))]=h
for path,h in data['pins'].items():
    ck(hashlib.sha256((ROOT/path).read_bytes()).hexdigest().upper()==h)
    pins[path]=h

def expr(op,*args):return [op,*args]
def plus(x,y):return expr('add',x,y)
def times(x,y):return expr('mul',x,y)
def eq(x,y):return expr('eq',x,y)
def lt(x,y):return expr('lt',x,y)
B='d1'
for j in range(8):B=expr('b0',B)
e=eq(plus(plus('x','y'),'c'),plus(times('B','k'),'d'))
h=eq(plus(plus('X','Y'),'k'),'Z')
con=eq(plus(plus(plus(times('B','X'),'x'),plus(times('B','Y'),'y')),'c'),plus(times('B','Z'),'d'))
ran=[lt('x','B'),lt('y','B'),lt('c','d2'),lt('k','d2'),lt('d','B')]
spec={
 'equation_lift':(8,[e,h],con),
 'range_checked_lift':(8,[e,h]+ran,con),
 'terminal_base':(1,[],eq(plus(plus('zero','zero'),'c'),'c')),
 'carry_bound':(5,[e,ran[0],ran[1],ran[2]],lt('k','d2')),
 'remove_zero_incoming_carry':(3,[eq(plus(plus('x','y'),'zero'),'z')],eq(plus('x','y'),'z')),
}
def flatten(t,expand=False):
    if isinstance(t,str):
        if expand and t=='B':return flatten(B,False)
        return [('leaf',t)]
    return [('node',t[0])]+[entry for child in t[1:] for entry in flatten(child,expand)]
def variables(t):return {val for typ,val in flatten(t) if typ=='leaf' and val not in ['B','zero','d1','d2']}
rows={}
for name,(a,prem,c) in spec.items():
    ck(len(set.union(variables(c),*(variables(t) for t in prem)))==a)
    nodes=flatten(c);L=sum(typ=='leaf' for typ,val in nodes);T=len(nodes)-L
    header=sum(len(flatten(t,True)) for t in prem+[c])+len(prem)+1
    row=dict(expression_arguments=a,proof_premises=len(prem),conclusion_atomic_nodes=len(nodes),
      conclusion_leaf_refs=L,fresh_binary_terms=T,cached_call_commands=a+len(prem)+2,
      fresh_call_commands=a+len(prem)+len(nodes)+1,unshared_header_expression_nodes=header-len(prem)-1,
      unshared_header_commands=header,cached_body_bytes_upper=3*(a+len(prem)+1)+5,
      fresh_body_bytes_upper=3*(a+len(prem)+L)+5*(T+1),conditional_fresh_expression_bytes=24*T)
    for key,val in row.items():ck(data['rows'][name][key]==val)
    rows[name]=row
ck(B==data['beta_tree'])

# Formal commutative polynomial identity, not numeric digit testing.
def polynomial(t):
    if isinstance(t,str):return {} if t=='zero' else {(t,):1}
    op,*args=t
    x=polynomial(args[0]);y=polynomial(args[1])
    if op=='add':
        z=Counter(x);z.update(y);return dict(z)
    assert op=='mul'
    z=Counter()
    for a,ca in x.items():
        for b,cb in y.items():z[tuple(sorted(a+b))]+=ca*cb
    return dict(z)
def difference(a,b):
    out=dict(a)
    for key,c in b.items():out[key]=out.get(key,0)-c
    return {key:c for key,c in out.items() if c}
def residual(t):return difference(polynomial(t[1]),polynomial(t[2]))
right=residual(e)
for mon,c in residual(h).items():
    key=tuple(sorted(('B',)+mon));right[key]=right.get(key,0)+c
right={key:c for key,c in right.items() if c}
ck(residual(con)==right)
ck(residual(spec['terminal_base'][2])=={})

# Full connected first-use DAG, under the explicitly stated closed-fact model.
# Coefficients are ordered length,D0,C,constant; no digit instances are supplied.
for name,hyp in [('equation',2),('range_checked',7)]:
    # H=hyp*l; R=(8+1)l+(1+1)+D0. Add C and one proof END.
    expected=[hyp+9,1,1,4]
    ck(data['body_command_vectors'][name]==expected)

out=dict(scope='Independent formal identity, source-pin and syntax counts only; no compiled theorem or proof emission.',
 checks=checks,pins=pins,rows=rows,
 qualifications=['All ranges are proofs, not consequences of arbitrary digit equations.',
 'Internal carry derivation is not an exported premise proof.',
 'D0 counts only newly applied closed zero-argument zero-premise facts.',
 'Command/header stencils exclude setup, definitions, sharing, range adapters and actual compiled costs.'])
dest=HERE/'review_radix256_adder_syntax_20261111.json'
with dest.open('x',encoding='utf8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'receipt_sha256':hashlib.sha256(dest.read_bytes()).hexdigest().upper()}))
