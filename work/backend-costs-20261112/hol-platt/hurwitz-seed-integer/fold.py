"""Replace the sparse observation row and add the independently timed seed arithmetic."""
from hashlib import sha256
from pathlib import Path
import json

HERE=Path(__file__).resolve().parent
HOL=HERE.parent


def main():
    pins={}
    def read(path):
        data=path.read_bytes()
        pins[str(path.relative_to(HOL))]=sha256(data).hexdigest()
        return json.loads(data)
    projected=read(HOL/"guard-repricing/consumer_scenario.json")["priced_including_two_streams"]
    old=read(HOL/"guard-repricing/guard.json")["scenarios"]["640"]["small_sparse_observations"]
    sparse=read(HOL/"sparse-hol-panel/three-conductor-price.json")["missing_stratum_scenarios"]
    totals=read(HERE/"price.json")["total"]
    seeds=totals["arithmetic_plus_phase_hours"]
    variants={}
    for phase in ("inner_h","pair_h"):
        rows={}
        for key,r in sparse.items():
            diff=r[phase]-old
            rows[key]={geom:[x+diff+seeds for x in xs] for geom,xs in projected.items()}
        flat=[x for r in rows.values() for p in r.values() for x in p]
        envelope=[min(flat),max(flat)]
        variants[phase]=dict(by_missing_stratum=rows,partial=envelope,
                             with_principal_integer_pilot=[envelope[0]+20500,envelope[1]+22200],
                             headroom_to_twofold_with_principal=[800000-envelope[1]-22200,800000-envelope[0]-20500])
    report=dict(guard=640,previous_observation_hours=old,seed_kernel_and_phase_hours=seeds,
                variants=variants,hashes=pins,
                principal_reference="../principal-rs-hol/README.md",
                scope="Fixed-grid guarded layout. The inner_h route keeps the separately priced raw projection. The pair_h sensitivity consumes already-produced head packets directly, subject to a certified packed interface and lookup costs. Both use the generic compressed-sign transfer and exclude a second raw-window replay. Bounds on analytic source errors, repairs across the campaign, phase-vector transport, large-conductor terminal signs, principal correction and proof assembly remain separate. Endpoints are named scenarios.")
    (HERE/"fold.json").write_text(json.dumps(report,indent=2)+"\n")
    for k,v in variants.items():
        print(k,v["partial"],v["with_principal_integer_pilot"])


if __name__=="__main__":
    main()
