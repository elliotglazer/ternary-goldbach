"""Two fixed-grid complex products per general quadratic chirp entry."""
import json
from pathlib import Path
from time import perf_counter,process_time
from flint import acb,arb,ctx

HERE=Path(__file__).resolve().parent
ctx.threads=1


def exactgrid(z,b):
    nums=[]
    for x in (z.real,z.imag):
        y=x*(1<<b)
        m=(y+arb(1)/2).floor().unique_fmpz()
        assert m is not None and abs(y-m)<arb(1)/2
        nums.append(int(m))
    return tuple(nums)


def mul(a,b,q):
    x,y=a
    v,w=b
    r=1<<(q-1)
    return (x*v-y*w+r)>>q,(x*w+y*v+r)>>q


def make(n,p,check=True):
    q=p+2*n.bit_length()+6
    ctx.prec=q+70
    cpu,wall=process_time(),perf_counter()
    unit=acb.exp_pi_i(acb(1)/n)
    ratio=exactgrid(-unit if n%2 else unit,q)
    step=exactgrid(acb.exp_pi_i(acb(2)/n),q)
    startup=[process_time()-cpu,perf_counter()-wall]
    z=(1<<q,0)
    vals=[(1<<p,0)]
    shift=q-p
    cpu,wall=process_time(),perf_counter()
    for j in range(1,n):
        z=mul(z,ratio,q)
        if j<n-1:
            ratio=mul(ratio,step,q)
        vals.append(tuple((x+(1<<(shift-1)))>>shift for x in z))
    measured=[process_time()-cpu,perf_counter()-wall]
    worst=0.
    changed=0
    if check:
        for j,v in enumerate(vals):
            exact=acb.exp_pi_i(acb((j*j+(j*n if n%2 else 0))%(2*n))/n)
            e=abs(acb(*v)-exact*(1<<p))
            assert e<1
            changed+=v!=exactgrid(exact,p)
            worst=max(worst,float(e.upper()))
    return dict(n=n,p=p,q=q,seed_cpu_wall=startup,loop_cpu_wall=measured,
                complex_multiplications=max(0,2*n-3),max_norm_grid_units=worst,
                differing_nearest_outputs=changed)


if __name__=="__main__":
    cases=[make(n,p) for n,p in [(500,307),(375,100),(4093,100),(65536,100)]]
    (HERE/"tests.json").write_text(json.dumps(cases,indent=2)+"\n")
