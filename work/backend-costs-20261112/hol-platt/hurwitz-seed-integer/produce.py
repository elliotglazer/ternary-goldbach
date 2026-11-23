"""Produce the existing 320-bit Hurwitz group inputs using dyadic integer arithmetic."""
from fractions import Fraction as F
from functools import lru_cache
from hashlib import sha256
from math import ceil, comb, factorial, isqrt
from pathlib import Path
from time import process_time
import json
import sys

HERE = Path(__file__).resolve().parent
PANELS = HERE.parent / "coefficient-panels"
sys.path.insert(0, str(PANELS))
from panel import seed
from seed_em import schedule
from flint import ctx

P, B = 384, 416
S, V = 1 << P, 1 << B
OUT = 1 << 320
LOG_TERMS, EXP_TERMS = 144, 96
ZERO = (0, 0)


def rnd(a, d):
    return (2*a+d)//(2*d)


def scale(z, u, v, d):
    a, b = z
    return rnd(a*u-b*v, d), rnd(a*v+b*u, d)


def log_mantissa(u, v):
    acc = 0
    for k in reversed(range(LOG_TERMS)):
        acc = rnd(V, 2*k+1) + rnd(acc*u*u, v*v)
    return rnd(2*u*acc, v)


LOG2 = log_mantissa(1, 3)


def root_and_step(A, f):
    k = A.bit_length()-f.bit_length()
    if A < (f << k):
        k -= 1
    d = f << k
    assert d <= A < 2*d and A <= 20002*f
    log_x = k*LOG2 + log_mantissa(A-d, A+d)
    t = -5*log_x
    assert abs(t) < 64*V
    acc = (V, 0)
    for n in range(EXP_TERMS, 0, -1):
        u, v = scale(acc, 0, t, 64*V*n)
        acc = V+u, v
    step = tuple(rnd(i, V//S) for i in acc)
    mag = isqrt(f*S*S//A)
    assert A*mag*mag <= f*S*S < A*(mag+1)**2
    return mag, step


def power_phase(mag, step, j):
    z = (mag, 0)
    p = step
    while j:
        if j % 2:
            z = scale(z, *p, S)
        j //= 2
        if j:
            p = scale(p, *p, S)
    return z


@lru_cache()
def bernoulli(last):
    b = [F(1)]
    for k in range(1, 2*last+1):
        b.append(-sum(comb(k+1,i)*v for i,v in enumerate(b))/(k+1))
    return [v/factorial(2*l) for l,v in enumerate(b[::2])]


def tail_factor(f, A, j, m, ell, bs):
    u, v = 64*m-32, 5*j
    den = f*(u*u+v*v)
    tx, ty = S//2 + rnd(64*S*A*u, den), rnd(-64*S*A*v, den)
    u += 64
    w = scale((S,0), f*u, f*v, 64*A)
    for l in range(1,ell+1):
        c = bs[l]
        tx += rnd(w[0]*c.numerator,c.denominator)
        ty += rnd(w[1]*c.numerator,c.denominator)
        if l < ell:
            for offset in (2*l-1, 2*l):
                w = scale(w, f*(u+64*offset), f*v, 64*A)
    return tx, ty


def needed(tasks):
    out = [0] * (len(tasks)+1)
    for m in reversed(range(len(tasks))):
        n, l = tasks[m]
        out[m] = max(out[m+1], n+int(l>0))
    return out


def coordinates(f, center, j, tasks, initial, *, radius=2, output_bits=320):
    quantum = 1 << (P - output_bits)
    needs = needed(tasks)
    rows = initial
    fac = (S,0)
    bs = bernoulli(max(l for _,l in tasks))
    seeds = []
    for m,(n,l) in enumerate(tasks):
        sx = sum(x for x,y in rows[:n])
        sy = sum(y for x,y in rows[:n])
        if l:
            w = tail_factor(f,f*(1+n)+center,j,m,l,bs)
            x,y = scale(rows[n], *w, S)
            sx += x
            sy += y
        val = scale(fac,sx,sy,S)
        seeds.append([rnd(v,quantum) for v in val])
        fac = scale(fac,-radius*(64*m+32),-radius*5*j,64*f*(m+1))
        rows = [(rnd(f*x,f*(1+i)+center),rnd(f*y,f*(1+i)+center))
                for i,(x,y) in enumerate(rows[:needs[m+1]])]
    return seeds


def envelope(f, j, tasks, *, radius=2, output_bits=320):
    h = 1+(5*j+63)//64
    bs = bernoulli(max(l for _,l in tasks))
    phase_error = 4*(2*j+1)
    fac, fac_error = F(1), F(0)
    worst = F(0)
    for m,(n,l) in enumerate(tasks):
        e = phase_error+m
        hx, he = F(n), F(n*e)
        if l:
            base = n+1
            beta = F(h+m+1,base)
            w, we = beta, F(1)
            tail, te = F(2*(n+2)+1), F(1)
            for k in range(1,l+1):
                c = abs(bs[k])
                tail += c*w
                te += 1+c*we
                if k<l:
                    for offset in (2*k-1,2*k):
                        a = F(h+m+1+offset,base)
                        w *= a
                        we = 1+a*we
            hx += tail
            he += 1+e*tail+(1+F(e,S))*te
        worst = max(worst,1+fac*he+fac_error*(hx+he/S))
        rate = F(radius*(h+m+1),f*(m+1))
        fac *= rate
        fac_error = 1+rate*fac_error
    return worst*(1 << output_bits)/S


def main():
    ctx.prec, ctx.threads = 510,1
    assert F(9,4*3**(2*LOG_TERMS+1)) < F(1,V)
    assert factorial(EXP_TERMS+1)>V
    data = HERE.parent/"guard-repricing/guard.json"
    bands = json.loads(data.read_bytes())["scenarios"]["640"]["bands"]
    degrees = (56,56,52,60,48,48)
    stats, fixtures = [], []
    for ix,(band,deg) in enumerate(zip(bands,degrees,strict=True),1):
        f, lo, hi = band["cells"]-1, band["lo"],band["hi"]
        tasks = schedule(f,hi,deg,320,2)
        maxphase = needed(tasks)[0]
        assert 4*(2*hi+1)<S and maxphase<20000
        err = envelope(f,hi-1,tasks)
        assert err < F(1,64)
        group_count = (f//16+1)*(hi-lo)
        ns = needed(tasks)
        info = dict(band=ix,lo=lo,hi=hi,grid=f,degree=deg,
                    groups_including_endpoint=group_count,phase_states_per_group=maxphase,
                    finite_terms=sum(n for n,l in tasks),scalar_steps=sum(ns[1:]),
                    corrections=sum(l for n,l in tasks),rounding_error_in_seed_ulps=float(err),
                    initial_base_pairs=(f//16+1)*maxphase,tasks=tasks)
        center = 16*((13*(f//16))//31)+8
        j = hi-1
        As = [f*(1+n)+center for n in range(maxphase)]
        t = process_time()
        bases = [root_and_step(A,f) for A in As]
        init = [power_phase(mag,step,j) for mag,step in bases]
        p = process_time()
        candidate = coordinates(f,center,j,tasks,init)
        finish = process_time()
        ref = seed(f,center,j,deg,320)
        delta = max(abs(u-v) for row,r in zip(candidate,ref,strict=True) for u,v in zip(row,r,strict=True))
        assert delta<=1
        # Test both components near the extremes and in the interior against independent phase balls.
        from flint import arb,acb
        for n in sorted(set([0,maxphase//2,maxphase-1])):
            xx = arb(As[n])/f
            true_base = (-acb(0,arb(5)/64)*xx.log()).exp()
            true = (-acb(arb(1)/2,arb(5*j)/64)*xx.log()).exp()
            assert abs(acb(*bases[n][1])-S*true_base)<2
            assert abs(acb(*init[n])-S*true)<4*(2*j+1)
        info.update(j=j,center=center,max_direct_delta=delta,init_cpu=p-t,arithmetic_cpu=finish-p)
        print(ix,maxphase,info["finite_terms"],info["corrections"],float(err),delta,flush=True)
        fixtures.append(dict(band=ix,grid=f,center=center,j=j,tasks=tasks,phases=init,seeds=candidate))
        stats.append(info)
    receipts = dict(bands=stats, phase_count=sum(r["groups_including_endpoint"]*r["phase_states_per_group"] for r in stats),
                    new_base_pairs_at_most=sum(r["initial_base_pairs"] for r in stats),
                    finite_terms=sum(r["groups_including_endpoint"]*r["finite_terms"] for r in stats),
                    corrections=sum(r["groups_including_endpoint"]*r["corrections"] for r in stats),
                    finite_scalar_steps=sum(r["groups_including_endpoint"]*r["scalar_steps"] for r in stats),
                    guard_sha256=sha256(data.read_bytes()).hexdigest())
    (HERE/"fixtures.json").write_text(json.dumps(fixtures,separators=(",",":"))+"\n")
    receipts["fixture_sha256"] = sha256((HERE/"fixtures.json").read_bytes()).hexdigest()
    (HERE/"integer.json").write_text(json.dumps(receipts,indent=2)+"\n")
    print({k:v for k,v in receipts.items() if isinstance(v,int)})


if __name__ == "__main__":
    main()
