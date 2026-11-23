from pathlib import Path
import re,json,hashlib
p=Path(__file__).resolve().parent
def receipt(tag):
    assert (p/f'{tag}.status').read_text().strip()=='0'
    log=(p/f'{tag}.log').read_text()
    xt=(p/f'{tag}.time').read_text()
    cpu=sum(float(re.search(k+r' time \(seconds\): ([.\d]+)',xt)[1]) for k in ('User','System'))
    assert all('Saved theorem _______ "pair_'+s+'"' in log for s in ('even','odd'))
    return dict(inner=float(re.search(r'FUSED_WORKER ([.\d]+)',log)[1]),process_cpu=cpu,
        raw_inputs=sum(float(v) for v in re.findall(r'FUSED_CHANNEL \d+ ([.\d]+)',log)),
        evaluate=sum(float(v) for v in re.findall(r'JOIN_EVAL [\d.]+ ([\d.]+)',log)),
        sha256=hashlib.sha256((p/f'{tag}.log').read_bytes()).hexdigest())
a,b=map(receipt,('baseline01','margins01'))
scale=1791987359885/(340484*3600)
d=b['inner']-a['inner']
last=json.loads((p/'results.json').read_text())
o=dict(baseline=a, margins=b, delta_inner=d, delta_process=b['process_cpu']-a['process_cpu'],
    marginal_hours=d*scale, old_hours=last['conditional_extra640_hours'],
    plus_marginal_hours=last['conditional_extra640_hours']+d*scale,
    replacement_hours=(b['inner']+last['projection']['worker'])*scale,
    scale=scale, raw_jobs=103, complete_process_hours_delta=(b['process_cpu']-a['process_cpu'])*scale)
(p/'fused-cost.json').write_text(json.dumps(o,indent=2)+'\n')
print(o)
