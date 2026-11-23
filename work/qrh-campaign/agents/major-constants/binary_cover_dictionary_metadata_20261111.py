"""Integer layout and abstract Boolean checks, without any prime bitmap or candidates."""
from pathlib import Path
from hashlib import sha256
import json
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3]
checks=0
def ck(b):
    global checks
    assert b
    checks+=1
# Abstract source bits only: their prime interpretation is a theorem premise.
L,D=4,2
for source in range(1<<(L+D)):
    rows=[sum(((source>>(t+s))&1)<<s for s in range(D+1)) for t in range(L)]
    minimal=sorted({h for h in rows if not any(g!=h and (g&h)==g for g in rows)})
    for available in range(1<<(D+1)):
        direct=all(h&available for h in rows)
        reduced=all(h&available for h in minimal)
        ck(direct==reduced)
    for h in rows:ck(any((g&h)==g for g in minimal))
    # A full template requires only its selected bits, not all palette bits.
    for template in range(1<<(D+1)):
        if all(h&template for h in rows):
            for available in range(1<<(D+1)):
                if (template&available)==template:ck(all(h&available for h in rows))

layout=[]
for B in [10**15,10**16,4*10**18]:
    E=B//2; L=2**32; D=2**19; W=2**18
    R=E//L; last=E-R*L+1
    ck(L-2+(R-1)*L+last==E-1)
    ck(1<=last<=L and L>=D+2)
    layout.append(dict(B=B,L=L,D=D,outer_blocks=R,last_width=last,initial_targets=L-2,
       full_template_tiles=(L+W-1)//W,actual_outer_tiles=(R-1)*((L+W-1)//W)+(last+W-1)//W))
paths=[
'work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md',
'work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md',
'work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md',
'work/qrh-campaign/agents/prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md',
'work/formal-goldbach-bench/architecture.md',
'work/formal-goldbach-bench/lean/KernelBench.lean',
'work/formal-goldbach-bench/lean/SourceProofs.lean',
'work/ternary-goldbach/TernaryGoldbach/Statement.lean',
'work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean']
out=dict(scope='Abstract Boolean exhaustive checks and integer endpoints only; no prime values',checks=checks,layout=layout,
 input_sha256={p:sha256((ROOT/p).read_bytes()).hexdigest().upper() for p in paths})
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8') as f:json.dump(out,f,indent=2);f.write('\n')
print(json.dumps(dict(checks=checks,layout=layout),indent=2))
