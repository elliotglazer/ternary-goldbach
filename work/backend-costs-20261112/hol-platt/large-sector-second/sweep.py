"""Measure the same cutoff at the other five full archived conductor-131071 nodes."""
import json
from time import process_time

from cohort import (BITS, HERE, J, PILOT, Q, acb, arb, ctx, decisions, digest,
                    nearest, phase_table, residues, slice_transform, source)


def main():
    ctx.prec, ctx.threads = 192, 1
    archive = PILOT/"prime-131071.json"
    nodes = json.loads(archive.read_text())["nodes"]
    _, rs = residues(Q)
    phase = phase_table(rs,Q)
    phase_int = {p:[nearest(z,1<<p) for z in phase[1:]] for p in BITS}
    report = dict(archive_hash=digest(archive),nodes=[])
    for node in nodes:
        j = node["j"]
        if j == J:
            continue
        start = process_time()
        mask = f"{int(node['reference_signs_hex'],16):b}"
        assert len(mask) == Q-1 and mask[0] == "1"
        s, _, raw = source(rs,Q,j)
        parts = [(arb.pi()*s.imag/4).exp()*(acb(Q)/arb.pi())**((s+v)/2)
                 *((s+v)/2).gamma()*acb(Q)**(-s) for v in [0,1]]
        rows = []
        for p in BITS:
            scale = 1<<p
            cfg = [nearest(z,scale) for z in parts]
            spectrum = slice_transform([(*nearest(z,scale),1) for z in raw],p)
            counts = dict(omitted=0, alternate_repairs=0, full_repairs=0,
                          phase_straddle=0, all_unresolved=0, full_unresolved=0)
            for k,((x,y,e),(u,v)) in enumerate(zip(spectrum,phase_int[p],strict=True),1):
                q, alt, full, quadrant, _ = decisions(u,v,*cfg[k%2],x,y,e)
                expected = 1 if mask[k] == "1" else -1
                assert all(z in (0,expected) for z in (q,alt,full))
                counts["omitted"] += not q
                counts["alternate_repairs"] += bool(alt) and not q
                counts["full_repairs"] += bool(full) and not q
                counts["phase_straddle"] += not quadrant
                counts["all_unresolved"] += not (q or alt or full)
                counts["full_unresolved"] += not full
            rows.append(dict(bits=p,**counts))
        report["nodes"].append(dict(j=j,sign_count=node["sign_count"],rows=rows,cpu=process_time()-start))
        (HERE/"sweep.json").write_text(json.dumps(report,indent=2)+"\n")
        print(j, [(r["bits"],r["omitted"],r["all_unresolved"]) for r in rows],flush=True)


if __name__ == "__main__":
    main()
