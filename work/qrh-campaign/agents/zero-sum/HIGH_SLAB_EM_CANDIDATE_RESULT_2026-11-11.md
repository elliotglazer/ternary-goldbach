# Completed explicit-EM candidate for the final high zeta slab

2026-11-11. **The authorized producer completed with `PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO`; independent numerical verification is pending.** All fourteen initial whole-boundary panels passed, with no subdivision or failed attempts. This result concerns exactly one closed slab at the million-height endpoint. It is not a full principal strip, family certificate, or Lean theorem.

## Frozen artifacts and inspection

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| `zero-sum/high_slab_em_candidate_20261111_01.json` | `CF90E96C7531F57E455ABCE70D8D71FB06596E9E1490FADDBAFA6DE64FCB0B09` |
| `zero-sum/high_slab_em_candidate_20261111.py` | `AA4496B7EE84D4BCA497B5BDFFC237A6DC0949F45C5F9E134B29498C5B58D084` |
| `zero-sum/coordinator_high_slab_run_20261111_01.json` | `C42A0F28906FB63C675F3B83652DACBCCDB85F58304ED46682E8D6BA14B89C82` |
| `zero-sum/HIGH_SLAB_EM_PRODUCER_PREPARATION_2026-11-11.md` | `DB32269D56AB94F38E3361A7B2BBA6C0CD0BD2425810BBF9CC80E1DE137EA8EA` |
| `audit/REVIEW_HIGH_PRINCIPAL_SLAB_PREFLIGHT_2026-11-11.md` | `1111EF1A55452E17059F51B662EA72B48A40354A3F7F59E2A1AC6A49AB2F1BD8` |
| `zero-sum/inspect_high_slab_receipt_20261111.py` | `F22BD8E477566ACBD57A6ACFE71FDEA3E6C3EDD2C46DFAA6532F4B3FAEF16E06` |
| Its inspection receipt | `8ECC5778F96DB9151C00827FB6AAC8DBCDCD0D35BE2512139C8C01AF8BE91DC4` |

The coordinator reported producer exit zero. This author inspection did not rerun the producer or evaluate a model. It hashed and read the frozen receipt, checked the pinned inputs, exactly reconstructed stored geometry, half-plane margins, shared-vertex memberships and crossings, and checked all imported top coefficient boxes enclose their original rational endpoints. All checks passed. The inspection's Python code imports only standard-library arithmetic and reads the producer solely to hash its bytes.

## Exact region, models and errors

The region is

`[629/1250,2]+i[7999999/8,1000000]`.

This is `[.5032,2]+i[1000000-1/8,1000000]`, including every side, corner and both heights. The calculation represents actual zeta using the finite entire pole-cancelled Euler–Maclaurin expression g approximating zetaF, then divides the full enclosure by s-1. No builtin zeta, Hurwitz, Gamma, RS or zero oracle is used.

The immutable parameters are N=333334, B=333335, M=32, Taylor length 24 (degree 23), finite-g outer radius 1, and 192-bit arithmetic for new models. Six accepted top coefficient models were imported through full rational endpoint enclosures. Exactly seven new models were built: six bottom models at the old real centers 5/8 through 15/8 in steps of 1/4, and one left model at `629/1250+i*(1000000-1/16)`.

The top/bottom target radius is 1/8; the left radius is 1/16. Each tested panel is contained in its fixed model's disk and in the actual slab. The actual EM bound applies on these panel points, whose real parts exceed 1/2. It is not claimed on the whole left model disk. The separate finite-g Taylor estimate does apply throughout that disk.

The uniform zetaF EM error is below `2^-38`. The conservative top/bottom Taylor error is `1/(7*2^21)`, and the left Taylor error is `1/(15*2^44)`. Coefficient and import rounding remain in the stored interval coefficients. Horner evaluation covers each entire segment; the complete polynomial-plus-error box is divided by the full nonzero s-1 box. The independent scalar/domain support and source adapter are pinned in the preparation and candidate.

## Whole-boundary certificate and exact minimum margin

There are six bottom panels rightwards, the analytic right side upwards, six top panels leftwards, and the left side downwards. The exact side lengths are 1871/1250 horizontally and 1/8 vertically. The first horizontal panels are clipped at 629/1250. The right edge uses the source-backed inequality `Re zeta(2+it)>1/4` and needs no numerical model.

Eleven panels use `Re(zeta)>0`. The first bottom panel, first top panel, and left side use `Re(-i*zeta)=Im(zeta)>0`. These are strict whole-panel inequalities, not sampled endpoint tests.

The smallest recorded lower margin, on the clipped top panel `t0`, is exactly

```
59497651057820038109888342225681522796535744544368568403
/392318858461667547739736838950479151006397215279002157056
```

and is strictly greater than `0.15165636261`. This is a lower bound in the selected signed-coordinate half-plane. It is not an assertion that every panel has positive real part or that this is the minimum actual modulus over the slab.

Shared rational image vertices are formed from the adjacent complex multipliers u,v as `conj(u)+conj(v)`, with both strict half-plane memberships checked. They are drawn from `2i`, `1+i`, and `2`, and need not approximate the true endpoint images. Their exact cyclic identity and half-plane memberships satisfy the reviewed polygon-transfer contract.

The fourteen crossing contributions are

`[0,-1,0,0,0,0,0,0,0,0,0,1,0,0]`.

Their exact sum is zero. Thus the packet gives both boundary nonvanishing and a zero winding, rather than merely a zero-free boundary with unknown interior count. All 14 visits were accepted at depth zero; no failed sufficient test or refinement occurred. The pending panel list is empty.

## Literal work and measurement limits

The receipt records:

| Category | Count |
| --- | ---: |
| New/imported models | 7 / 6 |
| Real logarithms | 333335 |
| Main Dirichlet-sum series exponentials | 2333338 |
| Other series exponentials | 14 |
| Bernoulli correction terms | 224 |
| Affine Pochhammer updates | 441 |
| Panel visits / numerical quotients | 14 / 13 |
| Horner multiplications / additions | 299 / 299 |
| Failed tests / model-reuse visits from refinement | 0 / 0 |

The 13 models retain 312 complex coefficient boxes, of which 168 were newly computed. A series exponential produces a truncated coefficient array; it is not equivalent in cost to a scalar exponential or a Fourier kernel node.

The internal elapsed time was `36.29981419999967` seconds and the recorded peak working set was `74,231,808` bytes. The timer includes numerical initialization, model construction, panel work and earlier checkpoints, but excludes interpreter startup, preliminary input/authentication checks and the final serialization after the recorded timestamp. This was one bounded run, not a controlled comparison or a production-rate estimate. The caps were 180 seconds, 512 MiB peak working set, 256 visits and depth 12; none was approached in this receipt.

**Actual frozen file size is 204,498 bytes.** The receipt's `output_bytes=200234` measures the LF UTF-8 payload before Windows newline translation, not the actual on-disk size. This non-scientific telemetry qualification was identified by static review before execution. The frozen code and receipt are preserved; scientific comparisons do not use this field.

## Consequence and acceptance boundary

Given the numerical enclosure claims and the reviewed analytic interfaces, the local zeta polygon has winding zero. The pinned source adapter transfers this to entire zetaF because `zetaF=(s-1)zeta` on a neighborhood of the slab and s-1 has a single analytic logarithm there, hence zero winding. The source rectangle argument principle then excludes all interior zeros with their actual analytic multiplicities; the panel inequalities exclude boundary zeros. No zero simplicity, RH, supplied zero list or assumed margin is used.

This author inspection verifies saved rational data and geometry. It does **not** independently establish that the new coefficient balls enclose the true finite-g coefficients or that every stored image encloses the actual function. A separately prepared all-thirteen-model evaluation with different EM/Taylor parameters is running under coordinator control. Its numerical review must be attached separately; it has not been replaced by this inspection or restarted here.

Any accepted result is limited to this final 1/8-high closed right slab. The source conjugation/reflection adapters can supply the corresponding local negative-height and left-side consequences. The remaining heights, other contours, shared nonprincipal family, analytic formalizations and Lean checker acceptance remain unproved by this packet. The old top count and other frozen evidence remain unchanged.
