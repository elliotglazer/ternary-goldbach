"""Compare six native CT outputs with independent Arb L-values."""
import csv
import json
from pathlib import Path
from flint import acb, arb, ctx, dirichlet_char

ctx.prec = 176
ctx.threads = 1
here = Path(__file__).resolve().parent
receipt = json.loads((here.parent / 'c10004-reference/receipt.json').read_text())
rows = []
for node in receipt['nodes']:
    h = node['h']
    if h == 0:
        continue
    with (here / f'h{h}-spectrum.tsv').open() as f:
        spectra = list(csv.DictReader(f,delimiter='\t'))
    s = acb(arb(1)/2,arb(5*h)/64)
    for item in node['checks']:
        _,k,l = item['positive_frequency']
        row = spectra[(k-1)*59+l-1]
        assert (int(row['k41']),int(row['k61'])) == (k,l)
        center = acb(int(row['re']),int(row['im'])) / (1 << 81)
        target = acb(10004)**s * dirichlet_char(10004,item['conrey']).l(s)
        gap = abs(center-target) * (1 << 81)
        bound = int(row['abs_error_grid_units'])
        assert gap < bound
        rows.append(dict(h=h,k41=k,k61=l,conrey=item['conrey'],gap_grid_units=str(gap),bound=bound))
print(json.dumps(rows,indent=2))
