# Independent review of the major final consumption join

2026-11-11. **PASS as a conditional paper/source implication.** No substantive correction is required. This is not a Lean proof, an axiom audit, or evidence that the required finite spectra exist.

Reviewed author file: `major-constants/MAJOR_FINAL_CONSUMPTION_JOIN_2026-11-11.md`, SHA256 `280FDC53E61066E050DD98D4A004A9435510CC67686A59354750E0F7DE188F64`. Source revision: `23b2d68ca344203d4384e0aff7affa4ec034bef9`. I read the frozen note, its scalar script, the accepted zero-sum and actual-smoothing joins, and the source consumers listed below. No source, dependency, frozen packet or Lean file was changed. No analytic evaluator or build ran.

## Checked mathematical joins

The residual Parseval identity has the correct inverse character and weight `|tau_q(psi)|^2/phi(q)`. The constant subtraction transforms to `mu(q)P` only in the principal row, including the case `mu(q)=0`; no division by mu is needed. This follows from [Bombieri.parseval_chars and sum_char_mul_S](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MinorArcs/Bombieri.lean:27). Applying the identity to the coprime coefficients meets the actual support hypothesis. Their norm summability follows from the unchanged smoothing coefficients. The supported imprimitive Gauss weights are retained.

The new star removal bound is valid and noncircular. The sum of character weights is phi(q), so a uniform scalar error `2e-12` has integrated vector norm at most `2e-12*sqrt(sum_q 2Dq phi(q)) < 2e-6`. Adding this to the finite-low norm below100 gives actual integrated Estar below10001. The plus counterpart is exactly `Ep+N < 1.2301`. Neither argument requires the final cubic bound, lower J, or MinorTotal's uniform-star theorem. The pointwise source removal bounds apply for the stated x and q, and give the two separate errors used in the product expansion.

Upper J and lower J have different uses. Upper J uses the principal main norm, Ep and N before the cubic estimate. Lower J discards nonprincipal energy, uses the positive Fourier lower integral on every Dq>=4, then reverse triangle for the actual principal residual and removal. It uses the stronger Ep estimate, not merely the public `Ep<=1e-4`. The source Fourier theorem is [EtaPlusL2.integral_fourier_etaPlus_Ioo_bounds](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/EtaPlusL2.lean:199). There is no L2-to-L4 inference: the cubic bound separately consumes Cross through `V<=2(Astar+Cross)`.

The cubic identity, the two applications of Cauchy-Schwarz, and the product-sum inequality all hold on the finite arc/residue measure space. Actual continuity on compact intervals justifies their integrability; endpoint changes are null sets. The original cubic has factor x^2*y and the change of variable contributes 1/x. Its common unit is therefore x*y=x^2/49. This also matches the ideal etaStar Fourier term.

The ideal coefficient is the source `coef_eq`, including its sign and cube of mu/phi. [MajorTotal.main_comparison](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/MajorArcs/MajorTotal.lean:561) applies at w=Dq/x because Dq>=4. Summing its absolute errors yields `49*2.03e-5*2.85=.002834895`, exactly once. The singular-series lower bound is multiplied by the positive Cmain lower bound, not by termwise positivity of coefN. The source periodic arc partition applies to the real part of the integrand and preserves the fundamental-domain boundary.

## Independent exact arithmetic

I reconstructed 13 comparisons independently in `audit/major_final_consumption_independent_scalar_20261111.py`, without importing or executing the producer. Script SHA256 `01263E1715E48184293BEBE8AAD93E38A2597E4645AB101E71BA8CF739687373`; receipt `audit/major_final_consumption_independent_scalar_20261111.json`, SHA256 `00C07FFF58F8211909102B07EBDBFF4413399DC96562B1CAA1B68D4FD8DDFCE2`. All passed using Fraction arithmetic. They check both J directions, star norm/energy, both removal caps, the two squared square-root comparisons, dynamic loss, main term, nonprime bound and final reserve. This is scalar evidence only.

The resulting major lower constant is `1.040492451>1.0404`. The existing source nonprime proof's `v=N^(1/64)>=2.64` and `c^2<=4.0804` give normalized loss below .00271. Thus `1.0404-1.0376-.00271=.00009>0`. The note correctly requires rebuilding [Inputs.major_arcs_input](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean:76), [Main.repSum_lower_bound](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/ternary-goldbach/TernaryGoldbach/Helfgott/Main.lean:30) and the final numerical use; it does not prove or erase the hypothesis from the old1.049 theorem.

## Limits and source pins

This closes the specified consumption implication after its quantitative inputs. The uniform .555 finite condition through the rational minimum Hcert, global7/8 provider and inverse-character interpretation, sharp Mellin/Gram/scalar bounds, actual residual transfer, and all Lean implementations remain at their existing status. The accepted zero-sum join supplies measurable actual residual components, not an unproved absolutely convergent infinite zero series. The larger `.000160001` mixed remainder is a norm and is correctly included before squaring. Independent minor, prime/Mobius and quotient obligations are not discharged here. The intended large root remains unconditional; the full Statement retains only the original inclusive BinaryGoldbachInput.

Directly checked source hashes:

| File under TernaryGoldbach | SHA256 |
|---|---|
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| MinorArcs/Bombieri.lean | F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79 |
| Helfgott/Inputs.lean | 5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83 |
| Helfgott/Main.lean | DD5E20E51EC7C699CAC00A497C34FEF687E7E5B4562D3B1D8B981ECE54F4261D |
| Helfgott/Numerics.lean | 059874D201ECC571583118A56BA6193D6D8B49016C227988CBC83FA0F34648DB |

Prerequisite joins read: zero-sum `600F627B397F7A8E83AE20578D8BA7A7C5EBEC536578EA5EC41D1E3AAC25ABDA`; smoothing `DDE8BB9C5782A91006A47E608F653A82E3BA195397D245C1304B485888F2F55D`. Their acceptance does not make the spectral hypotheses into established data.
