"""Update the +640 Platt workload using matched stock terminal and source tests."""
from collections import defaultdict
from hashlib import sha256
from pathlib import Path
from statistics import median
import json

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
hashes = {}


def contents(path):
    path = HOL / path
    data = path.read_bytes()
    hashes[path.relative_to(HOL).as_posix()] = sha256(data).hexdigest()
    return data


def read(path):
    return json.loads(contents(path))


def timings(label, prefix):
    folder = "large-terminal-signs/"
    assert contents(folder+label+".status").strip() == b"0"
    records = defaultdict(list)
    pending = None
    for line in contents(folder+label+".log").decode().splitlines():
        if line.startswith(prefix+" "):
            pending = tuple(line.split()[1:])
        elif line.startswith("JOIN_EVAL ") and pending is not None:
            records[pending].append(float(line.split()[2].replace("~","-")))
            pending = None
    return records


def main():
    old = read("hurwitz-seed-integer/fold.json")
    norm = read("hurwitz-seed-integer/normalized-price.json")
    group = read("hurwitz-normalized-translate/price.json")
    old_table = read("coefficient-panels/costs.json")["priced_table_hours"]
    old_table += read("guard-repricing/guard.json")["scenarios"]["640"]["added"]["coefficient_generation_and_checks"]
    assert group["groups"] == 5693448 and group["last"] == 84881
    assert old["seed_kernel_and_phase_hours"] == norm["prior_seed_hours"]
    translation = group["native_candidate_hours"] + group["standalone"]["median"]
    preparation = group["all_unassigned_preparation_hours"]
    seed_delta = norm["normalized_seed_hours"] - norm["prior_seed_hours"]
    source_delta = seed_delta + translation - old_table
    previous = old["variants"]["pair_h"]["with_principal_integer_pilot"]
    numerical = [previous[0]+source_delta, previous[1]+source_delta+preparation]

    geometry = read("large-axis-fused-tree/terminal.json")["640"]
    total = geometry["totals"]["outputs"]
    long_outputs = geometry["by"]["regular"]
    short = total-long_outputs
    assert total == sum(geometry["by"].values()) == 39241839619586

    sector = timings("t08SectorPrice","TERMINAL")
    rates = {}
    for p in ("24","28","81"):
        good, ctl = (sector[(p,"32",mode)] for mode in ("true","false"))
        assert len(good) == len(ctl) == 3
        rates[p] = (median(good)-median(ctl))/(32*4602)
    fused = timings("f07AbsorbedPrice","FUSED")
    measured_fused = {}
    for p in ("24","28"):
        for h in (1,2):
            tag = "fu"+p+"h"+str(h)
            good, ctl = (fused[(tag,"1024",mode)] for mode in ("true","false"))
            assert len(good) == len(ctl) == 3
            measured_fused[tag] = (median(good)-median(ctl))/(1024*59)
    assert max(measured_fused.values()) < 0

    even = timings("even01EvenPrice","FUSED")
    for p in (24,28):
        for width in (64,256,1024):
            tag = f"even{p}n{width}"
            reps = str(131072//width)
            good, ctl = (even[tag,reps,mode] for mode in ("true","false"))
            assert len(good) == len(ctl) == 3
            measured_fused[tag] = (median(good)-median(ctl))/131072
    assert all(s < 0 for s in measured_fused.values())
    phase = read("large-dynamic-phases/price.json")
    dynamic = next(r["dynamic_core_hours"] for r in phase["scenarios"] if r["extra"]==640)
    static = phase["static_hours_4333246843"]

    scan = timings("f07StreamPrice","STREAM")
    scan_rates = {}
    for label,n in (("low",32),("high",16)):
        hot, cold = scan[(label,"8")],scan[(label,"0")]
        assert len(hot) == len(cold) == 2
        scan_rates[label] = (median(hot)-median(cold))/(8*2301*n)
    scans = [f*total/3600 for f in (min(scan_rates.values()),max(scan_rates.values()))]
    def scenario(n,setup):
        return [x+y+setup+n*z/3600 for x,y,z in
                zip(numerical,scans,(min(rates.values()),max(rates.values())),strict=True)]
    report = dict(numerical_baseline_with_normalized_source=numerical,
                  prior_table_hours=old_table, normalized_table_hours=translation,
                  extra_table_setup_sensitivity=preparation,
                  changed_source_hours=source_delta,
                  full_grid_outputs=total, long_outputs=long_outputs, short_outputs=short,
                  separate_sector_seconds_per_output=rates,
                  tested_fused_seconds_per_output_increment=measured_fused,
                  count_hours=scans,
                  dynamic_phase_table_hours=dynamic, static_phase_table_hours=static,
                  direct_terminal_on_all_outputs=scenario(total,dynamic),
                  fused_zero_increment_for_long_only=scenario(short,dynamic+static),
                  mix_formula="For a fraction f of the long outputs handled under the zero-increment assumption, price the separate sign step on short+(1−f)*long outputs. Always add the scan charge once.",
                  scope="First-acceptance scenario, partial. The fused row transfers a zero incremental time to all eligible long outputs. Matched jobs cover four length-60 transforms at q10004 and six tiles from the selected full length-131070 transform at q131071. Short-output rates are proxies. Counts come from already-transposed q10004 panels. Both rows include dynamic phase updates. The fused row separately charges every static cache entry, without crediting the savings observed during timed runs. The table uses supplied phase and character enclosures. Absolute input-mass formation, transpose, repairs, analytic interpretation, library/proof transport and final completeness remain open. The principal integer pilot excludes its analytic upper-count and remainder proof.",
                  hashes=hashes)
    report["headroom_to_800000"] = [800000-x for x in reversed(report["fused_zero_increment_for_long_only"])]
    (HERE/"normalized_terminal.json").write_text(json.dumps(report,indent=2)+"\n")
    print(report["fused_zero_increment_for_long_only"],report["direct_terminal_on_all_outputs"])


if __name__=="__main__":
    main()
