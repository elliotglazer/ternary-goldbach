# Independent review of the modulus-weighted plus/star comparison

2026-11-11. **PASS at the stated conditional paper/source scope; no correction requested.**

Reviewed `independent-feasibility/MODULUS_WEIGHTED_PLUS_STAR_RESEARCH_2026-11-11.md`, SHA256 **A86643A179B34576117DF2F9125E78B7029696A367D5057EAA8531769B30DE1A**. This review reconstructs the arithmetic support factor, analytic smoothing lemma, source normalization, and uniform-comparison obstruction. It does not prove any of the proposed actual plus/star energy bounds, remove the spectral family, or certify a Lean proof. No analytic values or builds were run.

## 1. Exact support and normalized energies

`Bombieri.sum_char_mul_S:78` uses the inverse character in the actual twisted coefficient sum. Its Parseval identity at 114 and exact Gauss support theorem at 135 give the nonprincipal unit-vector expansion with normalization phi(q)^(-1/2). Thus its coefficient squared norm is E+_q, and finite Cauchy gives max_b|z_b|^2 <= (d_q/phi(q))*E+_q. Multiplication by the nonnegative |u_b|^2 and summation proves the stated mixed bound. No averaging over unit numerators is missing.

The support count is correct, including the exceptional small moduli. At p^a with a>=2, nonzero Gauss sum forces full conductor; the number of such local characters is phi(p^a)-phi(p^(a-1)). At exponent one, every local character is supported. CRT multiplies these counts; the principal character is supported exactly for squarefree q. Therefore

    kappa_q = product_(p^2|q)(1-1/p) - 1_squarefree(q)/phi(q).

This gives kappa_1=kappa_2=0 and kappa_q<=1/2 for 4|q. It is not the parity factor `LargeSieveWeights.kap:29`. The general counting argument, rather than the author's small-modulus checks, supports its use on every q.

The actual centered star variance subtracts mu(q)^2/phi(q), not mu(q)^2/phi(q)^2. This follows directly from `MajorTotal.sum_units_sq_sub_principal:108–154`, independently read for this review. The source is pinned at **106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A**. Multiplying this identity by kappa_q preserves the exact weighted principal subtraction.

In the finite tagged arc measure, splitting s=a_q P+z+a_q e+o yields precisely

    ||s(u+v)|| <= pbar + sqrt(A) + sqrt(C_mix)
                         + p0 sqrt(B_a) + d0 sqrt(B).

The principal e term carries a_q; the outer removal does not. The root's pbar=1.902e-6 is already an integrated norm and is not multiplied by sqrt(j). The separate root budget **22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7** is retained as a conditional input, not inferred from a support count. I checked its scalar conversion and the cited finite-product M3 bound; this is not a recursive review of all its analytic prerequisites.

The displayed complete allocation is valid: its norm upper bound is 0.000010855301, whose square is below 8.79*(3.67e-6)^2. The use of B_a<=.01 and B<=10^6 is explicit. Neither follows merely from A, since P can vanish. Actual E+_q<=7.02e-13 remains an unproved premise.

## 2. Source comparison and conductor 3

I read `LargeSieveProof:75–120,137–246,295–374`, `LargeSieveWeights:20–45,130–139`, and `LSQuot1:20–46`. The weighted finite character interchange is legitimate for nonnegative modulus weights. The common coefficient sequence must remain norm-summable and supported on primes above sqrt(x); its coprimality with every modulus in the comparison is part of the source proof, not true for the original unrestricted coefficient sequence without splitting it.

For x=49y, delta0=8, Q=7sqrt(y)/4, the source mR definition indeed gives m_R=2R and m_Q=floor(2Q) whenever |delta|<4. This is a positive-length interval. The source comparison requires a single coefficient bound for every character and twist; selecting conductor 3 is therefore a valid necessary constraint on that comparison constant, without asserting that the actual conductor-3 character energy is large.

With R=132900 the eligible ambient moduli are exactly 3d and 6d, d<=44300, squarefree and coprime to 6. Both have phi=2phi(d), kappa=1-1/(2phi(d)), and Gauss squared weight 3. Their combined coefficient is

    3*(1/phi(d)-1/(2phi(d)^2)).

This independently checks the factor 3, both parity branches, and the inclusive endpoint. The comparison denominator is 3G_6(Q/3). Floors cause no asymptotic correction to the leading coefficient: the pinned `LSQuot1.ramare_Gq:31` explicitly gives G_6(z)=(1/3)log z+O(1). Consequently C_kappa(y) log y has liminf at least 6G_kappa. That declaration has no Fact PlattGRH binder. Its deeper Ramaré proof remains an imported lower boundary; this review does not adopt the later numerical corollary's bundled assumptions.

Fourier scaling gives integral |Fourier etaUC(-delta/49)|^2 ddelta =49 V_U. Restricting each interval and using 0<=kappa<=1 thus gives L_kappa<=49 V_U M_R<49 V_U*14. The original finite mass upper bound, rather than a new prime computation, supplies M_R<=13.59756. The theta/QRH provider is not an input to this algebra.

## 3. New smoothing lemma

The actual mixture in `Cor933.etaU_eq:49–66` and the two pieces in `Eta2Moments.setIntegral_eta2_mul:23–42` give the stated moments. Differentiating the two displayed antiderivatives and substituting 1/4,1/2,1 gives (log 2)/2-3/16 and 3/4-(log 2)/2; their sum is 9/16. Tonelli and positive-scale substitution then yield m0=sqrt(pi/2), m1=9/8. Compact scales in [1/4,1], Gaussian decay, and nonnegativity justify these moments and the L2 pairing; they are not evaluated numerically.

For h(t)=(3-t)+ on t>=0, h>=3-t and integral h^2=9. Since pi>25/8, the pairing is strictly greater than 21/8. Cauchy therefore gives V_U>49/64>3/4. This uses the lower bound on the truncated pairing, not a false equality with 3m0-m1. It is a new elementary paper lemma, not a claim that the exact first moment already has a named Lean declaration.

## 4. Obstruction and its limits

The author grants tlarge(y)=V_U log y+O(1), zero small-prime/removal costs, and exact principal subtraction solely as a favorable test of this method. Combining these inputs with the uniform comparison constraint yields

    liminf comparison allowance >=49 V_U*(6G_kappa-14)>279.3.

Even deleting every other norm in the mixed sufficient inequality leaves the ceiling j*u0^2/epsilon<169 for the B_kappa upper bound inserted by E+<=epsilon. Thus this particular uniform coefficient comparison does not certify that sufficient target. The result survives the improved principal allocation because it has already allowed perfect principal treatment.

There is no lower bound here on actual B_kappa, C_mix, or Wstar. There is also no impossibility theorem for a centered denominator, a nonuniform integrated comparison, a better actual plus-energy profile, or separate low-conductor estimates. The favorable coefficient asymptotic is not proved by the new lemma. No computational family reduction follows.

## 5. Independent evidence

I used a separate trial-division factorization and reconstructed both ambient-modulus coefficients for every eligible d, without importing or executing the author's script. All 13 pinned inputs matched. The independent directed sum has 13468 terms and floor numerator 67935707915980013489 on the 2^-64 grid; adding 13468 units gives the corresponding upper enclosure. Its lower endpoint exceeds 18/5. The checker also verifies the moment constants, complete allocation, target ceiling, and strict obstruction. It reports **32 checks passed**, including the all-term pairing equality.

* Owned script: `integration/review_modulus_weighted_plus_star_20261111.py`, SHA256 **C5FF098361993BBB991DFBA3CBB12549AD35E71ACFF60B1B1AC6F05360B5124B**.
* Owned receipt: `integration/review_modulus_weighted_plus_star_20261111.json`, SHA256 **08919CFC9BD15F43430F228B3751F727399001920A6987D663ACA957CE20AAE0**.

The receipt retains every author source/report pin; the additional MajorTotal pin is above. Exact metadata checks do not establish the analytic lemmas by execution. Existing reports and Lean files were unchanged.
