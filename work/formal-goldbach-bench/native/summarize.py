from pathlib import Path
import hashlib
import json
import statistics

HERE=Path(__file__).resolve().parent
inputs=[HERE/f'results-{i}.json' for i in (1,2,3)]
runs=[json.loads(p.read_text(encoding='utf-8-sig')) for p in inputs]
rows=[]
for i in range(len(runs[0]['cases'])):
    cases=[r['cases'][i] for r in runs]
    rows.append({'bits':cases[0]['bits'],
       'median_cpu_seconds_per_word_mask':statistics.median(c['cpu_seconds']/c['word_mask_ops'] for c in cases),
       'median_wall_seconds_per_word_mask':statistics.median(c['wall_seconds']/c['word_mask_ops'] for c in cases),
       'wall_seconds_per_word_mask_range':[min(c['wall_seconds']/c['word_mask_ops'] for c in cases),max(c['wall_seconds']/c['word_mask_ops'] for c in cases)]})
out={'scope':'Native random-mask slice/OR microbenchmark; no primality or formal checking.',
     'cpu':'AMD Ryzen 9 8945HS, Windows x64',
     'compiler':'Lean 4.35 bundled Clang 23.1.0, -O3 -march=native',
     'source_sha256':hashlib.sha256((HERE/'mask_baseline.c').read_bytes()).hexdigest(),
     'inputs':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs},
     'timing':'GetProcessTimes CPU, QueryPerformanceCounter wall; three runs, setup excluded',
     'cases':rows}
(HERE/'summary.json').write_text(json.dumps(out,indent=2))
print(json.dumps(out,indent=2))
