# Signed Horner schedules and break-even costs

2026-11-11. Paper circuit and exact rational metadata only. No function, coefficient, prime, zero or transform values, builds or new declarations were evaluated. The three grid profiles and their mathematical error bounds are unchanged. This packet completes a symbolic schedule around the previously reviewed product counts. It does not implement an arithmetic proof generator or select a winning profile.

The new acceptance schedule checks every nearest-round witness by ordinary signed equalities and one nonnegative slack equality. It gives explicit addition-template counts as well as product-template counts. All remaining work is represented by named costs, including direct source conversion, sign/range lemmas, shifts, exact input/output binding, proof representation and witness generation. No missing item is set to zero in a claimed total.

## 1. Inherited inputs and fixed profiles

Consume moebius/FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md, SHA256 `96734A7E4A0C93857EE538A59890451C40644AAAA0D0F07FE9D82B936509C0D3`, and independent-feasibility/REVIEW_FIXED_HORNER_DEGREE_ENVELOPE_REPRICING_2026-11-11.md, SHA `57D7DEDBA4D5497861DD641F4CC68416CA89EEAD0358F2151DA005ABCE319468`. Its source acceptance and stored finite-polynomial semantics remain explicit dependencies.

The profiles are uniform b_j=100; root-linear100,100,98,...,81; and the fixed vector

    [100,100,100,100,97,95,95,95,89,87,
     87,87,81,79,79,79,71,71,71,71].

At a bound actual source array, degree j is converted DIRECTLY from its original center to grid2^-b_j. Let e_j=(3/4)2^-b_j, C_j=Z_j+e_j, A_19=C_19, T_j=A_(j+1)/4+e_j and A_j=C_j+T_j. The reviewed source-specific Z_j include numerical source errors relative to the finite shifted polynomial. The first-four and final-band classes use different Z_j. The separate analytic shift and source-function remainders remain unchanged.

For the real displacement h=r/v, v=2c>0, |h|<=1/4, |r|<=132900 and v<=531600, the inherited conversion-plus-evaluation error is below8u/3, u=2^-100. There are nineteen product rounds followed by exact additions; the highest coefficient is copied exactly after conversion and the final output has no additional round. Degree0 enters only the last addition. No geometry distribution or new grid search is used here.

## 2. One real stage with a complete nearest witness

Suppose the input coordinate is M/2^b_(j+1), the converted coefficient is n_j/2^b_j and delta=b_j−b_(j+1)>=0. Choose one of two FIXED schedule modes. The primary mode uses t=0. The optional mode uses t=min(delta,1), justified by v=2c. Define

    v'=v/2^t,
    P=r*M,
    X=P*2^(delta−t).

In the optional mode the exact identity v=2^t*v' must be checked and bound to the same c. No general gcd reduction or conductor-dependent extra cancellation is credited.

The producer supplies signed integers L,R and nonnegative integers S,C, then the checker proves

    V=L*v',
    R=X−V,
    S=2R+v',
    S+C+1=2v',
    Mnew=L+n_j.                                      (1)

All signed zeros are canonical. The checker independently requires S and C to have unsigned magnitude below2^(21−t). This is a rejection cap established from their numeral encoding, not a consequence assumed from an unchecked equality. Since2v'<2^(21−t), every valid nearest witness satisfies this cap. S+C+1 is bounded before checking by2^(22−t), so a three-byte natural adder suffices even for malformed but range-admissible candidates.

From S,C>=0 and the fourth equality,0<=S<2v'. The third equality gives

    -v' <=2R<v',

which with the first two equalities is exactly

    -v' <=2*(X-L*v')<v'.                            (2)

For any real X/v', (2) specifies nearest ties toward positive infinity. The lower endpoint is allowed and the upper endpoint is excluded. This also covers negative inputs: no unsigned-floor convention has been silently used. Scaling (2) by2^t recovers the original unreduced-divisor witness for r*M*2^delta/v. Thus the same L is the rounded coordinate required by the inherited error proof. Conversely the mathematically correct L yields integer R,S and C=2v'−S−1>=0 satisfying all equations and caps. This proves completeness of the witness interface, not successful data generation.

Two copies of (1), real then imaginary, give one complex stage. The input integer factor r is real, so there are two coordinate products for r*M and two for L*v'. No complex four-product multiplication is present.

## 3. Ordinary signed arithmetic realization

Use canonical signed magnitude for each integer, with positive sign for zero. A generic signed-product lemma combines a proved natural magnitude product with the two input signs and zero cases. Its proof and every use are charged separately from the natural product template.

A signed equality z=x+y can be certified with ONE natural addition equality after its signs and branch are checked. For matching nonzero signs it is |x|+|y|=|z|. For opposite signs, the result sign identifies which input magnitude is larger, and the equality is smaller input magnitude plus |z| equals larger input magnitude. Zero cases have their own canonical sign condition. Those equalities imply the needed order; an implementation may also emit an explicit order fact, whose cost must be charged. A bare natural addition without these sign/branch facts is insufficient. The corresponding fixed PA lemmas still have to be implemented or translated; no signed-arithmetic axiom is introduced.

Apply this bridge to R=X+(-V), S=2R+v', and Mnew=L+n_j. The natural guard S+C+1=2v' uses the existing adder with initial carry1. Its unsigned hypotheses are checked independently. The full real-stage arithmetic therefore uses two natural product templates and four natural addition templates: residual, range reconstruction, guard, coefficient addition. It also uses three signed-add bridges, two signed-product bridges, the nearest-range implication and exact shifts. Negative signs are not priced as an extra natural multiplication.

The three-byte guard width above is independent of the accepted equality. For the other additions let

    mcap=2^b_(j+1)*A_(j+1),
    lcap=2^b_j*T_j,
    ncap=2^b_j*C_j,
    pcap=132900*mcap,
    xcap=pcap*2^(delta−t),
    vcap=531600/2^t,
    rcap=xcap+lcap*vcap,
    scap=2*rcap+vcap,
    acap=lcap+ncap.                                  (3)

All are rational sufficient bounds; |M|<mcap and |L|<lcap are the range obligations inherited from the profile proof. Supplied records must satisfy their encoded bounds, with the proof interfaces attached to the correct source and stage. The residual natural addition is budgeted at the strict-power magnitude capacity for rcap, the range addition at scap, and the coefficient addition at acap. These are sums of input magnitude bounds, before cancellation. The appropriate sign-case natural equality fits those capacities. Its final carry/result must match the stated bounded result; overflow is not ignored.

Exact alignment of P and doubling of R are shifts with separate proof costs. Doubling v' for the guard can be proved once per exact divisor object and reused by checked reference; reconstructing it after a context reset is not free. The optional v/2 mode needs the corresponding divisor binding. The receipt lists every stage width and both modes. No range proof uses the narrow accepted residual before proving it.

## 4. Product and addition template counts

The common proposed ordinary-PA templates are section3 of integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md, SHA `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227`:

    M(m,n)=5*m*n+2*n+1,
    A(l)=2*l+1.

Here m,n,l are byte counts and n is the smaller product operand's byte count. A includes its initial carry and base event. These are proposed template events with PA-derived digit tables and lifting lemmas. They are not executed MM0 opcodes or Lean kernel costs. Numeral/reference construction, sign bridges and table setup are outside these formulas.

Every complex polynomial uses76 real product instances,152 natural-add template instances,114 signed-add bridges,76 signed-product bridges and38 nearest-range implications. The raw residual is doubled38 times. Source conversion and constant geometry setup are separate. The exact template subtotals are:

|Band|Profile|Products P|Additions A, t=0|P+A, t=0|Additions A, optional cancellation|
|---|---|---:|---:|---:|---:|
|First four|Uniform|12562|3204|15766|3204|
|First four|Linear|11272|2964|14236|2936|
|First four|Fixed15442|10702|2860|13562|2856|
|Final|Uniform|11872|3068|14940|3068|
|Final|Linear|10552|2824|13376|2804|
|Final|Fixed15442|9970|2716|12686|2716|

The optional cancellation does not change P: v' still needs3 bytes in the global bound. It saves respectively0/28/4 adder events first-four and0/20/0 final. It is worthwhile only if its added divisor-binding/cancellation costs, less its shift/representation savings, fit inside those small reserves. It is not adopted automatically.

Without cancellation the complex alignment-shift counts are0/36/14 for uniform/linear/fixed, with total bit distances0/38/58. With cancellation they are0/2/14 with distances0/2/44. A shift count or distance is not a price. Its input and output numeral sizes, proof references and zero-padding representation matter. The script records these for each stage. Nothing is credited for zero r or an unusually short actual operand.

## 5. Direct conversions, cache and full cost variables

For one original source coordinate a*2^e and destination grid b, direct conversion has a concrete ordinary interface. If e+b>=0, the new integer is a*2^(e+b), justified by an exact shift. If e+b<0, put d=−e−b>0 and check nearest n by

    -2^d <=2*(a−n*2^d)<2^d.

The same signed/slack construction as (1) proves this, with power-of-two products implemented as exact shifts. Its operands can be as wide as the original a and d demand. Neither the new narrow coefficient nor the final source envelope bounds the size of an arbitrary finer original encoding. Name this complete per-coordinate checking cost Conv(a,e,b), including decoding, shifts, signed bridges, range, tie, proof representation and binding. Every newly admitted source-array/profile object has40 such coordinate conversions unless a separately checked direct-output producer contract replaces them. No double rounding through b100 is assumed for the variable profiles.

A cache object must bind the exact source artifact, band, height, fine anchor, twenty centers and grid vector. Let r_o be its number of actual proof-context admissions or reconstructions. Then the conversion/cache bill is

    sum_o r_o * [sum_(j=0)^19 sum_(coord) Conv(a_oj,e_oj,b_j)
                 + BindObject(o)+CacheAdmission(o)].

A theorem proved globally once need not have its body rechecked on every reference in one full stream, but each checked import/reference and data association has a cost. Across independent proof runs, prior hashes alone are not proof imports. Eviction and reconstruction, term storage and reload policy determine r_o and the remaining traffic. Counting all outputs as consumers of a single freely retained array is invalid; height and anchor usually change.

For one declared evaluation or a cohort, define R_profile to include all NON-template work:

* Direct conversions and their actual cache admissions as above, plus original source certification or the common source theorem/input boundary.
* Product signs, canonical zero and signed-add branches; all supplied integer range proofs; nearest-round implication and stage linkage.
* Alignment/doubling shifts, optional cancellation and divisor facts, their checked reuse and exact coefficient/output representation.
* Geometry and unit/anchor/height binding, source lookup, all required output labels and coverage, exact final output association and assembly.
* Numeral/DAG construction, theorem arguments, proof references, unification, encoding/parsing, digit-table and generic-lemma setup, storage and traffic.

These categories are exhaustive obligations of the stated schedule, but their prices are not known from the paper. They may be width-dependent sums over the saved rows; one constant per bridge is only an explicitly chosen model. Any extra bridge discovered in implementation belongs in R, not in a silent new arithmetic rule. Common costs cancel in a comparison only when the same checked objects and coverage actually make them common.

Witness discovery is a separate producer bill G_profile: source conversion, coefficient and product arithmetic, quotient/nearest computation, slack construction, proof production, serialization and cache management. Ordinary checking does not trust these computations, but end-to-end cost must still pay them. The checker event model alone says nothing about G. A chosen joint objective can add lambda*G_profile with a declared conversion of producer and checker resources; no numerical lambda or elapsed-time estimate is supplied here.

## 6. Explicit break-even inequalities

Let alpha price a product-template event and beta price an addition-template event in ONE declared cost model. This may be a schematic event objective; actual encoded bytes or checking work may instead require the separate per-stage event vectors. Define

    T_profile=alpha*P_profile+beta*A_profile+R_profile.

The following table gives the precise reserves available to pay R_new−R_old in the uncancelled mode. The new profile wins under this model exactly when its differential R is STRICTLY smaller than the displayed expression. If an end-to-end objective is used, add lambda*(G_new−G_old) to the left side.

|Band|Old to new|Required upper bound on R_new−R_old|
|---|---|---|
|First four|Uniform to linear|1290alpha+240beta|
|First four|Uniform to fixed|1860alpha+344beta|
|First four|Linear to fixed|570alpha+104beta|
|Final|Uniform to linear|1320alpha+244beta|
|Final|Uniform to fixed|1902alpha+352beta|
|Final|Linear to fixed|582alpha+108beta|

With guaranteed cancellation in both schedules, the addition reserves in table order are268,348,80,264,352,88; the product reserves are unchanged. The cancellation costs remain in R for each profile. Thus choosing cancellation everywhere is not an assumption hidden in the comparison.

For q outputs that really share one admitted converted array, let DeltaC be new minus old conversion/cache cost and DeltaR_local the differential per-output residual cost. A scalar amortized model requires

    DeltaC+q*DeltaR_local < q*(DeltaP*alpha+DeltaA*beta).

If D=DeltaP*alpha+DeltaA*beta−DeltaR_local>0 and DeltaC>0, the threshold is q>DeltaC/D. If D<=0, increasing reuse cannot repair a positive DeltaC. Negative differences and q-dependent traffic must be kept with their actual signs/functions; they are not forced into this simplified threshold. A multi-array cohort sums the full expression over its actual objects and evaluations. No geometry scan or full-family count is supplied here.

The same stored-degree source bounds can refine finite-difference initialization, and shorter retained polynomials have different top-copy states. Neither is priced by deleting this packet's stages or comparing against an unnecessarily wide old competitor. This packet leaves those comparisons separate. All analytic foundations, spectral acceptance, seeds and actual numerical successes remain open or inherited at their existing status.

## 7. Exact metadata and review gate

Owned script signed_horner_schedule_costs_20261111.py has SHA256 `82BDFCBDA7A905808EF404EFD4FE36BBDC688E14C23E194CE2B1DF89C04A5602`; receipt of the same stem has SHA `0DF6FF38D7F14A9C3596423BE109E5EEC6CAF18E031F4329B907E43F5A60FF37`. All3450 exact assertions pass. It reads, but does not import, the prior fixed-profile receipt; reconstructs raw rational capacities; prices both cancellation modes for all114 stages; checks the natural guard capacities; and records every comparison. Its one formal linear coefficient identity verifies S+C+1=2v symbolically, not by sampling actual function values. The general sign/tie proof is sections2–3, not a claim established by finitely many fixtures. The writer refuses to overwrite its receipt.

Besides the two report pins in section1 and template pin in section4, it verifies prior script `22D456ADE5596011FF01145F384C2FA0A93D86C29E4A8EB97AE2C24FDA1B1162` and receipt `4F114004CC63EF912619A4318227731CECC5041AADAAD9F63DE38DE3B44468B9`. The prior source acceptance is consumed through those reviewed interfaces; no new source proof is claimed.

Independent review of this schedule remains required. A concrete ordinary-rule library, emitted witnesses and proof terms, complete source/target coverage and measured resource accounting are separate implementation gates. A native arithmetic inference rule would be a different design; it is not part of this model.
