# Persistent raw-head state source audit

Verdict: PASS for the actual integer state producer, its source/error interpretation and the pinned completed build/axiom evidence. No correction requested. This is an internal generic producer theorem, not a concrete literal trace, a complete grid100 raw-head exporter or a source-to-sign spectral certificate.

The mathematical reference is sections 2–4 of `work/qrh-campaign/agents/integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, SHA256 `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE`. The previously accepted extended source audit supplies the reviewed actual inverse-root and grid122 step producers. This review read the two new full sources, their recurrence and power-identity dependencies, the current probe and existing receipts/logs. Five fixed rational scale/budget/endpoint checks were performed; no actual state, logarithm, root, step or transform values were evaluated. No build was launched, and only this report was written.

## Pins

Paths in the following tables are relative to `work/lean-pilots/raw-head`.

| Source or prior review | SHA256 |
|---|---|
| `RawDyadicProduct.lean` | `95C2BB6F0D336646DA77C29BECF76655EC14AE4B66CFBED06CCEBEB1B7E4214A` |
| `RawStateProducer.lean` | `E5335116BA0B90DD92D500FCD0EFA5A89586D08C334D64C0F9EC01AB12D9B961` |
| `RawRecurrence.lean` | `21B56EAA24799BCE237C30F318A05276FC5F504A3D6A4E3A3B921BCBBED32C7A` |
| `RawInverseRootProducer.lean` | `AB4B5B6721C03D37E87DC09732865B27A42161C8B7B686EEC50EEF48B676353B` |
| `RawStepProducer.lean` | `A30763650701C171C20B3EB6908F0918A95F1A64A2F0BEBB557D0D42070F53AE` |
| `RawExpInteger.lean` | `F4964C22363D290F96A17900CD72D2F193DBBD211F52651A1E2A49D5F78CB53B` |
| `RawPowerIdentity.lean` | `94106C4B629AB59BA50DA9DAD3F0564BAF6BF681911561C45D626F1BE0203447` |
| `AuditRawState.lean` | `302BB1BF07F7EC704161F9D22A47004D301D598988C817DF542FF0B51B69E22D` |
| `EXTENDED_SOURCE_AUDIT.md` | `3F30ABA29F289FB11B653E2A3942D98E7E53F15CABDE09658EA11E7DACEDD46E` |

## Actual rounded multiplication

`RawDyadicProduct.mulStep` (line 13) forms four exact signed integer products, combines them as the usual complex real and imaginary numerators, and calls the actual `roundDiv T` once per coordinate. Thus it is one rounded complex product with two rounded coordinates, not two independent complex products. The left operand/output scale is S; the right operand scale is T. Before rounding, dividing each combined numerator by T and then S gives exactly `expIntegerValue S u * expIntegerValue T v` (line 18).

For S,T>0, each coordinate round has error at most 1/(2S). `mulStep_error` (line 32) uses their sum to bound the complex Euclidean norm error by 1/S. This is a conservative norm bound, not an uncharged conversion of a coordinate bound. Integer signs are unrestricted. The imported signed `roundDiv` implements nearest ties toward positive infinity, so negative numerators and halfway cases are covered. No supplied round certificate or assumed arithmetic accuracy remains in this theorem.

For the state update, S=2^120 and T=2^122. Raw exact products are at grid242; dividing by 2^122 returns grid120. The source uses unbounded mathematical integers. Bounded machine widths, witness layouts and backend operation costs are not certified here.

## Initialization and persistent representation

`rawStateInitial` (RawStateProducer line 16) uses the actual computed natural candidate m=inverseRootCandidate(x,2^98), then returns `(m*2^22,0)` as signed integers. `rawStateInitial_value` proves exact equality of this grid120 pair with the real number m/2^98. Since 2^98*2^22=2^120, there is no initialization round or new error allowance. The imaginary coordinate is exactly zero.

For x>0, the reviewed inverse-root generator supplies the adjacent-square conditions and hence initialization error strictly below 2^-98 against `integerPower x 0`. It is not a hypothesis about a proposed literal m. Natural x>0 implies x>=1, which is later needed for true power norm<=1. The code does not claim the positive inverse-root interpretation at x=0, even though its natural-number definitions are total there.

`rawStateNumerator` (line 20) is a natural-index recurrence with precisely this initial pair and update

    mulStep (2^122) (rawStateNumerator k x j) (rawStepNumerator k x).

Every stored state is interpreted on grid120. The fixed right operand is the actual grid122 step producer for the same k,x at every update. No grid100 head, transform input or other lower-precision export is fed back. No separate rounding, approximate cache substitution, step reset or height restart is hidden in the definition.

The mathematical recurrence's repeated occurrence of `rawStepNumerator k x` establishes identical values, not an implementation claim that a runtime or proof checker caches it once. A future cached-loop implementation needs its own equality/trace and lifetime argument; it is outside this audit.

## Exact time and source semantics

`rawTrueStep` (line 28) is exactly exp(i*(-5/64)*log x). The negative sign matches increasing t in `integerPower x t = exp((-1/2-i*t)*log x)`. The previously proved positive-base complex-power identity identifies this with x^(-1/2-it), and the conductor/residue identity in the paper retains the same sign convention.

`rawTrueStep_norm` proves unit norm for every natural x through the real-phase exponential identity. `rawTrueStep_power` (line 64) proves by induction that

    integerPower x 0 * rawTrueStep x^j
      = integerPower x ((j:Real)*5/64).

The height is a real cast before multiplication/division, not natural division of j*5 by64. Index zero is included, and the successor step uses the exact time-addition identity. This algebraic statement is valid for the total `integerPower` definition even at zero; the final positive-source approximation separately requires x>0.

The final finite prefix includes both j=0 and j=90000. The current t<=7000 grid corresponds exactly to j<=89600, hence lies within it. The endpoint j=90000 corresponds to 28125/4=7031.25. This extra slack does not assert that every downstream spectral theorem permits heights above7000. No negative-index or off-grid evaluator is exported by this natural-index recurrence.

## Complete error argument

The generic imported `RawRecurrence.power_state_error_lt_dyadic96` has real proof obligations: true starting norm<=1, exact unit step, approximate step error<=2^-120, initial error<=2^-98, and local update error<=2^-120. It must not be mistaken for a producer on its own.

The new final theorem discharges each obligation:

- x>=1 gives the actual initial power norm<=1 via `integerPower_norm_le_one`.
- `rawTrueStep_norm` supplies exact unit modulus.
- `rawStepValue_true_error` (line 48) applies the actual computed grid122 step theorem with x>0, k<=18 and 2^k<=x<=2*2^k.
- `rawStateValue_zero_error` (line 37) uses the computed inverse root and exact scale embedding.
- `rawStateValue_update_error` (line 55) applies the actual `mulStep_error` at S=2^120,T=2^122. It holds for every k,x,j without a height or source-accuracy premise because it is an algebraic rounding bound for those integer pairs.

Writing delta=2^-120 and e_j for error against the true power, the retained cross term gives

    e_(j+1) <= (1+delta)*e_j + delta + delta.

`RawRecurrence.recurrence_linear_prefix_le` closes an explicit bootstrap, rather than dropping delta*e_j or assuming exact unit norm for the rounded step. If e0+3*N*delta<=1, induction gives e_j<=e0+3*j*delta: the previous envelope yields e_j<=1 and therefore delta*e_j<=delta. Here e0=2^-98,N=90000. The exact final bound is

    2^-98 + 270000*2^-120
      = (279019/1048576)*2^-96 < 2^-96,

and is also <1. This independently checked rational margin makes the final result strict even though the producer's strict initial/step inequalities were weakened to non-strict premises for composition. It is a stronger sufficient estimate than the paper's coarser geometric envelope, with the same target and retained cross term.

`rawStateValue_error` (line 84) therefore has only x>0, k<=18, 2^k<=x<=2*2^k and j<=90000. No approximation, candidate-square, rounding or recurrence hypothesis remains. The integer source range is broad enough for the paper's pool through265800 once each range-reduction witness is supplied; the theorem does not itself enumerate the pool or construct those witnesses. Choosing a different valid k can produce a different rounded step; both are covered independently, but identical-center reuse is not inferred.

## Completed build and axiom evidence

For each receipt below the reviewer matched current source, object and log hashes, and checked exit_code=0, stop=null, source_unchanged=true, dependency_builds=false and command options `-t0 -j1 -M4096`. The two final producer logs are empty. Their earlier version01 mechanical-warning logs remain preserved and were not substituted for the clean version02 evidence.

| Receipt | Receipt SHA256 | Object SHA256 |
|---|---|---|
| `dyadicproduct02.json` | `1C42D7A002DDA8E40B1EE54D25EF15769C76FA54D9C144D9513FDBAFB2E67A9F` | `84C9DD1E16DBA60357F67CE00640AFEC1DE4756FB5A1D35C75233496D7E5CA92` |
| `stateproducer02.json` | `498750913DD53F578AA314356409C6EF310D9DA36DA17888C441A7491242868A` | `CF84CFE94A4EEA9F9020823248102BCDE4EEE462BEAB6F77A732E870E5F0AD77` |
| `stateaudit01.json` | `1EF2701486F6823C7FBFF72B0BF3157CC4BCD1D8F92D5B95B57319593653EF5A` | `305E4C1306D6DDEC5266D7296FAED06BCEC43B51F3E92718CC376F86D6163FC3` |

The empty producer logs have SHA256 `E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855`. `stateaudit01.log` is SHA256 `11549F9D65AC61F83A715E4E05B121126B0812E9238A286D6DC907961C4E8395`.

The probe prints three actual signatures: `mulStep_error`, `rawStateValue_error`, and `rawTrueStep_power`. In particular it confirms the five stated integer premises and actual `integerPower (j*5/64)` target of the final theorem. Five dependency lists—`mulStep_error`, `rawStateInitial_value`, `rawStateValue_update_error`, `rawTrueStep_power`, `rawStateValue_error`—each contain exactly `[propext, Classical.choice, Quot.sound]`. No custom source/rounding axiom or sorry/native-decision axiom is present in these inspected closures.

This is evidence from the coordinator's existing strict builds and imported-declaration probe, not a fresh reviewer build or an independent literal-type equality example. The full source-body review supplies the semantic comparison. Imported generic Mathlib/library foundations retain their ordinary trust boundary. Compilation observations do not establish checker throughput or a complete generation/checking cost.

## Exclusions and use obligations

A concrete exported state array still needs checked equality of every used literal to the actual recurrence, or a separately proved equivalent trace. A hash or a radius alone is not that identity. Correct source x, range-reduction k, height j, scales and step version must survive cache use. No such array, success distribution or cost saving is inferred here.

CachedLoop, three-product alternatives, witness-only alternatives, machine capacities and their pricing are excluded. Conductor-cache multiplication, actual grid100 raw-head export and assembly, H/J0 transport, transform/completion/interpolation and sign/count consumers are also not completed by this theorem. The previous extended audit remains unchanged; this separate report reviews only the newly assigned state/product extension and its necessary mathematical dependencies.
