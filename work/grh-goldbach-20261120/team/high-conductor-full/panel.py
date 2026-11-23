"""Precommit both parity pairs at two nonadjacent conductors and test the scheduled heights."""
from fractions import Fraction as F
from hashlib import sha256
from math import gcd
from pathlib import Path
import json
import subprocess
import sys
from flint import dirichlet_char

here=Path(__file__).resolve().parent
team=here.parent
work=team.parents[1]
source=team/'q10004-gaussian'
manifest=work/'qrh-campaign/agents/integration/transform_structural_manifest_20261111.json'
odd_panel='--odd' in sys.argv
if odd_panel:
    sys.argv.remove('--odd')
conductors=[65537,132899] if odd_panel else [65536,180180]
def once(s,old,new):
    assert s.count(old)==1,old
    return s.replace(old,new)

if __name__=='__main__' and len(sys.argv)==1:
    raw=manifest.read_bytes()
    rows={r[0]:r for r in json.loads(raw)['conductors'] if r[0] in conductors}
    for q in conductors:
        out=team/f'gaussian-panel-q{q}'
        out.mkdir(exist_ok=True)
        path=out/'freeze.json'
        if path.exists(): continue
        best=[None,None]
        counts=[0,0]
        for a in range(1,q):
            if gcd(a,q)!=1: continue
            b=pow(a,-1,q)
            if a>=b: continue
            char=dirichlet_char(q,a)
            if not char.is_primitive(): continue
            i=char.parity()
            counts[i]+=1
            key=f'repair-v1/{q}/{a}/{b}'
            candidate=(sha256(key.encode()).hexdigest(),a,b,key)
            if best[i] is None or candidate<best[i]: best[i]=candidate
        path.write_text(json.dumps(dict(rule='Minimum SHA-256 per primitive inverse-pair parity; q selected in advance',
            row=rows[q],manifest_sha256=sha256(raw).hexdigest(),candidates=counts,selected=best),indent=2))
    for q in conductors:
        subprocess.run([sys.executable,__file__,str(q)]+(['--odd'] if odd_panel else []),check=True,timeout=480)
elif __name__=='__main__':
    q=int(sys.argv[1])
    assert q in conductors
    out=team/f'gaussian-panel-q{q}'
    frozen=json.loads((out/'freeze.json').read_bytes())
    T=frozen['row'][3]
    main=(64*T+4)//5
    last=main+640
    V=F(5*last,64)
    for theta in range(64,97):
        W=q*V/theta
        eps=F(1,2**82*3**theta)
        K=L=1
        while 128*W*W*F(3,8)**K>=eps: K+=1
        while 48*W*F(3,8)**L>=eps: L+=1
        if F(8,3)**20>=W*(20+L): break
    assert F(8,3)**20>=W*(20+L) and V>=2*theta and W>=1
    n0=8192
    while True:
        v0=3*n0*n0/W
        z0=3*(2*n0+1)/W-F(1,n0)
        if v0>=2 and z0>0 and 88*n0*(1+1/z0)*F(3,8)**int(v0)<eps/8: break
        n0*=2
    N=1
    while F(5*N,64)<max(2*V*K/theta,V+2*K,6): N*=2
    J=(25*N+191)//192
    assert J<N//2 and last+128<N
    even,odd=frozen['selected']
    base=(even[1],odd[1])
    labels=(even[1],even[2],odd[1],odd[2])
    parities=[dirichlet_char(q,l).parity() for l in labels]
    assert parities==[0,0,1,1] and all(dirichlet_char(q,l).is_primitive() for l in labels)
    params=dict(q=q,T=T,V=str(V),W=str(W),theta=theta,N=N,J=J,K=K,L=L,n0=n0,labels=labels)
    (out/'selector.json').write_text(json.dumps(params,indent=2))
    print(params,flush=True)
    s=once((source/'spectrum.py').read_text(),'Q = 10004',f'Q = {q}')
    s=once(s,'BASE_LABELS = (6559, 5499)',f'BASE_LABELS = {base}')
    s=once(s,'return 84199, 84839, 524288, 68267, 64',f'return {main}, {last}, {N}, {J}, {theta}')
    s=once(s,'    weights = [[z*(n if h>=2 else 1)','    parities = [dirichlet_char(Q,l).parity() for l in LABELS]\n    weights = [[z*(n if parities[h] else 1)')
    s=once(s,'arb(1 if h<2 else 3)','arb(1+2*parities[h])')
    if q%2:
        # Summing all n handles nonzero chi(2); the character table kills nonunits.
        s=once(s,'second = (-8*z).exp()','second = (-2*z).exp()')
        s=once(s,'range(residue,m+1,48)','range(residue,m+1,24)')
        s=once(s,'4*i0+4','2*i0+1')
        s=once(s,'min(i0+48,m+1),2','min(i0+24,m+1)')
    (out/'spectrum.py').write_text(s)
    g=once((source/'grid.py').read_text(),'if j in (0,1,main,last):','if j in (-1,0,1,main,last):')
    (out/'grid.py').write_text(g)
    r=(source/'repair.py').read_text().replace('6578',str(T))
    r=once(r,'a = 0 if pair==LABELS[:2] else 1','from flint import dirichlet_char\n    a = dirichlet_char(Q,pair[0]).parity()\n    assert dirichlet_char(Q,pair[1]).parity()==a')
    r=once(r,'2*(80000000//theta)**2+1',f'2*F({W.numerator},{W.denominator})**2+1')
    (out/'repair.py').write_text(r)
    parent=work/'backend-costs-20261112/hol-platt'
    sys.path.insert(0,str(out))
    sys.path.extend([str(parent/'one-character-completeness'),str(parent/'small-character-kernel')])
    import spectrum,grid,repair
    assert spectrum.LABELS==labels
    for stage in (spectrum,grid,repair):
        print(q,stage.__name__,flush=True)
        stage.run()
