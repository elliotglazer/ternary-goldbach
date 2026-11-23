"""Tally scheduled heights by their residue modulo five."""
import ast
from collections import Counter
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path

out=Path(__file__).resolve().parent
agents=out.parents[2]/'qrh-campaign/agents'
small=agents/'prime-estimates/small_family_minimal_theta_20261111.py'
large=agents/'integration/transform_structural_manifest_20261111.json'
funcs=[n for n in ast.parse(small.read_bytes()).body if isinstance(n,ast.FunctionDef) and n.name in ['factors','height','cdata','ceil']]
env={'F':F}
exec(compile(ast.Module(body=funcs,type_ignores=[]),str(small),'exec'),env)
sc=Counter()
lc=Counter()
for q in range(3,10001):
    if q%2==0 and q%4!=0: continue
    H=env['height'](q)
    sc[H%5]+=env['cdata'](q)[1]
for q,phi,n,H,*_ in json.loads(large.read_bytes())['conductors']:
    assert q>10000
    lc[H%5]+=n
assert sum(sc.values())==18477108
report=dict(residues=list(range(5)),small=[sc[r] for r in range(5)],large=[lc[r] for r in range(5)],
            units='primitive characters, principal excluded',sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in [small,large]})
(out/'endpoint-population.json').write_text(json.dumps(report,indent=2))
print(report)
