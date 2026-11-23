"""Read every successful paired kernel trial and charge setup separately."""
import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path
from statistics import median

HERE=Path(__file__).resolve().parent


def fold(log,scope):
    assert log.with_suffix(".status").read_text().strip()=="0"
    raw=log.read_text()
    assert "WEIGHTED_SLAB_DONE" in raw
    samples=defaultdict(dict)
    for key,group,n,sec in re.findall(r"^SLAB (\w+)_groups(\d+) (\d+) ([\d.]+) ",raw,re.M):
        samples[key,int(group)][int(n)]=float(sec)
    groups=list(scope)
    populations={(name,int(g)):int(n) for name,g,n in re.findall(r"^SAMPLES (\w+) (\d+) (\d+)$",raw,re.M)}
    result={}
    for name,g in populations:
        if g:
            continue
        full=groups[-1]
        for g in groups:
            assert sorted(samples[name,g])==[1,2,3,4,5]
        def slope(x,y):
            delta=populations[name,y]-populations[name,x]
            return [1e6*(samples[name,y][r]-samples[name,x][r])/delta for r in (1,2,3,4,5)]
        measures={}
        for x,y in [(0,full),(groups[-2],full),(0,groups[1])]:
            trial=slope(x,y)
            measures[f"groups_{x}_to_{y}"]=dict(median_us=median(trial),trials_us=trial)
        result[name]=dict(complex_outputs=populations[name,full],fixed_control_s=median(samples[name,0].values()),
                          whole_full_window_us=1e6*median(samples[name,full].values())/populations[name,full],
                          marginal_us=measures)
    assert result
    return dict(cases=result,log_sha256=hashlib.sha256(log.read_bytes()).hexdigest())


if __name__=="__main__":
    record=fold(HERE/"slab03.log",[0,1,4,8])
    (HERE/"rates.json").write_text(json.dumps(record,indent=2)+"\n")
    print([(k,round(v["whole_full_window_us"],2),round(v["marginal_us"]["groups_0_to_8"]["median_us"],2),
            round(v["marginal_us"]["groups_4_to_8"]["median_us"],2)) for k,v in record["cases"].items()])
