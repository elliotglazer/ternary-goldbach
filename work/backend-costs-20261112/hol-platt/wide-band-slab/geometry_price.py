"""Price geometry reuse from checked paired runs and actual height-block counts."""
import hashlib
import json
import re
import sys
from pathlib import Path
from statistics import median

HERE=Path(__file__).resolve().parent
SLAB=HERE.parent/'large-weighted-slab'
sys.path.insert(0,str(SLAB))
from adaptive_groups import groups
from schedule import PATH


def read(p):
    return json.loads(p.read_bytes())


def main():
    label='geom01'
    log=HERE/(label+'.log')
    assert log.with_suffix('.status').read_text().strip()=='0'
    raw=log.read_text()
    assert 'GEOMETRY_DONE' in raw
    for row in log.with_suffix('.sha256').read_text().splitlines():
        digest,name=row.split()
        assert hashlib.sha256((HERE/name).read_bytes()).hexdigest()==digest
    starts=[r['tag'] for suffix in ['-first',''] for r in read(HERE/('fixtures'+suffix+'.json'))['cases']]
    following=[r['tag'] for suffix in ['-next-first','-next'] for r in read(HERE/('fixtures'+suffix+'.json'))['cases']]
    samples={name:float(v) for name,v in re.findall(r'^SETUP (\w+) ([\d.]+)',raw,re.M)}
    hits={name:int(v) for name,v in re.findall(r'^HITS (\w+) (\d+)',raw,re.M)}
    assert len(samples)==len(hits)==60
    geo=[float(t) for t in re.findall(r'^GEOMLOAD \d+ ([\d.]+)',raw,re.M)]
    coeffs={name:float(t) for name,t in re.findall(r'^COEFFLOAD (\w+) ([\d.]+)',raw,re.M)}
    assert len(geo)==5 and len(coeffs)==10
    a=read(SLAB/'adaptive-groups.json')
    plan=a['scenarios']['128']['bands']
    manifest=PATH.read_bytes()
    assert hashlib.sha256(manifest).hexdigest()==a['manifest_sha256']
    conductors=sorted((c,phi,j+41) for c,phi,_,_,j,_,_ in json.loads(manifest)['conductors'])
    zones=read(SLAB/'later-band-budget.json')['bands']
    result=[]
    for first,second,load,fee,z in zip(starts,following,geo,plan,zones,strict=True):
        for i in range(1,4):
            assert hits[f'{first}_plain{i}']==hits[f'{second}_plain{i}']==0
            assert hits[f'{second}_reuse{i}']==2 and hits[f'{first}_reuse{i}']==(0 if i==1 else 2)
        lo,hi=z['height_indices']
        active=[(c,phi,(min(hi,j)-lo+7)//8) for c,phi,j in conductors if j>lo]
        partition=groups(active,a['maximum_bytes'],128)
        epochs=calls=0
        for part,size in partition:
            heights={n for c,phi,n in part}
            epochs+=len(heights)*z['cells']
            calls+=max(heights)*z['cells']
        assert calls==fee['calls_even_if_empty'] and 0<epochs<=calls
        tref=lambda n: median(samples[f'{second}_{n}{i}'] for i in range(1,4))
        plain,warm=tref('plain'),tref('reuse')
        # The cold second-panel geometry is deliberately reconstructed when the active set changes.
        # Charge the higher of observed cold/warm setup prices for its first execution.
        first_price=max(warm,samples[f'{first}_reuse1'])
        kernel_setup=(epochs*first_price+(calls-epochs)*warm)/3600
        coeff_price=(coeffs[first]+coeffs[second])/2
        result.append(dict(band=len(result)+1,calls=calls,geometry_epochs=epochs,mean_uses=calls/epochs,
            plain_setup_seconds=plain,warm_setup_seconds=warm,first_setup_seconds=first_price,
            plain_setup_hours=calls*plain/3600,setup_with_geometry_reuse_hours=kernel_setup,
            literal_geometry_read_hours=epochs*load/3600,literal_coefficient_read_hours=calls*coeff_price/3600,
            second_height_plain_trials=[samples[f'{second}_plain{i}'] for i in range(1,4)],
            second_height_reuse_trials=[samples[f'{second}_reuse{i}'] for i in range(1,4)]))
    totals={col:sum(r[col] for r in result) for col in ['plain_setup_hours','setup_with_geometry_reuse_hours',
        'literal_geometry_read_hours','literal_coefficient_read_hours']}
    overhead=sum(totals[k] for k in ('setup_with_geometry_reuse_hours','literal_geometry_read_hours','literal_coefficient_read_hours'))
    prev=read(HERE/'all-costs.json')['other_components_and_source']
    projected={p:[h+overhead for h in opt['partial_kernel_scenario']] for p,opt in prev.items()}
    out=dict(bands=result,totals=totals,partial_with_geometry_reuse_and_literal_input=projected,
             headroom_to_twice_historical={p:[800000-h for h in v] for p,v in projected.items()},
             log_sha256=hashlib.sha256(log.read_bytes()).hexdigest())
    (HERE/'geometry-costs.json').write_text(json.dumps(out,indent=2)+'\n')
    print(totals,projected)


if __name__=='__main__':
    main()
