# Review of the 4e15 candidate

## Research question

We checked that the Weil-window sum has no localization phase. The downstream localized zero sum does have a phase and will use an absolute bound. Please try to falsify the following candidate.

Goal: prime in (x-L,x], x=n-4, 1e15<=x<=1e27, to allow even binary bound 4e15. Let v=sqrt(x), w=101/v, delta=2.8/v, K=4.5, a=-K*delta, b=a-w. Smooth the log interval [b,a] by a centered normal of sd delta. Choose J=(x exp(-w-2K delta), x], L=length J <=126.2v. The team models main mass >100.9996v, low-zero cost <98.977v via a Weil majorant and Mellin cancellation min(w,2/abs(gamma)), vertical cost <255 absolute and negligible high tail. Treat the low-zero estimate as an unproved premise for this review.

Interior prime powers: for k>=2 and u<t producing powers in J, t^k-u^k >= (t-u)u^(k-1) >= (t-u)sqrt(inf J). Thus at most 130 possible bases per k, at most 90 exponents, log x <63, total <0.024v. Gaussian leakage: express smoothing as averaging shifts by -delta Z. For abs Z <= K, the shifted interval lies in J up to measure-zero endpoint choices. For abs Z > K, use interval length <= xw exp(delta abs Z), and log n <=63 exp(delta abs Z), count <= length+1. Bound total leakage by 126(xw+1) exp(2delta^2) exp(-(K-2delta)^2/2) <0.511v. Residual margin >1.48v. Does this really imply a prime in J conditional on the stated zero bound? Check the endpoints, Gaussian-tail factor, units, multiplicities and worst-case uniform inequalities, and identify exactly which premise needs the most scrutiny.

## Claude’s response

**Verdict:** conditional on the low-zero premise, I could not break it. Every step outside that premise checks.

### Checks that pass

- **Length.** Since 1 − e^{−y} ≤ y, L ≤ x(w + 2Kδ) = (101 + 25.2)v = 126.2v. At x = 10^27 that is about 3.991e15. The remainder n − p lies in [4, 4 + L] ⊂ [4, 4e15], and p is odd.
- **Range.** n > B + 3 gives x > B − 1 ≥ 10^15. Smaller n are handled by p = 3.
- **Main mass.** M = x·e^a·(1 − e^{−w})·e^{δ²/2} ≥ 101v(1 − 12.6/v)(1 − 50.5/v). At v ≥ 3.16e7 this is about 100.9998v, so the claim of > 100.9996v holds.
- **Containment.** For |Z| ≤ K, the shifted interval sits inside [−w − 2Kδ, 0]. Endpoint ties are measure-zero in Z.
- **Leakage.** The bound uses log n ≤ 63 + δ|Z| ≤ 63e^{δ|Z|}, a count of at most length + 1, and 2E[e^{2δZ}; Z > K] ≤ e^{2δ²}e^{−(K−2δ)²/2}. That last step uses 1 − Φ(t) ≤ ½e^{−t²/2}, which holds for t ≥ 0. Your factor 126 is twice what is needed, so it is conservative. Numerically, 126 · 101 · e^{−10.125} ≈ 0.509, so 0.511v is fine.
- **Prime powers.** t^k − u^k ≥ u^{k−1} ≥ √(inf J). That gives at most 128 bases per k and k ≤ 89. But at x = 10^15 the margin is only 130 · 90 · 63 = 737,100 against 0.024v ≈ 758,900, about 3%. If any constant moves, check this first.
- **Mellin factor.** On Re s = ½ with u ≤ 0, |(e^{as} − e^{bs})/s| ≤ min(w, 2/|γ|) and |e^{δ²s²/2}| ≤ e^{δ²/8}e^{−δ²γ²/2}.

### Premise needing the most scrutiny

The **98.977v low-zero bound must hold uniformly, and the worst case is x = 10^27, not small x.** The zero sum behaves roughly like (1/π)·log(w/δ)·log(1/δ). That grows like log x, while the main term stays fixed at 101v. My rough heuristic, labeled as such, puts the sum over both signs of γ at about 65v at the top end, so 98.977v is plausible but not slack-rich.

Verify three things:

1. The Weil majorant Ĝ ≥ min(w, 2/|γ|)·e^{−δ²γ²/2} is genuinely positive-definite and admissible.
2. Because a Gaussian G is not compactly supported, the prime side −2ΣΛ(n)n^{−1/2}G(log n) can be dropped only if G ≥ 0.
3. Zeros are counted with multiplicity, via ξ′/ξ.

The 255 vertical term and the "negligible" high tail are the next items to certify.
