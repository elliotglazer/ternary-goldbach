# Review of the next rational-panel milestone and analytic slice

2026-11-11. **PASS as a bounded research recommendation.** The revised memo selects one arithmetic preflight milestone, preserves the full source-bound disk theorem as the objective, and keeps production spectral evidence separate. The new integral-moment remainder argument also passes independent paper-level review, with the explicit integrability conditions below. Neither verdict approves Lean declarations, freezes a dependency graph, authorizes implementation, or claims a kernel proof.

## Exact versions and work performed

| Input | SHA256 |
|---|---|
| `integration/NEXT_AFTER_RATIONAL_PANEL_2026-11-11.md` | `F9C3588E2BFC0A2DA7AF278F645E402C181FF6549E5455DDEDDE2FB4AE32D823` |
| `mellin/RATIONAL_DISK_MINIMAL_ANALYTIC_SLICE_2026-11-11.md` | `140A7211D82CAE13F7C3315B94F49A407066A6CE983D07435722405903F21B68` |
| Completed packet | `1B55E8A2665EF872056DE9747670E6F47017863A49D9E2C9A2D6604B6F74D09F` |
| Completed independent full-replay review | `11504C44549147C179EBB816E8EBED1F7FC44FA35B77F86C9BED51A5F0F4138C` |
| Receipt-controls review | `F0386856DA835AB2D4DFBE1E0A4B7BB78DA64E76850BA6AC554AEF358A33A826` |

Paths are under `work/qrh-campaign/agents`. The two proposed notes were read in full and their hashes checked. I independently read the pinned candidate's metadata to verify fixture selection; no analytic values were recomputed. The completed full-replay review's target/status and the existing receipt-control scope were checked. This task does not repeat either full replay or independently re-audit all newly cited production/nonprincipal support packets.

No builds, numerical function evaluations, declaration anchors or source edits were made. Only this review note was added.

## Corrections resolved before this pin

The initial memo incorrectly listed a backward reference as a negative-control failure while requiring references to earlier operands. The final version correctly rejects **forward references or cycles**. Backward references to already defined operands are valid and necessary.

The root wording is now explicit: the large-range target is `TernaryGoldbachFrom (10^27)` with no mathematical premise, including no BinaryGoldbachInput. Full Statement retains only the original inclusive BinaryGoldbachInput through 4*10^18. QRH, finite-spectrum data, checker correctness and analytic certificates are internal proof obligations, never new final hypotheses.

## Why the selected milestone is bounded and meaningful

The deterministic fixture rule selects first terminal types 2, 3, 4 and the first maximum-S-depth record, deduplicated. My independent metadata inspection reproduced:

| Criterion | Selected k |
|---|---:|
| First terminal theta2 | 0 |
| First terminal theta3 | 53 |
| First terminal theta4 | 49 |
| First maximum S depth, equal to two | 49 |

Thus the exact node set is `{0,49,53}`, not four unspecified easy cases. The signed weight rows -49 and 49 and zero are present. This is branch coverage for finite testing, not evidence that all admitted graphs are sound. Generic finite composition still needs a proof for every admitted record.

The two deliverables belong to one milestone: a general typed arithmetic-containment theorem and closed kernel acceptance of these concrete records. Neither alone completes it. The memo correctly distinguishes the closed predicate asserting arithmetic acceptance from the conditional semantic theorem interpreting a graph under seed, elementary-value and terminal-jet containment hypotheses. Those hypotheses are acceptable in an intermediate arithmetic lemma, provided they are visible and are not confused with a closed actual-P theorem.

The typed representation must fix target, operation meaning, initial theta type, operand references and allowed recipes independently of the certificate. Otherwise one could prove arithmetic soundness for a graph that computes the wrong function. The memo includes this requirement and correctly permits a different valid graph for the same recipe/claim; byte identity is not semantic soundness.

The existing JSON is not a complete operation proof. The proposed untrusted converter must reconstruct omitted computation from fixed recipes, with the Lean checker validating it. Trusted parsing of arbitrary JSON bytes is unnecessary for a theorem about a concrete imported typed value. Conversely, a theorem merely about that typed value must not be advertised as a byte-level parser theorem.

For future acceptance, inspect theorem types as well as transitive axioms. Only the allowed standard axioms—`propext`, `Classical.choice`, `Quot.sound`, or a subset—may occur. No `sorryAx`, introduced axiom, native-generated correctness axiom or hidden accepted-certificate hypothesis is permitted. A standard-axioms report by itself cannot expose a hypothesis that already asserts the desired analytic result.

The explicit later resource cap and separate elaboration/kernel/serialization measurements are appropriate. This review supplies no cap, timing estimate or implementation authorization. The full 929-node same-disk theorem remains required after the preflight; three arithmetic fixtures are not a substitute.

## Independent derivation of the moment remainder

This acceptance is new; it is **not inherited** from the earlier Cauchy review. A suitable generic complex-valued formulation over real Lebesgue measure requires:

- K is ae strongly measurable;
- `g(v)=norm(K(v))*exp(abs(v))` is integrable;
- `integral g<=D`;
- `0<=rho<1` and `norm(z)<=rho`.

Define `a_j=integral K(v)*(v:Complex)^j/(j!:Complex)` and `F(z)=integral K(v)*exp(z*v)`. The first two hypotheses imply integrability of every finite moment and the perturbed exponential integrand: each norm is bounded by g. This is why a numerical inequality on a totalized Bochner integral alone would be insufficient. An undefined/nonintegrable integral can totalize to zero without supplying the required domination theorem.

Absolute convergence of the exponential series gives, pointwise for real v,

`norm(exp(z*v)-sum_(j=0)^6 (z*v)^j/j!)`

`<=sum_(j>=7) rho^j*abs(v)^j/j!`

`<=exp(abs(v))*rho^7/(1-rho)`.

The final step bounds each nonnegative exponential term by exp(abs(v)), then sums the geometric tail. It includes rho=0. Multiplying by norm(K(v)), applying the norm-of-integral inequality, and commuting only a finite sum with integration gives exactly

`norm(F(z)-sum_(j=0)^6 a_j*z^j)<=D*rho^7/(1-rho)`.

No infinite-sum/integral interchange is required. No identification with iterated derivatives is required. Factorials occur exactly once in the moments and once in the corresponding quadrature integrands—not again in the final polynomial.

For this actual packet, `K(v)=P(v+i*b)*exp((s0-1/2)*v)` is continuous on the real line once the accepted analytic kernel construction is formalized. The reviewed P envelope implies the integrable majorant `A*exp(4*abs(v)-q*exp(2*abs(v)))` for g. On the two half-lines, the substitution R=exp(2*abs(v)) gives

`integral majorant = A*exp(-q)*(1/q+1/q^2) <= D`,

where q=1/44 and D=30813530880. Thus the additional generic measurability/integrability requirements are available for the actual kernel, but remain formal proof work. The final memo now states this boundary explicitly.

I inspected the cited source APIs: `NormedSpace.expSeries_div_hasSum_exp` supplies the factorial exponential series in the applicable complete normed algebra context; `Real.sum_le_exp_of_nonneg` and `Real.pow_div_factorial_le_exp` supply the needed nonnegative-term bounds. Local source hashes are `A0D4349C556CC8E9C1D637C183F75B4457BBA1733733131EE908E0BD645E798C` for `Analysis/Normed/Algebra/Exponential.lean` and `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0` for `Analysis/Complex/Exponential.lean`. This is source compatibility, not a tested Lean proof script.

## What the simplification does and does not remove

The seven quadrature rules already integrate the normalized moments. Their errors, signed weights, coefficient centers and numerical remainder budget therefore remain unchanged. The new argument removes the need to identify those moments as seven iterated derivatives and apply a separate Cauchy coefficient estimate. It does not remove the actual xi Fourier identity, its contour shift, the P/theta semantic attachment, weighted integrability, trapezoid theorem, discrete tails, finite node/weight acceptance, or rational budget proof.

For the successful disk, strict positivity of Re(F_b) directly proves nonvanishing; the nonzero exponential normalizer then transfers to actual xiF. General winding, multiplicity and rectangle-carrier machinery are unnecessary for this one conclusion. Optional zeta nonvanishing uses the source zero-location equivalence inside 0<Re(s)<1, a condition satisfied throughout this disk. The rectangle consequence follows from exact geometric containment. General future contours still need their own sound zero-count or inverse-cover argument.

## Frontier preserved

The memo does not turn local external success into Lean validation or production coverage. The narrow principal strip through one million and conductor-one family height 60,343,058 remain distinct. Nonprincipal data do not follow from a principal evaluator, and its four-S/sixteen-mode numerical allocation is not automatically reusable. Complete selected character/height coverage, closed boundaries, actual spectral margins or counts, and global QRH provider closure remain outstanding.

The scaling references are used only as warnings about particular sufficient budgets and constructions. Failure of such a bound is not a lower bound on true numerical error or a spectral impossibility theorem. The memo makes no unsupported runtime or guaranteed termination claim for the full spectral work.

**Final verdict:** accept the revised memo as the research handoff and the moment remainder as a valid paper simplification with explicit integrability hypotheses. Exact Lean declarations, generic soundness, concrete kernel acceptance and the full same-disk theorem still require separately authorized work. No final-root premise or production conclusion has been added.
