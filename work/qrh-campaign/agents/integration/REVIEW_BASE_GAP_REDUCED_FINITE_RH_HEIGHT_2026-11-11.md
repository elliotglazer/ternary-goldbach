# Independent review of the reduced base-gap finite-RH heights

2026-11-11. **PASS at conditional paper/source scope; no correction requested.** Reviewed `independent-feasibility/BASE_GAP_REDUCED_FINITE_RH_HEIGHT_2026-11-11.md`, SHA256 **776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898**.

The stated finite-RH premises suffice for the actual base-gap consumer at R=132900, under the retained principal and source inputs. They do not recover the old .014 intermediate guard. No finite spectrum, global union of heights, or computational saving is accepted by this review. No analytic values or builds were run.

## 1. Geometry, primitive conductors and ceilings

I read both branches of `BaseGap2.gap_point:185–227`, not just its weaker common conclusion. At x=49y the odd branch retains 4R/(49m)<=|d|<4R/m, and the even branch retains 8R/(49m)<=|d|<8R/m. The existing declaration is hardcoded at r0; a natural-R version retaining this branch information is still a formal adapter. Its source proof gives the stated paper geometry. The lower boundary is included and the upper excluded.

`S_etaStar_eq_expTsum:229–238` supplies Lambda(n)etaU(n/y) and phase d/y. There is no extra 49 in the error normalization. The reduced denominator for twice the phase is distinct from the character modulus m.

Every nonzero Gauss-weight ancestor has c|m. A primitive conductor cannot have exact 2-adic valuation one: for c=2r with r odd the unit group maps isomorphically to that modulo r, so a character at 2r is induced. Thus the nonprincipal ancestors are odd c>1 or 4|c. For odd c induced into even m, the integer m/c is even, so m>=2c. These facts give exactly the two D_c bounds and conductor ranges in the author note, including all imprimitive ambient labels. Inversion preserves the conductor and permutes its primitive labels.

Set T_c=27000000/c or 54000000/c. The minimum exceeds 203, and both T_c/(pi D_c)>16.1. Hence max(10pi|d|,50)<=T_c throughout the closed auxiliary range. The premise at ceil(T_c) supplies GRHUpTo at T_c by inclusion of closed zero carriers. The proof does not round down a required height or assume RH in the interval from T_c to 10^8/c. In fact ceil(T_c)<10^8/c also follows from 54000000+265800<10^8, but that observation is not used to obtain the finite-RH premise.

## 2. Actual source error and old-height comparison

`Cor933.err933New:382–386` contains all four displayed terms. `cor_9_3_3:490` accepts an arbitrary real working height satisfying its explicit admissibility and GRHUpTo hypotheses. For c>1 its main term is zero. `ExplicitBound.norm_Ssum_le:95–115` passes the finite zero bound through the good-height explicit formula and includes the left-line integral. `ZeroSumBound.norm_G_tail:105` applies on the full strip −1<=Re(s)<=1 above T; it requires no QRH or upper bound beta<1 stronger than the nontrivial-zero strip.

The new use of old numerical lemmas is legitimate. In `ZeroSumBound:287–313`, Jl(T)=floor(T/3.48)+1 is nondecreasing for positive T. The two square-root factors are nonnegative and nondecreasing. BP and its logarithm are nondecreasing on positive heights, so ZL and E1b are also nondecreasing. Therefore

    E1b(c,T_c)<=E1b(c,10^8/c)<=3.42e6/sqrt(c).

The same BP comparison gives Z3(c,T_c)<=177.26. These are comparisons of explicit upper-bound functions. `Cor713:311–419` supplies them without a PlattGRH binder. E0b and Vb at `Cor713:510–564` apply because c<300000 and |d|<=1063200/c<1200000/c. The bundled finite-RH convenience theorem starts only at line 802 and is not used for the nonprincipal deduction.

The principal branch remains separate: `Cor713.err933Z_le:774` plus `Cor933` uses only the retained principal RH height 10^8, with |d|<531600<1200000. Localizing this deduction rather than importing a blanket PlattGRH hypothesis remains necessary in implementation.

## 3. Independent error calculation and unbounded y

I reconstructed the two finite positive Taylor-polynomial certificates with direct rational powers and factorials, without importing or executing the author's script. They imply exp(-32)<1.3e-14 and exp(-27.6)<1.1e-12. Monotonicity of t exp(-.1598t) for t>=203 and u² exp(-.1065u²) for u>=16.1 gives the claimed EB and EA bounds. At d=0, EA is exactly the source's separate zero branch.

The B geometric factor is less than 775 using Z3<=177.26, c3<.2 and (1−rhoB)^(-1)<2.18. Its sqrt(c)-weighted contribution is below 9.42e-7.

For the A factor, (1−exp(-t))^(-1)<=1+1/t and pi/(1.93*4.4)<.371 give a+bK/c. Expanding before bounding c is essential. Multiplication by sqrt(c) produces the linear part 354.52*(a sqrt(c)+bK/sqrt(c)) and the quadratic part bounded by

    (82/27000000)*(a² c sqrt(c)+2abK sqrt(c)+b²K²/sqrt(c)).

With sqrt(c)<516, c<=265800 and 1/sqrt(c)<=1, this is exactly the author's rational expression; its EA-weighted value is below .023567. No cancellation among zeros was used.

The normalized low term is below 1.5e-6 after multiplying by sqrt(c), since 1.37259*3.42e6<4.7e6 and sqrt(y)>3.16e12. The origin and vertical terms are each below 1e-20 before that multiplication. Their weighted sum is below 2e-17. These terms decrease as y grows; the tail terms do not depend on y. Thus the full estimate sqrt(c)*err933New<.02357<.024 holds for every y>=10^25, without any hidden upper scale cutoff.

## 4. Weighted energy, removals and the actual consumer

The Gauss square c cancels the 1/c in the squared primitive bound. Counting all supported nonprincipal ambient labels gives Efull_m<=.024² Dnp_m/phi(m)<=.024². This is a weighted finite identity, not an average across the family.

The coprime restriction changes each normalized primitive character sum by at most d0=2e-9, using the actual noncoprime coefficient mass. Orthogonality of the finite character transform gives sum_psi|tau_psi|²=phi(m)². Consequently vector Minkowski yields

    sqrt(E_U,m)<=.024+d0 sqrt(phi(m))
                 <=.024001032<.029.

There is no assertion that the restricted and unrestricted energies are equal. The separate outer removal is still charged in the final additive estimate. At m=1,2 the nonprincipal part is empty, and the retained principal bound covers those cases.

I checked the exact consumer report **CFDA417AFFF112EBDF7BBB822FE7C884F3F8FCB4307BBC2F5AAC3B6856D5D264** and its normalization. The source Fourier main-term estimate and finite totient comparison give .000544; the principal residual gives 2e-6; outer plus principal removals give 4e-9. Their sum with the actual nonprincipal norm is .024547036<.03. The retained rational lower envelope 435635673/13700000000 exceeds .03. This therefore reaches y*ghatY(y,R) directly. It cannot be passed through an unchanged theorem demanding .014 or .0121. `MinorTotal:395–403` exposes the relevant envelope use; its natural-R source-level adaptation remains a formal proof obligation.

## 5. Scope and evidence

The algebraic comparison with the communicated plus height is sound, conditional on that candidate's separate proof and identical conductor domain. It supplies no such proof and does not adopt the maximum with the major-star requirement. Principal and exact head-data obligations remain unchanged. Actual finite-RH certificates and formal assembly remain open.

Independent evidence: **43 exact checks passed**, with all ten retained source/report pins matching. The checker recomputes the Taylor lower bounds, expanded tail expressions, all-scale scalar margins, ceiling comparison, removals and ghat budget. It performs no zero, prime-sum or special-function evaluation.

* `integration/review_base_gap_reduced_height_20261111.py`: **445DD8916F215DFF77EE93C2BABAB78AB7F10B02EF79E17C151AC4970A071AB4**.
* `integration/review_base_gap_reduced_height_20261111.json`: **98CC1BD4D23827445606CB2825C3C1C4368902C0B3404D981B4813011327FFEC**.

The receipt records the complete source paths and hashes. This review accepts the stated conditional mathematical implication at those source interfaces; it is not a recursive proof audit, compiled theorem, or final-axiom validation. Existing source and frozen reports were unchanged.
