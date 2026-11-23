"""Separate native table generation, HOL kernel arithmetic and standalone HOL replay."""
from collections import defaultdict
from hashlib import sha256
import json
from pathlib import Path
from statistics import mean, median

HERE=Path(__file__).resolve().parent


def accepted(stem):
    lines=(HERE/(stem+".log")).read_text().splitlines()
    assert (HERE/(stem+".status")).read_text().strip()=="0" and "COEFFICIENT_TRANSLATION_DONE" in lines
    for line in (HERE/(stem+".sha256")).read_text().splitlines():
        digest,path=line.split(maxsplit=1)
        assert sha256((HERE/path.strip()).read_bytes()).hexdigest()==digest
    return lines


def main():
    timed=accepted("coeff01")
    fresh=accepted("fresh01")
    assert any(line.startswith("SLAB bad 0 ") for line in fresh)
    native=json.loads((HERE/"panels.json").read_bytes())
    times=defaultdict(dict)
    whole=defaultdict(list)
    for line in timed:
        if line.startswith("SLAB "):
            _,tag,trial,secs,decode=line.split()
            b,n=map(int,tag.split("_"))
            times[b,n][int(trial)]=float(secs)
    for line in fresh:
        if line.startswith("FRESH "):
            _,b,ix,secs=line.split()
            whole[int(b)].append(float(secs))
    bands=[]
    for row in native["bands"]:
        b=row["band"]
        assert len(whole[b])==3 and all(len(times[b,n])==5 for n in (0,1,3))
        groups=row["seed_groups"]
        ds=[(times[b,3][i]-times[b,0][i])/3 for i in range(5)]
        assert median(ds)>0
        bands.append(dict(band=b,groups=groups,degree=row["degree"],seconds_per_new_group=whole[b],
            marginal_seconds_per_group=ds,marginal_kernel_hours=median(ds)*groups/3600,
            standalone_hol_hours=mean(whole[b])*groups/3600,
            native_hours=row["extrapolated_one_thread_hours"]))
    summ=lambda k:sum(r[k] for r in bands)
    groups=sum(r["groups"] for r in bands)
    seeds=sum(r["groups"]*(r["degree"]+1) for r in bands)
    total=summ("standalone_hol_hours")+summ("native_hours")
    out=dict(bands=bands,seed_groups=groups,certifiable_complex_seeds_required=seeds,
        marginal_kernel_hours=summ("marginal_kernel_hours"),standalone_hol_hours=summ("standalone_hol_hours"),
        native_generation_hours=summ("native_hours"),priced_table_hours=total,
        hol_three_spatial_height_draws=[sum(r["groups"]*r["seconds_per_new_group"][i]/3600 for r in bands)
                                        for i in range(3)],
        excluded="Analytic certification of the seeds, certified ungrouped endpoint cells, packing lemmas, persistent proof transport and scheduling.",
        hashes={s:sha256((HERE/s).read_bytes()).hexdigest() for s in ("coeff01.log","fresh01.log","panels.json","kernel-input.txt","fresh-input.txt")})
    (HERE/"costs.json").write_text(json.dumps(out,indent=2)+"\n")
    print({k:v for k,v in out.items() if k not in ("bands","hashes","excluded")})


if __name__=="__main__":
    main()
