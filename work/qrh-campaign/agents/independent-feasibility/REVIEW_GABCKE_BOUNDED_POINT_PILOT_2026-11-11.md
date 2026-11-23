# Independent review of the ten-point Gabcke pilot

2026-11-11. **PASS within the bounded external interval-pilot scope.** I found no mathematical or evaluator defect in the ten reported enclosures. An independently written evaluator checked all ten inputs with changed precision, EM parameters, phase propagation, and correction evaluation. Every original and alternate enclosure has the claimed strict sign. This is not a Lean proof, a production sign chain, a zero count, or a strip certificate.

## Pinned inputs and new evidence

All paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
|---|---|
| `mellin/GABCKE_BOUNDED_POINT_PILOT_2026-11-11.md` | `EC0D21B670F9005C65BE50F1B157D0051261F6B2375CEDF9AD81CA518A5A3080` |
| `mellin/gabcke_bounded_point_pilot_20261111.py` | `90AAE865FF49E10D82532B51DD3F4CC967A4E702467BE55625DFA81407FB7FDA` |
| `mellin/gabcke_bounded_point_pilot_20261111.json` | `7944B755DF307E3B03B6906869B31762D502C23D4FF6DD1BA06C655631376915` |
| `mellin/gabcke_1979_corrected_2015.pdf` | `A28AE7BE557F75997D1F9C48C9517247581F55AB89477181127F83E3DFFBBE53` |
| `audit/GABCKE_PRINCIPAL_EVALUATOR_SOURCE_REVIEW_2026-11-11.md` | `55C9C07C7958DF4DABCF3799705B56486103ED2AFB78453865466AA2B3D7F9ED` |

New reviewer script `independent-feasibility/review_gabcke_bounded_point_pilot_20261111.py` has SHA256 `D5E114BDF71E2298ECCE82E81BBB0A5BCAF431655102F661F1469003084A49E9`. Its same-stem JSON has SHA256 `23825BAF42BD3DC3F46AEBE6808A7F0D97C0787B35C1A0FFD666C4DABA8EA3CF`.

The script verifies all five input hashes, imports no producer code, and writes only its own receipt. One initial invocation stopped at the hash guard because I had mistyped the auditor hash (an extra `f`); no numerical point was evaluated. After correcting that literal to the independently read file hash, the complete run exited 0 in 1.46175 internal seconds. This is the only numerical alternate run. No original artifact was changed. No Lean, dependency installation, full scan, builtin zeta, Riemann–Siegel, Gamma, Hardy, indexed-zero, or zero-count call was made.

## Source normalization and enclosure logic

I read the author note and complete script, the source auditor's report, and the rendered primary pages for equation 3.26, Satz 3.2.2(a), and Satz 4.2.3(d). The [corrected primary thesis](https://d-nb.info/1072293277/34) fixes the conventions:

* `a=sqrt(t/(2*pi))`, `N=floor(a)`, and `p=1-2*(a-N)`.
* K0 **includes** the correction `(-1)^(N-1) F(p)/sqrt(a)`, with `F(p)=cos(pi*(p^2+3/4)/2)/cos(pi*p)` interpreted by removable continuation.
* The final Hardy-Z error is `.47*t^(-3/4)` for `t>=200`. It is not multiplied by another `1/sqrt(a)`.
* The true, continuously normalized theta equals `theta0 + 1/(48*t) + 7/(5760*t^3) + 31/(80640*t^5)` with error less than `1/(3322*t^7)` for `t>=10`. It is not a principal numerical Gamma argument.

All ten heights lie in `[1500,1000000]`, so both source domains apply. Here `N<=398`; integral comparison gives `2*sum(n^(-1/2),n=1..N)<=4*sqrt(N)-2<80`. The producer's separate phase allowance `80/(3322*t^7)` is therefore valid by the cosine Lipschitz inequality. Its analytic and phase errors are added to the final Z enclosure, and elementary arithmetic rounding remains in the Arb balls.

The independent evaluator instead inserts the whole true-theta interval into each cosine, then adds only the Gabcke remainder. It checks each floor through the stronger explicit interval inequalities `2*pi*N^2<=t<2*pi*(N+1)^2`. The stored floors are `15,15,39,126,282,398,100,100,199,200`. It also verifies that the last two rational heights lie strictly on opposite sides of `2*pi*200^2`. No exact transcendental floor-boundary value was tested; an eventual general evaluator must retain its ambiguous-floor rejection or supply a separate boundary proof.

For the removable chart, evenness and elementary sine identities give

`F(1/2+u) = (1+u)/2 * sinc(pi*u*(1+u)/2) / sinc(pi*u)`.

For `|u|<=1/4`, both sinc arguments have absolute value below 1. The producer includes terms through degree 48; the first omitted absolute term is `r^50/51!`, and successive ratios are at most `r^2/(52*53)`. Its displayed geometric tail is correct. The denominator is strictly positive: the alternating-series bound `sinc(v)>=1-v^2/6` on `|v|<=pi/4` gives `sinc(v)>7/8`. The script also checks its computed denominator before division. At `u=0` the continued value is exactly `1/2`.

For independent arithmetic I used ordinary cosine division at all ten points, proving each denominator excludes zero. This is well-conditioned enough at 192 bits even for the two small denominators near `p=+/-1/2`. A separately constructed degree-36 sinc polynomial with tail `r^38/39!/(1-r^2/(40*41))` overlaps the ordinary quotient on all three applicable inputs. Separate checks cover the exact removable value `u=0` and the uniform `7/8` bound. The two pilot heights near the removable points are not the exact removable points themselves.

## Independent EM and phase check

The alternate calculation uses 192 bits, `N_EM=ceil(t/3)+31`, and `M=36`, versus the producer's 160 bits, `ceil(t/2)+17`, and `M=28`. It reconstructs Bernoulli coefficients by exact rational recurrence and forms the pole-cancelled entire finite expression

`g(s)=(s-1)*(sum_(n<=N) n^(-s) + B^(-s)/2 + correction_sum) + B^(1-s)`, with `B=N+1`.

The correction coefficient is `B_(2k)/(2k)! * (s)_(2k-1) * B^(1-s-2k)`. The common periodic-Bernoulli EM remainder estimate at `sigma=1/2` is

`E_zeta = 4*|(s)_(2M)|*B^(1/2-2M)/(6^(2M)*(2M-1/2))`.

I insert `|s-1|*E_zeta` into both Cartesian coordinates of `g`, then divide by the nonzero `s-1`. That coordinate square conservatively contains the complex error disk. The resulting enclosure is therefore a zeta enclosure; no factor of `|s-1|` is lost. Its largest scalar `E_zeta` among these ten inputs is below `6.792e-21`.

The alternate reference computes `Re(exp(i*theta_interval)*zeta_interval)` directly. It does not divide a theta0 proxy by a phase cosine. The producer's different conversion is also valid: if `Z=exp(i*theta)*zeta` is real, then `Re(exp(i*theta0)*zeta)=Z*cos(theta-theta0)`. Its denominator is enclosed with the source phase error and is greater than `.999`; my script verifies that inequality independently on every input. The realness and normalized phase remain analytic source obligations, not consequences of numerical overlap.

Both implementations share Arb and the source EM/phase estimates. Thus this is independent code and changed-parameter evidence, not an independent arithmetic library or a new proof of those analytic estimates.

## Acceptance checks and result

Acceptance does **not** rely on the producer's `PASS_BOUNDED_POINT_ENCLOSURES` string, which checks overlap but not every sign claim. The reviewer requires exactly ten rows, the ten explicitly fixed rational inputs, and for each row:

1. Strict signs computed from its stored rational lower/upper bounds, agreeing with both stored sign fields and the independently prescribed sign sequence `+,+,-,+,+,-,+,+,+,+`.
2. Exact rational containment of the original EM interval in the original Gabcke interval.
3. A separately certified square-root floor and matching original `N`.
4. Matching strict signs for the new Gabcke and new EM intervals.
5. Containment of the new EM interval in both the original and new Gabcke intervals.
6. Overlap of the two EM intervals and of the two Gabcke intervals.

Every check passed. The largest alternate EM-reference width is below `1.395e-20`. The original two floor-transition points remain positive on both sides; the audit does not infer continuity of the truncated K0 expression across that transition. The exact Hardy function is continuous, while its finite expression and error representation may change.

## Remaining proof and production work

The source auditor accepted the transcription, not reconstruction of Gabcke's analytic remainder and phase proofs. Those lemmas, the EM identity/remainder, Hardy realness, and elementary interval arithmetic still need kernel-checkable proofs and proof-producing numerical replay. The ten strict signs provide no number of zeros between inputs, no high sign chain, and no principal strip assertion on `1500<|gamma|<=1000000`. Timing from this tiny run is not a forecast for a chain or Lean replay.

No producer correction is required. A subsequent bounded production experiment can use this pilot as reviewed external implementation evidence, provided it checks every strict sign independently, handles unresolved floor/sign cases explicitly, and keeps its completeness argument separate.
