# Ternary Goldbach: shrinking the finite computation below 10^27 under assumed GRH

## Research question

We want to reuse calr3/ternary-goldbach's large theorem for odd n >= 10^27, assuming a separately verified full Dirichlet GRH. The remaining challenge is to minimize the finite computation without formalizing a new circle method proof.

The sthubbar/goldbach-lean repository's entries/dudek2014 reportedly exports theorem2_of_RH_hsw, a backward prime interval bound of form c sqrt(x) log(x) assuming RH and a multiplicity-aware zeta zero-count bound HSWN70 gZ. We also have the option of a certified Proth prime ladder or an RH bound on Chebyshev theta. We can choose the EVEN binary cutoff B. For each odd n in (5,10^27] we need a prime p with even remainder 4 <= n-p <= B. A smaller B can justify using a more expensive ladder. 

Please give an independently derived mathematical or algorithmic improvement and identify the first falsifiable proof or benchmark. In particular, can we avoid HSWN70 and a global count proof by imposing a much weaker elementary zero count or certifying only a small finite list? Can we use a hybrid analytic and ladder design? Distinguish conjectural improvements and assumptions from actual implications. Check endpoints and the factor of two for a symmetric vs one-sided prime interval. Cite exact primary references where known.

## Claude’s response

### 0. Reduction (endpoint check)

For odd n with 7 ≤ n ≤ B+3, take p = 3. Then n−3 is even and lies in [4, B].

For B+3 < n ≤ 10^27, we need an odd prime p in [n−B, n−4]. Every prime in that range exceeds 2, so n−p is automatically even.

So the analytic task is a **one-sided** gap statement: for x = n−4 ≤ 10^27−4, the interval [x−(B−4), x] contains a prime.

Two cautions:
- **Factor of two.** Dudek's interval (x − (4/π)√x log x, x] is already one-sided (IJNT 11 (2015) 771–778). If any lemma is stated symmetrically (a prime within h of x), using it costs a window of length 2h.
- **RH from GRH.** Full Dirichlet GRH implies RH only if your formal GRH statement covers ζ itself (modulus 1, or via L(s,χ₀) = ζ(s)·∏(1−p^{−s})). Check that before relying on it.

### 1. Cost floor (an implication, not a conjecture)

Write g(x) for the proved RH gap bound. A ladder must cover the region where g > B, at spacing at most B. So the ladder needs about (10^27 − X_a)/B certificates, where g(X_a) = B.

- With Carneiro–Milinovich–Soundararajan (Comment. Math. Helv. 94 (2019) 533–568, constant 22/25): g(10^27) ≈ 1.73·10^15.
- With Dudek's constant 4/π: g(10^27) ≈ 2.50·10^15.

For B much below about 10^15, X_a ≈ (B/(c log x))² collapses and the ladder count explodes. Example: B = 10^12 needs about 10^15 certificates. So **a "small B plus ladder" design is infeasible**. Binary verification up to B is the dominant cost.

The realistic choice is B = 4·10^18, trusting Oliveira e Silva–Herzog–Pardi (Math. Comp. 83 (2014) 2033–2060). At that B the RH route has slack: any constant c ≤ about 2000 suffices at 10^27. HSWN70's sharp constants (presumably Hasanalizade–Shen–Wong, JNT 235 (2022) 219–241) are therefore overkill.

### 2. Zero-count-free bound (my derivation; an implication under RH)

Ingham's explicit formula (Distribution of Prime Numbers, Thm 28):

ψ₁(x) = x²/2 − Σ_ρ x^{ρ+1}/(ρ(ρ+1)) − x log 2π + ζ′/ζ(−1) + O(x^{−1})

Under RH, |ρ(ρ+1)| ≥ |ρ|² = ρ(1−ρ). The Hadamard-product identity gives Σ_ρ 1/(ρ(1−ρ)) = 2 + γ − log 4π ≈ 0.04619 (Davenport, Ch. 12). **This uses no N(T) at all.**

Take the tent second difference ψ₁(x) − 2ψ₁(x−h) + ψ₁(x−2h). It weights Λ(n) on (x−2h, x) with peak h:
- The main term is h².
- The linear and constant terms cancel.
- The zero terms are at most 4·0.04619·x^{3/2}.
- Prime powers p^k with k ≥ 2 contribute O(h² log x/√x), which is negligible.

So a prime exists in (x−L, x) with **L = 2h ≈ 0.860·x^{3/4}**, one-sided, the factor 2 included.

With L = 4·10^18, this covers x ≤ about 7.8·10^24. The rate x^{3/4} is the best possible from Σ1/|ρ|² alone, so it cannot reach 10^27 by itself; it falls short by a factor of about 38.

### 3. Hybrid design (no zero count anywhere)

- **x ≤ 7.7·10^24:** use §2.
- **[7.7·10^24, 10^27]:** use a Proth ladder (as in Helfgott–Platt, Exp. Math. 22 (2013) 406–409) with spacing at most 4·10^18−4. That is about 2.5·10^8 ninety-bit certificates (a^{(p−1)/2} ≡ −1 mod p). This is plausible with `native_decide` or a verified checker, but not with kernel `decide`.

**Alternative.** Recover the √x log x rate with a *crude local* count N(t+1) − N(t) ≤ a log t + b. Jensen's formula on a disc gives this, using |ζ(2+it)| ≥ 2 − ζ(2) and an Euler–Maclaurin growth bound (Titchmarsh, Thm 9.2). Given the ~2000× slack, Rosser-quality constants (Ann. Math. 42 (1941)) or even much worse would do. This route needs no ladder, but I'm unsure Mathlib's Jensen formula is in usable form; please check.

### 4. Assumptions vs implications

- **Implications:** §2 and §3, given RH and the Hadamard/explicit-formula infrastructure. The Σ1/|ρ|² identity itself requires the ξ product.
- **Trusted computation, not a formal proof:** the 4·10^18 binary verification.
- **Heuristic only:** true maximal gaps near 10^27 are around 10^4. This is irrelevant to the proof.

### 5. First falsifiable checks

1. **Repo check:** does the repository already contain the ψ₁ explicit formula and the Hadamard constant B = −Σ Re(1/ρ)? If only a ψ-level formula with truncation exists, §2 needs new work.
2. **Benchmark:** with exact interval arithmetic, verify h² − 0.1848·x^{3/2} − (prime-power term) − (constants) > 0 at x = 7.8·10^24 with 2h = 4·10^18−4. Separately, time 10^6 Proth certificates in Lean and extrapolate to 2.5·10^8.
