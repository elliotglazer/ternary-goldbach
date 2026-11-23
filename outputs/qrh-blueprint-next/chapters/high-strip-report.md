# A wider sufficient principal strip above height 1500

2026-11-11. Conditional paper implication with an exact rational scalar check. No new zero computation, Lean build, source declaration or frozen-file edit. The accepted external critical-line certificate through height 1500 is used at its reviewed scope; it has not become a Lean theorem. The higher strip remains an uncompleted finite certificate task.

## Result

It is sufficient to prove

`0.4968 ≤ Re(ρ) ≤ 0.5032` whenever `1500 < |Im(ρ)| ≤ 1000000`

for every nontrivial zeta zero, with the existing accepted critical-line result below height 1500. The resulting weighted moment satisfies

`W35 < 23.980532761132 < 23.981 < 24`.

This leaves a margin greater than `0.019467238868`. The primary half-width is the exact rational `δ=2/625=0.0032`, wider than the preceding `δ=1/400=0.0025` requirement. It needs no exact value of `N(1000000)` and no historical zero information. The proof uses only the accepted head values and the already reviewed analytic count bound.

The stronger optimization `δ=13/4000=0.00325` also passes, with `W35<23.998305865133`, but has much less margin. Keep the primary value `2/625` unless the extra width is needed. Neither value is asserted to be certified above height 1500 by this note.

## 1. Inputs and their precise scope

Let A=1500 and T=1000000. Let N(t) count all nontrivial zeta zeros with `0<Im(ρ)≤t`, using true analytic multiplicities. Let

`Q_A = Σ_{0<γ≤A} m_ρ (1/γ - 1/A)`.

The inputs are:

1. Every nontrivial zero with `|γ|≤A` is on `β=1/2`. The accepted external proof uses 1069 strict sign changes and the independent total count, and also proves simplicity. Simplicity is not needed for the present moment calculation. The review is `agents/audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md`, SHA256 `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE`.
2. `N(A)=1069` exactly, and `Q_A<417/250=1.668`. These come from the independently reviewed complete head contours. Their review is `agents/moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md`, SHA256 `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491`. The sign review independently recomputed the exact Q upper fraction and retained this cap.
3. For every real `t≥A`, the reviewed analytic argument gives

   `N(t) ≤ G(t) = F(t)+5 log t+20`,

   where `F(t)=t/(2π)(log(t/(2π))-1)+7/8`. This count includes closed upper heights. The derivation and independent review are `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` and `major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md`. Their respective frozen hashes are `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303` and `82B2A416EAE9E4F16F8147C92776AB7D5063355E3EABE828615281AA64D8C418`.
4. The as-yet unproved high finite strip `|β-1/2|≤δ` for `A<|γ|≤T`, with δ chosen above. Conjugation and the functional equation preserve zero multiplicity. These are existing analytic symmetry inputs to the principal spectral route, not numerical assumptions about separate halves of the strip.

The target moment is exactly the one in `mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md`:

`W35 = Σ_{nontrivial ρ, |γ|≤T} m_ρ exp(35 max(β-1/2,0)) / |ρ|`.

There are no nontrivial real zeros in this carrier. The accepted head contour excludes the real bottom and all zeros through height 14, so no zero-ordinate term or division by γ is introduced. The selected δ is less than .01, so the separate location requirement `.49≤β≤.51` in that existing psi contract still holds. All other intermediate-height, global-tail and Gaussian-sandwich obligations remain unchanged.

## 2. The certified critical-line head gets no exponential penalty

For `0<|γ|≤A`, the exponential weight equals 1. Conjugation pairs the two ordinate signs with equal multiplicity. Since `|ρ|=sqrt(1/4+γ²)≥|γ|`,

`W_low ≤ 2 Σ_{0<γ≤A} m_ρ/γ = 2(Q_A+N(A)/A)`.

Using the reviewed strict Q cap gives

`W_low < 2(417/250+1069/1500) = 3571/750 = 4.761333333333…`.       (L)

This is the improvement over applying the high-strip exponential factor to the whole head. The formula retains multiplicity throughout and does not rely on simplicity.

## 3. Reflection averaging on the higher strip

On the positive-ordinate carrier with `A<γ≤T`, reflection is `ρ↦1-conj(ρ)`. It preserves γ and multiplicity and replaces `β-1/2` by its negative. Put d=`β-1/2`. Then `|d|≤δ` and

`exp(35 max(d,0)) + exp(35 max(-d,0)) ≤ 1+exp(35δ)`.

Replace each denominator `|ρ|` by γ before averaging. Reindexing the finite sum by reflection and adding the two copies therefore gives

`Σ_{A<γ≤T} m_ρ exp(35 max(β-1/2,0))/|ρ| ≤ (1+exp(35δ))/2 · Σ_{A<γ≤T} m_ρ/γ`.

This proof includes the fixed points β=1/2: their two weights total 2, at most `1+exp(35δ)`. It does not require pairing zeros into disjoint two-element lists. Conjugation duplicates the positive-ordinate contribution with the same β, norm and multiplicity. Hence

`W_high ≤ (1+exp(35δ)) Σ_{A<γ≤T} m_ρ/γ`.                       (H)

The factor 2 from the two ordinate signs cancels the factor 1/2 from reflection averaging. There is no further sign factor.

## 4. Partial summation with the exact lower endpoint

For the closed count N(t), finite summation by parts gives the exact identity

`Σ_{A<γ≤T} m_ρ/γ = N(T)/T - N(A)/A + ∫_A^T N(t)/t² dt`.       (PS)

This identity remains valid if there is a zero at either endpoint. The low range is `(0,A]` and the high range is `(A,T]`, so a zero at A belongs only to the head. A zero at T is included by `N(T)/T`. The integral is unchanged by choices at isolated jump points. In fact the accepted head top contour excludes any zero at ordinate A; this stronger endpoint fact is available but not needed for (PS).

The analytic count bound was extended to closed zero ordinates by right limits in its reviewed derivation. Thus it can be substituted at T even without a zero-free top contour or an exact top count. Keep `N(A)=1069` exact in the negative term:

`Σ_{A<γ≤T} m_ρ/γ ≤ G(T)/T - 1069/A + ∫_A^T G(t)/t² dt = H_G`.

An upper bound on N(A) would not justify this subtraction. This is one reason the independent complete head count is an essential input.

Write `l_A=log(A/(2π))` and `l_T=log(T/(2π))`. Because `F'(t)=log(t/(2π))/(2π)`, integration by parts gives

`F(T)/T + ∫_A^T F(t)/t² dt = F(A)/A + (l_T²-l_A²)/(4π)`.

The remaining terms have the exact endpoint simplification

`(5 log T+20)/T + ∫_A^T (5 log t+20)/t² dt = [5(log A+1)+20]/A - 5/T`.

Consequently

```
H_G = (l_T²-l_A²)/(4π) + (l_A-1)/(2π) + 7/(8A)
      + [5(log A+1)+20]/A - 5/T - 1069/A.
```

The negative `-5/T` is retained. The exact rational enclosure in the script proves

`9.072023958327 < H_G < 9.072023958328`.

The displayed enclosure describes the analytic upper model H_G. It is not a measured actual reciprocal-zero moment.

## 5. Final scalar test

Combining (L), (H) and (PS) gives

`W35 < 3571/750 + (1+exp(35δ)) H_G`.                       (S)

The checker `principal_high_strip_refinement_20261111.py` imports no evaluator or spectral data. It uses Python `Fraction` for every acceptance comparison. Pi is enclosed by Machin's identity with 45 alternating arctan terms. Logarithms use powers-of-two reduction and 65 positive atanh-series terms plus a geometric upper tail. Exponentials use 36 Taylor terms and a geometric upper tail. All displayed bounds are rounded in the stated direction only after the rational checks.

| Half-width δ | Remaining closed strip | Safe upper bound for W35 |
| ---: | --- | ---: |
| .0025 | [.4975,.5025] | 23.735 |
| .003 | [.497,.503] | 23.910 |
| .0032 | [.4968,.5032] | 23.981 |
| .00325 | [.49675,.50325] | 23.999 |

For the primary δ=2/625, the tighter upward-rounded bound is `23.980532761132`. The exact tested upper expression is strictly below that number. For δ=13/4000 it is strictly below `23.998305865133`.

The same checker brackets the crossing of the conservative scalar model (S) between δ=.00325476 and δ=.00325477. This is a limit of this particular estimate using Q_A<1.668 and G(t). It is not a necessary limit on the actual zero strip, and a scalar failure above that threshold would not refute the desired moment or the zeta assertion.

No exact count at T is read or assumed. In particular the candidate value 1747146 plays no role. A later accepted top count could tighten only the `N(T)/T` term, in a separately reviewed refinement.

## 6. Consequence and certificate scope

To use the primary refinement, the still-needed finite principal task may target the closed high range `1500<|γ|≤1000000` with `β≤.5032`; reflection gives the lower bound .4968. A zero-free closed right rectangle starting at .5032 is a stronger sufficient way to establish that inequality. The existing exact critical-line result supplies the lower heights. Nothing in this note proves that the larger rectangle is easier to certify in a measured implementation.

After the analytic and finite-certificate bridges are formalized, (S) supplies the same W35≤24 contract used by the reviewed psi proof for x≥5·10⁹, together with the retained `.49≤β≤.51` bound. This does not remove its separate shared .555 and global zero-location requirements, and it does not complete the remaining finite prime interval or the full Goldbach theorem.

Exact replay command, from the workspace root:

```
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/major-constants/principal_high_strip_refinement_20261111.py
```

The run exited 0 and saved `principal_high_strip_refinement_20261111.json`. No external numerical service or approximate zero location was used by that run. Independent mathematical and arithmetic review is requested for this new note; previous frozen reports are unchanged.
