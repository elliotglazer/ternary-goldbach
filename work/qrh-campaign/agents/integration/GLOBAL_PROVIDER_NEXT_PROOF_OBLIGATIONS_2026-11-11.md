# Global seven-eighths provider: next proof obligations

2026-11-11. Source and paper research only. No Lean/Lake command, evaluator, build, dependency change, declaration, broad trust rescan, or frozen-file edit was performed. The compatibility, patch-semantic and static-trust reports and their independent reviews were read before this investigation.

The main unresolved provider obligation is still validation of the genuine proof against the target environment. No reviewed source discrepancy currently calls for a new analytic hypothesis or a new global zero-free theorem. That is not a finding that the thousands of candidate proof bodies are correct. Their successful elaboration and permitted transitive axiom closure remain unestablished.

This note adds two narrower results. First, the actual-zero interface needs only the Dirichlet export: its modulus-one specialization supplies every principal global bound used here, without consuming the separate zeta export at its assigned pole value. Second, primitive induction preserves zeros and analytic orders on the open critical strip by an explicitly nonvanishing Euler product. This resolves the ambient-modulus versus conductor interface, without making a claim about zeros on Re(s)=0.

## 1. What the damped psi replacement changes

The new damped proof and its independent review give the common real psi envelope from the RH head through 1500, its positive count 1069 and reciprocal datum Q1500<1.668, the shared finite [.445,.555] strip through H=60343058, and global seven-eighths nonvanishing. The extra narrow principal strip through one million and W35<24 are no longer needed for this consumer. The finite prime interval [1e9,5e9], head certificate formalization and shared finite certificate remain separate obligations.

This change does not shorten the established global-provider proof closure or weaken its required exponent. In particular, it gives no reason to substitute the smaller 23/24 proof or the 24 prerequisite build receipts for a checked seven-eighths theorem. It also gives no finite [.445,.555] certificate from the global [1/8,7/8] strip.

The intended large theorem remains TernaryGoldbachFrom(10^27) with no mathematical premise. The full Statement retains only its original inclusive BinaryGoldbachInput through 4e18. Every spectral statement in this research dependency map is an obligation to prove, not an allowed new final assumption.

## 2. Authoritative sources and present validation boundary

The repository heads were reread: OAI `4eaee87548250b2682affda7d05d947c05554bae`; Goldbach `23b2d68ca344203d4384e0aff7affa4ec034bef9`. OAI requests Lean 4.34.1 and Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`; the target uses Lean 4.35.0 and Mathlib `56a005855ea17e0b0958f73ec801ae140b0a1679`. Preserve `autoImplicit=false` and the recorded package options.

The established selected closure remains 2924 OAI modules plus 19 prepared external modules. The reviewed prepared source inventory resolves 8742 total sources including the target baseline. These are source-import inventories, not theorem dependency proofs or successful build receipts. This task did not repeat them.

The patch provenance question is resolved: the stored PNT and Rellich patches equal the blobs under `lean/patches/` in the pinned OAI Git tree. Their absence in an earlier sparse working-tree listing was not evidence of absent provenance. The independent semantic audit checks the retained QRH-facing definitions and hypotheses in all 19 selected modules. It expressly does not establish whole-library API equivalence: removed declarations, public visibility, constructor names and instance registration changed. The selected reconstructed bytes, rather than merely the pristine repository heads, must be the compiled inputs.

At `OAI/NumberTheory/DirichletL/Nonvanishing.lean:19` the required theorem is exactly

    {q : Nat} [NeZero q] (chi : DirichletCharacter Complex q) {s : Complex}
    (7/8 < s.re) -> not (chi = 1 and s = 1)
      -> _root_.DirichletCharacter.LFunction chi s != 0.

There is no primitivity, height, detector, finite-zero, moment or QRH binder. `Detector/FinalAssemblyUnconditional.lean:15,37` supplies its detector-band term and passes it to the conditional assembly. This is an actual candidate proof architecture, not a discharged kernel-validation gate. The comparison must use the continued `LFunction`, not the naive `LSeries` outside its convergence range.

## 3. New minimal principal interface: one export suffices

Fix a successfully validated Dirichlet theorem of the exact type above. This is a temporary mathematical premise for describing composition, never a final-root premise.

For any s with 7/8<Re(s) and s!=1, specialize to q=1 and chi=1. `NeZero 1` is available and the pole exclusion follows from s!=1. Target Mathlib `DirichletContinuation.lean:66` states the function equality

    LFunction (chi : DirichletCharacter Complex 1) = riemannZeta.

It therefore gives zeta(s)!=0 on precisely the region needed for nontrivial zeros. No assertion about analyticity or a residue at s=1 follows or is needed.

For an arbitrary xiF zero rho, target `Xi.lean:42,51` excludes Re(rho)>=1 and Re(rho)<=0. Thus 0<Re(rho)<1, and `xiF_eq_zero_iff:56` identifies an actual zeta zero. The modulus-one argument excludes Re(rho)>7/8. `xiF_one_sub:24` makes 1-rho another xiF zero; applying the same argument there gives Re(rho)>=1/8. Hence every xiF zero belongs to the closed strip [1/8,7/8]. Equality at either boundary is permitted. No height cutoff, root simplicity, conjugation identity or multiplicity transport is needed for this location proof.

The endpoints are handled by the actual entire function, not a pole convention: `xiF_zero:39` and `xiF_one:37` give value 1. For the Gaussian explicit-formula carrier, `ZetaZeroSums.zerosRectD_zetaF_strip:39` already supplies the zeta zero, open-strip location and xiF zero, so the same conclusion applies directly to every member. Its weights remain the source analytic-divisor weights; proving a location bound does not alter them.

This gives a smaller *consumed theorem boundary*, not a demonstrated smaller module closure. Importing the current public module still elaborates its other declaration and imports. If the separate `OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re` is claimed as validated, it still needs its own expanded-type and axiom check. A later integration can instead consume the modulus-one corollary only; that removes any mathematical dependence on the stronger pointwise statement at 1, without editing the provider now.

## 4. New conductor adapter on the open strip

Let q>0, chi be any character modulo q, c=conductor(chi), and chi0=primitiveCharacter(chi). Mathlib `DirichletCharacter/Basic.lean:250,254,309,313` supplies c|q, c!=0, `changeLevel chi0=chi`, and primitivity of chi0. For s!=1, `DirichletContinuation.LFunction_changeLevel:149` gives

    L_chi(s) = L_chi0(s) E_chi(s),
    E_chi(s) = product_{p in q.primeFactors} (1 - chi0(p) p^(-s)).

The product is over the source q.primeFactors, including primes dividing c. Such factors equal 1 when chi0(p)=0; they must not be omitted by an unproved relabelling. For Re(s)>0 and every such prime, p>=2, and

    |chi0(p) p^(-s)| <= p^(-Re(s)) < 1.

Use `DirichletCharacter.norm_le_one` in Bounds:38 and `LGrowth.norm_cpow_neg:84` instantiated at `s-1` for the norm identity. The latter theorem states the norm of `t^(-(s+1))`; this substitution and simplification give the required norm of `p^(-s)`. Its proof uses `Complex.norm_cpow_eq_rpow_re_of_pos` directly. Thus every factor, and E_chi, is nonzero. Each factor is holomorphic because its positive constant base is nonzero. Near any rho with 0<Re(rho)<1, the change-level identity holds on an open neighborhood avoiding 1, both L-functions are analytic by `differentiableAt_LFunction:91`, and E_chi has analytic order zero. `analyticOrderAt_congr` and `analyticOrderAt_mul:524` yield

    L_chi(rho)=0 iff L_chi0(rho)=0,
    analyticOrderAt L_chi rho = analyticOrderAt L_chi0 rho.

This is a local analytic-order identity. It does not assert an entire-function `LDatum` for an imprimitive principal character, and does not apply the entire-only WeilBridge helper to a meromorphic function on a ball containing 1. If such a principal ball carrier is needed, use the established pole-cancelled zetaF/xiF carrier, or a separately proved meromorphic-divisor restriction. The source expressions for induced L-functions and their prime-removal terms remain distinct.

Consequently, the prior primitive inverse-character reflection proof and section 3 together give [1/8,7/8] for *any* character zero in the open critical strip. The upper bound can be obtained directly from the public theorem; the lower bound goes through chi0. For chi0=1, primitivity forces c=1 and section 3 applies. Otherwise the prior local functional-equation factor relates chi0 at rho to chi0^-1 at 1-rho. Neither step assumes a same-character functional equation for a nonreal character.

For finite upper-strip certificates, use the certificate for chi0 at its actual conductor c and its assigned Hcert(c), not a height inferred from ambient q. Reflection uses the inverse primitive character at the same c (`conductor_inv:404`). Induction leaves rho unchanged; reflection negates its ordinate and preserves |Im rho|. The local-order identity above transports multiplicities whenever the chosen carriers contain the point and their divisor definitions apply. It does not eliminate the separate Gauss-weight, parity or prime-removal adapters.

## 5. What is already settled, and what remains

| Obligation | Current evidence and exact next requirement |
|---|---|
| Patch origin and selected external meanings | Reviewed source-level resolution. Compile the same reconstructed bytes; do not reopen provenance as an unexplained gap. |
| 4.34.1 to 4.35 compatibility | Five relevant Mathlib files were compared previously; retained mathematical interfaces agree. Whole closure, changed import visibility, tactic and instance behavior remain actual elaboration work. No specific current failure proves a need for new mathematics. |
| Validity of the global provider | Candidate proof bodies exist. The actual proof terms, expanded public type and transitive axiom closure remain unvalidated. This is more than checking filenames or building a trivial wrapper. No new global theorem can be declared proved from the source inventory. |
| Principal pole and global zero location | Resolved on paper here using the one Dirichlet export and existing modulus-one/xi APIs. Implement and validate that thin adapter. No use of zeta's assigned value at 1 is required. |
| Ambient character versus primitive conductor | Exact nonzero Euler-factor and local-order argument supplied in section 4. Implement the local statement and only the carrier corollaries actually consumed. It deliberately excludes Re(s)=0. |
| Primitive reflection and two-point order | Reviewed paper proof in PROVIDER_COMPATIBILITY_CUT. Implement its inverse-character identity, nonzero analytic factors and the two separate containing-ball checks. |
| Principal conjugation and damped symmetry | The earlier open-ended inventory is superseded: actual `XiPartial.xiF_conj:669` exists, and the new reviewed damped symmetry note proves local coefficient/order transport and complete finite-band reindexing on paper. The latter still needs formalization. Do not report the principal value identity as missing mathematics. |
| Nonprincipal conjugation | Prior paper route via conjugated absolutely convergent series and analytic continuation remains valid but unimplemented. Needed when reusing inverse-channel data or same-character reflected sums; not needed for the basic global strip proof. No new root assumption is justified. |
| Inclusive finite carriers | Reviewed source joins use a larger strict carrier U>H, then filter |Im rho|<=H and preserve true orders. Implement exact memberships and weights. Never replace this by the strict cutoff H. |
| Shared finite certificates and head evidence | Still distinct production/certificate/formalization work. Global QRH does not supply the tighter finite strip, and the removal of the additional one-million narrow goal does not validate any provider proof. |

No new analytic result is presently identified as necessary to repair the *global-provider interface*. There can still be undiscovered failures in the candidate proof or a future formal translation. The paper resolutions above must not be promoted to compiled theorems, and ordinary compatibility failure must not be repaired by adding hypotheses, admissions or alternative L-functions.

## 6. Smallest next validation sequence, not executed here

First create an isolated source port against the one target Mathlib/Lean pin, recording every compatibility edit and retaining exact external patch bytes and package options. Keep the original source tree and dependency caches unchanged. Existing prerequisite receipts are useful setup evidence only.

Next obtain successful actual elaboration of the genuine selected closure. Inspect the fully elaborated type of the Dirichlet export and the proof dependency closure. Reject every transitive axiom outside exactly `{propext, Classical.choice, Quot.sound}`, including synthetic sorry and native-generated axioms. An imported native example is not automatically a dependency, and an absent literal `axiom` token does not exclude one. Keep challenge modules with their admitted specification separate. The existing comparator selects the Dirichlet theorem and has `enable_nanoda=false`; neither a zeta audit nor an independent kernel check follows from that setting.

Then validate the modulus-one principal adapter and primitive location adapter before transporting orders or finite sums. The minimal location gate has no conjugation or weighted-zero-sum dependency, so a failure there can be isolated from later analytic interfaces. Validate the conductor/order and carrier corollaries next. This ordering reduces the unresolved interface without claiming a reduction in the imported proof closure or permission to start a build in this research task.

## 7. Pins for this handoff

All paths below are relative to `work/qrh-campaign/agents/`, except source rows. Full review hashes were reread from disk.

| Research input | SHA256 |
|---|---|
| integration/PROVIDER_COMPATIBILITY_CUT_2026-11-11.md | 4F2209C5D0D7F861426E5469A37B878CC4920756276F177C69D3C21D99E6F78C |
| prime-estimates/REVIEW_PROVIDER_COMPATIBILITY_CUT_2026-11-11.md | 85AFD92D37CA273EF553399903F3133BFA030175CFF608A25E3DA1E146970167 |
| prime-estimates/QRH_EXTERNAL_PATCH_SEMANTIC_AUDIT_2026-11-11.md | 9D305A6D9B5E0E1F5EC5B2BB8DBC1118C7061200C99BEE3BCA3C8BC1036ABD99 |
| independent-feasibility/REVIEW_QRH_EXTERNAL_PATCH_SEMANTIC_AUDIT_2026-11-11.md | 8E0265E3EC9A42B9EC3DECE55053676293851C0D9659005CBFBC3A45F13AF5C1 |
| moebius/QRH_PROVIDER_STATIC_TRUST_AUDIT_2026-11-11.md | 237280059D4E714E89432C4BC574EE42BC136BEAD7797FE5C09F3E48855AF270 |
| audit/QRH_PROVIDER_STATIC_TRUST_REVIEW_2026-11-11.md | 90E6426099124B1E446E48AF7DB0A099256CAD39FD4F87517ABA16DFE76B9560 |
| prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md | 8764E3EFDC940A4F302A761CFD2DE51778A91A5BF30F059F39CD0911F00CF5D0 |
| independent-feasibility/REVIEW_PSI_DAMPED_SHARED_STRIP_2026-11-11.md | 7D1315865B59B1CA84A8AB0676FF698121B665F54E2F84F81FFEA0A1B6FC7537 |
| zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md | 7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE |
| moebius/REVIEW_PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md | 8337D4EF50E27F37C20C16C59E04F3664886B21DBCE13CCFDCCC924B3F6C8D20 |

Source prefixes: O = `work/openai-math/lean/OAI/NumberTheory/DirichletL/`; G = `work/ternary-goldbach/TernaryGoldbach/Explicit/`; M = `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/`. The source table pins the actual files read, rather than a different copy of the named module.

| Source | SHA256 |
|---|---|
| O/Nonvanishing.lean | 16A7F55147E177E972264A2AC61D1639188A2090844A89D1C080CBA8500791CC |
| O/Detector/FinalAssemblyUnconditional.lean | 70D01B604FD5CC3522A4503543D9A5E422F9105C19E88985C5CD7C28C5958BA2 |
| M/NumberTheory/LSeries/DirichletContinuation.lean | ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1 |
| M/NumberTheory/DirichletCharacter/Basic.lean | 6CF338CFCDEE91A271CBDB8DF0011C47D02780469BCD2279D36907370F7C5FD4 |
| M/NumberTheory/DirichletCharacter/Bounds.lean | 411E5AEF9D6F072AB228FE5F23A88B3577042EA280379BDBD37E4D239EFFAA06 |
| M/Analysis/Analytic/Order.lean | 2426AEF2574C3DF5758D40D81DD33A6A62E07235F2B7B3F980512D4E80FDF46C |
| G/Xi.lean | 988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F |
| G/XiPartial.lean | 8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770 |
| G/WeilBridge.lean | 285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E |
| G/ZetaZeroSums.lean | 21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA |
| G/LGrowth.lean | 5E6BD327045A95842498DD35DA4D4CA476D7DF37275EA612CD4FA46D2273C341 |
