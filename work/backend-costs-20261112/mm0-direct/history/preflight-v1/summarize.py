"""Collect a completed root run. No producer or verifier is executed here."""
from pathlib import Path
import hashlib,json,re,statistics,sys

p=Path(__file__).resolve().parent;label=sys.argv[1]
assert re.fullmatch('[A-Za-z0-9_]+',label)
out={'scope':'Same64 canonical-pair signed products; no rounding, transform or analytic claim',
     'label':label,'arms':{},'processes':{},'artifacts':{},
     'measurement':'Files remain on the selected filesystem; no automatic tmpfs-copy or cold-I/O claim',
     'checker':'Existing instrumented, enlarged-capacity ordinary-rule checker; not stock-memory acceptance'}
for arm in ('direct','frontend'):
    for n in (0,64):
        values=[];internal=[]
        for r in range(1,6):
            key=f'check_{arm}{n}_{r}'
            log=(p/f'{label}_{key}.log').read_text(errors='replace')
            # Preserve actual timer text; generic process CPU is always recorded.
            cpu=re.search(r'BENCH_CPU_SECONDS=([0-9.]+)',log)
            assert cpu,log
            internal.append(float(cpu[1]))
            time=(p/f'{label}_{key}.time').read_text()
            assert re.search(r'Exit status:\s+0\s*$',time)
            user=float(re.search(r'User time \(seconds\):\s*([0-9.]+)',time)[1])
            system=float(re.search(r'System time \(seconds\):\s*([0-9.]+)',time)[1])
            values.append(user+system)
        out['arms'][f'{arm}{n}']={'whole_process_cpu_median':statistics.median(values),
            'internal_checker_cpu_median':statistics.median(internal),
            'internal_checker_cpu_samples':internal,
            'whole_process_cpu_samples':values,'timer_precision_caveat':'Also inspect internal verifier timer in saved logs',
            'binary_bytes':(p/f'{arm}{n}.mmb').stat().st_size}
for f in p.glob(f'{label}_*.time'):
    key=f.name[len(label)+1:-5]
    if key.startswith('reject_') or key=='summary':continue
    text=f.read_text();assert re.search(r'Exit status:\s+0\s*$',text),key
    out['processes'][key]={'time_text':text,'argv':(p/f'{label}_{key}.argv').read_text().splitlines()}
for arm in ('direct','frontend'):
    for bad in ('input','sign','result','proof'):
        stem=f'{label}_reject_{arm}_{bad}'
        assert int((p/(stem+'.exit')).read_text()) not in (0,124,137)
        log=(p/(stem+'.log')).read_text(errors='replace')
        assert 'MM0_REJECT' in log,log
for arm in ('direct','frontend'):
    for n in (0,64):
        name=f'{arm}{n}'
        profile=(p/f'{label}_profile_{name}.log').read_text()
        counts=re.search(r'BENCH_COUNTS proof=(\d+) unify=(\d+)',profile)
        assert counts,profile
        out['arms'][name]['proof_commands']=int(counts[1])
        out['arms'][name]['unify_commands']=int(counts[2])
        out['arms'][name]['highwater_log']=(p/f'{label}_highwater_{name}.log').read_text()
for f in p.iterdir():
    if f.is_file() and (f.name.startswith(label+'_') or f.suffix in ('.mmb','.mm0','.mm1','.py','.sh')):
        out['artifacts'][f.name]={'bytes':f.stat().st_size,'sha256':hashlib.sha256(f.read_bytes()).hexdigest().upper()}
with (p/f'{label}_results.json').open('x') as f:json.dump(out,f,indent=2)
print(json.dumps(out['arms'],indent=2))
