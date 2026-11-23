# Resumed major-average research, 2026-11-11

This report isolates a finite conductor-three task which would discharge a genuine part of the corrected major-arc budget. It does not prove that finite task. No Lean build, source edit, axiom or sorry was used. The target source remains commit 23b2d68ca344203d4384e0aff7affa4ec034bef9.

The primary budget remains J<=10, coprime Aplus<=5e-7 and coprime Astar+Cross<=9.5e-7. With the reviewed removal allowances these preserve major>=1.0404, minor<=1.0376 and nonprime<.00271. None of the historical budgets which omitted nonprime loss is used here.

## New quantitative route

For the unique primitive character chi modulo3, prove the finite nonvanishing statement

    L(s,chi) !=0 when 16/25 < Re(s) <=7/8 and |Im(s)|<=14,000,000.       (F3)

Together with the genuine global7/8 provider, a translated-mass lemma and the actual-smoothing Gram lemma below, this would imply

    Aplus_coprime[primitive conductor3] <8e-8,
    N[primitive conductor3] <.029.

The Aplus bound covers every inducing modulus in Qset150000, not merely q=3. N is the nonprincipal energy used in the J<=10 split Ep<=1e-4,N<=1.23. Thus this block would leave Aplus<=4.2e-7 and N<=1.201 for other conductors. It does not bound Astar or Cross.

A second route uses only the existing Dirichlet Jensen counts in place of the new translated-mass lemma: replace16/25 in(F3) by3/5. It still needs the new smoothing Gram lemma. This is an explicit tradeoff between analytic infrastructure and the strength of a finite spectral certificate.

No computation certifying(F3), nor the stronger3/5 version, has been performed. These statements are future proof tasks, not additional permitted assumptions in the target theorem.

## Exact conductor weights

Write x>=x0=4.9e26 and U(delta)=Fourier(etaU)(-delta/49). Define the primitive normalized residual

    e3(x,delta)=SsumG chi (fP delta) x/x.

There is no principal pole term. Chi is real, hence its inverse is itself. For squarefree q=r or2r with r odd, conductor3 contributes only when3 divides r. The Gauss norm squared is3 exactly in this case. The coprime correction apart, the Aplus block is

    integral W3(delta)|U(delta)|^2|e3(x,delta)|^2 ddelta,
    W3(delta)=6 sum_(r odd squarefree<=150000,3|r, |delta|<=600000/r) phi(r)^(-3).

It is supported on[-200000,200000]. Since r=3s with(s,3)=1,

    W3 <=(3/4) product_(odd prime p!=3)(1+(p-1)^(-3)) <=64/81.

For the last inequality use the reviewed elementary product bound product_(odd p)(1+(p-1)^(-3))<=32/27, and remove the p=3 factor9/8. The product may be enlarged before applying this argument. Gauss weights have been applied once, with no invented conductor square-root saving. The formulas agree with Bombieri.lean:27-29,78-81,135-138 and the conductor reduction recorded in integration/MAJOR_RESIDUAL_FIRST_BLOCK.md.

The pointwise character correction from the primitive sum to its q-coprime restriction is at most1e-15 after division by x: multiply each removed coefficient by chi(n), whose norm is<=1, and apply ArcChars.coprime_split (ArcChars.lean:298). This is the character version of the proof at ArcChars.lean:314; that displayed theorem itself is stated for the untwisted exponential sum. The norm triangle inequality and its existing summability facts justify the extension.

## Translated mass excludes a previously plausible cluster

For the completed odd primitive L-function

    Lambda3(s)=(3/pi)^((s+1)/2) Gamma((s+1)/2)L(s,chi),

its symmetric logarithmic-derivative expansion gives, for every finite collection of its actual nontrivial zeros with multiplicities,

    sum m(2-beta)/((2-beta)^2+(gamma-t)^2)
      <=Re(Lambda3'/Lambda3)(2+it)
      <=2+(1/2)log(1+|t|/2).                                  (M3)

The upper estimate needs no zero information. The conductor term .5log(3/pi) is negative. The Euler product gives |L'/L(2+it)|<=sum log(n)/n^2<1, using n>=2 and the first two terms plus the integral from3. The digamma series gives

    Re psi(3/2+iv)<=psi(3/2)+2/3+.5log(1+v^2/(3/2)^2)
                  <2+log(1+|v|).

Its summand decreases and is bounded by its first term plus its integral. See mellin/RESUME_PRINCIPAL_2026-11-11.md section1 and DLMF5.7.6 for the series. The bound psi(3/2)<1 follows from its recurrence and psi(1/2)=-EulerGamma-2log2.

The first inequality in(M3) is an analytic bridge still to formalize. The inspected source XiPartial.xi_partial_approx at line776 is zeta-specific and cannot simply be instantiated for chi. For this real character, adapt its symmetric contour proof to Lambda3, using the primitive functional equation and the source polynomial growth/good-height estimates. Alternatively prove its paired Hadamard logarithmic derivative. Positivity permits dropping other zeros. This report does not claim that a compiled Dirichlet analogue already exists.

This extra information matters. A hypothetical quartet at beta=7/8,1/8 and heights+-15 with multiplicity6 has total mass at2 about.158126, and fits the coarse source Jensen disk counts. At t=15 its two positive-height locations alone contribute

    6*(8/9+8/15)=128/15>8.53,

whereas(M3)<3.5. Thus the earlier proposed cluster is excluded by actual translated-L information. It is not an obstruction to the complete QRH route. Bounds at one center and generic Jensen bounds alone miss this restriction.

## Local counts and the Gram operator

Under the global strip and reflection,1/8<=beta<=7/8. On |gamma-t|<=1.74 each summand in(M3) is>=.26. This follows by checking the endpoints a=9/8,15/8 in a-.26(a^2+1.74^2)>=0. Since log(1+(14,000,010)/2)<16, every3.48 window in the relevant range has multiplicity<39. Consequently

    Nlow<39*(28,000,000/3.48+2)<320,000,000.

The Mellin worker derived, for the actual bandlimited etaPlus,

    |mellin(etaPlus^2)(sigma+i tau)|<=min(4,428/(25/16+tau^2)),
    -3/4<=sigma<=3/4.                                         (G)

This is paper mathematics, not a compiled lemma. Its proof uses the genuine Fourier-projection norms ||h||2<2, ||h'||2^2<=19.5, ||h''||2<19.2, followed by two integrations by parts. Those analytic bridges are itemized in mellin/RESUME_PRINCIPAL_2026-11-11.md section3. The compact etaO is not substituted for etaPlus.

Full-line Plancherel gives the finite-sum Gram entry at sigma=beta+beta'-1 and tau=gamma-gamma'. With multiplicities expanded as repeated indices, the39-per-window count yields the row and column bound

    78*(16+428/(3*3.48^2))=16401112/7569<2200.

Use four near-distance bins with bound4 and sum_(j>=4)j^-2<=1/3. The Schur inequality therefore gives, uniformly in every x and all its phases,

    integral_R |sum_low m x^(rho-1)M_plus(rho,delta)|^2 ddelta
       <=2200 sum_low m x^(2beta-2).                           (S)

Multiplying the norm by ||U||infinity<=1.2534 is valid. This does not assert a pointwise comparison between weighted and unweighted off-diagonal Gram entries.

Under(F3), the right side is<=2200*320,000,000*x^(-18/25). Since x0>exp61, exact rational Taylor comparisons prove the U-weighted low norm<.00031 and the unweighted low norm<.00025, for every x>=x0. No endpoint phase or oscillatory monotonicity assumption is used.

A more flexible finite spectral certificate could instead prove the density moment

    sum_(|gamma|<=14m) m x0^(2beta-2) <=961/34562254320000.       (D3)

Each summand decreases with x, so(D3) is uniform beyond x0. This suffices for the same .00031 norm allocation. The script prints diagnostic common-beta count allowances: approximately458million atbeta.64,615 at.75,1.319 at.8, and.000131 at.875. These are sufficient-method allowances, not necessary restrictions on actual zeros. A different weighted kernel could permit more high-beta zeros.

## High tail and explicit-formula remainders

This calculation uses Dirichlet BP3, not the zeta-only BPz2. Source ZeroSums.lean:17 defines

    BP3(T)=1400*3^9*4*(|T|+22)*(1.25(|T|+11))^10.

ExplicitBoundGen.polyDatum_L at17 supplies kappa=11. At T0=14m exact checks give Z3g(BP3,T0)<180 and c3g(11,T0)<4e-6. EtaPlusMellin.norm_mellin_fP_tail at286 applies on every |delta|<=200000. Its genuine bandlimit200 is retained. Set u=(T0-200)/(pi|delta|); then u>22.2 when delta!=0. The actual source EA and EB bounds give

    EA<5e-21, EB<1e-100,
    (1-rhoA)^(-1)<100000, (1-rhoB)^(-1)<100000.

The source4.4-height window geometric sum is<37million. With Cg*(2aH)<130, the total high-zero Mellin coefficient sum is<3e-11. GlobalQRH supplies x^(beta-1)<=x^(-1/8). The U-weighted tail norm is therefore<1.2e-11 on the400000-long interval. This remains uniform along the explicit formula's finite good-height sequence.

For the vertical remainder use ExplicitBoundGen.VgL at28 and norm_integral_hIntG_le at33, DN3<20, Kv<105394 and thP(delta)>=1e-6. After division by x its size has x^(-3/2). To avoid depending on a separate odd-parity zero-at-zero proof, retain the source's possible zero-at-zero term: Z3g(BP3,0)<50 and |M_plus(0)|<39000. The combined weighted norm of both remainders is<1e-14 by exact scalar estimates. This is deliberately loose.

The good-height limit and finite-sum estimates pass to L2 via Fatou; no exchange of an unproved absolutely convergent full-line zero expansion is needed. The full-line estimate is used only for the finite low set; the high tail is controlled on the actual bounded twist interval.

## Final arithmetic and source-only fallback

The normalized primitive U-weighted norm is less than

    n3=.00031+1.2e-11+1e-14.

Using |z+d|^2<=1.01|z|^2+101|d|^2, the exact all-inducing coprime block bound is

    1.01*(64/81)*n3^2
       +101*(64/81)*400000*(1.2534)^2*1e-30
     =12132625940082776143921003/158203125000000000000000000000000
     <8e-8.

The displayed equality refers to the rational upper expression, not the actual block. Its decimal is approximately7.6690178782e-8. For N, at most300000 moduli each have Gauss/phi weight at most3/2 for the single conductor-three lift. The unweighted norm including tiny remainders/removal is<.000251. Thus N3<300000*(3/2)*.000251^2<.029. This intentionally avoids needing a sharp induction Euler product for N.

Without(M3), apply the already source-proved sum_multRectD_le (ZeroSumGen.lean:59) using radius2.7 and BP3. Exact arithmetic gives fewer than156 zeros per3.48 window, total<1.3e9, and Gram row<8800. A finite beta<=3/5 rectangle through14m then gives the same .00031 allocation. It is a useful fallback if constructing the completed-L mass identity is more expensive than moving the certified rectangle's left edge.

## What remains, and a concrete certificate design

The next decisive numerical-analytic proof task is a zero-free rectangle for the actual chi3 L-function, with boundary nonvanishing and winding count0 to the right of16/25 (or3/5 for the source-Jensen fallback). This L-function is entire and nonprincipal, so there is no zeta pole to remove. One may count on the closed rectangle [16/25,2] times[0,14m], which is slightly stronger than(F3), or use a left edge strictly above16/25 together with a limit. Negative heights follow by conjugation. The real bottom edge is positive for real sigma>0 from the grouped alternating progression series sum_k((3k+1)^(-sigma)-(3k+2)^(-sigma)); the right edge follows from the Euler product. Top/left edges and winding number require certified enclosures, not sample values. Euler--Maclaurin/Hurwitz-zeta evaluation with proved remainder and reusable subdivisions is a possible implementation; its runtime and certificate size have not been measured.

For a more selective certificate, enclose all zeros to the right of1/2 in finitely many rectangles and give complete argument-principle counts. Bound each rectangle's beta by its certified right endpoint and insert its count into(D3). This can tolerate a small number of beta around.8, whereas the all-zero(F3) route cannot. Completeness and multiplicities are essential; checking a list of approximate zeros is insufficient.

Even a completed conductor-three certificate leaves conductor1, all other primitive families, and the mixed Astar/Cross estimates. Zero_sum's new induction operator ||T||^2<25 can organize Cross in conductor-L2 density moments, but it does not turn this single second-moment bound into a fourth-moment bound. No claim of full major-arc closure is made.

Reproducibility: run `python work/qrh-campaign/agents/major-constants/resume_major_c3_20261111.py`. Its Fraction assertions and positive exponential Taylor sums passed; JSON records exact scalar results. Printed common-beta tables are floating diagnostics only. Neither script nor note establishes(F3), the Dirichlet Hadamard bridge, the actual-smoothing Gram theorem, or a Lean theorem. These obligations are separately identified above.
