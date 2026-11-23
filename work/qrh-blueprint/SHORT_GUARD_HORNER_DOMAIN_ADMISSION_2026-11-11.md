# Shortened Horner evaluation on the 41-node guard extension

2026-11-11. Root-authored paper domain extension with six rational alpha-budget comparisons. No source coefficients, functions, transforms, zeros, primes, proofs, declarations or builds were produced. Existing author and review files remain unchanged. Independent review is required before adoption.

The new maximum guard height 26525/4=6631.25 admits the fixed-profile K18,b0=94 Horner candidate at complete alpha error below 0.861409838*2^-82. The alternative K19,b0=93 is below 0.939320968*2^-82. Both therefore meet the original 2^-82 alpha allocation on the added final-band guard domain. This supplies a fresh admission; it does not retroactively expand the old height-specific theorem.

## Exact inherited interfaces

The source is agents/moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md, SHA256 AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63, independently reviewed in agents/independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md, SHA256 84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7. Here agents means work/qrh-campaign/agents.

The guard author/review are agents/integration/SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md, 3E447AE8E8EEEC847E95CFB7473879EB2B56CFC5E467863404D3ECDBB0180606, and agents/zero-sum/REVIEW_SHORT_WINDOW_SAMPLE_GUARD_LEDGER_2026-11-11.md, 15BA744A36D5D85D1A2E4E2C797B235475A39D2258D9BA07B6472EE45A64C5AA. Their maximal original index is 84839 and the maximal guard index is 84880, with Delta=5/64. Thus

    V_old=424195/64,
    V_guard=V_old+41*Delta=26525/4 < 7000.

This maximum covers all four existing alternative auxiliary-prefix scenarios with their fixed old target domains. The negative adapter uses inverse-character positive samples already in the prefixes; it does not require extending this maximum. This note proves no new guard union or query count.

## Complete alpha inequality on the new domain

Retain D_out=8192 and the original fixed grid shape

    s=[100,100,100,100,97,95,95,95,89,87,
       87,87,81,79,79,79,71,71,71,71].

For K,b0 equal to either 18,94 or 19,93, consume degrees 0 through K-1 with b_j=s_j+b0-100. Convert each ORIGINAL stored coefficient directly to that grid. Initialize from the highest converted coefficient exactly, round each lower displacement product once, and add its coefficient exactly. Retain the original nearest-anchor displacement bound, both signs of height, and clipped endpoint geometry.

The reviewed error decomposition is

    T_K(V) = 1266*((V+K)/(4*8192))^K/K!,
    S = 1266*(5*7028/(8*4096))^28/28!,
    N = 844*2^-100,
    E = sum_(j=0)^(K-1) a_j*(3/4)*2^-b_j*4^-j,
    a_j=2 for j<K-1, a_(K-1)=1,
    Alpha(V)=T_K(V)+S+N+633*E.

All source, finite-shift and coefficient allowances remain unchanged. In particular S still uses the declared source bound 7000 and source normalization 4096. The new target Taylor term uses D_out=8192 and the new V. N already includes the relevant numerical source/translation terms; the former separate Horner-rounding term is replaced by E, not added twice. The top coefficient is a copy rather than another rounded product.

The reviewed shorter-output theorem justifies retaining S and N when taking a prefix, because their weighted bounds are positive. It does not identify stored translated centers with exact fine derivatives. Source production still delivers all twenty output centers from the complete P28/m159 source and its full translations. No source work is removed by this domain admission.

For fixed K and grids, only T_K depends on V, and it increases for V>=0. Exact testing at V_guard therefore covers every |t|<=V_guard in this final-band evaluator's source interface, without sampling heights.

|K,b0|Old-domain alpha ratio upper|Guard-domain ratio upper|Declared-7000 ratio upper|
|---|---:|---:|---:|
|18,94|0.858600152|0.861409838|1.395647229|
|19,93|0.939289215|0.939320968|0.945552042|

Each entry is an upward rational bound with denominator 10^9 for Alpha/2^-82. Both guard values are strictly below one. K18 still fails this sufficient test on the whole declared domain 7000; it is not being promoted to that broader domain. Failure of that bound does not prove a lower bound on actual function error. K19 retains its already admitted declared-domain option.

## Magnitudes, costs and output binding

The stored coefficient envelopes Z_j in the accepted joint packet are independent of this restricted target V. Their final-source bounds still use 7000. For each unchanged K and grid vector, the converted coefficient and Horner accumulator bounds are identical recurrences

    C_j=Z_j+(3/4)*2^-b_j,
    A_(K-1)=C_(K-1),
    T_j=A_(j+1)/4+(3/4)*2^-b_j,
    A_j=C_j+T_j.

Consequently all previously reviewed stage capacities and template prices for that SAME candidate remain valid. The extension changes the remainder bound and number of required instances, not those per-instance capacities. This is not a reuse of the other candidate's accumulator or an assumption of observed cancellation.

K18,b0=94 retains 8932 product-template events and 2420 addition-template events per complex final-band residue evaluation. K19,b0=93 retains 8858 and 2448. Their comparison still has reserve 74alpha-28beta in favor of K19 before its additional conversions, signed/range bridges, shifts and representation work. No runtime winner is selected. These are the old byte arithmetic templates, not the later named-digit or smaller cell command counts.

The output-to-grid100 adapters remain exact shifts of six or seven bits, with the previously reviewed 114-bit signed export capacity. They require actual sign/range/representation proofs and do not restore old numerical centers or sign margins. Subsequent embedding into transform grid p>=100 is exact under its own checked adapter. All head, transform, scale, actual completion, kernel and interpolation errors remain separate from this full alpha allowance.

Individual conductors' new guards occupy several bands. The first four bands retain their respective already admitted domain-specific evaluators. This final-band proof does not move every guard into the final source class. A full guard cost fold must use the existing exact band weights. The joint normalized-transform inventory is a separate task; no new global operation total is asserted here.

## Evidence and acceptance boundary

Owned script short_guard_horner_admission_20261111.py, SHA256 750C046F8B5B79D78E0A3263DC39C642F99AAB6802838002E86DAA87C71FA28B, performs 29 exact rational/hash assertions. It checks four source report pins, the exact guard endpoint, the two candidates at three domain caps, all outward ratios and monotonicity between those caps. It imports no writer or evaluator and reads no large receipt or inventory.

Its exclusive 8397-byte receipt short_guard_horner_admission_20261111.json has SHA256 C8EA9BEC79CB00DBDCB3FB14D8C00F142592737D3300267CE29F89F2C5BE01B2. The paper's continuum implication uses the already reviewed monotonicity of the displayed positive Taylor bound; the six comparisons are not a substitute for it.

This result supplies an explicit source-compatible candidate for the added final-band guards while retaining complete alpha error. It generates no guard sample or sign, establishes no spectral completeness and supplies no end-to-end timing. Independent review is pending.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
