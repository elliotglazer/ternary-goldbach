# Independent mixed-conductor review

2026-11-11. Bounded mathematical/source audit against `work/ternary-goldbach`, baseline `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Reviewed `zero-sum/RESUME_MIXED_2026-11-11.md` and its exact arithmetic script. No Lean build or canonical change. No blocking defect was found in the stated finite-sum operator reduction or correction budget. The primitive fourth-moment integral I and the Astar cap remain unproved.

## Gauss weights and source normalization

The source `MinorArcs/Bombieri.norm_sq_gaussSum:135` gives conductor c times the indicator that q/c is squarefree and coprime to c. `Prelim/GaussInduced.gauss_induced` and `norm_sq_gaussSum_of_isPrimitive` provide the underlying induced and primitive identities. These agree with the note, including zero weights at incompatible imprimitive levels.

For q=cr with squarefree r coprime to c, phi(q)=phi(c)phi(r). Therefore the zero-only contribution of primitive conductor c to the normalized spectral energy is exactly

`[c/phi(q)] P_c = [1/phi(r)] W_c`, with `W_c=(c/phi(c))P_c`.

There is only one Gauss factor c, not an extra square-root conductor saving. Inversion permutes primitive characters and preserves conductor. The principal character at conductor 1 is included, with its pole already subtracted. A future proof must choose consistent primitive zero truncations independently of induced modulus q; q-dependent imprimitive errors belong to the separate correction, not to this identity.

The plus and star sums have normalization x and y=x/49 respectively, with star transform twist delta/49. The resulting product integral uses the same delta measure as the source residual Cross. No extra 49 appears in this dimensionless Cross; the cubic change-of-variable factor is applied later in major-arc assembly.

The output projection Pi_delta retains q-dependent windows before applying contraction. Both character indices in the product remain independent. Endpoint choices for the interval indicators differ only on finitely many measure-zero boundaries; they do not replace the actual arc geometry by equal-length windows.

## Tensor-product constant

At an odd prime p, the conductor exponent-zero coordinate may remain zero or acquire output exponent one with weight 1/(p-1). Exponent one can only remain one; every exponent at least two is unchanged. Thus the local block is the stated shear, with separate identity coordinates. Its squared norm is

`(2(p-1)^2+1+sqrt(4(p-1)^2+1))/(2(p-1)^2)`.

Primitive conductors have no 2-adic valuation one, since a character modulo 2m for odd m factors through m. Restricted to the allowed input coordinates, the exponent-zero coordinate maps to two equal outputs and higher exponents remain fixed. Its squared norm is exactly 2. This restriction is necessary for the reported constant and is correctly stated as a character-theoretic lemma to formalize.

Every odd prime in a relevant q is at most 150000: odd q is at most 150000, and even q is at most 300000. Extending finite input vectors by zero into the finite prime-exponent tensor space, allowing extra output integers, then projecting back is valid. Tensor norms multiply, while the domain and output projections cannot increase norm. Taking identity on higher prime-power exponents does not increase any local shear norm.

I reran the arithmetic script and separately checked its exact rational numerator is less than 25 times its denominator. The certified global upper bound is

`35858356635742588448682057677821345334002074112323 / 1461501637330902918203684832716283019655932542976 <25`.

The square-root rounding and accumulated-product rounding are upward. Sieve enumeration covers the full required finite prime interval. At the reviewed script version, the displayed ceiling was 25 rather than a dedicated assertion of the final comparison; my separate integer check supplies that comparison for this output. This is a nonblocking reproducibility improvement, communicated to the author. No floating diagnostic decides the certificate.

## Powerful parts and pair coefficients

The compatibility condition is exact. If one conductor has exponent at least two at a prime, any common inducing modulus must have that exact exponent, and so must the other conductor. Hence unequal powerful parts cannot contribute together. When they agree, all common outputs are precisely q=lcm(c,d)*k with k squarefree and coprime to the least common multiple. The product of spectral weights is then

`c*d/[phi(lcm(c,d))^2*phi(k)^2]`.

The modulus cutoff and the actual delta window remain inside the k sum. The eleven exact sample comparisons confirm the script's transcription, but the general conclusion rests on the prime-exponent argument, not those samples.

For odd powerful part m, odd squarefree variables are bounded by R/m and the 2-adic doubling remains. For even m its valuation at 2 is at least two, so doubling disappears and the odd variables are bounded by 2R/m. Omitting primes dividing m is valid. The replay returned the claimed safe block bounds for m=1,4,8,9,16,36,144,900. Replacing R at a fixed twist by `min(150000,600000/|delta|)` follows exactly from qt(q), with a separate delta=0 convention.

## Mixed norm and density interface

For finite zero sums, Cauchy-Schwarz on the output coordinates and the operator estimate give `Cross_z<=25I`. This is a product of two conductor l2 norms. Minkowski in the weighted space indexed by q and two characters gives the stated remainder transfer `(5sqrt(I)+Rmix)^2`. It does not identify two independent characters or assume a fourth moment from two second moments.

The cell reduction is also valid when its finite cells cover the selected zeros. Weighted Cauchy-Schwarz must be applied to each whole primitive zero sum using the per-character mass bound M_c. It yields a sum of cell contributions, then the conductor l2 triangle inequality gives the factor `sqrt(S_A)` with `S_A=sum_c[(c/phi(c))*M_c*N_c(A)]^2`. Multiplicities occur in the count, and no simple-zero premise enters. The kernel J_AB is the integral of the product of cell suprema, as written; replacing it by a supremum of integrals would need a new argument.

For fixed cells, kernels and mass bounds, the real-part powers decrease with x. Endpoint evaluation of that sufficient majorant is therefore uniform at larger x, without claiming monotonicity of the oscillatory zero sums themselves. The local-max bridge to S_A from a first-density bound is correct, but its maximum must actually be estimated. This is the unresolved conductor-concentration problem.

Infinite-zero passage remains a separate obligation. Finite-dimensional operator bounds plus pointwise convergence alone do not provide mixed-norm convergence or a uniform Rmix bound.

## Euler/coprime correction

I checked the raw unconditional source types of `ArcChars.sum_noncoprime_etaPlus_le:66` and `BaseGap2.sum_noncoprime_le:41`. Their scale conditions are satisfied here. Multiplying removed coefficients by primitive character values of norm at most one preserves their bounds. The ceil choice for K ensures z^2<=2^K; `K<=2log(z)/log(2)+1` and the decreasing normalized logarithmic bound give the proposed uniform `d_plus<=1e-23` and `d_star<=1.4e-21`.

Character orthogonality gives `sum_psi |tau_q(psi)|^2=phi(q)^2`, so division by the spectral phi(q) leaves Euler-error energy at most phi(q)d^2. The note correctly uses this extra phi(q), not 1. Expanding primitive products about coprime products produces two linear error terms and one quadratic term. Under the explicitly retained J<=10 and the previously derived coprime energy bounds 57 and 4.15e14, their mixed Hilbert norm is bounded by the displayed expression below 1.2e-13.

The last coarse factor `sqrt(3.24e22)` is safe from phi(q)<=300000 and total window length at most 3.6e11. The replay verifies the remaining square-root and scalar comparisons by rational upper bounds. This correction concerns primitive character sums versus induced coprime sums. It is not the later coprime-to-full additive-sum transfer and must not be counted twice. Contour terms, zero-at-zero contributions and high-zero tails remain additional parts of Rmix.

The allocation `Astar_actual<=2.5e-7`, `I<=2.79e-8`, `Rmix<=1e-6` implies the corrected combined cap 9.5e-7 by the exact displayed square. None of those three analytic inputs is established by the allocation arithmetic.

## Status and pins

Reviewed note SHA256: `F22780A879B9636440B5C155441F622F338B79DCDA5E4134BCC686D7C727E488`.

Reviewed script SHA256: `F3D363A13D59922235C3149B20B7598F7D469FD12D95975C7EC9B1D00553A0B9`.

Status is an independently reviewed paper operator/correction argument with exact external finite arithmetic. Character decomposition, finite tensor norms, certificate replay, integrability and limit bridges, and exact source consumption still require Lean implementation. I, Astar and the complete Rmix budget remain open. No new anchor, sorry, draft import or sealed theorem was introduced by this review.
