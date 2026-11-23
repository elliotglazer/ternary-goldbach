"""Reprice the same measured large-character DFT circuits on each explicit guard."""
from collections import Counter
from hashlib import sha256
import json
from math import isclose, sqrt
from pathlib import Path
from statistics import mean, stdev
import sys

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
sys.path.insert(0, str(HOL / "large-kronecker-precision"))
from precision import AGENTS, admissible

EXTRAS = (0, 167, 320, 640)
pins = {}

def read(path):
    body = path.read_bytes()
    pins[str(path.relative_to(HOL.parents[1])).replace("\\", "/")] = sha256(body).hexdigest()
    return json.loads(body)

def add(a, b):
    return tuple(x + y for x, y in zip(a, b, strict=True))

def census(plan, short_rates, intervals):
    files = [
        AGENTS / "integration/transform_structural_manifest_20261111.json",
        AGENTS / "major-constants/combined_conductor_precision_rows_20261111.json",
        AGENTS / "major-constants/combined_conductor_precision_nodes_20261111.json"
    ]
    raw, prices, local = map(read, files)
    for f in files:
        assert sha256(f.read_bytes()).hexdigest() == plan["input_hashes"][f.name]
    errors = {r[0]: r[5] for r in local["rows"]}
    base, step = Counter(), Counter()
    groups = {e: Counter() for e in EXTRAS}
    units = {e: Counter() for e in EXTRAS}
    band_units = {e: Counter() for e in EXTRAS}
    board = [*intervals, (intervals[-1][1], intervals[-1][1]+max(EXTRAS))]
    assert len(raw["conductors"]) == 125400
    for idx, (r, pr) in enumerate(zip(raw["conductors"], prices["rows"], strict=True)):
        c, phi, chars, H, j, axes, _ = r
        assert pr[:4] == [idx, c, phi, chars]
        h = j+41
        assert h <= intervals[-1][1]
        packet_counts = {}
        for e in EXTRAS:
            span = [max(0, min(h+e, hi)-lo) for lo, hi in board]
            assert sum(span) == h+e
            packet_counts[e] = sum((s+7)//8 for s in span)
            for k, s in enumerate(span):
                band_units[e][k] += s*phi
            units[e].update(nodes=h+e, source=(h+e)*phi, outputs=(h+e)*chars,
                            beyond_original_nodes=span[-1], beyond_original_conductors=int(span[-1]>0))
        cost = sum(4 if n>=32 else errors[n] for n,_ in axes)
        p = next(p for p in range(80, pr[-2]+1) if admissible(c, phi, cost, pr[8], pr[7], p))
        full, kept, suffix = 1, 1, phi
        for n,q in axes:
            suffix //= n
            lines = kept*suffix
            if n>=32:
                cap = 2*full*16384
                scale = 1<<p
                w = ((2*n*(2*cap*scale+2)*scale).bit_length()+8)//8
                key = (n,p,cap,w)
                base[key] += h*lines
                step[key] += lines
            else:
                assert not any(x>2**17 for x,_ in axes)
                for e in EXTRAS:
                    groups[e][n,q] += packet_counts[e]*lines
            full *= n
            kept *= n-(n//q if q else 0)
        assert full == phi and kept == chars and suffix == 1
    for row in short_rates:
        assert groups[0][row["n"],row["q"]] == row["packets"] and row["original_precision_packets"] == 0
    return base, step, groups, units, band_units

def main():
    plan = read(HOL/"large-axis-sample/sample.json")
    hi = read(HOL/"large-axis-sample/estimate.json")["completed_sampling_strata"]
    lo = read(HOL/"large-axis-sample/estimate-p24.json")["completed_sampling_strata"]
    assert set(hi)-set(lo) == {"18"} and not (set(lo)-set(hi))
    short = read(HOL/"short-axis/costs.json")
    intervals = [b["height_indices"] for b in read(HOL/"large-weighted-slab/later-band-budget.json")["bands"]]
    base, step, groups, units, band_units = census(plan, short["rows"], intervals)
    measured = {**lo, "18":hi["18"]}
    pos = Counter()
    new_pos = Counter()
    for k in base:
        n = k[0]
        b = str((n-1).bit_length())
        pos[b] += n*base[k]
        new_pos[b] += n*step[k]
    assert set(pos)==set(plan["strata"])==set(measured)
    sums = {e: {} for e in EXTRAS}
    previous = {r["extra"]:r["large_plus41"] for r in read(HOL/"campaign-cost-ledger/ledger.json")["rows"]}
    for e in EXTRAS:
        hours, dh, se, se_delta = [], [], [], []
        details = {}
        counts = units[e]
        assert (counts["nodes"],counts["source"],counts["outputs"]) == tuple(previous[e][k] for k in
                    ("conductor_height_nodes","residue_inputs","primitive_outputs"))
        for b, stats in plan["strata"].items():
            assert pos[b] == stats["positions"]
            r = measured[b]
            rates = r["per_position_us"]
            # A draw's inclusion probability came from the old population. Apply the
            # changed workload at its full sampled geometry, including precision and cap.
            xs, ds = [], []
            for key, usec in zip(map(tuple,stats["draws"]), rates, strict=True):
                v = usec*pos[b]/3.6e9
                delta = v*e*step[key]/base[key]
                xs.append(v+delta)
                ds.append(delta)
            assert isclose(mean(xs)-mean(ds),r["hours"],rel_tol=3e-13)
            hours.append(mean(xs)); dh.append(mean(ds))
            se.append(stdev(xs)**2/len(xs)); se_delta.append(stdev(ds)**2/len(ds))
            details[b] = dict(old_positions=pos[b],new_positions=pos[b]+e*new_pos[b],
                              hours=mean(xs),additional=mean(ds),added_draws=ds)
        s_hours = sum(groups[e][r["n"],r["q"]]*r["seconds_per_packet"]/3600 for r in short["rows"])
        if e==0: assert isclose(s_hours,short["short_transform_hours"],rel_tol=1e-13)
        sums[e] = dict(long_hours=sum(hours),added_long=sum(dh),long_between_draw_se=sqrt(sum(se)),
                       added_long_between_draw_se=sqrt(sum(se_delta)),short_hours=s_hours,
                       added_short=s_hours-short["short_transform_hours"],short_packets=sum(groups[e].values()),
                       long_positions=sum(pos.values())+e*sum(new_pos.values()),strata=details,
                       population=dict(counts),source_inputs_by_band=list(band_units[e].values()))
    result=dict(extras=sums,sha256=pins,
        scope="Large-family long-axis resident marginal stock HOL4 circuit at p24 through bin 17, sampled high precision at bin 18, plus short-axis eight-height packets. Frozen circuit and operand assumptions. Incoming source generation, extra retries, transfer, and analytic height extension remain separate.")
    (HERE/"axes.json").write_text(json.dumps(result,indent=2)+"\n")
    print([(e,round(v["long_hours"]),round(v["added_long"]),round(v["added_short"]),v["population"]["beyond_original_nodes"]) for e,v in sums.items()])

if __name__=="__main__":
    main()
