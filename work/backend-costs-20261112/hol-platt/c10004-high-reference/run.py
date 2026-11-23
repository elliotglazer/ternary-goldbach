"""High-grid Hurwitz experiment, one worker. Reuse audited low-node CT and phases."""
import csv
import hashlib
import importlib.util
import json
import sys
from collections import Counter
from pathlib import Path
from time import perf_counter, process_time
from flint import acb, arb, ctx
here = Path(__file__).resolve().parent
low = here.parent/'c10004-real-transform'
sys.path.insert(0,str(low))
import reference as ct
import completed as comp
ctx.prec = 176
ctx.threads = 1
Q = 10004
S = 1 << 81


def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def nearest(v):
    x = v*S
    n = (x+arb(1)/2).floor().unique_fmpz()
    assert n is not None and abs(x-n)<arb(1)/2
    return int(n)


def run():
    units = [int(row['a']) for row in comp.read(here.parent/'c10004-reference/h1.tsv')]
    labels = [(k,l) for k in range(1,40) for l in range(1,60)]
    start,cpu = perf_counter(),process_time()
    tau = ct.tensor([acb.exp_pi_i(acb(2*a)/Q) for a in units],comp.dft)
    w = {p:z/(acb(0,1)**comp.parity(*p)*arb(Q).sqrt()) for p,z in zip(labels,tau)}
    phase = {}
    for p,z in w.items():
        if p in phase:
            continue
        partner = (40-p[0],60-p[1])
        assert abs(z).contains(1) and w[partner].overlaps(z.conjugate())
        if z.real > -arb(1)/2:
            r = ((1+z.real)/2).sqrt()
            e = acb(r,-z.imag/(2*r))
        else:
            assert z.real < arb(1)/2
            r = ((1-z.real)/2).sqrt()
            e = acb(-z.imag/(2*r),r)
        phase[p]=e
        if p!=partner:
            phase[partner]=e.conjugate()
    assert all((phase[p]**2*w[p]).contains(1) for p in labels)
    report = dict(precision=ctx.prec,threads=1,phase_wall=perf_counter()-start,phase_cpu=process_time()-cpu,nodes=[])
    signs = {}
    for j in (84198,84199):
        t = arb(j*5)/64
        s = acb(arb(1)/2,t)
        path = here/f'j{j}-source.tsv'
        node = dict(j=j,t=str(t))
        start,cpu = perf_counter(),process_time()
        xs = []
        with path.open('w',newline='') as f:
            writer = csv.writer(f,delimiter='\t',lineterminator='\n')
            writer.writerow(('index','a','re','im'))
            for i,a in enumerate(units):
                z = s.zeta(acb(arb(a)/Q))
                pair = (nearest(z.real),nearest(z.imag))
                xs.append(pair)
                writer.writerow((i,a,*pair))
        node.update(source_cpu=process_time()-cpu,source_wall=perf_counter()-start,source_sha256=digest(path))
        assert all(abs(v)<2**95 for pair in xs for v in pair)
        c = Counter()
        start,cpu = perf_counter(),process_time()
        ys = ct.tensor(xs,lambda row:ct.ct(row,True,c))
        assert all(abs(v)<2**112 for pair in ys for v in pair)
        node.update(ct_cpu=process_time()-cpu,ct_wall=perf_counter()-start)
        start,cpu = perf_counter(),process_time()
        refs = ct.tensor([(a,b,1) for a,b in xs],ct.direct_balls)
        node.update(direct_cpu=process_time()-cpu,direct_wall=perf_counter()-start)
        start,cpu = perf_counter(),process_time()
        factors = []
        for a in (0,1):
            g = (s+a)/2
            factors.append((arb.pi()*t/4).exp()*(acb(Q)/arb.pi())**g*g.gamma()*acb(Q)**(-s))
        count = Counter()
        margin = None
        maxerr = 0
        out = here/f'j{j}-completed.tsv'
        with out.open('w',newline='') as f:
            writer=csv.writer(f,delimiter='\t',lineterminator='\n')
            writer.writerow(('k41','k61','re_grid','im_grid','abs_error_grid_units','sign','scaled_real_ball'))
            for p,(x,y),(u,v,e) in zip(labels,ys,refs,strict=True):
                rad = ct.upnorm(x-u,y-v)+e
                maxerr=max(maxerr,rad)
                box = acb(arb(x,rad),arb(y,rad))/S
                val = phase[p]*factors[comp.parity(*p)]*box
                assert val.imag.contains(0)
                real = val.real
                sig = 1 if real>0 else -1 if real<0 else 0
                signs[j,p]=sig
                count[sig]+=1
                m = int((abs(real).lower()*10**12).floor().unique_fmpz())
                if margin is None or m<margin[0]:
                    margin=(m,p)
                writer.writerow((*p,x,y,rad,sig,real.str(40)))
        node.update(completion_cpu=process_time()-cpu,completion_wall=perf_counter()-start,
                    output_sha256=digest(out),max_error_grid=maxerr,signs=count,
                    min_scaled_abs_floor_1e12=margin)
        report['nodes'].append(node)
        (here/'receipt.json').write_text(json.dumps(report,indent=2)+'\n')
    report['opposite_endpoint_signs']=sum(signs[84198,p]*signs[84199,p]<0 for p in labels)
    (here/'receipt.json').write_text(json.dumps(report,indent=2)+'\n')


if __name__=='__main__':
    run()
