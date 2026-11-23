"""Show what the four-channel rates imply if assumed throughout the small family."""
from fractions import Fraction as F
import json
from math import ceil
from spectrum import HERE,SOURCE


def run():
    observed=json.loads((HERE/"results.json").read_bytes())
    table=json.loads(SOURCE.read_bytes())["scenarios"][-1]["small_sign_only_conditional_candidate"]
    assert table["raw_metadata"][0][0]==3
    # Recompute the actual output population from the imported arithmetic character layouts.
    from plan import layout
    from math import prod
    labels=coarse=0
    classes=set()
    tilt=dict(table["conductor_theta"])
    for c,m,n,*_ in table["raw_metadata"]:
        _,_,_,keep=layout(c)
        count=prod(keep)
        labels+=count
        coarse+=count*(m+1)
        classes.add((c%2,n,tilt[c]))
    assert labels==18477108 and coarse==1787257220237
    rates=observed["hol_count"]["admit_evaluate_decode_cpu"]
    coarse_seconds=sum(rates)/observed["scanned"]
    interior_per_cell=F(observed["sparse_interior"],observed["coarse"]-4)
    calcs=[]
    for edges in (4,6):
        interiors=ceil(interior_per_cell*(coarse-labels))
        jobs=interiors+edges*labels
        # Remove the excluded 0,T,H coarse samples on each label for that last guard.
        scan=coarse-3*labels+jobs
        calcs.append(dict(edge_probes_per_label=edges,interior_jobs=interiors,edge_jobs=edges*labels,
            count_phase_cpu_hours=scan*coarse_seconds/3600,
            count_whole_process_cpu_hours=scan*observed["hol_count"]["process_cpu"]/(observed["scanned"]*3600),
            sparse_dot_phase_cpu_hours=jobs*sum(observed["hol_sparse"]["admit_evaluate_cpu"])/((observed["sparse_interior"]+observed["endpoint"])*3600),
            sparse_whole_process_cpu_hours=jobs*observed["hol_sparse"]["process_cpu"]/(114*3600),
            discovery_cpu_hours=coarse*observed["discovery_cpu"]/observed["coarse"]/3600))
    out=dict(conditional_assumption="Apply four channels' observed interior-probe frequency and unit processing rates to every small-family character. This is not a sampling estimate.",
             conductors=7499,labels=labels,coarse_640=coarse,interior_probe_per_cell=float(interior_per_cell),
             order_offset_kernels_at_most=9*4095,radius_parameter_classes=len(classes),
             order_radius_checks_at_most=9*len(classes),
             scenarios=calcs)
    (HERE/"sensitivity.json").write_text(json.dumps(out,indent=2)+"\n")
    print(out)


if __name__=="__main__":
    run()
