"""Run the 14 externally frozen large-family pairs, with two bounded local workers."""
from concurrent.futures import ThreadPoolExecutor
from fractions import Fraction as F
from hashlib import sha256
from pathlib import Path
from time import process_time
import json
import subprocess
import sys
from flint import dirichlet_char,ctx

out=Path(__file__).resolve().parent
team=out.parent
work=team.parents[1]
hol=work/'backend-costs-20261112/hol-platt'
guard=hol/'guard-repricing'
raw=(guard/'weighted-repair-panel.json').read_bytes()
assert sha256(raw).hexdigest()=='343e001fb602519fa59b487928ded5972a3e700475a0cb36a99dba97cde2f43e'
requests=json.loads(raw)['selection']
def folder(i): return out/f'{i:02d}-q{requests[i]["q"]}'
if len(sys.argv)==1:
    def run(i):
        p=folder(i)
        p.mkdir(exist_ok=True)
        with (p/'worker.log').open('w') as log:
            try: code=subprocess.run([sys.executable,__file__,str(i)],stdout=log,stderr=subprocess.STDOUT,timeout=480).returncode
            except subprocess.TimeoutExpired: code='timeout'
        (p/'status.json').write_text(json.dumps(dict(index=i,exit=code)))
        print(i,requests[i]['q'],code,flush=True)
        return code
    with ThreadPoolExecutor(2) as ex: status=list(ex.map(run,range(len(requests))))
    (out/'status.json').write_text(json.dumps(status))
    sys.exit(int(any(s!=0 for s in status)))

i=int(sys.argv[1])
p=folder(i)
req=requests[i]
q,T,a,b,par=[req[k] for k in ('q','height','label','inverse','parity')]
assert a*b%q==1 and a!=b and all(dirichlet_char(q,l).is_primitive() and dirichlet_char(q,l).parity()==par for l in (a,b))
main=(64*T+4)//5; last=main+640; V=F(5*last,64)
for theta in range(64,121):
    W=q*V/theta; eps=F(1,2**82*3**theta); K=L=1
    while 128*W*W*F(3,8)**K>=eps: K+=1
    while 48*W*F(3,8)**L>=eps: L+=1
    if F(8,3)**20>=W*(20+L): break
assert F(8,3)**20>=W*(20+L) and V>=2*theta and W>=1
n0=8192
while True:
    v0=3*n0*n0/W; z0=3*(2*n0+1)/W-F(1,n0)
    if v0>=2 and z0>0 and 88*n0*(1+1/z0)*F(3,8)**int(v0)<eps/8: break
    n0*=2
N=1
while F(5*N,64)<max(2*V*K/theta,V+2*K,6): N*=2
J=(25*N+191)//192
assert J<N//2 and last+128<N
(p/'selector.json').write_text(json.dumps(dict(request=req,V=str(V),W=str(W),N=N,J=J,K=K,L=L,n0=n0,theta=theta),indent=2))
source=team/'high-conductor-pilot'
def once(s,old,new):
    assert s.count(old)==1,old
    return s.replace(old,new)
s=once((source/'spectrum.py').read_text(),'Q = 265800',f'Q = {q}')
s=once(s,'BASE_LABELS = (9539,)',f'BASE_LABELS = ({a},)')
s=once(s,'== [0,0]',f'== [{par},{par}]')
s=once(s,'return 3072, 3712, 32768, 4267, 64',f'return {main}, {last}, {N}, {J}, {theta}')
s=once(s,'    weights = [[z*(n if h>=2 else 1)','    parity = [dirichlet_char(Q,l).parity() for l in LABELS]\n    weights = [[z*(n if parity[h] else 1)')
s=once(s,'arb(1 if h<2 else 3)','arb(1+2*parity[h])')
if q%2:
    s=once(s,'second = (-8*z).exp()','second = (-2*z).exp()')
    s=once(s,'range(residue,m+1,48)','range(residue,m+1,24)')
    s=once(s,'4*i0+4','2*i0+1')
    s=once(s,'min(i0+48,m+1),2','min(i0+24,m+1)')
(p/'spectrum.py').write_text(s)
g=once((source/'grid.py').read_text(),'if j in (0,1,main,last):','if j in (-1,0,1,main,last):')
(p/'grid.py').write_text(g)
r=(source/'repair.py').read_text().replace('240*64',f'{T}*64').replace('T="240"',f'T="{T}"')
r=once(r,'a = 0 if pair==LABELS[:2] else 1',f'a = {par}')
r=once(r,'2*(80000000//theta)**2+1',f'2*F({W.numerator},{W.denominator})**2+1')
(p/'repair.py').write_text(r)
sys.path.insert(0,str(p))
sys.path.extend([str(hol/'one-character-completeness'),str(hol/'small-character-kernel'),str(guard)])
import spectrum,grid,repair
assert spectrum.LABELS==(a,b)
for stage in (spectrum,grid,repair):
    stage.run()
subprocess.run([sys.executable,str(team/'high-conductor-full/inclusive.py'),'--round-main',str(p)],check=True)
import strip_repair_panel as strip
ctx.prec=192
start=process_time()
packets=[]
result=strip.run(p,packets)
result['short_cpu_seconds']=process_time()-start
(p/'short.json').write_text(json.dumps(result,indent=2))
(p/'packets.tsv').write_bytes(('\n'.join('\t'.join(map(str,x)) for x in packets)+'\n').encode())
