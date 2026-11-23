# Independent review: principal head data in the current comparator

2026-11-11. **PASS for the original report together with its clarification.** The inspected original-RH comparator has no separate consumer requirement for N(1500)=1069 or Q1500<1.668. This is a bounded source/paper dependency conclusion, not an axiom-closure result, an actual RH certificate, or proof that every possible certificate producer can discard its head initialization.

## Frozen artifacts and corrections

Both author files below are under `work/qrh-campaign/agents/zero-sum/`:

| Artifact | SHA-256 |
|---|---|
| `SELECTED_PRINCIPAL_DATA_OBLIGATION_AUDIT_2026-11-11.md` | `8D0DD8B883512BF33BDEDF86097BB901D85F77314A27BE7621AE8D592F9A6934` |
| `SELECTED_PRINCIPAL_DATA_OBLIGATION_CLARIFICATION_2026-11-11.md` | `1F204823F789F0B04CF8C7B93690F656431FA91CCEA7ADDB85190D12906540F7` |

I read both in full. All ten source pins and twelve report pins in the original note were checked against disk. I also checked the selected combined assembly and the actual damped symmetry note discussed below. No author file was changed. No evaluator, analytic value, prime or spectral calculation, Lean declaration or build was produced.

Two narrow corrections were requested and are resolved by the separate clarification:

1. `line_sum_le` weights its pointwise estimate by max(1,abs(gamma)); `line_sum_leH` uses max(1/2,abs(gamma)). They cannot be described as having identical max1 hypotheses. Both avoid a numerical minimum-ordinate input.
2. The selected combined odd/even assembly uses the reviewed mixed star bounds A<4e-12 and B<42<62. It does not need the newer uninflated `SHARED_RH_STAR_BUDGET` lemma. That paragraph in the original ledger is corroborating optional evidence, not an added selected dependency.

The first correction is source precision; the second prevents an unnecessary proof dependency from being introduced. Neither changes the no-separate-N1500/Q1500 conclusion.

## Positive body reconstruction

Paths in this section are relative to `work/ternary-goldbach/TernaryGoldbach/`.

`Explicit/ZetaZeroSums.RHBelow:23` quantifies over actual zeta zeros in 0<Re(s)<1 and the closed absolute-height interval. Its conclusion is only Re(s)=1/2. It contains neither an exact count nor a weighted sum. The extraction at line29 currently uses `Fact PlattGRH` and the modulus-one L-function identity. Localizing that premise remains formal work.

The bodies of `line_sum_le:161` and `line_sum_leH:416` work with arbitrary finite subsets of the actual zero carrier, retaining `multRectD`. The former uses the analytic ZLg bound; the latter counts each window at its own center using the polynomial zeta growth estimate. The denominators are regularized at 1 or 1/2 as described above. Their needed hypotheses are line location, height, pointwise kernel control and analytic growth/count facts. No exact principal head population or raw reciprocal sum is used to bound these windows.

`Explicit/PsiExplicit.SsumG_gsm_errH:120` makes the division at abs(gamma)<=H, uses RHBelow H for the line contribution and the full-strip Gaussian tail for its complement, and retains the actual hZeta vertical integral. `LineB2H:110` is a sum of analytic window majorants with denominators max(1/2,6m). It is not Q1500 or an enclosure of numerically recorded ordinates. The finite-carrier estimate is uniform before the explicit-formula limit. `summable_gsm` and `tsum_gsm_leH` then give the actual infinite prime sum. The conclusion is not obtained by assigning a default value to a divergent sum.

This is the source route consumed by the original plateau. In `Prelim/MertensProduct.E1_win_num:531–545`, the proof also explicitly invokes `tsum_gsm_leH` at H=1e8 and then `ErrG_win_le`. Its separate smoothing and variation constants remain genuine inputs. `Prelim/EOneBound.abs_smoothed_E_le:156ff` explicitly supplies `rh_upto_1e8` to its integral/variation bounds. The prior height audit, independently reviewed at SHA `30736389905515E2AA502E924A299DCBEB4CBE6F9151477838592FA87B4E69D9`, covers the downstream finite psi, theta and Mertens/totient scope. I do not infer that those other inputs disappear.

For the major arcs, the same distinction is visible directly in `Explicit/ZeroSumGen.E1g:191`: it is ZLg times Plancherel square-root bounds. `zero_sum_boundG:201ff` derives its low-zero part from analytic window counts and kernel integral bounds. The actual scalar bodies in `MajorArcs/Thm714.errPZ_le` and `Cor713.E1z_le:653` bound this expression using BPz2 and a floor bound on the number of windows. The principal star estimate `err933Z_le:774` retains E1, E2, origin and vertical terms; it is not a hidden use of a recorded principal zero list. Finally `Prop715.prop_9_5_1:299` takes RH through500 and combines the phi1/phi2 formulas. Its wrapper obtains that input by restriction, not by reading N1500 or Q1500.

These are positive descriptions of the consumed estimates. A textual search for the two numerical constants would not establish the same conclusion and was not used as the proof of absence.

## Selected star path and the principal term

The selected combined assembly is `audit/COMBINED_ODD_EVEN_PROFILE_ASSEMBLY_REVIEW_2026-11-11.md`, SHA `2017E3ECC588438907D0A9582D9C351CE201FE11C41EAF68BDA4559F705FA250`. I read its actual chosen star join. It restricts the common ordinary-RH hypothesis to Hstar, implies the weaker squarefree/nonsquarefree finite strips of the floor300 proof, and uses A<4e-12 and B<42<62. It expressly avoids the newer line-budget and direct-B arguments.

The floor300 proof inherits a nonprincipal count bound for primitive conductors c>1. Its proof uses the canonical theta+S+S_inverse identity, elementary Turing bounds, Binet control, and averages on either side of the cutoff. Boundary and real zeros remain in its closed count. Its low Gram window cap is analytic Jensen control, and its high tail retains the growing window-count term. None of those steps is a specialization of zeta N(1500). The notation QA and QB denotes conductor-weighted finite spectral statistics and is unrelated to the integrated principal Q1500.

The principal part is separately estimated by the conductor-one star formula and the original coprime-removal bounds, then by the finite arithmetic weight calculation in `WEIGHTED_PRINCIPAL_WSTAR_BUDGET` (SHA `22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7`). Its integrated radius 1.902e-6 is derived from those quantities. Its generic sentence about “principal RH and its head data” cannot impose the specific N1500/Q1500 predicates when the mathematical derivation consumes neither. The author clarification properly identifies this as ambiguous inherited wording, while retaining any head data actually used by a chosen RH producer.

## Where the head data really are used

The historical `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md`, SHA `F5276E1C93B959BFC4D86A58BEFAA4666E320454CDC9B2CC2804EEEBE354FEBB`, selects a different principal path: a finite shared strip, global7/8 control and the damped psi replacement. It explicitly retains three head facts. In `zero-sum/PSI_DAMPED_SYMMETRY_SOURCE_JOIN_2026-11-11.md`, SHA `7574552D55981DCEC5CF5A419D6CEEB6FC7A264FE4A81CBAA8D0C3880F6DAFBE`, the actual Abel formula uses N(1500)=1069 in the endpoint subtraction and Q1500<1.668 in the head majorant. Its raw positive reciprocal sum is Q1500+N(1500)/1500. Ordinary RH does not supply these quantitative values.

The optional reciprocal/inverse-square head-reuse proofs also require actual head evidence. In the reciprocal proof the exact N(1500) cancels in one rearrangement, but the Q1500 bound remains. The inverse-square proof additionally uses the 1069 count and the zero-free head through14. Thus selecting the combined optional prime-gap construction can restore those obligations; no blanket deletion is justified.

## Cost and implementation boundary

For the inspected original-RH comparator, it is sound not to charge an additional mandatory N1500/Q1500 certificate solely as an analytic consumer input. It is not sound to infer a numerical saving without examining how principal RH through1e8 will be proved. A Turing, argument-principle or other completeness construction may reuse the head packet internally. Its required start count, signs, endpoint handling or reciprocal data must still be proved and checked if that construction uses them.

Principal RH through1e8 remains a genuine undischarged spectral obligation here. Its restriction through500 needs no separate run, but still needs that proof. All consumed finite arithmetic remains: in particular `Prelim/PsiTwoSided.psi_two_sided:79ff` directly uses `SmallTab.small_table` on the small range. The reduced-cutoff mass, finite minor data, binary coverage and other retained arithmetic are not removed by this dependency finding.

The recent isolated plateau improvement does not change this verdict into a complete lower-height result. Nor does this review validate every imported proof or establish a Platt-free build. It accepts the clarified selected-route dependency and the distinction between theorem inputs, alternative-route inputs and internal certificate-construction evidence.
