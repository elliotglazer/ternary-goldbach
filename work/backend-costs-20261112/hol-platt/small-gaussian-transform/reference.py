"""Build the conductor-10000 integer fixture and compare every primitive output to its defining sum."""
from hashlib import sha256
import json
from math import gcd, prod
from pathlib import Path
import sys
from time import process_time

from flint import acb, arb, ctx

HERE = Path(__file__).resolve().parent
FFT = HERE.parent/"small-character-kernel"
GAUSS = HERE.parent/"small-gaussian"
sys.path.insert(0,str(FFT))
from fixtures import fft, multiply
from plan import SOURCE, axis_bound, layout


def positive_root(j, n):
    return acb.exp_pi_i(acb(2*(j%n))/n)


def round_pair(value, scale):
    result = []
    for component in (value.real,value.imag):
        candidate = (component*scale+arb(1)/2).floor().unique_fmpz()
        assert candidate is not None and abs(component*scale-candidate) < arb(1)/2
        result.append(int(candidate))
    return tuple(result)


def bluestein(values, roots, chirps, kernel, scale):
    padded = [multiply(x,c,scale) for x,c in zip(values,chirps,strict=True)]+[(0,0)]*524
    fwd = fft(padded,roots,scale)
    mid = [multiply(x,c,scale) for x,c in zip(fwd,kernel,strict=True)]
    inv = fft(mid,[(a,-b) for a,b in roots],scale)
    return [multiply(x,c,scale) for x,c in zip(inv[:500],chirps,strict=True)]


def main(matched=False):
    ctx.prec,ctx.threads = 680,1
    start = process_time()
    source = GAUSS/"full.txt"
    lines = source.read_text().splitlines()
    c,m,p,qr,qi = map(int,lines[2].split())
    assert c==10000 and m==5303 and p==302
    cutoff = json.loads((FFT/"cutoff.json").read_bytes())
    row = next(r for r in cutoff["rows"] if r["c"]==c)
    dims = layout(c)[0]
    bounds = [axis_bound(d) for d in dims]
    stability = sum(a for a,_ in bounds)
    denominator = (1<<80)*4*3**row["theta"]*128*44*(2*3**33)*prod(dims)*stability*(8192**2+2)
    fft_p = (max(denominator,2*stability,max(b for _,b in bounds))-1).bit_length() if matched else p
    assert fft_p==(307 if matched else 302)
    lift = 1<<(fft_p-p)
    scale = 1<<fft_p
    flat = list(map(int,lines[3].split()))
    assert len(flat)==4*m
    table = [flat[4*i:4*i+4] for i in range(m)]
    residues = {}
    for u in range(2):
        for v in range(4):
            for w in range(500):
                a16 = (-1)**u * 5**v % 16
                a625 = pow(2,w,625)
                n = a16 + 16*((a625-a16)*pow(16,-1,625)%625)
                assert 0<n<c and gcd(n,c)==1 and n not in residues
                residues[n] = (u,v,w)
    assert len(residues)==4000
    roots = [round_pair(positive_root(i,1024),scale) for i in range(512)]
    chirp_balls = [positive_root(i*i,1000) for i in range(500)]
    chirps = [round_pair(z,scale) for z in chirp_balls]
    b = [acb(0)]*1024
    for j,z in enumerate(chirp_balls):
        b[j]=z.conjugate()
        if j:
            b[-j]=z.conjugate()
    kernel = [round_pair(z,scale) for z in acb.dft(b,inverse=True)]
    inputs_cpu = process_time()-start
    outputs = []
    labels = []
    folded = {}
    for h in range(2):
        for ell in (1,3):
            lanes = []
            for parity in range(2):
                if matched and (ell,parity) in folded:
                    lanes.append(folded[ell,parity])
                    continue
                xs = [[0,0] for _ in range(500)]
                for n,(u,v,w) in residues.items():
                    if n>m:
                        continue
                    a,d = table[n-1][2*parity:2*parity+2]
                    if matched:
                        w = (w+250*u)%500
                    rot = (2*(parity if matched else h)*u+ell*v)%4
                    x,y = ((a,d),(-d,a),(-a,-d),(d,-a))[rot]
                    xs[w][0] += lift*x
                    xs[w][1] += lift*y
                lanes.append(bluestein(xs,roots,chirps,kernel,scale))
                if matched:
                    folded[ell,parity] = lanes[-1]
            for k in range(500):
                if k%5:
                    outputs.append(lanes[(h+k)%2][k])
                    labels.append((h,ell,k))
    assert len(outputs)==len(set(labels))==1600
    transform_cpu = process_time()-start-inputs_cpu
    sched = json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    m_height = next(b[1] for b in sched["raw_metadata"] if b[0]==c)
    t = arb(2*row["theta"])/(arb(5*m_height)/64)
    z = (arb.pi()/c)*acb(t.sin(),t.cos())
    assert abs((-z).exp()*(1<<p)-acb(qr,qi)) < 1
    phases = [positive_root(i,500) for i in range(500)]
    terms = [(u,v,w,(-z*n*n).exp(),n) for n,(u,v,w) in residues.items() if n<=m]
    largest = [0,0]
    for (h,ell,k),out in zip(labels,outputs,strict=True):
        parity = (h+k)%2
        value = acb(0)
        for u,v,w,g,n in terms:
            phase = phases[(250*h*u+125*ell*v+k*w)%500]
            value += (g*n if parity else g)*phase
        error = abs(value*scale-acb(*out)).upper().ceil().unique_fmpz()
        assert error is not None and error < lift*3*m**4
        largest[parity] = max(largest[parity],int(error))
    reference_cpu = process_time()-start-inputs_cpu-transform_cpu
    def flatten(vec):
        return " ".join(str(z) for pair in vec for z in pair)
    path = HERE/("matched.txt" if matched else "actual.txt")
    inputs = [p,fft_p-p,m,qr,qi] if matched else [p,m,qr,qi]
    path.write_text("\n".join([" ".join(map(str,inputs)),*(flatten(v) for v in (roots,chirps,kernel,outputs))])+"\n",newline="\n")
    report = dict(conductor=c,frequency=0,precision=p,transform_precision=fft_p,retained_through=m,
                  primitive_labels=len(labels),terms_per_direct_sum=len(terms),
                  max_grid_units_vs_analytic_finite_sum=largest,
                  native_cpu=dict(input=inputs_cpu,integer_transform=transform_cpu,independent_direct_sums=reference_cpu),
                  sha256={f.name:sha256(f.read_bytes()).hexdigest() for f in (source,FFT/"cutoff.json",SOURCE,path)})
    (HERE/("matched.json" if matched else "reference.json")).write_text(json.dumps(report,indent=2)+"\n")
    print(report)


if __name__=="__main__":
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--matched",action="store_true",help="use the scheduled parity fold and precision lift")
    main(parser.parse_args().matched)
