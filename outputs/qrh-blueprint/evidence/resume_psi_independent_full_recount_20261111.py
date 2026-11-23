"""Independent full external recount with fixed global segments and modular-index marking.
No author imports. No Lean. Compares all source-sized subcounts and all window counts.
"""
from pathlib import Path
from math import isqrt
import hashlib,json,os,time
H=Path(__file__).resolve().parent;P=H.parent/'prime-estimates';Q=P/'psi_full_candidate_20261111'
OUT=H/'psi_independent_full_recount_20261111';OUT.mkdir(exist_ok=True)
A=10**9;B=5*10**9;SEG=1<<23

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
def read(p):return json.loads(p.read_bytes())
def save(p,j):
    raw=(json.dumps(j,indent=2)+'\n').encode()
    if p.exists():assert p.read_bytes()==raw
    else:
        tmp=p.with_suffix(p.suffix+'.tmp');tmp.write_bytes(raw);os.replace(tmp,p)
    return hashlib.sha256(raw).hexdigest()
t0=time.perf_counter();c0=time.process_time()
paths=[P/'resume_psi_short_gap_20261111.json',P/'resume_psi_multi32_20261111.json',P/'resume_psi_stress512_20261111.json']+sorted(Q.glob('batch_*.json'))
pilot=read(paths[0]);rows=[{'a':A,'b':pilot['pilot_endpoint'],'count':pilot['pilot_count'],'subwindows':pilot['pilot_subwindows'],'prime_list_sha256':pilot['pilot_primes_ascii_sha256']}]
rows+=read(paths[1])['windows'];rows+=read(paths[2])['windows']
for p in paths[3:]:rows+=read(p)['windows']
assert len(rows)==6439 and sum(len(r['subwindows']) for r in rows)==125271
cursor=A
for r in rows:
    assert r['a']==cursor and r['b']==min(B,cursor+cursor//4000);cursor=r['b']
assert cursor==B
# Independent complete base by prime trial division, not an imported producer list.
base=[]
for n in range(2,70711):
    for p in base:
        if p*p>n:base.append(n);break
        if n%p==0:break
    else:base.append(n)
assert len(base)==7004 and base==read(Q/'base_primes.json')['primes']
assert 70710**2<=B<70711**2
meta={'scope':'independent complete external recount; no Lean','script_sha256':sha(Path(__file__)),
 'inputs':{str(p.relative_to(P)).replace('\\','/'):sha(p) for p in paths},
 'segment_integer_width':SEG,'segment_origin':A,'method':'odd compressed array; zero-index residue j=(-first_odd*((p+1)//2)) mod p; global fixed segments independent of window boundaries',
 'base_count':len(base),'hashes':'all5901 new raw0/1 classification hashes and all538 old ASCII prime-list hashes compared; raw0/1 hash saved for every window'}
save(OUT/'metadata.json',meta)
index=0;batchno=0;prev=sha(OUT/'metadata.json')
for cp in sorted(OUT.glob('recount_*.json')):
    batchno+=1;assert cp.name==f'recount_{batchno:04d}.json';j=read(cp)
    assert j['previous_sha256']==prev and j['start_index']==index+1
    for x in j['windows']:
        assert x['index']==index+1 and x['a']==rows[index]['a'] and x['b']==rows[index]['b'] and x['count']==rows[index]['count']
        index+=1
    assert j['end_index']==index;prev=sha(cp)
print(json.dumps({'event':'start_or_resume','completed_windows':index,'endpoint':rows[index-1]['b'] if index else A}),flush=True)
pending=[];segments=0;buf=bytearray(rows[index]['b']-rows[index]['a']) if index<len(rows) else None
cursor=rows[index]['a']+1 if index<len(rows) else B+1
while cursor<=B:
    end=min(B,A+(((cursor-A-1)//SEG)+1)*SEG)
    first=cursor|1;length=(end-first)//2+1;mask=bytearray(b'\1')*length
    for p in base[1:]:
        if p*p>end:break
        j=(-first*((p+1)//2))%p
        if j<length:mask[j::p]=b'\0'*((length-1-j)//p+1)
    while index<len(rows) and rows[index]['a']<end:
        row=rows[index];lo=max(cursor,row['a']+1);hi=min(end,row['b']);ol=lo|1
        if ol<=hi:
            n=(hi-ol)//2+1;src=(ol-first)//2;dst=ol-row['a']-1
            buf[dst:dst+2*n:2]=mask[src:src+n]
        if row['b']>end:break
        count=buf.count(1);assert count==row['count'],('window count',index+1,count,row['count'])
        for sub in row['subwindows']:
            off=sub['n']-row['a'];got=buf[off:off+sub['width']].count(1)
            assert got==sub['count'],('subcount',index+1,sub['n'],got,sub['count'])
        h=hashlib.sha256(buf).hexdigest()
        oldhash=None
        if 'classification_sha256' in row:assert h==row['classification_sha256'],('raw hash',index+1)
        else:
            text=bytearray();loc=buf.find(b'\1')
            while loc>=0:
                text.extend((str(row['a']+1+loc)+'\n').encode());loc=buf.find(b'\1',loc+1)
            oldhash=hashlib.sha256(text).hexdigest();assert oldhash==row['prime_list_sha256'],('ascii hash',index+1)
        pending.append({'index':index+1,'a':row['a'],'b':row['b'],'count':count,'subcounts_checked':len(row['subwindows']),
                        'raw_classification_sha256':h,'old_ascii_hash_checked':oldhash})
        index+=1
        if len(pending)==64 or index==len(rows):
            batchno+=1
            prev=save(OUT/f'recount_{batchno:04d}.json',{'previous_sha256':prev,'start_index':pending[0]['index'],'end_index':index,'windows':pending})
            pending=[]
        if index<len(rows):buf=bytearray(rows[index]['b']-rows[index]['a'])
    cursor=end+1;segments+=1
    if segments%16==0:print(json.dumps({'event':'progress','segments_this_process':segments,'completed_windows':index,'sieved_through':end,'seconds':time.perf_counter()-t0}),flush=True)
assert index==6439 and not pending
summary={'status':'all counts/subcounts and original hashes independently matched externally; no Lean','windows':6439,'subcounts':125271,
 'positions':B-A,'prime_count':sum(r['count'] for r in rows),'new_classification_hashes_matched':5901,'old_ascii_prime_hashes_matched':538,
 'base_primes':7004,'segment_width':SEG,'final_endpoint':B,'last_checkpoint_sha256':prev,'metadata_sha256':sha(OUT/'metadata.json')}
save(OUT/'COMPLETE.json',summary)
resources={'wall_seconds_this_process':time.perf_counter()-t0,'cpu_seconds_this_process':time.process_time()-c0,'segments_this_process':segments}
(OUT/'resources.json').write_text(json.dumps(resources,indent=2)+'\n')
print(json.dumps(summary,indent=2));print(json.dumps(resources),flush=True)
