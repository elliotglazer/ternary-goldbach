# Independent review of finite-EM vertical batching scalars

2026-11-11. **PASS for the corrected packet.** The finite identity, real-phase remainder, weighted coefficient/quotient estimate, corrected arithmetic allocation and literal counts check. No function values, moments, transform outputs, panel comparisons, scans or builds were produced. The result is a conditional error interface, not an implementation or a spectral certificate.

## Frozen inputs and exact replay

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `major-constants/EM_VERTICAL_BATCH_SCALAR_SUPPORT_2026-11-11.md` | `44C53A6F71D9B00368568D35C08D2ED69EC9ECA746AE61E2DDC8A79C5BA2C52F` |
| `major-constants/em_vertical_batch_scalar_support_20261111.py` | `79D62492632A784D58019302F01C310849BB2B4A1D6AB4D782852F1DFCEA204C` |
| Its scalar receipt | `B68C8861B4F646C4EC43DEC00E5D364C33A1CEDF8C6F0C5FC976E72210F6F26F` |
| `zero-sum/review_em_vertical_batch_scalars_20261111.py` | `CFF35FB79563130BCB1A2FDBC46A6BF2289E05CA3E0A794A061A54AEA2E924F1` |
| Its independent receipt | `0027F86D69A5F3AB15ACD383A5EE9CBF3854B8010DE2E302714B8331E8FBBD1C` |

All input hashes were checked. The reviewer executed the author's scalar AST prefix ending before its first file write, compared the complete resulting object with the frozen receipt, and separately reconstructed the inequalities and all four count rows. No author file was written. Forty-two exact integer/Fraction checks passed.

The former `128/63` allocation is **not** accepted at rho<=1/8. The corrected `16/7` value is the subject of this review. The independent script also checks that the finite weight sum at rho=1/8 already exceeds 64/63, so the previous smaller factor is not silently inherited.

## 1. Finite identity and domains

The statement needs N=333334, 24 jet orders, positive integer J, Delta>0, real sigma>=629/1250, and a power-of-two integer L>=4J. For the Taylor residual require integer p>=1. The panel bound further uses 0<=rho<=1/8 and the explicit separation condition `|s_j-1|>3rho`.

If `|m_n-x_n|<=1/8`, then rounding m_n by `floor(m_n+1/2)` gives `|x_n-q_n|<=5/8`, including ties and either sign of q_n. Retaining the unreduced q_n is essential. From the definition of delta_n,

`j*Delta*log n = 2*pi*j*q_n/L + (j/J)*r_n`.

Consequently the normalized positive DFT must be read at `-j mod L` and multiplied by L. The identity keeps the exact requested centers; it does not round them to a frequency lattice. Reducing q_n modulo L affects only its root of unity, not the residual. The bound `|r_n|<=5*pi*J/(4L)<=5*pi/16<55/56<1` is correct and independent of Delta after the certified binning.

The two factorials in the moment definition have different roles: h! normalizes the actual Taylor jet, while m! belongs to the residual exponential expansion. Neither is applied again after the transform.

## 2. Real-phase remainder and source API

For real theta use f(u)=exp(-i*theta*u) on [0,1]. Its p-th real derivative has norm |theta|^p. The integral Taylor remainder of degree p-1 has kernel `(1-u)^(p-1)/(p-1)!`; its integral is 1/p!. Thus the complex-valued remainder is at most `|theta|^p/p!` without an extra exp(|theta|) factor. This argument does not use an invalid complex mean-value theorem.

The actual pinned Mathlib `Analysis/Calculus/Taylor.lean` was read. `taylor_integral_remainder` has a complete real normed target and hypothesis `ContDiffOn R (n+1) f (uIcc x0 x)`, so it applies to complex-valued f at n=p-1. The file hash is `0AB79A53A36F87AB2A69D907D7999D2516CC4C085799E306F97D8480AE8CA18A`. Identifying its within derivatives/polynomial with the explicit exponential expression remains a straightforward formal adapter, not an already executed Lean proof.

Here theta is the exact real `(j/J)*r_n`, whose absolute value is below 1. Therefore the additional exact h-jet error is at most W_h/p!. Enclosing uncertain r_n inside moment arithmetic is a separate error obligation; one must not interpret a complex rectangle radius as an additional exact imaginary part of theta and still invoke this real-phase estimate.

## 3. Weights and retained polynomial propagation

The decreasing-function comparison at exponent 1/2 gives the strict 1156 bound. The exact inequalities `exp(1)>8/3` from five Taylor terms and `(8/3)^13>N+1` prove log N<13. Reconstructing weights by the ratio `w_h/w_(h-1)=13/h` gives the stated maximum, attained at h=12 and 13, and verifies the individual p=36,39,48 comparisons.

For rho<=1/8, `sigma-rho>=3/8`. Extending the finite nonnegative h-sum to its exponential bounds the disk-weighted W sum by `sum n^(-3/8)`. Integral comparison gives `(8/5)N^(5/8)-3/5`; the exact test `N^5<5120^8` proves it is below 8192. This includes n=1 and makes no cancellation assumption.

Writing the actual and approximate main-sum coefficient differences as e_h, multiplication by s-1 gives `(s_j-1)e_h+e_(h-1)` for h=0,...,23. The retained shift sum has only h=1,...,23, so it is bounded above by rho times the full weighted e-sum. In particular the would-be degree-24 product term is **not** included in the retained polynomial. The existing remainder for the actual finite g controls the true discarded Taylor series; it need not be re-proved for a fictitious infinite continuation of the approximate coefficients.

On the target disk, dividing the entire error by s-1 gives amplification at most

`(|s_j-1|+rho)/(|s_j-1|-rho)<2`.

The stated separation condition is sufficient, including rho=0. It must be checked for every application; the real-part hypothesis alone does not imply it near s=1. Combining it with the weighted sum gives `2^14/p!`. Exact factorial arithmetic verifies p=32 is sufficient for the stated 2^-100 truncation allowance. This is a weighted quotient bound, not a per-jet assertion.

## 4. Corrected arithmetic allocation and box qualification

If every exact normalized moment-transform output is enclosed with radius at most `2^-104/(L*p)`, exact contraction gives each jet arithmetic error at most 2^-104, since 0<=j/J<1. Moment-input errors, roots of unity, finite arithmetic and transform scaling must all be included in that output radius. Neither exact rational centers nor a correct FFT alone supply it.

The disk weights satisfy `sum_(h=0)^23 rho^h<8/7`; after the less-than-two multiplication/quotient amplification the arithmetic contribution is bounded by `(16/7)*2^-104`. The corrected exact inequality

`2^14/32!+(16/7)*2^-104<2^-100`

passes independently. The two chosen J values make j/J dyadic, so exact rational contraction is mathematically available. Its implementation and bit/storage costs are not established here.

This is a **Euclidean norm** quotient-error allocation. If an implementation turns the resulting norm error into coordinate-square padding and subsequently needs a norm bound, charge the square's sqrt(2) loss instead of assuming that radius is unchanged. This is not a correction to the abstract norm inequality. As additional hardening, the independent script proves that even

`old_slab_square_allowance + (3/2)*batching_norm_allowance < 2^-42`.

Thus the particular old-slab scalar conclusion survives that safe implementation choice. This does not allocate unrelated errors for computing the half term, Bernoulli corrections, pole-removal term, or final finite arithmetic: those remain in their own established ledger. The high-slab EM/Taylor allowances apply only where their original parameters and domains hold.

## 5. Counts, scope, and remaining evidence

All four rows for J=1024,4096 and p=32,48 were independently reconstructed. The moment-contribution, transform, dense-entry, butterfly and contraction counts agree. Moving from p=32 to p=48 multiplies p-dependent counts by 3/2; the naive separate-center count, which does not depend on p, stays unchanged. Counts are for the stated literal dense construction, not universal lower bounds or equal-cost operations.

The note correctly excludes certified log/phase/bin construction, arithmetic precision, serialization, and EM correction costs from its moment comparison. One-jet streaming is a storage option with recomputation/data-retention tradeoffs, not an automatic peak-memory theorem. No actual bucket moment, output radius, transform or panel margin has been produced. The reviewed result supplies a mathematically valid batching error budget; practical savings and any zero-free region still require separate implementation and finite-data evidence.
