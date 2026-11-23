# Square-root bounds for the complete degree-zero EM expression

2026-11-11. Candidate paper refinement, submitted for independent review. The existing source identity gives O(sqrt N) degree-zero magnitudes after retaining the modulus of the endpoint power. No cancellation, function-value evaluation or asymptotic approximation is needed. All Bernoulli, pole, half-endpoint, remainder, numerical-source and finite-translation terms remain.

The resulting sufficient full-P20 output bounds are65,85,113,173 in the first four source bands and163 in the selected final band. They apply conditionally to the actual stored source vectors and the finite evaluator described below. They change neither its approximation error nor its source work. No new input precision, transform width, assignment, schedule or savings count is selected. No code, numerical evaluation, conductor/gate scan, planner, build, declaration or proof emission was produced. The older5691/5032 magnitude packet remains unchanged.

## 1. Exact source and selected parameters

Use s=1/2+it, coarse anchor a in[0,1], z=1+a, b=N+z, and the continued Hurwitz function f(a)=zeta(s,1+a). The first four bands are

    (V,D,N,m)=(500,512,220,64), (1000,1024,387,64),
              (2000,2048,720,64), (5000,4096,1720,64).

Their coarse source has P27 coefficients, except the unshifted right endpoint where P20 suffices. The final band has V7000,D4096,N1500,m159,P28, output normalization8192 and fine-anchor denominator16384. Both height signs and t=0 are included. The actual domain is not the superseded V10000 final band.

For degree zero, the pinned scaled finite-EM identity [3,5,7] is exactly

    U0_EM = sum_(n=0)^(N-1) (n+z)^(-s)
              + b^(-s) * [b/(s-1) + 1/2 + S0/6],
    S0 = sum_(r=1)^m gamma_r E_(2r-1),
    E_l=(s)_l/(6b)^l,   |gamma_r|<4.

Here R0=lambda0=E0=1, so no normalization factor has been suppressed. The true coarse coefficient is U0=zeta(s,z), with |U0-U0_EM|<R=2^-116. The denominator obeys |s-1|>=1/2, including t=0. This is a finite identity with a proved remainder, not convergence of the infinite EM expansion.

## 2. Complete coarse degree-zero bound

For z>=1 and integer N>=1, monotonicity of x^(-1/2) gives

    sum_(n=0)^(N-1) |(n+z)^(-s)|
       <= sum_(k=1)^N k^(-1/2)
       <= 1 + integral_1^N x^(-1/2) dx
        = 2sqrt(N)-1.

For k>=2, the summand is at most the integral over[k-1,k]; N=1 gives the same formula with an empty sum. This is valid uniformly in t and requires no absolute convergence claim for the infinite degree-zero Hurwitz series.

Crucially, |b^(-s)|=1/sqrt(b). Therefore the complete endpoint has norm at most

    2sqrt(b) + (1/2+|S0|/6)/sqrt(b).                 (1)

The pole-type term is retained through |s-1|>=1/2. The half-endpoint and every correction are included in the second term. Replacing |b^(-s)| merely by1 would lose this improvement even after improving the finite head.

In the first four bands the inherited E recurrence contracts by at most1/2. Hence its finite correction sum satisfies

    |S0| < 4 sum_(r>=1) (1/2)^(2r-1) = 8/3,
    1/2+|S0|/6 < 17/18 < 1.                         (2)

In the selected final m159 band, the inherited bound7009/9006<17/20 bounds all relevant rising factors after division by6b. Keeping the older conservative contraction r=17/20 gives

    |S0| < 4r/(1-r^2) = 1360/111,
    1/2+|S0|/6 < 1/2+680/333 < 3.                  (3)

These estimates bound finite sums by positive geometric series. They use the already admitted all-order bound on the actual signed gamma coefficients; no cancellation of alternating Bernoulli terms is assumed. Removing corrections from m256 to m159 does not invalidate the conservative geometric bound.

Choose rational integer root brackets ell<sqrt(N+1)<=sqrt(b)<w, and also sqrt(N)<w. The complete finite expression is then below

    4w-1+kappa/ell,

where kappa=1 in the first four bands and3 in the final band. The following table is certified by the displayed integer-square inequalities alone.

|N|ell|w|Root checks|Bound on U0_EM|C0|
|---:|---:|---:|---|---|---:|
|220|14|15|196<221;222<225|59+1/14|60|
|387|19|20|361<388;389<400|79+1/19|80|
|720|26|27|676<721;722<729|107+1/26|108|
|1720|41|42|1681<1721;1722<1764|167+1/41|168|
|1500|38|39|1444<1501;1502<1521|155+3/38|156|

Every kappa/ell is below1/2. Since R<1/4, this proves |U0|<C0. It also proves the same bound for the original stored coarse source center: its error from true U0 is below eta/4 in the first four bands and below .107eta in the final band, where eta=2^-100. Conservatively R+eta<1/2 closes that extra comparison. The use of R in a magnitude bound does not remove its existing place in the source-accuracy proof.

## 3. Finite translation and stored coefficients

The exact positive-degree bounds from [1] are retained. For coarse j>=1, |U_j|<=3A^j/j!, with A<5/4 in the first four bands and A<7/4 in the final band. Define the rational finite-series majorant

    H(x)=1+x+x^2/[2(1-x/3)],  0<=x<3.

Starting at degree2, successive terms of x^j/j! have ratio at most x/3, so H bounds every finite positive partial sum. It is a rational majorant, not an evaluated exponential.

The ideal finite shifted coefficient at degree zero differs from true coarse U0 by at most3(H(A|tau|)-1). For |tau|<=1/2 this is bounded by

    3(H(5/8)-1)=795/304       in the first four bands,
    3(H(7/8)-1)=1155/272      in the final band.       (4)

The final output factor2^-k is1 at k0. At positive degrees it is retained, yielding the existing ideal output envelopes

    I_k=6*(5/4)^k/k!          in the first four bands,
    I_k=(15/2)*(7/8)^k/k!     in the final band.       (5)

These are coefficients of the finite translation of the true coarse vector, not automatically true fine-anchor jets. Analytic finite-shift bias stays in the unchanged actual-function error contract.

The delivered first-four numerical vector has weighted error at most W=4eta+330*2^-110<5eta on weights4^-k, including degree zero. The final delivered vector has each error beloweta, hence weighted error below4eta/3. These already include the accepted seed/translation/output arithmetic. No new seed or shift error is added to that vector bound.

Consequently the stored shifted coefficient at degree zero is below C0+3 in each first-four band and below C0+9/2 in the final band. This gives63,83,111,171 and160.5 respectively. These are safe stored-vector bounds; they are not new enclosures of actual coefficient values.

## 4. Full P20 polynomial and rounded output

For the exact finite polynomial of the stored delivered coefficients and |h|<=1/4, its positive-degree contribution is bounded using (5):

    sum_(k=1)^19 I_k/4^k
      <=6(H(5/16)-1)=1515/688                  first four,
      <=(15/2)(H(7/32)-1)=20895/11392           final.       (6)

The source numerical vector contributes W or4eta/3 once, by its weighted bound. Combining (4) and (6), the exact rational inequalities

    795/304 + 1515/688 < 79/16 = 5-1/16,
    1155/272 + 20895/11392 < 111/16 = 7-1/16            (7)

leave explicit slack for the actual evaluator and conversions.

For a magnitude-only interface, allow direct coefficient grids b_j>=60, exact displacement h and exact grid alignment. Each of the twenty original-coefficient conversions has complex error at most2^-60. Nineteen Horner product rounds and, if used, nineteen addition rounds have the same bound. Permit one further output round of this size if export is not exact. There are at most59 such additive perturbations. Propagation through |h|<=1/4 has gain at most1 per perturbation, so their total output effect is at most59*2^-60<2^-54. The old unconverted two-round Horner circuit and product-only circuits satisfy this conservative interface whenever their stated gates do. This bound prices no operation and does not change the actual circuit.

The source numerical vector error is below2^-90 in either band class. Thus all new magnitude perturbations in this paragraph sum to less than1/16. Equations (7) prove the strict actual full-P20 output bounds

|Source band|Stored and evaluated P20 output magnitude|
|---|---:|
|V500,N220|<65|
|V1000,N387|<85|
|V2000,N720|<113|
|V5000,N1720|<173|
|V7000,N1500,m159|<163|

This magnitude interface includes the current full-P20 b0=94/min65 shape without reverting to a b0=100 price schedule. With b0<=100, export to grid100 is an exact checked shift and needs no additional rounding error. The min60 condition here is only a sufficient magnitude premise. It does not admit a grid60 analytic accuracy contract. Every chosen profile must still separately satisfy its complete alpha bound and source/sample/guard domain. Any FD or other evaluator requires its own bound relative to the same stored polynomial before inheriting the table.

## 5. Conditional raw-input consequence and limits

For the current conductor domain c<=265800, sqrt(c)<516 because265800<516^2. A raw finite-head center with error at most1 has magnitude below517. Exact grid100 addition to a polynomial from the table therefore gives raw input norm below690 uniformly, or below680 for final-band inputs only. After one admitted regrid with complex error at most2^-p, p>=80, the augmented bound is strictly below692 uniformly, or682 in the final band.

These are optional new magnitude inputs for a separately reviewed selector. They are not substituted into the frozen5691/5032 or8828 papers here. Head accuracy and encoding, exact assembly, conversion errors, normalized-cache contracts and source binding must still be supplied. A mixed-height conductor could use the uniform692 bound, while any sharper band-specific use needs an explicit matching theorem. No local width, cache plan, pricing or complete-error selector changes automatically. The smaller bounds are not actual observations or sign-margin estimates.

The refinement uses ordinary inequalities on the complete existing finite formula. It supplies no new zero-location premise and changes no approximation/error budget. The exact analytic EM identity, Bernoulli bound, remainder, source-rounding and translation theorems remain the same conditional proof obligations as in the pinned reports. Their future compatible kernel validation and concrete records remain open.

## Frozen source interfaces

Paths are relative to `work/qrh-campaign/agents/`, except the explicit blueprint row. All nine hashes were checked read-only. No scalar program or numerical receipt was created for this paper; the finite rational and integer-square comparisons are displayed above.

|Source|SHA256|
|---|---|
|prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md, sections1–6|9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2|
|major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md|1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6|
|prime-estimates/SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md, sections2–6|251B95AE92B6277C0B14C69F3CFE697F3100FD27C2D7963E4B42676FF4DAB231|
|integration/REVIEW_SCALED_HURWITZ_EM_SEED_PRECISION_2026-11-11.md|043E2E1630B19EC8EED9496FAA5D9AE6AF9C20944F7F2F5589B48E5A119C4F26|
|major-constants/JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md, sections1–3|AA1A7464A38CA5FDEDF21F000965C765DE22DFB2C8D4F796EC5C0B0A7A8F1D9F|
|audit/REVIEW_JOINT_QUARTER_MESH_HEAD_TRADEOFF_2026-11-11.md|2F057C0F2507452AC959587E13FD1AE8F9117FC75CBC3BA1C6364E8C5BF0064A|
|work/qrh-blueprint/JOINT_SEED_159_CORRECTIONS_2026-11-11.md|E6F0F3B277828EA451E05F3608478F760C83F02FEE1B70A899FA40434781CBE9|
|audit/REVIEW_JOINT_SEED_159_CORRECTIONS_2026-11-11.md|09DEF5ABB358A807936270B07E61FFEE624EF0F04C3E17AC47A1179D944E2E82|
|independent-feasibility/FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md, preserved comparator|718CFC0DDAA0594A2AB26ADDCEBA09E472E07C1ED21FD8058821957251EAC223|
