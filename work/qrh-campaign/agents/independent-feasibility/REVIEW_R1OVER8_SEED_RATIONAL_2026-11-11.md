# Independent review of the r=1/8 rational seed certificate

2026-11-11. **PASS at paper-proof plus exact external arithmetic scope. No correction requested.** The actual expression

`exp(1/4)*(-cos(2/1000001)+i*sin(2/1000001))`

lies strictly inside the exact frozen seed box of the specified T=1000000, r=1/8 lossless word. The new exponential factor has a complete all-index remainder argument. No numerical transcendental value is used as an acceptance premise. This review concerns the seed only; it does not independently certify the remainder of the word or supply a Lean proof.

## Frozen target and evidence

Paths are relative to `work/qrh-campaign/agents/`.

| Item | SHA256 |
| --- | --- |
| `integration/lossless_modular_word_20261111.json` | `E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910` |
| `prime-estimates/R1OVER8_SEED_RATIONAL_2026-11-11.md` | `5C2B846B4BF1983CE8448FCDBF78FE7860B68C57030598E72D6649831BD37C16` |
| `prime-estimates/r1over8_seed_rational_20261111.py` | `099E38BEAF5C184234FA35D30C896C996FC166CBE5E0002B532692D4F298C173` |
| `prime-estimates/r1over8_seed_rational_20261111.json` | `E4EFD292003D1216EDA8E4BD9BFF7921050874F9378222C34A5A71EC39974E89` |
| Independent `independent-feasibility/review_lossless_r1over8_seed_20261111.py` | `2BD6C032521EA129D965A0DD5B81C4B7D1EF820334D4AD9D58074DF84A660F98` |
| Independent receipt, same stem `.json` | `A2617AA2F104C29C048C4CB9B36C63B8E4108038810474A9441C41026217EC30` |

Integration supplied the target hash directly. The independent script checks that hash and the packet format, integer T, exact r string, literal expression, and first node's identity, kind, operation and empty operands. The target is `packet.nodes[0]`, ID `tau`. Its real and imaginary coordinates are exact dyadic midpoint/radius intervals. Both radii are nonnegative and both lo/hi pairs equal midpoint minus/plus radius. These identities were recomputed, not inferred from the target's status text.

The argument is exactly x=2/(T+1)=2/1000001, and u=2r=1/4. No nearby parameter or different seed payload is substituted. The modular expression `i*exp(2w)` at `w=r+i*(pi/4-1/(T+1))` simplifies symbolically to the displayed seed; the certificate itself establishes the displayed expression directly.

I read the complete producer report and code, independently reconstructed the certificate arithmetic, and ran its read-only `--check` path. The target and producer files remained unchanged. Neither the independent code nor the producer replay imports Arb or invokes exp, sine, cosine, pi, or any other numerical transcendental evaluator.

## All-index exponential remainder

Put `t_k=(1/4)^k/k!` and `EL=sum_{k<48} t_k`. All t_k are positive. For every natural j,

```
t_(48+j+1) = t_(48+j)/(4*(49+j))
            <= (1/196)*t_(48+j).
```

Starting with j=0, induction gives `t_(48+j)<=t_48*(1/196)^j` for every j. The denominator comparison is valid uniformly, not just for the finite indices in the receipt. The geometric ratio is positive and strictly below one. Therefore every finite tail is bounded by the corresponding geometric partial sum. Passing to the sum gives

`0 < exp(1/4)-EL <= t_48/(1-1/196)`.

The strict lower inequality follows already from the positive first omitted term. The upper bound includes that term with coefficient one, so there is no off-by-one loss at the start of the tail. Defining `EU=EL+t_48/(1-1/196)` gives a sound positive factor interval. The finite certificate's equality `tail*(1-rho)=t_48` and its 49 supplied terms agree exactly with these definitions.

The source bridge is to the actual real exponential. At the stated Mathlib pin, `NormedSpace.expSeries_div_hasSum_exp` in `Analysis/Normed/Algebra/Exponential.lean:640` supplies the complete power series. `Real.exp_eq_exp_ℝ` in `Analysis/SpecialFunctions/Exponential.lean:214` identifies it with Real.exp. The geometric-series theorem in `Analysis/SpecificLimits/Basic.lean:317` has exactly the nonnegative-ratio and ratio-below-one assumptions used here. I inspected these statements and verified their three file hashes against the producer's source table.

## Trigonometric and product bounds

For a=0 or 1, `f_a(k)=x^(2k+a)/(2k+a)!` has successor ratio

`x²/((2k+a+1)*(2k+a+2)) <= x²/((a+1)*(a+2)) < 1`

for every k. Thus it decreases to zero and is dominated by a convergent geometric sequence. The actual cosine and sine series give the stated even-six-term lower and odd-seven-term upper bounds. I inspected `Real.hasSum_cos`, `Real.hasSum_sin` and the two alternating partial-sum bounds at the cited source lines; their files have the claimed hashes. The old r=0 argument is valid mathematical reuse at this same x, but this review also checks the new certificate's fourteen terms and bounds directly.

All three factor intervals are positive. Hence their independent interval products give exactly

```
real: [-EU*CU, -EL*CL]
imag: [ EL*SL,  EU*SU].
```

The real minus sign reverses endpoints. There is no discarded cross term: these are products of the complete factor endpoints, including both remainders. No correlation is assumed between factors, and rational arithmetic introduces no extra rounding error.

## Independent exact replay and alternate truncation

The independent replay reconstructs all 63 positive terms using direct integer powers and factorials, checks the supplied exponential and trigonometric intervals, and forms the four products by a generic four-corner interval multiplication. It recomputes all four containment margins. The reported 743-bit maximum integer size in the rational ledger is also reproduced. Producer read-only replay confirms its twelve targeted corruption controls; these are not a general parser-security proof.

As a separate calculation, I used 64 exponential partial-sum terms with first omitted index 64 and all-index tail ratio 1/260, together with eight/nine-term trigonometric bounds. This longer enclosure is nested inside the producer's enclosure and strictly inside the same unchanged target. The independent receipt retains its complete rational sums, tail and margins.

For the producer's actual shorter certificate, the exact strict clearances are greater than:

| Target boundary | Strict lower bound for clearance |
| --- | --- |
| Real lower | `2^-255` |
| Real upper | `2^-254` |
| Imaginary lower | `2^-271` |
| Imaginary upper | `2^-275` |

These inequalities are rational comparisons, not rounded decimal diagnostics. The alternate truncation has still larger margins; it is a corroborating independent construction, not a replacement for checking the submitted certificate.

## Accepted conclusion and limits

There is no remaining numerical seed assumption for this one frozen payload at the stated paper/external level. The target's historical `unproved_seed` label remains unchanged; this version-bound supplement provides the separate proof. It can compose with a separately accepted arithmetic proof of the same lossless word. That composition does not follow merely from either file's status string, and the word's other gates were not re-evaluated here.

No Lean build, generic rational-checker soundness proof, formal typed-graph bridge, theta-series evaluation, derivative unwind, contour computation or spectral conclusion is supplied. This does not change the previously accepted r=0 seed or repair the distinct old lossy exported boxes. The accepted result is precisely the new exponential-times-trigonometric seed enclosure.
