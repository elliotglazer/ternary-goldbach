from pathlib import Path
import json,hashlib
here=Path(__file__).resolve().parent
three=json.loads((here/"three-conductor-price.json").read_text())
p=three["population"]
out={}
for q,r in three["rows"].items():
    prefix="Grouped" if q=="10000" else "Fused"
    modes={}
    for mode in ["Baseline","Margins"]:
        d=here/q
        keys=[k for k in sorted(d.glob("f*"+prefix+mode+".status")) if k.read_text().strip()=="0" and "FUSED_WORKER " in k.with_suffix(".log").read_text()]
        k=keys[-1]; log=k.with_suffix(".log").read_text()
        workers=[float(l.split()[1]) for l in log.splitlines() if l.startswith("FUSED_WORKER ")]
        secs=sum(float(l.split()[2]) for l in log.splitlines() if l.startswith("FUSED_CHANNEL "))
        modes[mode]=dict(worker=workers[-1],raw_input=secs,log=k.with_suffix(".log").name,hash=hashlib.sha256(k.with_suffix(".log").read_bytes()).hexdigest())
    delta=modes["Margins"]["worker"]-modes["Baseline"]["worker"]
    out[q]=dict(modes=modes,delta_s=delta,delta_h=delta*p/r["dense"]/3600,explicit_h=(modes["Margins"]["worker"]+r["projection"])*p/r["dense"]/3600,
     baseline_aligned_h=r["inner_h"]+delta*p/r["dense"]/3600)
w=three["stratum_layout"]
match=dict(three["matched_strata"],**{"v2=2":"10000"})
s={k:sum(w[g]*out[q][k]/p for g,q in match.items()) for k in ["delta_h","explicit_h","baseline_aligned_h"]}
(here/"grouped-price.json").write_text(json.dumps(dict(rows=out,weighted=s),indent=2))
print(json.dumps(dict(rows=out,weighted=s),indent=1))
