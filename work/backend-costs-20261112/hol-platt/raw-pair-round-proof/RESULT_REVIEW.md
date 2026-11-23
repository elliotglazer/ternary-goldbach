# Accepted rounding-to-complex bridge

Reviewed 13 November 2026 from pair05 construction and rawaudit03 reload evidence. This is a coordinator review of recorded results and a completed reload audit. It is not an independent replay of every imported theory and is not a source-to-sign throughput result.

## Exact accepted result

The program takes four exact signed integer products and rounds the two final coordinates with the existing nearest-division operation. For positive output grid g and positive right-operand scale s, its interpreted complex value differs from the exact product of the interpreted input values by at most 1/real_of_int g. Each coordinate error is at most 1/(2*real_of_int g). There is no sign restriction on either integer pair. The two scales may differ.

The seven audited roots are round_scaled_real_residual, round_scaled_real_error, round_scaled_coordinate_error, modu_le_coordinate_sum, pair_value_exact_product, four_product_coordinate_errors and four_product_round_error. The modulus is the actual complexTheory.modu, defined using the Euclidean square root. The coordinate-sum bound is a proved inequality, not a replacement definition of modulus.

Both program definitions and all seven theorem statements match the original candidate source exactly. Changes are confined to a direct real-theory import and proof bodies. The audit uses aconv against every exact expected conclusion, requires empty theorem hypotheses, permits only DISK_THM import tags and requires empty explicit axiom tags. Ancestry contains only bool.SELECT_AX, bool.INFINITY_AX, bool.ETA_AX and bool.BOOL_CASES_AX.

## Evidence checked

Pair05 constructed and exported the complete theory. Its six expected-source, five run-source, forty-five dependency/tool and two output pins matched the current files. Its phase and container exits are zero and all seven theorem-save records and the completion marker are present.

Rawaudit03 compiled and ran the separate audit. Its eight expected-source, five run-source, forty-five dependency/tool and one output pins matched. Both phases and the container exited zero. All seven exact root labels and the unique completion marker match. Both the regenerated dependency record and the compiled audit module name the repaired helper in raw-pair-round-proof, rather than the missing helper in the preserved original stage.

| Artifact | SHA256 |
|---|---|
| RawPairRoundScript.sml | b694669a982e383b8085754d0f91667eaefe09bf155f51d59f06501a87dcef51 |
| source_expected.sha256 | 474a2de1af052a9a7650ece1489a132e980acef902b27d308b7f8617470b36d4 |
| RawPairRoundTheory.uo | 2c29c12785624046fc92c229a0b334aaa1f73011cbb2a3275e2678c66001a9ed |
| RawPairRoundTheory.dat | 1edbc1efcd04ddf95b78efb8a5ef029948ddc39c4c7da76cb9032227707b7f9b |
| ../raw-pair-round-audit/raw_pair_round_audit.sml | 08bc1f85dabd0afed69610a657681a1626e49d15c22b0c7b33ed7bd05ac25875 |
| ../raw-pair-round-audit/source_expected.sha256 | deb56011beefcf265e478900de1efc9c982137457f9091b555f3cacada77d186 |
| ../raw-pair-round-audit/rawaudit03_audit.log | cf78aaaab37323540ba8e1c6ad02861f19ccd8df3ebdef6f175c46792e3027b3 |

## Construction costs and preserved failures

| Successful phase | CPU seconds | Wall seconds | Peak RSS KiB |
|---|---:|---:|---:|
| Pair05 theory construction | 16.64 | 55.02 | 883108 |
| Rawaudit03 audit module construction | 2.98 | 24.91 | 38728 |
| Rawaudit03 audit execution | 10.67 | 19.91 | 742448 |
| Sum | 30.29 | 99.84 | |

The two successful containers took 56.422 and 46.656 wall seconds. These figures exclude earlier failed attempts, saved-state diagnostics and cached prerequisites. The separate analysis dependency construction used 234.62 CPU seconds and stopped at the original helper's namespace error after all fifteen missing standard theories had built. Its preservation receipt and all 142 output pins passed. Earlier inherited library construction remains separately recorded. None of these numbers prices numerical source production.

Failures and repairs remain recorded. The original helper lacked a direct realTheory import. Pair01 required a private writable dependency-metadata copy. Pair02 exposed a broad simplifier that erased transported real inequalities; residualdiag02 verified the exact repaired theorem. Pair03 exposed absolute-division and positive-grid rewrite issues; errordiag04 verified the exact second theorem. Pair04 proved the first four lemmas and then required qualified pair projection theorem names. Pair05 passed all seven.

Rawaudit01 needed a private metadata copy for the completed helper as well as the libraries. Rawaudit02 resolved the shared theory name to the preserved failed candidate. Rawaudit03 uses PRE_INCLUDES for the completed helper and passed. Original sources, original build evidence and library proof objects remain unchanged. Only disposable dependency metadata receives writable overlays.

## Consumption and remaining scope

Consumers must give raw-pair-round-proof priority over the original dependency stage for RawPairRoundTheory. The original failed candidate remains preserved in that stage. The accepted helper is read-only in the audit and should remain pinned when adding source consumers.

Next, prove that SourceArithmetic.source_mul is the same rounded integer program with s=&step_scale, then carry the local bound through the actual persistent source_state recurrence. The selected complex library has MODU_MUL, MODU_CONJ, MODU_POS and RE_IM_LE_MODU, but this source inspection did not find a modulus triangle inequality. COMPLEX_TRIANGLE is a polar identity, and COMPLEX_SUB_TRIANGLE is an algebraic subtraction identity. A genuine modulus triangle inequality must be proved or located before using it in the recurrence. It can be derived from the modulus-square identity and RE(z*conj w) <= modu z * modu w; this is a mathematical route, not an implemented theorem here.

Actual logarithm, exponential, inverse-root and Euler-Maclaurin enclosures remain open, together with the selected anchored-log producer, complete source assembly, analytic transform error, strict signs and zero-count closure. No supplied approximate input becomes certified solely through this local multiplication theorem. There is still no accepted complete actual HOL source-to-transform-to-sign/count production block. The frozen campaign forecast and the full research objective are unchanged.
