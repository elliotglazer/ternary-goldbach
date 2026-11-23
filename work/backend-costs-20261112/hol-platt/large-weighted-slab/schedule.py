"""Count horizontal table use, input buffering and raw-pool replication."""
import hashlib
import json
from math import ceil
from pathlib import Path

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
PATH=HOL.parents[1]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
CELLS=1025


def fold():
    m=json.loads(PATH.read_bytes())
    rows=sorted((c,phi,J+41) for c,phi,_,_,J,_,_ in m["conductors"])
    assert len(rows)==125400
    useful=sum(phi*min(6401,j) for c,phi,j in rows)
    assert useful==44739119112240
    results=[]
    rates=json.loads((HERE/"rates.json").read_bytes())["cases"]
    for K in (8,32,128,512):
        chunks=[rows[i:i+K] for i in range(0,len(rows),K)]
        for H in (8,32):
            passes=pad=peak=raw=raw_steps=table_pairs=0
            for group in chunks:
                largest_j=max(j for _,_,j in group)
                band_j=min(6401,largest_j)
                blocks=(band_j+H-1)//H
                passes+=blocks*CELLS
                pad+=sum(phi*((-min(j,6401))%H) for c,phi,j in group)
                # Two grid94 coordinates in 120-bit fields. This is the
                # array for all actual units in H consecutive heights.
                peak=max(peak,sum(phi for _,phi,_ in group)*H*30)
                # Simple replicated whole raw state pool at each block. One
                # pair per positive base including the conductor factor.
                cmax=group[-1][0]
                raw+=ceil(largest_j/H)*cmax
                raw_steps+=max(0,largest_j-1)*cmax
                for lo,hi,F in [(0,6401,1024),(6401,12801,2048),(12801,25601,4096),
                                (25601,64001,8192),(64001,largest_j,16384)]:
                    table_pairs+=max(0,min(hi,largest_j)-lo)*(F+1)*20
            rs=[r for key,r in rates.items() if key.endswith("n"+str(H))]
            assert len(rs)==2
            # Same per-residue times and fixed control cost as the observed
            # eight-conductor panel. Kernel admission and IO are separate.
            components=[]
            for r in rs:
                slope=r["marginal_us"]["groups_0_to_8"]["median_us"]
                components.append(dict(slope=slope,
                    productive_kernel_hours=(useful+pad)*slope/3.6e9,
                    fixed_kernel_hours=passes*r["fixed_control_s"]/3600))
            results.append(dict(conductors_per_group=K,heights_per_block=H,band1_cell_block_calls=passes,
                                unused_residue_height_lanes=pad,active_units_band1=useful,
                                max_raw_bytes_for_one_eight_or_32_height_residue_buffer=peak,
                                five_band_P20_complex_coefficient_deliveries_within_groups=table_pairs,
                                raw_full_pool_pairs_admitted_once_per_block=raw,
                                raw_full_pool_updates_if_replicated_across_groups=raw_steps,
                                band1_kernel_sensitivities=components))
    return dict(manifest_sha256=hashlib.sha256(PATH.read_bytes()).hexdigest(),schedules=results,
                full_band1_one_write_bytes=useful*30)


if __name__=="__main__":
    r=fold()
    (HERE/"schedule.json").write_text(json.dumps(r,indent=2)+"\n")
    for row in r["schedules"]:
        print(row["conductors_per_group"],row["heights_per_block"],
              row["max_raw_bytes_for_one_eight_or_32_height_residue_buffer"],
              [round(v["productive_kernel_hours"]+v["fixed_kernel_hours"]) for v in row["band1_kernel_sensitivities"]])
