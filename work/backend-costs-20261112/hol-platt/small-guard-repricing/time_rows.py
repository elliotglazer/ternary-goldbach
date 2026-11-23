"""Apply the frozen 65536-field time-product and split rates to all four actual schedules."""
from collections import Counter, defaultdict
from fractions import Fraction as F
from math import ceil
from pathlib import Path
import json
import sys

HERE = Path(__file__).resolve().parent
HOL = HERE.parent
sys.path.insert(0, str(HOL / "small-time-diagonal"))
from fold import T, SOURCE, bits, primitive_count, diagonal_counts, pairs


def read(path):
    return json.loads(path.read_bytes())


def main():
    split = read(HOL/"small-time-diagonal/fold.json")
    projection = read(HOL/"c10000-kronecker-time-hol/projection.json")
    times = split["split_rate_seconds"]
    widths = sorted(map(int, split["by_width"]))
    product = {}
    for row in projection["rows"].values():
        if "width" in row:
            w = row["width"]
            assert row["count"] == split["by_width"][str(w)]["products"]
            product[w] = row["ratio_scaled_hours"]/row["count"]
    assert set(product)==set(widths), projection.keys()
    result = {}
    for scenario in read(SOURCE)["scenarios"]:
        data = scenario["small_sign_only_conditional_candidate"]
        theta = dict(data["conductor_theta"])
        strata = defaultdict(Counter)
        for c,m,n,_,_ in data["raw_metadata"]:
            t = theta[c]
            chars = primitive_count(c)
            L = 2*((25*n+191)//192)+1
            B = 2*F(40_000_000 if c%2 else 80_000_000,t)**2+1
            tol = F(35*n,2816*64*2**82*3**t)
            S = 1 << (bits(((7*B+12)*L+n)/tol)+1)
            width = 8*(((4*L*ceil((B+1)*S)*(S+1)).bit_length()+8)//8)
            bucket = next(w for w in widths if w >= width)
            tiles, extra = diagonal_counts(L,m,T)
            strata[bucket].update(products=3*chars*pairs(L,m,T)["pair_count"],
                                  grouped_splits=3*chars*(tiles+extra),
                                  complex_output_tiles=chars*tiles,
                                  live_raw_samples=chars*(m+1))
        split_rates = {w:[times[str(w)]]*2 if str(w) in times else sorted([times["616"],times["744"]])
                       for w in widths}
        ph = sum(row["products"]*product[w] for w,row in strata.items())
        sh = [sum(row["grouped_splits"]*split_rates[w][i] for w,row in strata.items())/3600 for i in (0,1)]
        extra = scenario["extra_nodes"]
        if extra == 0:
            assert abs(ph - 96634.9479308499)<1e-6
            assert max(abs(a-b) for a,b in zip(sh,split["same_synthetic_split_hours"]["grouped_splits"]))<1e-6
        result[extra] = dict(products_hours=ph,split_hours=sh,by_width=strata,total=sum(strata.values(),Counter()))
        print(extra, ph, sh, flush=True)
    (HERE/"time.json").write_text(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
