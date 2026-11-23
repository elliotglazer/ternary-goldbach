from pathlib import Path
import json
d=Path(__file__).resolve().parent
r=json.loads((d/"fold.json").read_bytes())
t=r["totals"]; rows=r["rows"]
assert r["matched_cases"]==42 and t["count"]==30962787324+24577932
s=f"""# Resident HOL4 character-transform panel

Across **{len(rows)} exact observed length, precision, input-capacity and lane-width combinations**, the retained workload contains **{int(t['count']):,}** whole cyclic slices out of 269,921,342,390. Applying each measured resident CPU rate only to its own stratum gives **{t['hours']:,.0f} core-hours**. The two separate repeated-group folds give {t['replicate_hours_0']:,.0f} and {t['replicate_hours_1']:,.0f} hours. The corresponding same-input native FLINT panel estimates {t['native_hours']:,.0f} single-worker wall-hours. The historical native endpoint panel associates {t['native_endpoint_hours']:,.0f} wall-hours with these same keys. Different timing clocks and input construction prevent treating their ratio as a machine constant.

The remaining **{int(t['unmeasured_count']):,}** slices have no HOL price in this fold. Under the prior native endpoint convention their original allocation was {t['unmeasured_original_native_endpoint_hours']:,.0f} wall-hours. The measured subtotal is an alternative price for these specific rows, not an amount to add to a newer short-precision or sampled campaign total. Eligibility and counts refer to the old selected p80–105 combined-precision contract.

| Length | Fractional bits | Lane bytes | Matched slices | Internal setup, CPU s | Resident complete transform, CPU s |
|---:|---:|---:|---:|---:|---:|
"""
for row in rows:
    if (row["n"],row["p"]) in [(32,83),(42,93),(256,83),(2048,83),(8192,83)] or row["p"]>=98:
        s+=f"| {row['n']:,} | {row['p']} | {row['lane']} | {row['count']:,} | {row['setup']:.6f} | {row['kernel_resident']:.6f} |\n"
s+="""
The input coordinates are deterministic signed dense integers within each selected cap. They are diagnostic values, not source values from an actual L-function. The chirps are genuine nearest p-bit roots. The generator verified the entire recurrence against independent Arb rounding at every index for every case. HOL constructs the same chirp sequence from two supplied higher-precision seeds, rounding its recurrence at p+64. The receiver uses the requested p-grid after each prechirp and postchirp, signed balanced packing and extraction, and the three exact large-integer products for the whole-axis convolution. The kernel array is packed once per case. The formal checker independently reproduced the exact four native direct-sum outputs at k=0,1,n/2,n−1 and the weighted checksum of every signed output pair. Those observations force full computation but the checksum does not uniquely identify the whole vector. General chirp, rounding, cyclic packing and analytic enclosure theorems are still needed. The actual n=500 full-output theorem is a separate measured instance.

The zero-repeat evaluation constructs the chirps, test inputs, packed kernel and powers and computes a control checksum. Nonzero repetitions reuse that state within one stock CV evaluation. The resident price is the difference between repeated and zero-evaluation CPU, divided by repetitions. It includes prechirping all inputs, packing, exact cyclic convolution, unpacking, terminal regrid, and the diagnostic checksum and four comparisons. It excludes standalone literal input admission, output export and root/source certification. Each run checks the expected public result with empty hypotheses, no explicit axiom tags and only allowed disk-theorem tags. fold.json retains each CV preparation, execution, decode/discharge/check time and all setup baselines. The native timing covers its warm full transform before independent verification.

All eligible top axes are even. For non-powers of two, balanced extraction pads to the next power of two and stops postchirping when the actual chirps end. The modulus uses the true n. This distinguishes arithmetic at 131,266 from arithmetic at its padded tree size. All 42 exact key matches use the observed slice counts, without multiplying nested transforms or crediting projected-away labels a second time.

The first cold build covered 34 keys, took 16.13 user + 5.84 system seconds, 49.79 wall seconds and peaked at 787,972 KiB. The second cold build covers eight more keys, one at each precision from 98 to 105; the process used 189.93 user + 39.94 system seconds, 259.80 wall seconds and peaked at 2,084,008 KiB. The worker used a 4 GiB virtual-memory ceiling, a six-minute cutoff and ordinary stock HOL4. Both successful logs and status files are preserved. The first failed compile assigned a rational type to an unannotated selector index; the corrected scripts explicitly select by natural index.

cases.py and wide.py select the histogram strata and independently check the native outputs. LargePanelScript.sml and LargePanelWideScript.sml define and execute the formal benchmarks. fold.py panel02 wide01 reconstructs the measured-component totals. The input hashes are in fold.json.
"""
(d/"REPORT.md").write_text(s,encoding="utf-8")

