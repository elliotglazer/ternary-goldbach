from pathlib import Path
import json
import csv

here = Path(__file__).resolve().parent
roots = json.loads((here.parent / 'c10004-roots/table.json').read_text())
assert roots['fraction_bits'] == 81
with (here/'roots.tsv').open('w',newline='\n') as out:
    for n in [2,3,5,10,15,20,30,40,60]:
        row = roots['rows'][str(n)]
        assert len(row) == n
        for r,i in row:
            out.write(f'{r}\t{i}\n')
for h in [1,2]:
    with (here.parent/f'c10004-reference/h{h}.tsv').open() as src:
        rows = list(csv.DictReader(src,delimiter='\t'))
    assert [int(r['index']) for r in rows] == list(range(4800))
    with (here/f'input{h}.tsv').open('w',newline='\n') as out:
        for r in rows:
            out.write(f"{int(r['re'])}\t{int(r['im'])}\n")
