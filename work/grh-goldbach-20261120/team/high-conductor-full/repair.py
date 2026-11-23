"""Discover extra crossings cheaply, prove each sign from the same raw polynomial, and test saturation."""
from fractions import Fraction as F
from functools import lru_cache
from hashlib import sha256
import json
from math import comb
from pathlib import Path
import sys
from time import process_time

import numpy as np
from flint import arb, ctx

from grid import GRID_BITS,HALO
from spectrum import HERE,Q,LABELS,parameters
sys.path.insert(0,str(HERE.parent/"one-character-completeness"))
from phase_ends import enclosure,SCALE

SUB = 20480
GUARDS = (320,640)
ORDER = 192
WBITS = 256


@lru_cache(None)
def weights(order, num, den):
    x = F(num,den)
    nodes = range(1-order//2,1+order//2)
    w = F(1)
    for t in list(nodes)[1:]:
        w *= (x-t)/(nodes[0]-t)
    out = [w]
    for i,t in enumerate(list(nodes)[:-1]):
        w *= -F(order-1-i,i+1)*(x-t)/(x-t-1)
        out.append(w)
    assert sum(out)==1
    return tuple(out)


def discover(raw, last):
    data = np.array([float(v)/(1<<GRID_BITS) for v in raw])
    values = np.empty((33,last))
    values[0] = data[HALO:HALO+last]
    values[32] = data[HALO+1:HALO+last+1]
    for k in range(1,32):
        kernel = [float(x) for x in weights(16,k,32)]
        values[k] = np.correlate(data[HALO-7:HALO+last+8],kernel,mode="valid")
    signs = values>0
    switches = (signs[:-1]!=signs[1:]).sum(axis=0)
    hidden = np.flatnonzero(switches>(signs[0]!=signs[-1]))
    jobs = set()
    for j in hidden:
        transitions = np.flatnonzero(signs[1:,j]!=signs[:-1,j])+1
        for lo,hi in zip(transitions,transitions[1:]):
            k = int(lo+np.argmax(np.abs(values[lo:hi,j])))
            jobs.add(int(j)*SUB+k*(SUB//32))
    # A close pair can fit entirely between adjacent 1/32 probes. Check a
    # quadratic vertex at every sampled extremum in a constant-sign cell.
    same = (switches==0)
    for k in range(1,32):
        y0,y1,y2 = values[k-1],values[k],values[k+1]
        orient = np.where(y1>0,1,-1)
        ids = np.flatnonzero(same & (orient*(y1-y0)<=0) & (orient*(y2-y1)>0))
        if len(ids)==0:
            continue
        d1 = (y2[ids]-y0[ids])/2
        d2 = y0[ids]+y2[ids]-2*y1[ids]
        good = d2!=0
        ids,d1,d2 = ids[good],d1[good],d2[good]
        shift = -d1/d2
        yv = y1[ids]+d1*shift/2
        for j,dx in zip(ids[(yv*y1[ids]<=0)&(abs(shift)<=1)],shift[(yv*y1[ids]<=0)&(abs(shift)<=1)]):
            jobs.add(int(j)*SUB+round((k+float(dx))*(SUB//32)))
    return jobs


@lru_cache(None)
def kernel(offset):
    exact = weights(ORDER,offset,SUB)
    assert sum(map(abs,exact)) < 5
    return tuple(round(w*(1<<WBITS)) for w in exact)


def rationals(meta):
    main,last,n,J,theta = parameters()
    eps = F(1,(1<<80)*4*3**theta)
    P = F(5*n,64)
    analytic = 3*eps*P/24
    # In coarse index coordinates the rth derivative has bound C*(2*pi*J/N)^r.
    # On the unit cell, the product of distances to the 2h centered nodes is at most (h!)^2.
    # The coefficient comparison from spectrum.py also verifies the inherited per-coefficient bound below.
    B = 2*F(3355725,2)**2+1
    C = (2*J+1)*B
    for line in (HERE/"coefficients.tsv").open():
        vals = list(map(int,line.split()))[1:]
        for re,im in zip(vals[::2],vals[1::2]):
            assert abs(re)+abs(im)<B*(1<<meta["bits"])
    rem = C*F(44*J,7*n)**ORDER/comb(ORDER,ORDER//2)
    sample = F(2,1<<GRID_BITS)
    return analytic, rem, sample


def rows_for(signs,l,h,main=False):
    # A strict sign on a sample infinitesimally inside neither endpoint is
    # assumed. Explicit interior samples below are included as ordinary data.
    rows = [(i,s) for i,s in signs if l<i<h]
    return [(i,j) for (i,s),(j,t) in zip(rows,rows[1:]) if s!=t]


def count(info,pair,version,main):
    a = 0 if pair==LABELS[:2] else 1
    out = []
    main = F(455*64,5)
    for extra in GUARDS:
        T,H = F(5*main,64),F(5*(main+extra),64)
        A = F(enclosure(Q,a,T,H)[1],SCALE)
        logq = (arb(Q*H.numerator)/(H.denominator*2*arb.pi())).log()
        assert logq<18 and T>50
        # Outward dyadic bounds on the two published/source allowances.
        def up(x):
            return F(int((x*(1<<32)).upper().ceil().unique_fmpz()),1<<32)
        bs = {"Rumely":up((arb(18397)+1242*logq)/10000),"moderate":F(18),
              "elementary":up(42+arb(693)/100*logq)}
        ints = [rows_for(info[l][version],0,main*SUB,True) for l in pair]
        aux = [rows_for(info[l][version],main*SUB,(main+extra)*SUB) for l in pair]
        K = sum(len(br) for br in ints)
        weight = sum((main+extra)*SUB-j for br in aux for i,j in br)
        W = F(weight*5,64*SUB)
        bounds = {k:(A-W+2*b)/(H-T)-K for k,b in bs.items()}
        out.append(dict(extra=extra,main_label_counts=[len(br) for br in ints],
                        K=K,aux=[len(br) for br in aux],W_ticks=int(weight),
                        phase_upper=str(A),allowance={k:str(v) for k,v in bs.items()},
                        U_minus_K={k:float(v) for k,v in bounds.items()},
                        exact_margin={k:str(1-v) for k,v in bounds.items()}))
    return out


def run():
    ctx.prec,ctx.threads = 160,1
    start = process_time()
    spec = json.loads((HERE/"spectrum.json").read_bytes())
    grid = json.loads((HERE/"grid.json").read_bytes())
    main,last,n,J,theta = parameters()
    analytic,rem,sample = rationals(spec)
    info = {}
    channel = []
    for row,label in zip(grid["rows"],LABELS,strict=True):
        p = HERE/("grid-%d.txt"%label)
        assert sha256(p.read_bytes()).hexdigest()==row["grid_sha256"]
        raw = list(map(int,p.read_text().splitlines()))
        assert len(raw)==last+2*HALO+1
        bound = max(map(abs,raw))
        error = analytic+rem+5*sample+F(ORDER*bound,(1<<WBITS)*(1<<GRID_BITS))
        coarse_limit = (analytic+sample)*(1<<GRID_BITS)
        assert all(abs(x)>coarse_limit for x in raw[HALO:HALO+last+1])
        coarse = [(i*SUB,1 if x>0 else -1) for i,x in enumerate(raw[HALO:HALO+last+1])]
        t0 = process_time()
        jobs = discover(raw,last)
        discovery_cpu = process_time()-t0
        target = 455*64*(SUB//5)
        edges = {1,target-1,target+1,*(target+e*SUB-1 for e in GUARDS)}
        extra = []
        edge_rows = []
        t0 = process_time()
        for at in sorted(jobs|edges):
            j,offset = divmod(at,SUB)
            assert offset
            i = j+HALO+1-ORDER//2
            center = sum(w*x for w,x in zip(kernel(offset),raw[i:i+ORDER],strict=True))
            assert abs(center) > error*(1<<(WBITS+GRID_BITS))
            (edge_rows if at in edges else extra).append((at,1 if center>0 else -1))
        verify_cpu = process_time()-t0
        # Keep edge-only separately so the contribution of interior repairs is measurable.
        info[label] = dict(coarse=coarse,edge=sorted(coarse+edge_rows),fixed=sorted(coarse+edge_rows+extra))
        with (HERE/("signs-%d.tsv"%label)).open("w",newline="\n") as f:
            for idx,s in info[label]["fixed"]:
                f.write(f"{idx}\t{s}\n")
        channel.append(dict(label=label,coarse=len(coarse),discovery_requests=len(jobs),edge_requests=len(edges),
            discovery_cpu=discovery_cpu,verification_cpu=verify_cpu,raw_error=float(error),
            min_abs_coarse=float(min(abs(v) for v in raw[HALO:HALO+last+1])/(1<<GRID_BITS))))
    results = {str(pair):{v:count(info,pair,v,main) for v in ("coarse","edge","fixed")}
               for pair in [LABELS[:2]]}
    files = [HERE/"spectrum.json",HERE/"grid.json",Path(__file__),*(HERE/("signs-%d.tsv"%l) for l in LABELS)]
    report = dict(T="455",sub=SUB,order=ORDER,remainder=float(rem),analytic_radius=float(analytic),
                  channels=channel,counts=results,total_cpu=process_time()-start,
                  sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in files})
    (HERE/"counts.json").write_text(json.dumps(report,indent=2)+"\n")
    print(channel,flush=True)
    for p,versions in results.items():
        for v,rows in versions.items():
            print(p,v,[(r["K"],r["extra"],r["U_minus_K"]) for r in rows],flush=True)


if __name__=="__main__":
    run()
