from pathlib import Path
from collections import Counter
import re,json,hashlib,sys
here=Path(__file__).resolve().parent
logs=[here/f"{x}.log" for x in sys.argv[1:]]
timings={}
for log in logs:
    for g,p,e,d in re.findall(r"^ACTUAL_GROUP (\d+) ([.\d]+) ([.\d]+) ([.\d]+)$",log.read_text(),re.M):
        timings.setdefault(int(g),[float(p),float(e),float(d)])
assert set(timings)==set(range(65)),len(timings)
seconds=[sum(values[k] for values in timings.values()) for k in range(3)]
original=(here.parents[2]/"qrh-campaign/agents/integration/guarded_residue_evaluation_frontier_20261111.json")
scenario=json.loads(original.read_bytes())["scenarios"][0]
n1=scenario["old_residue_inputs_by_band"][0]+scenario["guard_residue_inputs_by_band"][0]
stages=19*4800
res=dict(inputs=4800,anchors=1025,stages=stages,groups=len(timings),cpu_seconds=dict(zip(["prepare","kernel","decode_and_discharge"],seconds)),kernel_us_per_stage=seconds[1]*1e6/stages,total_us_per_stage=sum(seconds)*1e6/stages,band1_residue_inputs=n1,band1_required_us_per_stage_for_all_400k_core_hours=400000*3600*1e6/(19*n1),hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [*logs,here/"actual_terms.txt",here/"PackedPriceScript.sml",here/"packed.txt",original]})
(here/"actual_result.json").write_text(json.dumps(res,indent=2)+"\n")
print(json.dumps(res,indent=2))

