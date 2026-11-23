"""Summarise five stock-HOL replays on each side of the matched grid test."""
from hashlib import sha256
from pathlib import Path
from statistics import median
import json
import sys

HERE = Path(__file__).resolve().parent


def main(label):
    assert label.isalnum()
    log = HERE / (label + ".log")
    assert (HERE / (label + ".status")).read_text().strip() == "0"
    lines = log.read_text().splitlines()
    assert "WEIGHTED_SLAB_DONE" in lines
    fixture = json.loads((HERE / "ab_inputs.json").read_bytes())
    times = {}
    for line in lines:
        if line.startswith("SLAB "):
            _, tag, repeat, t1, t2 = line.split()
            times.setdefault(tag, {})[int(repeat)] = float(t1) + float(t2)

    def cell(row):
        vals = []
        for n in (0, 8, 32, 64):
            draws = times[row["tag"] + "_groups" + str(n)]
            assert set(draws) == {1, 2, 3, 4, 5}
            vals.append(median(draws.values()))
        return dict(tag=row["tag"], samples=row["samples"], cpu_s=vals[-1],
                    empty_cpu_s=vals[0], marginal_cpu_s=vals[-1]-vals[0], medians_by_n=vals)

    results = []
    for case in fixture["cases"]:
        c = cell(case["coarse"])
        fine = [cell(r) for r in case["fine"]]
        assert sum(r["samples"] for r in fine) == c["samples"]
        results.append(dict(start=case["start"], samples=c["samples"], coarse=c, fine=fine,
                            coarse_to_fine_cpu=c["cpu_s"]/sum(r["cpu_s"] for r in fine),
                            coarse_to_fine_marginal=c["marginal_cpu_s"]/sum(r["marginal_cpu_s"] for r in fine)))
    report = dict(cases=results, log=log.name, log_sha256=sha256(log.read_bytes()).hexdigest(),
                  fixture_sha256=sha256((HERE / "ab_inputs.json").read_bytes()).hexdigest(),
                  scope="Matched residue set and eight heights, 64 conductors. The two edge cells in each fine-grid test are clipped to the physical coarse cell. The raw three-call fine cost includes their fixed overhead; the marginal comparison subtracts each empty control.")
    (HERE/"ab_rates.json").write_text(json.dumps(report, indent=2) + "\n")
    print([(r["start"], r["samples"], r["coarse_to_fine_cpu"], r["coarse_to_fine_marginal"]) for r in results])


if __name__ == "__main__":
    main(sys.argv[1])
