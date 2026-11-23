"""Static trees, formal polynomial identities, and length counts only.

No PA/MM0 proof or declaration is emitted. No concrete digit is enumerated.
"""
from pathlib import Path
from hashlib import sha256
import json

ROOT = Path(__file__).resolve().parents[4]
OUT = Path(__file__).with_suffix('.json')
checks = 0

def ck(b):
    global checks
    assert b
    checks += 1

def atom(s): return (s,)
def op(s, *a): return (s, *a)
def add(a,b): return op('+',a,b)
def mul(a,b): return op('*',a,b)
def eq(a,b): return op('=',a,b)
def lt(a,b): return op('<',a,b)
def And(a,b): return op('/\\',a,b)
def bit(e,a): return op('b'+str(e),a)
zero,one = atom('0'),atom('d1')
beta = one
for _ in range(8): beta=bit(0,beta)
def var(s): return atom(s)
def size(t): return 1+sum(size(a) for a in t[1:])
def edges(t): return len(t)-1+sum(edges(a) for a in t[1:])
def state(x,Y,l,P,A):
    return And(eq(add(l,mul(P,A)),mul(x,Y)),And(lt(A,x),And(lt(l,P),lt(zero,P))))

x,x0,y,y0,z,z0,L,P,d,T,U,Z,A,S,D,c = map(var,
    ['x','x0','y','y0','z','z0','L','P','d','T','U','Z','A','S','D','c'])
sig={}
def signature(name,a,prem,con):
    h=len(prem)
    sig[name]={'args':a,'premises':h,'header':sum(size(q) for q in prem)+size(con)+h+1,
        'cached_call':a+h+2,'fresh_call':a+h+size(con)+1,
        'conclusion_constructor_edges':edges(con),'HR':a+h+1}
    ck(size(con)==edges(con)+1)

signature('reflexive',1,[],eq(T,T))
signature('zero_word_step',1,[eq(T,zero)],eq(add(mul(beta,T),zero),zero))
signature('initial_carry_transport',2,[state(x,zero,zero,one,zero),eq(A,zero)],state(x,zero,zero,one,A))
signature('concat_start',1,[],eq(add(zero,mul(one,Z)),Z))
signature('concat_step',5,[eq(add(L,mul(P,add(mul(beta,T),d))),Z)],
    eq(add(add(L,mul(P,d)),mul(mul(P,beta),T)),Z))
signature('concat_finish',3,[eq(add(L,mul(P,zero)),Z)],eq(L,Z))
signature('positive_transport',2,[eq(x0,x),lt(zero,x0)],lt(zero,x))
signature('final_transport',6,[eq(x0,x),eq(y0,y),eq(z,z0),eq(mul(x,y),z)],eq(mul(x0,y0),z0))
signature('padded_inner_base',2,[],eq(add(add(mul(zero,y),zero),c),add(mul(beta,zero),c)))
signature('bit_affine_start',1,[],eq(T,add(mul(one,T),zero)))
for e in (0,1):
    signature('bit_affine_'+str(e),4,[eq(S,add(mul(P,T),D))],eq(bit(e,S),add(mul(bit(0,P),T),bit(e,D))))
    signature('bit_congruence_'+str(e),2,[eq(T,U)],eq(bit(e,T),bit(e,U)))
    signature('bit_range_'+str(e),2,[lt(D,P)],lt(bit(e,D),bit(0,P)))
signature('byte_glue',4,[eq(S,add(mul(beta,T),d)),eq(T,U)],eq(S,add(mul(beta,U),d)))
signature('zero_bit_step',1,[eq(T,zero)],eq(bit(0,T),zero))
signature('symmetry',2,[eq(T,U)],eq(U,T))
signature('transitivity',3,[eq(S,T),eq(T,U)],eq(S,U))
signature('positive_b0',1,[lt(zero,T)],lt(zero,bit(0,T)))
signature('positive_b1',1,[],lt(zero,bit(1,T)))

# Formal commutative-polynomial identities. Variables are symbols, never digits.
def plus(a,b):
    out=dict(a)
    for k,v in b.items(): out[k]=out.get(k,0)+v
    return {k:v for k,v in out.items() if v}
def times(a,b):
    out={}
    for k,v in a.items():
        for l,w in b.items():
            q=tuple(sorted(k+l));out[q]=out.get(q,0)+v*w
    return out
def sym(s):return {(s,):1}
def const(n):return {():n} if n else {}
B,p,t,l,dd,s = map(sym,['B','p','t','l','d','s'])
ck(plus(l,times(p,plus(times(B,t),dd)))==plus(plus(l,times(p,dd)),times(times(p,B),t)))
ck(plus(plus(times(const(0),s),const(0)),t)==plus(times(B,const(0)),t))
for e in (0,1):
    lhs=plus(times(const(2),plus(times(p,t),dd)),const(e))
    rhs=plus(times(times(const(2),p),t),plus(times(const(2),dd),const(e)))
    ck(lhs==rhs)

# Small formal length cases check the AST endpoint, not arithmetic digit values.
def word(ds,tail=zero):
    for q in reversed(ds):tail=add(mul(beta,tail),q)
    return tail
for m in range(1,17):
    ds=[var('d'+str(j)) for j in range(m)]
    # Outgoing carry after removing the row's low digit has exactly m places.
    top=add(mul(beta,zero),var('c_top'))
    Bout=word(ds[1:],top)
    ck(Bout==word(ds[1:]+[var('c_top')]))
    for n in range(1,17):
        ys=[var('y'+str(i)) for i in range(n)]
        lows=[var('r'+str(i)) for i in range(n)]
        PP=one;YY=zero;LL=zero
        for yi,di in zip(ys,lows):
            YY=add(YY,mul(PP,yi));LL=add(LL,mul(PP,di));PP=mul(PP,beta)
        ck(PP[0]=='*' and PP[2]==beta)
        ck(word(lows,Bout)==word(lows+ds[1:]+[var('c_top')]))
        counts={'reflexive':3*(n-1)+1,'zero_word_step':m,'initial_carry_transport':1,
            'concat_start':2,'concat_step':2*n,'concat_finish':1,'positive_transport':1,'final_transport':1}
        V=sum(counts.values())
        H=sum(sig[k]['premises']*v for k,v in counts.items())
        HR=sum(sig[k]['HR']*v for k,v in counts.items())
        C=sum(sig[k]['conclusion_constructor_edges']*v for k,v in counts.items())
        ck(V==5*n+m+4)
        ck(H==2*n+m+9)
        ck(HR==20*n+3*m+26)
        # Term preconstruction reserve is intentionally charged even if shared.
        reserve=10*n+4*m+4*n*(m+1)
        ck(HR+C+reserve==4*m*n+21*m+80*n+62)

binary_names=['reflexive','bit_affine_start','bit_affine_0','bit_affine_1',
    'bit_congruence_0','bit_congruence_1','byte_glue','zero_bit_step','symmetry','transitivity']
ck(max(sig[k]['HR'] for k in binary_names)<=7)
ck(max(sig[k]['conclusion_constructor_edges'] for k in binary_names)<=16)
for length in range(1,65):
    ck(23*(26*length+8)+24*length+16==622*length+200)
    # 8-bit source grammar with high padding; symbolic count upper bound only.
    for r in range(1,9):
        ck(8*length+2 + 8*length+2 + 10*length+1 + 2 <=26*length+8)
ck(max(sig[k]['HR']+sig[k]['conclusion_constructor_edges'] for k in ['positive_b0','positive_b1'])<=6)

paths=[
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/REVIEW_PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md',
 'work/qrh-campaign/agents/prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md',
 'work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md',
 'work/mm0-efficient/toolchain-sources/examples__peano.mm1',
 'work/formal-goldbach-bench/mm0/src/mmb.md',
 'work/formal-goldbach-bench/mm0/src/verifier.c',
]
pins=[]
for path in paths:
    data=(ROOT/path).read_bytes()
    pins.append({'path':path,'sha256':sha256(data).hexdigest().upper(),'bytes':len(data)})
out={'scope':'static syntax and formal polynomial identities; no proof emission or concrete digit arithmetic',
 'checks':checks,'signatures':sig,
 'binding_V':'5n+m+4','binding_H':'2n+m+9','binding_HR':'20n+3m+26',
 'binding_HR_C_upper':'4mn+21m+80n+62',
 'binary_decoder_HR_C_upper_per_length':'622L+200',
 'positive_producer_HR_C_upper':'48m+6',
 'three_binary_lengths':'m,n,m+n',
 'full_binding_HR_C_upper':'4mn+1313m+1324n+668',
 'source_pins':pins}
with OUT.open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'output':str(OUT),'sha256':sha256(OUT.read_bytes()).hexdigest().upper()}))
