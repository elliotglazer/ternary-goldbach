from pathlib import Path
import json
from flint import arb,ctx
ctx.prec=320
p=Path(__file__).resolve().parent;rows=json.loads((p/'inputs.json').read_text())
inputs=[(arb(n).log(),1/arb(n).sqrt()) for n in range(1,3990)]
out=[]
for tick,h,pi,j,v in rows:
    t=arb(tick)/1024;P=arb.pi();s=(t/(2*P)).sqrt();z=1-2*(s-3989)
    J=(P*(z*z+arb(3)/4)/2).cos()/(P*z).cos()/s.sqrt()
    H=t*(t/(2*P)).log()/2-t/2-P/8+1/(48*t)
    A=J+2*sum((w*(H-t*l).cos() for l,w in inputs),arb(0));E=arb(451)/1000/t**(arb(3)/4)
    diff=abs(A-arb(v)/2**128);assert diff < arb(44)/10**16 and A < -E
    out.append(dict(tick=tick,center=str(arb(v)/2**128),arb_K=str(A),abs_diff=str(diff),tail=str(E)))
(p/'arb-check.json').write_text(json.dumps(out,indent=2)+'\n')
