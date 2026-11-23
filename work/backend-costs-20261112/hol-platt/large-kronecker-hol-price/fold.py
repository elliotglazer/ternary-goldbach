from pathlib import Path
from collections import defaultdict
import json,sys,statistics,hashlib
here=Path(__file__).resolve().parent
cases=json.loads((here/"cases.json").read_bytes())+json.loads((here/"wide.json").read_bytes())
panel=json.loads((here.parent/"large-kronecker-price/native-panel.json").read_bytes())
scope=json.loads((here.parent/"large-kronecker-price/price.json").read_bytes())["scenarios"]["0"]
times=defaultdict(lambda:defaultdict(list))
for stem in sys.argv[1:]:
    for line in (here/(stem+".log")).read_text().splitlines():
        if line.startswith("PANEL "):
            _,n,p,c,w,r,*ts=line.split()
            times[tuple(map(int,[n,p,c,w]))][int(r)].append(list(map(lambda t:float(t.replace("~","-")),ts)))
out=[];sums=defaultdict(float)
for case in cases:
    key=tuple(case[k] for k in ("n","p","cap","lane_bytes"))
    runs=times[key];n,p,c,w=key
    reps=4 if len(runs[4])>=2 else 2
    if len(runs[0])<2 or len(runs[reps])<2:continue
    base=sum(a[1] for a in runs[0][-2:])/2
    warm=[(a[1]-base)/reps for a in runs[reps][-2:]]
    rate=statistics.mean(warm);assert rate>0
    count=case["matched_slices"]
    edge=panel[str((n-1).bit_length())]["median_wall"]
    out.append(dict(n=n,p=p,cap=c,lane=w,count=count,setup=base,kernel_resident=rate,replicate_slopes=warm,first_kernel=runs[1][-1][1],same_input_native_wall=case["native_warm_wall"],old_native_endpoint_wall=edge,
                    hours=rate*count/3600,native_hours=case["native_warm_wall"]*count/3600,raw=runs))
    sums["hours"]+=rate*count/3600;sums["native_hours"]+=case["native_warm_wall"]*count/3600
    sums["native_endpoint_hours"]+=edge*count/3600;sums["count"]+=count
    for i,value in enumerate(warm):sums["replicate_hours_"+str(i)]+=value*count/3600
sums["unmeasured_count"]=scope["packed_slices"]-int(sums["count"])
sums["unmeasured_original_native_endpoint_hours"]=scope["edge_panel_native_wall_hours"]-sums["native_endpoint_hours"]
result=dict(rows=out,totals=dict(sums),expected_cases=len(cases),matched_cases=len(out),inputs={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in [here/"cases.json",here/"cases.txt",here/"wide.txt",here/"wide.json",here/"LargePanelWideScript.sml",here/"LargePanelScript.sml",here.parent/"large-kronecker-price/axis-histogram.csv.gz"]})
(here/"fold.json").write_text(json.dumps(result,indent=2))
print(len(out),len(cases),dict(sums))

