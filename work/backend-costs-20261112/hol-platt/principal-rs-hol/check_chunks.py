from pathlib import Path
import json,re,hashlib
p=Path(__file__).resolve().parent;lab='meshchunks01'
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
src=json.loads((p/'mesh-large.json').read_text());ch=[json.loads((p/f'mesh-chunk{k}.json').read_text()) for k in range(4)]
ns=[c['n'] for c in ch];assert ns==[128]*4
assert [v for c in ch for v in c['signs']]==src['signs']
assert all(c['start']==src['start']+128*128*k for k,c in enumerate(ch))
assert all(v and (v>0)==(s>0) and abs(v)*1000000>2**128 for c in ch for (_,_,v),s in zip(c['rows'],c['signs']))
assert int((p/(lab+'_bench.status')).read_text())==0
log=(p/(lab+'_bench.log')).read_text();assert 'RS_DONE' in log and 'SIGN_IMPLICATION_OK' in log
times=[float(x) for x in re.findall(r'chunk\d+ cpu=([\d.]+)',log)];assert len(times)==4
r=dict(sites=512,packets=4,cpu=times,cpu_per_site=sum(times)/512,sign_changes=src['changes'],actual_zero_count=src['counts'][1]-src['counts'][0],max_chunk_abs_diff=max(c['max_abs_diff'] for c in ch),min_tail_ratio=min(c['min_tail_ratio'] for c in ch),sha={f:sha(p/f) for f in ['RSKernelScript.sml','RSBatchScript.sml','meshchunks.sml','mesh-large.json',lab+'_bench.log']+[f'chunk{k}.tsv' for k in range(4)]})
(p/'512-audit.json').write_text(json.dumps(r,indent=2));print({k:v for k,v in r.items() if k!='sha'})
