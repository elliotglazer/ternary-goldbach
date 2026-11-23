# A wider finite real-part profile at large conductors

2026-11-11. Conditional paper implication with small exact rational checks. No finite zero assertion, evaluator run, prime/conductor scan, Lean build, source edit, or strategy adoption is made.

Keep every currently selected height unchanged. The following finite upper-real-part profile suffices for all the current major, J, cubic, and pointwise base-gap consumers:

`b(c)=111/200=.555` for `c<=100000`, and `b(c)=113/200=.565` for active `c>100000`.

The condition is inclusive: every actual primitive nontrivial zero at `|Im rho|<=Hcert(c)` must satisfy `Re rho<=b(c)`. The global reflected QRH strip remains in force. This is a weaker finite location requirement, not a proof that it holds or that verifying it is cheaper. In particular, it does not permit omitting a primitive character. The separate proposal to shorten heights has not been combined with this profile.

The main numerical check is

`Astar_coprime+Cross_coprime < .000000936859032001 < .00000095`.

The high-conductor pointwise base-gap branch is below `.0026`; the older low-denominator branches remain unchanged. The unweighted star term used in the final removal step increases from 10001 to 32401, and the exact removal calculation still gives the same final full-sum caps and major lower bound 1.0404.

## 1. Fixed domains and inherited proof inputs

The source is `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Active primitive conductors are odd `c<=150000` and multiples of four `c<=300000`, including the principal c=1. Let

`qt(c)=2c` for odd c and `qt(c)=c` otherwise, `Dc=1200000/qt(c)`,

`Hp_old(c)=ceil(200+max(1000,(704/7)*Dc))`,

`Hcert(c)=min(Hp_old(c),100000000/c)`.

The plus low cutoff is Hcert. The star low cutoff remains `min(Hs_old(c),100000000/c)`, where `Hs_old(c)=ceil(max(1000,(704/343)*Dc))`. Neither minimum is rounded upward. The base-gap cutoff is its existing twist-dependent H, known to be at most Hcert for every supported conductor. Inverse characters have the same conductor, so the new profile is invariant under the inverse-label operation in the actual source formulas.

The following packets were read and retain their existing reviewed scope:

* `WEIGHTED_EXCESS_CERTIFICATE_2026-11-11.md` and its review `D4F0619A50B3DF6BAFFCA051108F64A1DB2491F13BDB9CE31EF17C5F03C0B948`. Its actual-kernel and etaU product arguments are useful below, but its unproved premise `K<=6` is not used.
* `audit/REVIEW_WEIGHTED_EXCESS_DENSITY_FEASIBILITY_2026-11-11.md`, `1C63512867F844E4FD66D51394A411B5951C5AB198F33B1B1AF2A341E20E47D9`. The failure of those coarse density majorants is not replaced by an assumed stronger density estimate here.
* `RESUME_FAMILY_CAPS_2026-11-11.md` and `zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md`, the latter hash `5E7FB33EDF2A65F058DC605A3054FE37DFDF14E9ACDCB8409A8211DCF1F9D09D`. Use its stronger direct-modulus `Cross_low<1e-9`, not an inference from second moments or the weaker factor-25 allocation.
* `RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md`, `79833F8D5D5856E000A96D3F5CCA9FC9E26CB3BAF637CDE089FEFDD703436BA7`: actual character-dependent high-tail aggregate and all non-low remainders.
* `MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md`, `280FDC53E61066E050DD98D4A004A9435510CC67686A59354750E0F7DE188F64`, independently reviewed at `B341209783E4FABCBCDD6390F16717DE91DC686ED457567AE22556B3748E80A1`.
* `integration/BASE_GAP_ACTUAL_SOURCE_JOIN_2026-11-11.md`, sections 2-5, and the reviewed finite-family base-gap calculation `09340D4135D7E895E6F3FDA660DE9A7F773A91FF41F3B88FC125C814884D5E74`.

The unchanged algebraic weights are those of `MinorArcs/Bombieri.lean:27,78,135`: for an inducing primitive conductor c at modulus q, the squared Gauss weight is c precisely when `q/c` is squarefree and coprime to c; otherwise it is zero. It appears divided by phi(q) in character energy, and the pointwise reconstruction uses `sqrt(c)/phi(q)`. There is no extra primitive `1/sqrt(c)` decay. All low Gram/count estimates apply to the actual kernels and global QRH strip, not to relocated zeros.

## 2. Endpoint scaling of the existing positive envelopes

Set `x0=49*10^25`, `y0=10^25`, `epsilon=.01`. The exact integer-power checks give

`x0^epsilon < Fx=15/8`, `y0^epsilon < Fy=9/5`.

For an upper bound we may enlarge every finite low coefficient to the uniform cap `.565`, including the unchanged small conductors. Reapply the already proved positive Gram, count, and two-character envelopes with this cap. This is not a claim that a signed zero sum's norm is monotone under coefficient changes. The positive envelope before evaluation has the form `C*x^(2b-2)`, `C*y^(2b-2)`, or `C*(xy)^(2b-2)`; its constants and actual Mellin kernels are unchanged.

At the endpoint the squared envelopes are inflated by `Fx^2`, `Fy^2`, or `Fx^2*Fy^2`. At every larger x with y=x/49, the new powers are still strictly decreasing, so the endpoint bounds remain uniform. Do not claim `x^epsilon<=Fx` for unbounded x; that would be false. This proof compares envelopes at the endpoint and then uses their new negative exponents.

The resulting finite-low bounds are

`sqrt(Aplus_low)<.00007*Fx`, `sqrt(Astar_low)<.00049*Fy`,

`N_low<.001*Fx^2`,

`integral sum Lplus<.002*Fx^2`, `integral sum Lstar<10000*Fy^2=32400`,

`sqrt(Cross_low)<.000032*Fx*Fy`.

The last line follows from the direct two-character positive coefficient bound `Cross_low<1e-9` at the old cap and `.000032^2>1e-9`. In particular it retains the same-modulus product and both character indices. No large-sieve second-moment-to-fourth-moment inference enters.

At c=1 we do not use the enlarged envelope for the principal assertion: the actual finite condition and all principal cutoffs are unchanged. Thus `sqrt(Ep)<.00020001`, the principal psi route, and the lower-J input remain exactly as before.

## 3. High tails and the complete mixed perturbation

The high cutoffs have not moved, so the current plus-tail aggregate `integral sum Tq<.025`, Aplus tail norm `<1e-10`, scalar plus non-tail error `d0=2e-15`, and entire star scalar error `ds=2e-12` remain valid. The dominant high-plus times low-star squared aggregate has a positive low-star factor. Replacing the low coefficient cap multiplies that factor at the endpoint by at most `Fy^2`. Hence its norm is `<.00016*Fy`, not the unchanged `.00016`.

The remaining four mixed terms are bounded, in the same direct-sum/two-character Hilbert space, by

`d0*sqrt(300000*32400) + ds*sqrt(300000*.002*Fx^2)`

`+ ds*sqrt(300000*.025) + d0*ds*180000000000`.

The exact script uses respective square-root upper bounds `100000`, `46`, and `87`. The sum is

`5825009/12500000000000000 <1e-9`.

This replaces the old small-error ledger rather than inheriting it without rechecking. Therefore

`sqrt(Cross_c)<.000032*Fx*Fy+.00016*Fy+1e-9=.000396001`.

The remaining full coprime bounds are

`sqrt(Aplus_c)<.00007*Fx+1e-10+2e-9`,

`sqrt(Astar_c)<.00049*Fy+1.2e-6=.0008832`,

`sqrt(N)<.032*Fx+.16+2e-9`.

The `1.2e-6` star weighted-removal norm is independent of the finite low beta cap. Exact squared comparisons give

| Actual quantity | Strict upper bound |
|---|---:|
| Aplus_c | `.00000001722711375441` |
| Astar_c | `.00000078004224` |
| Cross_c | `.000000156816792001` |
| Astar_c+Cross_c | `.000000936859032001` |
| N | `.048400000880000004` |

The combined margin below `9.5e-7` is `.000000013140967999`. The obsolete separate target `Astar<=2.5e-7` is not claimed; the actual cubic consumer requires the combined target, which passes. Aplus passes `5e-7` and N passes `1.23` with substantial room.

For possible later proposals, this scaling rule is parametric in epsilon: the finite-low norm factors are `x0^epsilon` and `y0^epsilon`; the low mixed norm factor is their product; and any independently proved high-plus/low-star norm aggregate is multiplied by the star factor. A different height profile must supply its own high aggregate before this rule can be used. Nothing here validates such a combined change.

## 4. Final removal, both J bounds, and cubic budget

The arc-residue measure bound remains `W=sum_q 2Dq*phi(q)<=7.2e11`. The unweighted star vector therefore satisfies

`integral sum Estar < (180+2e-6)^2 <32401`.

This is the new value needed in the final full-sum transfer. Reusing 10001 there would be unjustified. The identity `integral sum Eplus=Ep+N<1.2301` remains valid, with a much smaller actual N upper bound above.

With the same `a=1.01`, `bp=3.03e-23`, `bs=3.03e-17`, the current full-sum estimates become

`Afull <= a*5e-7+381.22*2.85*bp`,

`Qfull <= a^2*9.5e-7+.640208*2.85*bs+a*bp*32401+a*bs*1.2301+bp*bs*3.6e11`.

Exact rational checks still give

`Afull<5.050000000000330e-7`, `Qfull<9.817952468e-7`.

The principal Ep estimate is unchanged, so both the upper-J argument with N<1.23 and the lower-J argument using the stronger principal norm remain valid: `J<10` and `J>8.6296`. The same full caps give cubic dynamic loss `<.008778`, and hence major lower bound `1.040492451>1.0404`. The minor target 1.0376 and nonprime reserve .00271 leave the same positive .00009 final reserve. This does not instantiate the old source 1.049 theorem; the final consumption join still specifies the required replacement assembly.

## 5. The pointwise base gap at all scales

Let m be the original character modulus and `q=m/gcd(m,2)` the reduced denominator. For `q<=50000`, `m<=100000`, so every supported conductor is unchanged. All existing bounds, including the exceptional q=1,2,3 prefix/high-parameter joins, apply verbatim.

For `q>50000`, bound every supported low zero using the larger cap, even when its actual conductor is small. It is essential not to inherit the standalone estimate `|M_etaU|<13/8` on the old reflected strip: that standalone estimate need not hold throughout the widened reflected interval. Instead use the already proved global-strip interpolation

`|M_etaU(beta+i gamma,d)|<=M(beta)=1.922-.6686*beta`.

For `1/8<=beta<=7/8`, `M(beta)>1`. Since `log y>8`,

`d/d beta [M(beta)*y^(beta-1)] = y^(beta-1)*(M(beta)*log y-.6686)>0`.

Consequently every actual low term with `beta<=.565` is bounded by

`M(.565)*y^(-.435)<(13/8)*y^(-.435)`.

This retains the actual kernel and handles all left-reflected zeros, without asserting an invalid standalone Mellin bound. It is uniform in gamma and the real twist d.

At the unchanged full source twist range `u<1200000`, choose the usual inclusive cutoff

`H=max(250,ceil(290400000/(7q)))`.

For `q>50000`, `H<=831`. The reviewed off-line count with multiplicities therefore gives

`N(H)<=ceil(400*(50H/87+2))<200000`.

No zero has been evaluated or discarded. The existing two containment proofs still give `H<=Hcert(c)` on every nonzero Gauss support. Global high, vertical, and zero-at-zero remainder `3e-14` per primitive character remains unchanged.

For the pointwise weights, exact character orthogonality gives `sum_psi |tau_m(psi)|^2=phi(m)^2`, with exactly phi(m) character labels. Cauchy-Schwarz implies

`Wm=sum_psi |tau_m(psi)|/phi(m) <=sqrt(phi(m))<=sqrt(m)<548`.

This uses the genuine imprimitive Gauss weights, including zero weights. It does not bound primitive character errors by `1/sqrt(c)`. Also `m>=q>50000`; more strongly an affected conductor implies `m>100000`. If no conductor above 100000 is supported, use the original bound instead. In the affected case the reviewed finite totient bound gives

`|mu(m)|/phi(m) <= (21/4)/100000`.

The exact positive-power comparison gives `y0^(-.435)<1.4e-11`; the new exponent is negative, so this bound holds for all y>=y0. The actual source reconstruction, including both removal errors, is then bounded by

`1.2534*(21/4)/100000 + 548*(13/8)*200000*1.4e-11`

`+548*3e-14+549*2e-9 = .00256030151644 <.0026 <.04712`.

For q>50000 but no high conductor on support, the unchanged `.044797` bound also suffices. Thus in every case the result is below the same uniform lower bound `.04712<ghatY(y,150000)`. This is the actual pointwise base-gap consumer, not an average over characters, moduli, or twists. The base-gap function equality, residue/modulus conventions, full-sum removal, and minor-energy input retain their existing source joins.

## 6. What has and has not been reduced

The requirement above `.565` replaces the former requirement above `.555` for active high conductors. It is a strict weakening of the finite mathematical information requested. It does not follow from the global `7/8` bound, the 400-per-window count, or the unsuccessful density comparison. No version of `K<=6` is assumed or needed.

The accepted manifest counts 3,695,775,113 primitive labels above conductor 100000. That count of labels is unchanged by this profile. There is no claimed reduction in runtime, proof volume, or number of factors to certify. The highest-risk numerical consumer in this deliberately simple envelope is the combined Astar/Cross budget, whose remaining margin is explicitly given above. This report is a sufficient profile, not an optimized or necessary boundary.

The companion `high_conductor_real_part_profile_20261111.py` performs only small Fraction and integer-power checks, and writes its adjacent JSON receipt. It runs no sieve, no conductor enumeration, and no analytic evaluator. All finite spectral assertions and analytic Lean bridges remain obligations before this optional profile could replace the selected one.
