# Full short-gap external candidate dataset

Date: 2026-11-11. The explicitly authorized external generation of every remaining short-gap window is complete. All6,439 windows on the reviewed grid from10^9 to5*10^9 now have externally computed counts and passing theta+/-a/10000 checkpoint enclosures. This is candidate-certificate completion, not a Lean proof of the counts, finite prime envelope E, any finite zeta assertion, or Goldbach.

The frozen first-window, multi32, failed tight-checkpoint stress test, and relaxed-checkpoint artifacts were not changed. This note supersedes their earlier incomplete-data status only. In particular, the original theta+/-a/24000 enclosure failure at index538 remains recorded and was not relabeled as a success or an actual theta counterexample.

## Outcome and exact coverage

The new run starts at the independently reviewed relaxed checkpoint538, endpoint1143945143, and ends exactly at5000000000. It generates5901 new windows, with the last grid step clipped to the terminal endpoint. The complete external candidate dataset comprises the earlier538 windows and these5901 new ones.

| quantity | complete result |
|---|---:|
|all grid windows externally counted|6439|
|windows still without external counts|0|
|total integer positions after the original1e9 seed|4000000000|
|new positions in this run|3856054857|
|new primes counted in this run|177184261|
|primes in(1e9,5e9] from the complete chain|184106689|
|all source-sized subwindows, including prior runs|125271|
|new source-sized subwindows|120619|
|new committed batches|93|
|new Lean count proofs|0|

All new checkpoint tests pass. The final theta enclosure, obtained by exact rational updates from the actual source seed, is

    4999882220.821805278 <= theta(5000000000)
                       <=4999930929.840072558,

subject to future proof-producing validation of the finite count chain. Its exact width is608862728341/12500000=48709.01826728. The permitted final radius under the reviewed alternative condition is500000, so there is substantial remaining margin.

Across all6439 endpoints, the smallest lower-side checkpoint margin is63519.486670203, at index14/endpoint1003505688. The smallest upper-side margin is121697.722610142, at index415/endpoint1109308490. Among the5901 new endpoints alone, the minimum lower margin is64180.088252400 at index542/endpoint1145089515. These are enclosure margins from exact arithmetic, not estimates of the actual theta error.

## Mathematical consumer remains unchanged

The accepted alternative condition is abs(theta(a)-a)<=a/10000 at the same grid points b=min(5e9,a+floor(a/4000)). The independent review is `audit/RESUME_PSI_STRESS_REPAIR_REVIEW_2026-11-11.md`, SHA25644DC6509BB59BAF752E091634ADC3B6C4C24F5CA7C7362120460B53E685213AD.

The complete paper interpolation, retained without modification, uses the reviewed P6 repair NP(t)<1.4262sqrt(t)<=17t/360000 for t>=1e9. It gives the two error coefficients

    1/4000+1/10000=7/20000,
    1/4000+(1/10000+17/360000)*(4001/4000)
      =572053/1440000000.

Both are less than1/2300. Since log(t)<23 throughout[1e9,5e9], this implies E: abs(psiN(v)-v)<=.01v/log(v) on the whole integer finite gap once the counts, log boxes, and their soundness bridges are formally checked. The endpoint5e9 is included, giving overlap with the separately conditional spectral tail starting there. The output does not validate that spectral tail or its finite RH/moment inputs.

## New files and immutable batch format

The generation script is `resume_psi_full_candidate_20261111.py`, SHA2561C67C3503E632F2661624E333A7F0F2AB2C2E01B7C99A140F3D865CE94AE0D78. Its output directory is `psi_full_candidate_20261111/` and contains189 files totaling15686001 bytes:

- `metadata.json`: fixed source-data pins, scale10^9, grid/checkpoint parameters, initial theta state, script hash, and explicit classification-hash format.
- `base_primes.json`: the7004 primes through70710, externally obtained by two independent elementary constructions and compared for exact equality.
- `batch_0001.json` through `batch_0093.json`:64 windows per batch, except13 in the last batch. Each row stores the exact interval, count, source-sized subcounts, rational log box, integer-scaled theta bounds and margins, and classification hash.
- `receipt_0001.json` through `receipt_0093.json`: hash-linked commit receipts with batch hashes, interval/index/count summaries, pass status, and measured external resources.
- `COMPLETE.json`: final count/endpoint/margin summary and the terminal receipt hash.

The first receipt links to the metadata hash; each later receipt links to the preceding receipt hash. A batch file is written before its receipt. Files are written to a temporary name and published by same-directory replacement; existing committed files are not overwritten. The receipt is the transaction commit marker. The run writes no source or canonical Lean file.

Key anchors are:

| artifact | SHA256 |
|---|---|
|metadata.json|0D65EC72AA1DC618558DD6ABBAA6BF6F7C13873BD2FA6617F38D768C2034D160|
|base_primes.json|9AB3C71A6E989BED8A71C95E30F51143D4F3876D49ED3220B4E4C0943A4A506E|
|batch_0001.json|D0645B3433023FBF0832ED8F3C1490557779853F82F3FC63BF550AFFA95E5196|
|receipt_0001.json|9CBF3CE557A7D636BD4106005574CED63A4F705D706E0D5B523521A9B6A4F6B0|
|batch_0093.json|057628E07C5D432EAC0439F81293764771EDFE0FC9006F18795DD2E9E2CB7FB0|
|receipt_0093.json|604B77ED187593841978045B24ED19F06458715255C6663B0C7C99DE3340A453|
|COMPLETE.json|92770E969395E4817210366B3ECBDFF218768D800C923CA6E7944CF71DD73763|

The complete189-file name/hash/size manifest is in the separate read-only validation output described below. Hashes identify external evidence; they are not proofs of primality, completeness, theta bounds, or file authenticity beyond the specified pinned chain.

## Counting and source-checker arithmetic

The base list is generated once by Eratosthenes and independently by testing every integer candidate through70710 against every divisor through its integer square root. The lists agree. Because70710^2<=5e9<70711^2, this list contains a prime factor of every composite in the target interval. Each window uses the prefix required through floor(sqrt(b)); every sieved integer is larger than every base prime, so marking prime multiples does not remove a prime itself.

For each(a,b], one segmented representation has a byte for every integer a+1 through b. Another representation independently indexes only odd integers and computes the first odd multiple using a separate formula. The program checks the full odd-index byte slice equals the odd representation exactly and that the even-index slice contains no surviving1 byte. This is a pointwise comparison of all classifications, not merely an equality of totals. It replaces the earlier slow Python-level pointwise loop with equivalent exact bytearray slice comparisons.

The per-window classification hash is SHA256 of W raw bytes, with byte i equal to1 precisely when a+1+i survives the complete sieve and0 otherwise. This format differs deliberately from the earlier newline-separated prime-list hashes and is specified in metadata. It hashes the complete classification without an expensive Python string conversion for every prime. Independent selected-window review must reproduce this byte format to compare hashes.

Each window is partitioned into exact adjacent source-sized subwindows of width<=32768. Their counts sum to the parent count. All log boxes are checked by exact replay of the existing `Small.chkLow` and `Small.chkStep` rational Taylor formulas. Decimal logarithms only propose endpoints. Log endpoints use denominator10^9 and width2e-8, below the independently corrected1e-7 ceiling.

Theta updates use integer arithmetic scaled by10^9:

    QL_b=QL_a+c*lower_log_numerator(a),
    QU_b=QU_a+c*upper_log_numerator(b).

The checkpoint inequalities compare these integers directly with b*(10^9 +/-10^5). This is exactly the rational theta+/-b/10000 test, without floating decisions. Any classification discrepancy, arithmetic assertion failure, bad log box, or failed checkpoint terminates the process. None occurred in this completed run.

## Process record and resources

The single live generation process was PID12760, tool session55025. It was polled through completion and exited0. It was never restarted after a timeout. The final event reported88.86839139999938 seconds internal wall time and88.40625 seconds process CPU time. The committed batch receipts sum to88.6177529000015 wall seconds and88.140625 CPU seconds; initialization and final work account for the difference.

The receipts record10215117138 full-sieve marking assignments, counting repeated composite marks. The maximum reported simultaneous bytearray payload is1944977 bytes, explicitly excluding temporary slices, Python lists/integers, allocator overhead and process RSS. This is not a measured peak-process-memory figure. The exact byte-slice comparison explains the large speed improvement over the earlier Python per-position loop; no mathematical checking condition was removed.

These are measurements of external Python3.14.7 on the supplied host. They make no prediction about Lean kernel runtime, proof-term size, or the cost of validating125271 bit-sieve count declarations. At completion there were no ERROR artifacts, STOPPED marker, temporary files, or RUNNING lock in the dataset directory.

## Read-only full-chain validation after completion

The separate script `resume_psi_full_candidate_validate_20261111.py` performs no new prime counting or full re-sieve. Its output `resume_psi_full_candidate_validation_20261111.json` records PASS and includes the189-file manifest. It reconstructs all6439 prior and new theta/log chains from the original source seed, checks every interval and subinterval boundary, recomputes all log-checker tests and checkpoint margins, and checks each stored theta fraction.

It also checks every new batch's metadata hash and scale; all receipt links and data hashes; receipt index/endpoint/window/position/prime/subwindow summaries; minimum margins; the exactly calculable bytearray payload formula; and every substantive COMPLETE summary field. It confirms the prior/new split538+5901, the exact terminal endpoint5e9, and the total125271 source-sized subwindows. The base list is rechecked independently by elementary trial division. It exited0.

The reported full-sieve mark counters and wall/CPU timings are accumulated from receipts, not independently remeasured by this arithmetic validator. The validator does not turn the input prime counts into proven values: it checks their complete arithmetic use and storage consistency. Independent review of the generator, first/final batches and selected recounts is separate; a new full independent3.856-billion-position re-sieve was not requested or claimed.

## Resume protocol limits identified by independent review

The live protocol was reviewed without changing its frozen code. It revalidates committed row arithmetic and hash continuity on resume, but it does not itself check every receipt summary or each batch's metadata/scale field. The stronger post-completion validator now checks those for this dataset. This distinction prevents overstating the live resume routine's defenses against arbitrary artifact mutation.

A STOPPED marker gates further work after a failed checkpoint. ERROR_pid files record an exception but do not themselves gate a later restart; resuming after such an error should therefore require explicit review. No ERROR occurred here. A stale RUNNING lock deliberately blocks another launch until ownership is inspected. An interrupted transaction with only an uncommitted deterministic batch can be recomputed and compared with that existing data before receipt publication. Atomic replacement addresses process interruption, not a fully fsync-protected power-loss durability guarantee. No crash/recovery experiment was performed in this run.

These are nonblocking protocol limitations for the completed, fully revalidated dataset, not reasons to alter frozen evidence. They should be tightened in a separately versioned future generator before relying on unattended recovery after a discrepancy.

## Remaining proof-producing work

The finite gap now has concrete passing data at every intended checkpoint. Future Lean work still needs a proved complete base-prime list through70710, generalized prime/no-base-factor and mask-shift/count specifications, and kernel checks of all concrete source-sized counts. A uniform70710 base with32768-bit cells can use131072-bit patterns, since70710+32768<131072; `maskP_spec` and generic `pcL_spec` are available, while the existing fixed PS3 characterization/count theorem is insufficient.

The log checker soundness theorems and exact integer theta recurrence then connect those counts to the checkpoints. The independently reviewed interpolation plus the reviewed P6 repair gives finite E. These are formalization obligations, not additional assumptions to install in Goldbach. The zero-count/moment assertions supporting the separate analytic tail at5e9 remain unproved providers in this campaign.

There are zero new Lean count proofs. The complete external dataset does not establish a finite zeta theorem or the final Goldbach statement. The original10^27 and BinaryGoldbachInput remain unchanged.
