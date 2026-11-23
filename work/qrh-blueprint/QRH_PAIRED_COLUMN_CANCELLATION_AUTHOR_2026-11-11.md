# QRH paired-column cancellation author report

2026-11-11. Root author report; independent review is pending. This reconstructs the analytic paired-column input left open by the [physical-saving report](QRH_EXCEPTIONAL_PHYSICAL_SAVING_AUTHOR_2026-11-11.md). It is a conditional source-level mathematical argument with the lower inputs in section 8 retained. It is not a new Lean theorem, an approved declaration anchor, a complete dependency graph, or validation of the QRH provider. No build or numerical analytic evaluation was run.

The source base B is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, at revision `4eaee87548250b2682affda7d05d947c05554bae`; M means B/Moments. One-based declaration locations and source hashes below refer to this revision. This report does not change any source file or existing frozen report.

## 1. Exact input to the physical saving

The inspected target is `CenteredMomentFiniteProfileExceptionalCommon.actual_common_better_side`, M/FiniteProfileExceptionalCommonSymmetry.lean:22. For fixed finite slot carrier, fixed radial support interval `[wlo,whi]` with wlo>0 and whi>=0, fixed slot supports lo,hi, positive epsilon,delta,theta, and nonnegative conductor/divisor exponents B,Lbound, it chooses J and a finite Schwartz seminorm set Sprofile containing (0,0). These choices precede Q. For each nonzero fixed ideal Q it chooses K>0 and an eventual threshold in Z. All varying source data and profiles follow those choices.

Write c=Norm(C), d=Norm(D), and

    u=max(rLeft-log_Z(c),0), v=max(rRight-log_Z(d),0).

The conclusion bounds the actual expression

    sum_(L in Ds) |mu(L)| sum_(z in rows)
      |normalizedColumn(s,C,R,seed,L,z)|
      *|normalizedColumn(vSource,D,R,seed,L,z)|

by

    K * #rows * Z^(2epsilon+delta-max(u,v)) * (c*d)^theta
      * profileMass(Sprofile,s,vSource,p,q,J)
      * frozenProfile(s)*frozenProfile(vSource)/(c*d).

Here profileMass is the source expression, not an arbitrary upper envelope. It contains the two pairs of source seminorm controls, `(1+|s.t|)^J(1+|vSource.t|)^J`, both slotControl factors, and the two square roots of the source volumes. Each pair of profiles is supported in the fixed radial interval. The source volumes and normalizedColumn are unchanged.

Both sources have the fixed slot supports lo,hi and slot scales P_i>=1. C,D are supported nonzero ideals; R is nonzero; seed divides both C and D. All four left pair scales are at least Z^rLeft and all four right pair scales at least Z^rRight. Each retained row z is nonzero and has its actual fixed-inducing-row witness for each source, with the fixed bad mask. Each expanded row-conductor bound is at most Z^B, including the source modulus, bad-mask ideal, (72), R*C or R*D, and (z). The only bound on members of Ds is Norm(L)<=Z^Lbound when mu(L) is nonzero. No requirement rLeft>=0 or rRight>=0 is added.

This target is the finite-Sprofile theorem. Substituting an older Tests-based statement without proving uniform control over the varying profiles would leave a gap. It is also an eventual estimate; this report supplies no effective numerical threshold for it.

## 2. Uniform volume approximation for the actual exceptional row

M/HeckeVolume.lean:214, `fixedInducingRow_controlled`, first extracts the actual character witnesses chi0,psi from the fixed-inducing condition. The original chi0 need not have the required conductor bound. The source constructs a bounded-conductor character chi for the same row and transfers induction from chi0 to chi by equality of element coefficients. The primitive psi and ideal containment Q<=psi.modulus survive. These are actual character identities, not a declaration that every row may be treated as principal.

Use the fixed nonzero period k=3*idealGenerator(Q). Its principal ideal lies inside Q, hence inside psi.modulus. The periodic coefficient is psi on primary representatives and zero otherwise. Its absolute value is at most one; its total mass is at most the cardinality of O/(k), which depends only on Q.

M/Lattice.lean:15,60 separates the zero mode of the actual radial Poisson formula. Absolute summability of the transformed lattice sum is supplied before separating or estimating it. The nonzero modes obey

    t * sum_(h!=0) |paperRadialFourier(W)(t*|h|^2)| <= pvControl(W)

for every t>0. The finite Fourier coefficients of the periodic weight are bounded by its total absolute mass. Substitution t=X/|k|^2 therefore gives an error independent of X for every X>0. The zero mode retains the paper-normalized transform and the factor X/|k|^2.

The primary-representative/ideal correspondence in M/HeckeVolume.lean:68 converts this identity to the ideal sum. A finite Mobius expansion supplies the coprime-to-modulus mask. Every divisor rescales X to X/Norm(L)>0, so the same uniform error applies; its coefficient has norm at most one. The actual row vanishes on the bad ideals because its mask contains the lambda and 2 factors. Thus its primaryCoefficient equals its actual idealCoeff. The resulting `actual_induced_volume` has the form

    |sum_I idealCoeff(chi,I)*W(Norm(I)/X) - X*density*W_hat(0)|
      <= divisorCount(chi.modulus) * #O/(k) * pvControl(W).

The density is the exact finite Mobius/residue sum in the source. It may depend on chi and psi, but is independent of X. No positivity of this complex density is used. This reconstruction retains the radial Poisson, lattice-tail, primary-ideal and row-character foundations as lower inputs; it does not validate them transitively.

## 3. Why the rectangle error is linear, not quadratic

Let F_i(X) be the actual twisted ideal sum with profile W_i and common real twist t. M/HeckeTwist.lean rewrites it as X^(it) times the ideal sum with profile W_i(x)*x^(it) on its positive support. Thus

    F_i(X) = X^(1+it)*a_i + error_i(X),   |error_i(X)|<=E_i,

uniformly for all X>0. The same file supplies `|F_i(X)|<=128*b_i*M_i*X` when |W_i|<=M_i and its support is bounded above by b_i>=0.

The leading coefficient satisfies `|a_i|<=128*b_i*M_i`, without an added E_i. M/Counting.lean:82 proves the necessary elementary fact: if |S(X)-X*a|<=E and |S(X)|<=C*X for all X>0, then |a|<=C. If |a|>C, choosing X=(E+1)/(|a|-C) gives E+1<=E. This is why uniformity in X matters. A bound at only the four chosen scales would not justify this coefficient estimate.

Assume all X1,X2,Y1,Y2>=L>0 and X1*X2=Y1*Y2=T. Their leading products agree exactly, including their common imaginary power. Expanding each product as

    (F_1-main_1)*F_2 + main_1*(F_2-main_2) + main_1*main_2

and subtracting gives the bound

    |F_1(X1)F_2(X2)-F_1(Y1)F_2(Y2)|
      <= E*C*(X1+X2+Y1+Y2) <= 4*E*C*T/L,

where E=E1+E2 and C=128*(b1*M1+b2*M2). This is M/HeckeTwist.lean:100 and M/Basic.lean:180. Bounding F_2 directly avoids manufacturing an E1*E2 term. Since T>0, dividing by sqrt(T) gives 4*E*C*sqrt(T)/L.

Two restrictions are essential. Both profiles have the same twist within this rectangle, and the two scale products are equal. This report makes no cancellation claim if either condition is removed. Different twists between the two later columns remain allowed because cancellation occurs separately within each column.

## 4. A finite set of controls chosen before the profiles

M/FiniteProfileExceptionalControl.lean:58 expresses the positive-support twist through the fixed log pullback, an ordinary frequency twist by t/(2pi), and the fixed return map. A derivative of order j of a frequency twist uses only derivative orders i<=j, with the same weight index. For every finite target seminorm set, one therefore obtains a finite source set and a polynomial factor (1+|t|)^J. The continuous linear pullback/return maps transfer this finite control. The fixed assumption wlo>0 is retained throughout.

M/Mask.lean:109 bounds the divisor count by C*Z^epsilon under Norm(chi.modulus)<=Z^B. It applies the ideal-divisor small-power theorem with exponent epsilon/(B+1); B>=0 gives B*epsilon/(B+1)<=epsilon, including B=0. Together with the fixed period mass, this yields M/FiniteProfileExceptionalVolume.lean:16:

    volumeControl(Q,chi,twisted W)
      <= C_Q * sourceControl(Sprofile,W) * Z^epsilon * (1+|t|)^J.

J,Sprofile precede Q,chi,W,Z,t. C_Q follows Q but precedes all the varying data. Inserting (0,0) ensures the source control bounds pointwise norm. For unit-controlled profiles, E1+E2<=2*C_Q*Z^epsilon*(1+|t|)^J, so section 3 gives the normalized rectangle estimate with only one epsilon loss per column.

M/FiniteProfileExceptionalNormalize.lean handles zero control explicitly. Because (0,0) is included, zero sourceControl forces W=0. Otherwise division by sourceControl gives a unit-controlled profile, and bilinear homogeneity restores exactly the product of the two controls. No positive lower bound on a profile or seminorm is imposed.

M/FiniteProfileExceptionalRow.lean transfers this to the actual row. M/FiniteProfileExceptionalCapped.lean uses cancellation for L>=1 and an absolute bound for 0<L<1. The result has denominator max(1,L). It does not apply an L>=1 theorem to the smaller extracted scales. Empty support or zero profiles cause no exception.

## 5. Allocation and the retained denominator

The live slots are bounded absolutely with their coefficient and support factors. M/FiniteProfileExceptionalAllocated.lean applies the capped result to the residual pair scales, dividing the pair volume by the selected plain norm and retaining the live slot volumes. If d0 is the actual formalReductionFactor, the resulting residual volume is V/d0 and its lower scale is Z^r/d0. Slot scales P_i>=1 supply the required lower-scale comparisons. The exact cap is

    max(1,Z^r/d0) = Z^max(r-log_Z(d0),0).

M/FiniteProfileExceptionalAmplitude.lean combines the residual estimate with the actual allocated energy identity. If F is the frozen coefficient majorant, Lslot the live slot majorant, H the profile/twist/error factor, and cap the preceding cap, the scalar calculation is

    F^2/d0 * (H*Lslot*sqrt(V/d0)/cap)^2
      = (H*F*Lslot)^2 * V/(d0^2*cap^2).

Since F*Lslot<=slotControl, taking the nonnegative square root gives a denominator d0*cap, not sqrt(d0)*cap. All divided quantities are positive. This distinction affects the subsequent shell count.

For the pair of columns, multiply the two individual bounds and discard only the right cap, which is at least one. Put x=log_Z(dLeft), y=log_Z(dRight). The remaining weight is exactly

    Z^(-x-y-max(r-x,0)).

Each column pays Z^epsilon, giving Z^(2epsilon). M/FiniteProfileExceptionalCommonAsymmetric.lean also replaces r by max(r,0) without changing the weight: P_i>=1 implies dLeft>=1, so x>=0 and the two nested maxima agree. This identity would fail for arbitrary dLeft<1.

## 6. Why summing divisors does not consume the saving

The sum retains only L with mu(L)!=0; these ideals are squarefree and nonzero. For an active right allocation, the actual support boundary in M/ActiveDivisorShell.lean:45 is

    n=log_Z(Norm(L)) <= y + allowance(right,Z).

Write A for that allowance. The exact scalar identity

    -x-max(r-x,0) = -max(r,x)

then proves

    -x-y-max(r-x,0) <= A-r-n.

The right column's support data supplies an inverse Norm(L) factor, while the left cancellation supplies Z^(-r). No oscillatory cancellation of Mobius signs is needed. Both facts depend on the actual active allocation, not on a bound invented for arbitrary allocations.

M/ExceptionalAllocationShell.lean sums this estimate over a dyadic norm shell U<=Norm(L)<2U with U>=1. Each side's allocation count is at most C_e*Norm(L)^e for fixed finite slot carrier. There are at most 256U ideals in the shell. Consequently the shell costs at most

    256*C_e*C'_e*(2U)^(2e)*Z^(A-r).

The inverse norm cancels the shell's linear U. Uniformity over all subsets of the fixed slot set is obtained by a finite sum of constants. It is not uniformity over an unbounded number of slots.

For U<=Z^Lbound, choose e=deltaShell/[2*(Lbound+1)]. Then U^(2e)<=Z^deltaShell. The fixed right slot windows give

    Z^A <= exp(sum_i logWindow(lo_i,hi_i)),

with no additional Z-power. This explains why only the right support intervals need to be fixed in the asymmetric statement.

M/WholeDivisorShell.lean partitions the live divisor set into disjoint half-open dyadic shells using floor(log_2 Norm(L)). Their count is at most `(3+Lbound/log(2))*(1+log Z)`, and hence eventually at most C*Z^deltaCount. M/ExceptionalWholeSource.lean:26 takes deltaShell=deltaCount=delta/2, retains the exact Mobius weights with |mu|<=1, and obtains

    sum_(L in Ds) |mu(L)| sum_(active a,b) weight <= C*Z^(delta-r).

This covers empty live sets, the unit ideal, negative r, and Lbound=0. The threshold is chosen before the varying divisor set and r. Combined with section 5 at max(r,0), it gives the masked-column exponent `2epsilon+delta-max(r,0)`.

## 7. Common allocations and choosing the stronger side

M/CommonExceptionalGates.lean shows that each coordinate ideal of a common allocation divides C, so its norm is at most c. Thus extraction changes the lower-scale exponent to rLeft-log_Z(c), with the analogous right exponent. It also computes the expanded row conductor exactly. Mask-induction equivalence retains the actual Q-inducing witness; it does not add a coprimality assumption between Q and C or D. M/FiniteProfileExceptionalCommonGates.lean discharges all fourteen ProfileAdmissible fields with these identities and the original source hypotheses.

For each common allocation, M/CommonExceptionalCost.lean retains the exact scalar/volume normalization. Its bound is

    |commonScalar| * sqrt(commonVolume)
      <= frozenProfile(s) * sqrt(originalVolume)/c.

The zero frozen-coefficient case is handled separately. In the nonzero case, actual support supplies the rawReduction lower bound needed for the factor 1/c. The common slotControl is at most the original slotControl because deleted factors are at least one. M/CommonExceptionalMass.lean and the finite-profile counterpart therefore bound the paired profile mass by the original mass times frozenProfile(s)*frozenProfile(vSource)/(c*d).

The number of common allocations is bounded by K*c^theta on one side and K*d^theta on the other. Their product is K^2*(c*d)^theta, not (c*d)^(2theta). The scalar inequality is applied to the actual finite allocation expansion of normalizedColumn. M/FiniteProfileExceptionalCommonSource.lean:25 supplies the left-saving bound in section 1 with max(u,v) replaced by u.

Finally apply that same uniform theorem to the swapped sources, profiles, ideals, and lower-scale exponents. Both original sources now need the fixed slot windows. The nonnegative product sum and its profile majorant are symmetric. The same K,J,Sprofile and threshold work for both applications. Choosing the better bound gives max(u,v), with no factor two. This does not justify replacing max(u,v) by u+v.

## 8. What this author report advances, and what remains

The previously opaque paired-column producer is now a sequence of explicit mathematical steps: fixed-period volume approximation; equal-product cancellation; finite profile control; residual allocation normalization; one-sided divisor-shell saving; common-allocation mass; and symmetry. At this reading depth no defect was found in those implications. This advances the named paired-column boundary only at author level.

The following remain lower obligations or separate work, rather than new assumptions permitted in a final Goldbach theorem:

* The actual paper-normalized radial Poisson formula, transformed lattice summability and uniform pv_lattice_bound; the finite Schwartz controls of the fixed log maps. Existing Fourier/radial reports have their own bounded scopes and are not silently promoted to cover every use here.
* Ideal-ball counting, ideal-divisor and allocation small-power bounds, primary-representative identities, actual row-character completion and the transfer of inducing data, fixed-mask induction equivalence, and the active-allocation support boundary. Their exact applications were inspected, but this report does not rebuild all their proofs.
* The finite source-to-residual and source-to-normalizedColumn identities, including nonzero frozen-coefficient support and slot products. They are genuine source identities used by the argument; they are not replaceable by freely chosen majorants.
* The separate [fixed-Q row-count author argument](QRH_FIXED_Q_ROW_COUNT_AUTHOR_2026-11-11.md) and [physical-saving author argument](QRH_EXCEPTIONAL_PHYSICAL_SAVING_AUTHOR_2026-11-11.md) still require independent review. They are complementary inputs, not consequences of this analytic argument.
* Compatible Lean elaboration, expanded theorem and definition audits, and transitive axiom checks of the QRH provider remain undone. No finite RH or GRH premise is used in the reconstructed argument above, but that is not a kernel-level assertion about its complete import closure.

The selected Goldbach route is unchanged. It still requires the complete `.555/.56` finite spectral family, the principal RH/count/moment head, finite prime replay, the genuine global provider, and the new consumer proofs. This report produces none of that spectral data and does not establish a QRH-only proof of ternary Goldbach.

## 9. Verification record

The companion [rational scalar checks](paired_column_scalar_20261111.py) exercise the max identities, allocation normalization, shell exponent implication and negative controls for weakened premises. The run passed 696 max/shell examples, 96 allocation-normalization examples, 54 shell-budget examples and five negative controls. They perform no L-function, zeta, theta, Gamma, prime-sum or floating-point evaluation. These are checks of algebraic examples alongside the general arguments, not a proof of the analytic lemmas or of termination of a spectral checker.

The live inventory again reported six terminal usage-limit errors and one completed author agent. No failed agent was restarted and no independent PASS is claimed for this report. Source revisions and the mutable ledger/checkpoint were checked before writing. All source and support hashes below were verified against the actual files. No existing report or frozen strategy was modified.

DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0

## Evidence pins

The following appendix binds the inspected source files and explicitly retained lower interfaces; inclusion is not a claim that every declaration in each file was audited. Source locations are relative to B.


| Source file relative to B | SHA256 |
|---|---|
| `Moments/Basic.lean` | `FAFFDAADA158B8BFD79FE5D2CB8306EF964B7E2EBCD8C9112CF0CC5269595A89` |
| `Moments/Counting.lean` | `A16733E0EC8800895D5EC29129856758957F6A21ECE810956F812EB818523FF3` |
| `Moments/Lattice.lean` | `2B654A58F4C0FC8510679BCF5A5D5FA2BED33A4E7A12DAF7E4A354FC198B79C7` |
| `Moments/HeckeVolume.lean` | `A3C27FEBDAB33714B807888A120CBB6CA89F716369161A75E524FAA70AEFEF04` |
| `Moments/HeckeTwist.lean` | `1D75E168889B0DD60D2C66E7984F9C999B6A83C6D882E66277358C23B561BA0A` |
| `Moments/Mask.lean` | `1DC9E461D022F9D744F777D93C0EB256CA83240A5A7ED75BA3F729E31FC21C79` |
| `Moments/FiniteProfileExceptionalControl.lean` | `9294C44A21FD53FB38507C1CF826A9A54DC77BF533EE4E1CB206565804FCBB27` |
| `Moments/FiniteProfileExceptionalVolume.lean` | `3E8720E0AA3772428797BB408D3BF72FFE7D2E1CB880B54CB9FC60C8A1E7861C` |
| `Moments/FiniteProfileExceptionalUnit.lean` | `6D9DB2127268654B9B685AAD7548BFCDBEE7B6C3AE4A5EF3EE8998CE1522B5E6` |
| `Moments/FiniteProfileExceptionalNormalize.lean` | `63962CAB986744C497AA52A2770CF1AACA8C810919DD332D3AFF93125B2FC1DC` |
| `Moments/FiniteProfileExceptionalRectangle.lean` | `9D68A2EFA7A8D23759BB1B8838AF56BFA3C6F17F8F9A9080A1BB413450334697` |
| `Moments/FiniteProfileExceptionalRow.lean` | `7344C935A1049D7AF7DDC5F2071B2BAC6191ADAA96E525BCBDA61A2A2196BD24` |
| `Moments/FiniteProfileExceptionalCapped.lean` | `BAAE0FBF2BD5D7A9708D53CEBC49AB0C7B3CAD07849B420DDC7A57C2BEB22DB8` |
| `Moments/FiniteProfileExceptionalSlots.lean` | `D46AC7EBBBDACFE0CCE0A8EEC5D8FF74018960349C6FD205FB0CD3351C5BF80A` |
| `Moments/FiniteProfileExceptionalAllocated.lean` | `1AB2DF78D11327915ECA06613258BFB5115931731B84BBA8B3D7A5AC6DF2CFA5` |
| `Moments/FiniteProfileExceptionalAmplitude.lean` | `E533E9256A21F642A699B2D47C9B5F9D629048207E2F6494321ED828876323C2` |
| `Moments/FiniteProfileExceptionalPair.lean` | `F4E6A790FAFC9DCE047FBBC0ACC3FBB01643B288050E79A7EF3E3FF1E406028D` |
| `Moments/FiniteProfileExceptionalCommonAsymmetric.lean` | `D9A267152375BCDE237D8DF6E31AAD2502F1637D68A791A5C0FAC210B713C0BB` |
| `Moments/FiniteProfileExceptionalCommonMass.lean` | `F35011B21CA61E1C2032595F43CAAC85FD8A37B81709B0F8C845E67201E45CFB` |
| `Moments/FiniteProfileExceptionalCommonGates.lean` | `D86A6049CC2003782FEA9DE3605CF79EEC0A5D5942D04F4AF0F1E05EAC3F1A47` |
| `Moments/FiniteProfileExceptionalCommonSource.lean` | `3215AC37EBDA8D7830FA0D5B20591FFB92A5A4CDD9444F4A2ABB708843BDE434` |
| `Moments/FiniteProfileExceptionalCommonSymmetry.lean` | `2DBDC6B649C7A0A1E915D9A911E1975C330ACA7689E47E7EDF2E66B0796E308E` |
| `Moments/ActiveDivisorShell.lean` | `7615F59BDBA12C6766FF35EA65E1045DD88E2F22BE75F3E3129ECCC49746221A` |
| `Moments/ExceptionalAllocationShell.lean` | `23AF9F0926FD8BF637D60C5AB42DD113E17A783766B4F43E5A1FEBAD7F3B0C8A` |
| `Moments/ExceptionalWholeSource.lean` | `A04B1C0AE30DF63443412198C1FB6B2F5392D5432355EA5CAE6E310D29EE16B5` |
| `Moments/WholeDivisorShell.lean` | `FD28E5E55631D7445D41442FD8526005981E4FD38798DCD26433EB2BAC226E42` |
| `Moments/UniformDivisorShell.lean` | `4D61F76DF095A0BD22D5FEF8FEEEDDCD6BBF40C101E6DC90824199BBC7668BB3` |
| `Moments/CommonExceptionalGates.lean` | `0B81EE0128007E1946DB573A3C3B54B35729D7CC1838C99493B76337AF9B3F0D` |
| `Moments/CommonExceptionalCost.lean` | `3035C53EE716FF75541A45213712F2FB86C4CF9E86374A00A86987743E1B23DD` |
| `Moments/CommonExceptionalMass.lean` | `4F930C9C03F48009A5E70194C9FD755F0C917C7FF81FEB8D7F66114348CB803F` |
| `Moments/CommonPairedSource.lean` | `3DDDB08AFD7009FAB9AC5AD6A520B3385E70BBDD6C02FF78FD9FD4A72313663C` |
| `Moments/ExceptionalMaskedSource.lean` | `E30F495343E0295A4D5D362740338713FE68FC4EAD76F782CD1D1C2E7502A31E` |

| Context artifact relative to workspace | SHA256 |
|---|---|
| `work/qrh-blueprint/QRH_EXCEPTIONAL_PHYSICAL_SAVING_AUTHOR_2026-11-11.md` | `7AAB71EBE62B6BF513922FED1D46711E355565127CADB792104076A3CD5E1F0A` |
| `work/qrh-blueprint/QRH_FIXED_Q_ROW_COUNT_AUTHOR_2026-11-11.md` | `05B4819F167FB47E57B770484E9E708ED7D7401AC30AF940DF7FD9AE1F0D9C6F` |
| `work/qrh-blueprint/SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md` | `D0F77CCCFCE45DBFE5C863643236107ECBBE4D363103A70BB06CE57213A42CB7` |
| `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md` | `F5276E1C93B959BFC4D86A58BEFAA4666E320454CDC9B2CC2804EEEBE354FEBB` |

Scalar script SHA256: `0A6A0DB51CCF7C7CEA171558DF2EE57C79E2D7A55EBD0BD551E98540BD47ED15`.
