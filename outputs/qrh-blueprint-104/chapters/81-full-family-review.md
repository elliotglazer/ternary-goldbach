# Independent full-family moment review

Research review, 2026-11-11, against ternary-goldbach source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical source edit.

## Verdict

The proposed sufficient-condition argument passes this bounded mathematical and source review. In particular, the mixed estimate uses genuine fourth-moment control, the star scaling factor 49 is present, and the final joint remainder allowance can be proved without assuming J<=10. No blocking defect was found in the reviewed formulas or exact scalar calculations.

The common finite condition is **unproved**: every active primitive character must have every nontrivial zero with |gamma|<=Hplus(c) in beta<=111/200. The global QRH/reflection strip is also needed. These are different inputs: global beta<=7/8 does not supply the finite beta<=.555 assertion. The argument is a quantitative conditional implication, not a newly discharged analytic input to Goldbach.

The new analytic bridges, finite character enumeration, scalar certificate replay and actual spectral certificate all require Lean proofs. No finite zero calculation was performed here. No assertion is made that this workload is cheaper than certifying the original finite-RH input.

## Smoothing and Gram bounds

The etaPlus kernel is the actual squared smoothing, not etaO substituted for etaPlus. The previously reviewed projection argument gives

    |Mellin(etaPlus^2)(sigma+i*t)| <= min(4,428/(25/16+t^2)),
    -3/4 <= sigma <= 3/4.

At a pair of zeros sigma=beta+beta'-1, so the reflected global strip is exactly enough. Four near windows on each side and the tail sum sum_{j>=4} j^-2<=1/3 give the new row bound

    800*(16+428/(3*3.48^2)) < 23000.

For etaU, I independently checked the new Gaussian-mixture derivation. The positive measure eta2(r)dr/r on [1/4,1] has mass 4 log(2)^2<2. In the squared mixture, A=(r^-2+s^-2)/2 lies in [1,16] and r^-2*s^-2<=A^2. For k=sigma+4 in [13/4,19/4], the component's zero-frequency integral is

    (1/2)*r^-2*s^-2*A^(-k/2)*Gamma(k/2) < 9/2.

Here A^(-sigma/2)<3; also Gamma(k/2)<3 follows by splitting at 1, bounding the lower integrand by 1 and the upper by t^2 exp(-t). Integrating both measures gives 18.

For H(u)=exp(k*u-A*exp(2u)), the derivative coefficients are

    H'' = [k^2-4(k+1)A exp(2u)+4A^2 exp(4u)] H.

Gamma recurrence after taking absolute values gives integral |H''| <=4k(k+1) integral H <=109.25 integral H. Thus integrating H-H'' twice by parts gives the numerator 18*(1+109.25)=1984.5<1985 and

    |Mellin(etaU^2)(sigma+i*t)| <= min(18,1985/(1+t^2)).

The endpoint terms vanish because k is uniformly positive at the left endpoint and Gaussian decay controls the right endpoint. Positive mixture integration and Gaussian domination supply the needed Fubini/derivative integrability arguments; these remain formalization tasks. The row calculation

    800*(72+1985/(3*3.48^2)) < 102000

is valid. Plancherel is first in the physical star twist d. The target uses d=delta/49, so its Gram integral is multiplied by 49, giving **Ks=4998000**. There is no missing Fourier 2*pi or scaling factor in this convention.

The pointwise plus transform bound <3.95 follows from source `Explicit/EtaPlusMellin.norm_fP_le` and the previously checked generic GaussianEnvelope lemma. For 0<=beta<=1, weighted AM-GM bounds t^beta by (1-beta)+beta*t, and the two Gaussian moments give the stated constant. The actual etaPlus wrapper remains to be integrated formally. The star pointwise bound <4 follows from the positive mixture moment <2 and Gaussian Mellin moment <2 throughout the strip; it is uniform in real twist.

For P(delta), `MajorArcs/EtaCirc.lean:18,30` supplies etaO(t)=(t(2-t))^3 exp(-(t-1)^2/2) on [0,2]. Its L1 norm is at most integral_0^2 (t(2-t))^3 dt=32/35. The pointwise Fourier-tail bridge adds the full noncompact error .00221*integral_0^infinity t exp(-t^2/2)dt=.00221. Consequently |P|<=641547/700000<.917<1. This uses the stronger source-derived pointwise bridge, not the source's L2 smoothing approximation alone.

## Carriers, counts and arithmetic weights

All active conductors are retained, including conductor one. The local primitive-character counts a(p)=p-2 and a(p^k)=p^(k-2)(p-1)^2 imply no primitive characters when v2(c)=1. The scripts enumerate 150000 active conductors and 5543640188 primitive characters. Their finite enumeration is exact external arithmetic, not a certified Lean enumeration.

The Hplus/Hstar cutoffs coincide in both scripts. Because an admissible induction q=c*r has squarefree r coprime to c, its target twist width is at most the conductor width. Thus the conductor-dependent tail cutoff covers every induced modulus. Jensen counts include multiplicity, both ordinate signs and the window enlargement. The shared 400-per-window bound yields the exact ceiling counts used in the scripts. Repeated zero indices in Schur preserve multiplicities; no spacing or simplicity is assumed.

The source Gauss formula is used once: |tau_q(psi)|^2=c precisely when q/c is squarefree and coprime to c, and otherwise zero. Inversion preserves conductor and permutes the primitive characters. Each primitive character induces once. Both replays independently check sum_{eligible c} c*a(c)=phi(q)^2 for every active q.

For Aplus/Astar, mu(q)^2 restricts q to squarefree moduli. Pairing q=r and q=2r, with r odd squarefree, gives exactly 2c/phi(r)^3 per character. The scripts' Splus/Sstar sums have this weight. For nonprincipal N the weight is c/phi(q), on the exact induction support, excluding conductor one. No extra conductor or Gauss suppression has been inserted.

Actual arc windows remain present until a nonnegative integral is bounded by the full-line integral. This enlargement is legitimate; it is not an assertion that every arc has equal length.

## Genuine fourth moments and all-scale validity

The direct mixed estimate bounds the plus leg in L2 and the star leg pointwise. Multiplying the resulting Aq and Bq retains two independent character indices. It gives Cmix<6.794e36 and, under b=.555, Cross_low<1e-9.

The factor-25 route also checks independently. Writing W_c=(c/phi(c))*sum_chi |z_chi|^2, the inequality integral P_c^2 <=sup(P_c)*integral P_c gives

    integral W_c,+^2 <=(c*a(c)/phi(c))^2 *3.95^2*23000*Nplus(c)^3*x^(4b-4),
    integral W_c,*^2 <=(c*a(c)/phi(c))^2 *16*4998000*Nstar(c)^3*y^(4b-4).

These are actual fourth-moment inequalities. Summing conductors and applying integral Cauchy-Schwarz gives I_low <=sqrt(Cp4*Cs4)*(xy)^(2b-2). The exact integer square-root ceiling in the script bounds the rational upper product. At b=111/200 the comparison I_low<1e-8 is valid, hence Cross_low<2.5e-7 through the previously reviewed operator norm squared <25. That operator retains its p=2 restriction, powerful-part support and actual output arc projection.

Every coefficient bound is uniform in the phases of x^(i gamma). The powers decrease with x>=x0 because b<1. The proof does not evaluate a signed zero sum only at x0 or assume the actual residual is monotone. The same finite condition covers Hstar because Hstar<=Hplus. The separate b=.557/.5573 optimizations for second moments and b=.58 direct-Cross calculation are not silently substituted for the common b=.555 condition.

## Full error ledger and absence of a J circle

The high-zero estimate uses the existing hybrid source-tail calculation under global QRH. Vertical contours and zero-at-zero residues are handled separately, with per-character normalized allowance <1e-18. Source `ExplicitBoundGen.VgL`, `ExplicitFormula.DN`, and `GrExtend.norm_G_uniform_ext` have the constants and real-part domain used in the new estimates. For star, the vertical mixture moment at real part -1/2 is <3, so Kv<=900 is consistent. The GoodSmoothing/etaU explicit-formula construction is a remaining substantive analytic bridge; a vertical estimate by itself does not establish it. The contour ending at -1/2 crosses zero at zero, which is retained. Trivial zeros further left are not silently part of the nontrivial-zero sums.

The primitive-to-coprime bounds 1e-15 and 1e-12 extend the source omitted-coefficient bounds through |chi|<=1. The source `ArcChars.coprime_split` and `ArcCharsStar.coprime_split_star` occur before the later local Platt binders. Their raw estimates do not require PlattGRH. Adding the tail and contour/zero0 allowances gives dplus<2e-15, dstar<2e-12. This is distinct from the final coprime-to-full additive-sum transfer.

The final joint appendix resolves the formerly open mixed contour/removal allowance without assuming J. The finite plus energy summed over q is <.001+.0002^2<.002, using nonprincipal N and the principal Ep weight. For star, Nstar<3e8, the Gauss identity and sum_q phi(q)<=9e10 give integral sum_q Lstar<10000. The two-character product-vector perturbation is therefore bounded in its actual direct-sum Hilbert norm by

    dplus*sqrt(300000*10000)
      +dstar*sqrt(300000*.002)
      +dplus*dstar*sqrt(3.24e22) <2e-10.

Both independent character indices and all error cross terms are included. These per-character allowances already include high zeros, so the separate 6e-9 high-tail norm must not be added as if it were an unaccounted error. The older sharp Euler estimate conditional on J is unnecessary for this version.

It follows conditionally that Cross_coprime<(sqrt(2.5e-7)+2e-10)^2<7e-7. The second-moment caps give Astar_coprime<2.5e-7, hence the corrected Astar+Cross<=9.5e-7 allocation is respected. The other second-moment targets Aplus<=5e-7, N<=1.23 and Ep<=1e-4 also pass. This review does not itself close any remaining lower-energy consumer, minor-arc input, global provider integration or final Goldbach declaration.

## Evidence status

Both exact scripts were independently replayed with writes redirected into this audit directory. Their numerical JSON fields matched the authors' outputs; only the mixed runtime field was excluded from equality. Appended final assertions and hashes are recorded below after the final freeze. Decimal thresholds are diagnostics, whereas acceptance comparisons use rational/integer arithmetic. I additionally checked a rational Taylor upper certificate for exp(1)<2.7182818286, making explicit the exponential upper bound used in the endpoint-log comparisons.

The remaining work is not numerical rounding: it includes proving the finite spectral condition, constructing its completeness certificate for the actual L-functions and multiplicities, proving and integrating the listed actual-smoothing analytic bridges, formal replay of finite enumeration and arithmetic, and checking exact consumer types and axioms. No new axiom, sorry, draft import or sealed theorem was introduced by this review.


### Final frozen replay

Both final scripts, including the no-J mixed remainder assertions, completed independently with exit code 0. All numerical output fields matched the frozen JSON (runtime excluded). Audit-directory `*-independent.json` and `*-independent.log` files retain the replays.

| File relative to agents | SHA256 |
|---|---|
| major-constants\RESUME_FAMILY_CAPS_2026-11-11.md | 2990B5B5D7ABA1B8262FB18800CA5CE61DC347B7C5748405A5886D9EE45BBAF3 |
| major-constants\resume_family_caps_20261111.py | 01354A3F7FD1F6760A4C7EE8D5F573B84F003494B05D59E9F1BC71A32B21D678 |
| major-constants\resume_family_caps_20261111.json | 5F5B43C23BD45FC3850602700CF541294049892D562FC17AD506278C6E847BEC |
| zero-sum\RESUME_FAMILY_MIXED_2026-11-11.md | 5E7FB33EDF2A65F058DC605A3054FE37DFDF14E9ACDCB8409A8211DCF1F9D09D |
| zero-sum\resume_family_mixed_20261111.py | A4D698D2499FE8C2A6CA523C9AB7F72E767BB3952360FFA9723303043005DA1E |
| zero-sum\resume_family_mixed_20261111.json | 5AB746D38F112CF8A5C3BA86EDC5104242FA9E0F46FB51BEB5CA75FB7D0C4041 |
