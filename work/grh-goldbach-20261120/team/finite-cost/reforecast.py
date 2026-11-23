"""Sensitivity to the first full-width cached arithmetic fixture; no fleet quote."""
from datetime import datetime, timedelta
from pathlib import Path
import json
import math
import statistics
import model

here=Path(__file__).resolve().parent
rows=(here/"wide262144-cache/operator01/PackedReplay.log").read_text(encoding="utf-8").splitlines()
observed=[]
for line in rows:
    if line.startswith("COVER,"):
        _,label,width,reps,ndecls,setup,nanos=line.split(",")
        observed.append(int(nanos)*1e-9/int(reps))
assert len(observed)==2
baseline=json.loads(model.SOURCE_FILES[0].read_text())
settings=json.loads((here/"results.json").read_text())["scenarios"]["planning"]["assumptions"]
deadline=datetime.fromisoformat("2026-11-21T15:00:00-08:00")
report={"scope":"Binary certificate creation+first validation under original planning assumptions; "
        "only the warmed single arithmetic-equality calibration changes. Two blocks on one workstation. "
        "Full recurring shard throughput, packaging costs and parallel production remain unvalidated.",
        "observed_seconds":observed, "mean_seconds":statistics.mean(observed),"cutoffs":{}}
baseline["lean"]["kernel_seconds_per_chunk"]=statistics.mean(observed)
for bound in [4*10**15,10**16]:
    best=min((model.workload(2**j,settings,baseline,bound) for j in model.SPAN_EXPONENTS),
             key=lambda b:b["total_cpu_hours"])
    h=best["total_cpu_hours"]
    report["cutoffs"][str(bound)]={"core_hours":h,"planned_integer_span":best["integer_span"],
        "min_equivalent_cores_29h_70pct":math.ceil(h/(29*.7)),
        "latest_start_at_70pct":{str(c):(deadline-timedelta(hours=h/(c*.7))).isoformat(timespec="minutes")
                                   for c in [4096,8192]},
        "max_price_per_allocated_core_hour_given_10k":10000*.7/h,
        "stages_core_hours":best["cpu_hours"]}
(here/"reforecast.json").write_text(json.dumps(report,indent=2)+"\n")
for b,r in report["cutoffs"].items():
    print(b,r["core_hours"],r["min_equivalent_cores_29h_70pct"],r["latest_start_at_70pct"])
