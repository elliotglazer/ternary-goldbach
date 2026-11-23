# Production obligations under the selected high-conductor profile

2026-11-11. Research and exact conductor metadata only. The selected profile reduces the full-family primitive-character height proxy by about **15.392037%**, not by half. Every character remains required. The principal height and its retained head are unchanged. Existing paper algorithms can target the smaller rectangles, but the complete source-bound spectral packets and their formal acceptance are still missing.

This report adds a full-family comparison and an explicit auxiliary-height guard to the existing production plans. It does not propose another spectral profile, evaluate any L-function, theta function, zeta function or prime sum, predict runtime, or report new spectral coverage. No Lean command, canonical source edit or frozen-file change was made.

## 1. Exact target and what is reduced

The authoritative profile is `work/qrh-blueprint/SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md`, SHA256 `D0F77CCCFCE45DBFE5C863643236107ECBBE4D363103A70BB06CE57213A42CB7`. Its independent joint review is `audit/REVIEW_SELECTED_HIGH_CONDUCTOR_PROFILE_2026-11-11.md`, SHA `AB1856F8CE555F4494F8EC18D2EA872FC2AE7FB26EF2528BD9C5BFC0E5D8109D`. Unless stated otherwise, agent paths below are relative to `work/qrh-campaign/agents/`.

For odd c<=150000 and c divisible by four with c<=300000, put qtilde=2c in the odd case and qtilde=c otherwise. The old height is

    Hold(c)=min(ceil(200+max(1000,844800000/(7*qtilde))),100000000/c).

The selected pair (b,H) is:

| Conductors | Upper real part b | Inclusive height H |
|---|---:|---:|
| c<=100000 | 111/200 | Hold(c) |
| odd c>100000 | 14/25 | 50000000/c |
| four divides c, c>100000 | 14/25 | 99000000/c |

In both changed groups Hold=100000000/c. Thus the odd heights halve and the even heights drop by one percent. The lower real-part bound follows by the existing exact inverse-character/reflection argument, with unchanged absolute ordinate and analytic order. Nothing permits using the finite strip above H(c).

The ordinary right-rectangle width changes from 289/200 to 288/200 on the changed conductors, a factor 288/289. This geometric width reduction is small. The extra separation from the critical line might improve actual enclosure margins, but neither the profile nor this metadata computation proves such a margin. A real zero at height zero and a zero at exact H(c) remain in scope.

All 150000 conductor indices and all 5543640188 primitive-character labels remain. The c=1 row has H=60343058 and is unchanged, as are the RH1500/count/reciprocal-moment inputs used by the selected damped-psi proof. The older additional principal narrow strip through one million is not an obligation of this profile.

## 2. Full-family height comparison

Let a(c) be the number of primitive characters of conductor c, including a(1)=1, and let

    V_old=sum_c a(c)*Hold(c),       V_new=sum_c a(c)*H(c).

These are positive-height geometry proxies. They are not zero counts, panel counts, arithmetic-operation counts or runtimes. Doubling both for two ordinate signs would not change their ratio. Production can exploit character and inverse-character sharing without materializing this sum as separate samples.

The new script `prime-estimates/selected_profile_geometry_20261111.py` uses divisor inversion twice. It derives phi(n) from n=sum_(d|n)phi(d), and then a(n) from phi(n)=sum_(d|n)a(d). This is independent of the coordinator's prime-power multiplicative construction. It forms each exact rational height, multiplies by a(c), and accumulates directed floor/ceiling bounds at denominator D=100000000. Thus every displayed interval is rigorously enclosing, without floating arithmetic. The proof of the primitive-character count formula and its correspondence to actual source labels still belongs to the reviewed manifest; a numerical count alone does not supply that bijection.

Every pair in the last two columns is an integer numerator interval with common denominator D.

| Group | Conductor indices | Primitive labels | D*old height sum | D*new height sum |
|---|---:|---:|---|---|
| c<=100000, including c=1 | 75000 | 1847865075 | [292534155285082928995,292534155285082962260] | same |
| high odd | 25000 | 2053236314 | [164258977375339990502,164258977375340015502] | [82129488687669988951,82129488687670013951] |
| high four-divisible | 50000 | 1642538799 | [82126808517142475718,82126808517142525705] | [81305540431971050971,81305540431971100858] |
| total | 150000 | 5543640188 | [538919941177565395215,538919941177565503467] | [455969184404723968917,455969184404724077069] |

Dividing the new lower numerator by the old upper, and the new upper by the old lower, gives in particular

    .846079629950 < V_new/V_old < .846079629951.

Therefore

    .153920370049 < 1-V_new/V_old < .153920370050.

The previously reported approximately .66333 ratio concerned the changed high-conductor part only. It is not the full-family ratio. The unchanged part alone is larger than half the old total, so this selected change cannot halve the full proxy even if every changed height were hypothetically reduced to zero.

The script also records a second, deliberately different count. The uniform finite-U allocation has N=ceil(T)+36, and its literal shared residue head has N*phi(c) bases. At one top-height center per nonprincipal conductor, define

    B(H)=sum_(active c>1) phi(c)*(ceil(H(c))+36).

Then B(Hold)=8500555507588 and B(H)=7467072337142. Their unchanged-low contribution is 4207318250546; the changed odd contributions are 2118896901242 and 1105675496084; the changed even contributions are 2174340355800 and 2154078590512. This is the size of that particular literal one-center formula, with character sharing already present. It is neither a lower bound for all possible algorithms nor a count for a full scan. It omits logs, jet orders, moment orders, transforms, corrections, interval precision, panel subdivision and reuse between heights.

The exact source for this count is `major-constants/FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md`: line 9 states c*T<=100000000, line 20 gives N, and line 70 identifies the Nv head terms with v=phi(c). The actual tensor composition at `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md`:64,130 describes these Nv bases and the additional NvKp moment contributions. This count does not use a nonexistent black-box fast full-L evaluator.

The metadata run exited 0. The first attempt through the Windows `python` app alias did not start a program; the successful invocation used the existing CPython binary with `-I -S`. No evaluator was imported. Script SHA256 `F75847A1C0AE51455B277232810A5A6B8614DCD774658801D40AC23BA2F5A3BB`; receipt `selected_profile_geometry_20261111.json`, SHA `7311301D07977142BD4FC953D8F352C44929DD8E2E8F8B04964D3CDCC44E0388`.

## 3. A concrete parameter interface that still needs care

The cap c*T<=100000000 is a hypothesis of the **uniform finite-U evaluator allocation**, not of the desired spectral theorem, Turing's theorem or all available evaluators. The allocation chooses M=16, N=ceil(T)+36, K=30, outer radius 1 and target radius 1/16. It includes the full disk down to real part 197/400. With the accepted correction, a retained outer rising-factor term is at most T+33, while T+33<N remains strict. Moving the center real part from .555 to .56 stays within this allocation but does not automatically reduce its fixed M, K or precision.

For a Turing count, distinguish the required height H(c), the main count height T>=H(c), and the auxiliary end U=T+h. The same finite-U allocation may be applied to the auxiliary center heights only if c*(T+h)<=100000000. At T=H(c), the available h is:

    high odd:  h<=50000000/c;
    high even: h<=1000000/c.

At c=300000 the even headroom is only 10/3. Choosing the sometimes convenient T=floor(H)+1 makes T=331 and leaves only 7/3. The odd uniform headroom is at least 1000/3 because c<=150000. At unchanged conductors where c*H=100000000, the same specialization has no positive auxiliary headroom at all.

These observations do not obstruct Turing verification in general. The accepted arbitrary-auxiliary Fourier parameters and general precision extension are available for larger U. They do show why the selected short height must not be substituted for U inside a budget or cost calculation. For example, any fixed h>=10 lies above the old required height 100000000/c when added to the new even height at every c>100000. This compares required heights, not the costs of two full algorithms using equal auxiliary protocols.

The actual Turing acceptance remains D+2b_T/h<1, where D=(Abar-W)/h-K_main is determined by certified Gamma-phase integration, main counts and auxiliary intervals, and b_T bounds 42+6.93*log(c*(T+h)/(2*pi)). Selecting h does not supply D. Neither a small geometric H nor the new .56 bound implies successful critical-line sign saturation. Ordinary sign saturation proves the stronger finite RH/simple-root result; complex-cluster or direct-strip certificates avoid that unrequested strength.

There is currently **no selected full-family production implementation** to which this report attributes the finite-U cap. It constrains the reviewed EM parameter specialization, including the planned c8 application. The current checkpoint reports the bounded principal small-batch experiment, static rational-j7 preparation and local slab/point evidence. It does not report a completed high-conductor family run. General-height Fourier plans are paper alternatives, not measured implementations. The old principal narrow-strip long-rectangle job is not a remaining selected production job.

## 4. What batching and geometry already remove, and what they do not

Existing plans already provide the substantive sharing mechanisms. A common centered Hurwitz/finite-U table feeds a tensor transform over the actual CRT unit group. Time and character transforms commute for the finite main sum, so either schedule can share work. The source-level identity uses the positive normalized transform, the correct time label -j, and scale phi(c)*L. No cyclic length-phi(c) shortcut can replace a noncyclic group.

This transform covers the main sum only. The half endpoint, all scaled Bernoulli terms and the entire pole difference P_a(s) remain required for every residue and height before character combination. The composition's lines 110-142 explicitly retain these correction and arithmetic costs. In particular integer-base absorption leaves the EM ratio controlled by |s|/(N+a/c); it does not create a gain of c in that ratio. The s=1 continuation and actual character label are part of the output's mathematical meaning.

Closed-slab assembly and an optional single outer contour are already accepted paper designs. They are not new reductions in this report. A direct outer contour can avoid all internal crossbars, provided its actual whole boundary and shared-vertex winding are certified. Independent local slabs instead require a complete closed cover. A positive-height packet for chi supplies negative heights for chi inverse, not for an arbitrary same-name nonreal row. Real-axis and top-height faces are retained. The boundary-divisor adapter can allow exact zeros on beta=b, but demands actual vanishing/order identities; a box containing zero cannot substitute for one.

Thus the precise missing interface is a complete, source-bound finite collection that chooses one of these acceptance modes and passes its data-dependent tests. For the direct route it must contain all actual-function panel enclosures, shared image vertices, strict half-plane margins and zero winding for a closed cover of each requested rectangle. For the count route it must contain complete main counts and sufficient auxiliary weighted data, with correct central and inverse-channel conventions, to satisfy the integer-saturation inequality. Arithmetic accuracy parameters do not prove either set of margins. All such packets still require a sound standard-axioms Lean acceptance proof and source continuation/order/manifest adapters.

The changed profile saves some requested height and weakens the forbidden real region. It does not remove a label, a residue-class transform axis, the correction terms, true multiplicity bookkeeping, closed-boundary coverage, or the global-provider/formal-consumer work. Current evidence does not identify which of precision, enclosure margins, finite transforms, correction generation, output size or kernel replay would dominate an implemented production run. Converting these distinct metadata counts to a time estimate would not be justified.

## 5. Source and review pins

The target source is `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`, with the target Mathlib pin `56a005855ea17e0b0958f73ec801ae140b0a1679`. The reused source interfaces are actual `DirichletCharacter.LFunction`/`differentiable_LFunction` and the primitive functional equation in `NumberTheory/LSeries/DirichletContinuation.lean`; the repository's `Explicit/RectResidue.lean:391` supplies the whole-rectangle logarithmic derivative count, with `NoZerosOnSides` at line 360. The reviewed coverage plans spell out transport from those local carriers to true analytic orders. This report does not revalidate their Lean elaboration or transitive axioms.

| Reused artifact | SHA256 |
|---|---|
| `zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF` |
| `major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md` | `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58` |
| `zero-sum/FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md` | `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4` |
| `zero-sum/FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `17D6A2E7478E3C03D8B9406C01A5AD93D4277E33B09009B6550D02357DE54BEC` |
| `mellin/REVIEW_FINITE_EM_CHARACTER_HEIGHT_COMPOSITION_2026-11-11.md` | `9E6004112BFBD8F565FBD2A6871B2E9C123751B5F35C9DEEFE631F7997EAAD64` |
| `major-constants/FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `9D2AEE85DB76673ACE63D17057B1B2B3BEAEC925F9A38A9980171696FF4EC233` |
| `mellin/REVIEW_FINITE_U_UNIFORM_SCALAR_BUDGET_2026-11-11.md` | `2D8AA8B58F64AC7DCF82887F6EECAF973F06EC0DD12EC68592F9DD243314C7CF` |
| `major-constants/FAMILY_STRIP_SLAB_ASSEMBLY_2026-11-11.md` | `5064865E9CE249A896B6B083278938E0E77762B88DE4539E038E624AC011FF93` |
| `zero-sum/SHARED_STRIP_COVERAGE_ASSEMBLY_2026-11-11.md` | `077F494EC96844D3422631DE26377D6DB152A1EF7058E274D567D9820E3DF6ED` |
| `moebius/REVIEW_SHARED_STRIP_COVERAGE_ASSEMBLY_2026-11-11.md` | `E4E8451DCC8D9236E642F83BC30ED20FC2667790BA6E2238106B4764F16C81DA` |
| `integration/TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md` | `36AFA1DF2A38D56A0677816038B08821B6CD5919118CEADB7616717047209943` |
| `mellin/REVIEW_TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md` | `D0BDFD871D73E77EE0386D6E94136136E77364B6512802E08E626E8ABFB1D5C8` |
| Root `work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47` |
| `zero-sum/REVIEW_AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `5EB56E2F86C5CE05CCA3491C237FE66F4C0053F656AD1401211A47406833DA21` |

The current checkpoint snapshot read for this task is `work/qrh-blueprint/RESEARCH_CHECKPOINT_2026-11-11.md`, SHA `D58AA410234EA48384F934CDDCE5200227638411676AC4E476F1D2DFC9F6CD25`. Its current leading selected-profile status supersedes older frozen profile prose. In particular later accepted Turing proofs supersede the earliest completeness plan's then-open paper Turing leaf. The final Goldbach threshold 10^27 and original BinaryGoldbachInput are unchanged.
