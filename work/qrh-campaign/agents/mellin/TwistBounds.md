# Twist-dependent etaPlus strip estimate

This is a mathematical derivation from existing source lemmas, not a newly compiled Lean theorem. The accompanying floating-point script explores the bound; its printed values are not interval certificates. No zero-free height or first-zero gap is assumed.

Let M(σ+it,δ) be the Mellin transform of etaPlus(r) exp(2πiδr), with 1/8 ≤ σ ≤ 7/8. Write ghat for `𝓕 gC`. Source `Explicit/EtaPlusMellin.lean:134` gives

    M(σ+it,δ) = ∫_{|2πξ|≤200} ghat(ξ) Gδ(σ−1+i(t+2πξ)) dξ.

All integrals here use ordinary Lebesgue measure. In particular the Fourier frequency is ξ, not 2πξ. This normalization matters for both estimates below.

## Formula

For t ≠ 0 choose 0 < B ≤ min(200, |t|) and 0 ≤ θ < π/4. Define

    c = cos(2θ),
    b = 0                         if δt ≥ 0,
        2π|δ| sin θ                if δt < 0,
    U(c,b) = exp(b²/(2c)) min(sqrt(2π/c), b/c + sqrt(π/(2c))),
    R(c,b) = max(U(c,b), 1/c + (b/c)U(c,b)),
    W(B) = min(2.03 B/π, 3.01),
    T(B) = sqrt(184)/B²            if B < 200,
           0                      if B = 200.

Then the following paper bound holds:

    |M(σ+it,δ)| ≤ min(3.95, T(B) + W(B)R(c,b) exp(−θ(|t|−B))).

The constant 3.95 is already kernel-checked in `GaussianEnvelope.lean` for any Gaussian-dominated function, and applies using the existing `norm_fP_le`; the etaPlus wrapper awaits its dependencies. The new second term is not yet formalized. Since each admissible pair gives an upper bound, taking the infimum over B and θ is valid. For all |δ|≤4 one can use b=8π sin θ on the unfavorable half-line and b=0 on the favorable half-line.

## The tail and its normalization

On B < |2πξ| ≤ 200, Cauchy–Schwarz bounds the convolution by

    (∫_{|2πξ|>B}|ghat(ξ)|² dξ)^(1/2)
      (∫_R |Gδ(σ−1+i(t+2πξ))|² dξ)^(1/2).

`MajorArcs/HHFourier2.lean:217`, `tail_fourier_gC_le'`, bounds the first squared factor by 368/B⁴. For the second, substitute r=exp(u): G is the Fourier transform, up to sign, of

    u ↦ exp((σ+1)u) exp(−exp(2u)/2) exp(2πiδ exp(u)).

Translation in frequency and Fourier Plancherel give exactly

    ∫_R |Gδ(σ−1+i(t+2πξ))|² dξ
       = ∫_0^∞ r^(2σ+1) exp(−r²) dr ≤ 1/2.

There is no factor 2π left because integration is in ξ. The inequality needs no gamma estimate: put v=r², use v^σ≤(1−σ)+σv, and integrate exp(−v) and v exp(−v), both of integral 1. Thus the tail is at most sqrt(184)/B². At B=200 the tail set is empty, so its contribution is exactly zero. This explains the separate endpoint definition of T.

## Signed contour rotation on the near part

For |2πξ|≤B≤|t|, τ=t+2πξ has the sign of t, possibly zero. Rotate by θ'=sign(t)θ. The hypotheses of `Explicit/MellinRotate.lean:346`, `Gr_eq`, hold because |θ'|<π/4 and σ−1>−2. Its exact norm identity `norm_Jr` at line56 gives

    |Jr(σ−1+iτ,δ,θ',r)|
      = r^σ exp(−θ'τ − c r²/2 − 2πδr sin θ').

Thus θ'τ≥θ(|t|−B). When δt≥0 the linear term is nonpositive and may be dropped. Otherwise it equals br. This is the sign information discarded by the existing absolute-delta `norm_Gr_le`.

Set I0=∫_0^∞ exp(−cr²/2+br)dr and I1=∫_0^∞ r exp(−cr²/2+br)dr. Completing the square gives I0≤U(c,b): bound the shifted half-Gaussian either by the whole Gaussian or by a segment of length b/c plus the unshifted half-Gaussian. Integration of the derivative gives

    I1 = 1/c + (b/c) I0.

Since 0≤σ≤1, weighted AM–GM gives r^σ≤(1−σ)+σr, so the remaining integral is ≤max(I0,I1)≤R(c,b). One can sharpen R on the requested narrower strip to

    max((7U+V)/8, (U+7V)/8),  V=1/c+(b/c)U,

but the script and displayed bound use the simpler R. Integrating |ghat| on the near set proves its claimed contribution once W is established.

## The Fourier L1 constant

The existing `Cg_le` and `norm_fourier_gC_le` bounds give |ghat|≤2.03, hence a near-set integral at most 2.03 B/π.

For the global alternative, the Fourier derivative identity and Plancherel, already used inside `MajorArcs/HHFourier.lean:435`, give

    ∫_R (2πξ)² |ghat(ξ)|² dξ = ∫_R |gL'(u)|² du ≤19.5.

Split at |2πξ|=R0=3/2. The central contribution is at most 2.03 R0/π. Cauchy–Schwarz on its complement gives

    ∫_{|2πξ|>R0}|ghat| ≤ sqrt(19.5/(πR0)),

because the integral of (2πξ)^−2 there is 1/(πR0). Therefore

    ∫_R |ghat| ≤ 3.045/π + sqrt(13/π) < 3.01.

For an elementary rational certificate, use π>3.14, (2.035)²·3.14>13, and 3.045/3.14+2.035<3.01. These rational inequalities are checkable by `norm_num`; the global L1 lemma itself remains to be formalized.

## Exploratory values

`twist_envelopes.py` searches 200 cutoff values and 389 angles for each row. Results are floating-point evaluations, not certified upper-bound decimals. The inputs headed “height” are test points, not claims about zero locations.

| Height | Favorable sign δt≥0 | Unfavorable delta magnitude 1 | Unfavorable delta magnitude 4 |
|---:|---:|---:|---:|
| 5 | 2.76946 | 3.93300 | 3.95 |
| 10 | 0.954430 | 3.73059 | 3.95 |
| 14 | 0.395691 | 3.08159 | 3.95 |
| 20 | 0.143709 | 1.78475 | 3.93438 |
| 30 | 0.0452689 | 0.419705 | 3.73835 |
| 50 | 0.0114197 | 0.0468032 | 2.77744 |
| 100 | 0.00207001 | 0.00400769 | 0.151485 |
| 200 | 0.000429265 | 0.000589478 | 0.00270618 |
| 300 | 3.19e−32 | 1.49e−17 | 0.000546750 |
| 500 | 8.79e−100 | 2.20e−71 | 1.41e−23 |

Examples in the unfavorable |δ|=4 column: at height100, B=14 and θ=.116; at height200, B=76 and θ=.168; at height500, B=200 and θ=.32. At the last point no Fourier tail is left. Small-twist principal estimates benefit substantially above height50–100, but the worst-sign |δ|=4 estimate remains close to 3.95 at small heights. These bounds alone do not establish the final averaged major-arc error budget.

## Exact remaining lemmas

1. Extract the weighted Fourier-energy identity and prove `∫ ‖𝓕 gC‖ ≤3.01` from the existing derivative energy. Existing source already provides regularity, derivative identity, and Plancherel inputs.
2. Prove Gaussian Mellin Plancherel uniformly in δ and σ∈[1/8,7/8], with squared integral in ξ at most1/2. The logarithmic substitution above fixes its exact normalization.
3. Derive the signed version of `norm_Gr_le` directly from `Gr_eq` and `norm_Jr`. Existing absolute-delta result is insufficient to capture the favorable sign.
4. Prove the elementary I0/I1 estimates and AM–GM bound, or use a slightly weaker closed form if its Lean proof is shorter.
5. Split the etaPlus Fourier convolution at B, apply these bounds, and handle B=200 separately. This is the first new etaPlus theorem needed; it needs no additional result-shaped assumption.
6. Select a finite set of rational B,θ choices and certify the corresponding transcendental bounds before using numeric values in zero-window summations or delta integration. The current optimization script is exploratory only.

A possible later refinement is an L2 estimate jointly in δ and t, retaining the positive twist damping instead of discarding it. That would address the remaining small-height/worst-sign contribution more directly, but it has not been derived or certified here.
