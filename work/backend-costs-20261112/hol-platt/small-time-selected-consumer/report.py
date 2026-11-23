from pathlib import Path
import csv,json,hashlib,collections
p=Path(__file__).resolve().parent;b=p.parent;h=b/'sparse-head';full=b/'full-height-count'
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
lens={int(s[0]):int(s[1]) for row in (full/'stencils.txt').read_text().splitlines()[1:111:2] if (s:=row.split())}
geo=[]
for l in (3,6667,11,9091):
    f=p/f'heads-{l}.txt';ref=h/f.name
    assert f.read_text().splitlines()==ref.read_text().splitlines()
    slots=set();ws=collections.Counter()
    for i,line in enumerate(f.read_text().splitlines()):
        m,w,e,v=line.split();m=int(m);ws[int(w)]+=m.bit_count();slots.update(64*i+j for j in range(64) if (m>>j)&1)
    support=set();nj=0
    for row in (h/f'jobs-{l}.txt').read_text().splitlines():
        t,k=map(int,row.split());r=lens[k];start=t//4096+128+1-r//2
        support.update(range(start,start+r));nj+=1
    assert support<=slots
    geo.append(dict(label=l,selected=len(slots),jobs=nj,repair_support=len(support),witness_only=len(slots-support),widths=ws,sha_heads=sha(ref),new_sha_heads=sha(f)))
ts=list(csv.DictReader((p/'native-timings.csv').open()));rates={}
for k in (10,12,16):
    rates[k]={mode:[sum(float(v['wall']) for v in ts if v['k']==str(k) and v['rep']==str(rep) and v['mode']==mode) for rep in range(3)] for mode in ('full-post','full-extract','select','pruned')}
out=dict(geometry=geo,timing_wall_seconds_all_eight_tiles_by_repetition=rates,source_spectrum_sha256=sha(full/'coefficients.tsv'))
(p/'summary.json').write_text(json.dumps(out,indent=2));print([(q['selected'],q['jobs'],q['repair_support'],q['witness_only']) for q in geo]);print(rates[16])

