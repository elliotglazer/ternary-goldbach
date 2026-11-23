# Independent radial Fourier separation-envelope review

2026-11-11. **PASS within the bounded source/mathematical scope below; no correction requested.** I independently read the full frozen author report `zero-sum/QRH_RADIAL_FOURIER_ENVELOPE_AUDIT_2026-11-11.md`, SHA256 `EE7C7B00310ED151CAD460CE31D36A725E128681201B5959D607691DD8FD1D3D`, after reconstructing the source argument. All eight author source hashes match. The substantive derivation and stated limitations agree with the direct checks below.

Source baseline: `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`. No Lean build, source modification, numerical function evaluation or numerical integral was performed. The review is mathematical source reasoning, not validation of the global QRH provider.

## 1. The actual kernel and Euler derivatives

I independently read `GaussSum/SexticRadialPoisson.lean:230–318,426–430`, `Poisson/RadialFourier.lean:70–144,177–424`, and the separation implementation. The kernel is

    F_W(x) = paperFourier(z -> W(|z|^2))(sqrt(x)),
    paperFourier(f)(u) = (2/sqrt(3))*Fourier(f)(paperFrequency(u)),
    paperFrequency(u) = (2i/sqrt(3))*conjugate(u).

The prefactor and conjugation are present in the actual definition. The real ray therefore has frequency norm squared 4x/3 when evaluated at sqrt(x), x>=0. Ordinary Fourier decay is not transferred by pretending the frequency is x.

`radialTestCLM` composes a real Schwartz function with |z|^2, using the polynomial growth and properness estimate |z|<=1+|z|^2. Plane Fourier transform and restriction to the nondegenerate real frequency ray are continuous linear maps on the relevant Schwartz spaces. Their composition, including 2/sqrt(3), gives a real Schwartz function G_W satisfying F_W(x)=G_W(sqrt(x)). This construction uses the restriction map's explicit lower-growth estimate; unrestricted pullback of a Schwartz function would not suffice.

Define E(F,j,x)=D_t^j F(x*exp(t)) at t=0, as in `Fourier/PositiveLogProfiles.lean:264`. The chain rule along sqrt(x)*exp(t/2) gives

    E(F_W,j,x) = H^j(G_W)(sqrt(x)),   H(g)(u)=(u/2)*g'(u).

`RadialFourier.lean:190–227` proves the iterated identity by induction. It works for x>=0, including x=0; the envelope itself uses R>0 and only evaluates F at positive arguments. The proof does not need ordinary smoothness of F_W at zero, or an unjustified assertion that an arbitrary sqrt-profile is smooth there. ContDiffOn on (0,infinity) is separately established.

For each A,j, the elementary split x<=1 versus x>1 bounds (1+x)^A|H^jG_W(sqrt(x))| by 2^A times the sum of its zeroth and 2A-th spatial Schwartz seminorms. The finite family of continuous linear maps W -> H^jG_W, j<=K, is controlled by a finite supremum of source seminorms (`:358–405`). Thus the source really provides, with constants selected before W and x,

    (1+x)^A |E(F_W,j,x)| <= C * sup_{s in S} p_s(W),   j<=K, x>=0.

Specializing W yields the CF used by `paperRadialFourier_euler_bound`. Its dependence on W is not removed; neither a uniform bound for all Schwartz inputs nor a uniform constant for unbounded derivative order is claimed.

## 2. Compact logarithmic cutoff and source seminorm bound

The envelope at `QuadraticSieve/IdealQuotients.lean:305–436` takes a finite index type, arbitrary complex functions V_j with support windows |y|<=M_j, M_j>=0, real slopes a_j, and fixed natural A,J. The V_j need not be smooth or measurable: for each fixed tuple y they are only scalar factors in the integral variable t.

Put T=sum_j |a_j|M_j, L=T+1, m=exp(-L), and p=volume.integrablePower. A smooth scalar cutoff V equals one on [-T,T] and has support in [-L,L]. Its derivatives through K=J+p have a common finite bound CW and vanish outside that larger interval. `Mellin/LogProfiles.lean:1230–1300` proves the derivative-support assertion using support_iteratedFDeriv_subset, rather than inferring it solely from pointwise support of V.

For R>0, g_R(s)=V(s)F_W(R*exp(s)) is compactly supported and smooth, hence Schwartz. On any active derivative of V,

    m*(1+R) <= 1+R*exp(s),   |s|<=L.

The Leibniz sum and the Euler bounds give, with S_R=m^A(1+R)^A,

    S_R * |D^n g_R(s)| <= D_n,
    D_n=sum_{i=0}^n binom(n,i)*CW*CF.

If all derivatives of V through n vanish at s, the Leibniz sum instead proves D^n g_R(s)=0. Thus multiplying by |s|^k is safe also outside the support. `PositiveLogProfiles.lean:366–510` derives

    S_R*p_{k,n}(g_R) <= L^k*D_n.

Consequently the source's nonnegative finite constant

    P=sum_{n=0}^{J+p} (1+L^p)*D_n

dominates S_R*(p_{0,n}(g_R)+p_{p,n}(g_R)) for every required n. All quantities in P and m are chosen before R. This is the concrete uniformity mechanism; it pays m^(-A), and does not assert that widening the support window has bounded cost.

## 3. Weighted L1 and pointwise bounds

I read the complete transfers in `Mellin/LogProfiles.lean:785–913,1113–1186`, not merely the final invocation. Set

    Vp=2^p * integral_R (1+|t|)^(-p) dt.

The integral is finite by the definition and theorem for integrablePower; no numerical choice p=2 or p=3 is silently made. Source derivative integrals are bounded by Vp times the paired seminorms. The Fourier differentiation estimate with Fourier derivative order zero yields

    S_R*p_{k,0}(Fourier(g_R)) <= 2^k*(k+1)*Vp*P.

Applying the same spatial-moment integral bound to Fourier(g_R), at indices 0 and J+p, proves the source's coefficientMomentBound(J,P). The two moment bounds at 0,J and (1+|t|)^J<=2^J(1+|t|^J) yield the weighted L1 constant B. All integrability requirements are discharged from the actual Schwartz functions; a totalized nonintegrable integral is not used as a bound.

`IdealQuotients.lean:267–297` separately combines the Fourier seminorm bounds at 0 and J into the pointwise constant Bpoint. Both desired inequalities follow with the single constant

    C=(B+Bpoint)/m^A,
    (1+R)^A integral (1+|t|)^J |b_R(t)| dt <= C,
    (1+R)^A (1+|t|)^J |b_R(t)| <= C,

where b_R=Fourier(g_R). The denominator is strictly positive. Zero input W, zero slopes, empty index type, A=0 and J=0 cause no division by a zero seminorm, window length or slope. R=0 and negative R are outside this theorem and are not supplied by continuity without a separate argument.

## 4. Reconstruction and consumer quantifiers

Schwartz Fourier inversion gives g_R(s)=integral exp(2*pi*i*t*s)b_R(t)dt. The source `logPhase` has this positive inverse-transform sign. If the product of the V_j(y_j) is nonzero, its support hypotheses ensure |sum a_j y_j|<=T, so the cutoff equals one. If that product is zero, both sides vanish. Multiplication of exponential phases turns the one-variable inverse transform into the stated product separation. This is equality with a complex density, not a positivity assertion about b_R.

The entry statement selects C before R and b_R after R, but before all y. It does not state that one fixed b works for all R. The stronger consumer in `Descent/FirstProfileUniform.lean:124–156` is also valid: it first applies the envelope to a fixed indicator box, then the SAME b_R reconstructs every family supported in that box. This step is justified by multiplying the box identity by the new scalar product on its active set. It does not exchange an existential b with an arbitrary universal window parameter. `translated_box` at :158–167 puts translated windows in the enlarged M+B box.

The cubic adapter `CubicSieve/KernelEnergy.lean:622–653` requests order J+2 before dividing by (1+|t|)^(J+2) to obtain its fixed positive majorizing density. It does not infer a J+2 tail from an order-J bound. This review checks that adapter only, not the subsequent arithmetic kernel factorization or cubic improvement.

## 5. Remaining scope

The direct source implications above contain no identified local defect. They depend on the standard Schwartz Fourier transform and inversion, continuous pullback/multiplication/differentiation on Schwartz spaces, the smooth cutoff theorem, Fourier derivative estimates and finite seminorm control of continuous linear maps. The source contracts and the principal relevant mathematical formulas have been checked, but this is not a fresh proof of every Mathlib foundation.

The inspected auxiliary Mathlib source is the cached checkout at `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`, revision `56a005855ea17e0b0958f73ec801ae140b0a1679`; OAI requests a different manifest revision. In particular, the checked APIs are `SchwartzSpace/Basic.lean:909` (proper temperate pullback), :1098 (integrated derivative moment bound), `TemperateGrowth.lean:485–491` (integrablePower), and `FourierTransformDeriv.lean:731` (Fourier derivative estimate). No compatible elaboration is claimed.

This result does not validate masked Poisson identities, the arithmetic Gauss kernels, global energy induction, or QRH. It audits the radial separation and its uniform analytic envelope only.

## Source evidence

The eight whole-file OAI hashes in the author report were independently checked; their equality binds the source ranges cited here without enlarging the reviewed scope to every declaration in those files. The explicit weighted-integrability proof in `GaussSum/CubicNormalization.lean:424–458` and the density definition/integrability at `CubicSieve/KernelEnergy.lean:603–622` were also read: the former compares with two integrable Schwartz moments, while the latter's J-weighted integrand is exactly (1+|t|)^(-2).

Additional cached Mathlib sources inspected for their actual contracts are pinned below. These checks do not establish compatibility with OAI's requested Mathlib revision.

| Cached Mathlib source | SHA256 |
|---|---|
| `Analysis/Distribution/SchwartzSpace/Basic.lean` | `5B10BF48B6A1C4AEC5EF05AC756599D80E6A6F4D4EDDBE387D159A9C7ACC5A4D` |
| `Analysis/Distribution/TemperateGrowth.lean` | `8C87B41990EC60B2F5CB39C7AB1F75AD297DF721BE556A1E6D5E9041D0976346` |
| `Analysis/Fourier/FourierTransformDeriv.lean` | `7757D9F2D70A699CB2602502BBEDF14A48444F475E60901C5B1BFCD5F4B48F7C` |
