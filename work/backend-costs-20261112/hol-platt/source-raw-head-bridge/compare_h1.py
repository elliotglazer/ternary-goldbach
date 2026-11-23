"""Trace the archived h1 rows against the exact integer program from SourceArithmetic."""
from pathlib import Path
import csv
import hashlib
import json
from math import isqrt

here = Path(__file__).resolve().parent
source = here.parent / 'c10004-p20-source'

def nearest(n, d):
    return (2*n+d)//(2*d)

def log_center(a, b):
    tail = 0
    for k in reversed(range(45)):
        tail = nearest((1 << 137)*b*b + (2*k+1)*a*a*tail, (2*k+1)*b*b)
    return nearest(2*a*tail, b)

log2 = log_center(1, 3)

def state(x):
    k = x.bit_length()-1
    q = nearest(k*log2+log_center(x-(1 << k), x+(1 << k)), 256)
    p = -5*q
    r, i = 1 << 131, 0
    for j in reversed(range(72)):
        den = (1 << 135)*(j+1)
        r, i = nearest((1 << 131)*den-p*i, den), nearest(p*r, den)
    r, i = nearest(r, 512), nearest(i, 512)
    m = isqrt((1 << 196)//x)
    return m, r, i, nearest((m << 22)*r, 1 << 122), nearest((m << 22)*i, 1 << 122)

state_path = source / 'h1-head-states.tsv'
head_path = source / 'h1-rawhead.tsv'
states = {}
different = [0]*5
with state_path.open() as f:
    for row in csv.DictReader(f, delimiter='\t'):
        x = int(row['x'])
        actual = state(x)
        states[x] = actual
        for j, field in enumerate(('m98','step_re122','step_im122','re120','im120')):
            different[j] += actual[j] != int(row[field])

ur, ui = states[10004][-2:]
wrong = []
count = 0
with head_path.open() as f:
    for row in csv.DictReader(f, delimiter='\t'):
        count += 1
        a = int(row['a'])
        vr, vi = states[a][-2:]
        value = nearest(10004*(ur*vr+ui*vi), 1 << 140), nearest(10004*(ur*vi-ui*vr), 1 << 140)
        if value != (int(row['re']), int(row['im'])):
            wrong.append(a)
report = dict(states=len(states), state_differences=different, heads=count, head_mismatch_residues=wrong,
              state_sha256=hashlib.sha256(state_path.read_bytes()).hexdigest(),
              head_sha256=hashlib.sha256(head_path.read_bytes()).hexdigest())
print(json.dumps(report, indent=2))
(here/'h1_compare.json').write_text(json.dumps(report,indent=2)+'\n',encoding='utf-8')
