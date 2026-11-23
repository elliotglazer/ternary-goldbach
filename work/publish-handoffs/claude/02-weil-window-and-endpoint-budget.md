# Review: the sign argument, the endpoint budget, and the localized interval

## Research question

We agree on the backward interval endpoints. We require a standard-axioms-only theorem; the whole binary computation must be certified. The binary bound 4e18 and native_decide are therefore inappropriate for this run. We already have an existing kernel-replayed Proth ladder in calr3, plus a smaller-range Lucas bitmap prototype. The upstream release explicitly exports RiemannHypothesis. Your proposed elementary psi1 estimate should retain endpoint terms when counting higher prime powers.

In calr3/ternary-goldbach at 23b2d68, WeilWindow.weil_windowH bounds a partial, multiplicity-weighted sum of Re WH by WPhi + OffC. The hypothesis H <= 3e10 originally bounded the negative contribution of omitted high zeros. Under ordinary RH every omitted term has Re WH >= 0, so we can drop it. A new Lean implementation for the sharper bound WPhi is drafted; downstream bounds on the smoothed Chebyshev function need propagation. A candidate uniform absolute error per endpoint on [1e16,1e27] is 5.13e15, with psi minus theta at the upper endpoint bounded by 17 sqrt(x). B=1.1e16 then has slack. A previous independent alternative we want you to challenge is this: use a single localized smooth interval instead of subtracting two global psi estimates. For 0<h<x take a=0, b=log(1-h/x). The same explicit formula has main term x(1-exp b)exp(delta^2/2); its Mellin transform has factor (exp(as)-exp(bs))/s. For low gamma this is O(h/x), so dropping this cancellation too early loses most of the short-interval gain. Smoothing also leaks outside the interval and includes prime powers.

Please independently review the sign argument and endpoint budget. Derive a concrete inequality needed to turn the localized smoothed sum into a prime in the unsmoothed interval, with inside and leakage/power terms and a falsifiable threshold test. Explain whether available bounds given above alone certify a smaller B. Numerical guesses should be labeled as such.

## Claude’s response

### 1. The sign argument

On the critical line, Re W_H(½+iγ) ≥ 0 holds only if W_H(½+iγ) = |F(γ)|². That means the test function must be an autocorrelation f∗f̃, with **no x^{iγ} localization phase**.

Even then, the sign runs one way:

- Dropping nonnegative omitted zeros gives *partial ≤ full*.
- A lower bound on primes needs an upper bound on the **full** zero sum.

So dropping H is valid only if WPhi + OffC actually bounds the full sum. The natural way it does: evaluate the Weil formula **at the origin**. When supp G ⊂ (−log 2, log 2), the prime side vanishes, so

W₀ := Σ_ρ m_ρ Ĝ(γ)

equals pole terms plus the archimedean term, with no zero count needed. The localized sum then satisfies |Σ_ρ x^{iγ}Ĝ(γ)| ≤ W₀.

**First check in Lean:** does weil_windowH contain an x^{iγ} factor? If it does, Re W_H ≥ 0 is false, and the H-free version needs this W₀ route instead.

### 2. The localized inequality

Take a compactly supported autocorrelation weight, for example a box of log-width δ/2 convolved with itself, so G is a tent of width δ. Set:

- h = B − 3 and x = n − 4, so that (x−h, x] = [n−B, n−4];
- φ(t) = (t/x)^{1/2} · G(log t − log x + δ/2) with supp φ ⊆ [x−h, x], which forces δ ≤ −log(1 − h/x).

Compact support makes the leakage term exactly 0. If you keep the Gaussian factor e^{δ²/2}, you must add a term L = Σ_{n∉I} Λ(n)φ(n) and bound it with a crude Chebyshev estimate.

The sufficient condition is:

M − √x·W₀ − |T_Γ| − P − L > 0

where:

- M = ∫φ (main term);
- T_Γ is the trivial-zero/Γ term;
- P is the prime-power term, with endpoints retained:

P ≤ φ_max Σ_{k=2}^{⌊log₂x⌋} (log x / k) · ( h/(k(x−h)^{1−1/k}) + 1 ).

The "+1" terms add roughly φ_max · log x · ln log₂x ≈ 250 φ_max (my estimate). This is negligible but must be kept.

**Falsifiable threshold test:** with interval arithmetic at x = 10^27, find the least h for which the inequality holds, then confirm it is monotone over [10^16, 10^27].

**Heuristic, unverified:** M ≈ xδ²/4 and W₀ ≈ (δ/2π) log(1/δ), which gives h ≈ C√x log x with C ≲ 1. That suggests B ~ 10^15 to 2·10^15 at the top, which would be roughly a 5–10× smaller binary computation.

### 3. Your endpoint budget

The difference argument needs:

θ(x) − θ(x−h) ≥ h − E(x) − E(x−h) − (ψ−θ)(x).

Only the upper-endpoint ψ−θ term is needed, because ψ−θ is nondecreasing. The arithmetic: 2 × 5.13e15 + 17·√(10^27) ≈ 1.026e16 + 5.4e14 ≈ 1.080e16 < h = 1.1e16 − 3. The slack is about 2%, which is thin.

Things to verify:

- E bounds |ψ(y) − y| itself, not a smoothed ψ. Otherwise you need a monotone sandwich between smoothed and unsmoothed ψ, which costs extra.
- 17√x is a genuine bound on ψ−θ at 10^27 (true ψ−θ ≈ 1.0·√x).
- The case analysis is covered: for n > B+3 we have x ≥ B − 1 > 10^16, and n ≤ B+3 uses p = 3.

### 4. Do the available bounds certify a smaller B?

**No.** A uniform absolute E of 5.13e15 forces h > 2E. Going below about 1.08e16 requires the localized inequality of §2 with a certified W₀, which is new work. Whether that work is cheaper than certifying binary Goldbach up to 1.1e16 is the decision to make.
