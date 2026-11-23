"""Independently compare the fused predicates to native completed decisions."""
import csv
import json
from pathlib import Path
here = Path(__file__).resolve().parent
report = []
previous = None
for h in (1,2):
    with (here.parent/f'c10004-real-transform/h{h}-completed.tsv').open() as stream:
        native = list(csv.DictReader(stream,delimiter='\t'))
    with (here.parent/f'c10004-hol-replay/a02_h{h}.tsv').open() as stream:
        hol = [[int(v.removesuffix('i')) for v in row.split()] for row in stream]
    guards = [tuple(map(int, row.split())) for row in (here/f'h{h}-guards.tsv').read_text().splitlines()]
    assert len(native) == len(hol) == len(guards) == 2301
    signs = []
    margins = []
    for row,(r,i),(a,b,e,s) in zip(native,hol,guards,strict=True):
        assert e >= 0 and s in (-1,1) and s == int(row['sign'])
        gap = s*(a*r-b*i)-((abs(a)+abs(b))*e+abs(r)+abs(i)+2*e)
        assert gap > 0
        signs.append(s)
        margins.append(gap)
    report.append(dict(h=h,positive=signs.count(1),negative=signs.count(-1),
                       min_margin_grid2=min(margins),min_margin_over_scale_squared=min(margins)/(1<<162)))
    if previous:
        report[-1]['changed_from_previous'] = sum(x!=y for x,y in zip(signs,previous,strict=True))
    previous=signs
print(json.dumps(report,indent=2))
