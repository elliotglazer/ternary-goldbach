"""Generate stock HOL4 circuits for every short axis in the large-conductor manifest."""
from collections import Counter,defaultdict
from pathlib import Path
import hashlib
import json
import random
import sys

from flint import acb,ctx

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
WORLD=HOL.parents[1]/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
P=24
S=1<<P
WIDTH=112
B=1<<WIDTH
LANES=8


def quant(x):
    v=(x*S+0.5).floor().unique_fmpz()
    if v is None:
        raise ValueError('ambiguous rounded root')
    return int(v)


def weights(n):
    cs=[]
    for i in range(n):
        w=acb.exp_pi_i(acb(2*i)/n)
        a,b=quant(w.real),quant(w.imag)
        assert abs(w*S-acb(a,b))<1
        cs.append((a,b))
    return cs


def pack(xs):
    return sum(x*B**i for i,x in enumerate(xs))


def norm_source():
    unit=pack([1]*LANES)
    rows=[f'Definition sr0_def:\n  sr0 (x:num) = x DIV {S}\nEnd\nval _=cv_auto_trans sr0_def;']
    for i in range(1,4):
        h=B**(1<<(i-1))
        rows.append(f'Definition sr{i}_def:\n  sr{i} (x:num) = sr{i-1} (x MOD {h}) + {h} * sr{i-1} (x DIV {h})\nEnd\nval _=cv_auto_trans sr{i}_def;')
    rows.append(f'Definition sr_def:\n  sr (z:int) : int = &(sr3 (Num (z+{unit*(B//2+S//2)}))) - {unit*(B//(2*S))}\nEnd\nval _=cv_auto_trans sr_def;')
    return '\n'.join(rows)+'\n'


def circuit(n,q):
    """Share signed sums and products between conjugate Fourier modes."""
    rotations=weights(n)
    bindings=[]
    names={}
    def name(expr):
        if expr not in names:
            v='t'+str(len(names))
            names[expr]=v
            bindings.append((v,expr))
        return names[expr]

    def linear(key):
        if not key:
            return '0'
        # Share a sum independently of its overall sign.
        relative=1 if key[0][0]>0 else -1
        pieces=[(v*relative,x) for v,x in key]
        s=pieces[0][1]+''.join((' + ' if sign>0 else ' - ')+x for sign,x in pieces[1:])
        expr=name(s) if len(pieces)>1 else s
        return expr if relative>0 else '(-'+expr+')'

    def sum_axis(k,coord,exact):
        factors=defaultdict(list)
        for j in range(n):
            a,b=rotations[k*j%n]
            for val,x in [(a,('x' if coord==0 else 'y')+str(j)),
                          (-b if coord==0 else b,('y' if coord==0 else 'x')+str(j))]:
                if val:
                    factors[abs(val)].append((1 if val>0 else -1,x))
        terms=[]
        for fac,group in sorted(factors.items()):
            term=linear(sorted(group,key=lambda z:z[1]))
            if not exact:
                term=name(f'{fac} * {term}') if fac!=1 else term
            terms.append(term)
        total=name(' + '.join(terms)) if len(terms)>1 else terms[0]
        return total if exact else name('sr '+total)

    included=[k for k in range(n) if q==0 or k%q!=0]
    ys=[]
    for k in included:
        exact=all(max(abs(v) for v in rotations[k*j%n])==S and min(abs(v) for v in rotations[k*j%n])==0 for j in range(n))
        ys.append('('+sum_axis(k,0,exact)+','+sum_axis(k,1,exact)+')')
    fn=f'sa{n}q{q}'
    pat=';'.join(f'(x{j},y{j})' for j in range(n))
    ret='['+';'.join(ys)+']'
    if bindings:
        ret='let '+';\n        '.join(a+' = '+b for a,b in bindings)+'\n    in '+ret
    definition=f'Definition {fn}_def:\n  {fn} (xs:(int # int) list) = case xs of\n    [{pat}] => {ret}\n  | _ => []\nEnd\nval _=cv_auto_trans {fn}_def;\n'
    return fn,definition


def workload():
    counts=defaultdict(Counter)
    for c,phi,pr,_,j,axes,_ in json.loads(WORLD.read_bytes())['conductors']:
        got,full,rem=1,1,phi
        for n,q in axes:
            rem//=n
            if n<32:
                counts[n,q][2*full*16384]+=(j+41)*got*rem
            full*=n
            got*=n if q==0 else n-n//q
        assert full==phi and got==pr
    return counts


def fixture(n,q,cap,seed):
    rng=random.Random(seed)
    rot=weights(n)
    x=[[(rng.randint(-cap*S,cap*S),rng.randint(-cap*S,cap*S)) for l in range(LANES)] for j in range(n)]
    y=[]
    for k in range(n):
        if q and k%q==0:
            continue
        out=[]
        for l in range(LANES):
            a=b=0
            for j in range(n):
                u,v=x[j][l]
                c,d=rot[k*j%n]
                a+=u*c-v*d
                b+=u*d+v*c
            assert max(abs(a),abs(b))+S < B//2
            out.append(((a+S//2)//S,(b+S//2)//S))
        y.append(out)
    conv=lambda z: [(pack([p[0] for p in row]),pack([p[1] for p in row])) for row in z]
    return conv(x),conv(y)


def main():
    ctx.prec=176
    counts=workload()
    chunks=['Theory ShortAxis\nAncestors list integer arithmetic cv_std\nLibs cv_transLib intLib\n',norm_source()]
    inputs=[]
    plans=[]
    branches=[]
    for i,((n,q),caps) in enumerate(sorted(counts.items())):
        fn,definition=circuit(n,q)
        chunks.append(definition)
        branches.append((str(i),fn))
        total=sum(caps.values())
        running=0
        for cap,num in sorted(caps.items()):
            running+=num
            if 2*running>=total: break
        # Uniform absolute bound for all possible input values as well as the representative sample.
        assert 2*n*max(caps)*S*S+S<B//2
        plans.append(dict(n=n,q=q,slices=total,minimum_capacity=min(caps),median_capacity=cap,maximum_capacity=max(caps)))
        # Two independently generated vectors per transform; first also replays exactly at the largest capacity.
        for trial in (0,1,2):
            x,y=fixture(n,q,max(caps) if trial==2 else cap,20261121+i*10+trial)
            flat=lambda z:' '.join(str(b) for pair in z for b in pair)
            inputs.append(f'{i} {n} {q} {trial}\n{flat(x)}\n{flat(y)}\n')
    dispatch=''.join(f'if mode={i} then {fn} xs else ' for i,fn in branches)+'[]'
    chunks.append(f'Definition short_def:\n  short (mode:num) xs = {dispatch}\nEnd\nval _=cv_auto_trans short_def;\n')
    chunks.append("""Definition eqall_def:
  (eqall [] ys <=> (ys:(int # int) list) = []) /\\
  (eqall (z::zs) ys <=> case ys of [] => F | w::ws => z=w /\\ eqall zs ws)
End
val _=cv_auto_trans eqall_def;
Definition loop_def:
  (loop 0 mode flag xs ex us eu = T) /\\
  (loop (SUC n) mode flag xs ex us eu =
    (eqall (if flag then short mode xs else ex) ex /\\ loop n mode flag us eu xs ex))
End
val _=cv_auto_trans loop_def;
""")
    (HERE/'ShortAxisScript.sml').write_text('\n'.join(chunks))
    (HERE/'rows.txt').write_text(''.join(inputs),newline='\n')
    (HERE/'plan.json').write_text(json.dumps(dict(lanes=LANES,width=WIDTH,bits=P,rows=plans,
        manifest_sha256=hashlib.sha256(WORLD.read_bytes()).hexdigest()),indent=2)+'\n')
    print('axes',len(plans),'positions',sum(r['n']*r['slices'] for r in plans))


if __name__=='__main__':
    main()
