# QRH base-floor analytic audit

2026-11-11. Bounded source/paper finding: no defect found in the reconstructed base-floor mechanism. The new substantive cut is the all-positive-length nonprincipal polynomial bound, its finite prime-deletion and radial-energy transfer, and the resulting zero/positive small-width floors. This is not a proof of global QRH, a kernel or axiom audit, or validation of all imported analytic foundations. No build, Lean edit, declaration, numerical evaluation, or frozen-file change was made.

Source base B is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, provider revision `4eaee87548250b2682affda7d05d947c05554bae`. One-based declaration locations below are relative to B; the final ledger binds the actual files. The existing energy-induction audit and remaining-obligations inventory already check the outer triangular schedule. The canonical-rank and retained/radial frontier do not supply these particular base estimates. I therefore do not repeat that schedule or label the high/zero recovery producers closed.

## 1. Objects and the selected cut

`Energy/State.lean:15–68` makes the predicates substantive. A NaturalState has nonnegative row and character widths m,q, radial scale exactly Z^m, character modulus norm at most Z^q, a nonzero puncture R with norm at most Z^Bmask, and actual radial support at most bPhi. Every kept row is nonzero and is not the specified fixed-inducing row for the state's fixed modulus and mask. Its width is m+q. `plainEnergy_eq_zero:50` identifies plain energy with the named **zeroEnergy**, not with the number zero.

`Hecke/Dyadic.lean:48` defines the actual polynomial

    P_chi(W,D,omega) = D^(-1/2) sum_{I != 0} chi(I) W(NI/D) (NI/D)^(i omega).

Here inverse=false, sigma=0. The ideal sum has finite support for positive D and compact support of W (`summand_finite_support:51`). The source series at inverse=false is the actual LFunction (`series:69`), not its reciprocal. Consequently the contour argument below needs nonprincipality/entireness, not a zero-free region inside the rectangle. The inverse=true nonvanishing premise in the generic contour theorem is discharged because false is not true; this is a legitimate unused branch, not the deletion of an applicable premise.

The newly inspected base input is `Moments/NaturalMaskedFloor.lean:77`, `natural_masked_floor`, through its `excluded_pair:21`. Positive-bottom additionally uses a genuine prime-slot estimate. The latter's source conversion and combination are reconstructed in section 5; the underlying prime estimate remains a named lower input.

## 2. The all-length polynomial estimate has analytic content

`Moments/PlainGlobalActual.lean:13`, `global_polynomial_bound`, obtains for D>=1 and every nonprincipal chi

    |P_chi(W,D,omega)| <= C B_S(W) N(modulus chi) (3+|omega|)^2,

where S,C are chosen from the fixed support [a,b], a>0, before W,chi,D,omega. This uniformity is essential: a bound with a D-dependent constant would not supply the floor.

Its actual calculation is `PlainGlobalBound.lean:39`, `finite_strip_bound`. Mellin decay is used uniformly for Re s in [1/2,2], with sixth power of 1+|Im s|; L growth costs second power. Take the finite rectangle with horizontal heights +/-D, not a limiting rectangle. On the central side D^(Re s-1/2)=1. Weighted decay dominates (1+t^2)^(-1), giving central norm <= C_m K pi (`weighted_central:11`). Each horizontal side has length 3/2 and norm at most

    (3/2) C_m K D^(3/2)/(1+D)^2 <= (3/2) C_m K.

The remaining integral is the exterior of [-D,D] on Re s=2, with absolute-series constant E_2=HeckeReciprocalBound.bound 2. Its bound is C_m E_2 pi D^(3/2)/(1+D)^4 <= C_m E_2 pi. The total is divided by 2pi. `Hecke/DyadicContour.lean:114` first uses actual Mellin inversion and integrability on the right line, splits that integral into a compact part and its complement, then uses the finite rectangle identity. No unproved vanishing of horizontal integrals or default value of a divergent sum is invoked.

For the required growth K, `Hecke/DyadicReflectedControl.lean:54`, `original_upper_strip`, gives

    |L_chi(s)| <= C Q^(3/5) rad(Q)^(1/10+e) (3+|Im s|)^2

on Re s>=-1/10 for every nonprincipal chi. Set e=3/10. Since rad(Q)<=Q, the modulus powers total exactly 3/5+2/5=1. The shift changes the ordinate to t-omega, and 3+|t-omega| <= (3+|omega|)(1+|t|). This yields K=C Q(3+|omega|)^2. The primitive conductor is no larger than the original modulus; primitive nonprincipality follows from the finite-deletion principal-character equivalence. The growth theorem factors the original L into primitive L and finite Euler factors. It calls `Hecke/LogarithmicInput.lean:137` regular_right_growth, whose strip part uses `Hecke/Presentation.uniform_strip_bound`, while the right half-plane uses the absolute series. It does **not** call the beta-dependent disk nonvanishing theorem later in that file. Primitive strip growth/continuation and the finite-deletion producer are explicit lower boundaries of this audit.

`Moments/PlainPositiveScale.lean:13,40` supplies the previously missing interval 0<D<=1, including all scales created by deletion. The absolute ideal-count estimate gives |P| <=128 max(0,b) B_00(W) sqrt(D) <=128 max(0,b)B_00(W). Enlarge S by (0,0), add that constant to C, and use Q>=1 and (3+|omega|)^2>=1. Thus the same form holds for **every positive D**. No assumption D>=1 is silently reused after dividing by a large ideal norm. The absolute ideal-count and underlying Mellin source-decay lemmas remain imported foundations.

## 3. Radial integration and finite deletion

`Moments/PlainPositiveEnergy.lean:15` multiplies the two polynomial bounds and then squares them in the radial energy. The result contains Q^4, B_S(W1)^2 B_S(W2)^2 and fourth powers of each frequency factor. At zero frequency this is the explicit 3^8 cost. `PlainGlobalEnergy.lean:59` first proves summability for the bounded row function, then compares to B^2 times the radial norm sum. The radial mass is bounded by diagonalControl(Phi)*max(1,K). There is no cardinality assumption on keep and no inference from a possibly divergent real tsum.

The common-mask step is not a termwise assertion that deletion decreases a character sum. `CommonMaskExpansion.lean:67` expands the deleted pair and slots over two subsets D1,D2 of the finite prime support and a subset J of slots. Both polynomial scales become X_i/N(product D_i). The signed coefficient majorant is controlled before summing rows. `CommonMaskEnergy.lean:15,64` applies finite Hilbert-space triangle/Minkowski in the form

    sum_i |sum_j a_ij f_ij|^2 <= (sum_j rho_j)^2 E,

assuming |a_ij|<=rho_j and each j-column energy<=E. It calls the coefficient-mass theorem with exponent e/2, so squaring gives precisely N(rad R)^e, not twice the advertised exponent.

The subpower bound itself was inspected: `CommonMaskExpansion.lean:255–323` bounds the coefficient mass by a fixed product of slot constants times an Euler product to power 2+|F|. `ReflectionMass.lean:130` splits primes into a globally finite small-norm set and its complement. For weight p=Np^(-1/2), localMass=(1+weight)/(1-weight) is <=7 always and <=3 once Np>=4. Choose a fixed threshold after which Np^delta>=3. The small-prime cost is at most 7^(number of all small ideals), independent of the chosen prime set. Use delta=e/(2+|F|) and then the e/2 choice above. This pays deletion without a cardinality loss growing with R. The ideal finiteness/count and prime norm>=2 inputs are retained.

`CommonMaskRadialEnergy.lean:37` applies the finite result to arbitrary finite kept rows with multiplier sqrt(Re Phi). Radial nonnegativity is explicit. Every child energy is genuinely summable, using bounded finite slots and pair_radial_summable; hence finite child sums are <= their tsums. The final nonnegative-series comparison supplies the infinite radial bound. For `NaturalMaskedFloor.excluded_pair`, F is empty, so every child is exactly the all-positive-scale pair of section 2 and the prime-support product is rad R.

## 4. Actual natural rows and the zero floor

`NaturalMaskedFloor.lean:77` restricts keep only by Phi(|z|^2/K)!=0, removing zero contributions term by term. It does not alter a live row. On this support, |z|^2<=bPhi Z^m. Actual natural-row completion supplies

    N(modulus chi_z) <= F bPhi Z^(m+q),

where F=fixedConductorFactor>0 is fixed arithmetic data. Its nonprincipal proof consumes the state's actual nonexceptional condition. The masked row identity identifies the excluded natural character with the original row; `zero_row_norm:42` and the norm-one scale phases preserve the X_i^(-1/2) normalization.

The common imaginary twist is absorbed into both profiles. `FiniteProfileExceptionalControl.lean:58` uses log pullback, a frequency twist and return maps to give B_S(V_i)<=C_t B_T(W_i)(1+|t|)^n. The squared pair therefore costs C_t^4(1+|t|)^(4n). The conductor/radial factors are

    Z^m (Z^(m+q))^4 <= Z^(m+q+4rho),  provided m,q>=0 and m+q<=rho.

After absorbing F^4 and bPhi^4, this is exactly natural_masked_floor. No pole term, exceptional row, or small positive scale was dropped.

`Energy/Floor.lean:11` sets rho=epsilon/16 and e=epsilon/[4(Bmask+1)]. Since e Bmask<=epsilon/4 and 4rho=epsilon/4, deletion and width fit inside epsilon with slack. The conclusion holds with threshold Z0=1 for every fixed Q, all admissible states of width<=epsilon/16 and **all positive X1,X2**. The constants and profile controls precede Q. This is a small-width estimate, not an estimate on arbitrary width and not a positive lower bound on energy. Zero profiles, empty keep and zero energy are valid cases; actual nonempty supported states are not excluded by the proof.

## 5. Positive bottom: the extra input and exact join

`RayMaskedFloorSlots.lean:33` uses the actual normalized prime-slot estimate from `NaturalFixedRaySourceRayPrime.lean:18`. Its bound is C(1+|t|+|v|)^J Z^ell P^kappa, under beta>=51/100 and kappa>=2beta-1, a nonprincipal-ray condition obtained from the fixed-inducing exclusion, and a conductor cap. `NaturalFixedRaySourceNaturalPrime.lean:19,35,73` explicitly transports the actual natural character, its product with a fixed inverse character, and the finite ray twists. The fixed-character modulus is absorbed by an eventual threshold, raising Lmod to Lmod+1. Constants precede that fixed character; the threshold may depend on it. Finite ray characters permit an eventual intersection. There is no assertion of a uniform threshold over all fixed characters.

For every subset A of the fixed finite slot set F, choose ell=loss/(|F|+1) before A. Multiplication of the **squared** slot bounds gives Z^(loss+kappa sum_F w_i), degree J|F| and constant max(1,C)^|F|. Here kappa>=0 follows from the displayed beta/kappa assumptions; w_i>=0 permits enlargement from A to F. Empty A is included. `RayMaskedFloorNatural.lean:24` takes the square root of this product estimate once, multiplies the two ordinary polynomial bounds, and squares once in radial energy. Thus the slot exponent is not inadvertently doubled. Shared deletion requires all A and all reduced positive scales; both have been supplied.

`RayMaskedFloorShared.lean:25` pays N(rad R)^e as in section 3. `RayMaskedFloorSource.lean:24` identifies the original positiveSlotRow with the normalized pair times actual normalized slots, keeping the outer X1^(it)X2^(it) of norm one and slot heightCoefficient=beta(I)NI^(it). Mask-inducing equivalence supplies the base-mask exclusion. `RayMaskedFloor.lean:22` then substitutes the live-row conductor cap F bPhi Z^rho and radial scale Z^m. The bound is

    C N(rad R)^e bPhi^4 diag(Phi) profileControl^2
      (1+|t|+T)^degree Z^(m+4rho+loss+kappa sum w_i).

`RayMaskedFloorState.lean:20` sets rho=epsilon/16, loss=epsilon/4 and e as above. With Wstate=m+q<=epsilon/16 and 6kappa sum w_i<=Wstate, the extra exponent is at most

    e Bmask+4rho+loss+kappa sum w_i <= 3epsilon/4+epsilon/96 < epsilon.

Since m<=Wstate this proves the desired Wstate+epsilon bound. `Energy/Bands.lean:55` chooses a finite union of controls, sum of degrees and 1+sum of constants for all subsets before eta0, then intersects the eventual conditions. The PositiveAt capacity uses log_Z(max(1,X_i)); its nonnegativity removes the length terms and yields exactly the required six-kappa inequality. The existing scale caps cause no further loss.

The prime-slot inequality is **not** inferred from the ordinary all-length floor. Its lower analytic boundary is `Moments/PrimeHeight.lean:152`, ray_prime_all_height_squared, through the natural-character/ray conversion above. This report checks its consumption, not the whole prime-sum theorem or beta-dependent analytic continuation machinery. Beta is the existing source zero-supremum, not a new hypothesis that beta<=7/8.

## 6. Recovery remains a different analytic task

The requested recovery entries were located and their immediate calls inspected to avoid confusing them with the now-expanded floor:

* `Energy/NaturalHighStage.lean:30` combines `PositiveHighSourceBound.actual_high_stage_from_physical:66` and `PositiveHighPhysical.actual_positive_high_physical:30`. It consumes prior zero/positive bands and the newly supplied low positive band, with capacity/drop margins. The present polynomial floor does not prove either physical high-column estimate.
* `Energy/NaturalZeroStage.lean:24` combines `ZeroGrowthContourBounded.zero_from_growth_additional_loss_bounded:64`, `ZeroGrowthSourceControlled.actual_growth_from_physical:21` and `ZeroGrowthPhysical.actual_growth_physical:31`. Those recovery estimates are not consequences of the small-width floor alone.
* `Energy/ZeroGrowthOriginal.lean:52` is a concrete later recovery target. It orders the two scales, expands finite deletion, splits each deleted long scale at width-log_Z(Xlong/ND)+xi>=0, and uses `ZeroGrowthBounded.live_deleted_bounded:21` on that branch and `ZeroRetainedError.natural_original_error_mass:211` on the other. `ReferenceDeletionEnergy.original_energy_weighted_deletion:20` and `ReferenceProfileBudget.reference_envelopes:15` supply the weighted sum and controls. Its second error term retains Rcap^(2epsilon) Z^(-2saving) max(1,radial.scale) Z^L, with Rcap=max(1,F bPhi Z^width); it must not be erased as a zero-error identity. This audit maps that branch and does not certify its live-deleted or error-mass producers.

No new final premise or altered Goldbach root is proposed. The immediate remaining mathematical frontier is narrower: primitive strip growth/deletion and Mellin foundations beneath section 2; natural-row/nonexceptional arithmetic and radial/ideal-count foundations beneath sections 3–4; the actual beta-dependent ray-prime estimate beneath section 5; and the separate high/zero recovery estimates just listed. The outer width schedule remains the previously reviewed result, not a new result here.

## Pinned source and support ledger

The following hashes bind read source files (full bodies for the base chain; interface/call-map scope for recovery files). Source filenames are relative to B. Hashes are SHA256.

| File | SHA256 |
|---|---|
| `Energy/State.lean` | `B5118D2F6F04ED495A6317317B74A7D60BA1B32F2050AEB7EE7E9E4783D67222` |
| `Energy/Floor.lean` | `C21817E4B2C47A5B2DEA174CC15897358A01B05F873880AF9727C2925093B54D` |
| `Energy/Bands.lean` | `42FD3FE963D8DEEF1CC5772979B41A8273E80940641E9F24475FF33397A09C2E` |
| `Moments/NaturalMaskedFloor.lean` | `12876AAAE7F7CE330AAA6007F8FE85BB81EEBC7FF647EC0C0C3074C2DA8677F8` |
| `Moments/PlainPositiveEnergy.lean` | `4067E54974B6EF470B585B253A0E6906766B7F0F5DAEBB00FD48DD2740C2B609` |
| `Moments/PlainPositiveScale.lean` | `DB598DF6BFA787FA463AE09C31DEF2974DB0065D10D793EB2AE3B6A7CC411B92` |
| `Moments/PlainGlobalEnergy.lean` | `9C3EDA2702831D38D9107E2EE287D36E98BFB0D7EAA6A9E93979555CF2464E24` |
| `Moments/PlainGlobalActual.lean` | `B213329E9D509F1F7FE50708F9B0BD897F3CB202B86C6860918826A04F102FA2` |
| `Moments/PlainGlobalBound.lean` | `9EEDF1C9EA4E497A2E9564426A7C8A36CC06A85E8D31D52BF069940366D58699` |
| `Moments/CommonMaskEnergy.lean` | `BA996F7F2AB3275035495BFA8CE42ED28C17AF089B79CCD75721C70619036AFF` |
| `Moments/CommonMaskExpansion.lean` | `C8D1AFB70331A0AC672682CBA3B69926C919D9C931B4296AE3798BCCB587C688` |
| `Moments/CommonMaskRadialEnergy.lean` | `20077F90F61AFEEC9C55A06A2E1133A4F851FDFF97E9645A97ECDE27ED5F5FA3` |
| `Moments/ReflectionMass.lean` | `15213BA9EA109301049130D0F9ECE9E5545B88708214772A63F6F0859263751B` |
| `Moments/FiniteProfileExceptionalControl.lean` | `9294C44A21FD53FB38507C1CF826A9A54DC77BF533EE4E1CB206565804FCBB27` |
| `Moments/RayMaskedFloor.lean` | `DB656577472D2B9883298469914404B74EB6AE30A8BC475773D47874B2BE8057` |
| `Moments/RayMaskedFloorState.lean` | `0ADDE65DA42896C3A2C06CA4E09B97363DE4A5763CEDA12F054C424F95CFB0CD` |
| `Moments/RayMaskedFloorSource.lean` | `251DFA24333ACD6545A20E0C931B3F82F21B5274FF265033B9C8EEB7F716ACB3` |
| `Moments/RayMaskedFloorShared.lean` | `BD7C97D4F8F8F84560CDC2745E1E170772576DA4806138CC4195638A517FC79E` |
| `Moments/RayMaskedFloorNatural.lean` | `E0D563F8A84EC57CB75105467A55E41891BD097306F150B55F758556008EEE5A` |
| `Moments/RayMaskedFloorSlots.lean` | `25090798011E816359E0E0CFF7DD25837A11324DCC675A603A3A2DBE9A4DA4DA` |
| `Moments/NaturalFixedRaySourceNaturalPrime.lean` | `CA6A36E22778FA91B262985F24010BF55697A59FD9A654413D7DA8FB7CAE312A` |
| `Moments/NaturalFixedRaySourceRayPrime.lean` | `1B06B3219B02319110AD35CE9B867B1BCCCF01F861A4E43D2119A0144C071516` |
| `Moments/PrimeHeight.lean` | `A1EC164AF7FF7B0D757E3B6DBBD43DCF9CD394DBE50783C35FE970DD84F64B12` |
| `Hecke/Dyadic.lean` | `15E88379D7386D4D0A873C8D2467EF28AF8ED5FB7392219D634F616B9D36C2A2` |
| `Hecke/DyadicContour.lean` | `EE2E6A428199FBD1DFC34B23D7EAEA69E76FA3E7D0CD70208B620F5BBFE550E1` |
| `Hecke/DyadicJoins.lean` | `29C9B2F656000932021428E972D62435D22937959A08CF37549250E6762B9048` |
| `Hecke/DyadicReflectedControl.lean` | `D6D5B22F9AC3DC41566DCF7D3248E84F6D2FDAC28BBF621A265479FF97D8E0D1` |
| `Hecke/LogarithmicInput.lean` | `9ADCC4FDE13E8A257CDC81F4A1DA752949FCFCF339B856A40411BFE901DC6F0D` |
| `Energy/NaturalHighStage.lean` | `9A8E0F9C45BBEA861336F632D48A526A47694C0A71A860FE88B65E420ED492AB` |
| `Energy/NaturalZeroStage.lean` | `7745F22169E40515D27022D4A88DA9E4BB94A47A50F876FBD2740F9014CD865E` |
| `Energy/ZeroGrowthOriginal.lean` | `6282A4B2C61775A1C92E9F62344366560379EEFF92CA529389C8B57A411BCA7D` |

Prior-scope references (historical inventory entries are not fresh proof obligations once superseded):

| Workspace path | SHA256 |
|---|---|
| `work/qrh-campaign/agents/major-constants/QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md` | `C04D05F95C1747652F28576AC41372702F586F5D85E2849F12CD3E4D28A8D695` |
| `work/qrh-campaign/agents/independent-feasibility/REVIEW_QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md` | `70B618789695E16ECD8F78F81E951D9A7AB02FA6ED55B78CE9A46CD7203C3877` |
| `work/qrh-campaign/agents/major-constants/QRH_CANONICAL_RANK_ANALYTIC_AUDIT_2026-11-11.md` | `2767A7CC08CC13239EFDBC5242D47505FC44028016251407B21A542CDC98FF4B` |
| `work/qrh-campaign/agents/audit/QRH_REMAINING_SOURCE_OBLIGATIONS_2026-11-11.md` | `B4FD23DBABB297E057E00A6DFDE4BD3A8164202AA40DC292C090E7C5C3858D07` |
| `work/qrh-blueprint/QRH_QUADRATIC_RETAINED_RESIDUE_RADIAL_FRONTIER_2026-11-11.md` | `4C33F3D113D174FDB449DB67A8228CD6D29496D6B2AC85886C52B7FFB6ED971F` |
