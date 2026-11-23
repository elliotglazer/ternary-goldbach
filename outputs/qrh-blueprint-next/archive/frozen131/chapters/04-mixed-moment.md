# Blueprint: the mixed fourth moment with the actual two smoothings

This is a source-level research blueprint, not a proved estimate. No Lean process ran and no Lean source was changed. The target source is `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. The starting definitions are those in `agents/major-constants/STRONGEST_AVERAGE.md` and `WEIGHTED_ZERO_MOMENTS.md`. All sums below retain multiplicities and the actual imprimitive Gauss support. The recommended route is a modulus-dependent, two-variable spectral kernel calculation combined with explicit density information. A second route rewrites the same quantity as a centered additive correlation of primes; that identity is useful, but no available theorem presently bounds that correlation sufficiently.

## 1. Exact target and corrected budget

Put x0=4.9e26, x>=x0, y=x/49, Q=Qset(150000), and Dq=1200000/qt(q). The source has qt(q)=q for even q and 2q for odd q. Thus Q contains the even moduli up to 300000 and odd moduli up to 150000. It must not be replaced by just the squarefree moduli in Cross.

Use the actual coprime coefficient sequences and normalized residuals

    e+(q,psi,delta) = Schar(psi^-1,coprimePart(q,cP(x)),delta/x)/x
                     - 1_(psi=1) P(delta),
    e*(q,psi,delta) = Schar(psi^-1,coprimePart(q,cU(y)),delta/x)/y
                     - 1_(psi=1) U(delta),

where P(delta)=Fourier(etaPlus)(-delta), U(delta)=Fourier(etaU)(-delta/49), and cU(y)(n)=Lambda(n)*etaU(n/y). Define

    w(q,psi)=|tau_q(psi)|^2,
    E+(q,delta)=sum_psi w(q,psi)|e+|^2/phi(q),
    E*(q,delta)=sum_psi w(q,psi)|e*|^2/phi(q),
    Cross = sum_(q in Q) integral_[-Dq,Dq] E+(q,delta) E*(q,delta) ddelta.

For c=cond(psi), the weight is exactly

    w(q,psi)=c * 1_(q/c squarefree and gcd(q/c,c)=1).

The current corrected shared interface, communicated by the parent and major-constants worker, is

    J<=10,  Aplus_coprime<=5e-7,
    Astar_coprime+Cross_coprime<=9.5e-7.

An illustrative split is Astar<=2.5e-7 and Cross<=7e-7. It is a planning allocation, not a bound already obtained. A different split is legitimate if the combined cap is retained. The old 1.65e-6 combined cap omitted the nonprime reserve and is not sufficient for the final theorem.

The reviewed removal calculation sends the corrected targets to full-sum A<=5.050000000000330e-7 and Astar+Cross<9.817952468e-7. Together with J<=10, it gives dynamic cubic loss below .008778, clean major coefficient at least 1.0404, and leaves .00009 after minor coefficient 1.0376 and nonprime reserve .00271. These are interface consequences conditional on proving all the stated estimates; this blueprint proves none of those analytic caps. In particular, J<=10 and the minor-arc replacements remain other workers' obligations.

The exact full-sum inequality to retain is

    cubic dynamic loss <= sqrt(2*J*(Astar+Cross)) + sqrt(B*Aplus),
    B <= 2*J + 2*.640208*13.59756.

Do not mix a larger logarithmic J estimate with the caps above without recomputing this inequality and the coprime-removal terms.

## 2. What orthogonality can and cannot do

The exact identity is

    Cross = sum_q 1/phi(q)^2 integral sum_(psi,xi)
                  w(q,psi)w(q,xi)|e+(q,psi)|^2|e*(q,xi)|^2.

There are two independent characters at the same modulus. Replacing the pair by psi=xi changes the quantity. In particular, the familiar fourth-moment congruence n1*n3=n2*n4 modulo q is not the congruence obtained from this expression. There is also no cancellation between the nonnegative summands indexed by (psi,xi). Cancellation must be retained inside each residual, inside its spectral Gram matrix, or in an exact arithmetic expansion before absolute values.

There is nevertheless a useful Gauss-weighted orthogonality kernel. For units n,m modulo q, expansion of the Gauss sums and character orthogonality gives

    (1/phi(q)) sum_psi |tau_q(psi)|^2 psi^-1(n) conjugate(psi^-1(m))
       = c_q(n-m),
    c_q(h)=sum_(b unit mod q) exp(2*pi*i*b*h/q).

The orientation can equivalently give c_q(m-n); the two are equal and real. Multiplication by a unit permutes the Ramanujan sum, which removes the intermediate quotient n/m. This equality preserves the zero Gauss weights automatically. It also shows why replacing every weight by its conductor before checking its support loses information.

Available ingredients are `parseval_chars`, `sum_char_mul_S`, `dirichlet_inv_apply_unit` and `norm_sq_gaussSum` in `MinorArcs/Bombieri.lean` (lines 28,82,20,137 respectively), and `DirichletCharacter.sum_char_inv_mul_char_eq` used in its proof. `MajorArcs/Singular.lean:23` gives `ramanujan_sum`; `MinorArcs/Montgomery.lean:75` gives the coprime specialization. The displayed weighted two-point kernel is a new finite algebraic lemma to derive from these ingredients, not an existing theorem name.

## 3. Primary route: an exact four-zero kernel

For s=beta+i*gamma and t=alpha+i*tau define the actual transforms

    F+(s,delta)=integral_0^infinity etaPlus(u) u^(s-1) exp(2*pi*i*delta*u) du,
    F*(t,z)=integral_0^infinity etaU(v) v^(t-1) exp(2*pi*i*z*v) dv.

At first use finite zero sets with the exact source multiplicities. A primitive spectral residual has zero part

    z+(chi,delta)=-sum_rho m_rho x^(rho-1) F+(rho,delta),
    z*(chi,delta)=-sum_sigma m_sigma y^(sigma-1) F*(sigma,delta/49).

The principal pole has already been subtracted. The zero at 0, if the particular completed datum includes it, trivial-zero terms, contour terms, and Euler/coprime removal must be kept in a separate remainder. They must not be included in a nontrivial-zero density theorem. For an induced character the primitive residual equals the actual coprime residual only after its q-dependent removed prime powers are subtracted.

The relevant kernel, for each q separately, is

    Kq((rho,sigma),(rho',sigma'))
      = integral_[-Dq,Dq] F+(rho,delta) F*(sigma,delta/49)
                           conjugate(F+(rho',delta) F*(sigma',delta/49)) ddelta.

For finite zero sets, expanding the squared product is an exact finite identity. Each summand has coefficient

    m_rho*m_sigma*m_rho'*m_sigma'
    * x^(rho+conjugate(rho')-2) * y^(sigma+conjugate(sigma')-2)
    * Kq((rho,sigma),(rho',sigma')).

Then multiply by w(q,psi)w(q,xi)/phi(q)^2 and sum the actual inducing characters. This is the first exact intermediate statement. It retains phases, varying real parts, repeated zeros, and the common delta interval. Passing to infinitely many zeros needs convergence or an explicit uniform tail bound; the finite identity alone supplies neither.

### A usable operator formulation

Set theta=7/8, a(rho)=(2-Re(rho))/((2-Re(rho))^2+Im(rho)^2), and use the positive atomic measure

    mu_(chi,xi)(rho,sigma)=m_rho*m_sigma*a(rho)*a(sigma).

Define k_(rho,sigma)(delta)=F+(rho,delta)F*(sigma,delta/49)/(a(rho)a(sigma)). The total mass is Mchi*Mxi. Under the actual QRH provider and its reflected lower strip, the remaining coefficients

    x^(rho-theta)*y^(sigma-theta)

have modulus at most one. A weighted Schur bound gives

    ||z+(chi)z*(xi)||_(L2[-Dq,Dq])^2
      <= (xy)^(-1/4) Mchi*Mxi * R(q,chi,xi),
    R(q,chi,xi)=sup_(rho,sigma) sum_(rho',sigma')
        mu_(chi,xi)(rho',sigma') *
        |Kq((rho,sigma),(rho',sigma'))|
        /(a(rho)a(sigma)a(rho')a(sigma')).

This is a sufficient bound, not an asserted numerical estimate of R. In a finite certified spectral block, a rigorous upper bound on the largest eigenvalue of the weighted positive Gram matrix can improve on absolute row sums. Such an operator bound remains valid for every x>=x0: the phase factors act diagonally and the amplitude factors are contractions. Evaluating the actual oscillatory sum at x0 and calling it monotone in x would be invalid.

The mixed zero-part cap becomes the concrete aggregate

    (xy)^(-1/4) sum_q 1/phi(q)^2 sum_(psi,xi)
        w(q,psi)w(q,xi) M_cond(psi)*M_cond(xi)*R(q,cond(psi),cond(xi)).

The mass identities/constants in WEIGHTED_ZERO_MOMENTS.md are still analytic obligations. Even after those are proved, replacing every R by a common mass-times-supremum estimate reproduces the unusable mass-only bound. The new work has to estimate the actual kernel rows or operators.

## 4. Why the actual etaStar structure helps

Extend the following functions by zero to the negative real axis:

    f_rho(u)=etaPlus(u)*u^(rho-1),
    g_sigma(v)=49*etaU(49v)*(49v)^(sigma-1)
              =49^sigma*etaU(49v)*v^(sigma-1).

The scaling factor 49 is necessary. With the source Fourier convention,

    F+(rho,delta)=Fourier(f_rho)(-delta),
    F*(sigma,delta/49)=Fourier(g_sigma)(-delta),
    F+(rho,delta)F*(sigma,delta/49)
       = Fourier(f_rho*g_sigma)(-delta).

Hence the full-line four-kernel is the spatial inner product

    K_infinity((rho,sigma),(rho',sigma'))
       = integral (f_rho*g_sigma)(v)
                  conjugate((f_rho'*g_sigma')(v)) dv.

This follows from Fourier convolution plus polarized Plancherel once L1 and L2 are established. For a whole finite spectral combination, the restricted-interval squared norm is at most the full-line squared norm. Do not claim the entrywise inequality |Kq|<=|K_infinity|: truncation can remove cancellation, so that statement is false in general. Full-line replacement can itself be expensive for large q, where Dq is small; retain the restricted matrix or use its own certified quadrature there.

The actual eta2 is a logarithmic tent. If b(u)=1_[1/2,1](u), direct Mellin convolution gives eta2=4*(b*_M b), apart from irrelevant endpoint conventions. Consequently, for Re(s)>0,

    Mellin(eta2)(s)=4*((1-2^(-s))/s)^2,
    H(s):=Mellin(etaU)(s)
        =4*((1-2^(-s))/s)^2 * 2^(s/2)*Gamma(1+s/2).

The value at s=0 is obtained by continuous extension if needed. Nontrivial zeros in the reflected QRH strip do not require that endpoint. These are derivations from the actual definitions, not numerical conjectures. The eta2 Mellin identity and its Fubini justification still need a Lean proof. The Gaussian factor follows directly from `Explicit/GammaBounds.lean:20`, `Gr_zero_zero_eq`, and `mellin_fδ`.

A particularly useful finite expansion is, for real z and positive integer L,

    F*(s,z)=sum_(k=0..L-1) (2*pi*i*z)^k/k! * H(s+k) + Rem_L(s,z),
    |Rem_L(s,z)| <= (2*pi*|z|)^L/L! * H(Re(s)+L).

The remainder bound uses the real-argument exponential Taylor integral remainder, whose oscillatory factor has modulus one, and etaU>=0. It does not need an exp(2*pi*|z|*v) loss. The moment on the right is a positive real number. Thus on a high-modulus arc one can certify a small finite matrix of Gamma expressions uniformly for |z|<=Dq/49. This preserves the eta2 factor and its inverse-square height decay. A blanket bound etaU<=6.2 discards both advantages.

For low moduli Dq/49 is large, so this Taylor expansion is a poor numerical choice. Split delta into a central interval and geometric outer slabs. On the latter use the exact compact r-integral

    F*(s,z)=integral_(1/4)^1 eta2(r)*r^(s-1)*G(s,z*r) dr,

where G is the source Gaussian Mellin transform. This follows by v=r*u in `etaU_eq`. Apply signed contour rotation to G before integrating r. Keep the sign relation between z and Im(s); taking absolute z too early loses the useful damping on one half-plane.

For etaPlus use the already implemented identity `mellin_fP_eq`:

    F+(s,delta)=integral_(|2*pi*xi|<=200) ghat(xi)
                  G(s-1+i*2*pi*xi,delta) dxi.

The existing ghat Fourier-tail and derivative-energy estimates permit a near/far xi split. The plus height is shifted by as much as 200; it is incorrect to claim sharp height separation while ignoring that shift. The actual ghat amplitude, rather than just its support, should be retained in a numerical kernel calculation.

The shared-delta geometry now becomes visible. Gaussian stationary phases approximately require

    gamma/u ~= 49*tau/v ~= -2*pi*delta,

with u in the plus smoothing range and v in the unscaled star range. Many pairs therefore have weak overlap. This is an explanation of the proposed calculation, not a proven exclusion rule: the smoothings are not compact in u,v, etaPlus has its height shift, and low imaginary parts need separate treatment. No minimum zero spacing or positive first-zero height for arbitrary characters is assumed.

## 5. An explicit bridge to the density worker

The exact four-kernel route can be expensive. A conservative intermediate reduction uses mass-weighted Cauchy-Schwarz inside each individual spectral sum, while retaining the joint kernel integral. It does not apply a second-moment theorem to Cross and stop.

For a zero cell A in (beta,gamma), let beta_A be its upper real endpoint and a_A be a proved positive lower bound for a(rho) on A. Define

    Nchi(A)=sum_(rho in A) m_rho,
    Bq(A)=sum_(psi mod q) w(q,psi)*M_cond(psi)*N_cond(psi)(A),
    Jq(A,B)=sup_(rho in A,sigma in B)
        integral_[-Dq,Dq] |F+(rho,delta)|^2*|F*(sigma,delta/49)|^2 ddelta.

For a finite cell partition the zero contribution is bounded by

    sum_q sum_(A,B)
      x^(2*beta_A-2)*y^(2*beta_B-2)
      * Jq(A,B)/(phi(q)^2*a_A*a_B) * Bq(A)*Bq(B).

All multiplicity weights are inside Nchi. The conjugation convention is inherited from the exact explicit formula, so no real-character quartet is assigned to a single nonreal character. The primitive induction/coprime corrections remain outside this zero contribution.

This identifies the new density interface: it is a same-modulus weighted PAIR density, or a global density estimate for one cell combined with a rigorous per-modulus bound for the other. A global first-density estimate alone does not bound the product at each q without such an additional step. The elementary inequality

    sum_q hq*Bq(A)*Bq(B) <= sup_q Bq(B) * sum_q hq*Bq(A)

is valid for hq>=0 but can be wasteful. Keep q bins and conductor divisibility in both factors. The existing `PolyDatum`/`sum_multRectD_le` Jensen machinery supplies a local count with multiplicity. Covering the full strip uses radius 2.7 for height-3.48 windows, as in the saved uncompiled strip-count draft, rather than the radius-2.3 critical-line count. This can give a valid per-modulus cap without zero-spacing assumptions; whether its numerical cost is tolerable must be tested.

The major-constants worker is developing the corresponding single-cell beta-density factor, including the condition 2*log(x)>a*log(B) when a density bound has B^(a*(1-beta)). That factor can be inserted here only after proving the actual explicit density theorem, with its constants and height range. No such theorem has been established in this campaign. In particular, rare real zeros or several coincident zeros at low height cannot be wished away by QRH or by a total positive mass estimate.

The finite computational target is now well specified: use rational beta/height/delta/conductor cells, certify Jq(A,B) from Section 4, certify the actual weighted count or density in every cell, sum this expression, and reserve room for all remainders. An output below 7e-7 would meet the illustrative Cross allocation only after those remaining terms are included. There is currently no certified numerical value for this aggregate.

## 6. Alternative arithmetic route: centered convolution and Ramanujan sums

This route retains correlations of prime sums directly. For each unit residue a modulo q define finite signed measures on the real line

    nu+(q,a)= (1/x) sum_(n=a mod q) Lambda(n)etaPlus(n/x) delta_(n/x)
              - (1/phi(q))*etaPlus(u) du,
    nu*(q,a)= (1/y) sum_(n=a mod q) Lambda(n)etaU(n/y) delta_(n/x)
              - (49/phi(q))*etaU(49u) du.

Use a finite prime truncation first and then prove total-variation convergence using the smoothing tails. The sums are over positive integers; a unit residue enforces coprimality. etaPlus need not be nonnegative, and this signed-measure formulation does not assume it is. The star scaling in the continuous term and the common atom n/x are both essential.

Write H_a(delta)=integral exp(2*pi*i*delta*u) dnu+(a)(u) and K_a similarly. Their multiplicative character transforms are exactly e+ and e*. Their additive transforms reconstruct the coprime rational-arc residuals. Therefore Cross is exactly

    sum_q integral_[-Dq,Dq] sum_(a,a',b,b' units)
      c_q(a-a')*c_q(b-b')
      * H_a*conjugate(H_a')*K_b*conjugate(K_b') ddelta.

Let W_D(delta)=(pi^2/4)*sinc(delta/(2D))^2, with sinc(t)=sin(pi*t)/(pi*t), continuously extended at zero. Then W_D>=1 on [-D,D], W_D>=0, and

    Fourier(W_D)(u)=(pi^2*D/2)*max(1-2D*|u|,0).

After replacing the interval by this positive majorant, Fourier-Fubini expresses the last integral as a centered four-prime additive correlation: apply this triangular kernel to the difference between the convolution measures nu+(a)*nu*(b) and nu+(a')*nu*(b'). In the purely atomic term it is supported on

    |(n1+n3)-(n2+n4)| <= x/(2Dq).

The mixed discrete/continuous and continuous/continuous terms implement the principal subtraction exactly. Dropping those terms before estimating destroys centering. Dropping the signs of the Ramanujan kernels also throws away the orthogonality gain.

This is a genuine same-modulus correlation identity. A sufficient new analytic theorem would bound these centered, triangularly smoothed convolution energies with the specified residue kernels and eta weights. A usual second-moment large sieve or a bilinear theorem for one character does not provide that theorem. The additive twist exp(delta*m*n/x) also prevents directly inserting a factorized multiplicative bilinear estimate. No explicit result already found in the pinned comparison repository proves the required four-prime correlation at x0.

There is one related escape route: estimate the original V=sum integral sum_b |s_b|^2|t_b|^2 directly rather than majorize it by 2(Astar+Cross). This replaces the independent pair of residues by the diagonal b=b'. Its Fourier expansion is a different character-convolution constraint and can be much smaller. It is a legitimate alternative cubic proof architecture, but it does not prove the Cross cap defined here. It needs its own exact algebraic derivation, corrected budget and analytic estimate before being substituted into the main blueprint.

## 7. Remainders and passage to the source statement

For each (q,psi), write the actual e+=z++r+ and e*=z*+r*, where r includes every nonzero spectral remainder and imprimitive correction. Work in the direct-sum Hilbert space over (q,psi,xi,delta), with measure w(q,psi)w(q,xi)/phi(q)^2 on the finite character pair and Lebesgue measure restricted to the arc. Then Minkowski gives the exact useful transfer

    sqrt(Cross_actual) <= ||z+ z*||_H + ||z+ r*||_H
                                      + ||r+ z*||_H + ||r+ r*||_H.

The right side must be at most sqrt(7e-7) for the illustrative split. A scalar remainder norm without the right character/Gauss weighting does not certify these terms. The source's q-dependent removed-prime-power estimates and contour estimates must be applied before taking this norm. The already reviewed full/coprime transfer is a subsequent, distinct step and should not be double-counted.

For infinite zero sums, a valid proof order is: prove the finite identities; obtain uniform tail bounds in this Hilbert space using the existing Mellin exponential tails plus multiplicity counts; pass to the explicit-formula limit; then apply the numerical aggregate. Pointwise convergence of a zero sum is not enough by itself to interchange all four sums and the delta integral.

## 8. Lean proof blocks and what is actually available

The proposed declaration names below are planning labels only. None has been implemented by this task.

1. `gauss_weighted_character_kernel`: the finite identity in Section 2. Use the exact `Bombieri` lemmas and finite sum rearrangements. This has no new analytic premise.
2. `mixed_zero_sum_gram_finite`: expansion for finite zero carriers with natural multiplicities. This is complex-ring algebra and finite integral interchange, with ordinary integrability inputs supplied later.
3. `eta2_mellin_eq` and `etaU_mellin_eq`: derive the actual tent convolution and the Gaussian product formula. Source definitions are `Helfgott/Defs.lean:45,49,55`, `MinorArcs/EtaU.lean:24,26`, and `MajorArcs/Cor933.lean:49` (`etaU_eq`). `Cor933.fourier_etaU` provides an existing Fubini pattern, not the required Mellin theorem.
4. `etaU_mellin_twist_taylor`: the finite Taylor formula and explicit remainder in Section 4. Prove the Gaussian moments and integration domination; use `GammaBounds.Gr_zero_zero_eq` and `norm_Gamma_le_rot` for certified cells.
5. `mixed_mellin_fourier_convolution`: scaling and convolution identities. Mathlib has `Real.fourier_mul_convolution_eq` in `Analysis/Fourier/Convolution.lean:121`, with two L1 inputs. The target has `TernaryGoldbach.integral_norm_sq_fourier` in `Prelim/PlancherelReal.lean:83`, requiring L1 and MemLp 2. Obtain cross inner products by polarization or the L2 isometry. Gaussian domination and the positive strip endpoints supply the needed integrability, but those wrappers still require proofs.
6. `mixed_kernel_cell_bound`: a genuine analytic/numerical family of estimates for Jq or the four-kernel rows, using the actual transforms, delta intervals and certified tails. Existing plus inputs include `EtaPlusMellin.mellin_fP_eq` at line134, `norm_fP_le` at66 and `norm_mellin_fP_tail` at286; `HHFourier2.tail_fourier_gC_le'` supplies the xi-tail. The new joint bound is missing.
7. `weighted_pair_density_bound`: an explicit same-modulus aggregate count, retaining primitive induction and multiplicities. Local Jensen bounds can supply a coarse factor; an explicit zero-density improvement or finite verified zero inventory is missing.
8. `mixed_residual_tail_transfer`: the Hilbert-space remainder calculation and limit passage in Section 7. Existing generic norm/integral tools apply, but the actual uniform inputs are still missing.
9. `cross_bound_at_x0_and_above`: combine certified items 6-8 with the exact finite weight arithmetic and phase-uniform x monotonicity. Its conclusion must be the actual Cross expression from Section 1, not a theorem with an assumed mixed-moment bound as a new hypothesis.

An axiom/dependency audit is required after compilation. Lexical absence of `sorry` or a proof sketch is not kernel verification. QRH, if used, must be supplied by the actual proved provider with its pole/zero correspondence checked; a local `Fact` restating QRH is not a replacement proof.

## 9. Recommendation and stopping point

First implement the algebraic character kernel and the etaU Mellin/Taylor identities, then perform a bounded certified kernel experiment on high-modulus central arcs. These have exact source inputs and no guessed zero-spacing condition. In parallel, the averages worker should identify an explicit density theorem or finite zero certificate with usable constants. The two interfaces meet at Bq(A) and Jq(A,B), not at an unspecified promise of cancellation.

For the small moduli and low heights, retain a finite spectral block and its positive Gram matrix, then certify tails. The q=1,2 principal block cannot be improved by averaging over many characters. Low nonprincipal zeros, including possible real zeros within the QRH strip, also need a genuine estimate. The compact log-tent factor and 49 scaling make the mixed kernel more structured than an arbitrary product of L2 functions, but they do not alone prove the required numerical cap.

At this stopping point, the exact identities and the finite Taylor remainder have mathematical derivations; no kernel-cell table, density theorem, remainder aggregate, or final Cross cap has been certified. The blueprint therefore identifies a concrete proof program and its missing number theory without claiming a PlattGRH replacement or completion of Goldbach.


## Independent review status

The statement-audit worker independently checked the new formulas and found no mathematical defect: the eta2 and etaU Mellin factors, the real-twist Taylor remainder without an extra exponential, the factor 49 in the scaled convolution, the Gauss-weighted Ramanujan identity for unit inputs, and the finite four-zero/Schur normalizations. This is a bounded source-level review, not Lean verification. In particular, the Ramanujan identity is not asserted for arbitrary nonunit inputs, and the analytic Fubini, convergence, density and numerical-kernel obligations above remain open.
