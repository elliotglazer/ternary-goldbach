# Resumable short-gap candidate run: protocol and bounded independent review

2026-11-11. Verdict: PASS for the saved candidate dataset and exact arithmetic chain within the scope below. The first batch and final receipt chain are consistent. This is external evidence for later formal replay, not a Lean prime-count proof, a proof of the additional low-zeta input, or closure of E.

## Independent validation scope

The original assignment covered the protocol and first 64-window batch. After the producer completed, extended the arithmetic review to all saved data without duplicating the full sieve. The independent script `resume_psi_full_protocol_review_20261111.py` exited 0 and saved its JSON beside this review.

- Independently generated the complete prime list through 70710 by incremental trial division: all 7004 entries match the saved base. Checked 70710^2<=5e9<70711^2.
- Checked metadata and prior artifact pins, and recovered the exact seed at global index538 from the previously reviewed stress fractions and log box.
- Replayed all 5901 new grid transitions, all source rational log checks, all theta updates, subwindow partitions/count sums, and every relaxed checkpoint inequality.
- Checked all 93 receipt hashes and their predecessor links, exact data filenames, batch metadata hashes/scales, indices/endpoints, counts/positions/subwindow totals and minimum-margin summaries. Checked the COMPLETE.json endpoint, totals, final fractions and last receipt link.
- Independently recounted ONLY five new windows: 539, 570, 602, 6427 and 6439. Used a separate set-based odd-composite sieve and the independently generated base; verified every associated subcount and classification hash. The other 5896 new-window counts were not independently re-sieved in this audit.
- Confirmed absence of ERROR files, STOPPED.json and RUNNING.lock after completion. No interruption/fault-injection test was performed.

The earlier 538-window arithmetic chain was separately reviewed from stg2813. Its prime counts retain their earlier external evidence; this audit does not upgrade them to Lean certificates.

## First batch

The first committed batch is global indices539..602, continuing directly from index538 at 1,143,945,143 and ending at 1,162,393,119. It spans 18,447,976 integers and reports 884,665 primes in 576 subwindows. All64 relaxed checkpoint tests pass. The minimum lower and upper margins are respectively 64180.0882524 and 147272.53764095.

Independent sample recounts:

| Global index | Interval (a,b] | Count |
|---:|---|---:|
|539|(1143945143,1144231129]|13816|
|570|(1152844028,1153132239]|13853|
|602|(1162102594,1162393119]|14030|
|6427|(4984323162,4985569242]|55916|
|6439|(4999296704,5000000000]|31327|

The last window is correctly shortened by min(5e9,a+floor(a/4000)); it does not overshoot the final endpoint.

## Saved full candidate result

There are 92 full batches of64 windows and a final batch of13, totaling5901 new windows. They join the earlier538 windows to cover all6439 grid intervals through5e9. The new portion reports177,184,261 primes; combined with the previous6,922,428, the candidate count after1e9 is184,106,689. All saved relaxed checkpoint brackets pass. The smallest new lower margin is64180.0882524; the smallest new upper margin is142006.210867698.

These totals and margins are verified arithmetic consequences of the saved counts. The original producer's two sieve layouts supply external count evidence, and the five selected recounts supply additional independent spot checks. The audit does not assert a second independent full-range sieve or a fully verified machine implementation.

## Counting, phase-free normalization and hash format

For each high interval (a,b], every integer exceeds every base prime. Therefore marking all multiples of p, starting at the first multiple at least a+1, cannot delete a prime in the interval. Every composite up to5e9 has a prime factor at most70710. Truncating the base at floor(sqrt(b)) remains complete for that interval.

The full representation has W=b-a bytes. Its position i represents a+1+i. The independent odd representation starts at the first odd integer in the interval. The code compares the entire odd slice and separately checks that the even slice has no surviving1. Both parity_offset cases are correct; the count equality is an additional check after pointwise equality, not a replacement for it. The final shortened interval and subwindow endpoints retain the open-left/closed-right convention.

**New hashes are SHA256 of W RAW classification bytes, each literally 0x00 or 0x01.** They are not text digits and are not the earlier newline-separated ASCII prime-list hashes. Metadata states this change explicitly. The sample recounts reconstruct the exact raw byte arrays and match their hashes. The remaining classification hashes bind reported outputs but cannot themselves establish their correctness without recomputation or proof.

## Logarithm and checkpoint logic

The literal Small.chkLow/Small.chkStep rational formulas are retained, with scale10^9 and width at most1e-7; Decimal logarithms are used only to propose boxes. Each theta update adds count times the previous endpoint's lower log numerator to L, and count times the new endpoint's upper numerator to U. Integer-scaled margins use exactly D/10000, which is integral at D=10^9. No rounding is introduced by this representation.

The change to ±a/10000 was independently proved sufficient in RESUME_PSI_STRESS_REPAIR_REVIEW_2026-11-11.md. It preserves E on the unchanged a/4000 grid, given the reviewed P6 bound. The original tight-contract failure at538 remains in its separate frozen artifact; this run starts from its valid enclosure under the relaxed condition rather than relabeling that old test as passing.

## Transaction and resume review

The implemented publication sequence is suitable for a single local writer:

1. Exclusive RUNNING.lock prevents a concurrent producer.
2. Each immutable JSON is written to a same-directory temporary file and replaced into its final name with os.replace. An existing final file must match the intended bytes exactly.
3. Batch data are published before the receipt. Only receipt-bearing batches are treated as committed on resume. An interruption before receipt publication may cause deterministic batch recomputation; it does not advance the committed seed.
4. Receipts link to the prior receipt or metadata hash and to the batch-data hash. Resume requires contiguous receipt filenames, matching predecessor hashes and contiguous grid/arithmetic chains.
5. A failed relaxed checkpoint is recorded, then the program stops. A resumed failed batch cannot pass advance(require_pass=True), even if an interruption prevented STOPPED.json from being written. Dual-representation or log discrepancies raise before committing the current batch. COMPLETE is emitted only at endpoint5e9/index6439 after successful arithmetic checks.

The code regenerates and checks metadata, binding the script hash, base list, original seed, tolerances and prior artifacts. Changing the script without a new dataset protocol would fail that metadata equality, which is appropriate for this frozen run.

### Limits and nonblocking robustness improvements

The frozen resume code checks the substantive row arithmetic and receipt predecessor/data hashes, but does not itself recheck every redundant receipt summary, the batch metadata_sha256/scale fields, or the receipt's suggested filename against the exact batch number. The independent validator here checks those fields and finds them correct in all saved batches. A future hardened resume validator should perform those checks itself.

ERROR_pid.txt does not prohibit restart; STOPPED.json does. Thus a past discrepancy can be retried after process exit without an explicit review gate, although no unchecked interrupted batch is silently accepted and the same deterministic discrepancy should fail again. Before intentional continuation after an error, require an operator review or an explicit reviewed error resolution. No such error file exists in this completed run.

There is no fsync/directory durability guarantee. Atomic replacement avoids exposing a half-written JSON under its final name in ordinary process interruption; it is not a proof of power-loss durability. Missing/corrupt artifacts are expected to fail the hash/parse/chain checks. A stale lock after a hard crash requires checking process ownership before removal. These source-level observations were not tested with injected crashes. They do not invalidate the intact frozen dataset or imply it is an adversarially hardened certificate format.

## Proof-status boundary

The candidate dataset now covers the entire short finite grid externally. It still needs kernel-checked prime-base completeness, generalized count specifications and concrete count equalities, logarithm/arithmetic replay, and the interpolation/P6 assembly. No new Lean count proof exists. The old66000-bit mask parameters remain insufficient; the candidate's ordinary arrays do not validate those old source hypotheses.

The short route also still needs the additional complete low-zeta strip/weighted-moment certificate through10^6 and the original selected finite/global spectral inputs. External completion of the finite prime grid does not discharge them. The frozen104-chapter package and prior notes were not changed in this audit.

## Frozen artifact pins

| Artifact | SHA256 |
|---|---|
| producer script | 1C67C3503E632F2661624E333A7F0F2AB2C2E01B7C99A140F3D865CE94AE0D78 |
| metadata.json | 0D65EC72AA1DC618558DD6ABBAA6BF6F7C13873BD2FA6617F38D768C2034D160 |
| base_primes.json | 9AB3C71A6E989BED8A71C95E30F51143D4F3876D49ED3220B4E4C0943A4A506E |
| batch_0001.json | D0645B3433023FBF0832ED8F3C1490557779853F82F3FC63BF550AFFA95E5196 |
| receipt_0001.json | 9CBF3CE557A7D636BD4106005574CED63A4F705D706E0D5B523521A9B6A4F6B0 |
| batch_0093.json | 057628E07C5D432EAC0439F81293764771EDFE0FC9006F18795DD2E9E2CB7FB0 |
| receipt_0093.json | 604B77ED187593841978045B24ED19F06458715255C6663B0C7C99DE3340A453 |
| COMPLETE.json | 92770E969395E4817210366B3ECBDFF218768D800C923CA6E7944CF71DD73763 |

All dataset files above are under prime-estimates/psi_full_candidate_20261111; the producer script is prime-estimates/resume_psi_full_candidate_20261111.py. The independent review script/JSON are in agents/audit.
