# Extended raw-head source audit

Status: PASS for the pinned source mathematics and the existing successful strict-Lean build/axiom evidence for these generic computed-value exports. The final step theorem discharges its polynomial and rounding assumptions; only its stated integer range/positivity premises remain. The inverse-root generator discharges the adjacent-square certificate. Literal-cache fixtures are outside this requested scope. This review ran no build, proof emission, log/root/step evaluation or inventory; it read the coordinator's completed evidence. Only this report was written.

This coordinator-requested finalization supersedes the pending evidence status of this report at SHA256 `5E85E23328396A139B52389B2D82F725E813FB7FDD7DE9DCCB17234E6B73A464`. The earlier mathematical analysis remains; only final proof repairs, source pins and completed evidence are reconciled below.

The source is section 3 of `work/qrh-campaign/agents/integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, SHA256 `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE`. The implemented source objects are actual `Real.log`, `Complex.exp`, positive `Real.sqrt` and `integerPower`; no replacement uninterpreted function or supplied analytic enclosure occurs in the final computed-step theorem.

## Exact pinned sources

Lean paths in this table are relative to `work/lean-pilots/raw-head`.

| File | SHA256 |
|---|---|
| `RawExpTail.lean` | `2E0CCA220F498DDA3C552E84A15652DF2DC2550F307921ADF029E5115A3DB7DC` |
| `RawExpHorner.lean` | `CB1BBBBBF4D77AD7155F3F669EC2E0F00CC127095C61E0EB733DC4CDA830FEB5` |
| `RawExpInteger.lean` | `F4964C22363D290F96A17900CD72D2F193DBBD211F52651A1E2A49D5F78CB53B` |
| `RawStepAssembly.lean` | `D8E72587BA40FBA79DC6554B42F8CC352513A142ACF925F31076CBB5849DAF42` |
| `RawStepProducer.lean` | `A30763650701C171C20B3EB6908F0918A95F1A64A2F0BEBB557D0D42070F53AE` |
| `RawInverseRootProducer.lean` | `AB4B5B6721C03D37E87DC09732865B27A42161C8B7B686EEC50EEF48B676353B` |
| `RawLogAssembly.lean` | `BDF4C5DABB9F68EA9E5754452CE0C228EDA801A9F144A4648F415E7C900485D7` |
| `RawLogHorner.lean` | `B8F3D80805063D22C653D1949732DE0B67E92BE329512EABD1198A88E8A67AAD` |
| `RawLogTail.lean` | `2D6E8E9A38086653661FF06A263164BF04B077E41C7EFBDD96011466EB52AB55` |
| `RawInitialization.lean` | `C695D2F12F1822C57A8E13EC4376CD2E0378D90B82ABD111805FC7A72FACA1E1` |
| `RawInverseRoot.lean` | `D0B6C28B39F35DE88056CA4BBB078B2A8D84463DC92AAA2D32F3C4CD1BA67619` |
| `RawPowerIdentity.lean` | `94106C4B629AB59BA50DA9DAD3F0564BAF6BF681911561C45D626F1BE0203447` |

## Taylor polynomial and arithmetic bridge

`RawExpTail.expPartial` (line 15) sums `range N`, hence `expPartial 73` has exactly degrees 0 through 72. `Complex.exp_bound'` in the imported Mathlib `Analysis/Complex/Exponential.lean:407` is the actual exponential-series remainder theorem. Its condition is norm(z)/(n+1) <= 1/2. At n=73, norm(z)<=4 implies 4/74<=1/2; its remainder 2*4^73/73! is at most 2^-124. The implementation uses that finite exact inequality, not a numerical exponential evaluator.

`expHorner z N k` starts from exact 1 and performs N updates of `1+z/(k+1)*child`. The rising-factorial identity proves its exact sum; at k=0, N=72 this is the same 73-term polynomial. The endpoint is not a 74-term or degree-73 substitute.

The generic error theorem in `RawExpHorner` has genuine premises: exact initial 1 and an affine error at most delta at every recursive N,k. They are not themselves a produced certificate. For k>=4 the multiplier is at most 4/5, so a 5*delta bound is invariant. Successive top stages yield factors 6,9,19,77. The final 81*delta is conservative. There is no assumption of independent rounding or cancellation.

`RawExpInteger` discharges those premises. For positive natural S,d, its denominator D=d*(k+1) is positive and its signed pair update is

    (roundDiv D (S*D-p*w_im), roundDiv D (p*w_re)).

After division by S this is the affine map `1+(i*p/d)/(k+1)*w`, with two actual integer nearest rounds. The negative real-coordinate product is correct for multiplication by i. `roundDiv` is signed Euclidean division `(2*r+D)/(2*D)` and uses nearest ties toward positive infinity, including negative halfway cases. Its previously proved half-unit real-coordinate bounds combine by the complex L1 inequality to at most 1/S. No coordinate error is silently read as a Euclidean error. Exact start `(S,0)` gives 1 because S>0. Thus `expIntegerHorner72_error` has only S>0,d>0 and the real phase-size premise; it has no residual hstep or supplied polynomial-error premise.

These are mathematical arbitrary-precision integers. No bounded machine capacity or primitive-instruction timing follows from this proof.

## Logarithm phase and final step

The actual grid129 log center is computed from two 45-term atanh programs on grid137, the shared log2 term multiplied by k, then one division by 256. Its source theorem requires x>0, k<=18 and 2^k<=x<=2*2^k. The lower range premise makes natural subtraction x-2^k agree with real subtraction. The inclusive upper endpoint is harmless: the atanh proof accepts v<=1/3. The integer pool 1..265800 fits the possible range-reduction domain, but these files do not construct all its range witnesses or scan the pool.

The complete log error ledger is

    19*2^-135 + (133/4)*2^-137 + 2^-130
      = (949/2048)*2^-128 < 2^-128.

`rawStepPhase` equals `-(5/64)*(q/2^129)` for the actual integer log center q. Source log x is nonnegative and <19; the center has absolute value <20, so its phase magnitude is <25/16<2, and therefore <=4 as needed by the exponential theorem. No assumption that a rounded log center is nonnegative is required.

`stepInnerFromLog` uses numerator -5*q and denominator 2^135. Since 2^135=64*2^129, this is the exact same phase, with no additional phase round or pi reduction. The sign agrees with the negative-phase time increment in `integerPower_time_step`, namely exp(-i*(5/64)*log x).

The actual inner pair is grid131, with error <=81*2^-131 to the finite polynomial. `stepFromLog` divides each coordinate by 512 and exports grid122. The identity 512*2^122=2^131 proves this is the correct regrid. Each coordinate incurs at most 2^-123; their Euclidean norm is safely bounded by 2^-122. Although the paper uses strict language for some coordinate-nearest norm allowances, these non-strict implemented L1 bounds suffice for the final strict result.

Unit-circle exponential transport is globally one-Lipschitz in the real phase; no small-phase hypothesis is needed for that transport. The separately charged total is exactly

    (5/64)*2^-128 + 2^-124 + 81*2^-131 + 2^-122
      = (5773/16384)*2^-120 < 2^-120.

`RawStepAssembly.raw_step_error_of_polynomial_error` remains an internal conditional helper. `RawStepProducer.rawStep_polynomial_error` supplies that premise using the actual integer program and final regrid. `rawStepValue_error` then has only the four integer range premises listed above. It proves the actual computed grid122 pair approximates the actual source exponential. It does not certify an unrelated externally supplied pair, a different phase direction or a differently rounded implementation.

Nine fixed rational/finite-factorial checks independently reproduced the tail condition and bound, contraction and top-stage factor, exact phase and regrid denominators, phase-size slack, final step fraction and log ledger. No function values were evaluated. An initial message called 723*2^-131 the exact total; it is only a valid coarse upper bound. That shorthand was immediately corrected; the exact fraction above is the reviewed one.

## Inverse-root generation and endpoint semantics

`RawInverseRootProducer.inverseRootCandidate x S = Nat.sqrt ((S*S)/x)` uses ordinary natural division and natural square root. For x>0, the floor-root theorems give m²<=floor(S²/x)<(m+1)². Exact natural division equivalences yield

    m²*x <= S² < (m+1)²*x.

The right inequality is strict even at an exact square; the next integer is used. These inequalities are supplied by the producer, not assumed of its output. S=0 is allowed for the integer certificate, but the approximation and initialization theorems correctly require S>0. x=0 is excluded from all claimed certificates. For x>=1, the certificate also implies m<=S; this capacity fact is not separately exported by this file.

The imported real checker derives nonnegativity of any signed candidate from the two adjacent-square conditions, then compares against the positive real square root. The producer's natural m is already nonnegative. The conclusion is one-sided `0 <= 1/sqrt(x)-m/S < 1/S`; no strictness is lost at x=1 or perfect-square ratios. `inverseRootCandidate_initialization_error` identifies this with actual `integerPower x 0`, using the positive-base complex-power source identity. At S=2^98 this supplies the paper initialization accuracy. Exact embedding into a persistent grid120 state and later recurrence arithmetic remain downstream obligations; they are not implemented merely by this source theorem.

## Literal/cache joins and remaining scope

The generic computed-value step export is closed with respect to approximation premises, but it still requires checked integer range facts. A literal cached log center q needs an exact equality to `log129Center k x`. A literal cached step w then needs an exact equality to `stepFromLog q`, or an equivalent proved arithmetic trace. A small analytic log radius alone does not identify that precise integer program or guarantee identical rounded output.

The existing `log129WithLogTwo_eq` supplies the cache bridge only given exact equality of the shared literal with `logCenter (2^137) 1 3 45`. Existing `RawLogCases64.logTwo_checked` and per-center equalities illustrate checked use of this bridge. No new literal-step case was present in the reviewed snapshot. The current report therefore approves the generic mathematical producer chain, not a completed cache-population certificate. Exact literal joins will be read and pinned separately if added.

This extension does not prove persistent-state recurrence through 90000 steps, conductor-cache multiplication, final raw-head grid100 rounding, aggregate H/J0, character-transform accuracy, sign success or Turing completeness. The source objects align with those consumers, but these six files alone do not discharge their later premises. Imported Mathlib/generic library foundations remain the ordinary library boundary.

## Final build and axiom evidence

The coordinator's final successful receipts are listed below. For every row the reviewer independently matched the source, object and log bytes to the receipt; verified exit code zero, no stop, source_unchanged=true and dependency_builds=false; and checked the command uses stock Lean `-t0 -j1 -M4096`. Each of the six producer/helper compilation logs is empty. The audit log contains the five requested signatures and six axiom lists. This was read-only verification of existing evidence, not an independently rerun build.

| Receipt | Receipt SHA256 | Object SHA256 |
|---|---|---|
| `exptail01.json` | `F9E6B091BF77C4F12D6FFAD35237AC291A861574570D91D92A44B9D0DA3500AB` | `FE164CE1070467D5C84D467127CE3179F410FFF5D4AACEA2CCCB2570E841EA9F` |
| `exphorner02.json` | `3F4CE72FCA6E7DB82BC2B825ABC972C185DD823A78FE1D1C465180F677B443F1` | `F325AE150E58E63B0E6948615F6CC548D98F793D557C73B069751D00CF910E6E` |
| `expinteger04.json` | `B5673A867F183DB6933EA384F1A9DEDD94C600D20F1CAD8E17861013B2E17F7D` | `37177B440188F80D12153C64E20489F335F3C6400926DBE684F9DC7362F49D51` |
| `stepassembly02.json` | `1FC5DBDB886112CB08200B11EF2F361455E012295A9852B157D0E39C73FE95AB` | `FA3D78FCBAE99949170D5029E7524E58E873DF2A3A35B00083DA15D4398669F9` |
| `stepproducer02.json` | `CFD0AE7C568B472C4F7CFB1DAF6D285ACD5D59B83B2F1E7386D1F2F6C1618B93` | `D408223727A79698071365F917204A12EC1B8E0A782240F59A0983D532446319` |
| `invproducer01.json` | `4E6DE6D97134171D5F969309C9C889271F13ACF246F815625635043DDAC381FF` | `1147F93BDEAD3D99A45C6B77F44479AAFA25F677AF45D42305C98F69398AFBDD` |
| `extendedaudit01.json` | `48B0384A7E928C2B13BC5B79FBD04073368A9F754FDFC4EF17C0CF3D62E66A35` | `FEF15976E7A409AEB4306FF1ED8971A80127F2F4C285D404AEB3084CF10EBF93` |

The six empty compilation logs have SHA256 `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855`. `AuditRawExtended.lean` is SHA256 `2C4E779B69097CBA87DD36A1BE40CC8A5EE356355F6553B12E04F55C34F93237`; `extendedaudit01.log` is SHA256 `4B4D229EAB70CA85792B03BD94788F8C909007ED7A63BDF9A464CAB9E8459596`.

The final Integer cleanup only finishes the exact affine identity, with `all_goals ring` after coordinate simplification and denominator clearing. The final StepProducer repair uses the explicit triangle bound followed by `add_le_add hr he` and `add_comm`; it does not add a premise or alter any source/error constant. The signatures remain the reviewed ones.

The probe prints these actual exported types:

- `expPartial73_error`: only norm(z)<=4 for the true exponential versus the 73-term polynomial.
- `expHorner72_error`: the intentionally generic exact-start and affine-step-error hypotheses remain visible.
- `expIntegerHorner72_error`: positive S,d and absolute phase<=4; no abstract rounding hypothesis remains.
- `rawStepValue_error`: x,k natural, x>0, k<=18, 2^k<=x and x<=2*2^k; error of the actual `rawStepValue` against exp(i*(-5/64)*log x) is strictly below 2^-120.
- `inverseRootCandidate_initialization_error`: x>0,S>0; the computed natural inverse-root candidate approximates actual `integerPower x 0` within 1/S.

The six printed dependency closures—`expPartial73_error`, `expHorner72_error`, `expIntegerHorner72_error`, `rawStepValue_error`, `inverseRootCandidate_certificate`, and `inverseRootCandidate_initialization_error`—each list exactly `[propext, Classical.choice, Quot.sound]`. No custom approximation axiom, sorry axiom or native-decide axiom appears in those lists. This is the scope of the standard-axiom evidence; it does not assert a fresh replay of all imported library proofs or validate unrelated exports.

The probe uses `#check` on the imported declarations rather than an independent literal-type equality example. Consequently its evidence is a readable actual signature plus the source-body audit and recursive axiom printout, not a separate syntactic equality test against an independently elaborated target. The inspected binders and source definitions establish the intended generic producer semantics at this scope.

Earlier failed logs remain preserved: Horner01, StepAssembly01, Integer02/03 and StepProducer01 were not counted as successful admissions. Integer01's warning-bearing predecessor also does not stand in for the cleaned final Integer04 source. The final matching receipts resolve the prior pending status. No literal step fixture was required or inferred. Existing cached logarithm examples do not turn this result into a new concrete cache population or a runtime measurement.

`RawDyadicProduct` and `RawStateProducer`, including their new compilation evidence, are explicitly excluded from this audit. Persistent-state recurrence arithmetic and complete head/transform consumers remain separate as described above. The build CPU and elapsed fields are admission observations only; this audit makes no throughput, amortization, performance forecast or complete raw-head cost claim.
