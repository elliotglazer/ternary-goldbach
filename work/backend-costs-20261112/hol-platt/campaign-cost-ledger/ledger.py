"""Bind guard populations and project mutually explicit small-family count interfaces."""
import hashlib,json,math,sys
from pathlib import Path
from fractions import Fraction as F

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/"time-pruning"))
from count_time_fft import SOURCE,primitive_count

pins={}
def read(p):
    data=p.read_bytes()
    pins[p.name+"@"+p.parent.name]=hashlib.sha256(data).hexdigest()
    return json.loads(data)


def main():
    schedules=read(SOURCE)["scenarios"]
    base=read(HOL/"small-gaussian/costs.json")["new_partial_hours"]
    raw=read(HOL/"grid-projection/results.json")
    join=read(HOL/"grid-sign-join/results.json")
    older=read(HOL/"full-height-count/results.json")
    small_sensitivity=read(HOL/"full-height-count/sensitivity.json")
    large=read(SOURCE.parent.parent/"integration/short_window_guard_ledger_20261111.json")["scenarios"]
    measured=join["samples_including_halos"]
    assert measured==raw["full"]["samples"]==340484
    nlabels=small_sensitivity["labels"]
    rows=[]
    for obj,lg in zip(schedules,large,strict=True):
        e=obj["extra_nodes"]
        assert e==lg["extra_nodes"]
        small=obj["small_sign_only_conditional_candidate"]["raw_metadata"]
        totals=[(primitive_count(c),m) for c,m,n,*_ in small]
        assert len(totals)==7499 and sum(z for z,_ in totals)==nlabels==18477108
        coarse=sum(z*(m+1) for z,m in totals)
        halo=256*nlabels
        population=coarse+halo
        factor=population/(measured*3600)
        proj={k:factor*raw["full"][k] for k in ["worker","numerals","check","process"]}
        joined=factor*join["phase_cpu"]
        joint_eval=factor*sum(sum(x["eval"]) for x in join["channels"])
        # Alternative packet-count/targeted-dot route from earlier experiment.
        # Its numerical edges are not observed campaign counts.
        repairs=[]
        for edge in (4,6):
            jobs=math.ceil(F(older["sparse_interior"],older["coarse"]-4)*(coarse-nlabels))
            njobs=jobs+edge*nlabels
            scans=coarse-3*nlabels+njobs
            repairs.append(dict(edge_per_label=edge,hypothetical_interior=jobs,
              hypothetical_edge=edge*nlabels,
              bit_packet_count_hours=scans*sum(older["hol_count"]["admit_evaluate_decode_cpu"])/(older["scanned"]*3600),
              separate_sparse_dot_hours=njobs*sum(older["hol_sparse"]["admit_evaluate_cpu"])/(114*3600),
              native_discovery_hours=coarse*older["discovery_cpu"]/(older["coarse"]*3600)))
        assumptions={"explicit_two_interfaces":proj["worker"]+joined,
                     "skip_projection_numerals_only":proj["worker"]-proj["numerals"]+joined,
                     "kernel_only_both_boundaries":proj["check"]+joint_eval,
                     "compressed_join_only":joined}
        budget={mode:dict(additional_hours=h,subtotal=[b+h for b in base],
                     remainder_to_800k=[800000-b-h for b in base[::-1]]) for mode,h in assumptions.items()}
        main=lg["old_runtime"]; guard=lg["added_runtime"]
        counts={k:main[k]+guard[k] for k in ["conductor_height_nodes","residue_inputs","primitive_outputs"]}
        rows.append(dict(extra=e,window_grid_units=str(F(5*e,64)),large_plus41=counts,
             small_labels=nlabels,small_conductors=len(small),small_coarse=coarse,
             modeled_extra_halo=halo,modeled_sample_population=population,raw_to_compressed=proj,
             compressed_join_inner=joined,compressed_join_eval_only=joint_eval,
             alternative_packet_model=repairs,conditional_budget=budget))
    assert rows[-1]["small_coarse"]==small_sensitivity["coarse_640"]
    assert abs(rows[-1]["raw_to_compressed"]["worker"]-raw["conditional_core_hours"]["worker"])<1e-6
    result=dict(historical_platt_hours=400000,comparison_target=800000,baseline=base,
                baseline_remainder_to_800k=[800000-b for b in base[::-1]],measured_family_labels=4,
                sample_counts_include_halos=measured,hashes=pins,rows=rows)
    (HERE/"ledger.json").write_text(json.dumps(result,indent=2)+"\n")


if __name__=="__main__":
    main()
