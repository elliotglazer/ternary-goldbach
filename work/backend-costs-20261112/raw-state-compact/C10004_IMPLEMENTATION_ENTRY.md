# Implementation entry for the actual c10004 block

13 November 2026. Source inspection and specification only. No builds,
evaluations, generated values or changes to existing modules. Proposed names
and signatures below are interfaces to implement, not existing theorems.

The next substantial module should implement the actual retained integer
character transform, `C10004TransformScript.sml`. Reuse the already prepared
`c10004-map/C10004MapScript.sml`; do not write another map checker. In parallel
with later implementation, prepare the literal elementary/source producers
needed to supply its inputs. The present rotate-and-pair benchmark is not an
acceptable replacement for this transform.

The smallest complete target remains one conductor, two positive heights,
4800 inputs at each height and all 2301 primitive outputs at each height.
It needs no Bluestein implementation or global inventory. It does need real
source generation, rigorous radii and canonical completion. Omitting these
would measure an integer transform component, not the complete block.

## Fixed job and final contract

Use c=10004, height indices 1 and 2 on t=5j/64, and height-zero source
initialization. Retain D512/N220/m64/P27, endpoint P20, full delivered K20,
the saved b94 degree profile, exact grid100 assembly and p81 conversion.
Preserve the selected 8828 error/16384 width interface. This note does not
adopt p75 or narrower source bounds.

Use an integer pair type `ipair = int # int`. At the final boundary, round a
nonnegative rigorous radius upward onto the same grid as the real center.
An enclosure record `(m,e,g)` represents center m/2^g and radius e/2^g with
e>=0. Its proposed classifier is

```
status : int -> int -> num
status m e = if m < -e then 0 else if e < m then 2 else 1
```

Here 0 means proved negative, 1 means inconclusive, and 2 means proved
positive. Reject a negative radius before classification. The required
generic theorem is, for g>=0, e>=0 and real x,

```
abs(x - real_of_int m / 2^g) <= real_of_int e / 2^g
  ==> (status m e = 0 ==> x < 0) /\
      (status m e = 2 ==> 0 < x).
```

Pack 2301 statuses in each of two base-three integers with an explicit fixed
length. This is a new enclosure-status encoder; the existing
`raw_sign_code` has a different middle meaning, exact integer zero, and must
not be reused as if it proved an inconclusive enclosure statement.

The final proposed executable interface is

```
c10004_run : checked_seed_payload -> (num # num) option
```

`checked_seed_payload` is a proposed structured input to a checker, not a
trusted abstract type. It contains only externally supplied constants or
elementary witnesses that the chosen producers need. The executable rejects
invalid identities, grids, witness inequalities, shapes and runtime bounds.
If all sources are generated internally, this payload can be empty except
for fixed job parameters. It cannot contain unexplained input L-values,
Horner outputs, transform outputs or completed signs.

The closed final theorem must identify a concrete HOL definition
`hardy10004 k j : real` for the canonical completed character value, and state
for both j=1,2 and every k<2301 that decoding the returned digit implies its
corresponding strict sign. The definition of `hardy10004` must be joined to
the actual L-function, character and completion conventions. An arbitrary
function parameter with assumed enclosures is only an intermediate lemma.

Every channel's full center and rigorous radius is computed internally before
classification. No numerical center-radius records need be exported in this
successor contract. This explicitly differs from the old plan's full record
export. A predeclared strict-sign success condition is still required; all
inconclusive output is not a successful sign benchmark. Repairs, later
interpolation, sign-change brackets and Turing/zero-count closure remain
separate, with checkpoint or recomputation costs.

## Existing code to reuse, with its actual limits

| Source and named interface | Usable content | What it does not supply |
|---|---|---|
| `hol4-setup/BlockRoundScript.sml:8–23`, `round_scaled`, `round_scaled_residual` | Actual signed nearest division `(2*r+s)/(2*s)` and `-s <= 2*(r-q*s) < s` for s>0, including ties. | Source accuracy or a complex analytic interpretation. |
| Same file, `rounded_butterfly`, `rounded_butterfly_residual`, `round_scaled_pre_ok` | Exact three-product butterfly program, local residual and CV precondition support. | An FFT, character map, root certificate or global radius. |
| `hol4-setup/StageCheckScript.sml`, `three_real`, `three_imag` | Exact three-real-product identities. | Permission to change rounding locations or summation order. |
| `raw-state-handoff/RawStateHandoffScript.sml`, `raw_mul`, `raw_trace`, `raw_produce`, `raw_head` | Built integer state/head operations and structural proofs from the successful handoff experiment. | General grid140 source, actual logarithms/initializers, or c10004 full pipeline. `raw_pipeline` is hard-coded to c61 and the eight-row fixture. |
| `raw-state-compact/RawCompactSignsScript.sml`, `raw_sign_mask_rel_iff`, `raw_compact_correct` | Built exact integer summary relation and a demonstrated compact evaluation path. | Radius-aware signs of a real function. |
| `hol-platt/raw-analytic/RawPairRoundScript.sml`, `pair_value`, `four_product_round_error` | Prepared integer-to-complex denotation and rounding proof using HOL `complex` and `modu`. | Read source is marked prepared, not a build acceptance receipt; its successful build must be established separately. |
| `hol-platt/c10004-map/C10004MapScript.sml` | Prepared fixed map, independent exhaustive unit specification, inverse checks and output-label checks. | Read review permits a first build, not accepted computed results. Character primitivity and Fourier semantics are still missing. |
| `raw-state-handoff/HandoffRuntime.sml:50–75` | Actual `cv_rep_for`, `from_to_thm_for`, `cv_eqs_for`, `cv_compute`, `cv_rep_eval`, hypothesis-only discharge and exact equation audit. | Free transport between separately decoded arrays, or an analytic proof from integer equality. |

`DependentBlock.block_run` rotates pairs between layers. Its local soundness
is useful regression evidence, but its program is not any of the selected
c10004 DFT nodes. Do not substitute it in the new entry module.

The pinned HOL analysis sources provide `complex_exp`, `COMPLEX_EXP_ADD`,
`COMPLEX_EXP_N`, `COMPLEX_EXP_NZ`, `MODU_MUL`, `MODU_CONJ`, `RE_IM_LE_MODU`,
and the real logarithm laws `LN_MUL`, `LN_DIV`, `LN_POW`. `complex_exp` is
marked `nocompute`, so this is mathematical support rather than an executable
certified exponential. The prior bounded source audit located no ready
Dirichlet-L/EM/Gamma/functional-equation provider for this job. Do not infer
one from similarly named HOL Light results. Generic HOL analysis dependency
construction is itself separately measured library work.

## Reuse the map, with two explicit adapters

The existing fixed choices are local41 b=6^b mod41 and local61 c=2^c mod61,
with CRT coefficients 2501,4880,2624. Its executable `finite_checks` requires
the full local power lists and exact independent unit list to match, rather
than assuming these bases generate. Root must first obtain a successful
closed `finite_map_checked` and the exported map theorems.

Existing map order is
`i=2400*j4+60*j41+j61`. The live-data schedule instead proposed tensor order
`t=2*(40*j61+j41)+j4`. They are not the same array. Define

```
map_to_tensor i = 2*(40*(i MOD 60)+(i DIV 60) MOD 40)+i DIV 2400
tensor_to_map t = 2400*(t MOD 2)+60*((t DIV 2) MOD 40)+t DIV 80
```

Prove both maps preserve the range below4800 and are mutual inverses there.
The scatter theorem must say that tensor slot `map_to_tensor i` contains the
input belonging to `C10004Map.residue i`. Alternatively retain the map order
and implement strided first-axis access; do not silently relabel it.

Define the exact fine cell of residue a by
`(2048*a+10003) DIV 20008`. For each mapped unit prove range0..1024 and
`(2k-1)*10004 < 2048*a <= (2k+1)*10004`, interpreted over integers. This
implies `abs(512*a/10004-k/2)<=1/4`. Prove the bucketed map is a permutation
of the original4800 records with exact prefix offsets and no dropped writes.
These finite adapters are small dependencies, not another map replacement.

Separate mathematical work defines characters on those units, extends them
by zero on nonunits, proves multiplicativity, identifies primitivity with
the retained labels, and joins positive Fourier phases to character values.
`labels_checked` alone proves none of those facts.

## Concrete next module: the retained transform

Prepare `C10004TransformScript.sml` in a fresh directory after map acceptance.
Use the existing signed rounding program, and pin one arithmetic ordering.
An explicit proposed API is:

```
root_at : root_packet -> num -> num -> ipair option
cmul81  : ipair -> ipair -> ipair
direct81 : num -> root_packet -> ipair list -> ipair list option
ct81 : num -> bool -> root_packet -> ipair list -> ipair list option
tensor81 : root_packet -> ipair list -> ipair list option
```

`root_at roots n k` retrieves the stored grid81 center for exp(2*pi*i*k/n).
Its finite shape and index checks are executable; its error<=2^-81 theorem
requires the separate root producer. `cmul81` takes exact three real products
and rounds only the two final coordinates using divisor2^81. Special identity,
negation and quarter-turn roots use their exact coordinate actions. Their
identities must be proved, not detected from approximate centers.

`ct81 n omit0` is defined only for the finite closure
2,3,5,10,15,20,30,40,60, with splits (2,5),(3,5),(2,10),(2,15),(2,20),(2,30).
For n=r*m it gathers `x[a+r*b]`, runs each length-m child, multiplies by the
cross root exp(2*pi*i*a*v/n), and runs length-r children. It writes at
`k=v+m*u`. For omit0 it omits only k0, requesting the pruned r child only at
v0. Full direct3/direct5 rows sum in the fixed original input order. Keep
additions exact on the common grid where the selected circuit does so. The
pruned2 output is the original subtraction, not a newly rounded expression.

`tensor81` requires exactly4800 entries in the declared tensor order, applies
axis2 on2400 lines, axis40 on60 lines and axis60 on39 lines, and returns
exactly2301 entries ordered `(k41-1)*59+(k61-1)`. No length4800 single DFT,
missing inverse channel, or principal-only shortcut is admissible.

The non-Bluestein DFT formulas here are unnormalized. Metadata fields called
`normfactor` do not authorize inserting numerical divisions. Before accepting
a matched p81 implementation, review its exact additions, root actions,
rounding order and scale against the retained reference circuit. If any
ordering differs, prove a fresh bound or label it an algorithm successor;
agreement of dimensions is insufficient.

Required theorem targets, in order:

1. Totality under exact finite root-table and input-shape predicates;
   `tensor81 roots xs=SOME ys ==> LENGTH xs=4800 /\ LENGTH ys=2301`.
2. Exact refinement of its lists/indices to the declared rounded CT reference.
   The pruned result is the selected subset of that same rounded full
   reference, including all predecessor operations and root objects.
3. An exact-arithmetic version equals the positive DFT tensor. Combining the
   map adapter yields, for k=`(1,k41,k61)`, the sum over all4800 actual units
   weighted by the corresponding character. This proof must expose any
   inverse-character convention rather than absorbing it into a label name.
4. Under proved root error, stored-input bound and retained safety conditions,
   the rounded tensor encloses that exact sum with the selected intrinsic
   radius. Propagate actual input errors separately. No assumed final-output
   radius may replace this theorem.
5. Register the executable functions with ordinary `cv_trans`/`cv_auto_trans`,
   prove their real preconditions, and audit the closed returned equation and
   ordinary theorem dependencies. A native implementation must match the same
   signed divisions, root objects, operation order and output indexing.

Targets1–2 and a native/HOL integer comparison can proceed before the analysis
library is finished. Targets3–4 and the source/completion joins are essential
before the result is called a character-value or sign proof.

## Dependency order to the complete measured block

| Stage | Executable deliverable | Semantic work required for complete acceptance |
|---|---|---|
| 0 | Existing map build, plus permutation/fine-cell adapters | Complete unit/label indexing; later character interpretation remains separate. |
| 1 | `C10004Transform` above, initially tested on bounded explicit input/root packets | CT exact identity, retained rounded-reference refinement and radius theorem. No source-value claim at this stage. |
| 2 | Actual log, integer inverse-root and cis programs; initialize and update both source pools internally | Positive-base exp/log identity and finite integer-program errors. Port the actual Lean programs as specifications, not imported Lean proofs. Rational EM arguments require the higher-precision source contract; raw120 code alone is insufficient. |
| 3 | N220/m64 scaled EM, P27 shifts, P20 Horner, raw heads, exact assembly and p81 input conversion, streamed into stage1 | Finite Hurwitz identity, EM remainder, finite translation/tail and Horner errors; raw power source join; nonprincipal L identity. Preserve source arguments and the full4800 domain. |
| 4 | Root-number and Gamma/completion producers, all2301 center-radius computations and status tests at each height | Actual phase/parity/functional-equation reality theorem and rigorous completion error. No replacing these by positive real parts of uncompleted L sums. |
| 5 | One fused `c10004_run`, compact export, exact equation/ancestry audit and adversarial controls | Close every stage assumption from the actual computed sources, prove final function-sign implication and satisfy the strict-sign success policy. |

For stage2, the existing Lean `RawStepProducer` computes the actual grid122
step using `log129Center`, `expIntegerHorner` with72 updates and final nearest
division by512. `RawStateProducer` initializes through
`inverseRootCandidate`, embeds grid98 to120, and updates with the actual
rounded product. These supply precise raw-program specifications. The EM
pool instead needs its own log144/source-state140/step142 contract and rational
arguments `1+k/512`. It is not licensed to call the raw source program and
pretend its smaller error. A generalized elementary producer must expose its
precision and tail parameters and receive its own source proof.

Stage3 must retain the exact endpoint terms and all64 Bernoulli corrections,
even when only two low heights are requested. It needs checked exact
Bernoulli/pi constants or checked generators, not a list accepted by digest.
The full first-band113153 rational source pool, raw integer1..10004 pool and
streamed live-data schedule remain the proposed architecture. Alternative
source formulas can be explored later but are not a matched implementation.

Stage4 is the largest unresolved semantic prerequisite. The currently located
HOL APIs support complex algebra, real log and integration, not the complete
L/Gamma/functional-equation theory. Its numerical generator and certified
tail/range choices are also not yet fixed. Record this as blocking complete
producer-to-Hardy-sign acceptance, even if stages0–3 run successfully.

## What can be timed before all analysis proofs exist

A native/HOL same-algorithm prototype may run stages0–3 and a fully specified
stage4 numerical program once its formulas and constants are fixed. HOL can
prove equality to the literal integer program with no trusted external
evaluation. If only input/root packets are supplied, time and report that
component honestly, including their construction/translation separately.
Arbitrary easy or zero inputs are regression tests, not evidence about the
actual c10004 numerical workload.

Before complete analytic closure, such a run establishes integer arithmetic,
representation lifetimes, code translation and matched outputs. It does not
certify that the centers enclose L-values or that the reported digits prove
Hardy signs. A computed rational budget can be tested, but the premise that
it bounds the actual function still needs the missing theorems. Conditional
lemmas may help organize those obligations; they do not discharge them.

For a meaningful complete cost measurement, both versions must generate the
same actual sources and constants and perform the same final tests. Include
initialization, both updates, every4800-input stage, every2301 completion,
all radius arithmetic, output binding and theorem construction. Record cold
generic-library construction, one complete checked run, and optional replay
separately. Native timing measures only its matched numerical implementation;
HOL's analytic library construction is an additional cost, not an unexplained
runtime multiplier.

The first implementation commitment is therefore narrow: finish and audit
the prepared finite map, then implement the actual retained transform with
its explicit rounded reference and map permutation. Source producers can be
connected incrementally to that real consumer. There is no reason to repeat
the rotate-and-pair or c61 fixture as a supposed c10004 completion test.

## Inspected source bindings

Paths are repository-relative. The exact hashes below bind the static source
read, not a new build or successful evaluation.

| Source | SHA256 |
|---|---|
| `work/backend-costs-20261112/raw-state-compact/C10004_LIVE_DATA_SCHEDULE.md` | `56019E9D091270F46C3C4DCBE17390C2CBFD336135C94675A7F61FCC222F850F` |
| `work/backend-costs-20261112/hol-platt/ANALYTIC_BLOCK_PLAN.md` | `55E63C1849DC9D9007DD8085D0FD4EEE2CD98CEBDA57E14554A5DB23A9F3AD1C` |
| `work/backend-costs-20261112/forecast-audit-20261113/C10004_PARAMETER_PACKET.md` | `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF` |
| `work/backend-costs-20261112/hol-platt/c10004-map/C10004MapScript.sml` | `0773AC5249A66AF85814F7694063D53759AEF19C41D6172BE06DA906FD60AC6E` |
| `work/backend-costs-20261112/hol-platt/c10004-map/REVIEW.md` | `6580D991FE4720FA4AAED1C59FABF63CA04E93C967663013FE8CBED61E3877C8` |
| `work/backend-costs-20261112/hol4-setup/BlockRoundScript.sml` | `FF267EC688BDC4A4065DE0BD14D3BC109F60F2A0D86F99FAE89646D4212EF143` |
| `work/backend-costs-20261112/hol4-setup/StageCheckScript.sml` | `019B156330F9E3623529F46705F7B5C4682C8E74456E293598F620EEE34AF26C` |
| `work/backend-costs-20261112/hol4-setup/DependentBlockScript.sml` | `1A57F4025ED1A7B9C5A823D5F6B73B2A7BE02B109F21AD13D24214EA52D9D665` |
| `work/backend-costs-20261112/hol-platt/raw-analytic/RawPairRoundScript.sml` | `FE67132187C0E3C07FD256BB3B475A41333BAB49C70B7E49CB5B2CFCA946F0D1` |
| `work/backend-costs-20261112/raw-state-handoff/RawStateHandoffScript.sml` | `774B0143E497705D2575062083B3952B88C9E06C1C9571ED3D53A7BAC114EE9C` |
| `work/backend-costs-20261112/raw-state-handoff/HandoffRuntime.sml` | `CB1CC15B68CF987AFA38182BCC7EAFC41E95ADA96565CC611239D23A30B7C1F0` |
| `work/backend-costs-20261112/raw-state-compact/RawCompactSignsScript.sml` | `1B26201077B2FEDB21712482F73531D02C40DAACEE2983820D97393D2577140D` |
| `work/lean-pilots/raw-head/RawStepProducer.lean` | `A30763650701C171C20B3EB6908F0918A95F1A64A2F0BEBB557D0D42070F53AE` |
| `work/lean-pilots/raw-head/RawStateProducer.lean` | `E5335116BA0B90DD92D500FCD0EFA5A89586D08C334D64C0F9EC01AB12D9B961` |
| `work/qrh-campaign/agents/zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md` | `CB4085D00AED0BFDA9ADC1BB7306DB24EF052502C99F30D45E15AEF6EEC3F8B8` |
