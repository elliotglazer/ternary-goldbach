# Compact conductor-eight tensor receipt and execution contract

2026-11-11. Paper/schema preparation only. No evaluator code, numerical import, function value, Fourier transform, receipt generation, Lean declaration or build was performed. This contract implements the data and execution requirements of the accepted design without authorizing a run. Code preparation, static review, a benign supervisor-capability check and a separately bound execution decision remain later gates.

Pre-acceptance revision: this version supersedes SHA256 `717110591A5572B4895878EE2E8597B9C7BCB640E988219421FE5177CF82D79C`. It fixes the shared root-table labels and explicitly admits the separately reviewed independent endpoint-power P-jet calculation. The producer's Q32 formula, all required outputs and all resource limits are unchanged.

## 1. Fixed specification and trust boundary

The governing design is `zero-sum/NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md`, SHA256 `3B4B21946F89CA503F03A2BBC030B73F556B31254BA643C427AFB1B39CA5A43B`; its independent paper review is `moebius/REVIEW_NONPRINCIPAL_TENSOR_PILOT_DESIGN_2026-11-11.md`, SHA256 `0046FAEEC56248F33F5AB9CD80E8C8675631FBF77679FE54CE436DD9A56FCFA3`. Paths in this note are relative to `work/qrh-campaign/agents` unless stated otherwise. Their existing analytic dependencies and source versions are retained, not silently replaced by principal-zeta formulas.

The fixed binding table also includes:

| Source | SHA256 |
|---|---|
| `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC` |
| `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64` |
| `zero-sum/POLE_DIFFERENCE_JET_ENCLOSURE_PLAN_2026-11-11.md` | `3F73AF600725DDB51ED622577BF374251B38C408D0D52D4EA06CFCF1BDD60011` |
| `moebius/REVIEW_POLE_DIFFERENCE_JET_ENCLOSURE_2026-11-11.md` | `39D7D84D0706FE27A7DEF211684FA1DCA4D9E3544AB1A496AE435DDF4E04F577` |
| `major-constants/FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233` |
| `mellin/REVIEW_FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF` |
| `integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` |
| `audit/REVIEW_UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md` | `222346A598FB72100005E065A6BFA77DCDE91B8B8F9F068847BE9DCBA0FB558D` |
| `major-constants/C8_INDEPENDENT_POLE_JET_ALLOCATION_2026-11-11.md` | `59C6448E26CDC8AD7DA944017C555B2F3B3F1A4D70E98B4B275585FA5BC46E48` |
| `moebius/REVIEW_C8_INDEPENDENT_POLE_JET_ALLOCATION_2026-11-11.md` | `B50F5AF842E71467E821F97070D6315F08E5921F29E16D5362561B48591D851E` |

The new supervisor proposal `audit/C8_EXTERNAL_SUPERVISION_DESIGN_2026-11-11.md`, SHA256 `EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19`, is a conditional implementation design, with independent review and benign capability testing still separate. This schema does not presume that its required post-exit query works on this host.

Bind these exact parameters independently of supplied claims:

`c=8, v=4, T=1, N=37, M=16, K=30, p=32, Qpole=32, J=3, L=16, R=1, rho=1/16; s_base=1+i/8, Delta=-1/8, s_j=1+i*(1-j)/8`.

All jets are normalized complex-s derivatives, orders h=0,...,29. The nine actual-function models are the three nonprincipal labels at all three centers. Each domain is a full closed complex disk of radius1/16, not only a diameter segment. No half-plane, nonvanishing, winding, GRH or spectral-coverage test is required or licensed by this schema.

There are four mandatory acceptance layers: actual-moment enclosures; the normalized two-axis transform of **exact stored centers**; complete finite-function coefficient enclosures; and actual-L disk/endpoint enclosures using the reviewed analytic adapters. Independent reconstruction must cover every record at each layer. Stored source hashes and arithmetic summaries do not replace those checks. External elementary interval computations remain externally trusted evidence; this is not a rational analytic proof or a Lean checker.

## 2. Files, indices and common scalars

Use a new versioned format `c8-tensor-pilot-v1` and a fresh attempt directory. A producer payload and a separate independent payload each have a manifest, completion seal and bounded logs. All required numerical records reside in one streamed payload per attempt; no duplicate full snapshots are retained. A decoder may stream arrays. It must verify exact counts, index order and all parameter/type restrictions before treating an entry as a claim.

The shared rational table contains the exact parameters and budgets, using these names:

```
epsilon_moment = epsilon_tensor = 2^-90
own_moment_error = own_tensor_error = 2^-92
pole_finite_arithmetic = 2^-85
pole_analytic_tail = 2^-113       # producer Q32 path only; zero at exact s=1
independent_endpoint_power_tail = 0  # exact formulas, not a truncated moment series
residue_block = 2^-84
residue_correction = 2^-82
character_correction = residual_contraction = 2^-79
coefficient_assembly = 2^-77
coefficient_radius = 2^-75
main_residual_per_order = 2^17/32!
EM_norm_bound = 2^-70
Taylor_norm_bound = 2^-77
outer_finite_L_bound = 2^42
polynomial_evaluation_error = 2^-75
disk_radius = endpoint_radius = 2^-68
```

The EM/Taylor entries are conservative non-strict enclosures backed by the design's strict analytic inequalities. The checker separately verifies the exact domain/scalar premises; a header constant alone is not an analytic bound. Every disk/endpoint comparison retains the required strict total-error inequality. The main per-order residual is already inside the final coefficient radius, and the P tail is already inside the complete P block. Neither is added twice.

Unit-coordinate index is `u=2e+f`, with `(e,f)` in `{0,1}^2`, f fastest. Unit representatives are `[1,5,7,3]`, endpoint bases `[297,301,303,299]`. Head index is `b=37u+nu`, nu=0,...,36, with exact base `n_b=8nu+a_u`. There are148 distinct head bases. Character index is `r=2alpha+beta` with values `(-1)^(alpha*e+beta*f)` in that same unit order, zero on nonunits.

| r | Values at 1,5,7,3 | Source status | Permitted output |
|---|---|---|---|
| 0 = 00 | +,+,+,+ | Principal, conductor1, even | Finite-array artifact only |
| 1 = 01 | +,-,+,- | Primitive conductor8, even | Actual nonprincipal L model |
| 2 = 10 | +,+,-,- | Conductor4 induced to level8, odd | Actual nonprincipal level8 L model |
| 3 = 11 | +,-,-,+ | Primitive conductor8, odd | Actual nonprincipal L model |

Retain all four rows in the tensor outputs, including all2,880 principal-row entries. Actual L coefficients/models/endpoints have only r=1,2,3. The multiplication table, reduction kernel `{1,5}`, conductor and parity checks are exact finite obligations. Counts alone do not identify source characters. All rows here are real and self-conjugate; this pilot does not test complex character phases.

The dense array order is normative:

* Moment position `(((h*32+m)*4+u)*16+k)`, h<30,m<32,u<4,k<16: exactly61,440 entries.
* Tensor position `(((h*32+m)*3+j)*4+r)`, j<3,r<4: exactly11,520 entries, with time label `ell_j=(-j) mod16`, namely0,15,14.
* Correction packet position `3u+j`: exactly12 packets, all four residues/all centers.
* Actual-model position `3(r-1)+j`: exactly9 models; coefficient h is its h-th entry. There are270 coefficient claims.
* Endpoint position `2*(3(r-1)+j)+side`, side0=upper, side1=lower: exactly18 incidence records. Height is `(1-j)/8 + (1-2side)/16`. Shared endpoints stay duplicated by incidence, with the same exact character and rational point.

No principal row may acquire an actual-L label, especially at s=1. The full nonprincipal-L reconstruction has no extra factor8^(-s), multiplication or division by s-1, Gauss factor or parity one-half. This restriction does not prohibit the proved internal P-jet recurrence at the two exact nonzero values q=s_j-1=+/-i/8, specified in section7; it is never used at q=0.

## 3. Lossless wire encoding and byte bounds

Use UTF-8 containing canonical ASCII numbers and compact separators, no pretty-print whitespace in bulk arrays. Reject duplicate object keys, booleans in integer positions, floats/NaN, noncanonical decimal strings, unknown tags, wrong array lengths, invalid references, unordered intervals and negative radii. Telemetry uses integer monotonic ticks with a recorded exact frequency, or integer nanoseconds, rather than floating-point mathematical fields. Bounds are checked **before** allocating shifted integers or parsing an unbounded numeric token.

```
D = [signed canonical decimal mantissa string, signed integer exponent]
    # exact m*2^e; m odd, or exactly ["0",0]
Q = [signed canonical decimal numerator string, positive decimal denominator string]
    # reduced rational, positive denominator
C = [D_re_mid, D_im_mid, D_re_radius, D_im_radius]
    # closed rectangle, radii nonnegative; never rounded display endpoints
Center = [D_re, D_im]
```

For bulk D values require `abs(m)<2^256` and `abs(e)<=4096`. This admits the specified192-bit producer and256-bit independent finite balls if their actual records fit; it is not a guarantee that every intermediate fits. A range failure is INCOMPLETE, not permission to clip a tiny value or raise precision. General Q payloads have numerator/denominator bit lengths at most4096 and are used only in bounded small sections. Exact reconstruction may use larger temporary integers under the memory/time caps; these wire limits do not justify truncation. A separate type/tag is used where a rational constant reference is needed, so a rational `1/(k+1)` is not falsely encoded as an exact dyadic.

The canonical zero **complex** record may be the integer token0 in a C position, denoting four exact zero components. This saves bytes but not a claim: the record still occupies its indexed slot, and its exact-zero semantics must be proved by the corresponding reconstruction. Empty bins, the n=1 simplification and exact a=1 P zeros are legitimate sources. A small computed value is not a zero certificate.

Four D values fit in at most361 bytes as a C record, or362 including its trailing array comma: a signed256-bit mantissa uses at most79 characters, quotes add2, a signed exponent needs at most5, and the pair punctuation adds3. Thus the61,440+11,520 mandatory bulk C records occupy at most26,411,520 bytes. Shared canonical norm radii are written once; the C radii are the producer's own rectangular witness radii, not the published Euclidean radius. The same compact bound applies to independent reconstructed bulk C arrays. Independent center-to-target distances are computed exactly rather than redundantly serialized as73,000 additional fractions.

This is a bound on two encoded arrays, not on total memory or total output. Enforce a48MiB main-payload cap, a4MiB aggregate companion/manifest/completion cap, a4MiB aggregate log cap and an8MiB reserve, always under the overall64MiB retained-output cap. All pending files, partial files, checkpoints and supervisor logs count. Renaming one pending payload does not duplicate it. Never retain both a full pending and a copied final payload. No repeated full checkpoints are permitted. If the remaining required sections cannot fit, report INCOMPLETE; do not omit evidence, sample records, silently compress away semantics or exceed64MiB.

These are **per-attempt** budgets from the accepted design: one producer allowance and one separate independent allowance. The independent job reads the producer payload in place and need not duplicate it. Any new copy it retains counts toward its own output budget. Existing read-only source files are dependencies, not newly generated output.

## 4. Required producer payload

The top-level sections are `format`, `binding`, `parameters`, `characters`, `encoding`, `budgets`, `elementary`, `bins`, `moments`, `circuit`, `head_contractions`, `corrections`, `coefficients`, `models`, `endpoints`, `consistency`, `worker_observations`, `status`. Optional bounded failure details do not replace required sections in a complete candidate. The later code preflight must freeze these names and exact decoder rules; semantic changes require a new schema version.

**Binding.** Store producer code hash, schema/design/review hashes, every analytic-source pin, the coordinator run-record hash and the intended output filename. The coordinator record fixes192-bit arithmetic, the exact parameters, caps and approved code/static-review versions. All hashes are recomputed before acceptance. They provide provenance only.

**Elementary and bins.** Store one lossless pi enclosure, the148 head log/base-phase enclosures, four endpoint log/phase families at all three centers or their exact fixed recurrence recipe, `ell=log297`, and the four d_u=log(X_u/297) enclosures. Record named exact special cases. Each of the148 bins supplies the full signed q, k=q mod16, a rational midpoint witness with actual x=-log(n)/pi within1/8, and its real residual enclosure `3*(Delta*log n-2*pi*q/16)`. Verify abs(residual)<1, complete base mapping and exact n=1 zero. Error in log/pi is included, not ignored when assigning a bin.

**Moments.** Serialize all61,440 C records in the index order above. Their midpoints are the exact serialized moment centers. Each witness rectangle must enclose the actual defining bucket sum and have Euclidean error from its midpoint at most epsilon/4, certified for example by its L1 radius. Publish the canonical radius epsilon=2^-90 about that midpoint, including zero slots. Fresh independent moment reconstruction must fit in this published ball. Its radius is not enlarged to accommodate a failed comparison. The specification fixes each moment's actual positive-base formula, factorials, signed residual and bin; a label such as `moment` does not prove it.

**Circuit.** Store one table of15 lossless enclosures `root[t]=exp(2*pi*i*t/16)` for t=1,...,15, in that order; `root[0]=1` is exact and is not duplicated in the table. These are powers of the positive primitive16th root, not fifteen distinct primitive roots. They are NOT stage-local records with repeated zeros. A butterfly of length d in{2,4,8,16}, local label b=0,...,d/2-1, uses `root[(16/d)*b mod16]`. A direct time-DFT term at input k and output ell uses `root[k*ell mod16]`, so all fifteen nonzero labels have a fixed meaning. Also record the stage lengths, fixed recipe identifier, and all11,520 C output records. Output midpoints are exact rationals; own circuit-witness norm errors must be at most epsilon/4 before publishing radius epsilon. Group roots are the exact signs, not numerical roots. The circuit recipe starts from exact stored moment centers, applies bit-reversed length16 positive butterflies `(u+w*v)/2,(u-w*v)/2`, then for each retained time label applies the f-axis normalized two-point transform followed by the e-axis one. This yields the group normalization1/4 and time normalization1/16. It computes all four r outputs per(h,m,j), before residual contraction.

To avoid a full stage dump, this contract selects a **separate deterministic exact-rational interval replay** of that fixed circuit from the stored exact centers and recorded twiddle rectangles. Every butterfly and group operation is reconstructed. Require its complete result to lie inside the supplied own witness rectangle, and hence within epsilon/4 of the published center. Temporary stage arrays may be discarded after checking; they are reproducible from retained inputs. This is a certificate calculation for the same unrounded mathematical circuit, not a claim that unspecified native192-bit intermediate balls were reproduced. The source identities and all operation-containment rules remain necessary. A later implementation may instead store/replay named outward-rounded gates, but that would need a frozen rounding recipe and code preflight, not an informal substitution.

The independent program must ALSO check all11,520 outputs by direct finite normalized tensor sums on the exact stored moment centers, with independently enclosed roots. A circuit replay alone does not replace that distinct direct-transform check. No time-stage output outside the specified three labels is advertised as a function value. Omitting a stage dump is legitimate deterministic reconstruction, not sampling.

**Head contractions.** Retain360 center/error records, all r=0,...,3, h<30 and j<3; principal records stay marked finite-array artifacts. The exact polynomial is `64*sum(m<32)(j/3)^m*tensor_center(h,m,j,r)`. Use exact rationals0,1/3,2/3; any rounding has a separate checked norm allowance<=2^-79. Store or reconstruct the exact source-input sum and circuit-error sum, each<=2^-79, with the correct scale64. The per-order analytic head residual is stored separately as2^17/32!, not folded into FFT arithmetic. At j=0, y^0=1 and all positive powers vanish exactly.

## 5. Complete producer correction packets and removable-point identities

There are12 packets, each containing30 normalized jets for the half endpoint, the complete16-term Bernoulli block, and P, with separate error certificates and their final addition. Share the signed rational Bernoulli table and factorials once. Retain or deterministically reconstruct every rising-factorial coefficient up to degree29 and length31 with old-array multiplication; coefficients of higher polynomial factors are not discarded before their low-degree contributions are computed. All192 residue/center/Bernoulli-term series remain checked, whether represented explicitly or reconstructed from this exact recipe.

The Bernoulli block must retain `8^(2m-1)*X_u^(1-s-2m)` or its proven equivalent `X_u^(-s)/(37+a_u/8)^(2m-1)`. A circuit that mixes the two scalings fails. The packet's whole-block arithmetic error includes construction AND summation, not2^-84 for each of16 terms.

For P record the exact expression binding

```
P_(u,h)(s)=-(d_u/8)*E*(-1)^h
  *sum(k=0..h) ell^(h-k)*d_u^k/((h-k)!*k!)*phi_k(z),
z=(1-s)*d_u, E=exp((1-s)*ell),
phi_k,Q(z)=sum(m=0..31) z^m/(m!*(m+k+1)).
```

Each producer packet stores z/E enclosures, shared z^m/m! data or its deterministic recurrence, all30 moment enclosures or their exact finite-sum reconstruction, all30 output P centers/finite-arithmetic errors and the analytic tail in the correct units. Finite P arithmetic is<=2^-85 per jet and its analytic tail<2^-113, hence complete P error<2^-84. The exact a=1 branch yields all90 zero P jets across the three centers. At the exact center s=1, E=1 and phi_k(0)=1/(k+1); these are rational identities, not threshold tests. Nonreference P jets at s=1 must still include the log-power convolution and are generally nonzero. This producer Q32 path does not divide by s-1. Neither path may substitute individual totalized Hurwitz finite parts; the allowed independent P recurrence is specified separately below.

The half block, whole Bernoulli block, whole P block and addition each have norm allowance2^-84, giving each residue correction<=2^-82. Contract residues by the exact UNNORMALIZED character signs and charge its arithmetic separately, giving each nonprincipal correction<=2^-79. If a normalized group transform is used here, an additional exact factor4 is compulsory; the simpler fixed recipe is a direct signed sum. Record each complete correction center and error for all270 actual coefficients.

## 6. Coefficients, full disks and endpoint incidences

Each of the270 actual finite-L coefficient records contains its exact dyadic center, finite-arithmetic error ledger, head residual contribution and canonical norm radius2^-75. The finite arithmetic is<=2^-76 and `2^-76+2^17/32!<2^-75`. All source-input, circuit, contraction, P, complete correction and assembly terms appear in the ledger. The final coefficient radius already includes the main per-order residual and P tail. It encloses `L_fin,r^(h)(s_j)/h!`, not residue U jets or raw height derivatives.

Each model record references its30 centers and states exactly the following tube:

`for every complex z with norm z<=1/16, norm(LFunction(chi_r)(s_j+z)-sum(h<30) C_(r,j,h)*z^h) <=2^-68`.

It binds the actual level8 nonprincipal character, exact center and closed radius. Store the reviewed domain premises, finite-function outer bound, EM and Taylor bounds, and the strict rational error ledger. The full complex disk is not checked by a grid of sampled values. For an exact polynomial graph its evaluation error is zero. If a serialized evaluated polynomial center uses rounding, its additional norm error is<=2^-75 and is included. The sufficient ledger is `(3/2)*(E+Tay)+(16/15)*2^-75+2^-75<2^-68` when analytic errors are inserted as coordinate squares. If norm balls are propagated directly, record that choice and its valid smaller conversion. No extra residual or P tail is added here.

Each of18 endpoint records binds r,j,side by its position, exact endpoint coordinate, a serialized polynomial-evaluation center, a proved evaluation error<=2^-75 and the canonical actual-L radius2^-68. Exact rational evaluation of the stored polynomial at z=+/-i/16 supplies the check against the chosen center; any outward rounding is charged. The endpoint has the same model and actual character, not a new fitted model. This design retains shared endpoints twice as required, with12 distinct character/point pairs overall.

There is no final s-1 division. The principal row has no coefficient/model/endpoint section. A field claiming an actual principal L value, especially at1, is a semantic rejection even if its finite number looks harmless.

## 7. Independent payload and complete containment

The independent attempt fixes256-bit elementary arithmetic and a separate program which imports no producer evaluator. It binds the exact producer payload hash, approved producer code/schema, its own code/static review, all analytic pins and its own run record. It checks every mandatory record, not a sample. Its compact arrays use the same indices, so labels and shapes cannot drift.

Retain all61,440 independent actual-moment witness rectangles and all11,520 independent direct-tensor witness rectangles. An index-implied record is a full enclosure, not a PASS bit. A decoder recomputes each center-to-target distance from these rectangles and the producer centers. Require full containment in the immutable canonical epsilon balls, with an exact squared-distance or conservative L1 proof. Input uncertainty is included only in actual moments; the direct tensor calculation uses exact producer moment centers. The independent roots have their own enclosure basis. Empty/zero slots remain checked.

Independently construct all12 direct unbatched residue/center jet packets and all270 direct nonprincipal coefficient enclosures, including the entire P formula and all errors appropriate to the independently selected method. The accepted `endpoint-power-recurrence` method is explicitly permitted; the code preflight fixes that method rather than switching after a failed calculation. Write `L_a=log X_a`, `L_1=log297`. At s=1 it uses

`P_h(1)=((-L_a)^(h+1)-(-L_1)^(h+1))/(8*(h+1)!)`, for h=0,...,29,

so the last coefficient requires power30 and factorial30!, not a numerator truncated at degree29. At s=1+q, q=+/-i/8, independently enclose

`N_h=exp(-q*L_a)*(-L_a)^h/h! - exp(-q*L_1)*(-L_1)^h/h!`

and use `P_h=(N_h/8-P_(h-1))/q`, with P_-1=0. In exact coordinates this is `P_h=-i*N_h+8i*P_(h-1)` for q=+i/8, and `P_h=i*N_h-8i*P_(h-1)` for q=-i/8. Record q's exact tag and these signed coordinate operations; no uncertain numerical denominator or division at s=1 is used. The identities follow from the same entire P function. For a=1, retain all90 exact zero outputs.

The independent packet records its log/endpoint-exponential enclosures, all numerator and P jets or their lossless deterministic reconstruction, the center-one power sequence through30, and per-order arithmetic/error certificates. It must include the recurrence amplification `e_h<=epsilon_N,h+8e_(h-1)+eta_h`, whose thirty-order factor is `(8^30-1)/7`; a one-step tolerance is not a final bound. The accepted allocation uses elementary error2^-240 and complete named-gate rounding2^-224, with exact rational operations between those gates or a separately proved bound for the complete alternate gate. A256-bit setting alone does not prove either requirement. This route has **zero Q32 moment truncation tail**: its identities are exact, and all errors are elementary and arithmetic. The producer's Q32 tail is not imported into it or charged again. The accepted allocation/review are pinned in section1; their output accuracy still does not replace the actual saved-center containment check.

These independent calculations use no time bin or FFT to obtain actual coefficients. Store the complete resulting coefficient boxes and any additional norm error not already included in them. For every h, produce a rational D_h bounding the maximum distance of that full enclosure from the producer center, require D_h<=2^-75, and do not infer containment from overlap or center agreement. The internal P recurrence does not introduce any s-1 normalization into the full nonprincipal L reconstruction.

For each of9 disks, independently verify the analytic EM/Taylor domain/scalar premises and the uniform inequality

`sum(h<30)(1/16)^h*D_h + E_ind + Tay_ind + e_eval <2^-68`.

If an independent box uses coordinate-square analytic padding, charge its norm conversion explicitly in E_ind/Tay_ind. The polynomial graph may take e_eval=0. This is a proof of uniform tube containment using coefficient enclosures and analytic bounds, not numerical sampling of the disk.

For each of18 endpoints, evaluate the independent direct coefficient model at the exact singleton offset, add the independently justified finite-function Taylor and actual-L EM bounds, and retain an actual-L enclosure. Require that entire enclosure to lie in the producer's radius2^-68 ball. The endpoint target center remains the producer polynomial evaluation; replacing it with an easier independent center is not allowed. Shared endpoint images need not be equal.

Retain auxiliary consistency checks for exact shared coordinates, overlap at shared actual points, real-character conjugation of positive/negative-center coefficients and endpoints, and compatibility with real coefficients at s=1. For jets at conjugate centers no extra(-1)^h occurs: these are complex-s derivatives. Such consistency checks do not replace any actual-value containment, operation or tail proof. A failed check is reported explicitly rather than discarded because the main interval claims might still be true.

The independent payload may reference frozen producer constants instead of duplicating them, but must bind their exact payload hash and deterministic decoding. It must retain its own full witness arrays and direct coefficient/endpoint enclosures. Reconstructing an exact intermediate is permitted; an absent unreconstructible enclosure is not. Every required array has an independently checked count and complete index range.

## 8. Fixed execution, caps and completion seal

This document creates no executable or runtime record. Before any run, freeze both programs, their parser/schema, exact reconstruction recipe, source pins and static review. Author precision is192bits with one180-second launch-to-exit attempt. Independent precision is256bits with one300-second launch-to-exit attempt. Both include import/setup, every elementary/circuit/correction check, serialization, status publication and process exit. No automatic precision changes, node selection, omission, refinement, restart or second attempt is allowed by the same authorization.

Each attempt has512MiB lifetime peak working-set and64MiB aggregate retained-output limits. Worker subprocesses and delegated computation are forbidden. The supervisor must verify this restriction; only then does process-tree memory reduce to the single evaluator. The external supervisor is separate control machinery, not an evaluator allowed to hide work. Any later change involving child workers needs a new reviewed resource contract.

Mandatory supervision uses a retained handle for the exact launched process, records launch and exit, and enforces the full wall deadline externally. The current Windows research requires a fresh successful final `PeakWorkingSetSize` query using that retained handle after it is signaled exited, in addition to live checks. **Availability is not yet established by this schema.** A separate benign capability preflight must establish the supported lifetime-peak query and its binding to this process before numerical authorization. Missing/zero/inconsistent final telemetry, a closed/replaced handle, PID-reuse ambiguity or incomplete monitoring gives INCOMPLETE. Commit charge or a maximum of periodic resident-memory samples cannot silently replace the required OS lifetime peak. The supervisor's final implementation and capability report require their own reviewed pin.

The supervisor terminates on an enforced deadline and on detected resource breaches. Sampled monitoring is not a claim that transient excess was physically prevented. A complete result requires the authoritative lifetime peak below512MiB, no prohibited descendants, bounded retained bytes, normal exit0 and all numerical checks complete. The process deadline includes publication; cooperative internal timers alone are insufficient.

Use exclusive creation of the fresh attempt directory and attempt marker. Reserve space for final status/seal. The worker streams one pending payload and bounded logs, checks its own budgets during work, flushes and closes the payload, and emits `CANDIDATE_COMPLETE` only if all its assigned checks pass. A PASS-looking worker token or a pending file is not final acceptance. After exit the supervisor verifies actual bytes, hashes, completion, deadline, final peak and child policy, then writes a bounded **completion seal** with status `COMPLETE_EXTERNAL_PRODUCER` or `COMPLETE_EXTERNAL_INDEPENDENT`. Publish the payload by a no-overwrite rename, never copy-and-retain it twice. Bind the seal to the exact payload, code, authorization and telemetry record hashes. The combined model-validation status requires both independent seals and all specified containment checks.

If no final numerical status fits the remaining space, stop and write a bounded INCOMPLETE record from the reserved allowance. An external kill may leave a truncated pending payload; its complete prefix can remain as partial evidence but cannot be interpreted as complete. Partial data, logs and seals continue to count toward the aggregate cap. Report budget failures, malformed inputs, false identities, invalid analytic domains and containment failures as separate reason categories. Never relabel an incomplete run as successful because a subset of coefficients was computed.

Status vocabulary is deliberately narrow: `PREPARED` before execution, `RUNNING/PARTIAL`, `CANDIDATE_COMPLETE` inside a completed worker, supervisor `COMPLETE_EXTERNAL_*`, and `INCOMPLETE` or `REJECTED` with reason. No status says zero-free, GRH, winding, full family, formally proved, or Lean accepted. External interval results remain conditioned on the reviewed analytic identities and sound external elementary arithmetic.

## 9. Static review and later acceptance checklist

Before numerical authorization, review the concrete code against every index, exact character sign, fixed norm budget, removable-point branch and reconstruction rule above. Check JSON/token bounds before large allocation, lossless mid/radius semantics, full arrays, principal-output exclusion, the no-overwrite state machine, log/partial accounting, child policy and deadline/peak capability. The input and output manifests must not accept booleans as integers, unbounded exponent shifts, duplicate keys or inflated fixed radii. The full dataset is not considered present merely because a summary declares its size.

A future successful pilot must deliver all61,440 actual-moment and11,520 exact-center tensor containments, all270 complete normalized coefficient containments, all9 full-disk inequalities and all18 actual-L endpoint containments, plus circuit replay, complete corrections and required consistency checks. The direct calculation and circuit reconstruction have distinct roles. Unused principal transform rows remain finite artifacts, not absent records.

The compact format removes redundant labels, repeated constants and reconstructible stage dumps. It does not remove required mathematical evidence. No runtime or memory feasibility follows from its byte bound. If exact stage replay, elementary work or independent containment fails the fixed limits, preserve that failure; another algorithm or run would require a newly reviewed version. No formal implementation or new spectral conclusion follows from approval of this schema.
