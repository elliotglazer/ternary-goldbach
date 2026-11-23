"""Fold the verified coefficient-term reuse into bounded group/height tiles."""
import hashlib
import json
import re
from pathlib import Path

HERE=Path(__file__).resolve().parent


def read(n):
    return json.loads((HERE/n).read_bytes())


def main():
    log=HERE/'coeff01.log'
    assert log.with_suffix('.status').read_text().strip()=='0'
    s=log.read_text()
    for row in log.with_suffix('.sha256').read_text().splitlines():
        digest,n=row.split()
        assert hashlib.sha256((HERE/n).read_bytes()).hexdigest()==digest
    assert 'COEFFICIENT_REUSE_DONE' in s
    new=[r['tag'] for suffix in ['-next-first','-next'] for r in read('fixtures'+suffix+'.json')['cases']]
    old=[r['tag'] for suffix in ['-first',''] for r in read('fixtures'+suffix+'.json')['cases']]
    hits={n:int(k) for n,k in re.findall(r'^HITS (\w+) (\d+)',s,re.M)}
    assert len(hits)==60
    for a,b in zip(old,new,strict=True):
        assert [hits[a+n] for n in ['A1','B1','A2','B2','A3','B3']]==[0,1,3,3,3,3]
        assert [hits[b+n] for n in ['A1','B1','A2','B2','A3','B3']]==[2,3,3,3,3,3]
    literals={a:float(v) for a,v in re.findall(r'^LITERAL (\w+) ([\d.]+)',s,re.M)}
    tiles=read('tile-schedule.json')
    panels=read('all-costs.json')['other_components_and_source']
    prices=[]
    for a,b,r in zip(old,new,read('geometry-costs.json')['bands'],strict=True):
        entire=r['literal_coefficient_read_hours']*3600/r['calls']
        shared=(literals[a]+literals[b])/2
        prices.append(dict(band=r['band'],original_literal_seconds=entire,
                           measured_reusable_seconds=shared,credited_seconds=min(entire,shared)))
    results={}
    for label,tile in tiles.items():
        inputs=sum(r['preparation_hours']+r['literal_geometry_hours']+
                   r['coefficient_hours_if_no_literal_load_is_shared']-
                   (r['calls']-r['coefficient_loads'])*p['credited_seconds']/3600
                   for r,p in zip(tile['bands'],prices,strict=True))
        levels={bits:[x+inputs for x in costs['partial_kernel_scenario']] for bits,costs in panels.items()}
        results[label]=dict(max_output_buffer_bytes=tile['max_output_buffer_bytes'],
                            preparation_hours=inputs,partial_hours=levels,
                            room_to_800000={k:[800000-h for h in v] for k,v in levels.items()})
    output=dict(bands=prices,tiles=results,log_sha256=hashlib.sha256(log.read_bytes()).hexdigest(),
        scope='Uses the observed shareable part of literal construction and keeps the full measured per-call warm proof-preparation price. The byte limit covers packed output payloads only.')
    (HERE/'coefficient-costs.json').write_text(json.dumps(output,indent=2)+'\n')
    for k,v in results.items():
        print(k,v['max_output_buffer_bytes'],round(v['preparation_hours']),[round(x) for x in v['partial_hours']['24']])


if __name__=='__main__':
    main()
