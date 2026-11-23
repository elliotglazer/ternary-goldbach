# Source arithmetic review

13 November 2026. Independent source-only review of `SourceArithmeticScript.sml`, SHA256 `0B19AD2A223A9069C288B00C79B8CE7EE82D60C0E2ABD8A11A1E29C09C36D875`, and `README.md`, SHA256 `CA96BADFEDD9417A3DE972A1AEDBD78535769C1BB48D52EFBF75192C05E6EABE`.

Verdict: no mathematical formula correction is required before a focused build of this numerical core. This is not an acceptance of the uncompiled HOL declarations or a closed analytic producer. No HOL/Lean build, numerical evaluation, CV translation, or dependency change was performed for this review. The only new file is this review.

## Exact program correspondence

The signed rounding operation is the existing `BlockRound.round_scaled`, `(2*r+s)/(2*s)`, matching Lean's `RawHead.roundDiv` for positive divisors, including negative numerators and ties toward positive infinity. `BlockRoundScript.sml` has SHA256 `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143`. Its residual is `-s <= 2*(r-round_scaled s r*s) < s`, exactly the orientation consumed by `source_mul_residuals`.

| HOL definition | Source comparison and finding |
|---|---|
| `source_log_horner`, `source_log_center` | Match `RawLogHorner.logHorner/logCenter`: terminal zero, denominator `(2*k+1)*B^2`, numerator `S*B^2+(2*k+1)*A^2*previous`, followed by nearest division of `2*A*previous` by `B`. |
| `source_raw_log129` | Matches `RawLogAssembly.log129Center`: inner scale `2^137`, 45 logarithm terms, actual shared `logCenter ... 1 3 45`, and final division by 256. |
| `source_exp_step`, `source_exp_horner` | Match `RawExpInteger`: terminal `(S,0)`, denominator `d*(k+1)`, simultaneous old coordinates, real numerator `S*den-p*wi`, imaginary numerator `p*wr`. `N` updates produce the degree-`N` polynomial with `N+1` terms. |
| `source_raw_step` | Matches `stepFromLog`, not the entire composed log producer: `p=-5*q`, denominator `2^135`, 72 updates on grid 131, then division by 512 to grid 122. This is 73 exponential terms; the 45 in the log producer is a different polynomial length. |
| `source_inverse_root` | The rational extension is correctly `ROOT 2 ((D*S*S) DIV A)`. At `D=1` it matches the mathematical result of Lean's `Nat.sqrt ((S*S)/x)`. No formal cross-prover equality is asserted. |
| `source_raw_initial` | For positive integer `x`, returns `SOME` of the grid-98 numerator embedded by `2^22` on grid 120. This is an option wrapper around the Lean initial pair, not unconditional equality of the total programs at invalid `x=0`. |
| `source_mul`, `source_state` | Match four-product `mulStep` and persistent recurrence. The divisor is the right operand's scale, independent of the persistent left/output scale. The step is fixed, and each update uses the preceding state. |
| `source_pool_tick` | Performs one such update per entry and preserves its step. It preserves list length, but does not yet prove iteration, argument order or source association. |

All nine Lean source hashes listed in the README were independently read and matched. Their source bodies, rather than only their theorem names, were used above. These Lean proofs are specifications for the HOL port; they do not confer HOL theorem status.

## Rational domain and initialization

For positive `D` and `2^k*D <= A <= 2*2^k*D`, the rational base is `x=A/D>=1`. The local atanh argument is exactly `(A-2^k*D)/(A+2^k*D)`, lies between zero and one third, and has positive denominator. Thus natural subtraction is appropriate only after the gate has been proved. The source correctly retains that gate. Its generic `source_log_checked` does not certify the supplied `l2`, impose an error-dependent upper bound on `k`, or certify a logarithm radius. Its only theorem says the gate held.

For `m=ROOT 2 ((D*S*S) DIV A)` and `A>0`, the intended adjacent-square statement is `m*m*A <= D*S*S < (m+1)*(m+1)*A`. With `D>0` and `S>0`, this gives a one-sided approximation to `sqrt(D/A)` with error strictly below `1/S`. The formula handles exact squares, including `x=1`. The HOL proof from `ROOT` and integer division, its real interpretation and exact embedding proof remain missing.

The first EM pool uses `A=512+k`, `D=512`, amplitude bits 123 and persistent bits 140. The caller's `k<=113152` supplies `1<=x<=222`; the function does not enforce the upper bound. At height zero no initial cis is necessary. This does not initialize new arguments introduced later at nonzero heights.

`logrootScript.sml`, SHA256 `E6EE98912238AC22D9943F72A2C60FE0D7A053CCBA7BA9C7B8C2F0AE4CE69E27`, proves the `ROOT` specification from existence and supplies `numeral_root2` and numeral square-root computation theorems. Existing `logrootTheory` object/interface/data files are present. This supports the mathematical executable specification, but does not establish a successful CV translation of this new function.

## EM exponential schedule

The separate EM schedule agrees with the cited elementary-leaf and height-recurrence papers. If `l145` represents a log center on grid 145, multiplying by `-5/64` gives `-5*l145/2^151`. Representing that exact phase on grid 161 requires numerator `-5*l145*2^10`, as in the code.

`round_scaled (2*pi161) phase161` gives the nearest signed number of periods. Subtracting `2*turns*pi161` retains the exact reduced rational phase. A positive pi center makes this arithmetic well-defined, but positivity alone proves neither its accuracy nor the required reduced argument bound. The actual pi enclosure, a coarse guard such as `3<pi_hat<4`, a turn bound, and the real exponential periodicity/Lipschitz argument must still be supplied.

For the baseline cis parameter 138, the paper chooses 83 terms and inner grid 151. The code therefore correctly uses 82 updates. Seven-bit coordinate regridding produces grid 144; the second two-bit regrid produces the separately required grid 142 step. Both operations are retained. The source budget is log-phase error `(5/64)*2^-144`, complete cis error below `2^-142`, then separate step-rounding error below `2^-142`, totaling below `2^-140`. None of these analytic inequalities is proved by the new module's three small theorems.

The selected EM logarithm algorithm is the shared anchor/degree-21 construction at accuracy 144. The generic atanh routine and raw 45-term specialization do not implement it. The README correctly excludes a silent schedule or cost substitution. A direct target-144 baseline would use 50 log terms and different grids, and needs its own actual proof and pricing if chosen.

## Build and proof boundaries

The theory imports only `BlockRound`, arithmetic/integer/list/option and `logroot`. Its three proposed theorems concern gate implications, map length, and signed residuals. Their statements follow mathematically from the definitions and existing residual theorem. Their parser, tactic elaboration and axiom closure remain subject to root's build and exact-type audit. The new file imports no real/complex theory and cannot establish an analytic source value by itself.

Before treating these outputs as source-certified transform input, the remaining work includes the rational logarithm identity/tail and actual cached-log association, the selected EM log producer, complex Horner/Taylor correctness for 83 terms, an actual pi producer and phase reduction proof, rational inverse-root correctness, persistent recurrence error with its cross term, and separate grid-122 exports without low-grid feedback. The raw branch additionally needs its existing bounds on base range, exponent and number of steps reproduced in HOL. No generic function signature supplies those bounds.

Finally, neither pool supplies the required 4,800 transform pairs directly. Finite EM coefficients, shifts and residue evaluation, raw-head assembly, exact grid-100 sum, one grid-81 input conversion, character order, transform semantics, completion and strict sign still require their own proofs and actual outputs. The README exposes this boundary correctly. There is no source-to-sign or throughput completion claim to approve here.
