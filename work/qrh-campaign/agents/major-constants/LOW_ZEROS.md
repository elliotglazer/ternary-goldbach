# Low-height zero exclusions and the remaining averaged budget

This is source inspection and an exploratory numerical model, not a proof of a new zero-free region or averaged estimate. No Lean compiler was run in this round. The pinned ternary source remains read-only. The independent review correction in FULL_TRANSFER.md now uses the safe upper decimal 9.696000000000330e-7.

## What is actually available

Searched the pinned ternary Explicit directory by theorem-name and statement patterns, the pinned Mathlib NumberTheory/LSeries directory and broader NumberTheory references, and the comparison repository's implemented DirichletZF files (not merely its Challenge statements).

* Ternary Explicit/Xi.lean:42 and :51 prove xiF nonzero for Re(s)>=1 and Re(s)<=0. At :104 xiF_half_ne_zero proves only xiF(1/2) != 0, using re_zetaF_half_ge at :80. Continuity gives an unspecified neighborhood of this point, not a numerical zero-free rectangle.
* Explicit/ZetaDatum.lean:190 zetaF_ne_zero_strip means -1<Re(s)<0. It does NOT cover the critical strip.
* Explicit/ZeroFreeRegion.lean:421,546 gives beta<=1-1/(11 log |gamma|) only when |gamma|>=1e8. It supplies no first-zero gap.
* Explicit/ZeroFree.lean:97 gives 0<beta<1 for xiF zeros. Its pairing and Stechkin lemmas and XiPartial.lean:776 xi_partial_approx are unconditional analytic infrastructure, not numerical low-height exclusions.
* Mathlib NumberTheory/LSeries/Nonvanishing.lean:410 gives riemannZeta_ne_zero_of_one_le_re. LSeries/ZetaZeros.lean proves discreteness and finiteness in compact sets. Harmonic/ZetaAsymp.lean:514 gives eventual nonvanishing near 1 with no explicit radius.
* Comparison bombierivinogradov1965/LeanLab/PNTPort/DirichletZF/ZeroFreeAll.lean:203 and RealZero.lean:63 give existential positive constants near Re=1 and allow one real exceptional zero. These are not exclusions for the whole QRH strip and have no usable numerical height.

No unconditional numerical rectangle for zeta or conductors 3,4,5 was found in this search. This is a scoped search result, not a claim that every repository file has been exhaustively classified. No Platt-dependent exclusion has been used.

An exact missing zeta input, for a chosen rational H, would be

    forall s : Complex, 0 < s.re -> s.re < 1 -> abs s.im <= H ->
      riemannZeta s != 0.

Equivalently, using the existing strip theorem and xiF equivalence, xiF(s)!=0 whenever abs(s.im)<=H. H=14 is used ONLY as a hypothetical sensitivity example below; this note supplies no certificate for H=14. For a primitive small-conductor character chi, replace riemannZeta with LFunction chi and keep the open critical strip, avoiding trivial zeros. A family of proved H_chi values is needed, including real zeros at gamma=0. Merely proving the absence of off-line zeros does not remove on-line terms from an absolute zero sum.

## What a hypothetical gap changes

The existing etaPlus exponential envelope reported by the Mellin worker has K<=105393.224 and a(delta)=min(.28/(1+abs delta),.005). Even granting an ideal continuous shift of the tail past H=14, its gain is only exp(-a*14). This is .932394 for delta=0 or49, .961932 for delta=100, .996092 for delta=1000, and .99999347 for delta=600000. The actual discrete window proof must also handle endpoint windows; the ideal factors are sensitivity calculations, not new proved tail inequalities.

The rectangle-Sobolev bound proportional to sqrt(2T) at T=1e8 would improve by only sqrt(1-14/1e8)=.99999993. A useful first-zero gap must therefore be combined with a much sharper joint transform estimate. Untwisted Gaussian Gamma-function decay does not control the whole twist integral: the oscillation is gamma*log(t)+2*pi*delta*t, so stationary phase is possible when gamma and delta have opposite signs. The relevant delta range cannot be replaced by delta=0.

The exact principal target, neglecting separately budgeted explicit-formula and coprime-removal errors, is

    integral_{-600000}^{600000} |FU(-delta/49)|^2
      |sum_rho multiplicity(rho) * x^(rho-7/8) * Mplus(rho,delta)|^2 ddelta
      <= A_cap * x^(1/4).

At x=4.9e26 and J=8.79, the right side is approximately 4.57840012664. This is a weighted L2 requirement, not a pointwise zero sum. Moduli 1 and 2 have equal phi and delta range and share the primitive zeta error, apart from already identified removed powers of 2. Treating them as independent estimates wastes this relation but does not cancel their nonnegative energies. With both present the same integral has approximately half that budget.

The source proves integral |FU(-delta/49)|^2 over the full line <=381.22. Previously computed uncertified quadrature gives 52.11714704834. Using the latter for sensitivity only, a uniform QRH coefficient for the pair q=1,2 must be C<.2095808308 in |E|<=C*x^(7/8). With the source upper bound the sufficient C cap is .1095895223/sqrt(2), substantially smaller.

## Removing principal characters does not close the remaining estimate

Here is a conditional profile with exact arithmetic structure. Assume each primitive-conductor error, including necessary imprimitive corrections, satisfies

    |E_chi(delta)|/x <= e0/sqrt(c),   c=conductor(chi).

For squarefree q all its divisors are coprime to their complementary divisors. The exact Gauss weight is c, so it cancels 1/c in the squared error. Summing the actual counts of primitive characters over divisors gives phi(q). Consequently the resulting upper estimate for Aplus is e0^2 times

    sum_{q in Qset, squarefree} I_q/phi(q)^2,
    I_q=integral_{-1200000/qt(q)}^{1200000/qt(q)} |FU(-delta/49)|^2 ddelta.

Its principal-character part is e0^2 sum I_q/phi(q)^3. These formulas retain the exact imprimitive Gauss weights. Non-squarefree q have m_q=0 and hence contribute zero to Aplus, although they still matter to the cubic Cross/V quantities.

The reproducible low_zero_model.py replaces every I_q by the full-line integral upper bound (or the explicitly uncertified quadrature for sensitivity). It sums the exact finite modulus set using integer phi and mu, followed by floating-point sums. The dimensionless weights are:

    all characters:                         2.82641135909
    all characters at q>2:                  .82641135909
    principal characters at every modulus: 2.30096154467
    nonprincipal characters at every q:     .525449814417
    nonprincipal characters at q=3 and6:     .25
    all characters, q>=10000:               .000185615165463
    all characters, q>=100000:              .0000107977901611

The q=3,6 value .25 is exact in this full-line model: each has phi=2, one nonprincipal character of primitive conductor3, and coefficient1/8. Their actual I_q both truncate at delta=200000; the source's Fourier tail bound makes the missing full-line integral at most about4.96e-10. The numerical value of the full-line integral itself is still uncertified here.

With e0=C0*x^(-1/8), the q=3,6 pair alone requires C0<.592784107 in this quadrature model. After removing ALL principal characters the full-line sufficient cap is C0<.408884770. The exploratory rectangle-Sobolev profile gives C0=8.239*sqrt(2e8)*Z=116517.0554*Z; even optimistically setting its window-count factor Z=1 gives a modeled q=3,6 Aplus of37596.78, versus the target below1e-6. Thus a first-zero gap for zeta alone cannot rescue that bound.

This is an obstruction to these upper estimates, not a lower bound on actual character errors and not an impossibility theorem. It does NOT establish an insurmountable large-conductor obstruction. The weights decay strongly with modulus, and a sharp large-sieve/density argument may control large conductors while a separate explicit calculation handles the small ones. Existing large-sieve results audited in AVERAGING.md do not currently provide the needed constants and twist treatment.

## Relaxing J

The dynamic cubic budget stays .011670451 and B(J)=2J+17.41053338496. Equal allocation gives

    A_cap=budget^2/(4B(J)),   V_cap=budget^2/(4J).

For J=9 these are approximately9.61574237408e-7 and3.78331740398e-6. For J=10 they are9.10167633417e-7 and3.40498566359e-6. These modest changes are feasible if the analytic estimates exist. They do not fix the orders-of-magnitude failure above. prime_estimates is separately investigating J and reports that an unweighted residual integral R can give sqrt(J)<=sqrt(8.70526669248)+sqrt(R); Aplus alone does not control that R because its weight can vanish.

Best next direction: obtain a certified low-conductor weighted transform/zero calculation (not just H=14 in the current envelopes), retain the exact character average for the large-conductor treatment, and prove an unconditional J bound through its unweighted residual interface. All three analytic tasks remain open.

