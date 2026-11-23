"""Summarize only the final timed_* receipts with complete helper replay."""
from pathlib import Path
import hashlib,json,statistics
H=Path(__file__).resolve().parent
groups={}
for path in sorted(H.glob('timed_*.json')):
    receipt=json.loads(path.read_text())
    if receipt['exit_code'] != 0:
        continue
    for row in receipt['rows']:
        if 'variant' not in row:
            continue
        key=f"{row['variant']}P{row['precision']}N{row['butterflies']}"
        groups.setdefault(key,[]).append(dict(
            receipt=path.name,kernel_ms_per_stage=row['kernel_wall_ns']/1e6/row['repetitions'],
            declarations=row['declarations'],process_cpu_seconds=receipt['cpu_seconds']))
summary={}
for key,rows in groups.items():
    vals=[row['kernel_ms_per_stage'] for row in rows]
    summary[key]=dict(runs=len(rows),median_ms=statistics.median(vals),min_ms=min(vals),max_ms=max(vals),details=rows)
pins=[]
for path in sorted(H.iterdir()):
    if path.name != 'SUMMARY.json' and path.suffix in ['.lean','.py','.log','.olean','.json','.md']:
        data=path.read_bytes()
        pins.append(dict(path=path.name,bytes=len(data),sha256=hashlib.sha256(data).hexdigest()))
result=dict(results=summary,artifact_pins=pins,
            timings_are_kernel_replay_not_full_build=True,
            arithmetic_scope='exact dyadic weighted butterfly stages; roots/source enclosures excluded',
            historical_replay_01_02_invalid='They omit decide +kernel helper proofs and must not be used.')
(H/'SUMMARY.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
print(json.dumps(summary,indent=2))
