"""Apply measured kernel CPU times to both schedules using the original probability sample."""
from collections import defaultdict
from hashlib import sha256
import json
from math import sqrt
from statistics import mean,median,stdev

from plan import HERE,inventory


def read(path):
    return json.loads(path.read_bytes())


def checked(label,marker):
    assert (HERE/(label+".status")).read_text().strip()=="0"
    for entry in (HERE/(label+".sha256")).read_text().splitlines():
        digest,name=entry.split(maxsplit=1)
        assert sha256((HERE/name).read_bytes()).hexdigest()==digest
    log=(HERE/(label+".log")).read_text()
    assert marker in log
    return log


def price():
    checked("theory01","Exporting theory")
    trials=checked("panels02","FFT_DONE")
    actual=checked("actual01","FFT_DONE")
    assert "DAMAGED " in trials
    assert [s.split()[1] for s in actual.splitlines() if s.startswith("ACTUAL ")]==[
        "pre","forward","pointwise","inverse","post"]
    plan=read(HERE/"plan.json")
    inputs=read(HERE/"panels.json")
    cutoff=read(HERE/"cutoff.json")
    old,_=inventory()
    new,totals=inventory({r["c"]:r["transforms"] for r in cutoff["rows"]})
    assert totals==cutoff["folded_character_counts"]
    measured=defaultdict(dict)
    for line in trials.splitlines():
        if line.startswith("FFT_PANEL "):
            _,ix,j,reps,f,c=line.split()
            r=inputs[int(ix)]
            assert r["id"]==int(ix) and r["reps"]==int(reps)
            measured[int(ix)][int(j)]=(float(f.replace("~","-"))-float(c.replace("~","-")))/int(reps)
    assert set(measured)==set(range(len(inputs))) and all(set(v)=={0,1,2} for v in measured.values())
    results={}
    for label,pop in (("original",old),("shorter",new)):
        bands={}
        for name,group in plan["strata"].items():
            total=sum(old[name].values())
            assert total==group["calls_or_scalar_operations"]
            rows=[r for r in inputs if r["stratum"]==name]
            folds=[]
            per_draw=[]
            for row,key in zip(rows,group["draws"],strict=True):
                key=tuple(key)
                assert key==(row["d"],row["p"],row["e"],row["fill"],row["sign"])
                # The original draws were with replacement and proportional to calls
                # within each fixed transform length (or operations in point/add strata).
                # Density ratio preserves the estimator for the thinner schedule.
                ratio=pop[name][key]/old[name][key]
                divisor=1 if row["mode"]==0 else 1<<row["d"]
                repeats=[v*total*ratio/(3600*divisor) for v in measured[row["id"]].values()]
                folds.append(repeats)
                per_draw.append(median(repeats))
            bands[name]=dict(hours=mean(per_draw),between_draw_se=stdev(per_draw)/sqrt(len(per_draw)),
                             calls_or_scalar_operations=sum(pop[name].values()),per_draw_hours=per_draw,
                             three_run_hours=[mean(f[i] for f in folds) for i in range(3)])
        results[label]=dict(strata=bands,hours=sum(b["hours"] for b in bands.values()),
            between_draw_se=sqrt(sum(b["between_draw_se"]**2 for b in bands.values())),
            three_run_hours=[sum(b["three_run_hours"][i] for b in bands.values()) for i in range(3)])
    campaign=read(HERE.parent/"price-check-20261120/short-and-coefficients.json")
    old_price=read(HERE.parent/"price-check-20261120/component-sensitivity.json")["parts"]["small_character_arithmetic_at_old_operation_prices"]
    assert old_price[0]==old_price[1]
    for scenario in results.values():
        scenario["new_partial_hours"]=[x-old_price[0]+scenario["hours"] for x in campaign["priced_subtotal"]]
    result=dict(removed_legacy_price=old_price[0],scenarios=results,original_partial=campaign["priced_subtotal"],
                sha256={n:sha256((HERE/n).read_bytes()).hexdigest() for n in
                        ("plan.json","panels.json","panels.txt","panels02.log","actual01.log","cutoff.json")})
    (HERE/"costs.json").write_text(json.dumps(result,indent=2)+"\n")
    for name,r in results.items():
        print(name,r["hours"],r["between_draw_se"],r["new_partial_hours"],r["three_run_hours"])


if __name__=="__main__":
    price()
