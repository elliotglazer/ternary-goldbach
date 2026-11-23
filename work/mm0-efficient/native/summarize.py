"""Summarize wall time. One target bit is one tested even integer."""
import json,statistics
from pathlib import Path
P=Path(__file__).resolve().parent
names=['dense','active','hybrid32','hybrid64','hybrid96','hybrid128','hybrid192','hybrid256','tile64K-hybrid96','tile256K-hybrid96']
out={}
for path in sorted(P.glob('bulk_*native.json'))+sorted(P.glob('bulk_*scalar.json')):
    if not path.stat().st_size:continue
    d=json.loads(path.read_text());rows=[]
    for width in sorted(set(x['width'] for x in d['loaded'])):
        for mode in range(len(names)):
            a=[x for x in d['loaded'] if x['width']==width and x['mode']==mode]
            if not a:continue
            samples=[x['wall_seconds']*1e9/x['reps']/x['bits_per_sweep'] for x in a]
            rows.append(dict(width=width,mode=names[mode],ns_per_even=statistics.median(samples),
                min_ns_per_even=min(samples),max_ns_per_even=max(samples),
                mean_prefix=a[0]['prefix_sum']/a[0]['cases'],
                word_updates_per_even=a[0]['updates_per_sweep']/a[0]['bits_per_sweep']))
    stream=[]
    for mode in range(len(names)):
        a=[x for x in d['stream_parse'] if x['mode']==mode]
        if a:stream.append(dict(mode=names[mode],ns_per_even=statistics.median(
            x['wall_seconds']*1e9/x['reps']/x['bits_per_sweep'] for x in a)))
    out[path.stem]=dict(positive_checks=d['positive_checks'],negative_checks=d['negative_checks'],
        initial_load_seconds=d['initial_load_seconds'],loaded=rows,stream=stream)
    print(path.name)
    for width in sorted(set(x['width'] for x in rows)):
        r=sorted((x for x in rows if x['width']==width),key=lambda x:x['ns_per_even'])
        print(width,[(x['mode'],round(x['ns_per_even'],4)) for x in r[:3]])
    print('best stream', sorted(stream,key=lambda x:x['ns_per_even'])[:2])
(P/'summary.json').write_text(json.dumps(out,indent=2))
