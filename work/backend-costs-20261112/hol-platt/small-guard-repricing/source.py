"""Reweight the original character-panel draws and Gaussian length-class controls."""
import json
import sys
from collections import Counter
from pathlib import Path

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
sys.path.insert(0, str(HOL / "small-character-kernel"))
import plan
import cutoff
sys.path.insert(0, str(HOL / "small-gaussian"))
from sample import runs


def read(path):
    return json.loads(path.read_bytes())


class Scenario:
    def __init__(self, schedule):
        self.data = json.dumps({"scenarios": [schedule]}).encode()

    def read_bytes(self):
        return self.data


def main():
    source = read(plan.SOURCE)
    original, _ = plan.inventory()
    char = read(HOL / "small-character-kernel/costs.json")["scenarios"]["shorter"]
    strata = read(HOL / "small-character-kernel/plan.json")["strata"]
    base = read(HOL / "small-character-kernel/cutoff.json")["rows"]
    prior, _ = plan.inventory({r["c"]: r["transforms"] for r in base})
    gauss = read(HOL / "small-gaussian/costs.json")
    result = {}
    for scenario in source["scenarios"]:
        extra = scenario["extra_nodes"]
        data = scenario["small_sign_only_conditional_candidate"]
        theta = dict(data["conductor_theta"])
        rows = base if extra == 0 else [
            cutoff.conductor(c, m, n, theta[c]) for c, m, n, _, _ in data["raw_metadata"]]
        plan.SOURCE = Scenario(scenario)
        pop, counts = plan.inventory({r["c"]: r["transforms"] for r in rows})
        hours = 0
        for name, spec in strata.items():
            values = []
            for key, value in zip(spec["draws"], char["strata"][name]["per_draw_hours"], strict=True):
                key = tuple(key)
                assert prior[name][key] and original[name][key]
                values.append(value * pop[name][key] / prior[name][key])
            hours += sum(values) / len(values)
        weights = Counter()
        for row in rows:
            for lo, hi, last in runs(row):
                weights[(last-1).bit_length()] += (hi-lo)*last
        gates = sum(r["gates"] for r in rows)
        transforms = sum(r["transforms"] for r in rows)
        assert 2*sum(weights.values())-transforms == gates
        gaussian = sum(v*gauss["strata"][str(k)]["hours"]/gauss["strata"][str(k)]["weight"]
                       for k,v in weights.items())
        missing = {name: sum(v for k,v in group.items() if not original[name][k])
                   for name,group in pop.items()}
        length_price = sum(char["strata"][name]["hours"] * sum(group.values()) /
                           sum(prior[name].values()) for name,group in pop.items())
        result[extra] = dict(character_hours=hours, gaussian_hours=gaussian,
                             character_same_length_rate_hours=length_price,
                             outside_original_draw_population=missing,
                             counts=counts, gates=gates, transforms=transforms,
                             gaussian_length_weights=weights)
        if extra == 0:
            assert abs(hours-char["hours"]) < 1e-6 and abs(gaussian-gauss["hours"]) < 1e-6
        (HERE/"source.json").write_text(json.dumps(result, indent=2))
        print(extra, hours, gaussian, flush=True)


if __name__ == "__main__":
    main()
