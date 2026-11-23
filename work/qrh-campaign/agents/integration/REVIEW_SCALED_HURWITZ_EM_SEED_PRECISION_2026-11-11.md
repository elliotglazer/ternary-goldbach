# Independent review of scaled Hurwitz seed precision

2026-11-11. PASS at the stated paper and exact-arithmetic scope. No correction requested to the author report `prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md`, SHA256 `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231`.

I read the complete frozen report and its exact scalar script and receipt. I independently derived the scaled finite formula, error propagation and midpoint-shift bounds. The attached checker imports no author module and evaluates no Hurwitz or elementary function. Its 6,987 exact rational and finite-matrix checks pass. This accepts a proposed finite circuit and sufficient error allocation. It does not accept any generated seed values, prove a Lean or MM0 implementation, or establish a runtime advantage.

## 1. Exact interface and finite formula

The coefficient is U_k=C_k/D^k, where C_k=(-1)^k(s)_k zeta(s+k,1+a)/k!, s=1/2+it. D is the original coarse-grid denominator even at a new odd fine-grid anchor. Consequently the consumer uses h=D(alpha-b), with |h|<=1/4; the midpoint translation uses 1/2. Changing D to 2D only on the output coefficients would be a different interface. Returning these enclosures to the old unscaled interface multiplies their errors by D^k.

All five (V,D,N) rows satisfy N=ceil((V+160)/3) and (V+32)/D<5/4. The domain includes both signs of t, t=0, every anchor in[0,1], and every retained k<P<=32. Since Re(s+k-1)=k-1/2, the reciprocal in the endpoint has norm at most2 and never uses totalized division at zero. All other denominators x,b,D,k+1 are positive.

For E_l=(s)_l/(6b)^l and lambda_k=(-1)^k(6/D)^k/k!, one has lambda_k E_k=R_k/b^k with R_k=(-1)^k(s)_k/(D^k k!). This gives exactly the author's head plus B_b lambda_k Z_k formula. In a Bernoulli term, gamma_r E_(k+2r-1)/6 contributes

    (-1)^k B_(2r)(s)_(k+2r-1)
      / [D^k k! (2r)! b^(k+2r-1)],

as required. The pole-type, half and all64 Bernoulli terms survive. The largest required E index is P+126, not P+127. Multiplication of the true raw remainder by D^-k cannot enlarge it. The prerequisite EM identity and all-order remainder remain those in the separately reviewed unscaled report.

## 2. Rounding and the absolute seed radius

The only noncontracting R factor can be the first; it acts on an exact initial value. Thereafter its norm is at most5/8. Thus its error is below3u. E factors have norm at most1/2, and lambda factors at most6/512, giving errors below2u. These statements allow arbitrary complex rounding directions and do not depend on numerical cancellation.

The head accumulates N terms, each with error at most delta+Pu. Using the rounded R bound5 and the exact unscaled head-sum magnitude at mostN gives

    E_head <=5N delta+(5NP+3N+1)u.

The endpoint arithmetic is deliberately ordered through Z before multiplication by lambda. I checked this order, rather than assigning an insufficient bound to a separately rounded lambda-times-E product. Each gamma-times-E term has error at most11u, including rounded gamma and the final product. Therefore the exact sum has error at most704u. The three rounded Z components have errors bounded by (4b+1)u, 2u and119u. This yields (4b+122)u, while |Zhat|<=2b+2. Multiplying by lambda and rounding gives (8b+127)u. Finally,

    E_endpoint <=(2b+1)delta+[2(8b+127)+1]u.

The last head-plus-endpoint rounding adds another u. Maximizing only after these separate terms gives

    23714 delta+606562u+2^-116
      =(493025/2097152) 2^-100 <2^-102

for delta=2^-118 and u=2^-122. I independently reconstructed all25 band/order totals from these operations and compared them with the frozen receipt. The seed-error claim includes the analytic EM remainder and every named finite rounding gate. Exact rational factors and signed Bernoulli definitions remain acceptance inputs to be proved, not cost-free numerical data.

A coordinate grid of step u has nearest-grid Euclidean error at most u/sqrt(2), so the complex-error convention is consistent. Initial B centers must meet their total delta bound after this rounding. Log error2^-135, amplitude and proposed-phase cis errors2^-121, and the final product allocation suffice by the real-phase Lipschitz inequality. This is not a claim that range reduction or every elementary intermediate fits the seed recurrence precision.

## 3. Width and midpoint stability

The magnitude proof concerns the ideal finite EM coefficients before rounding. Factoring E_k from each higher E term gives

    |U_k^(EM)| <= C A^k/k!,
    A=(V+32)/D<5/4, C=N+2b+1<=3N+5.

The complete positive translation matrix sends this majorant to at most C A^k/k! exp(A/2). Bounding exp(A/2) by its geometric majorant gives at most(10/3)C<4C. Every partial pruned update matrix is entrywise bounded by the complete unpruned matrix. Thus the same bound applies at intermediate updates, not only at the final shifted coefficient.

The maximum row sum of the complete matrix is at most2^P. This rough bound is used only for arbitrary input/rounding perturbations in the width estimate: 2^P(eta+L_P u_T)<1. It is not the final-value error bound. Hence shifted centers have magnitude below4C+1<2^16. This does not bound rational numerators, divisor witnesses, phase arguments or the eventual character transform. The stated small center magnitude is compatible with larger working integers.

For accuracy, an error injected into slot j is propagated by a suffix of the actual update schedule. A prefix is entrywise at least identity, so the complete nonnegative product dominates that suffix; restoring omitted unpruned updates preserves domination. Applying final weights (1/4)^k gives an injection bound at most(3/4)^j<=1. This proves the character-summed633 L_P u_T bound, rather than assuming a partial schedule equals a full translation.

I checked this independently by reverse propagation of the final evaluation weights through the exact pruned schedule. For P27,28,32, every individual injection satisfies the claimed bound. A separate forward matrix construction gives exactly the first20 rows of the binomial translation matrix and the prescribed330,350,430 updates. Every intermediate majorized coefficient also satisfies the claimed width bound.

Initial coefficient errors bounded by eta contribute less than4eta per residue. Horner multiplication and addition errors sum to at most(8/3)u_H per residue. With the existing633 character factor, these become2532eta and1688u_H. Both exact real segments remain in[0,1]. The original differentiated shift and final P20 Taylor remainders are still separate. Exact arithmetic confirms the full sum is below2^-82 for all three orders with eta=u_H=2^-100 and u_T=2^-110.

## 4. What is and is not established

The raw and scaled reports describe different accepted-output interfaces. The reduction from383/388 sufficient fractional-error exponents to118/122 in the V10000,P28 example is a valid comparison of their explicit sufficient allocations. It is not a minimum-precision theorem or a measured speed ratio. The phase recurrence across heights requires its separate cumulative-error allocation; neither scaling nor reuse eliminates it.

All function/parameter identities, rounding witnesses, exact rational factors, coefficient radii and argument identities still need actual checked data. The ordinary PA and Lean analytic and arithmetic proofs have not been implemented by this review. The downstream conductor phases, transform errors, height interpolation, exceptional repairs, signs and completeness checks remain outside this isolated alpha allocation. No claim about old immutable raw boxes or complete spectral proof follows from it.

## 5. Reproducible evidence

Paths below are relative to `work/qrh-campaign/agents`. The independent checker verifies all seven input pins in its receipt and does not execute the producer script.

| Artifact | SHA256 |
|---|---|
| `prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md` | `251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231` |
| `prime-estimates/scaled_hurwitz_seed_bounds_20261111.py` | `51814FE2AA93B10AF604E635AD38831E8E6DDBAFEB32EB6A3DA5E1BDA98B52C5` |
| `prime-estimates/scaled_hurwitz_seed_bounds_20261111.json` | `2705A1CFACB0C9CECDA842DDF73A37696DF8A1BAD250AEA7F383D63AC11A99E8` |
| `independent-feasibility/REVIEW_SHARED_HURWITZ_EM_SEED_CIRCUIT_2026-11-11.md` | `C4D2F0385C84FDC42B70D451378284E278EBA2527D0DC7B74BC9F85AECE73E4F` |
| `integration/check_scaled_hurwitz_seed_review_20261111.py` | `2482A4A819891E8F4F69BDF596CC5B1392F7E5ABC1CAB17997E290C0389A9BBB` |
| `integration/check_scaled_hurwitz_seed_review_20261111.json` | `A34F7CFED2E27D9D1AA7D5EEB98CCA862F7934E56C4F1AC83EDBE2F7DAAB1A3B` |

The checker completed6,987 exact checks. They support the paper derivation and validate the concrete constants and finite matrices; they do not substitute for its generic analytic or rounding arguments.
