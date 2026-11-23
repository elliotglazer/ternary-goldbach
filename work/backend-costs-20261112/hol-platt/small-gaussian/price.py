"""Price the retained small-conductor Gaussian recurrences using paired HOL4 timings."""
from collections import defaultdict
from hashlib import sha256
import json
from math import sqrt
from pathlib import Path
from statistics import mean, median, stdev

HERE = Path(__file__).resolve().parent
KERNEL = HERE.parent / "small-character-kernel"


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_bytes())


def log_for(label):
    assert (HERE / f"{label}.status").read_text().strip() == "0"
    for line in (HERE / f"{label}.sha256").read_text().splitlines():
        value, name = line.split(maxsplit=1)
        assert digest(HERE / name) == value, name
    return (HERE / f"{label}.log").read_text().splitlines()


def main():
    assert any('Exporting theory "Gauss"' in line for line in log_for("gauss01"))
    lines = log_for("bench01")
    assert "GAUSS_DONE" in lines and "DAMAGED_OK" in lines
    full = [line.split() for line in lines if line.startswith("FULL ")]
    assert [int(parts[1]) for parts in full] == [3, 10000]
    assert all(int(parts[4]) == min(int(parts[1]),int(parts[2])) for parts in full)
    sample = read(HERE / "sample.json")
    assert digest(KERNEL / "cutoff.json") == sample["cutoff_sha256"]
    population = read(KERNEL / "cutoff.json")["totals"]
    weights = {int(k): v for k,v in sample["weights"].items()}
    frequencies = sum(sample["frequencies"].values())
    assert frequencies == population["transforms"]
    assert 2*sum(weights.values()) - frequencies == population["gates"]
    cases = {r["id"]: r for r in sample["cases"]}
    trials = defaultdict(dict)
    for line in lines:
        if line.startswith("GAUSS "):
            _, identifier, run, reps, work, control = line.split()
            ix, j, count = map(int,(identifier,run,reps))
            assert ix in cases and j not in trials[ix] and count == cases[ix]["reps"]
            difference = float(work.replace("~","-")) - float(control.replace("~","-"))
            trials[ix][j] = difference / count
    assert trials.keys() == cases.keys()
    assert all(set(runs) == {0,1,2} for runs in trials.values())
    strata = {}
    for band, weight in sorted(weights.items()):
        # Sampling probability within a band is m/weight for each concrete frequency.
        # A complete frequency time divided by m estimates seconds per retained term.
        draws = [[trials[ix][r] * weight / (3600 * case["m"]) for r in range(3)]
                 for ix, case in cases.items() if case["band"] == band]
        assert len(draws) == 5
        centers = [median(values) for values in draws]
        strata[band] = dict(weight=weight, draws=centers, hours=mean(centers),
                            se=stdev(centers)/sqrt(len(centers)),
                            three_run_hours=[mean(column) for column in zip(*draws, strict=True)])
    hours = sum(row["hours"] for row in strata.values())
    se = sqrt(sum(row["se"]**2 for row in strata.values()))
    old = read(KERNEL / "costs.json")["scenarios"]["shorter"]["new_partial_hours"]
    subtotal = [x + hours for x in old]
    result = dict(frequencies=frequencies, recurrence_gates=population["gates"], strata=strata,
                  hours=hours, between_draw_se=se,
                  three_run_hours=[sum(row["three_run_hours"][i] for row in strata.values()) for i in range(3)],
                  preceding_subtotal=old, new_partial_hours=subtotal,
                  sampled_cases=len(cases), full_vectors=full,
                  sha256={p.name:digest(p) for p in [HERE/"sample.py", HERE/"sample.json",
                          HERE/"gauss01.log", HERE/"bench01.log", KERNEL/"costs.json", KERNEL/"cutoff.json"]})
    (HERE/"costs.json").write_text(json.dumps(result,indent=2)+"\n")
    print(hours,se,result["three_run_hours"],subtotal)


if __name__ == "__main__":
    main()
