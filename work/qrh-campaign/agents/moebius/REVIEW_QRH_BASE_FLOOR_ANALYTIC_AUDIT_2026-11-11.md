# Independent review: QRH base-floor analytic audit

2026-11-11. **PASS at the stated bounded source/paper scope.** No mathematical or source-contract correction is required in the author report. This accepts the reconstructed implication through the ordinary all-positive-length floor, common-mask deletion, and the zero/positive small-width interfaces. It does not validate global QRH, every imported analytic theorem, the outer induction, or the high/zero recovery producers. No Lean build, declaration, source mutation, or analytic numerical evaluation was performed.

The reviewed author artifact is `integration/QRH_BASE_FLOOR_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `7EBE8A5D2A7E2D4B78416A5BB34E1C7EF34E50155A25461A05C698F4989CEF7E`. Source locations below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, expected provider revision `4eaee87548250b2682affda7d05d947c05554bae`. The byte receipt reproduces all 31 source pins and five scope-reference pins in that report. A pin establishes source identity, not that its entire dependency closure was independently proved.

## 1. Actual carriers, normalization and all positive lengths

`Energy/State.lean:15–68` carries a nonzero puncture, nonnegative row/character widths, the exact radial scale, a modulus bound, radial support, and a nonexceptional condition on each kept row. Its `plainEnergy_eq_zero` refers to the named zero-slot energy; interpreting this as the scalar zero would invalidate the audit. The report makes the distinction correctly.

I checked the ordinary polynomial route through `PlainGlobalActual`, `PlainGlobalBound`, `PlainPositiveScale` and `NaturalMaskedFloor`, including the role of the finite-contour identity at `Hecke/DyadicContour.lean:114`. The polynomial uses the actual L-function at `inverse=false`. In that branch, the generic inverse-series zero-free premise has false antecedent; no applicable nonvanishing premise has been discarded. Nonprincipality instead gives the holomorphy required by the finite contour.

For D>=1, the contour has real endpoints 1/2 and 2 and imaginary endpoints +/-D. After the D^(-1/2) normalization, the central side has no positive D power. The sixth-order Mellin decay pays the quadratic L growth. Each horizontal side is bounded by (3/2) C_m K D^(3/2)/(1+D)^2 <= (3/2) C_m K. The exterior right-line integral contributes at most C_m E_2 pi. These estimates concern a finite rectangle plus an integrable right-line tail, not an unsupported contour-at-infinity limit. The overall normalization is 1/(2pi).

`Hecke/DyadicReflectedControl.lean:54` uses the primitive right/strip growth and finite Euler factors. With e=3/10, the conductor exponents are 3/5+1/10+3/10=1, because the radical norm is at most the modulus norm. This particular theorem does not call its beta-dependent reflected-line predecessor. Its primitive growth and finite-deletion identities remain lower inputs, as the author states.

The separate small-scale argument in `PlainPositiveScale.lean:13,40` matters: for 0<D<=1 it gives a constant times sqrt(D), then bounds sqrt(D) by one. Consequently every positive X_i/Norm(product D_i) created by deletion is covered. The stronger large-scale premise D>=1 is never silently reused on those children. The fixed support and seminorm constants precede the character, scale and frequency.

## 2. Deletion and radial summability

The pair bound is squared when inserted into radial energy: its modulus cost is Q^4, with two squared profile controls and fourth powers of each frequency factor. At both frequencies zero this yields 3^8. `PlainGlobalEnergy.lean:59` proves summability of the bounded kept-row function against the Schwartz radial weight before using `tsum_le_tsum`; the comparison majorant is itself summable. The mass is bounded by `diagonalControl(Phi)*max(1,scale)`. There is no finite-cardinality assumption on the kept rows and no reliance on a divergent tsum's default value.

`CommonMaskEnergy.lean:15,64` implements finite Hilbert-space triangle/Minkowski. The coefficients may depend on the row, but their absolute majorants are common to all rows. Its resulting bound is `(sum rho)^2 E`. Calling the coefficient-mass bound at e/2 is necessary and sufficient to leave precisely the advertised radical exponent e after squaring.

I checked `CommonMaskExpansion.lean:255–323` and `ReflectionMass.lean:130`: the coefficient mass is bounded by a fixed slot factor times an Euler product to power 2+|F|. The Euler-product subpower proof splits off the finite set of all small ideals. Each small local factor is <=7; each sufficiently large local factor is <=3<=Norm(P)^delta. The constant is chosen independently of the actual finite prime support. Thus no uncontrolled count of the puncture's prime factors is hidden in C.

`CommonMaskRadialEnergy.lean:37` applies the finite inequality to arbitrary finite kept rows with the multiplier sqrt(Re Phi). It requires radial nonnegativity explicitly. Each deleted child has genuine radial summability from `pair_radial_summable` and a bounded finite slot product. Only then are finite child sums compared with their tsums. The nonnegative finite-sum bound supplies the final infinite-series estimate. The positive norm of each finite prime product establishes all child-scale positivity.

## 3. Natural rows and zero floor

`NaturalMaskedFloor.lean:77` filters only rows at which the radial profile is zero. On its remaining support, the actual natural character has modulus at most F*bPhi*Z^(m+q), with fixed F>0; its nonprincipality follows from the kept-row exclusion. The exact masked-row and norm-one scale-phase identities preserve both square-root normalizations.

Twisting the profiles costs C_t^4(1+|t|)^(4n) for the squared pair. The radial and conductor powers combine as Z^m (Z^(m+q))^4 <= Z^(m+q+4rho), under m,q>=0 and m+q<=rho. These are the source's actual assumptions.

`Energy/Floor.lean:11` takes rho=epsilon/16 and e=epsilon/[4(Bmask+1)]. The extra exponent satisfies e*Bmask+4rho<=epsilon/2<=epsilon. The threshold is 1, the constants precede the fixed modulus Q, and the conclusion retains all positive X1,X2. Empty keep or zero profiles are allowed, but the carrier does not force them; this is an upper energy bound, not a positive lower bound.

## 4. Independent positive-prime and quantifier check

The author stops at `Moments/PrimeHeight.lean:152` as its positive-floor analytic boundary. I independently read that file and `PrimeGlobal.lean` one layer farther, without claiming the underlying prime-bin estimate proved. This narrows the interface check; it does not remove that remaining analytic input.

`RayNonprincipal.lean:14,44,51,63` derives nonprincipal twists from the actual non-FixedInducingRow condition. If the product twist were principal, conductor descent would produce a primitive inducing character and hence the forbidden fixed-inducing row. `NaturalFixedRaySourceNaturalPrime.lean:19` transports this through the fixed inverse character and `internalQ`. Thus this is not an extra unproved nonprincipal premise inserted into the floor conclusion. The finite descent/primitive-character arithmetic used by this argument remains a lower foundation.

At `NaturalFixedRaySourceNaturalPrime.lean:35,73`, the constants and degree are chosen before the fixed character eta0, while its modulus is absorbed into an eventual Z threshold. The threshold is allowed to depend on eta0. Replacing this with a single threshold for every fixed character would be unjustified; neither the source nor the author does so. The conductor exponent changes from Lmod to Lmod+1, and the slot ordinate is t+v, bounded by |t|+|v|. The finite ray-character intersection preserves these quantifiers.

`PrimeHeight.lean:68,152` covers both prime-scale regimes. For the large-scale branch, set d=max(Lmod,Lslot)+2, T=3+|freq|, Zt=Z*T, U=Zt^d and r=log_U(P). The source proves 0<=r<=1, caps every twisted modulus by U, and checks `(3+2Zt)^2<=U^(4/d)`. With eps=loss/(2d), the output exponent converts exactly to P^kappa Z^loss T^loss. The choice e=min(eps/32,1/2000) pays `8e+eps/2<=eps`. The bounded-scale branch is a direct absolute bound on 1<=P<=exp(2(|log A|+|log B|)+1). The integer degree ceil(loss) absorbs T^loss. No frequency-dependent constant is substituted for a uniform one.

`PrimeGlobal.lean:12,28` bounds the finite family zero maximum by the existing global beta using actual family-zero membership and `zero_re_le_beta`. The inserted 51/100 baseline uses the explicit hypothesis beta>=51/100. Its squared prime bound uses kappa>=2beta-1. These premises are not discharged inside this floor audit, and no assumption beta<=7/8 is used here. The actual `ray_prime_bin_bound`, its analytic zero/prime machinery, and the zero-supremum foundations remain below this review.

For a fixed finite slot set F, `RayMaskedFloorSlots.lean:33` spends ell=loss/(|F|+1) before choosing a subset. Nonnegative weights and kappa>=1/50 permit enlargement of the subset exponent to the full sum. The empty subset is covered. `RayMaskedFloorNatural.lean:24` takes one square root of the squared-slot estimate, then squares the combined pair/slot bound once in radial energy. It therefore does not double the slot exponent.

The final exponent check at `RayMaskedFloorState.lean:20` is

    e*Bmask + 4*(epsilon/16) + epsilon/4 + kappa*sum(w)
      <= 3*epsilon/4 + epsilon/96 = 73*epsilon/96 < epsilon.

It uses `6*kappa*sum(w)<=state.width<=epsilon/16` and m<=state.width. `Energy/Bands.lean:55` collects only finitely many subset constants/controls/degrees before eta0. Its capacity uses nonnegative `log_Z(max(1,X_i))`; dropping those length terms is valid and yields the required slot inequality. Neither an arbitrary-width estimate nor a uniform eta0 threshold is inferred.

## 5. Boundary of the verdict and reproducibility

No correction is requested. The report correctly separates its base estimates from `NaturalHighStage`, `NaturalZeroStage` and the later original-growth reconstruction. In particular, the nonzero error term in `ZeroGrowthOriginal` remains present. This review does not approve those recovery producers or repeat the outer successor schedule.

The remaining inputs are primitive strip growth/continuation and finite-deletion identities; Mellin inversion, finite-contour and profile-decay foundations; natural-character completion/descent; radial Schwartz and ideal-count facts; and the actual beta-dependent ray-prime estimate. This is a bounded source implication review, not elaborated axiom-closure evidence.

`check_base_floor_source_20261111.py` (SHA256 `7D414195EEFEDA88503A5DDBC79707AD9878903F54EB9344EAD9AD21196CE64E`) reconciles the author hashes and performs seven exact rational scalar checks. Its receipt `check_base_floor_source_20261111.json` has SHA256 `F36D96044F9DCC0A34E2FB87D35A5A7F82DD3E769EF25C1EC74E61256C7379D2`. The checker does not verify Lean proofs or evaluate analytic functions.

Additional independently read source pins beyond the author's ledger:

| File | SHA256 |
|---|---|
| `Moments/RayNonprincipal.lean` | `B0E1D4D7F843992F272D0544E5EC43C68420A042B66C3727D542A86FE0190970` |
| `Moments/PrimeGlobal.lean` | `8FFC0F6629F775AA1BD9DA2CC1FB61F4D37DD710B214035299C800EC8DFFFE9E` |
