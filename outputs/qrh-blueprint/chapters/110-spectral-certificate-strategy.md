# A zero-count certificate for the selected finite spectrum

Research only, 2026-11-11. This is a new strategy note; all frozen family and base-gap reports remain unchanged. There was no Lean build, L-function evaluation, or numerical zero verification. The primary target is still the original shared height Hp(c) and uniform upper real part111/200 for every active primitive character. Weighted major-moment alternatives cannot replace that pointwise premise.

The concrete certificate proposed here is a zero winding number on a right-hand rectangle for each conductor product. It requires no individual zero isolation and gives every-character exclusion by positivity of multiplicities. The reduction in required output is genuine: no locations, root brackets, simplicity tests or critical-line membership proofs are required. A corresponding reduction in numerical work is not yet demonstrated. In particular, directly multiplying billions of L-values is not an efficient implementation.

## 1. Exact target and a sufficient rectangle certificate

Let C be the150000 active conductors of the reviewed family. They support5,543,640,188 primitive characters. Retain

    b=111/200,
    Dc=1200000/qt(c),
    Hp(c)=ceil(200+max(1000,(704/7)Dc)).

The required conclusion is that every actual nontrivial zero of every primitive character of conductor c, with |gamma|<=Hp(c), has beta<=b. Multiplicities do not weaken this condition. Heights are inclusive.

For c>1 define the finite entire function

    F_c(s)=product_(chi primitive mod c) L(s,chi).

There is no principal primitive character for c>1. For c=1 use the source entire zetaF, including its nonzero value at the removable point s=1. Raw zeta would introduce a pole inside the rectangle and change the argument-principle integer. The certified function must match the source nontrivial-zero carrier.

Choose a rational T_c>Hp(c), initially Hp(c)+1. Form the counterclockwise rectangle

    R_c={s: b<=Re(s)<=2, -T_c<=Im(s)<=T_c}.

A sufficient record proves F_c nonzero on its entire boundary and proves the boundary winding number around0 equals0. The argument principle then counts no zeros inside, with multiplicity. Product multiplicities are sums of factor multiplicities and are nonnegative. Consequently no individual factor can have a zero with b<beta<1 and |gamma|<=Hp(c). The upper real edge2 lies beyond the critical strip; Euler-product nonvanishing can handle that edge analytically, but numerical evaluation is also permissible.

This is a stronger certificate than the required non-strict beta<=b conclusion, since it additionally excludes zeros exactly on the left boundary. Failure to prove boundary nonvanishing is not a counterexample to the desired theorem. One must not move the left edge to b+epsilon and discard the missed sliver. Horizontal edges may move upward or downward only while retaining T_c>Hp(c); that strict margin handles zeros exactly at the requested height.

The certificate counts real zeros at gamma=0 as well as both height signs. Conjugation permutes the complete primitive family, so F_c(conj(s))=conj(F_c(s)). This can reuse evaluations on reflected boundary panels. It does not justify dropping real zeros or merely doubling a positive-height count without accounting for the real axis. Character functional equations are not needed for the right-rectangle implication; they are needed later to recover the reflected finite lower bound. The uniform family premise supplies the conjugate character where necessary.

No GRH assumption enters the argument principle. Global QRH can reduce an evaluation domain if independently proved, but is not needed to know that all sought nontrivial zeros lie left of2.

## 2. A concrete checker interface without isolated roots

The recommended first implementation evaluates factors in batches but emits aggregate count certificates. It does not evaluate an enormous product as one complex floating number.

For each conductor, the record contains a checked enumeration of the primitive characters, including conductor tests and a proof that none is omitted. Split the rectangular boundary into rational panels. On every panel the record provides the following certified ingredients for each factor, or for a batch with a shared analytic error theorem:

* Taylor coefficients or another polynomial approximation to L(s,chi), with a uniform remainder bound over the whole panel.
* Rational complex vertices approximating endpoint values.
* A rational separating linear functional whose real value is strictly positive on the entire image enclosure of that panel and its endpoint approximants.

The last item puts the image in an open half-plane excluding0. It proves nonvanishing between nodes and a homotopy from the true image to the rational polygon. Endpoint evaluation alone is insufficient: a curve can wind around0 between arbitrarily close-looking endpoint values. Taylor or derivative remainder bounds must certify the entire connecting arc.

Compute each polygon's winding number by exact ray crossings and determinant signs, using a ray chosen to avoid vertices and collinear degeneracies. Sum the integers over the primitive family and accept only a sum of0. Each winding number is nonnegative by holomorphy and the argument principle, even if a numerical producer initially guessed otherwise. Hence their sum0 excludes zeros from every factor. One need not output each zero or its owning character. The c=1 record uses zetaF instead of raw zeta.

An alternative record encloses the normalized integral of F_c'/F_c in a real interval contained in(-1/2,1/2), together with a proof of boundary nonvanishing. Its integrality forces0. This version must bound quadrature and evaluation errors and avoid poles of the logarithmic derivative; naming the integral is not an implementation of those bounds.

These are sufficient, proof-producing interfaces. A practical producer would adapt panel widths and precision, then serialize the accepted rational bounds. A formal checker needs the analytic approximation/remainder theorems, exact character enumeration, the homotopy or quadrature theorem, and the argument principle. An external interval-library result is useful experimental evidence but not yet a Lean theorem or a trusted certificate opcode.

## 3. An actual batch evaluator exists, but not the complete certificate

The primary Arb2.23 documentation specifies `acb_dirichlet_l_vec_hurwitz`: it evaluates all characters at a given s using Hurwitz zeta and a character DFT. It also specifies L-function Taylor jets and Hurwitz precomputation. These are relevant producer building blocks, not a supplied proof checker for the rectangles above. The current FLINT documentation describes the successor interface, but the older explicit API is enough to identify the proposed batch computation. [Arb L-function and DFT documentation](https://arblib.org/acb_dirichlet.html), [FLINT module](https://flintlib.org/doc/acb_dirichlet/index.html).

At a contour point s, use the exact identity

    L(s,chi)=c^(-s) sum_(a=1)^c chi(a) zeta(s,a/c).

Shared Hurwitz values and the finite-group DFT give all character values, after which a checked primitive filter chooses the factors. At s=1 the apparent Hurwitz poles cancel for nonprincipal characters; use a deflated representation with a proved cancellation, not subtraction of infinite quantities. For horizontal panels, the point's real part ranges from b to2. For vertical panels it is b or2 and its height ranges through[-T_c,T_c]. Derivative or Taylor data must cover those same panels.

This removes repeated independent summation over residues. It still has phi(c) outputs per sample, so it does not establish sublinear cost in the number of characters. At c=149993 there are149991 primitive factors and Hp=1200; an aggregate contour is still a high-degree computation. A common adaptive mesh may also be controlled by the worst-conditioned factor.

The aggregate Euler identity from the previous note is exact for Re(s)>1:

    -F_c'/F_c=sum_(n>=1) Lambda(n) A_c(n)n^(-s),
    A_c(n)=1_(gcd(n,c)=1)
      *sum_(d|c,d|(n-1)) mu(c/d)phi(d).

Its divisor coefficients avoid explicit character evaluation in that half-plane. The absolutely convergent series cannot be used on Re(s)=.555. A rigorous analytic continuation of this aggregate with competitive complexity would be a genuine further reduction; no such evaluator is supplied here.

## 4. Why merely taking a product is not a speedup

Suppose a naive panel certificate has, for every factor, a relative enclosure

    |f_j(s)/f_j(s0)-1|<=rho.

The direct product enclosure only gives

    |product_j f_j(s)/product_j f_j(s0)-1|<=(1+rho)^n-1.

To use that disk to exclude0 requires (1+rho)^n<2. At n=149991 this forces rho approximately below log(2)/149991, about4.62e-6. This is a limitation of this enclosure rule, not a lower bound on the true function or on all possible algorithms. It shows why collapsing all factors into one disk can lose the apparent saving. Products can also have large dynamic ranges even when every factor is well conditioned.

Factorwise polygon homotopies avoid that relative-product loss; one sums their exact winding integers afterward. They retain essentially all factorwise boundary evidence. A more compact aggregate proof would need a stronger common analytic representation, for example a certified group-convolution inverse or determinant representation with a useful norm bound. No such norm bound is assumed here.

Complex conjugation supplies a valid symmetry, but arbitrary Galois orbits of character values do not automatically carry numerical L-values at transcendental s to one another. It is unsound to certify one representative of every character-value orbit and infer the rest without an additional theorem. Likewise, no conductor may be omitted just because its Gauss weight is small: the selected pointwise finite-strip premise requires every active factor.

## 5. What existing rigorous computations contribute

Platt's primary arXiv v1 paper gives interval evaluation algorithms and a Turing completeness method, and reports verification for moduli through400000. Its Theorem7.1 includes the common height10^8/c, with additional parity-dependent height. It reports approximately400000 core-hours and3.8e13 isolated zeros; these are historical measurements, not a forecast for our certificate. The critical-line sign and completeness approach supplies reusable numerical ideas, while the proposed right-rectangle method avoids requiring critical-line isolation. [Platt, Numerical Computations Concerning the GRH, v1, Sections3–7](https://arxiv.org/pdf/1305.3087v1).

The distinction matters formally. A published statement cannot be inserted as the `PlattGRH` input we are trying to remove. Reusing old data would require the actual data, indexing, rounding model, analytic error bounds and a replayable completeness proof. This research did not locate or validate such a transcript. The existing numerical results are neither assumed nor counted as discharged proof obligations.

The independent exact domain comparison is in `major-constants/PLATT_DOMAIN_COMPARISON_2026-11-11.md`. For the original Hp profile, only41667 active conductors, carrying1,140,703,839 primitive characters, fit the common published domain. The remaining108333 carry4,402,936,349 characters. In particular the original Hp is not automatically implied throughout by the reported historical range, even if that historical result were separately formalized. The accompanying comparison concerns heights, not runtime.

Büthe supplies a separate explicit-formula method for proving completeness of a proposed zero list for broad L-function classes. It is an alternative to a Turing completeness step, not a zero list or a certificate for this family. It is relevant if the project chooses to reuse verified critical-line lists instead of the empty right-rectangle approach. [Büthe, A method for proving the completeness of a list of zeros of certain L-functions](https://arxiv.org/abs/1308.6704).

## 6. Separate height compatibility for the base-gap consumer

The pointwise base-gap derivation does not intrinsically require the original Hp height. It also works if every active primitive character is certified beta<=.555 only through the COMMON height10^8/c. This is a separate conditional implication, not a revision of the selected major-moment profile.

Use the exact normalization from the frozen base-gap note: q is the reduced denominator of2alpha; original modulus m is q or2q; every relevant conductor c divides m, so c<=2q; q<=150000. For U<=1200000 the dynamic etaU cutoff is

    H(q,U)=max(250,ceil(242U/(7q))).

Its largest raw value is290400000/(7q). Compare it with50000000/q. Their difference is

    59600000/(7q)>=59600000/1050000>56.

Therefore even the ceiling satisfies ceil(290400000/(7q))<50000000/q. Also250<50000000/q since q<=150000. Consequently

    H(q,U)<50000000/q<=100000000/c.

Both signs and the closed cutoff are covered. The same shorter uniform certificate yields the reflected lower beta>=.445 at those low heights, so the13/8 etaU bound survives. All high-zero, contour and removal estimates in the pointwise branch are unchanged because its actual cutoff H is unchanged. The actual smoothing/GoodSmoothing and explicit-formula proofs remain obligations; this height lemma does not prove them.

The new script `resume_spectral_strategy_20261111.py` checks the rational slack and all150000 q, without computing any zeros. This removes pointwise base-gap height as an obstruction to a future height-optimized major profile. It does not show that the original major-moment tails remain acceptable at10^8/c; that is a separate analytic calculation.

## 7. A bounded next experiment and acceptance criteria

First implement a toy complete rectangle, such as conductor3 with requested height32, to validate boundary orientation, primitive indexing, pole handling and the rational winding checker. That toy does not verify the selected Hp(3), which is much higher.

Then benchmark a production-scale batch at c=149993 on a short panel of the actual left edge .555+i[1000,1001]. Record rigorous endpoint/Taylor enclosures, minimum certified modulus, required precision, panel subdivisions, wall time, peak memory and certificate bytes. Repeat the same panel with factorwise and aggregate-product enclosures. A successful panel establishes only that panel, not the full rectangle.

The decisive next milestone is one complete conductor rectangle through its actual Hp(c), with independently replayed winding0 and boundary nonvanishing. Only then estimate the full family, using measured scaling and the actual exceptional-panel distribution. No current result supports a claim that150000 product certificates are thousands of times cheaper than billions of character computations.

The present result is a sound zero-isolation-free certificate specification, an available batch-evaluation route, a quantified weakness of naive product enclosures, and a new exact base-gap height compatibility lemma. Actual right-rectangle data and the complete formal analytic checker remain unbuilt.
