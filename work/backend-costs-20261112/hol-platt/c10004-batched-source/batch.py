"""Single-threaded low-height Hurwitz sources via 16 Taylor cells and a shared head."""
import csv
import hashlib
import json
from pathlib import Path
from time import perf_counter, process_time
from flint import acb, arb, ctx
import flint

HERE = Path(__file__).resolve().parent
Q = 10004
P = 81
ctx.prec = 176
ctx.threads = 1


def timer():
    return perf_counter(), process_time()


def elapsed(start):
    return dict(zip(("wall_seconds","cpu_seconds"),[a-b for a,b in zip(timer(),start)]))


def round_coord(x):
    scaled = x*(1<<P)
    candidate = (scaled+arb(1)/2).floor().unique_fmpz()
    assert candidate is not None and abs(scaled-candidate)<arb(1)/2
    return int(candidate)


def coefficients(s, centers):
    factors = [acb(1)]
    for k in range(20):
        factors.append(-factors[-1]*(s+k)/(k+1))
    return [[f*(s+k).zeta(1+center) for k,f in enumerate(factors)] for center in centers]


def main():
    started = timer()
    centers = [arb(2*j+1)/32 for j in range(16)]
    bound = (arb(5)/3)*(arb(1)/32)**21/(1-arb(1)/32)
    radius = arb(0,bound.upper())
    assert radius.contains(bound) and radius.contains(-bound)
    widen = acb(radius,radius)
    rows = []
    for i in range(4800):
        a = (2501*(1+2*(i%2))+4880*pow(6,(i//2)%40,41)+2624*pow(2,i//80,61))%Q
        cell = (16*a)//Q
        alpha = arb(a)/Q
        delta = alpha-centers[cell]
        assert abs(delta)<=arb(1)/32
        rows.append((a,cell,delta,acb(alpha.rsqrt()),acb(0,-5*alpha.log()/64).exp()))
    result = dict(ctx_prec=ctx.prec,threads=ctx.threads,python_flint=flint.__version__,
                  source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  tail_enclosure=str(bound),initialization=elapsed(started),heights=[])
    for h in (1,2):
        begin = timer()
        coeffs = coefficients(acb(arb(1)/2,arb(5*h)/64),centers)
        coeff_cost = elapsed(begin)
        node_begin = timer()
        entries = []
        for i,(a,cell,delta,prev,step) in enumerate(rows):
            head = prev*step
            rows[i] = (a,cell,delta,head,step)
            poly = coeffs[cell][-1]
            for k in range(19,-1,-1):
                poly = poly*delta+coeffs[cell][k]
            z = head + poly + widen
            entries.append((i,a,round_coord(z.real),round_coord(z.imag)))
        node_cost = elapsed(node_begin)
        path = HERE.parent/"c10004-reference"/f"h{h}.tsv"
        raw = path.read_bytes()
        expected = [tuple(map(int,row)) for row in csv.reader(raw.decode().splitlines()[1:],delimiter="\t")]
        assert entries == expected and len(entries)==4800
        result["heights"].append(dict(h=h,coefficient_setup=coeff_cost,residue_evaluation=node_cost,
                                      matching_rows=len(entries),reference_sha256=hashlib.sha256(raw).hexdigest()))
    result["inclusive_wall_cpu"]=elapsed(started)
    (HERE/"receipt.json").write_text(json.dumps(result,indent=2)+"\n")


if __name__ == "__main__":
    main()
