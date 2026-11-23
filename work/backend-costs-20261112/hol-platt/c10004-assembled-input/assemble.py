"""Assemble actual h1 raw heads and mixed-P20 centers on the priced p81 grid."""

import argparse
import csv
import hashlib
import json
import sys
from collections import Counter
from pathlib import Path
from time import process_time

from flint import acb, arb, ctx


HERE = Path(__file__).resolve().parent
HOL = HERE.parent
sys.path.insert(0,str(HOL / "c10004-p20-source"))
from produce import dyadic, nearest, to_ball
sys.path.insert(0,str(HOL / "c10004-real-transform"))
from reference import ct, tensor


def read(path):
    with path.open() as f:
        return list(csv.DictReader(f,delimiter="\t"))


def run(use_state):
    ctx.prec = 200
    ctx.threads = 1
    when = process_time()
    s = acb(arb(1)/2,arb(5)/64)
    source_path = HOL / "c10004-reference/h1.tsv"
    shift_path = HOL / "c10004-p20-source/h1-horner.json"
    spec_path = HOL / "c10004-real-transform/h1-spectrum.tsv"
    direct_rows, shifts = read(source_path), json.loads(shift_path.read_bytes())
    xs = []
    delta, delta_spectrum = Counter(), Counter()
    largest = arb(0)
    raw_path = HOL/"c10004-p20-source/h1-rawhead.tsv"
    raw = read(raw_path) if use_state else []
    if use_state and len(raw)!=4800:
        raise ValueError("raw state count")
    stem = "h1-state" if use_state else "h1"
    heads = HERE/f"{stem}-heads.tsv"
    with heads.open("w",encoding="ascii",newline="") as f:
        w = csv.writer(f,delimiter="\t",lineterminator="\n")
        w.writerow(["index","a","cell","head_re100","head_im100","assembled_re81","assembled_im81"])
        for i,(row,data) in enumerate(zip(direct_rows,shifts,strict=True)):
            idx,a,k,u,v = data
            if i != idx or int(row["index"])!=idx or int(row["a"])!=a:
                raise ValueError("source order disagrees")
            x = arb(a)/10004
            if use_state:
                item=raw[i]
                if idx!=int(item["index"]) or a!=int(item["a"]):
                    raise ValueError("raw state order")
                head=(int(item["re"]),int(item["im"]))
            else:
                head = dyadic(x**(-s),100)
            z = tuple(nearest(h+(q<<6),1<<19) for h,q in zip(head,(u,v)))
            error = abs(s.zeta(x)-to_ball(z,81)) * (1<<81)
            if not error < 1:
                raise ValueError("assembled source outside one grid unit")
            if error.upper()>largest:
                largest=error.upper()
            delta[max(abs(z[0]-int(row["re"])),abs(z[1]-int(row["im"])))] += 1
            xs.append(z)
            w.writerow([idx,a,k,*head,*z])
    if len(xs)!=4800:
        raise ValueError("source count")
    ys = tensor(xs,lambda row:ct(row,True,Counter()))
    original = read(spec_path)
    guard_path=HOL/"c10004-hol-fused/h1-guards.tsv"
    guards=[tuple(map(int,line.split())) for line in guard_path.read_text().splitlines()]
    if len(guards)!=2301:
        raise ValueError("guard count")
    new_spectra = HERE/f"{stem}-spectrum.tsv"
    radii=[]
    with new_spectra.open("w",encoding="ascii",newline="") as f:
        w = csv.writer(f,delimiter="\t",lineterminator="\n")
        w.writerow(["k41","k61","re","im","abs_error_grid_units"])
        for i,((x,y),r) in enumerate(zip(ys,original,strict=True)):
            if (int(r["k41"]),int(r["k61"])) != (1+i//59,1+i%59):
                raise ValueError("spectrum order disagrees")
            dx,dy=x-int(r["re"]),y-int(r["im"])
            delta_spectrum[max(abs(dx),abs(dy))]+=1
            radius=int(r["abs_error_grid_units"])+abs(dx)+abs(dy)
            radii.append(radius)
            w.writerow([1+i//59,1+i%59,x,y,radius])
    radius=max(radii)
    margins=[sign*(u*x-v*y) - (abs(u)+abs(v))*radius-abs(x)-abs(y)-2*radius
             for (x,y),(u,v,_,sign) in zip(ys,guards,strict=True)]
    if min(margins)<=0:
        raise ValueError("an expected sign failed under the global radius")
    paths = [source_path, shift_path, spec_path, heads, new_spectra,guard_path]
    if use_state:
        paths.append(raw_path)
    return dict(source_pairs=len(xs),source_coordinate_delta_histogram=delta,
                max_complex_source_error_in_p81_units=str(largest),
                spectra=len(ys),spectrum_coordinate_delta_histogram=delta_spectrum,
                head_source="integer raw state" if use_state else "direct Arb",
                global_spectrum_grid_radius=radius, strict_signs=len(margins),
                min_scaled_sign_margin_floor_1e12=min(margins)*10**12//2**162,
                cpu_seconds=process_time()-when,
                sha256={str(p.relative_to(HOL)):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths})


if __name__ == "__main__":
    parser=argparse.ArgumentParser()
    parser.add_argument("--state-head",action="store_true")
    print(json.dumps(run(parser.parse_args().state_head),indent=2))
