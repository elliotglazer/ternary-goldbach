"""Reconstruct Platt-family q=131071, j=5695 from the archived independent pilot."""
import csv
import hashlib
import json
import sys
from pathlib import Path
from time import process_time

from flint import acb, arb, ctx, dirichlet_char

HERE = Path(__file__).resolve().parent
PILOT = HERE.parent / "large-coarse-sign"
sys.path.insert(0, str(PILOT))
from prime_panel import nearest, phase_table, positive_dft, residues, slice_transform, source

Q, J, K0, FINAL_N = 131071, 5695, 7, 257
BITS = (24, 28, 32)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def sign(n):
    return int(n > 0) - int(n < 0)


def table(path, cols, rows):
    with path.open("w", newline="") as out:
        writer = csv.writer(out, delimiter="\t", lineterminator="\n")
        writer.writerow(cols.split())
        writer.writerows(rows)


def decisions(p, q, f, g, r, i, e):
    pf, qg = (p > 0) == (f > 0), (q > 0) == (g > 0)
    use_re = pf != qg
    c = r if use_re else i
    orientation = pf if use_re else ((p > 0) != (g > 0))
    quadrant = min(abs(p), abs(q), abs(f), abs(g)) > 1
    simple = (1 if (orientation == (c > 0)) else -1) if quadrant and abs(c) > e else 0
    a, b = p*f - q*g, p*g + q*f
    d = abs(p) + abs(q) + abs(f) + abs(g) + 2
    alternatives = set()
    if abs(a) > d and abs(r) > e:
        alternatives.add(sign(a)*sign(r))
    if abs(b) > d and abs(i) > e:
        alternatives.add(-sign(b)*sign(i))
    assert len(alternatives) <= 1
    alternate = next(iter(alternatives), 0)
    score = a*r - b*i
    err = (abs(a)+abs(b))*e + d*(abs(r)+abs(i)+2*e)
    full = sign(score) if abs(score) > err else 0
    return simple, alternate, full, quadrant, use_re


def main():
    ctx.prec, ctx.threads = 192, 1
    archive = PILOT / "prime-131071.json"
    historical = json.loads(archive.read_text())
    node = next(row for row in historical["nodes"] if row["j"] == J)
    mask = f"{int(node['reference_signs_hex'],16):b}"
    assert mask[0] == "1" and len(mask) == Q-1
    expected = [0] + [1 if b == "1" else -1 for b in mask[1:]]
    start = process_time()
    generator, rs = residues(Q)
    assert generator == historical["generator"] == 3
    n = len(rs)
    phases = phase_table(rs, Q)
    s, order, raw = source(rs, Q, J)
    ref = positive_dft(raw)
    parts = [(arb.pi()*s.imag/4).exp() * (acb(Q)/arb.pi())**((s+v)/2)
             * ((s+v)/2).gamma() * acb(Q)**(-s) for v in [0,1]]
    for k in range(1, n):
        h = phases[k]*parts[k%2]*ref[k]
        assert h.imag.contains(0) and sign(h.real) == expected[k]
    report = dict(q=Q, j=J, generator=generator, n=n, primitive=n-1, t_numerator=5*J,
                  t_denominator=64, taylor_order=order, prec=ctx.prec,
                  pilot_hash=digest(PILOT/"prime_panel.py"), transform_hash=digest(PILOT/"check.py"),
                  archive_hash=digest(archive), archived_positive=node["positive"],
                  regenerated_signs=sum(x > 0 for x in expected), archive_phase_cpu=process_time()-start)
    group_exponent = int(dirichlet_char(Q,generator).chi_exponent(generator))
    inverse = pow(group_exponent, -1, n)
    label_probes = []
    for k in [1, 2, K0, n//2, n-1]:
        label = pow(generator,k*inverse % n,Q)
        chi = dirichlet_char(Q,label)
        assert chi.conductor() == Q and chi.chi_exponent(generator) == k
        assert chi(generator).overlaps(acb.exp_pi_i(acb(2*k)/n))
        label_probes.append(dict(k=k,conrey=label,exponent=int(chi.chi_exponent(generator)),sign=expected[k]))
    report.update(conrey_generator_exponent=int(group_exponent),conrey_probes=label_probes)
    print("archive, phases and label probes OK", flush=True)
    common_grid = 1<<28
    table(HERE/"input28.tsv", "j residue re im",
          ((j, a, *nearest(z,common_grid)) for j,(a,z) in enumerate(zip(rs,raw))))
    table(HERE/"roots28.tsv", "k root_re root_im",
          ((k,*nearest(phases[k],common_grid)) for k in range(1,n)))

    m = n//FINAL_N
    weights = [acb.exp_pi_i(acb(2*K0*b)/m) for b in range(m)]
    lane = [acb.exp_pi_i(acb(2*a*K0)/n)*sum((raw[FINAL_N*b+a]*w for b,w in enumerate(weights)),acb(0))
            for a in range(FINAL_N)]
    check = positive_dft(lane)
    assert all(z.overlaps(ref[K0+m*j]) for j,z in enumerate(check))
    lane_header = "a pre_re pre_im k p q f g ref_re ref_im sign"
    lane_rows = [(a,*nearest(lane[a],common_grid), k, *nearest(phases[k],common_grid),
                  *nearest(parts[k%2],common_grid), *nearest(ref[k],common_grid),expected[k])
                 for a in range(FINAL_N) for k in [K0+m*a]]
    table(HERE/"axis257-grid28.tsv", lane_header, lane_rows)
    report.update(lane_k0=K0,lane_m=m,lane_length=FINAL_N,phase_parts_grid28=[nearest(x,common_grid) for x in parts],
                  lane_sha256=digest(HERE/"axis257-grid28.tsv"))
    print("full inputs and final 257-axis ready", flush=True)

    report["runs"]=[]
    for bits in BITS:
        step = process_time()
        scale = 1 << bits
        centers = [(*nearest(z,scale), 1) for z in raw]
        spectrum = slice_transform(centers,bits)
        cfg = [nearest(z,scale) for z in parts]
        counts = dict(simple=0, alternate=0, full=0, full_after_quadrant=0, alternate_after_quadrant=0,
                      phase_straddle=0, spectrum_straddle=0, real_column=0)
        miss, all_fail = [], []
        for k,(r,i,e) in enumerate(spectrum,1):
            p,q = nearest(phases[k],scale)
            f,g = cfg[k%2]
            simple, both, full, quadrant, use_re = decisions(p,q,f,g,r,i,e)
            assert all(x in (0,expected[k]) for x in (simple,both,full))
            counts["simple"] += bool(simple)
            counts["alternate"] += bool(both)
            counts["full"] += bool(full)
            counts["real_column"] += use_re
            if not simple:
                miss.append(k)
                counts["full_after_quadrant"] += bool(full)
                counts["alternate_after_quadrant"] += bool(both)
                counts["phase_straddle" if not quadrant else "spectrum_straddle"] += 1
                if not both and not full:
                    all_fail.append(k)
        run=dict(bits=bits, radius=spectrum[0][2], cpu=process_time()-step,counts=counts,
                 simple_misses=miss,all_unresolved=all_fail)
        report["runs"].append(run)
        (HERE/"cohort.json").write_text(json.dumps(report,indent=2)+"\n")
        print(bits,counts, "all unresolved",len(all_fail),flush=True)
    report["sha256"]={p.name:digest(p) for p in [Path(__file__),HERE/"input28.tsv",HERE/"roots28.tsv",HERE/"axis257-grid28.tsv"]}
    report["total_cpu"]=process_time()-start
    (HERE/"cohort.json").write_text(json.dumps(report,indent=2)+"\n")


if __name__ == "__main__":
    main()
