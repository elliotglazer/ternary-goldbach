# Base-gap implementation interface ledger

Source pin: `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Paths below are relative to `TernaryGoldbach/`. This is a research interface plan, not author-frozen declarations, a Lean implementation, or a proof-status upgrade. Existing reports are unchanged. No compiler ran.

The reviewed pointwise base route needs two substantial bridges not exposed by existing source statements: a parity-preserving extraction from the actual major arcs, and an admissible actual etaU smoothing with its own finite-strip explicit-formula estimate. The old `gap_point` discards needed parity information. The existing generic norm-bound theorem assumes RH and cannot consume the new strip. The source does supply enough lower-level formulas to describe a directed implementation route without adding mathematical assumptions.

## 1. Source endpoint and notation contract

`MinorArcs/MinorTotal.lean:394–403` needs, for `x>=4.9e26`, `y=x/49`, and alpha in the gap,

`norm(S etaStar x alpha) <= y*ghatY(y,150000)`.

The gap is `majorArcs 8 150000 y \ majorArcs 8 150000 x`. Both arc sets use open intervals. Outside the smaller arcs therefore gives a **closed** lower distance bound; membership in the larger arcs gives a **strict** upper distance bound. The new proof targets this consumer directly, not the old `.0121*y` conclusion at `BaseGap2.lean:243`.

Keep these objects distinct throughout:

| Symbol | Type and meaning |
|---|---|
| x | Real original scale, x>=4.9e26. |
| y | Real x/49, hence y>=1e25. |
| m | Positive natural original rational modulus used for the character expansion. |
| a | Integer numerator with `IsCoprime a (m:Int)`. |
| q | Natural reduced denominator `m/gcd(m,2)` for the approximation of **2 alpha**. |
| d | Real `(alpha-a/m)*y`, physical etaU twist. |
| Delta | Real `2*d`, the normalized Approx2 twist at scale y. |
| u | Real `q*abs(Delta)=2*q*abs(d)`. |
| c | Positive natural primitive conductor, distinct from m and q. |

The source `S` convention is `sum Lambda(n)*eta(n/x)*e(n*alpha)`, `Helfgott/Defs.lean:58`. `phi(t)=t² exp(-t²/2)` at line49, `kappa=49`, and `etaStar(t)=mellinConv eta2 phi (49t)` at line55. `MinorArcs/EtaU.lean:24` defines etaU by an integral over positive w. `BaseGap2.S_etaStar_eq_expTsum:229` already gives, for x>0 and every real alpha,

`S etaStar x alpha = expTsum (n ↦ (Lambda(n)*etaU(n/y):Complex)) alpha`.

This identity does not rescale alpha or insert another factor49.

## 2. Parity-preserving gap adapter

Current `BaseGap2.gap_point:185` takes `{x alpha:Real}`, x>0, membership at x/49 and nonmembership at x. It returns positive q<=300000, an integer coprime numerator, and only

`600000/(49*q) <= abs(d) < 1200000/q`.

Here its variable q is the **original** modulus. Its proof has already obtained sharper parity-specific conclusions before deliberately weakening them. The required adapter must reuse that proof or unfold `Helfgott.majorArcs` at `Defs.lean:64`; it cannot be deduced from the old conclusion alone.

Proposed intermediate mathematical contract, in prose/pseudocode:

Given the same x, alpha, membership and nonmembership, produce m,a,d with

`1<=m`, `IsCoprime a m`, `d=(alpha-a/m)*y`, and exactly one parity branch:

- m odd, m<=150000, `600000/(49m)<=abs(d)<600000/m`;
- m even, m<=300000, `1200000/(49m)<=abs(d)<1200000/m`.

No restriction alpha in `(0,1]` is needed. The source definition allows all integer numerators. The equality `alpha=a/m+d/y` is exact on Real. Reducing a modulo m later introduces an integer translate, handled by `expTsum_periodic` as in `BaseGap2:267–282`.

Derive q=m/gcd(m,2) as a separate elementary adapter. If m is odd, q=m and use numerator A=2a for the approximation of2alpha. If m is even, q=m/2 and use A=a. Coprimality follows from the original numerator and parity. Then

`1<=q<=150000`, `2alpha=A/q+Delta/y`,

`1200000/49<=u<1200000`, and `600000/(49q)<=abs(d)<600000/q`.

Odd q has possible original moduli m=q and m=2q. Even q only has m=2q. Do not replace a/m by A/q in the character expansion: A/q approximates2alpha, not alpha.

### Raw Type I/II branch interface

`MinorArcs/TypeI.lean:60` defines `Approx2 alpha z delta_z A q Q0` by five conjuncts: q>=1, coprimality, an integer-translate equality for2alpha, `abs(delta_z/z)<=1/(q*Q0)`, and q<=Q0.

For the eta2 convolution at z=w*y, use `delta_z=w*Delta`, so `delta_z/z=Delta/y` and `delta0(delta_z)*q=max(2q,w*u/4)`. The equality/coprimality alone do **not** establish Approx2; each high-branch argument must retain its bounds on w and choice of Q0. At `Q0=(3/4)z^(2/3)`, the remaining approximation inequality is `u/y<=1/Q0`, and q<=Q0 is separate. These are already addressed by the reviewed high-branch w split but must appear in its actual proof application. Do not use the finite Mellin twist d as the Approx2 twist.

## 3. Actual etaU analytic data below the explicit formula

For each real d, write the proposed complex smoothing as

`fU_d(t)=(etaU(t):Complex)*e(d*t)`.

`MajorArcs/Cor933.lean:50`, `etaU_eq`, already gives etaU(t) for every real t as

`integral_(r>0) eta2(r)*phiPos(t/r) dr/r`,

where phiPos cuts phi off at nonpositive arguments. This result and `fourier_etaU:70` precede the finite-RH corollary and are unconditional. `MajorArcs/Eta2Moments` gives eta2 nonnegativity, compact support on `[1/4,1]`, integrability, and moments:

- `moment0:52`: integral eta2(r)dr=1;
- `moment_one:154`: integral eta2(r)dr/r<=1.92182;
- `moment_3half:176`: integral eta2(r)dr/r^(3/2)<=2.74517.

Required Mellin identity, with all integrability obligations proved, is

`Mellin(fU_d)(s) = integral_(1/4<=r<=1) eta2(r)*r^s*Gr(s,d*r,0) dr/r`.

It is valid on a half-plane at least `Re(s)>-1`; proving it on `Re(s)>-2` is natural because phi vanishes quadratically at0. Positive-real complex powers must use the source convention. The factor is r^s, not r^(s+1), and the twist is d*r, not d/r. The interval endpoints have measure zero; a single chosen interval convention avoids repeated transport. Fubini follows from the compact positive r-range and Gaussian domination in t. Holomorphy requires a local integrable majorant for the s derivative, including the log(t) factor; pointwise differentiability of Gr alone is not a proof of differentiability under the r integral.

### Admissibility and numerical vertical bounds are different contracts

`Explicit/ExplicitFormula.lean:51` defines `GoodSmoothing f K decay` with five fields:

1. continuity at every positive real t;
2. MellinConvergent at s=3/2;
3. complex differentiability of Mellin f at every s with Re(s)>-1;
4. decay>0;
5. `norm(Mellin f(s))<=K*exp(-decay*abs(Im s))` for **-1/2<=Re(s)<=3/2**.

`Explicit/GrExtend.norm_G_uniform_ext:73` has bound300 but only on **-3/2<=Re(s)<=1**. Therefore the reviewed numerical vertical bound Kv=900, based on that theorem, does not by itself provide GoodSmoothing. Its upper real-part domain is too short. This is a missing admissibility bridge, not a counterexample to the pointwise argument.

A source-faithful solution is available without changing any numerical budget. `Explicit/GMellin.norm_G_le_strip:85` covers the entire GoodSmoothing strip with constant `Kdelta(d)` and decay .28. From its integral definition at line75, positivity and `abs(d*r)<=abs(d)` imply `Kdelta(d*r)<=Kdelta(d)` for r in `[1/4,1]`. Also `r^Re(s)<=r^(-1/2)` throughout the strip. The eta2 moment gives the safe contract

`GoodSmoothing(fU_d, 3*Kdelta(d), .28)`.

Kdelta can be enormous for large d; only its finiteness and admissibility are used in the contour-limit theorem, so no numerical evaluation is needed. Its monotonicity proof must use integrability of the defining positive integrands. Continuity and Mellin differentiation are still separate fields to prove.

For the **quantitative line Re(s)=-1/2**, use GrExtend and the moment2.74517 to prove

`norm(Mellin(fU_d)(-1/2+i*t)) <=900*exp(-thetaD(d)*abs(t))`,

where `thetaD(d)=.28/(1+abs(d))`. For the full base twist range abs(d)<=600000, decay can be weakened to4e-7. This is the correct input to `ExplicitBoundGen.norm_integral_hIntG_le:32`, whose other binders are positive conductor with NeZero, primitive nonprincipal chi, Kv>=0, positive decay, and y>0. Its conclusion is `norm(vertical integral)<=y^(-1/2)*VgL(DN(c),Kv,decay)`. The formula coefficient later divides by2pi and by y, yielding y^(-3/2). The zeta case needs its own hZeta analogue, not a nonprincipal application.

### Low strip and high tail contracts

The reviewed13/8 bound must be attached to the actual fU_d:

`89/200<=Re(s)<=111/200` implies `norm(Mellin(fU_d)(s))<13/8`, for every real d and every Im(s).

Prove the endpoint moments `M_U(0)=4log(2)^2`, `M_U(1)=sqrt(pi/2)` and the weighted AM-GM inequality with positive measure etaU(t)dt/t. This is distinct from a bound for the Gaussian phi alone. It requires neither critical-line membership nor a height restriction, but applying it to a zero requires the finite reflection adapter.

For high zeros `0<Re(s)<1`, use `Explicit/ZeroSumBound.norm_G_tail:105` under the r integral. The common H must satisfy `H>=250` and `H>=22*pi*abs(d)`. Since abs(d*r)<=abs(d), all scaled twists meet the source cutoff. The prefactor is bounded using the eta2 moment by2. Prove uniform envelopes for EA and both geometric ratios over d*r explicitly; a bare claim that every source EA expression is globally monotone in d would be unjustified. The reviewed scalar argument uses the large-ratio regime H/(pi*abs(d))>=22 and the separate d=0 definition.

## 4. Primitive explicit formula, with exact zero carriers

`Explicit.explicit_formula_gen`, `ExplicitFormula.lean:988`, takes `{c:Nat}[NeZero c]`, primitive chi, `chi!=1`, GoodSmoothing f K decay, and y>0. It gives a sequence T(k) in `[k+1,k+2]` and convergence of

`sum_(rho in zerosRect chi T(k)) multRect chi T(k) rho * Mellin(f)(rho)*y^rho`

to `-SsumG chi f y -(1/(2pi))*verticalIntegral`.

`zerosRect` and `multRect`, lines298 and302, use finite analytic-divisor zeros and their natural multiplicities. The rectangle is open at real sides-1/2,3/2 and imaginary sides+-T. `ZeroSums.zerosRect_cases:159` classifies its zeros as zero itself or an actual L-function zero in `0<Re(s)<1`. The possible zero at0 is included for nonprincipal characters and must be split off before invoking the finite `.555` condition. A bound on distinct roots is not a bound on this sum.

For conductor1, use the specialized zeta formula `ZetaExplicit.explicit_formula_zeta_seq:122`. Its carrier is `zerosRectD zetaF (goodSeqD ldatum_zeta k)` with `multRectD`, and its limit is

`Mellin(f)(1)*y-SsumG 1 f y -(1/(2pi))*hZetaIntegral`.

This zeta carrier has no zero-at-zero term. Primitive principal-character detection must transport the c=1 character through the exact level equality. `MajorArcs.Prop932.ne_one_of_primitive:37` already handles primitive c!=1. For an induced character psi modulo m, `psi=1` iff its conductor is1; inversion preserves the conductor.

Proposed finite-sum estimate before limits: for every outer height T, split the nontrivial zeros into `abs(Im rho)<=H` and `H<abs(Im rho)`, with equality assigned to the low part, and keep rho=0 separate. On low zeros apply the inclusive shared height condition and reflection to `.445<=Re rho<=.555`, and bound **the sum of multRect** by the off-line Jensen count. On high zeros apply global7/8 and the etaU geometric-tail bound. For each finite sum the bound must be independent of outer T. Then continuity of norm and the source sequence limit yield

`norm(SsumG chi fU_d y - [c=1]*Mellin(fU_d)(1)*y)/y`

` <= (13/8)*N(H)*y^(-.445) +3e-14`,

under the reviewed base domains and conductor bounds. The3e-14 covers high zeros, contour and possible nonprincipal zero0. It does not include coprime removal. No reordering of an infinite zero series or uniform convergence in d is needed for this pointwise result. A separate sequence for each chi,d is sufficient because every estimate is uniform in the height before taking that limit.

Do not call `ExplicitBoundGen.norm_SsumG_le_gen:128` or its zeta counterpart unchanged: their hG premise requires finite RH, rho.re=1/2. Reuse their triangle/limit construction with the finite-strip low bound instead.

## 5. Identity, height, and character reconstruction bridges

Before using the primitive estimate, prove the exact identities

`Schar chi (n ↦ Lambda(n)*etaU(n/y)) (d/y) = SsumG chi fU_d y`,

`Mellin(fU_d)(1) = Fourier(etaU)(-d)`.

The first is finite-term algebra under the source complex casts, followed by tsum congruence. The second uses integrability and the source Fourier sign. The coefficient at n=0 is zero because Lambda0=0, so division conventions at zero cause no missing term. For absolute summability of the coefficient sequence, reuse `Helfgott.summable_etaStar` plus `S_etaStar_eq_expTsum`'s pointwise scaling proof. `EtaPlusSq.summable_SsumG:415` has a `Summable` conclusion, not literally a `Summable norms` conclusion; its proof contains a norm majorant, but that stronger statement must be extracted if used. Ordinary Summable alone is not enough to invoke the character norm APIs.

Let `H(q,U)=max(250,ceil(242*U/(7q)))`. For a u-prefix U, check u<=U, H>=22pi*abs(d), and H<=Hp(c) for every primitive conductor actually used. Original m, not reduced q, determines induction. The reviewed height inclusion uses `qt(c)<=qt(m)=2q`; a separate finite arithmetic lemma must establish that implication on the exact conductor/Gauss support. The common finite certificate includes every primitive character of c, so reflection may use its conjugate character without assuming a quartet within one complex character. Pole s=1 is excluded by `0<Re(s)<1`.

`BaseGap.coprimePart:71`, `Schar_primitive:78`, and `Schar_sub:64` give the induction/removal identities. `totient_mul_norm_le:19` requires norm-summable coefficients, coprime support, real twist d/y and a unit b in ZMod m. The source proof obtains b from a, then uses periodicity to reduce the rational numerator. `Bombieri.norm_sq_gaussSum:135` gives exactly

`norm(tau_m(psi))² = c` if m/c is squarefree and coprime to c, and0 otherwise.

A new weighted version of the character triangle bound is required. The existing `norm_expTsum_le_of_chars:93` weakens the principal term to norm(M)/phi(m) and the total Gauss mass to sqrt(m). It therefore does not directly deliver the sharp table used by the reviewed route. Retain the weights instead:

`W_m=sum_psi norm(tau_m(psi))/phi(m)`;

`norm(additive sum)/y <= |mu(m)|/phi(m)*|Fourier(etaU)(-d)|`

` + W_m*((13/8)*N(H)*y^(-.445)+3e-14) +(1+W_m)*d0`,

where d0 bounds the normalized noncoprime coefficient norm, at most2e-9. This follows by retaining the principal Gauss norm in the source expansion, applying the primitive residual estimate on supported characters, and charging removal both outside and inside the character sums. The source `BaseGap2.sum_noncoprime_le` supplies the underlying removal mechanism. Do not hide this term in the analytic3e-14 allowance.

Finally rewrite W_m by the exact supported conductor sum and count primitive characters with their actual multiplicities. For odd q prove equality of the weights for m=q and m=2q; for even q use m=2q only. The principal factor must retain `abs(mu(m))`. Finite rational enumeration or a proved analytic bound then supplies the reviewed table. Only after that step can the table be compared to the all-y lower bound for `ghatY(y,150000)`.

## 6. Dependency direction and acceptance gates

A possible dependency order, without prescribing new frozen module names, is:

1. **Geometry leaf:** Defs and elementary arithmetic -> parity gap facts, denominator reduction and exact phase relations. This leaf need not import BaseGap2's final conditional theorem, character estimates, or MinorTotal.
2. **Smoothing leaf:** EtaU/Eta2 and unconditional convolution/moment lemmas -> fU Mellin representation, integrability, GoodSmoothing, moments, vertical and tail bounds. Existing Cor933 contains useful earlier unconditional lemmas but also imports the old GRH estimate. Extract/rehouse those reusable lemmas or accept a one-way import with no call to its conditional corollary. Do not put etaU analysis below a module that already depends on it.
3. **Generic spectral estimate:** existing explicit-formula/zero-divisor APIs plus smoothing estimates -> primitive residual from explicit finite-strip and global-strip premises. These premises are local proof inputs awaiting their real providers, not permitted final assumptions.
4. **Character arithmetic leaf:** Bombieri and basic coprime norm identities -> weighted Gauss reconstruction. Prefer a lower-level extraction from BaseGap, whose current imports include LargeSieveProof, rather than making the smoothing layer import the whole minor-arc consumer chain.
5. **Finite-family application:** actual shared finite certificate and global provider -> residual and weighted pointwise bound on finite prefixes. Separate raw high-branch proofs consume the ten-producer Type I/II repairs.
6. **Final gap adapter:** geometry, finite-prefix provider, high branches, and the lower ghat comparison -> the exact hv0 gap input. MinorTotal imports this result and the off-arc provider; none of these lower layers imports MinorTotal.

The principal uncovered interfaces are now explicit: all-strip etaU admissibility; differentiated Mellin/Fubini bridge; a finite-strip rather than RH norm formula; exact source divisor multiplicity transport; zero0/pole case split; height containment and conjugate reflection; weighted Gauss reconstruction; and the stronger parity adapter. Their mathematical derivations are described above, but no proof term has been supplied. The actual finite spectral certificate and global provider validation remain separate, essential gates. Passing the scalar table cannot replace any of them.
