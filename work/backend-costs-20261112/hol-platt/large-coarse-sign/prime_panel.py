"""Check complete low/high nodes of a prime conductor with an independent Arb DFT."""
import hashlib
import json
import sys
from fractions import Fraction
from pathlib import Path
from time import process_time

from flint import acb, arb, ctx, fmpz

from check import nearest, slice_transform

HERE = Path(__file__).resolve().parent


def residues(q):
    assert fmpz(q).is_prime()
    n=q-1
    factors=[int(p) for p,_ in fmpz(n).factor()]
    g=next(g for g in range(2,q) if all(pow(g,n//p,q)!=1 for p in factors))
    rs=[1]
    for _ in range(1,n):
        rs.append((rs[-1]*g)%q)
    assert len(set(rs))==n and (g*rs[-1])%q==1
    return g,rs


def positive_dft(xs):
    # FLINT uses a minus sign in the forward transform. Complex conjugation
    # on both sides preserves the input signs and leaves the sum unnormalized.
    return [v.conjugate() for v in acb.dft([x.conjugate() for x in xs])]


def phase_table(rs,q):
    n=len(rs)
    gauss=positive_dft([acb.exp_pi_i(acb(2*a)/q) for a in rs])
    phases=[None]*n
    for k in range(1,n):
        if phases[k] is not None:
            continue
        w=gauss[k]/(acb(0,1)**(k%2)*arb(q).sqrt())
        other=gauss[n-k]/(acb(0,1)**(k%2)*arb(q).sqrt())
        assert w.conjugate().overlaps(other) and abs(w).contains(1)
        if w.real > -arb(1)/2:
            r=((1+w.real)/2).sqrt()
            z=acb(r,-w.imag/(2*r))
        else:
            r=((1-w.real)/2).sqrt()
            z=acb(-w.imag/(2*r),r)
        assert (z*z*w).contains(1)
        phases[k]=z
        if k!=n-k:
            phases[n-k]=z.conjugate()
    return phases


def source(rs,q,j):
    cells = 64
    t=arb(5*j)/64
    s=acb(arb(1)/2,t)
    height = (5*j+63)//64 + 1
    bound=Fraction(1)
    for k in range(1,256):
        bound *= Fraction(height+k-1,2*cells*k)
        ratio=Fraction(height+k,2*cells*(k+1))
        # |zeta(s+k,1+b)| <= 1+1/(k-1/2) <= 2 for k>=2.
        if k>=2 and ratio<1 and 2*bound/(1-ratio)<Fraction(1,1<<100):
            break
    else:
        raise ValueError("Taylor order")
    centers=[arb(2*i+1)/(2*cells) for i in range(cells)]
    factors=[acb(1)]
    for i in range(k-1):
        factors.append(-factors[-1]*(s+i)/(i+1))
    polynomials=[[f*(s+i).zeta(1+c) for i,f in enumerate(factors)] for c in centers]
    eps=arb(0,arb(2)**-100)
    widen=acb(eps,eps)
    out=[]
    for a in rs:
        cell=cells*a//q
        alpha=arb(a)/q
        d=alpha-centers[cell]
        terms=polynomials[cell]
        z=terms[-1]
        for f in reversed(terms[:-1]):
            z=z*d+f
        out.append(acb(alpha)**(-s)+z+widen)
    for i in (0,len(rs)//5,len(rs)//2,len(rs)-1):
        assert out[i].overlaps(s.zeta(arb(rs[i])/q))
    return s,k,out


def main(q, nodes):
    ctx.prec,ctx.threads=192,1
    g,rs=residues(q)
    phases=phase_table(rs,q)
    # Independent check of the sign convention for the positive Fourier transform.
    probe=positive_dft([acb(0),acb(1),acb(0),acb(0)])
    assert probe[1].contains(acb(0,1))
    nodes_out=[]
    path=HERE/f"prime-{q}.json"
    for j in nodes:
        start=process_time()
        s,order,raw=source(rs,q,j)
        refs=positive_dft(raw)
        parts=[(arb.pi()*s.imag/4).exp()*(acb(q)/arb.pi())**((s+a)/2)*
               ((s+a)/2).gamma()*acb(q)**(-s) for a in (0,1)]
        fs=[v*parts[k%2] for k,v in enumerate(phases[1:],1)]
        reference=[]
        for k,f in enumerate(fs,1):
            z=f*refs[k]
            assert z.imag.contains(0) and (z.real>0 or z.real<0)
            reference.append(1 if z.real>0 else -1)
        tests=[]
        for p in (20,24,28,32):
            grid=1<<p
            inputs=[(*nearest(z,grid),1) for z in raw]
            ys=slice_transform(inputs,p)
            unresolved=[]
            for k,((a,b,e),f,sign) in enumerate(zip(ys,fs,reference,strict=True),1):
                bounded=f*acb(arb(a,e),arb(b,e))/grid
                assert bounded.imag.contains(0)
                sg=int(bounded.real>0)-int(bounded.real<0)
                if sg:
                    assert sg==sign
                else:
                    unresolved.append(k)
            tests.append(dict(bits=p,unresolved=len(unresolved),modes=unresolved,radius=ys[0][2]))
        record=dict(j=j,taylor_order=order,sign_count=len(reference),positive=reference.count(1),
                    reference_signs_hex=int('1'+''.join('1' if s>0 else '0' for s in reference),2).to_bytes(
                        (len(reference)+8)//8,'big').hex(),tests=tests,cpu=process_time()-start)
        nodes_out.append(record)
        path.write_text(json.dumps(dict(q=q,generator=g,requested=nodes,nodes=nodes_out,
                             script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()),indent=2)+"\n")
        print(q,j,[(r["bits"],r["unresolved"]) for r in tests],flush=True)


if __name__=="__main__":
    main(int(sys.argv[1]),list(map(int,sys.argv[2:])))
