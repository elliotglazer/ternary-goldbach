import csv
import json
from pathlib import Path
from time import perf_counter, process_time
from flint import acb, arb, ctx
ctx.prec=176
ctx.threads=1
here=Path(__file__).resolve().parent
source=list(csv.DictReader((here.parent/'c10004-reference/h1.tsv').open(),delimiter='\t'))
rows=[source[150*i] for i in range(32)]
start=perf_counter()
cpu=process_time()
for row in rows:
    z=acb(arb(1)/2,arb(84199*5)/64).zeta(acb(arb(int(row['a']))/10004))
    for v in (z.real,z.imag):
        y=v*(1<<81)
        n=(y+arb(1)/2).floor().unique_fmpz()
        assert n is not None and abs(y-n)<arb(1)/2
wall=perf_counter()-start
print(json.dumps(dict(samples=len(rows),j=84199,wall=wall,cpu=process_time()-cpu,projected_full_wall=wall*300)))
