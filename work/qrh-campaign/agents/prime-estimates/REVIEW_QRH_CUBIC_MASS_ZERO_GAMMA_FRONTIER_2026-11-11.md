# Independent review of the cubic, mass, zero-mode and Gamma synthesis

2026-11-11. Verdict: PASS for the corrected synthesis at bounded source and mathematical scope. No outstanding correction. This review does not validate the complete QRH provider, its elaboration, its imported axioms, or any finite spectral certificate.

Reviewed synthesis: [QRH_CUBIC_MASS_ZERO_GAMMA_FRONTIER_2026-11-11.md](../../../qrh-blueprint/QRH_CUBIC_MASS_ZERO_GAMMA_FRONTIER_2026-11-11.md), SHA256 `7B9525A40EFDDC5D6CA52105836E49C1E478974DFBCE664B8D22E9A065093A59`.

The initial version, SHA256 `C0E4D2B27D6F8913393D1F834C233D18CEE65CC166DAD1699B6AF6AB60B62A40`, omitted the domain M,N>=1 from the introductory sentence for the cubic estimate. I requested that domain and the order of choosing C. The author added both. I read the corrected sentence and verified the final hash. This matters because the asymmetric term has a negative power of M. No author report or earlier review was edited.

## Mathematical and scope comparison

I read the four author/review pairs and compared their claims with the synthesis. I also reread the actual declarations and adjacent proof steps in `CubicSieve/FullImprovement.lean:48`, `Descent/SecondActualMass.lean:35`, and `Inversion/InitialZeroModeBudget.lean:15`. Source paths are below `work/openai-math/lean/OAI/NumberTheory/DirichletL/` at revision `4eaee87548250b2682affda7d05d947c05554bae`.

The cubic section preserves the distinction between squarefree-ideal and full element-row norms. The corrected domain and constant order agree with `full_improved`. The 7*theta loss, unit zero-frequency contribution, initial-bound proof of convergence, and comparison of complete descendant monomials match the reports. In particular, the section does not impose M/e>=1. The exponent map and contraction describe finite iteration for each requested epsilon, not a limiting argument with a uniform constant. The lower Poisson, Gauss, Fourier-envelope and initial-sieve inputs remain explicit.

The deleted-mode section retains the actual fiber multiplicity d(f)^(9+4K)*D_K and the geometric-mean Cauchy bound. A common bound A for both child energies contributes A, not A squared. List restoration affects the child lists; the outer deleted assignments remain charged. The mass constant precedes the source and scales. Nonempty triples imply the positive scale bounds are at least one, so the final Z>0 statement requires neither Z>=1 nor nonnegative kappa. The synthesis correctly resolves the author's opening shorthand about eventual child moments: these two finite estimates themselves neither assume nor prove the four child moment estimates.

The zero-mode section preserves the disjoint-support argument, the unique empty/empty surviving pair, and the signed Mobius density before absolute values. It retains the global character bound and arithmetic hypotheses through its stated reference to the actual hypotheses. The small-power mark estimate is independent of the number of slots. Empty support below bX=1 justifies the all-X>0 mass statement. The final normalization and D<=L comparison work for negative D and m. C is allowed to depend on the fixed Schwartz function through its Fourier value at zero; no numerical value or uniform constant over all such functions is asserted.

The Gamma section retains the strict positive beta parameters and the opposite-height conjugation. Its Hecke specialization uses p=11/10 and d=4/5. The reciprocal recurrence is used in the correct direction at large imaginary part; entire reciprocal continuity handles the compact rectangle and real Gamma poles. The strip-dependent Gamma constant and conductor-dependent temporary uncompleted-L growth witness are distinguished from the later uniform boundary estimate. The comparison with the target Mathlib cache is explicitly not a test of compatibility with the different OAI-pinned version.

No section promotes an unaudited internal dependency to a new final theorem premise. The synthesis does not claim current mathematical closure, compatible kernel validation, removal of PlattGRH from target source, a completed finite spectrum, or a changed selected strategy. The principal residue and other later reports remain outside this entry even if they have since been written. The repository status sentence records the coordinator's observation; this review did not rerun repository status or make a new clean-tree claim.

## Pin and count checks

I independently hashed all eight reports and all source-table rows containing a Lean path and SHA256. The per-report row counts are 40,35,28,0,27,0,7,4, giving 141. Every expected source hash matches current bytes. I separately read the two JSON receipts and hashed each referenced file: the deleted-mode receipt has 28 author entries and five additional entries, and the zero-mode receipt has 25 entries. All 58 match. Thus there are 199 checked entries across these inventories, with repetitions retained. This is not a count of distinct files or a fraction of the provider proved.

The deleted-mode receipt SHA256 is `F134EAC0DFAF6936ED633AF055B8AE65A50326981B458F1AFA6B6FE9054A8FDA`. The zero-mode receipt SHA256 is `B0AA72AF24A3DE3D5523BC51AD4E964724167C0809B8AC0CCC76580530974B44`. These match the reviews. Hash checking reads bytes; it does not verify imported proofs.

| Report | SHA256 |
|---|---|
| Cubic author | `1727E899339761F828A0D5B56F776884C63E9BB810EF5E0606C9E88E85AC10BD` |
| Cubic review | `0FB95170974269A2967C811BEE01C3AB919CCE5871E8320E742205C5E76EC1F8` |
| Deleted-mode author | `B7575C743474BBF80AA421937AFDAD10590EA76BE21FB421B6225DDEC8CAA859` |
| Deleted-mode review | `943B4229968A6901E909A9AE51159B52ADBE5DAE331B0F28E2B78A4DBA03B8CB` |
| Zero-mode author | `AC63CCA803785C2E4ECBE0AB8C9373206CA19ADE741BBD8A26B5AB5D168BF8DB` |
| Zero-mode review | `E0E5A316FE5B64E0AF3E33F95CED30F2BABD5220559BE76DD66BBA13D17ED741` |
| Gamma author | `A7D461828B1832622C66F5E450BB25EAF3C98EE4B75BD3BD240DE00B5861A7FF` |
| Gamma review | `20E4EC7C79A2FD89142FD9A01CF441E07811648AF59F30434E601DF3322D0291` |

No Lean/Lake command, analytic evaluation, spectral scan, source edit or dependency change was performed. The accepted result is fidelity of this synthesis to the reviewed conditional arguments and their explicit remaining foundations.
