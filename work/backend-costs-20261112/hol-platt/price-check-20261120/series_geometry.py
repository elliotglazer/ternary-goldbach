"""Count the band-1 workload on which a dense polynomial sequence could be useful."""

import hashlib
import json
from collections import Counter
from itertools import groupby
from pathlib import Path


HERE = Path(__file__).resolve().parent
HOL = HERE.parent
MANIFEST = HOL.parents[1]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
LIMITS = HOL/"c10004-effective-degree/counts.json"


def main():
    manifest = json.loads(MANIFEST.read_bytes())
    effective = json.loads(LIMITS.read_bytes())
    limits = {int(k):v for k,v in effective["degree_zero_through_height_index"].items()}
    degrees = [max(j for j,hmax in limits.items() if h > hmax) for h in range(6401)]
    bands = []
    start = 0
    for d, group in groupby(degrees):
        length = sum(1 for _ in group)
        bands.append((start,start+length,d))
        start += length
    result = {ratio:Counter() for ratio in (2,4,8)}
    for c, phi, _, _, j, _, _ in manifest["conductors"]:
        stop = min(6401,j+41)
        for lo,hi,d in bands:
            heights = min(hi,stop)-lo
            if heights <= 0:
                break
            for ratio, r in result.items():
                r["all_unit_residues"] += heights*phi
                if phi < ratio*1025*(d+1):
                    r["units_retaining_direct"] += heights*phi
                    continue
                r["eligible_unit_residues"] += heights*phi
                r["dense_numerators_including_nonunits"] += heights*(c-1)
                r["cell_evaluations"] += heights*1025
                r["max_initial_direct_evaluations"] += heights*1025*(d+1)
    expected = next(x["residues"] for x in effective["scenarios"]
                    if x["extra"]==0 and x["guards"]==41)
    for r in result.values():
        assert expected == r["all_unit_residues"]
        assert r["eligible_unit_residues"] + r["units_retaining_direct"] == expected
    return {"scope":"scenario zero, 41 guards, band 1; select series if phi >= ratio*1025*(d+1)",
            "input_sha256":{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (MANIFEST,LIMITS)},
            "min_units_per_initial_value":result}


if __name__ == "__main__":
    print(json.dumps(main(),indent=2))
