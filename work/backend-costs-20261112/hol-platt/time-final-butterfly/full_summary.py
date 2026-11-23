from pathlib import Path
import hashlib,json,re
from math import isclose
here=Path(__file__).resolve().parent
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest()
keys=['schema','read_and_quote','encode','cv_arithmetic','finish_audit','save_and_write','readback','driver_total']
def tstat(path):
    text=path.read_text()
    fields={}
    for out,pattern in [('user',r'User time \(seconds\): ([\d.]+)'),('system',r'System time \(seconds\): ([\d.]+)'),('rss_kib',r'Maximum resident set size \(kbytes\): (\d+)')]:
        fields[out]=float(re.search(pattern,text).group(1))
    wall=re.search(r'Elapsed \(wall clock\).*?: (.+)',text).group(1).strip()
    h=re.search(r'(\d+)h',wall);m=re.search(r'(\d+)m',wall);s=re.search(r'([\d.]+)s',wall)
    fields['wall']= (3600*int(h.group(1)) if h else 0)+(60*int(m.group(1)) if m else 0)+float(s.group(1))
    return fields
batch='b06'
shards=[]; files=[]
for lo in [0,256,512,768,1024,1280]:
    s=here/f'{batch}_part{lo}'
    assert s.with_suffix('.status').read_text().strip()=='0'
    logs=s.with_suffix('.log').read_text()
    assert logs.count('FULL_BUTTERFLY_DONE')==1
    low,high,required,ticks=map(int,re.search(r'FULL_BUTTERFLY_COVERAGE,([^\n]+)',logs).group(1).split(','))
    assert low==lo and high==min(lo+255,1330)
    cpu=dict(zip(keys,map(float,re.search(r'FULL_BUTTERFLY_CPU,([^\n]+)',logs).group(1).split(',')),strict=True))
    shards.append(dict(lo=low,hi=high,required=required,ticks=ticks,cpu=cpu,process=tstat(s.with_suffix('.time'))))
    for end in range(lo+7,high+8,8):
        p=here/f'{batch}_proofs_{lo}/ending-{min(end,high)}.thms'
        assert p.stat().st_size>0
        files.append((p,digest(p)))
assert sum(s['required'] for s in shards)==71325 and sum(s['ticks'] for s in shards)==51996 and len(files)==167
total={key:sum(s['cpu'][key] for s in shards) for key in keys}
proc={key:sum(s['process'][key] for s in shards) for key in ['user','system','wall']}
proc['max_rss_kib']=max(s['process']['rss_kib'] for s in shards)
result=dict(tiles=1331,outputs=71325,ticks=51996,shards=shards,total_cpu=total,process=proc,
            archives=len(files),archive_bytes=sum(p.stat().st_size for p,_ in files))
(here/'full-proof-archives.sha256').write_text(''.join(f'{h}  {p.relative_to(here).as_posix()}\n' for p,h in files))
(here/'full-verified.json').write_text(json.dumps(result,indent=2))
print(json.dumps({k:v for k,v in result.items() if k!='shards'},indent=2))
