"""Benchmark distinct rows from the previously pinned Lean fixtures."""
from pathlib import Path
import json,hashlib
H=Path(__file__).resolve().parent
def z(v):return f'(pairc (numc {max(v,0)}) (numc {max(-v,0)}))'
def ls(xs):
    t='(numc 0)'
    for x in reversed(xs):t=f'(pairc {x} {t})'
    return t
pins=[]
for p,n in [(100,64),(343,64),(415,64),(343,256)]:
    case=f'P{p}N{n}';source=H.parents[1]/f'lean-pilots/batched-transform/{case}.json'
    rows=json.loads(source.read_text())['rows']
    assert len(set(tuple(r['input']) for r in rows))==n
    xs=ls([ls([z(v) for v in r['input']]) for r in rows])
    ys=ls([ls([z(v) for v in r['output']]) for r in rows])
    tm=f'Zstage {xs} {ys} {z(2**p)} {z(1024*2**p)}'
    s='let _ =\n  let tm = `'+tm+'` in\n'
    for run in range(3):
        label=f'distinct_{case}_r{run}'
        s+=f'  let _ = bench_mark "{label}_start" in\n'
        s+='  let th = compute zdefs tm in\n'
        s+=f'  let _ = bench_mark "{label}_end" in\n'
        s+='  let _ = if rand (concl th) = `numc 1` then () else failwith "distinct rejected" in\n'
    s+=f'  print_string "DISTINCT_{case}_DONE\\n";;\n'
    (H/f'distinct_{case}.ml').write_text(s)
    pins.append(dict(case=case,rows=n,sha256=hashlib.sha256(source.read_bytes()).hexdigest()))
(H/'distinct_pins.json').write_text(json.dumps(pins,indent=2)+'\n')
