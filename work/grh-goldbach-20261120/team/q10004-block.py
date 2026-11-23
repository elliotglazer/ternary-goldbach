"""Recheck frozen channels on the saved 16-endpoint, 15-midpoint source block."""
import csv
import hashlib
import json
import sys
from pathlib import Path
from time import process_time

here = Path(__file__).resolve().parent
grid = here.parents[1] / 'backend-costs-20261112/hol-platt/c10004-grid-repair'
sys.path.insert(0, str(grid))
import complete as campaign
from flint import acb, arb, ctx, dirichlet_char

freeze = json.loads((here / 'q10004-freeze.json').read_text(encoding='utf-8-sig'))
start = process_time()
labels, phases = campaign.phases()
channels = []
for parity, name in enumerate(('even','odd')):
    for label, freq in zip(freeze[name]['labels'],freeze[name]['frequency'],strict=True):
        chi = dirichlet_char(campaign.Q,label)
        k,l = freq
        assert chi.is_primitive() and campaign.comp.parity(k,l)==parity
        for residue, index, order in [(2501*3+4880+2624,1,2),
                  (2501+4880*6+2624,k,40),(2501+4880+2624*2,l,60)]:
            assert chi(residue%campaign.Q).overlaps(acb.exp_pi_i(acb(2*index)/order))
        channels.append((label,(k,l),labels.index((k,l)),chi))
setup = process_time()-start
values = {label:[] for label,*_ in channels}
units = [int(r['a']) for r in campaign.comp.read(grid.parent/'c10004-reference/h1.tsv')]
sources = {}
core = cross = 0
for doubled in range(2*84184,2*84199+1):
    t0=process_time()
    filename = f'mid{doubled}-source.tsv' if doubled%2 else f'j{doubled//2}-source.tsv'
    raw=(grid/filename).read_bytes()
    sources[filename]=hashlib.sha256(raw).hexdigest()
    rows=list(csv.DictReader(raw.decode().splitlines(),delimiter='\t'))
    assert [int(r['a']) for r in rows]==units
    spec=campaign.ct.tensor([(int(r['re']),int(r['im']),1) for r in rows],campaign.ct.direct_balls)
    t=arb(5*doubled)/128
    s=acb(arb(1)/2,t)
    fac=campaign.factors(t)
    for label,p,ix,chi in channels:
        x,y,e=spec[ix]
        z=phases[p]*fac[campaign.comp.parity(*p)]*(acb(campaign.Q)**(-s))*acb(arb(x,e),arb(y,e))/campaign.S
        assert z.imag.contains(0) and (z.real>0 or z.real<0)
        values[label].append(1 if z.real>0 else -1)
    core+=process_time()-t0
    if doubled in (168368,168369,168398):
        t0=process_time()
        with ctx.workprec(288):
            for label,p,ix,chi in channels:
                z=phases[p]*campaign.factors(t)[campaign.comp.parity(*p)]*chi.l(s)
                assert z.imag.contains(0) and (z.real>0 or z.real<0)
                assert (1 if z.real>0 else -1)==values[label][-1]
        cross+=process_time()-t0
result={'freeze_sha256':hashlib.sha256((here/'q10004-freeze.json').read_bytes()).hexdigest(),
        'source_sha256':sources,'grid':'t=5*doubled/128; doubled=168368..168398',
        'conrey_signs':values,'direct_L_checks':12,'precision_bits':ctx.prec,
        'phase_setup_cpu_seconds':setup,'block_cpu_seconds':core,'direct_L_cpu_seconds':cross,
        'total_cpu_seconds':process_time()-start}
(here/'q10004-block.json').write_text(json.dumps(result,indent=2)+'\n')
print({k:v for k,v in result.items() if k not in ('conrey_signs','source_sha256')},flush=True)
