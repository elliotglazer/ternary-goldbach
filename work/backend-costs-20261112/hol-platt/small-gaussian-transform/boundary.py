"""Count the coefficient transfers between the character and time transforms."""
from collections import Counter
from hashlib import sha256
import json
from math import prod
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
FFT = HERE.parent/"small-character-kernel"
sys.path.insert(0,str(FFT))
from plan import SOURCE, axis_bound, layout


def main():
    cutoff = FFT/"cutoff.json"
    costs = HERE.parent/"small-gaussian/costs.json"
    ledger = json.loads(cutoff.read_bytes())
    saved = json.loads(SOURCE.read_bytes())["scenarios"][0]["small_sign_only_conditional_candidate"]
    totals = Counter()
    ranges = []
    for row in ledger["rows"]:
        ds,_,_,keep = layout(row["c"])
        labels = prod(keep)
        totals["labels"] += labels
        fft_terms = row["transforms"]*labels
        single_terms = (row["nonempty"]-row["transforms"])*labels
        totals["transform_coefficients"] += fft_terms
        totals["singleton_coefficients_if_expanded"] += single_terms
        bounds = [axis_bound(n) for n in ds]
        stability = sum(a for a,_ in bounds)
        common = (1<<80)*4*3**row["theta"]*44*2*3**33
        fft_bits = (max(common*128*prod(ds)*stability*(8192**2+2),2*stability,max(b for _,b in bounds))-1).bit_length()
        gauss_bits = (common*192*8192**4-1).bit_length()
        delta = fft_bits-gauss_bits
        ranges.append(delta)
        key = "shift_left" if delta>0 else "round_right" if delta<0 else "equal_precision"
        totals[key+"_conductors"] += 1
        totals[key+"_frequencies"] += row["transforms"]
        # A fixed-width storage illustration with 32 bits per coordinate in addition to the fraction.
        # This models one write and excludes the singleton broadcasts, reads and all proof encoding.
        totals["fixed_slot_bytes"] += fft_terms*2*((fft_bits+32+7)//8)
    assert totals["labels"]==saved["totals"]["primitive_labels"]
    assert sum(row["transforms"] for row in ledger["rows"])==sum(v for k,v in totals.items() if k.endswith("_frequencies"))
    subtotal = json.loads(costs.read_bytes())["new_partial_hours"]
    headroom = 800000-max(subtotal)
    microseconds = headroom*3600*1e6/totals["transform_coefficients"]
    result = dict(totals=totals,fft_minus_gauss_bits=[min(ranges),max(ranges)],partial=subtotal,
                  comparison_hours=800000,remaining_hours=headroom,
                  available_microseconds_per_complex_output_if_no_other_costs=microseconds,
                  sha256={p.name:sha256(p.read_bytes()).hexdigest() for p in [cutoff,costs,SOURCE]})
    (HERE/"boundary.json").write_text(json.dumps(result,indent=2)+"\n")
    print(result)


if __name__=="__main__":
    main()
