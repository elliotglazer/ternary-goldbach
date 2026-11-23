# Independent review: actual smoothing continuity and admissibility

2026-11-11. **PASS as a source-supported paper derivation.** No substantive mathematical correction is required. This is not a compiled proof, an axiom-closure audit, or verification of a sharp numerical Mellin bound.

Reviewed author: `major-constants/ACTUAL_SMOOTHING_CONTINUITY_JOIN_2026-11-11.md`, SHA256 `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`. The complete note was read and its hash checked. The review independently reconstructed its moment majorants, parameter arguments, Mellin convolution normalization, full-strip estimate, and residual continuity. Source statements and relevant proof bodies were read directly. No function values, evaluator/native programs, Lean builds, or numerical zero data were run.

## 1. Actual functions and absolute integrability

The definitions agree with the source: etaPlus is `hH 200 t * t * exp(-t^2/2)`, and etaU is the integral of `eta2(t/w) * phi(w) / w` over positive w. The usable positive-ray bounds are respectively `(63/20)t exp(-t^2/2)` and `144t^2 exp(-t^2/2)`. The second follows from the swapped convolution and the elementary support argument in `Helfgott/Decay`, not from a Platt-dependent arc estimate.

The all-real etaU continuity argument is valid. Its integrand is continuous in t for each w>0, and its absolute value is at most `3w exp(-w^2/2)`, integrable on the positive ray. The nonpositive values vanish because eta2 vanishes there. EtaPlus vanishes on the nonpositive ray by the source indicator identity; its positive-ray continuity and Gaussian envelope also establish continuity at zero. Thus the subsequent integrals have measurable integrands before integrability is asserted.

For `(C,d)=(63/20,1)` or `(144,2)`, put `q=a+d+r>0`. On `0<t<=1`, with `u=-log t`, the independent calculation is

    t^(q-1) u^m
      <= m! (2/q)^m t^(q/2-1).

This follows from the m-th nonnegative term of `exp(qu/2)`. It remains valid at m=0 and t=1. The resulting integral is `2^(m+1)m!/q^(m+1)`.

For t>=1, `|log t|^m<=t^m`, and the choice `2k>=max(0,b+d+r-1)+m` controls every allowed power of t. Completing the square gives

    -t^2/2 + 2*pi*D*t <= -t^2/4 + 4*pi^2*D^2.

The k-th exponential-series term then absorbs `t^(2k)` at cost `8^k k! exp(t^2/8)`. This proves exactly the author's Gaussian majorant. Its integral is bounded by `8^(k+1)k!`, since `exp(-t^2/8)<=exp(-t/8)` for t>=1. The complex-twist factor has norm `exp(-2*pi*Im(delta)*t)<=exp(2*pi*D*t)`, so the same argument works for local complex-twist neighborhoods. For real twists D=0, the bound is independent of the magnitude of the twist.

Consequently all the stated log and nonnegative-power moments converge on the claimed open half-planes. In particular 0, 1, and the full strip `[-1/2,3/2]` are interior values for both smoothings. The note does not claim convergence at the excluded limiting endpoints -1 or -2.

## 2. Continuity, derivatives, and normalization

The Mellin measure and exponent are correct: `M(s,delta)=integral t^(s-1) eta(t) exp(2*pi*i*delta*t) dt` over t>0. No `dt/t` is added to this expression. The source positive-real complex-power identity supplies norm `t^(Re(s)-1)`.

On a neighborhood of any admissible parameter pair, the preceding bound is an integrable majorant independent of that pair. Pointwise continuity and measurability give joint continuity by the actual Bochner dominated-continuity API. For each successive derivative, the next moment bound supplies the derivative majorant and center integrability. Differentiating the twist introduces `(2*pi*i)^r`, and differentiating s introduces `(log t)^m`. Formula (5) includes both correctly. These are ordinary derivatives, with no hidden factorial normalization. Parameter-by-parameter differentiation suffices; no joint-holomorphy theorem is silently assumed.

At s=1, the source Fourier sign is `fourier eta (-delta)`. The negative half-line contributes zero, so this is the actual principal term. A fixed finite zero carrier, its fixed multiplicities, the factor `z^(rho-1)` for z>0, and a finite sum preserve continuity. This does not require continuity or absolute convergence of an infinite zero sum.

## 3. Full-strip etaU admissibility

Starting with the swapped convolution, its double Mellin integrand is

    eta2(r)/r * t^(s-1) * phi(t/r) * exp(2*pi*i*delta*t).

The substitution t=rv contributes a Jacobian r, leaving the exact factor `eta2(r) r^(s-1)`. The inner integral is `Gr(s,delta*r,0)`. Its absolute integral is a Gaussian moment with power `Re(s)+1`; it converges for Re(s)>-2. The remaining r integral has compact support bounded away from zero. These statements justify absolute Fubini and the substitution before using the identity, including at s=0 and s=1.

`Explicit/GMellin.norm_G_le_strip:86` really covers the entire closed strip `[-1/2,3/2]`. Its constant is the positive finite integral Kdelta in that file, not the narrower-domain constant 900. For r in `[1/4,1]`, `|delta*r|<=|delta|`; comparison of positive integrands gives `Kdelta(delta*r)<=Kdelta(delta)`. Also `r^(Re(s)-1)<=8`. The eta2 integral is 1. These facts prove

    |M_U(s,delta)| <= 8 Kdelta(delta) exp(-.28 |Im(s)|).

The comparison integrals are finite by `integrableOn_rpow_mul_exp_quad` with powers 1/2 and 5/2 and positive quadratic coefficient `cos(.56)/2`. No order comparison of divergent or merely totalized integrals is involved. The optional improvement using `Eta2Moments.moment_3half:176` is also valid: the integrated support weight is at most 2.74517, hence below 3.

Together with the moment and continuity results, this supplies all five actual fields of `GoodSmoothing` for etaU at each fixed real twist. For etaPlus the existing `goodSmoothing_fP:268` already supplies these fields. The new etaU argument has no spectral premise. Its qualitative constant may be large; it supplies neither a selected high-zero tail bound nor any Gram or major-arc numerical inequality.

## 4. Actual residual measurability and dependency scope

`Helfgott/Decay.summable_etaPlus` and `summable_etaStar` give absolute summability of the fixed-scale von Mangoldt coefficients. For etaU, apply `etaStar_eq_etaU` at scale 49z for n>0. The zero summand is handled separately by Lambda(0)=0, so a positive-argument lemma is not used at n=0. Character and coprimality factors do not increase the bound. The real additive twist has unit modulus and continuous summands; `continuous_tsum` therefore applies with a twist-independent summable bound.

The actual residual R and finite low-zero sum p are continuous, hence `R-p` is Borel measurable. This supplies the measurability input of `ZERO_SUM_SOURCE_JOIN` at its final pin `600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA`. There is no selection of a measurable good-height sequence and no limit exchanged with the arc integral.

The selected envelope, summability, eta2, Gaussian Mellin, and etaPlus-admissibility declarations have no PlattGRH premise, and their inspected proof bodies use the stated analytic ingredients. Broad enclosing imports contain conditional results. This review does not identify importing such files with using those hypotheses, nor claim a complete elaborated axiom audit. Moving the new etaU lemmas near its definition avoids the circular import that would result from importing MajorTotal into Explicit merely for measurability.

## 5. Minor API clarifications and source pins

Two implementation clarifications do not change the verdict:

* `hasDerivAt_integral_of_dominated_loc_of_deriv_le` is a global declaration in `Analysis/Calculus/ParametricIntegral.lean:284`; `ParametricIntegral.` in the author's prose should be read as the file label, not a namespace prefix. The declaration is polymorphic over an RCLike field, so it supports the complex one-parameter derivatives used here. Its hypotheses include center integrability and derivative measurability, both supplied above.
* `Integrals/Basic.lean:236` is a finite-interval exponential formula. For the improper tail one can use `Analysis/SpecialFunctions/ImproperIntegrals.lean:77` (`integrableOn_exp_mul_Ioi`) and :102 (`integral_exp_mul_Ioi`) directly, or pass to the limit in the finite formula. The paper's exponential tail estimate already includes this mathematical step.

All seven source hashes in the author note were independently rechecked and match. Additional files inspected, with SHA256:

| File | SHA256 |
| --- | --- |
| MinorArcs/BaseGap2.lean | AAD66405B48CFBFE46DE3196CE82D3CAB57136353F482CA3DF4B591A27B9C60E |
| Explicit/ExplicitFormula.lean | 8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35 |
| MajorArcs/Eta2Moments.lean | 3DDC63BE9937E6022B77B80238CC1666A3B122161CC0CFA02081E0E9A2DF0871 |
| Analysis/Calculus/ParametricIntegral.lean | 25DB07D17F5E3D4B0B424315CBE0A90075AFE4889DC36EDCE73968D656EE3BE4 |
| MeasureTheory/Integral/Bochner/Basic.lean | AD1563F0A02C9A283353898E6A8AAD8781CF993F4C507A1B24147971C235ADB6 |
| Analysis/MellinTransform.lean | 5E7D9902133DA1210CFC9BA447EE2178C3224AD2ACE8EEBEBCA43243232DE38D |
| Analysis/Normed/Group/FunctionSeries.lean | EE789D376FDE7B3CAB84FBD6569966BD72A7F88CEBB274251898B5B9B5840C0D |
| Analysis/SpecialFunctions/ImproperIntegrals.lean | 2A16F764506DC7D528E9BBC7710621C257CB5806F3826137643972D1A1639E9B |

Ternary files are from the pinned `work/ternary-goldbach` checkout. Mathlib files were read from `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`, the existing cache identified in the author note. This is source/API review, not verification that a future consumer build uses those files.

The remaining work for this join is Lean implementation and validation of the moment, dominated-parameter, etaU mixture, and residual wrappers. Finite spectral certificates, the global provider, sharp numerical estimates, and the final ternary theorem remain outside this PASS.
