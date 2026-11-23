from pathlib import Path
from fractions import Fraction as F
import hashlib,json
from collections import Counter
here=Path(__file__).resolve().parent
base=here.parents[2]/'qrh-campaign/agents/prime-estimates'
src=(base/'small_family_minimal_theta_20261111.py').read_text()
env={'__file__':str(base/'small_family_minimal_theta_20261111.py')}
exec(src[:src.index('for f,h in PINS.items()')],env)
meta_path=base/'sign_only_minimal_theta_nonprincipal_schedule_20261111.json'
data=json.loads(meta_path.read_bytes())
params={(r['odd'],r['theta']):r for r in data['selectors']}
Bpref=2*3**33
scenarios=[]
for scenario in data['scenarios']:
    cands=scenario['small_sign_only_conditional_candidate']
    thetas=dict(cands['conductor_theta'])
    assert len(thetas)==7499
    rows=[]
    for c,m,N,*_ in cands['raw_metadata']:
        v,n,dims=env['cdata'](c)
        if 500 not in dims:
            continue
        idx=dims.index(500)
        kept=[]
        for p,e in env['factors'](c):
            if p==2:
                kept.extend([1] if e==2 else [2,2**(e-3)])
            else:
                kept.append(p-2 if e==1 else (p-1)**2*p**(e-2))
        count=v//500
        for d,k in zip(dims[:idx],kept[:idx]):
            count=count*k//d
        # Check exactness via rational arithmetic with independent product.
        from math import prod
        assert count==prod(kept[:idx])*prod(dims[idx+1:])
        theta=thetas[c]
        param=params[c%2==1,theta]
        S=sum(env['axis'](d)[2] for d in dims)
        safe=max(env['axis'](d)[3] for d in dims)
        eps=F(param['eps'])
        sigma=F(param['sigma'])
        pchar=env['bits'](min(F(1,safe),F(1,2*S),eps/(128*44*Bpref*v*S*(8192**2+2))))
        pgauss=env['bits'](min(F(1,safe),F(1,2*S),sigma/(65536*v*S)))
        R=(50*N+383)//384+1
        assert c not in (3,4,12)
        rows.append(dict(c=c,dims=dims,theta=theta,lines=count,dense_lines=v//500,frequency_positions=R,
                         char_frac=pchar,gauss_frac=pgauss,character_transforms=2*R*count,gauss_transforms=count))
    groups=Counter()
    gauss=Counter()
    for r in rows:
        groups[r['char_frac']]+=r['character_transforms']
        gauss[r['gauss_frac']]+=r['gauss_transforms']
    scenarios.append(dict(extra_nodes=scenario['extra_nodes'],rows=rows,char_by_p=groups,gauss_by_p=gauss))
print(json.dumps(dict(ledger_sha256=hashlib.sha256(meta_path.read_bytes()).hexdigest(),scenarios=scenarios),indent=2))
