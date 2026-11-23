from pathlib import Path
import json,statistics
here=Path(__file__).resolve().parent
base=here.parent
load=lambda path:json.loads(path.read_bytes())
old=load(base/"sparse-head/results.json")
two=load(here/"receipt.json")
groups=load(base/"sparse-sample-panel/panel.json")
layout={g:x["samples"]+896*x["characters"] for g,x in groups.items()}
population=sum(layout.values())
assert population==1791987359885
rows={}
def add(q,dense,ret,projection,paired,cold):
    inner=projection+paired
    rows[q]=dict(dense=dense,retained=ret,projection=projection,paired=paired,cold=cold,overhead=cold-inner,
        projection_h=projection/dense*population/3600,pair_h=paired/dense*population/3600,inner_h=inner/dense*population/3600,
        us_per_dense=inner/dense*1e6,retained_fraction=ret/dense)
add("10000",340484,71325,old["projection"]["worker"],old["compressed_total"],sum(old["process_cpu"].values()))
for q,r in two.items():
    proj=float(r["processes"]["HeadProjection"]["markers"][0].split()[-1])
    add(q,r["dense"],r["retained"],proj,r["internal_cpu"]-proj,r["cold_projection_pair_cpu"])
assert abs(rows["10000"]["inner_h"]-old["conditional_extra640_hours"])<1e-6
match={"odd composite":"7689","odd prime":"7283","v2>=3":"10000"}
def fold(k,unseen):
    return sum(w*rows[match.get(g,unseen)][k]/population for g,w in layout.items())
weighted={q:{k:fold(k,q) for k in ("projection_h","pair_h","inner_h")} for q in rows}
raw=sum(row["dense"] for row in rows.values())
pooled=sum(row["paired"]+row["projection"] for row in rows.values())/raw*population/3600
out=dict(population=population,stratum_layout=layout,rows=rows,matched_strata=match,missing_stratum_scenarios=weighted,
 pooled_by_pilot_size_hours=pooled,full_pilot_min_max_hours=[min(r["inner_h"] for r in rows.values()),max(r["inner_h"] for r in rows.values())],
 four_label_batch_startup_sensitivity={q:r["overhead"]*18477108/4/3600 for q,r in rows.items()},
 amortised_overhead_per_1000_four_label_batches_hours={q:r["overhead"]*1000/3600 for q,r in rows.items()})
(here/"three-conductor-price.json").write_text(json.dumps(out,indent=2))
print(json.dumps(out,indent=1))
