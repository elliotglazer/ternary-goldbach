# Gamma completion source and constant audit

2026-11-11. Independent bounded PASS for the frozen helper mathematics, literal definitions and helper axiom closure. No author correction is required. This is not a review of the final actual-L export or a replacement for its integration audit.

The targets are `SpectralCompletion.gammaPhase_enclosure` in `GammaEnclosure.lean`, SHA256 `1CCA415D6FA64E24F052F0426C36BB68A373E30166F9234C61A5C7D11DD7B920`, and `completion_factor_eq`, `completionScale_pos`, and `completed_product_positive` in `CompletionFactor.lean`, SHA256 `F1BF6D24853A20EE9524E839907E8B2C8ABCA270148435B9A3A465743E805359`. Their author directory is `work/lean-pilots/spectral-completion`. Neither file was changed during this review.

## Actual objects and scope

The source object is the actual Mathlib complex Gamma function at `3/4 + I*(5/128)`. The definition under review is

    gammaPhase = exp(I * (5/128)*log(4/pi)) * Gamma(3/4 + I*(5/128)).

Here the logarithm is real and its argument is positive. The compiled definition has this literal body, not an arbitrary complex number constrained by an assumed enclosure. `samplePoint` is exactly `1/2 + I*(5/64)`. `completionScale` is exactly the real exponential of `log(4)/4 - 3*log(pi)/4` and is strictly positive.

The exact completion identity is

    4^(samplePoint/2) * GammaR(samplePoint+1)
      = completionScale * gammaPhase.

Mathlib defines `GammaR(s) = pi^(-s/2) * Gamma(s/2)`. Consequently the real exponent is `log(4)/4 - 3*log(pi)/4`, and the imaginary exponent is `5*(log(4)-log(pi))/128`. Both the conductor 4 and the sign of the phase are correct. Positive real bases permit the real-log complex-power identities; no branch choice is suppressed. The helper does not assert a character root phase or the full canonical Hardy normalization. Those belong to the actual-L integration.

Definition checks for `gammaPhase`, `samplePoint`, and `completionScale`: BODY_MATCH OK; PUBLIC_CARRIER OK; WELL_DEFINEDNESS N/A_LITERAL; CHARACTERIZATION N/A_LITERAL; CHOICE_INDEPENDENCE N/A; DEFINITION_VERDICT PASS. Gamma and complex powers are the existing Mathlib definitions, not new oracle constants.

## Independent derivation of the bounds

Mathlib proves ordinary convexity of real Gamma on the positive half-line from its log convexity and positivity. On [1,2], convexity with Gamma(1)=Gamma(2)=1 gives Gamma(x)<=1. Recurrence therefore gives Gamma(3/4)<=4/3 and Gamma(1/4)<=4, while Gamma(5/4)<=1. Interpolating at 1 with weights 3/4 and 1/4 between 3/4 and 7/4 yields

    1 <= (3/4)*Gamma(3/4) + (1/4)*Gamma(7/4)
      = (15/16)*Gamma(3/4),

so Gamma(3/4)>=16/15. Every argument is positive; recurrence never divides by zero.

For x>0, applying `2u <= exp(u)` to u=log(x)/2 and its negative proves `abs(log(x)) <= sqrt(x) + 1/sqrt(x)`. The complex phase estimate `norm(exp(I*v)-1) <= abs(v)` then bounds the difference of the two Euler integrands by

    abs(b)*exp(-x)*(x^(a-1+1/2) + x^(a-1-1/2)).

At a=3/4, the dominating Gamma arguments are 5/4 and 1/4, both strictly positive and integrable. Mathlib's Bochner integral on `Ioi 0` is used for the actual complex Gamma function. Integrability is proved before subtracting integrals, and the pointwise comparison is used only almost everywhere on x>0. There is no assertion about an undefined logarithm at x=0 and no unproved interchange of differentiation and integration.

Thus the vertical difference is at most `(5/128)*(1+4)=25/128`. The inequalities 3<pi<4 and log(u)<=u-1 for u>0 give `0 <= log(4/pi) <= 1/3`; the phase angle is at most 5/384. Splitting the rotated Gamma difference as

    e*(Gamma(a+ib)-Gamma(a)) + (e-1)*Gamma(a)

retains both contributions and uses norm(e)=1. The total bound is

    25/128 + (5/384)*(4/3) = 245/1152.

The real enclosure has reserve `16/15 - 245/1152 - 3/4 = 599/5760 > 0`; the imaginary enclosure has reserve `1/4 - 245/1152 = 43/1152 > 0`. Hence the closed bounds Re(gammaPhase)>=3/4 and abs(Im(gammaPhase))<=1/4 hold. No Gamma evaluation, finite lookup table or assumed numerical box appears in this proof.

For the conditional complex-product helper, Re(L)>1/4 and abs(Im(L))<1/2 give a strict real-part reserve exceeding `3/16-1/8=1/16` before the positive scale. The proof keeps the imaginary cross term rather than discarding it.

## Binder and consumption audit

| Export or input | Classification | Finding |
|---|---|---|
| `gammaPhase_enclosure` | No binders | Closed actual-Gamma enclosure; zero SOURCE, STANDING, TYPING, RULED or EXCESS inputs. |
| `completionScale_pos` | No binders | Closed positivity of the literal exponential. |
| `completion_factor_eq` | No binders | Closed literal identity with the exact conductor and sample point. |
| `completed_product_positive`: implicit `L : Complex` | TYPING | Arbitrary complex input of this internal conditional lemma. |
| `hLre : 1/4 < L.re` | SOURCE for the conditional lemma | Explicit required input, not a proved actual-L bound here. |
| `hLim : abs(L.im) < 1/2` | SOURCE for the conditional lemma | Explicit required input, not a proved actual-L bound here. |

The conditional helper has SOURCE=2, TYPING=1 and other bins zero relative to its stated conditional mathematical lemma. It is CONDITIONAL as an actual-L certificate. It cannot replace the closed final theorem unless the integration supplies these two bounds from the actual L producer. Treating these premises as an unconditional L enclosure would fail the source audit. This review intentionally does not duplicate the full final export probe.

## Independent checks and history

`check_gamma_constants.py` ran 18 exact rational checks, saved in `gamma_constants_receipt.json`. It evaluates no transcendental functions. The source proof was compared with pinned Mathlib Gamma Basic, BohrMollerup and Deligne files, real-log bounds, and the trigonometric complex-exponential bound.

A helper-only independent probe imported the frozen `CompletionFactor.olean`, checked the literal phase definition, the closed Gamma box and positive scale, then printed axioms for the three substantive exports. It ran with Lean4.35.0, `-j 1 -t 0`, no resource or tactic settings overrides, and read-only dependency caches. The successful receipt is `helper_probe_v2_receipt.json`, exit 0, wall 23.5237705 seconds. Every printed axiom set is exactly `[propext, Classical.choice, Quot.sound]`. No `sorryAx`, custom axiom or native-decide acceptance is present. These timings measure the narrow audit import/check, not spectral generation throughput.

The first independent probe failed only because `rfl` did not equate a cast of a real product with the product of its casts. It also hit a console encoding error after the failure receipt and log were saved. The second probe used `simp only [SpectralCompletion.gammaPhase, Complex.ofReal_mul]` for that defining equation. No target theorem or mathematical assumption changed. Both receipts/logs are retained. Temporary probe source files were removed after their hashes and source text were recorded in `audit_probe_sources.json`; no project or dependency artifact was deleted.

The complete source and evidence hashes are in `gamma_completion_source_ledger.json`. This scoped PASS does not certify the final L-series approximation, character/root-phase identity, positivity of a complete exported sample, or any general family/height algorithm. Those remain the integration review's responsibility.
