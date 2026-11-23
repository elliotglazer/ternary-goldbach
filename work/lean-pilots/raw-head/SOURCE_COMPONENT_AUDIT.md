# Independent raw-head source component audit

Status: PASS for mathematical/source fidelity and the compiled core, including the default-resource64-case packaging successor described in the final section. The earlier heartbeat override remains explicitly historical. The successor preserves the exact expanded64-claim theorem type and uses no raised heartbeat setting. No performance extrapolation or source-to-sign/count closure is asserted.

Reviewer: independent-feasibility. Scope: read-only mathematical, definition and saved-receipt review; no Lean/HOL/native build, producer evaluation, inventory or proof emission. This file is the only review output. Exponential-tail/Horner successors are outside this audit.

## Source and intended boundary

The mathematical source is `work/qrh-campaign/agents/integration/RAW_HEAD_GRID100_PRODUCER_AUDIT_2026-11-11.md`, SHA256 `FBBB538E0FC72865A9B4815A048992644AA0563AFC2DEA970FB9C3B4F7596EEE`, especially sections 2 through 4. Its prior bounded independent review is `work/qrh-campaign/agents/independent-feasibility/REVIEW_RAW_HEAD_GRID100_PRODUCER_2026-11-11.md`.

This component must conclude an error bound for the actual `Real.log x`, with an explicit integer center on grid129. It is not enough to prove accuracy relative to a finite polynomial or a checked residual alone. The source domain is positive integers through265800. A range witness must satisfy `k<=18` and `2^k<=x<=2*2^k`; its lower inequality also prevents truncated natural subtraction from changing the numerator.

The inspected implementation separates the analytic tail in `RawLogTail.lean`, the integer algorithm in `RawLogHorner.lean`, and assembly in `RawLogAssembly.lean`. Its generic range-conditioned theorem is a legitimate internal producer interface. A concrete certificate must supply the actual range witness and establish its computed integer center. It must not export those facts as unresolved premises of a claimed generated sample.

## Integer rounding and recurrence

`roundDiv d r=(2*r+d)/(2*d)` uses integer Euclidean division. For positive d its remainder lies in `[0,2*d)`, hence the output is nearest to `r/d`, with ties toward positive infinity. The absolute error is at most1/2 even for negative r. The positivity premise is essential; the total definition at other d is not an admitted rounding interface.

For natural S,A,B,N,k with `B>0` and `3*A<=B`, the inspected recurrence is exactly

    H(0,k)=0
    H(N+1,k)=roundDiv ((2k+1)B^2)
      (S B^2+(2k+1)A^2 H(N,k+1)).

Writing `v=A/B`, its ideal normalized state is

    F(N,k)=sum_(j<N) v^(2j)/(2(k+j)+1),
    F(N+1,k)=1/(2k+1)+v^2 F(N,k+1).

Thus the denominator does not accidentally divide the recursive coefficient by `2k+1`. The final `logCenter` rounds `2*A*H(N,0)/B`, and `logPartial N v=2*v*F(N,0)`.

The source proof uses a simple invariant `|H-SF|<=1`: one step contributes at most1/2 and propagates the previous error by `v^2<=1/9`. Therefore its new error is at most11/18, which is below1. The final integer error is at most `1/2+2v<=7/6<7/4`, proving the stated `7/(4S)` bound after division by positive S. This is more than sufficient; no improvement of the adopted budget is needed. N=0 and A=0 are valid, and all recursive denominators remain positive.

## Analytic tail and complete grid error

I read Mathlib's actual `Real.sum_range_sub_log_div_le` in `Mathlib/Analysis/SpecialFunctions/Log/Deriv.lean:290`. For `|v|<1` it bounds the difference between half the actual logarithm of `(1+v)/(1-v)` and its N-term odd-power series by `|v|^(2N+1)/(1-v^2)`. The helper correctly multiplies this bound by2. On `[0,1/3]` the resulting coarse tail is at most `(9/4)*3^(-(2N+1))`.

For N45, even this coarser tail is strictly below `2^-135`. The implementation does not need the sharper factor1/91 from a direct series-tail bound. The inclusive endpoint v=1/3 supplies the shared log2; v=0 supplies log1.

Positive-base logarithm identities give the exact range decomposition with `A=x-2^k` and `B=x+2^k`. The implementation retains the log2 center at grid137, multiplies it by k exactly, adds the other grid137 center exactly, and rounds that integer once by256. Interpreting the result on grid129 is the correct scaling. Its final round contributes at most `2^-130`.

With k+1<=19, the full error is bounded by

    19*2^-135 + 19*7/(4*2^137) + 2^-130
      = (949/2048)*2^-128 < 2^-128.

Five independent fixed rational checks confirmed the coarse tail, this exact budget identity, its strict margin, the generic geometric budget and `265800<2^19`. They evaluated no logarithm or generated input. Prematurely rounding the cached log2 to grid129 before multiplying by k would not be covered by this proof.

## Adjacent helper interfaces

`RawInverseRoot.lean` uses adjacent integer squares to enclose the actual positive inverse square root. Even though its candidate m is signed, the two inequalities force m>=0: for m<=-1, `(m+1)^2<=m^2` contradicts the strict upper comparison. Positive x and S then give `0<=sqrt(x)^(-1)-m/S<1/S`. This is a checker soundness theorem. Actual candidates and both comparisons are still required.

`RawPowerIdentity.lean` defines the actual complex exponential with exponent `(-1/2-i*t)*log(x)` and proves its principal-cpow interpretation for positive x. The raw-head identity `c*conj(B_c(t))*B_a(t)=(a/c)^(-1/2-it)` has the correct conductor factor and phase sign. The later external `c^(-s)` is not part of this identity. The final source also proves `exp(-log(x)/2)=sqrt(x)^(-1)` for positive x using ordinary real-power identities. `RawInitialization.lean` then transports the adjacent-square certificate to the actual complex `integerPower x 0`, retaining the same strict `1/S` error. Its only logical premises are positive x,S and the two integer comparisons; it assumes no numerical inverse-root enclosure.

`RawRecurrence.lean` retains the uncertain-step cross term. Its one-step bound is `(1+eps)*e_j+eps+u`. The linear bootstrap at equal step and round tolerances delta proves `e_j<=e0+3j*delta` provided that envelope stays below1. The selected `e0=2^-98`, `delta=2^-120`, `j<=90000` gives strict error below `2^-96`. The hypotheses about initial, step and local-round errors are appropriate for this internal helper; they are not evidence that the concrete step/state producers exist.

## Remaining acceptance and cost boundaries

The component establishes actual finite logarithm and inverse-root enclosures and the generic height-zero power adapter. It does not establish a positive-height integer-power state, actual unit step, grid100 raw head, shifted-Hurwitz polynomial, transform input, completed sign or zero count. Those conclusions require the remaining producers and exact source/height/grid joins. This review does not convert the conditional recurrence hypotheses into accomplished numerical evidence.

The author subsequently added `log129WithLogTwo`, an executable path taking the shared grid137 integer explicitly, and an exact equality bridge under the checked log2 identity. `RawLogCases.lean` proves `logTwo_checked` once, then uses the literal shared center in each concrete computation. This resolves the specific semantic cache-binding concern. Timing must still distinguish one-time construction from per-input work and imports. Integer divisions, ranges, final rounding, witness generation, literal data and exact output binding remain chargeable. No old 48-product paper subtotal is automatically a measured cost for this new integer implementation.

I read the untrusted generator without executing it and inspected the generated declarations for the eight inputs 1, 2, 3, 41, 61, 10004, 262144 and 265800, then the expanded 64-input fixture. The latter retains those eight and adds 56 distinct integer inputs across the declared domain. The centers are tied to the actual integer program by `decide +kernel`, then transported through the generic bound. Every final `log_x` statement has an actual `Real.log` conclusion with no range, primality, approximation or center-equality hypothesis. Each inverse-root statement similarly supplies the two concrete square comparisons. The separate `RawLogData` and `RawLogData64` namespaces contain the shared literal definitions; theorem namespaces consume their checked identities.

The expanded independent static check made 886 assertions on the two fixture/source pairs and controls: distinct input counts, exact literal bindings, positive-domain/range witnesses, each actual analytic statement and its supplied premises, and absence of `sorry`, custom `axiom` or `native_decide` in the generated files. It did not run the generator or the source arithmetic algorithm. The first static check needed an explicit UTF-8 file-read correction before its 84-check result; that decoder issue was not a theorem or arithmetic failure.

Five closed controls prove that a modified output, input, shared log2 cache, excessive inverse-root candidate and deficient inverse-root candidate fail their actual executable checks. Two further controls exercise negative rounding, including a tie toward positive infinity. They test the actual program and adjacent-square predicates rather than a detached checksum. Successful control compilation cannot replace the generic correctness proof.

The first 64-case build stopped at the large final inverse-root conjunction's ordinary heartbeat limit. That failed module build was not treated as accepted closure. The first accepted snapshot compiled its exact conjunction by sequential `And.intro` applications with the local heartbeat setting. The earlier eight-case source and all individual analytic claims retained their intended statements. The final section below separately checks the successor that removes this setting.

## Binder and actual-export check

The following table records the relevant logical interfaces. Natural, integer, real and complex parameters are typing inputs. No project-owned assumption bundle or class hides additional premises.

| Declaration | Logical premises | Classification and actual conclusion |
|---|---|---|
| `roundDiv_error` | `d>0` | SOURCE. Bounds the actual integer division against r/d. |
| `logHorner_error` | `B>0`, `3*A<=B` | SOURCE. Compares the actual integer recursion with the exact ideal state. |
| `logCenter_error` | `S>0`, `B>0`, `3*A<=B` | SOURCE. Adds the final rational multiplication and rounding. |
| `log129Center_error` | `x>0`, `k<=18`, `2^k<=x`, `x<=2*2^k` | SOURCE. Bounds the actual `Real.log x` error strictly by `2^-128`. |
| `log129WithLogTwo_eq` | equality of the supplied cache with the exact integer log2 algorithm | SOURCE for this internal adapter; discharged by `logTwo_checked` in every concrete case. |
| `inverse_sqrt_sub_div_bounds` | `x>0`, `S>0`, lower and upper adjacent-square checks | SOURCE. Encloses the actual positive inverse root. |
| `integerPower_zero_initialization_error` | the same four inverse-root premises | SOURCE. Encloses the actual height-zero complex power. |
| `integerPower_raw_head` | positive a and c | SOURCE. Exact principal-power identity for arbitrary real t. |
| `power_state_error_lt_dyadic96` | true amplitude bound, unit step, step error, initial error, every local-round error; `j<=90000` | SOURCE for the internal recurrence theorem. Concrete step/state producers remain open. |
| `RawLogCases.all_logs`, `RawLogCases.all_inverse_roots` | none | Eight concrete actual-function enclosures; zero EXCESS premises. |
| `RawLogCases64.all_logs`, `RawLogCases64.all_inverse_roots` | none | Sixty-four concrete actual-function enclosures; zero EXCESS premises. |

All listed source interfaces have zero EXCESS, STANDING or RULED premises. The generated exports do not leave source-generation, arithmetic, range, primality or coverage assumptions to a consumer.

## First accepted snapshot and saved-build evidence

Hashes are SHA256. This table retains the first accepted snapshot, previously recorded by this audit at hash `DFE2280A3F14FD9183DD5948EFC29614B71FE7D4519ADE680791EF393E0A00D8`. The final section supersedes only the64-case source and audit probe entries. Every listed successful build receipt has exit code0, no external stop, source_unchanged=true and dependency_builds=false. I recomputed its source and log hashes against the receipt when accepting that snapshot. I did not rerun a build.

| Source | Source hash | Successful receipt | Receipt hash |
|---|---|---|---|
| RawLogTail.lean | 2D6E8E9A38086653661FF06A263164BF04B077E41C7EFBDD96011466EB52AB55 | logtail02.json | AB32310F8D26E4CDB6C765FBED301E00D4855007C8EB24FCCB570DB302469762 |
| RawLogHorner.lean | B8F3D80805063D22C653D1949732DE0B67E92BE329512EABD1198A88E8A67AAD | loghorner03.json | AE8407562FF649EA7D006296A63DEC679B2E4892B5F33EED0CC4B82EB5EB58A7 |
| RawLogAssembly.lean | BDF4C5DABB9F68EA9E5754452CE0C228EDA801A9F144A4648F415E7C900485D7 | logassembly02.json | 3C58058BACF5E33426834261784032F9F52875AB2B8AA638D36A795524020D56 |
| RawInverseRoot.lean | D0B6C28B39F35DE88056CA4BBB078B2A8D84463DC92AAA2D32F3C4CD1BA67619 | invroot02.json | 401AE9239F1416B24A94A0EA732CC93ACE9C557413D7679A50809D06A7DCEBC1 |
| RawLogCases.lean | 6CC1E45D4E8C33BFD52D3E8A752D2A08F34682399F31E8F92EC27F3C02157AEA | logcases02.json | 6B741AC7DA6F96F700949B1A4B52F9E6B51D3B35E571925FF0ABB4EB0EB98B15 |
| RawLogCases64.lean | D744F35C15C7D188F714F7F6438C5CDACEA7B7EB0E6E6B79CD7B63F97EA61ABA | logcases64_03.json | B9C2ABAE653DC7F082C114293CD327D90DCB407D91BC683EAA4EAF6C1FC1A153 |
| RawSourceControls.lean | B331448EE92731B8B601BEF067F5EB720ACBBB9B1C91A8D2903BB437BAB13F34 | sourcecontrols01.json | 65C47803DAB3850F8EB3EEE9D61DFD7D2DE2CB1385823A9CF0AA15437F864ED3 |
| RawPowerIdentity.lean | 94106C4B629AB59BA50DA9DAD3F0564BAF6BF681911561C45D626F1BE0203447 | power05.json | 23CE43FD76B6A7FEB6B6369DC3E04E07BBB70B48A013B9F23CC31326E6BBB112 |
| RawRecurrence.lean | 21B56EAA24799BCE237C30F318A05276FC5F504A3D6A4E3A3B921BCBBED32C7A | recur03.json | 642CEE2A322C32D53A20E306C57CDC6B9AA7DA24371F6B708CF5E258503114E9 |
| RawInitialization.lean | C695D2F12F1822C57A8E13EC4376CD2E0378D90B82ABD111805FC7A72FACA1E1 | initialization01.json | 99BFB220EF91A50F42D9BC2972EDB5C703EB1CFAB0B53C3B15CFAC51DBAD6ABD |
| AuditRawSources.lean | 40B105752AC8D4E356C887378B6667F3C8CB17D5B52500813857936AD8CBF9B8 | sourceaudit01.json | 81C1423C5F1C492A054500FF75DE976681F7F4F026641C7B7AFCAEB42BABCD6F |

`fixture.json` is `6B3BFB1F685C50BC4588C499FBAAA27B68763FC18604ED3E74ACFED9B44BE93B`; `fixture64.json` is `BB725A50AB0EC32A07F3516542E2FC3CE59081E75598E7283B686D0AFDBB12C3`; the current untrusted generator is `573E6059882C9BC7D04F57D4D7793C41ECCC16367B2A56840A28DC170B905C48`. Both fixture/source sets passed the repeated 886-check static binding test after the final aggregation edit. Literal numerical truth is accepted through the recorded Lean kernel proofs, not these metadata checks or the Python generator.

`sourceaudit01.log`, hash `2EB8E44FD695180E6B41397B218118A3A6125EACF1F80A6ADFA5CC6F41580AB9`, reports the exact source-facing types and14 axiom lists. Every reported axiom lies in `{propext, Classical.choice, Quot.sound}`. This includes both8/64 logarithm and inverse-root conjunctions, the main analytic helpers and the five false controls. The initialization adapter was separately compiled and read in full; the saved probe did not separately print its axiom list. Its body only composes the pinned inverse-root and actual-power lemmas with ordinary norm/real identities.

The first snapshot's ten core sources contain no `sorry`, custom axiom or `native_decide`. Its only resource override was the identified local setting in `RawLogCases64.lean`, removed by the successor below. The runner, hash `8439769E5AFC6E12CE1B908F691BD15EF9B8090D92762EFDA4FF6EB6EE64736F`, uses Lean4.35 with `-t0 -j1 -M4096`, a600-second external time cap and a4-GiB observed-private-memory cap. Lowercase `-t0` sets trust level, not heartbeats. The nonempty successful recurrence log contains only an unused-variable warning. Prior failed elaboration and aggregation receipts remain historical evidence, not successful acceptance.

The separately compiled `RawReplay.lean` timing helper and later CPU measurements are not a speed verdict of this audit. Timing transfer, concrete positive-height step/state production and all source-to-sign/count work remain separate.

## Default-resource64-case successor

PASS without a remaining packaging qualification for the successor bound here. The historical source is preserved byte-for-byte at `history/RawLogCases64_heartbeat.lean.txt`, SHA256 `D744F35C15C7D188F714F7F6438C5CDACEA7B7EB0E6E6B79CD7B63F97EA61ABA`. I checked that equality directly. Its earlier timing remains a historical pilot observation and must not be relabeled a default-resource build.

The successor preserves every earlier definition, individual theorem and `all_logs` byte-for-byte. Only the final inverse-root aggregation changes. The explicit theorem header now uses Lean's builtin `(type_of% inverse_sqrt_x)` for each of the same64 closed leaf theorems, in the same order and right-associated conjunction. Its proof is exactly63 `And.intro` applications to those64 proofs. There is no inferred header hole, proof-valued definition, new predicate, extra hypothesis, custom syntax or raised resource setting. The failed `theorem ... : _` attempt is not the accepted source.

I independently compared the header leaf list, proof leaf list and audit-probe leaf list with the64 fixture records, including uniqueness and order. The earlier886 static checks remain applicable because all individual sources are unchanged. Eight successor checks additionally bound the preserved source, identical prefix, exact ordered header/body, constructor count and absence of overrides.

The successful probe does not rely on truncated pretty-printing. It reads each leaf as a compiled theorem, takes its actual `ConstantInfo.type`, reverses the accumulated list and constructs the exact right-associated `And` expression. It checks the aggregate is also a theorem and compares `actual.type` with that expected expression using `Lean.Expr.equal`. The final log reports `AGGREGATE_TYPE,64,exact_ordered_conjunction`. This is audit evidence about the compiled expressions; it introduces no theorem premise or axiom. In particular, no leaf or its inverse-root lower/upper pair has been removed, weakened or replaced.

| Successor artifact | SHA256 |
|---|---|
| RawLogCases64.lean | 0B922F559AB7F10EEFFC0FEAB697AED9D8035BA1161C4B30F636A43C829D01EC |
| RawLogCases64.olean | 890C853F2984DF84D199376C01FDE72E126ADADF29B5E6C444668867711296DE |
| logcases64_06.json | F2938BF321A797F36BDF473B5E5AF672941E5F922D0386D362F3BDBC0185F89B |
| AuditRawSources.lean | 50601CBB97F8543CE08E22C77C35B4320F50D6945E009C6A95A9AEB485C00210 |
| AuditRawSources.olean | 3BA63D94ADC539E71F840FB616ED763E7E4381E588A8C03582A2250DA5A7EBFD |
| sourceaudit04.json | 76DA7E621C9C4FB0EFC2F9E0B63D4B2F1CD72E40F06CFABD2792DB00055C844C |
| sourceaudit04.log | 8F3EA8CABD758B4C32137672BEA2D9D458EFFCCD4B1FEFD751D512D3584D6C77 |
| generate_cases.py | 2D929670B83B39F3BBD5C7EEF9CA4B155C33D13177C3F7E6C47EBC4075EEDD9F |

Both successor receipts report exit0, no stop, unchanged source and no dependency builds. I recomputed their source, object and log hashes. The64-case compile log is empty. The new audit log repeats14 axiom lists, all contained in `{propext, Classical.choice, Quot.sound}`, and adds the successful exact-expression check. The generator was read but not run by this reviewer. Both fixture JSON files retain the hashes already recorded above.

This closes the requested default-resource packaging and exact-type audit for the core logarithm/inverse-root component. The mathematical boundary is unchanged: actual64-input enclosures and the generic power/initialization/recurrence helpers are accepted; a complete positive-height source, character transform, sign or zero count is not supplied by this component.
