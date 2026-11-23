# Bounded byte-cost optimization of Horner grids

2026-11-11. Conditional circuit and exact metadata research. The search evaluates integer grids, rational error envelopes and declared ordinary-PA product-template counts only. It evaluates no coefficients, functions, tables, quotients, primes or transforms and runs no build. No frozen report, selected ledger or spectral boundary is changed.

**Result.** Within the explicitly bounded monotone grid family and product-only cost model below, the minimum is15442 macro events per degree19 complex Horner evaluation. The earlier linear-grid profile costs16252 and uniform b100 costs17632 when all three are repriced using the same sufficient widths. The minimum profile also has a larger certified error reserve than the linear profile. This is an exact optimization of one declared arithmetic subtotal, not of total proof work or runtime.

The selected minimum-subtotal profile, in increasing degree order0..19, is

    [100,100,100,100,97,95,95,95,89,87,
     87,87,81,79,79,79,71,71,71,71].

It has error envelope5253/2048 times u, with u=2^-100, leaving625/6144 times u against the old8/3 allowance. It uses seven nonzero alignment shifts, maximum8 bits and total29 bits. Those shifts remain separately priced. The receipt retains all74 nondominated cost/error profiles and all their stage widths.

## 1. Exact circuit and admissible search family

Consume the original, source-bound degree19 polynomial P(h)=sum z_j h^j at real h=r/v, v=2c>0 and |h|<=1/4. The selected conductor cap is265800, so |r|<=132900<2^18 and v<=531600<2^20. The source coefficients have the quantified general margin below40665. All original source/EM, coefficient uncertainty, analytic shift and target remainder obligations remain.

Choose integer b_j satisfying

    b_0=100,  100>=b_1>=...>=b_19>=70.

Convert every ORIGINAL z_j directly to its chosen coordinate grid2^-b_j, ties toward positive infinity. This creates z'_j=n_j/2^b_j and a new named polynomial. Do not first round to b100 and then round again without paying that separate error. Initialize A_19=z'_19. At stage j18..0, round hA_(j+1) to grid b_j and add z'_j exactly. The final output is already on grid100.

If the input coordinate is M/2^b_(j+1), compute rM first, then apply the exact left shift delta_j=b_j-b_(j+1). The resulting numerator X=rM2^delta_j is divided by v for nearest rounding. A supplied L is checked by one signed product Lv and -v<=2(X-Lv)<v. Thus the two priced products are rM and Lv. The shift is not absorbed into a wider multiplier and then counted as though the old narrow factor remained. Signed residuals, bounds, output ties and exact coefficient additions retain their ordinary proof costs.

The source packet for this circuit is root DEGREE_DEPENDENT_HORNER_GRID_PROPOSAL_2026-11-11.md, SHA `0249787E3EC22DAC609C28FE62CE847A8389CDB6D81ADD5A65D783A872A5DE12`, independently reviewed in this directory at `D475972DB3EBDEC46D1AAB5DC5D4CBD7D7C157936E333ECE46737F45C34DC5E9`. This note extends its allowed grid vectors and proves the common bounds needed below; it does not treat that fixed-profile review as proof of a different vector automatically.

## 2. Uniform error and magnitude proofs for every searched profile

Nearest coordinate rounding has complex error less than(3/4)2^-b, since sqrt(2)/2<3/4. Direct coefficient conversion and the Horner error recurrence therefore give total error strictly below

    E(b)u = (3/4)u [sum_(j=0)^19 2^(100-b_j)4^-j
                     +sum_(j=0)^18 2^(100-b_j)4^-j].       (1)

Each stage-j product round acquires the factor h^j from subsequent stages; the highest initial coefficient is copied without a separate accumulator round. Equation(1) remains valid at h=0, both displacement endpoints and arbitrary correlated errors. Require E(b)<8/3. This preserves the inherited evaluation allowance and its absolute character/conductor factor633. The actual source errors remain separate. Mixtures with other admitted evaluators retain the old whole-band1688u cap unless actual subset weights justify a sharper cap.

For all searched b>=70, the coefficient conversion error is below1, so |z'_j|<40666<C=2^16. Use C=2^16 consistently for every profile, rather than improving one competitor's magnitude bound alone. Each product round is also below1. Starting with |A_19|<C, induction gives

    |A_j| < Bstar=4(C+1)/3 <2^17.

The rounded product has norm below Bstar/4+1=(C+1)/3+1<2^15. Thus every coordinate L has magnitude below2^(b_j+15). This is a sufficient tighter bound than the earlier proposal's b_j+16; all compared profiles are repriced with it. The initial input n_19 has magnitude below2^(b_19+16), while other input states use the common b_(j+1)+17 bound. No observed coefficients or cancellation enter this sharpening. It also covers negative nearest ties.

Consequently the product operands' magnitude widths are

    rM: 18 and b_(j+1)+17 bits, except j18 uses b19+16;
    Lv: 20 and b_j+15 bits.                              (2)

After the exact shift, |X|<2^(b_j+35), including arbitrarily sized permitted delta_j; the first stage has an extra bit of slack. Lv has the same strict bound2^(b_j+35). Safe signed capacities are b_j+36 for each shifted/witness product, b_j+37 for their raw residual, and b_j+38 for a doubled residual. The signed accumulator fits b_j+18. These bounds concern raw operands before cancellation. They do not make the shift or residual check free. A half-v range test can avoid doubling only with its own exact identity/proof.

## 3. Declared byte-schoolbook objective

Let ceil8(w)=ceil(w/8). The previously specified rectangular ordinary-PA template is M(m,n)=5mn+2n+1, with n outer rows. Both narrow factors in(2) fit3 bytes; every variable operand is longer, so the chosen direct orientation is M(n,3)=15n+7. It is not the more expensive M(3,n). A complex product uses two coordinate products.

For a grid vector define

    D(b)=ceil8(b0+15)
          +sum_(j=1)^18 [ceil8(b_j+17)+ceil8(b_j+15)]
          +ceil8(b19+16).

The complete charged product subtotal is

    Cost(b)=30D(b)+532.                                 (3)

The532 is2 coordinates times2 products times19 stages times the7-row-overhead term. The special last term accounts for the sharper first input; no generic-state bound is used to overprice that one coefficient copy. The same formula is used for the optimized, linear and uniform profiles. Padding, range proof and possible leading-zero trimming still require their representation adapters.

This objective charges only the two numerical multiplication proofs per coordinate/stage. It excludes alignment shifts, coefficient conversions, signed wrappers, exact coefficient additions, residual reconstruction, comparisons, quotient discovery, table/library setup, numeral terms, unification, cache traffic and complete source binding. In particular a byte boundary is not a runtime boundary in another representation. Different multiplication algorithms, fixed-factor schedules or bit/radix choices define different objectives. The earlier fixed-factor-table comparison is separately pinned below and is not assumed as a universal lower bound.

## 4. Exhaustive bounded dynamic program

All weights in(1) are dyadic. Scale the bracket by2^38 and define

    w_j(b)=(2 if j<=18 else1)*2^(138-b-2j),
    W=sum_j w_j(b_j).

Every exponent is nonnegative for j0..19,b70..100. Exact strict feasibility is

    9W <32*2^38.                                       (4)

The algorithm begins with b0=100, its node cost ceil8(115)=15 and weight2^39. After degree j, a state is(last grid b_j, accumulated digit cost). Its value is the least W attained by any monotone prefix with that key, together with one realizing vector. The next grid ranges over every integer70..b_j. Add its exact node cost from(3) and w_(j+1); discard a prefix only when it already fails(4), since all future weights are positive. At equal W, a deterministic lexicographically larger prefix is retained for reproducibility.

This state compression is exact: prefixes with the same last grid and cost have the same future admissible grids and future cost/weight increments. A prefix with larger W can never improve feasibility or error reserve. The transition examines all bounded continuations, so induction proves that every retained state has the optimal W for its key. Minimizing over last grids then gives the best error envelope for every feasible cost. Finally discard any cost whose best W is no better than an already cheaper cost. This proves completeness of the saved cost/error Pareto frontier within the stated grid domain and objective. It is not a global optimization over arithmetic circuits.

The run examines104533 transitions, ends with1435 states, and finds74 feasible digit costs, all nondominated after error minimization. Their digit totals run497..570, giving74 profiles at30-event increments. The smallest cost is therefore15442; no admissible monotone profile in the bounded family has a smaller declared subtotal. The30-second abort guard was not triggered. This run is scalar search evidence, not a timing benchmark of a numerical or proof backend.

## 5. Error-reserve choices and matched baselines

The following rows use the minimum cost whose envelope reserve8/3-E(b) meets the stated request. The exact vectors and stage rows are in the receipt; reserve is a property of the proved error envelope, not measured numerical error.

| Required reserve in units u | Product events | Actual envelope reserve |
|---:|---:|---:|
|1/24|15442|625/6144|
|1/12|15442|625/6144|
|1/6|15472|1489/6144|
|1/3|15532|257/768|
|1/2|15682|6479/12288|
|1|No admissible profile|—|

For the15472 row, change only b16 from71 to73 in the minimum vector. The complete frontier is retained rather than choosing a reserve as a new production requirement. Uniform b100 has the largest reserve in this domain and still falls short of1u, so the last rejection is not an arbitrary search cutoff.

The minimum profile has D=497 and E=5253/2048. Its reserve625/6144 exceeds the earlier linear profile's262171/6291456. Under the same sharper L bound and first-stage rule, the linear profile100,100,98,...,81 has16252 product events, while uniform100 has17632. Thus the reductions of this subtotal are810 and2190, respectively. The comparison does not reuse the earlier linear cost under a different width convention.

The minimum profile has seven nonzero shifts of sizes3,2,6,2,6,2,8, total29, rather than the linear profile's eighteen nonzero shifts totaling19. Uniform100 needs none. This extra shift/term work, different cache grid vector and output conversion costs must be included before any adoption. Both old and new profiles still perform nineteen stages, nineteen exact complex additions and nineteen complex product rounds; the highest coefficient copy remains exact. Nothing reduces the number of required unit residues or height/character outputs.

## 6. Source pins, evidence and next gate

The uniform comparator audit/B100_PRODUCT_ONLY_HORNER_2026-11-11.md has SHA `84E9E1491DE668337E0DACFCFFFBA7F6CDEBDAE6479929EB6CC097D2535D9A6C`. The narrow-factor price comparison B100_HORNER_FIXED_FACTOR_PROOF_REUSE_2026-11-11.md has SHA `973FA8095EA9BC4768B1D50B70AB0218FE730508C46E7BC37F68B5E944381CE0`. Its rectangular-template citation should be read as section3 of integration/EFFICIENCY_MM0_LADDER_ARITHMETIC, as its independent reviewer recorded. The two root linear-profile pins are in section1. All four are checked by the new script.

Owned script optimize_degree_horner_grids_20261111.py, SHA256 `CB760828296AB00D2469B06B53FEE3BE2980B815186CED384D36DF94BD225AA8`; receipt same stem JSON, SHA `9BA037D7AAFB7A0F053C109ABD9751112B586805236A14D9467EFD29B32871CE`. All1767 exact assertions pass, including every saved profile's stage-cost decomposition, strict budget and monotonicity. The receipt retains the layer sizes, transition count, complete Pareto vectors, stages and both repriced baselines. It contains no coefficient values or production outputs.

Independent review must verify the DP completeness argument and widths before this becomes an accepted planning input. A later implementation still needs generic soundness, actual direct conversions and quotient witnesses, full ordinary-rule checking, exact cache/coverage bindings and a complete cost comparison. This note does not select an evaluator or claim a total proof-work saving.
