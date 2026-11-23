"""Measure extra projection on selected postchirped p81 rows of the production h1 fixture."""
from pathlib import Path
from statistics import median
from time import perf_counter_ns
import hashlib
import json
import platform

here = Path(__file__).resolve().parent
root = here.parent
files = [root/"c10004-full-integer"/"spectrum.tsv",
         root/"c10004-hol-shared-phase"/"phases.tsv",
         root/"c10004-full-integer"/"params.tsv"]
def integers(path):
    return [tuple(map(int, line.split())) for line in path.read_text().splitlines()]

spec, phase, (params,) = map(integers, files)
e, mask = params[-2:]
rows = []
for j, ((r,i),(p,q)) in enumerate(zip(spec,phase,strict=True)):
    parity = 1-j%2
    f,g = params[2*parity:2*parity+2]
    rows.append((p,q,f,g,e,r,i))

def amplitude(p,q,f,g,e,r,i):
    a,b = p*f-q*g,p*g+q*f
    return a*r-b*i,(abs(a)+abs(b))*e+(abs(p)+abs(q)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*e)

def run(indices):
    return [amplitude(*rows[i]) for i in indices]

all_indices = list(range(len(rows)))
for j,(v,d) in enumerate(run(all_indices)):
    assert d>=0 and abs(v)>d and ((v>0)==bool(mask>>j&1))
receipt = {"python":platform.python_version(),"files":{str(f.relative_to(root)):hashlib.sha256(f.read_bytes()).hexdigest() for f in files},
           "samples":[]}
for size in (2,32,256,len(rows)):
    selected = [j*len(rows)//size for j in range(size)]
    timer = []
    reps = max(12,9000//size)
    for _ in range(7):
        start = perf_counter_ns()
        for rep in range(reps):
            result = run(selected)
        timer.append((perf_counter_ns()-start)/(reps*size))
    receipt["samples"].append(dict(rows=size,median_elapsed_ns_per_selected_row=median(timer),
        minimum_elapsed_ns_per_selected_row=min(timer),maximum_elapsed_ns_per_selected_row=max(timer),
        max_center_bits=max(abs(v).bit_length() for v,d in result),max_radius_bits=max(d.bit_length() for v,d in result)))
def postchirp_ball(sc, z, w, coefficients):
    x,y=z
    u,v=w
    a,b=x*u,y*v
    c=(x+y)*(u+v)
    r,i=(a-b+sc//2)//sc,(c-a-b+sc//2)//sc
    return amplitude(*coefficients[:5],r,i)

receipt["pre_postchirp_tiles"] = []
archive = root/"large-terminal-signs"
for p in (24,28):
    for size in (64,256,1024):
        tag = f"even{p}n{size}"
        sc,_,bits,bad = integers(archive/(tag+"cfg.txt"))[0]
        zs,ws,cs = [integers(archive/(tag+suffix+".txt")) for suffix in ("zs","ws","abs")]
        assert len(zs)==len(ws)==len(cs)==size
        inputs = list(zip(zs,ws,cs,strict=True))
        def evaluate():
            return [postchirp_ball(sc*sc,z,w,coef) for z,w,coef in inputs]
        results = evaluate()
        certified = 0
        for j,(v,d) in enumerate(results):
            if abs(v)>d:
                assert not (bad>>j&1) and (v>0)==bool(bits>>j&1)
                certified += 1
        timings = []
        for trial in range(7):
            reps=max(8,6000//size)
            start=perf_counter_ns()
            for rep in range(reps):
                evaluate()
            timings.append((perf_counter_ns()-start)/(reps*size))
        receipt["pre_postchirp_tiles"].append(dict(tag=tag,strict_ball_sign_matched=certified,
            ball_overlaps_zero=size-certified,
            median_elapsed_ns_per_tap=median(timings)))
out = json.dumps(receipt,indent=2)
(here/"window_taps.json").write_text(out+"\n")
print(out)
