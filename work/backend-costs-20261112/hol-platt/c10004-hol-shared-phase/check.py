"""Compare each packed bit and factorized integer sign guard independently."""
import csv
import json
from pathlib import Path
here = Path(__file__).resolve().parent
phases = [tuple(map(int,l.split())) for l in (here/'phases.tsv').read_text().splitlines()]
report = []
prev = None
for h in (1,2):
    er,ei,orr,oi,e,m = map(int,(here/f'h{h}-params.tsv').read_text().split())
    with (here.parent/f'c10004-real-transform/h{h}-completed.tsv').open() as stream:
        native = list(csv.DictReader(stream,delimiter='\t'))
    with (here.parent/f'c10004-hol-replay/a02_h{h}.tsv').open() as stream:
        pairs = [[int(v.removesuffix('i')) for v in line.split()] for line in stream]
    assert len(native)==len(phases)==len(pairs)==2301 and e>=0
    signs,gaps = [],[]
    for j,(row,(p,q),(r,i)) in enumerate(zip(native,phases,pairs,strict=True)):
        parity = int(row['parity'])
        assert parity == (1-j%2)
        f,g = (orr,oi) if parity else (er,ei)
        a,b = p*f-q*g,p*g+q*f
        d = abs(p)+abs(q)+abs(f)+abs(g)+2
        s = 1 if m%2 else -1
        m //= 2
        assert s == int(row['sign'])
        gap = s*(a*r-b*i) - (abs(a)+abs(b))*e - d*(abs(r)+abs(i)+2*e)
        assert gap > 0
        gaps.append(gap)
        signs.append(s)
    assert m == 0
    report.append(dict(h=h, radius=e,positive=signs.count(1),negative=signs.count(-1),
                       min_margin_over_scale_cubed=min(gaps)/(1<<243)))
    if prev:
        report[-1]['opposite'] = sum(x!=y for x,y in zip(signs,prev,strict=True))
    prev = signs
print(json.dumps(report,indent=2))
