from pathlib import Path
from fractions import Fraction
from math import factorial
import json
p = Path(__file__).resolve().parent
rows = iter((p.parent / "full-height-count/stencils.txt").read_text().splitlines())
count = int(next(rows))
omega = Fraction(44*68267,7*524288)
C = (2*68267+1)*(2*1250000**2+1)
mass = json.loads((p/"coefficient-mass.json").read_text())
observed = max(row["symmetric_l1_raw"] for row in mass["channels"])
assert observed + 2*(2*68267+1) <= 441000 * (1<<256)
receipts = []
for expected in range(count):
    idx, r, f, den, _ = map(int, next(rows).split())
    ws = list(map(int,next(rows).split()))
    assert idx == expected and len(ws) == r
    h = r//2
    # Work in coordinates centered at coarse node zero. Translation may rotate
    # a Fourier coefficient, for which twice the original L1 is sufficient.
    K = 2*r+64
    u = list(range(1-h,h+1))
    powers = [1]*r
    x = Fraction(f,4096)
    xpower = Fraction(1)
    wfactor = Fraction(1)
    error = Fraction()
    for k in range(K+1):
        if k == K:
            moment = abs(xpower) + Fraction(sum(abs(v*t) for v,t in zip(ws,powers)),den)
        else:
            moment = abs(xpower - Fraction(sum(v*t for v,t in zip(ws,powers)),den))
            if k<r:
                assert moment == 0
        error += moment*wfactor
        powers = [a*b for a,b in zip(powers,u)]
        xpower *= x
        wfactor *= omega/(k+1)
    allowed = C*omega**r*factorial(h)**2/factorial(r)
    assert 2*C*error <= allowed
    receipts.append(dict(idx=idx,order=r,terms=K,shared_slack_floor=allowed//(2*C*error), slack_floor=allowed//(882000*error)))
(p/"moment-rates.json").write_text(json.dumps(receipts,indent=2)+"\n")
print(len(receipts), min(row["slack_floor"] for row in receipts), max(row["order"] for row in receipts))

