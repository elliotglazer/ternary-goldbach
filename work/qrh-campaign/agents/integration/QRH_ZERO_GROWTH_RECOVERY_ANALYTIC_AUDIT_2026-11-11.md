# QRH zero-growth recovery analytic audit

2026-11-11. Bounded source/paper finding: no defect found in the reconstructed zero-band recovery. This audit follows the actual reflected polynomial, its discarded error, the uniform Fourier-profile comparison, and the deleted-scale growth bound through `original_from_growth`. It also checks the immediate scalar reserve converting that bound into ZeroAt. It does not prove the supplied ZeroGrowthAt hypothesis, audit the high-band recovery, validate the full induction, or claim kernel/axiom verification. No Lean edits, builds, declarations, analytic evaluations, or changes to frozen reports were made.

Source base B is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, revision `4eaee87548250b2682affda7d05d947c05554bae`. Locations are one-based and relative to B. Source hashes below bind the inspected bodies. The base-floor audit supplies a distinct starting estimate; the existing induction/caller audit supplies the outer schedule. Neither is used to assume this recovery estimate.

## 1. The actual conditional improvement

`Energy/ZeroGrowth.lean:15` defines ZeroGrowthAt on actual NaturalState/plainEnergy, profiles supported on [a,b], positive scales X1,X2<=Z^L, and fixed modulus Q. Its exponent is

    max(width, length_Z(X1)+length_Z(X2)) + loss,
    length_Z(X)=log_Z(max(1,X)).

This is weaker than the desired exponent width+loss. In particular, growth does not disappear by choosing the definition of the target differently. The recovery uses this premise for newly constructed annular test profiles, not the already desired ZeroAt estimate. The easy `zeroGrowth_of_zeroAt` in the same file is not used to obtain that premise here.

`Energy/ZeroGrowthOriginal.lean:52` fixes 0<a<=1/4, b>=1, bPhi>0, epsilon,xi,defect>0, saving, Lreflect, and source seminorm set S. It then chooses J,U,C>0 and an eventual Z threshold **before** Bmask,L,Mcap,loss,Q,degree,K. The latter satisfy K>=0, ZeroGrowthAt, Bmask>=0,

    Mcap+Bmask+defect+xi <= L,
    Mcap+Bmask+defect <= Lreflect.

For every allowed state of width w<=Mcap and both original scales in (0,Z^L], put R=max(1,F*bPhi*Z^w), where F is the actual fixedConductorFactor, and Nrad=N(puncture.radical). The conclusion is

    plainEnergy <= C(K+1) diagonalControl(Phi) control_U(p)^2 (1+|t|)^J Nrad^epsilon
      * [ R^epsilon (1+2L log Z) Z^(w+loss+defect+xi)
          + R^(2epsilon) Z^(-2saving) max(1,radial.scale) Z^L ].

Both terms matter. The second is a nonnegative approximation-error budget, not an identically zero tail. The theorem allows arbitrary real saving; positive decay is supplied by the later reserve choice in section 7. The constants may depend on the initially fixed parameters, including Lreflect and saving; they do not depend on the later growth degree or K. The physical radial normalization and diagonalControl are retained throughout.

## 2. Reflection is an identity with actual character coefficients

`Moments/NaturalReflection.lean:32,53,73` makes the immediate reflection interface explicit. A nonprincipal natural character chi descends to a primitive nonprincipal psi. The redundant prime set S satisfies

    N(modulus psi)*N(redundantIdeal) <= N(modulus chi).

The primitive adapter obtains a multiplier g with |g|=1 from `TraceCharacter.normalizedGauss_norm` and the actual `primitive_deleted_reflection` identity. For every Schwartz G and X>0, the original polynomial equals g times a finite sum over D subset S and a genuinely infinite sum over S-smooth ideals H. Each term is

    mu(product D)*psi(product D)*psi.inverse(H) / sqrt(N(product D)*N(H))
      * P_(chi.inverse)(paperRadialFourier G, Q*N(product D)/(X*N(H)), 0),

where Q=N(modulus psi). The inverse-deletion coefficient identity is proved by conjugating actual ideal coefficients; it is not an arbitrary replacement of a character by its inverse. `original_natural_reflection` includes Summable for each smooth-ideal fiber. `RetainedReflection.lean:27,56,75` separately proves summability for retained/discarded columns before splitting them. There is no appeal to the default value of an unproved tsum.

This round checks those adapters and their normalization. It leaves the underlying primitive deleted-reflection theorem, primitive descent, and normalized Gauss norm theorem as named lower producers. The earlier original-Poisson audit covers its own trace/radial identity; it does not by itself prove every finite-deletion restoration used here.

## 3. The discarded part is quantitatively small

`Moments/UniformReflectionApproximation.lean:16` combines actual radial Euler-seminorm control of order B+A with the plain rapid polynomial estimate, B>=2, giving

    |P_chi(discardedWeight(R)*paperRadialFourier G,Y)|
       <= C control_H(G) (Y^B/sqrt(Y))/R^A.

At :39 choose B=2 and an integer A>(saving+3L/2)/(xi/2), before G,chi,Y,Z. For Y<=Cscale*Z^L and R=Z^(xi/2), the exponent is 3L/2-(xi/2)A<=-saving. This works for every positive Y, including Y<1. At :77 the actual coefficient-column mass bound proves the infinite smooth-ideal sum converges and adds only the redundant-ideal subpower. A uniform termwise bound alone would not justify that sum.

The exact split is :163; the approximation is :175. The energy conversion `UniformOriginalEnergy.lean:12` uses |a|^2<=2|b|^2+2|a-b|^2 and |g|=1. The discarded bound is squared, so the error contains Rcap^(2epsilon) Z^(-2saving), while the retained energy has coefficient 2. Arbitrary finite row families and row multipliers are permitted with constants fixed before the family; no row-cardinality cost is hidden.

`UniformOriginalComparison.lean:14` calls this approximation with xi/2, hence its actual retained cutoff is Z^(xi/4). The retained comparison uses the matching geometry. Confusing this cutoff with Z^(xi/2) would change the interface. It retains the same short polynomial in the row multiplier and absorbs the factor 2 into the fixed constant.

## 4. The retained comparison does not assume the original bound

`UniformReflectionProfile.lean:14,38` obtains a Schwartz Fourier density for a compact logarithmic window multiplied by the reflected profile. The finite source seminorm set and constant are chosen before the profile and dilation. The source separation uses `LocalLogFourier.coupled_positive_log_separation_linear_constant` and `paperRadialFourier_euler_source_weighted_bound`; it provides an actual identity, integrability, and a common pointwise envelope. With two extra powers of frequency decay, the weighted envelope integral is K*D*pi, giving an energy constant (K*pi)^2 D^2.

`ReflectedProfileMeasure.lean:106,177` proves the finite-polynomial/integral identity by compact ideal support and actual integrability before interchanging the finite sum and integral. Its :49 normalizes by the strictly positive common envelope rho(v)w(v), then applies `CompletedGauss.finite_integral_energy_bound`. It transfers a **common-frequency** row-energy bound to row-dependent Fourier densities; it does not multiply separate per-row maxima or lose a factor equal to the number of rows.

At `UniformReflectionProfile.lean:93,111`, the real annular window gives the exact conjugation identity

    P_(chi.inverse)(logWindow V,X,+2pi*v)
       = conjugate(P_chi(logWindow V,X,-2pi*v)).

Only the norm removes conjugation. An arbitrary complex window would not support this step. `UniformReflectionScale.lean:14` then applies the paired rowwise scale estimate using derivative indices j,k in Fin 2 and two closed logarithmic intervals. `UniformReflectionChoices.lean:13` allows independent annular choices for every finite row; inactive rows are set to zero, with a valid fallback scale. In the selected application the short interval is a singleton, so the two interval factors reduce to 1+2*(long-window length).

The infinite reflected coefficient sum is handled by `RetainedWeightedSource.lean:51,67,95,113` and `ReflectionWeightedEnergy.lean:105,151,231,266`. The index includes D, a smooth ideal H, and a retained dyadic annulus. The normalized column carries the exact sqrt(scale)/(1+scale)^B factor. The signed weights are absolutely summable, with subpower mass uniform for B>=2. The all-selections energy lemma uses finite approximate choices to bound the sum of row suprema, then weighted summation; it does not assume a supremum is attained. Applying the mass bound at epsilon/2 before squaring yields Rcap^epsilon. Thus infinitely many smooth ideals do not create an uncharged cardinality factor.

`UniformNaturalRetained.lean:14` places every retained logarithmic scale in

    [0, max(0,w-along+xi)*log Z].

This uses the primitive/redundant conductor cap and the matched cutoff, with its eventual threshold before arbitrary row data. `UniformRadialComparison.lean:15` passes from finite rows to radial energy using P(z)*sqrt(Re Phi), positivity of Phi, and actual single/pair radial summability. The finite-subset bound is not mistaken for summability. `Energy/ReferenceHomogeneous.lean:20` inserts the height-twisted profile with uniform source seminorm control. When its controlling seminorm vanishes, the profile is proved zero separately; the positive-normalization branch is used only otherwise.

## 5. Growth controls the new short tests with the correct deletion loss

`Energy/ZeroGrowthChild.lean:22,43` applies the supplied growth predicate to unitBudgetState and independentProfiles at common height 0. The two independent frequencies are part of those profiles; this is why the old free growth degree disappears from the output while explicit source-control powers of |t| and |v| remain. The annulus seed and its two derivative variants have support [1/4,1], contained in [a,b]. `ZeroGrowthMoments.lean:22` proves the required uniform profile-control factor rather than assuming it.

Order the **original** scales Xshort<=Xlong and write Ns,Nl>=1 for the two deletion norms. The proof does not assume Xshort/Ns<=Xlong/Nl. Nonzero original energy supplies 1<=b*Xlong; zero original energy is handled separately. In the live branch,

    0 <= w-log_Z(Xlong/Nl)+xi,
    0 <= x <= (w-log_Z(Xlong/Nl)+xi)*log Z.

`ZeroReflectionSupport.lean:120,137` gives

    length_Z(exp x)+length_Z(Xshort/Ns)
       <= w+log_Z Nl+log_Z(max(1,b))+xi.

Eventually log_Z(max(1,b))<=defect (:151). The cap hypotheses ensure exp(x) and Xshort/Ns lie within the growth range. Since w>=0 and Nl>=1, `ZeroGrowthMoments.lean:52` bounds the max in ZeroGrowthAt and exponentiates **without dropping Nl**:

    Z^(max(w,length1+length2)+loss)
       <= Nl * Z^(w+loss+defect+xi).

`ZeroGrowthWindow.lean:19` supplies all common frequencies -2pi*v and all j,k in Fin 2. `ZeroGrowthReflection.lean:20` meets the reflected comparison's conductor/along constraint using Mcap+Bmask+defect<=Lreflect. `ZeroGrowthBounds.lean:19` bounds the long log window by L; :37 proves a separate absolute short-mass estimate, valid even below scale 1. `ZeroGrowthBounded.lean:21` consequently has a main child bound proportional to Nl, plus the unchanged rapid error, capped by Xshort/Ns<=Z^L.

## 6. Dead scales and restoring the original puncture

The live test includes equality. Its complement is the strict inequality w+xi<log_Z(Xlong/Nl). `ZeroReflectionSupport.lean:54` proves that **the retained annular set** is empty there. It does not prove that the actual original polynomial vanishes. `ZeroRetainedError.lean:22,60,126,211` keeps the discarded-error estimate, first on finite rows, then on the true radial sum. The short radial mass at :179 contributes diagonalControl(Phi)*max(1,radial.scale)*(Xshort/Ns), with a fixed support/seminorm constant. This is the second term in section 1 after capping the last factor by Z^L.

`ReferenceDeletionEnergy.lean:20` restores the actual punctured pair from the signed common-mask expansion. Each child is bounded by E*Nl^p with p<=1; here p=1. Finite weighted radial energy uses sqrt(Nl) at the norm level. `ReferenceDeletionBudget.lean:19` proves

    Nl^(-1/2)*Nl^(p/2) <= 1.

This absorbs the child Nl exactly where needed. It does **not** erase the number of subsets: :27 and :118 pay the remaining powerset/Euler mass by a subpower. The energy theorem requests that mass at epsilon/2 and squares it, producing Nrad^epsilon. Each child's radial series is proved summable before the finite weighted-energy step.

For both live and dead branches, Nl>=1 lets the original proof enlarge the rapid error to the common E*(main+error)*Nl required by p=1. Profile envelopes combine both branches in one fixed U,J,C; K+1 pays the growth-dependent main term and the growth-independent error. Swapping the two original profiles preserves both plainEnergy and control_U. These steps account for every original scale ordering and every deletion pair, including the empty pair.

## 7. Immediate recovery and the remaining cut

`ZeroGrowthReserve.lean:12` is a genuine scalar estimate. It uses Nrad^d<=Z^(Bmask*d), R^d<=A^d Z^(Mcap*d), max(1,radial.scale)<=Z^w, and `ReferenceScalarBounds.lean:60`:

    1+2L log Z <= (1+2L/d) Z^d.

For epsilon>0, Mcap,Bmask>=0, `ZeroGrowthContourBounded.lean:31` chooses

    d=min(1,epsilon/[8(Bmask+Mcap+4)]),
    L=max(Loriginal,Mcap+Bmask+2d)+1,
    saving=L+Bmask*d+2Mcap*d+1.

The main excess d(Bmask+Mcap+1)+3d and the error excess Bmask*d+2Mcap*d-2saving+L are both <=epsilon. For a nonnegative pre-existing loss ell, :16 factors out Z^ell and permits one more d of slack. Hence :64 really derives ZeroAt with loss ell+epsilon from ZeroGrowthAt on the enlarged length range L, with coefficient C(K+1). Here d,L are chosen before S; J,U,C and the eventual threshold are chosen before ell,Q,degree,K. This is a conditional recovery, not a circular proof that arbitrary growth data exist.

The bounded finding closes the source implication just described, not all of its foundations. Remaining lower producers are: actual primitive descent/deleted reflection and Gauss norm; the radial Euler source-seminorm and coupled logarithmic Fourier separation theorems; the paired rowwise scale/Sobolev estimate; the coefficient-column/Euler subpower and actual radial single/pair summability foundations; and the supplied ZeroGrowthAt construction in the induction. Their immediate consuming hypotheses and nonzero/summability guards were checked. The high-band producer below NaturalHighStage was not audited here. No new final premise is proposed, and no claim is made about successful Lean elaboration, transitive axioms, or global QRH.

## 8. Byte-bound source ledger

Whole-file hashes below bind the declaration locations and reconstructed bodies. The ledger is source evidence, not an axiom or build certificate.

| Path relative to B | SHA256 |
|---|---|
| `Energy/ZeroGrowth.lean` | `9B891926385D2746C1397EB0F54AAE7A6AE7F13185CC0C46AD8DBE782332E8AD` |
| `Energy/ZeroGrowthOriginal.lean` | `6282A4B2C61775A1C92E9F62344366560379EEFF92CA529389C8B57A411BCA7D` |
| `Energy/ZeroGrowthBounded.lean` | `CFE04DEFDE47F010997AD64D97B1878E6764F6DAD21E0D09F09F9E8A2C9D9718` |
| `Energy/ZeroGrowthBounds.lean` | `5A56F38CD321E7CE06E8C3C2728EDFA070F9A81F81B049F5BEE3E11E5DD163EC` |
| `Energy/ZeroGrowthReflection.lean` | `0A2A4F63A3F701A950698EA63147A115F01EB72557CC7A3A2B81FDCF4CE52B09` |
| `Energy/ZeroGrowthWindow.lean` | `54D72178AF6C8FBB0E67AA025DB168E307BC1B5A655C74AEE768F99DCF7B3D33` |
| `Energy/ZeroGrowthMoments.lean` | `FF7D1775A03A88BE93C6A7EA904FA8189D71236C638A8F1207AFBD037068939F` |
| `Energy/ZeroGrowthChild.lean` | `9E2C4E26CC2BC7D7467E132652D591B225892CF1788C43FDF8F72DED6E29FFD6` |
| `Energy/ReferenceHomogeneous.lean` | `4A60AD60815EE0FDE3A67BE2B4536F1AC3D49872BEAC37174F79025855E92F45` |
| `Energy/ZeroReflectionSupport.lean` | `12255985128738DABAED630CB8F161009772F2E2BBA74D84D6794B1660C7471E` |
| `Energy/ZeroRetainedError.lean` | `4CCB3231ACA7BF7727721CFFD860B41F1F843A645797D93D65575763FFC3C8C9` |
| `Energy/ReferenceDeletionEnergy.lean` | `7AE940260AE66BA51E370038051C5784A69F21E7515C7A9395E3DFA87BC7CC6E` |
| `Energy/ReferenceDeletionBudget.lean` | `E7813955B749D15B62F044C13CE1DD1B96CF334286843613B8515D9FE8AFF469` |
| `Energy/ReferenceWeightedEnergy.lean` | `FF30671D548C2D4964A6843C240469526706C853DB386F3DD2930D879A7DD81D` |
| `Energy/ZeroGrowthContourBounded.lean` | `4ABC10F8357C64E5EE30F3AD08ABD7173D7700DC87E1F11365FA05413941BB38` |
| `Energy/ZeroGrowthReserve.lean` | `3EB53DF30E9794FE0E35DCF8CD904D217CDFDAAC3501955A77B54151D8A9D3D6` |
| `Energy/ReferenceScalarBounds.lean` | `918BA417C2CA4118EC987E114A8DE94D24AA42A9E2D40824A8A6EF18ED2E6508` |
| `Moments/UniformRadialComparison.lean` | `691A519EBF6299C90CB322973CCE682B2FD7178452CDD06DB2B5388E2AA068C1` |
| `Moments/UniformOriginalComparison.lean` | `C02C85741EE1EA5717538D93FDB4BE7A7EAF68A4B2EEB426FF5079B4522E3A2C` |
| `Moments/UniformOriginalEnergy.lean` | `D100B9A02B83116CEF1030AEB503AF9830239752CC2F57DBC01FFF4F04F45C84` |
| `Moments/UniformReflectionApproximation.lean` | `66B338241929D7FD0CDD5C89887297E4E5EFC4A8F7A100402412602BE3283517` |
| `Moments/UniformNaturalRetained.lean` | `EC3D375978F3C93D9C73E683377F6878959DC8E16EF9BE099B0A64DF7B14C674` |
| `Moments/UniformRetainedEnergy.lean` | `0A266EE17020575CC62DCA913E869E84A1A67BF96E444ECCFB368AFB5DDDFC17` |
| `Moments/UniformReflectionChoices.lean` | `2CD8B7065C189675337009B8CCB08E22C47E842B88F0CF1C32DDBA283EF85054` |
| `Moments/UniformReflectionScale.lean` | `8B386E7DAE475BC10B40DF94EA303A86FC6B70504BD1CFD6C656E4DF92CAC979` |
| `Moments/UniformReflectionProfile.lean` | `C4E46D26256EE55C311D2CF87012E063BAEE70E63408ED79767853988A8B7DCA` |
| `Moments/ReflectedProfileMeasure.lean` | `05D62DFD2A97E8056402C6EE87B564A56299674F1B22762BA52275A8BB50A745` |
| `Moments/RetainedWeightedSource.lean` | `1BF1DA2E2E55CC6E0261E065467D06A649F4500F4102A2E5D84569AAA2F96497` |
| `Moments/ReflectionWeightedEnergy.lean` | `D0F5E51AC23D16494E782D695DD2471501E7F9354C4775BC8DCFD8CB69DE6351` |
| `Moments/RetainedReflection.lean` | `97A698C3726A87BB75ED0FEC23EB29AFB92824714B0B74F74665D9B2570604D9` |
| `Moments/NaturalReflection.lean` | `C8FE9636B9BC40FC0ED280FCE22FEE4C15E6C7D97927BA0626FFC66FF1B15888` |

Prior scope references:

| Workspace path | SHA256 |
|---|---|
| `work/qrh-campaign/agents/integration/QRH_BASE_FLOOR_ANALYTIC_AUDIT_2026-11-11.md` | `7EBE8A5D2A7E2D4B78416A5BB34E1C7EF34E50155A25461A05C698F4989CEF7E` |
| `work/qrh-campaign/agents/moebius/REVIEW_QRH_BASE_FLOOR_ANALYTIC_AUDIT_2026-11-11.md` | `C944E03E2E67AD98B18625573AA18348916D7426C6375E1B11F1F48514414412` |
| `work/qrh-campaign/agents/integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md` | `DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA` |
| `work/qrh-campaign/agents/moebius/REVIEW_QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md` | `9516B5144F691A5D5203C93D737B943E69EFE4A0E4BA4F399A164F833AF75407` |
| `work/qrh-campaign/agents/major-constants/QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md` | `C04D05F95C1747652F28576AC41372702F586F5D85E2849F12CD3E4D28A8D695` |
| `work/qrh-campaign/agents/independent-feasibility/REVIEW_QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md` | `70B618789695E16ECD8F78F81E951D9A7AB02FA6ED55B78CE9A46CD7203C3877` |
| `work/qrh-campaign/agents/audit/QRH_REMAINING_SOURCE_OBLIGATIONS_2026-11-11.md` | `B4FD23DBABB297E057E00A6DFDE4BD3A8164202AA40DC292C090E7C5C3858D07` |
