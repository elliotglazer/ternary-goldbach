# Actual raw phase range and error

HOL4 checked four theorem statements from `SourcePhaseRangeScript.sml`. For `source_log_domain x 1 k` and `k ≤ 18`, write `q = source_raw_log129 k x`, `u = real_of_int (−5*q) / &(2**135)` and `θ = −(5/64) ln(&x)`. The exports give `|u−θ| ≤ (5/64)/2^128` and `|u| ≤ 2`. The latter supplies the phase premise of `SourceExpHornerTheory.source_exp_horner_zero_error` at the actual raw numerator and denominator.

`spr_grid` proves the precise change of grid from 129 to 135 bits. `spr_log_range` uses the integer source-domain cap `1 ≤ x ≤ 2^19`, monotonicity of `ln`, and `ln 2 ≤ 1` to prove `0 ≤ ln(&x) ≤ 19`. `source_raw_phase_error` rescales `SourceLogRangeTheory.source_raw_log129_error`. The range and error theorems quantify over the executable `source_raw_log129` output.

`phase05.status` and `audit01.status` both contain zero. A new HOL process loaded the exported theory, compared all four statements for alpha-equivalence to the independently written quotations in `phase_audit.sml`, checked empty hypotheses and axiom tags, and allowed only the standard `DISK_THM` reload tag. Its ancestry check found exactly `bool.SELECT_AX`, `bool.INFINITY_AX`, `bool.ETA_AX`, and `bool.BOOL_CASES_AX`. The logs, source and output hashes, and time records are in this directory. The `SourceLogRangeTheory.uo` and `.dat` input hashes match the accepted `../source-log-range/range03_output.sha256` receipt.

The one-job theory build used 22.79 CPU seconds, 58.68 seconds elapsed and 1,017,384 KiB peak RSS. After preparing the audit loader, the independent HOL audit used 14.16 CPU seconds, 23.15 seconds elapsed and 764,000 KiB peak RSS. These measurements cover construction and reload of this reusable theorem. They provide no campaign-throughput measurement.

The fallback runner used the existing `docker-desktop` WSL distribution, the original pinned HOL4 installation and a private mount namespace. The workspace mount was read-only except for the experiment leaf and its local copies of dependency-index directories. Older labels record the experiments before the accepted `phase05` build.

The Taylor polynomial identity, its remainder, sensitivity to the phase error, and the final output-grid rounding remain separate parts of the raw producer proof. The EM producer uses other arguments and grids.
