# Independent review of the weighted conductor certificate

Review scope: paper mathematics, pinned-source fidelity and exact scalar replay. No Lean declaration, finite zero dataset or global theorem is certified by this review. The active target remains the original reviewed height profile and common endpoint budgets at x0=4.9e26,y0=1e25; the reduced-height proposal is separate.

## Independent reconstruction

For each conductor c and smoothing eta, let N_eta(c) be the source Jensen upper count for one primitive character through H_eta(c), and a(c) its primitive-character count. Define

    E_c,eta(z0)=sum_(primitive chi mod c) sum_(low zeros rho) m_rho*z0^(2Re(rho)-2).

Multiplicity is included even if several characters share a zero. The sum contains only actual nontrivial zeros. For c1 use the pole-subtracted zeta residual; a pole is not a zero contribution. Conductor inversion permutes the primitive characters and leaves the aggregate unchanged.

For arbitrary enclosed real parts in the global reflected7/8 strip, the already reviewed Gram rows give

    integral P_c,eta <=K_eta E_c,eta,
    sup P_c,eta <=M_eta^2*N_eta(c)*E_c,eta,

where P_c,eta is the sum over primitive characters of squared zero-sum norms. The second line is ordinary Cauchy-Schwarz over each character's zeros followed by summation; it uses the per-character count N_eta(c), not a false bound on conductor-wide total count. Here Kplus=23000,Kstar=49*102000,Mplus=3.95,Mstar=4. The pointwise Mplus input remains an actual-smoothing analytic proof obligation in the mixed report.

Consequently

    integral W_c,eta^2 <=(c/phi(c))^2*M_eta^2*K_eta*N_eta(c)*E_c,eta^2,
    W_c,eta=(c/phi(c))*P_c,eta.

Sum over c and use Cauchy-Schwarz in delta to get I<=sqrt(Dplus*Dstar), with D_eta the corresponding conductor sum. This is a valid pointwise-times-L2 fourth-moment argument. It does not infer L4 from L2 alone. The exact Gauss induction operator is unchanged, so Cross_low<=25I retains both character indices.

Aplus, Astar and N have nonnegative conductor weights already derived in the reviewed family report; they are linear in the appropriate E_c,eta. Principal Ep involves c1 alone and the same Gram inequality. Thus a conductorwise comparison with the old endpoint envelope propagates to every second-moment cap as well as the fourth-moment envelope.

## Endpoint comparison and its uniform extension

Suppose all low zeros have beta<=.7 and at most K_c,eta<=floor(a(c)N_eta(c)/1e8) have beta>.54. Then

    E_c,eta(z0)<=a(c)N_eta(c)*z0^(-.92)+K_c,eta*z0^(-.6).

This upper bound deliberately counts the exceptional zeros also in the first term; the overcount is safe. Dividing by the old uniform-.555 endpoint envelope a(c)N_eta(c)z0^(-.89) gives at most

    z0^(-.03)+1e-8*z0^(.29)<1/5+3/5=4/5.

The exact comparisons y0^3>5^100 and x0^29<(6e7)^100 prove these two inequalities for z0=y0 and x0. Therefore second moments improve by a factor<.8; each D_eta improves by<.64, and I improves by<.64, when the weighted condition is imposed on every conductor including c1.

The displayed ratio is NOT bounded by.8 for arbitrary larger z: its second term increases. The correct all-scale proof fixes endpoint E(z0). Every individual magnitude factor z^(beta-1) is at most its endpoint value for z>=z0 because beta<=.7<1. Apply the same phase-independent Gram and Cauchy-Schwarz inequalities with these contracted magnitudes. This gives the fixed final budgets for every x>=x0,y=x/49. It does not claim monotonicity of an oscillatory residual.

The exception budget uses the SOURCE UPPER COUNT a(c)N_eta(c), not the actual total zero count. It should not be described without qualification as an actual exceptional fraction1e-8. The plus and star budgets are separate constraints on nested height ranges; totals across them do not count disjoint zeros.

## All-cap and whole-blueprint scope

If the weighted condition holds at every conductor, all original second-moment and fourth-moment envelopes decrease. Their original high-tail, zero0, contour and coprime remainders remain valid, because they use the global strip and actual coefficient estimates. The finite low sup estimates used for the mixed perturbation also decrease by the same endpoint argument. Thus the reviewed Aplus,Astar,N,Ep and Cross conclusions all remain within their fixed caps.

The alternative by itself does not establish the separate principal finite-.555 condition needed by the psi-tail branch elsewhere in the blueprint. Two valid choices must be distinguished:

1. Keep BOTH the weighted condition and the principal-.555 condition at c1. Then the global.8/.64 improvements remain valid.
2. Keep only the original principal-.555 condition at c1, and apply the weighted alternative to c>1. Then c1 retains its original envelope, while other conductors improve. All original finalcaps still follow, but the GLOBAL.8/.64 improvement is no longer justified.

This is a mathematical scope distinction, not a request for a new hypothesis in the final theorem. Each selected finite condition must eventually be proved by a complete certificate.

## Conductor products and completeness

For c>1 all primitive characters are nonprincipal. The finite product of their L-functions is entire, using the source differentiable_LFunction input in ExplicitBoundGen.lean:19 and ExplicitFormula.lean:314. None is identically zero, by its Euler product on the right half-plane. Local zero multiplicities of the product add. There is no zero-pole cancellation because there are no poles in these factors. Common zeros contribute the sum of multiplicities; they do not cancel.

For c1 use the entire zetaF defined at ZetaGrowth.lean:17 by updating (s-1)zeta(s) at1 to1; zetaF_one at22 confirms that the removed pole is not an artificial zero. Raw zeta cannot be treated as an entire factor on a contour reaching across1. On nontrivial-zero rectangles, prove the correspondence between zetaF zeros and zeta zeros with multiplicities.

A product argument-principle certificate can give conductor-aggregate cell counts sufficient for E_c. It still needs rigorously nonzero contour boundaries, complete coverage, actual primitive-character enumeration and multiplicity normalization. Conjugate-character symmetries may reduce computation only after an exact correspondence proof; they do not permit automatic halving of all counts. Product evaluation can suffer large magnitudes and conditioning costs. Reducing the number of certificate objects does not establish reduced runtime or proof volume.

## Arithmetic replay

The author's exact script was replayed with Path.write_text disabled, so the review did not alter author-owned JSON. It exited0 and reproduced150000 conductors,5,543,640,188 primitive characters, original total Jensen upper proxies1740063512485802 and1278926120257689, and exception-budget sums17325646 and12714116. These totals agree with the independent family enumeration already audited.

The script's single-beta7/8 sensitivity calculation concerns a positive UPPER MAJORANT, not a lower bound on actual Cross. A single zero in both carriers makes that particular scalar majorant large; it does not prove such a zero makes the true residual large. That interpretation must remain explicit.

Freeze pins and final verdict are recorded below once the author's note is frozen. The preceding mathematical reconstruction does not constitute a finite spectral certificate or a Lean verification.

## Frozen final review and verdict

Frozen author files independently read and hashed:

* zero-sum/RESUME_WEIGHTED_CERTIFICATE_2026-11-11.md: A3AB3E32FE0353385DF100BB07AF406DB2D0CEE3DA097258005E6E8914CF8377.
* zero-sum/resume_weighted_certificate_20261111.py: 8CECF6A012136266871F130543FA35D7F83250830C5D2613A274DAF6D305AC2E.
* zero-sum/resume_weighted_certificate_20261111.json: D0516EEC978011BCDF886F4853B71D75F81353DCA97A2B74DB71811114838FAA.

The final script replay, again with file writes disabled, exited0. Additional independent assertions confirm that removing conductor1 leaves allowed exception-budget sums17,325,508 and12,714,114. The frozen note explicitly addresses all scope caveats above: endpoint-only comparison, original conductor1 certificate for the psi branch, upper-count denominator, distinct nested height constraints, and no inferred runtime saving.

The new conductor-product Euler coefficient identity was also reconstructed independently. For a unit m modulo c, all characters modulo each divisor d sum to phi(d) when m=1 mod d and to0 otherwise. Every character modulo c induces uniquely from a primitive character of conductor dividing c. Mobius inversion therefore gives the stated primitive sum over d|c,d|(m-1). If m is not a unit modulo c every character value vanishes, which is why the explicit unit indicator is necessary. Summing absolutely convergent primitive logarithmic derivatives for Re(s)>1 proves the product identity there. This does not analytically continue a computable error bound to the desired left contours; the author correctly leaves that step open.

Verdict: no mathematical defect found in this bounded review. The blueprint-compatible variant preserves all reviewed major second- and fourth-moment caps and their remainders for every x>=x0, conditional on its actual finite spectral conditions and the existing unproved analytic bridge lemmas. It does not complete any finite spectral certificate, assert a new permitted external assumption, prove computational savings, or constitute Lean verification. The original conductor1 condition is retained, so the whole-blueprint variant claims domination by the old envelopes, not global.8/.64 improvements.
