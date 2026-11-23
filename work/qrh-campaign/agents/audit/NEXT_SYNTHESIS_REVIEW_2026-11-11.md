# Independent successor synthesis review

Date: 2026-11-11. Verdict: PASS for the frozen research synthesis and package integrity, within the evidence scopes below. No blocking correction is required. This is not theorem closure, a validated Lean dependency graph, or approval of new mathematical premises.

This review is bound to `outputs/qrh-blueprint-next/manifest.json`, SHA256 `3F0DA3E74F80F563F2F2FD8368AFBA46FF6CC086F7459C2B32B52A47385B686A`. It is saved outside the package. No package, canonical Lean source, dependency, or prior frozen artifact was edited during this review.

## Exact snapshot and integrity

| File | SHA256 |
|---|---|
| README | `A0A9E92F05452E157AA290D649D97665107F7F2D84ED02980A569ADCCE1E2AE6` |
| OVERVIEW | `8B8B4737F8D899AA52CDB6D5501F66CF1FB279EED58A95D43F2F592C44B8FD63` |
| SELECTED_STRATEGY | `E07683A017B922BC309E26763A821E97CAC7AE79938A19CCBF843E9205CABBF7` |
| dependencies.json | `B1EFEA240C16F8B41F3EFEC6FA29583535D02C9DE9B53627216784BF22B47B86` |
| assembler | `6D61A0192BEBE611CED93A6FC0B706F4FF3DA20BF01B1B92CD1F5F6971F5F04F` |
| verifier | `A9837DE2250924C091ABD5B7125F7ED303E78F8E48771E229D74AAC5A2395685` |
| provenance catalog | `D094DD9D3CBB5147B8A72DF31558EC0A4D5D80442457FAE7EA35534627AA3DC9` |

Ran the new verifier and the original verifier; both exited 0. New results: 676 manifest-listed files, 672 source copies, 576 archived files, 16 accepted packets, 36 landing-page links and 27 research nodes. Original results: 575 manifest-listed files, 131 source-matched chapters, 149 chapter links and 35 research nodes.

An independently written read-only inventory script, `next_synthesis_independent_inventory_20261111.py`, also exited 0. It verifies every manifest hash and file size, the complete inventory, every catalog pin, and the research DAG. It compares actual bytes for all 672 source copies and all 576 archived files against the unchanged original package. The original manifest remains `EAA2FDF61FBB79477242314C3269146FFD45646DA030DF1D111A0360ED447035`. The new archive includes that manifest itself without changing it. Its 575 declared payload files also match exactly. Results and source hashes are in `next_synthesis_independent_inventory_20261111.json`.

The original target remains at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, and the global provider checkout remains at `4eaee87548250b2682affda7d05d947c05554bae`. Target git status contains only the two previously recorded untracked helpers, `Explicit/QrhMellin.lean` and `Explicit/QrhNumeric.lean`. There are no tracked target modifications. No Lean compiler was invoked.

The assembler and verifier are appropriately scoped. The assembler validates the old manifest before copying and builds a separate output inventory. Accepted packets come from an explicit catalog with pinned independent reviews, not filename searches for PASS. The verifier checks exact current/source/archive bytes, relative paths, packet references, landing links and acyclic coarse dependencies. It does not purport to validate numerical or analytic claims. The manifest's `frozen:true` means an immutable research checkpoint; the documents explicitly deny an approved declaration set or proof graph. No author-frozen Lean anchor or newly sealed theorem is created by this flag.

## Root fidelity

Read the actual `Statement.lean`, `MainTheorems.lean`, and the large/small join in `Helfgott/Main.lean`. The selected outcome is unchanged:

    TernaryGoldbachFrom (10^27)

with no mathematical hypothesis, and full `Statement` with only the original `BinaryGoldbachInput`. Expanded, the large result quantifies natural N, assumes Odd N and 10^27<=N, and produces three natural primes summing to N. It neither requires distinct primes nor adds a witness restriction. The full result quantifies odd naturals greater than 5. BinaryGoldbachInput remains the inclusive statement for even naturals 4<=n<=4*10^18. The existing small/large join overlaps at 10^27.

The current upstream theorems still have PlattGRH inputs; the package does not describe them as already removed. All new spectral and numerical inputs are proof obligations internal to the intended development, never extra final binders or bundled standing assumptions. The full finite binary input is the sole retained mathematical premise. Hashes for the inspected statement and root source are in the independent inventory receipt.

## Selected quantitative route

The current selected family is exactly the active primitive conductors: odd c<=150000, and 4 divides c with c<=300000, including the principal conductor and inverse/conjugate characters. The proposed closed cutoff is the real quantity

    Hcert(c)=min(Hp_old(c),10^8/c),
    Hp_old(c)=ceil(200+max(1000,(704/7)*D_c)),
    D_c=1200000/qt(c).

Here qt(c)=2c for odd c and c otherwise. At c=1 the selected cutoff is 60343058. The required upper real part is 111/200. This is not replaced by a weighted profile, a smaller unreviewed cutoff or a pilot computation. The entire active family remains open.

The major coprime targets are Aplus<=5e-7, Astar+Cross<=9.5e-7, N<=1.23, Ep<=1e-4 and the stated lower/upper J contract. The common-height mixed remainder is correctly the newer <.000160001, not the superseded <2e-10. The final normalized major/minor/nonprime constants remain 1.0404, 1.0376 and .00271 in x^2/49 normalization, with reserve .00009. Existing actual smoothing, parity, original versus reduced modulus and multiplicity adapters remain explicit tasks.

The principal selection incorporates the independently accepted external critical-line/simplicity certificate through closed height 1500. Above that, the remaining sufficient target is the closed [.4968,.5032] strip on 1500<|gamma|<=10^6. Its reviewed split moment gives W35<23.980532761132<24 and stays inside the original [.49,.51] psi requirement. The head uses exact N(1500)=1069 and boundary-corrected Q1500<1.668. The high moment uses only the analytic upper count; no exact N(10^6) is inserted as a premise. The optional .00325 width is not selected.

## Evidence scope and independent obligations

The following distinctions are preserved in the current overview, selected strategy and graph:

| Branch | Present evidence and remaining work |
|---|---|
| Finite primes | All 6439 windows, 125271 subcounts and the full external recount are complete. Log/recurrence mathematics and a kernel architecture are reviewed. Actual count proofs, base completeness, arithmetic semantics and kernel replay remain open. Finite theta-to-psi transport needs the finite nonprime_mid repair only; global P6 is not smuggled into that finite leaf. |
| Principal low spectrum | All 1070 retained sign points have a full alternate explicit-EM replay. Together with the separate complete head count, they establish finite RH and simplicity externally through 1500. Formal Hardy/phase, interval and multiplicity proofs remain open. |
| Principal top count | The preferred explicit-EM/Taylor packet has a full six-block independent alternate calculation and gives N(10^6)=1747146 externally. It uses no builtin zeta/RS count premise. This count supplies neither the remaining high strip nor enough sign brackets. The earlier RS method is retained as an alternative only. |
| Principal high spectrum | The [.4968,.5032] implication is independently reviewed, but the strip itself on 1500<|gamma|<=10^6 remains unproved. Neither low RH, exact top count nor the .555 family assertion supplies it. |
| Nonprincipal family | Conductor-five covers all three primitive characters only on its bounded closed rectangle. Conductor-101 covers all 99 primitive characters only on the stated short vertical segment. The segment is not a contour/count or a full-height certificate. Full family production, coverage and formal replay remain open. |
| Global provider | Exact public source type, inverse-character reflection and compatibility have source reviews. Complete provider compilation, elaborated exports, transitive axioms and actual zero-order adapters remain open. The 23/24 theorem is not substituted for seven-eighths. |
| Prime and Mobius producers | P2/P3/P6 paper repairs, the selected short psi route and finite data feed the other exact Lambda interfaces and relaxed .03/.10 profile. M1/M2, G2 .0089, finite boundaries and tails still need their actual formal consumers. |
| Totient and quotient branches | Finite, first-choice, remote second-choice and separate regionS repairs are retained. A finite certificate is not described as a proved unrestricted replacement for global div_totient_lt. |
| Energy and base gap | Actual etaPlus energy <=.65*x*log x and residual <=8e-11*x, finite-family pointwise base gap, q=1,2,3 high joins and all ten Type I/II boundaries remain formal obligations. The averaged major estimates are not silently used as pointwise base-gap bounds. |
| Final assembly | Complete major/minor/prime-removal transfer, summability, source carriers, numerical adapters, exact root types and axiom audit remain required. No root proof is claimed. |

The explicit-EM top-count review's stale low-range sentence is corrected in the current overview without mutating its frozen producer. The overview also records that acceptance requires PASS_EXPLICIT_EM_TOP_PATH and all six blocks; exit code zero alone is insufficient when a producer can return INCOMPLETE. The current documents retain the Hurwitz totalization-at-one warning and the corrected floor-versus-square-root numerical bound. These qualifications prevent the archived shorthand from becoming a selected false claim.

## Graph and final disposition

The 27-node map is explicitly coarse research bookkeeping, not an author-approved or declaration-level proof graph. Its roots are faithful, and all selected independent branches are represented directly or transitively. The moment does not require the optional topcount node. Nodes with accepted external evidence remain marked as needing formal replay. The archived chronology is kept intact, and current selection is identified by the two new landing documents rather than rewriting historical conclusions.

No blocking synthesis or integrity issue remains at this exact manifest. Acceptance of this snapshot does not freeze new Lean declarations, promote draft proofs, validate the global provider, or establish the two remaining large finite spectral tasks. Further claims require versioned evidence and a new review rather than modifying this checkpoint in place.
