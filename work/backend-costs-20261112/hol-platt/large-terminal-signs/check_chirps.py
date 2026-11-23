from pathlib import Path
from flint import arb,acb,ctx
d=Path(__file__).resolve().parent
ctx.prec=160
for p in [24,28]:
 s=2**p
 actual=[tuple(map(int,l.split())) for l in (d/f'fu{p}h1ws.txt').read_text().splitlines()]
 for j,(u,v) in enumerate(actual):
  c=acb(0,arb.pi()*(j*j%120)/60).exp()
  assert abs(c.real*s-u)<1 and abs(c.imag*s-v)<1
 print(p,len(actual),'strict component error < 1')
