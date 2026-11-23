"""Two hypothetical dimension fixtures; exact integer inequalities only."""
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
checks = []

def check(name, condition):
    if not condition:
        raise AssertionError(name)
    checks.append(name)

# theta=1/16; q=1-theta+theta^2=241/256.
check("q_power_512_below_2^-44", 241**512 * 2**44 < 256**512)
check("empty_power_512_below_2^-47", 15**512 * 2**47 < 16**512)
check("empty_power_16_above_1/4", 4 * 15**16 > 16**16)
# eta=1/32, E[2^B]=(33/32)^512 for B~Binomial(512,eta).
check("availability_mgf_below_2^26", 33**512 < 32**512 * 2**26)
check("W_squared_pair_bound", (2**18)*(2**18-1) < 2**36)
check("W_missing_lower", 2**18 // 256 == 1024)
check("availability_tail_exponent", 65-26 == 39)
check("adaptive_union_exponent", 1024-512 == 512)

data = {
    "scope": "exact inequalities for two hypothetical iid Bernoulli-matrix fixtures; no samples, source bits, primes, masks or inventory",
    "checks": len(checks),
    "passed": checks,
    "fixtures": [
        {"W": 2**18, "M": 512, "theta": "1/16", "eta": "1/32",
         "nonempty_antichain_probability_lower": "1-2^-8-2^-29",
         "any_subset_size_at_most_64_cover_probability_upper": "2^-512",
         "available_anchor_cover_probability_upper": "2^-39+2^-512"},
        {"W": 2**18, "M": 64, "theta": "1/16",
         "probability_no_empty_row_upper": "2^-1024"}
    ],
    "note": "probability conclusions use the paper's independence assumptions and generic (1-x)^n<=exp(-nx), exp(1)>2; no transcendental values evaluated"
}
out = HERE / "incidence_bernoulli_fixed_20261111.json"
with out.open("x", encoding="utf-8", newline="\n") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
print(json.dumps({"checks": len(checks), "bytes": out.stat().st_size,
                  "sha256": hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
