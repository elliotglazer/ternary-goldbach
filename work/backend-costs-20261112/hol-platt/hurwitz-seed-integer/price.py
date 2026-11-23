"""Price the integer verification of seeds on the six guarded source intervals."""
from collections import defaultdict
from hashlib import sha256
from pathlib import Path
from statistics import median
import json
import sys

HERE=Path(__file__).resolve().parent


def results(label):
    assert label.isalnum()
    assert (HERE/(label+".status")).read_text().strip()=="0"
    lines=(HERE/(label+".log")).read_text().splitlines()
    ready=None
    records=[]
    for line in lines:
        row=line.split()
        if not row:
            continue
        if row[0]=="JOIN_EVAL":
            ready=[float(x.replace("~","-")) for x in row[1:]]
        if row[0] in ("SEED_REPLAY","PHASE"):
            assert len(ready)==3
            records.append((row,ready))
            ready=None
    return lines,records


def main(cases,phases):
    c_lines,cs=results(cases)
    p_lines,ps=results(phases)
    assert "SEED_CASES_DONE" in c_lines and "SEED_PHASES_DONE" in p_lines
    grouped=defaultdict(list)
    for r,parts in cs:
        grouped[int(r[1])].append([parts[1],sum(parts)])
    admission={int(q[1]):float(q[2]) for s in c_lines if (q:=s.split()) and q[0]=="ADMISSION"}
    phase_times={r[1]:parts for r,parts in ps}
    workload=json.loads((HERE/"integer.json").read_bytes())
    rows=[]
    for b in workload["bands"]:
        i=b["band"]
        assert len(grouped[i])==3
        g=b["groups_including_endpoint"]
        steps=g*b["phase_states_per_group"]-b["initial_base_pairs"]
        base_pairs=b["initial_base_pairs"]
        hi=min(1024,b["hi"]-b["lo"]-1)
        def run_at(n):
            return median(phase_times[f"march{i}_{n}_{r}"][1] for r in (1,2,3))
        step_s=(run_at(hi)-run_at(128))/(hi-128)
        assert step_s>0
        init=phase_times[f"base{i}"][1]+phase_times[f"start{i}"][1]
        core=median(x[0] for x in grouped[i])
        stage=median(x[1] for x in grouped[i])
        rows.append(dict(band=i,groups=g,steps=steps,base_pairs=base_pairs,
                         group_kernel_seconds=core,group_staged_seconds=stage,
                         input_admission_seconds=admission[i],phase_update_seconds=step_s,
                         new_base_setup_seconds=init,group_kernel_core_hours=core*g/3600,
                         group_staged_core_hours=stage*g/3600,group_literal_core_hours=admission[i]*g/3600,
                         phase_core_hours=step_s*steps/3600,phase_setup_hours=init*base_pairs/3600))
    total={k:sum(r[k] for r in rows) for k in ("group_kernel_core_hours","group_staged_core_hours","group_literal_core_hours","phase_core_hours","phase_setup_hours")}
    total["arithmetic_plus_phase_hours"]=total["group_kernel_core_hours"]+total["phase_core_hours"]+total["phase_setup_hours"]
    files=["integer.json","cases.txt","phase-cases.txt",cases+".log",phases+".log","SeedReplayScript.sml","SeedCasesScript.sml","SeedPhasesScript.sml","seedbench.sml"]
    out=dict(bands=rows,total=total,hashes={p:sha256((HERE/p).read_bytes()).hexdigest() for p in files},
             scope="Includes one full degree group at the single endpoint in each band. The row check works on the existing 320-bit seed interface. Its standalone admission of a complete literal phase pool at every height is redundant if adjacent heights are fused; that separate sensitivity is retained. The scalar loop measures recurrent phase arithmetic. Full transport between recurrence and a height batch and the general analytic theorem are separate. Existing native coefficient generation and 16-cell polynomial translation are already in the previous ledger.")
    (HERE/"price.json").write_text(json.dumps(out,indent=2)+"\n")
    print(total)


if __name__=="__main__":
    main(*sys.argv[1:])
