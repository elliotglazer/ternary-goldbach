"""Price the measured short transforms in eight-height packets within each source band."""
from collections import Counter, defaultdict
from hashlib import sha256
import json
from pathlib import Path
from statistics import median
import sys

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
WORLD = HOL.parents[1]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"


def load(path):
    return json.loads(path.read_bytes())


def counts(plan):
    assert sha256(WORLD.read_bytes()).hexdigest() == plan["manifest_sha256"]
    bands = [r["height_indices"] for r in load(HOL/"large-weighted-slab/later-band-budget.json")["bands"]]
    groups, scalar, high_precision = Counter(), Counter(), Counter()
    for _, phi, primitive, _, j, axes, _ in load(WORLD)["conductors"]:
        h = j + 41
        used = [max(0, min(h,hi)-lo) for lo,hi in bands]
        assert sum(used) == h
        packets = sum((n+7)//8 for n in used)
        high = any(n>2**17 for n,q in axes)
        prefix, remaining = 1, phi
        for n,q in axes:
            remaining //= n
            if n < 32:
                repeats = prefix * remaining
                scalar[n,q] += h*repeats
                groups[n,q] += packets*repeats
                if high:
                    high_precision[n,q] += packets*repeats
            prefix *= n-(n//q if q else 0)
        assert prefix == primitive and remaining == 1
    assert scalar == {(r["n"],r["q"]): r["slices"] for r in plan["rows"]}
    return groups, high_precision


def fold(stem):
    plan = load(HERE/"plan.json")
    for receipt in ("theory02", stem):
        assert (HERE/(receipt+".status")).read_text().strip() == "0"
        for entry in (HERE/(receipt+".sha256")).read_text().splitlines():
            digest, name = entry.split(maxsplit=1)
            assert sha256((HERE/name.strip()).read_bytes()).hexdigest() == digest, name
    groups, high = counts(plan)
    lines = (HERE/(stem+".log")).read_text().splitlines()
    assert (HERE/(stem+".status")).read_text().strip()=="0" and "SHORT_DONE" in lines
    timings = defaultdict(dict)
    for line in lines:
        if not line.startswith("SHORT "):
            continue
        _, mode, kind, repetitions, trial, seconds = line.split()
        timings[int(mode),kind][int(trial)] = (int(repetitions),float(seconds.replace("~","-")))
    assert timings[0,"bad"].keys()=={0}
    real = load(HERE/"real-inputs.json")
    assert real["conductor"] == 10004 and len(real["pairs"]) == 8
    for band in ("low", "high"):
        for pair in real["pairs"]:
            assert len(timings[1, f"real_{band}_{pair}"]) == 1
    rows = []
    for i,r in enumerate(plan["rows"]):
        assert timings[i,"high"].keys()=={0}
        full,ctrl = timings[i,"full"],timings[i,"control"]
        assert full.keys()==ctrl.keys()==set(range(7))
        reps = full[0][0]
        assert all(rep==reps for rep,t in list(full.values())+list(ctrl.values()))
        dt = [(full[j][1]-ctrl[j][1])/reps for j in range(7)]
        assert median(dt)>0, (i,dt)
        axis = r["n"],r["q"]
        count = groups[axis] - high[axis]
        h = [count*t/3600 for t in dt]
        rows.append(dict(n=axis[0],q=axis[1],packets=count,original_precision_packets=high[axis],
            scalar_slices=r["slices"],repeats=reps,seconds_per_packet=median(dt),
            full_seconds_per_packet=median(t for rep,t in full.values())/reps,
            hours=median(h),paired_hours=h))
    earlier = load(HOL/"wide-band-slab/coefficient-costs.json")["tiles"]["4x4"]["partial_hours"]["24"]
    hours = sum(r["hours"] for r in rows)
    gross = sum(r["packets"]*r["full_seconds_per_packet"]/3600 for r in rows)
    combined = [x+hours for x in earlier]
    out = dict(rows=rows,short_transform_hours=hours,including_comparison_loop_hours=gross,
        seven_whole_run_hours=[sum(r["paired_hours"][j] for r in rows) for j in range(7)],
        scalar_slices=sum(r["slices"] for r in plan["rows"]),all_padded_packets=sum(groups.values()),
        original_precision_packets=sum(high.values()),prior_partial=earlier,partial_with_short_transforms=combined,
        remaining_to_800000=[800000-v for v in combined],log_sha256=sha256((HERE/(stem+".log")).read_bytes()).hexdigest())
    (HERE/"costs.json").write_text(json.dumps(out,indent=2)+"\n")
    print({k:v for k,v in out.items() if k!="rows"})


if __name__=="__main__":
    if sys.argv[1:]==["counts"]:
        gs,hs = counts(load(HERE/"plan.json"))
        print("packets",sum(gs.values()),"at original large-axis precision",sum(hs.values()),hs)
    else:
        fold(sys.argv[1])
