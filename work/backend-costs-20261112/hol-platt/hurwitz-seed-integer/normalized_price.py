"""Reprice only the normalized coefficient generator on the common 384-bit arithmetic grid."""
from collections import defaultdict
from hashlib import sha256
from pathlib import Path
from statistics import median
import json
import sys

from price import results


HERE = Path(__file__).resolve().parent


def main(label):
    lines, entries = results(label)
    assert "NORMALIZED_SEEDS_DONE" in lines
    assert any('Saved theorem' in s and '"altered_normalized_rejected"' in s for s in lines)
    counts = json.loads((HERE/"normalized-counts.json").read_bytes())
    old = json.loads((HERE/"price.json").read_bytes())
    rates = {r["band"]:r for r in old["bands"]}
    timings = defaultdict(list)
    for record, parts in entries:
        timings[int(record[1])].append(parts)
    rows = []
    for data in counts["bands"]:
        i = data["band"]
        timer = timings[i]
        assert len(timer)==3
        scalar = rates[i]
        g = data["groups"]
        bases = data["base_pairs"]
        steps = g*data["phase_states"]-bases
        rows.append(dict(band=i, groups=g, bases=bases, steps=steps,
                         core_seconds_measured=[x[1] for x in timer],
                         row_hours=g*median(x[1] for x in timer)/3600,
                         phase_hours=steps*scalar["phase_update_seconds"]/3600,
                         setup_hours=bases*scalar["new_base_setup_seconds"]/3600))
    totals = {k:sum(r[k] for r in rows) for k in ("row_hours","phase_hours","setup_hours")}
    cost = sum(totals.values())
    previous = old["total"]["arithmetic_plus_phase_hours"]
    manifests=[label+".status",label+".log","normalized-counts.json","price.json",
               "normalized-cases.txt","NormalizedSeedScript.sml"]
    out = dict(bands=rows, totals=totals, normalized_seed_hours=cost,
               prior_seed_hours=previous, seed_arithmetic_saving=previous-cost,
               hashes={f:sha256((HERE/f).read_bytes()).hexdigest() for f in manifests},
               scope="Kernel group arithmetic uses three checks of each of six genuine last-group inputs. Phase and initialization rates use the existing 384-bit recurrence on its six representative operands. A normalized group owns both endpoints of the last mesh interval. Table translation, data transport, continuous error proofs and repairs are separate.")
    (HERE/"normalized-price.json").write_text(json.dumps(out,indent=2)+"\n")
    print(totals, cost, previous-cost)


if __name__=="__main__":
    main(sys.argv[1])
