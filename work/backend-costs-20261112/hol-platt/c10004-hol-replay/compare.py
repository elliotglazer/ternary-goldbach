from pathlib import Path
import csv
import hashlib
import json
import sys
import re

here = Path(__file__).resolve().parent
label = sys.argv[1]
def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()
result = {}
for h in (1,2):
    expected = here.parent/f'c10004-real-transform/h{h}-spectrum.tsv'
    actual = here/f'{label}_h{h}.tsv'
    with expected.open() as stream:
        rows = list(csv.DictReader(stream,delimiter='\t'))
    assert [(int(r['k41']),int(r['k61'])) for r in rows] == [
        (i,j) for i in range(1,40) for j in range(1,60)]
    ys = [tuple(int(re.fullmatch(r'(-?[0-9]+)i', token).group(1)) for token in line.split()) for line in actual.read_text().splitlines()]
    assert len(ys) == len(rows) == 2301
    for i,(y,r) in enumerate(zip(ys,rows)):
        assert y == (int(r['re']),int(r['im'])), (h,i,y,r)
    result[h] = dict(outputs=len(ys), native_sha256=digest(expected), hol_sha256=digest(actual))
print(json.dumps(result,indent=2))
