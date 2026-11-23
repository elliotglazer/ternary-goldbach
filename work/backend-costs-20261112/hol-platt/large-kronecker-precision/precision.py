"""Recheck the large Fourier error budget for exact-convolution axes."""

import hashlib
import json
from collections import Counter
from pathlib import Path


HERE = Path(__file__).resolve().parent
HOL = HERE.parent
AGENTS = HOL.parents[1] / "qrh-campaign/agents"
Q = 2**52
CG = 1266 * 202305920 * 16384
V = 8828


def admissible(c, phi, s, old_peak, old_base, p):
    if (1<<p) < max(old_peak,2*old_base):
        return False
    radius = (Q-1)*int(p<100) + Q*s*V
    return (phi*radius)**2 << (2*(108-p)) <= c*((Q-1)*CG)**2


def main():
    sources = [AGENTS/"integration/transform_structural_manifest_20261111.json",
               AGENTS/"major-constants/combined_conductor_precision_rows_20261111.json",
               AGENTS/"major-constants/combined_conductor_precision_nodes_20261111.json"]
    raw, tables, nodes = [json.loads(f.read_bytes()) for f in sources]
    local = {r[0]:r[5] for r in nodes["rows"]}
    original, candidate, drops, eligible_constants = (Counter() for _ in range(4))
    scalar_bytes_old, scalar_bytes_new, slice_count = 0, 0, 0
    worst_example = None
    for i,(row,price) in enumerate(zip(raw["conductors"],tables["rows"],strict=True)):
        c,phi,prim,_,j,axes,_ = row
        if price[:4] != [i,c,phi,prim]:
            raise ValueError("conductor join")
        s0 = sum(local[n] for n,_ in axes)
        s1 = sum(4 if n>=32 else local[n] for n,_ in axes)
        _,_,_,_,_,_,saved_s,old_base,peak,_,_,p0,rho = price
        if s0!=saved_s or rho!=int(p0<100) or not admissible(c,phi,s0,peak,old_base,p0):
            raise ValueError("saved error contract does not reproduce")
        if p0>80 and admissible(c,phi,s0,peak,old_base,p0-1):
            raise ValueError("saved p is not minimal under original contract")
        if not admissible(c,phi,s1,peak,old_base,p0):
            raise ValueError(f"new circuit does not fit old precision at c={c}")
        p1 = next(p for p in range(80,p0+1) if admissible(c,phi,s1,peak,old_base,p))
        original[p0]+=1
        candidate[p1]+=1
        drops[p0-p1]+=1
        if worst_example is None or s1>worst_example["new_S"]:
            worst_example=dict(c=c,old_S=s0,new_S=s1,old_p=p0,new_p=p1)
        prior,kept,rest=1,1,phi
        for n,q in axes:
            rest//=n
            if n>=32:
                eligible_constants[local[n]]+=1
                slices = (j+41)*kept*rest
                def one_operand(p):
                    scale=1<<p
                    cap=2*prior*16384
                    bound=2*n*(2*cap*scale+2)*scale
                    return n*((bound.bit_length()+8)//8)
                slice_count += slices
                scalar_bytes_old += slices*one_operand(p0)
                scalar_bytes_new += slices*one_operand(p1)
            prior*=n
            kept*=n if q==0 else n-n//q
        if prior!=phi or kept!=prim:
            raise ValueError("axis dimensions")
    assert slice_count==269921342390
    return dict(conductors=sum(original.values()),old_precision=original,new_precision=candidate,
                reductions_in_bits=drops,min_old_coefficient_on_replaced_axes=min(eligible_constants),
                max_new_coefficient_sum_row=worst_example,eligible_slice_count=slice_count,
                summed_one_operand_capacity_bytes_old=scalar_bytes_old,
                summed_one_operand_capacity_bytes_new=scalar_bytes_new,
                input_sha256={str(f.relative_to(AGENTS)):hashlib.sha256(f.read_bytes()).hexdigest()
                              for f in sources})


if __name__=="__main__":
    print(json.dumps(main(),indent=2))
