import csv,json,collections
from pathlib import Path
p=Path(__file__).resolve().parent
src=p.parent/'principal-slab';rows=list(csv.DictReader((src/'stages.csv').open()))
windows=collections.defaultdict(list)
for r in rows: windows[int(r['left'])].append(r)
accepted=collections.Counter();lost=0;hard=0;split=collections.Counter()
for stages in windows.values():
    a=stages[-1];assert a['accepted']=='True'
    ad=int(a['denominator']);accepted[ad]+=1
    if ad>8:
        r=next(x for x in stages if int(x['denominator'])==8)
        lost+=int(r['true_increment'])-int(r['changes']);hard+=1
        for x in stages:
            if int(x['denominator'])>8:split[int(x['denominator'])]+=int(x['new_sites'])
report=dict(windows=len(windows),accepted_by_den=accepted,deficient_at_den8=hard,missing_zeros_den8=lost,extra_by_den=split,extra_sites=sum(split.values()),dense_grid_sites=4096*8+1,full_sites=4096*8+1+sum(split.values()),all_zero_increment=10812)
(p/'mesh-slab-mapping.json').write_text(json.dumps(report,indent=2));print(report)
