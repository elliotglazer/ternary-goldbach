# Independent review of the top count at height 2000

2026-11-11. **PASS as external interval evidence conditional on the reviewed analytic EM, Cauchy, branch and count contracts.** No mathematical defect was found. This is not a Lean proof, a new allowed hypothesis, or evidence about the unfinished higher spectral range.

## Frozen inputs and independent artifacts

Root directory `work/qrh-blueprint/principal-chunk-2000`:

| Input | SHA256 |
| --- | --- |
| `TOP_COUNT_2000_2026-11-11.md` | `FE551A7B6B8C58C5E0394675AB63F694B16516B63570CD6FCA9D2CDB40665A25` |
| `em_top_2000.py` | `29FD53BC084FC38C3033E6C8D9E7DDB63E1AF0D96A8789216EC069AA7D75F6CF` |
| `em_top_2000.json` | `477BD15B17326BCE7333346491BA820C98DB2FE2B07DBDB7A0D11278CD2AE252` |

New files in this review's directory:

| Artifact | SHA256 |
| --- | --- |
| `review_top_count_2000_20261111.py` | `C8EBA16F90F5739AB87FD09538B05FBDB8D5280E18891460C6C007E77483B99B` |
| `review_top_count_2000_20261111.json` | `B74E93664D1EC77214E97F18128DA091F2A42E1C50C47E7F681AE401FB213F0B` |

The clean final run exited 0 and returned `PASS_ALL_SIX_INDEPENDENT_EM_MODELS`. Internal elapsed time was about .108 seconds; this records only this external calculation, not a formal replay prediction. A preceding output-truncated invocation caused a stdout flush exception; the final run captured the complete log and exited cleanly.

## Independence and calculation

The implementation adapts the previously independent `independent-feasibility/review_em_top_horizontal_20261111.py`, SHA `CD6C4E02FA2CB3F3D8F24EDA9B41C038466764C442E55C7997E6608DF9BC4A1E`. This shared code ancestry is explicit. No producer module is imported. The source comparison confirms that the new producer changes only the old executable height from one million to 2000, plus its opening description.

The reviewer uses N=601, B=602, M=36, K=26, Cauchy radius 3/4 and precision 160 bits; the producer uses N=667, B=668, M=32, K=24, radius 1 and 128 bits. Both use actual halfwidth 1/8. Exponential coefficients are formed manually as `a_0=exp(-c log n)` and `a_j=a_(j-1)(-log n)/j`, not by series exponentiation. Finite series multiplication remains external interval arithmetic. The pole-removal exponential is independently written as B times the B-exponential jet.

All six complete closed panels cover [1/2,2] without gaps. Their real lower endpoints exceed respectively .41779, .50792, .53942, .60200, .66557 and .72369. All seven endpoint images have positive real part. Shared endpoints overlap and every endpoint overlaps its producer enclosure. The right endpoint exceeds 1/4. These overlaps are consistency diagnostics: they do not prove that every producer coefficient box is sound. The review's own complete enclosures establish the numerical positivity evidence independently under the same analytic remainder contracts.

The outer-circle estimate bounds the finite entire function g only. Cauchy gives its Taylor tail; the separate EM error is imposed on actual panel points, whose real parts are at least 1/2. Each error is a norm bound enlarged into both coordinate directions, before division by s-1. The whole denominator box has imaginary part 2000 and excludes zero. No EM assertion on the outer disk is needed.

The final argument/main-term calculation uses exact fractions: Machin arctangent series (32 and 12 terms), 40-term alternating arctangent with an addition shift at 1/2, and 40-term atanh logarithm bounds. This differs from the producer's native elementary logarithm extraction. It imports no builtin zeta, Gamma, Riemann-Siegel, indexed zero or count routine. The exact outward 25-decimal count enclosure is

```
[1516.8749966842719705599382719,
 1517.1249966842719705690157337].
```

Its lower ceiling and upper floor both equal 1517. The integer is extracted before comparison with the producer receipt; interval width alone is not used as an integer-existence argument.

## Analytic joins and scope

`mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md`, sections 3–4, supplies the normalized paper contracts `N(T)=1+theta(T)/pi+S(T)` at a nonzero ordinate and `|1+theta(T)/pi-F(T)|<1/8` for T>=1500. Height 2000 meets that threshold. The +1 is the contour normalization, not calibration against a known zero count.

Along the canonical vertical path at real part 2, the Dirichlet-series bound keeps zeta in the right half-plane. Whole horizontal positivity continues that same branch to 1/2+2000i, so the endpoint's principal argument is the required continuous argument. Endpoint positivity alone would not justify this step. Functional reflection, with its nonzero factors on the open strip, excludes zeros on the other half of the top boundary. These are the previously reviewed analytic contracts, still requiring formal implementation.

The accepted external head count is N(1500)=1069; `audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md` also records nonzero top boundary and multiplicity conventions. Therefore 1517−1069=448 counts positive-ordinate nontrivial zeros in (1500,2000], with their analytic multiplicities. A future strictly increasing chain of 449 certified nonzero, alternating actual Hardy-Z samples with endpoints 1500 and 2000 gives 448 distinct critical-line zeros. Equality with the complete multiplicity count then proves all are simple and no off-line or extra zeros remain in that chunk. This review does not produce that sign chain.

No frozen input, canonical source, dependency, or Lean declaration was changed. Finite coefficient semantics, elementary interval soundness, EM and Taylor remainder theorems, branch/count normalization, and multiplicity transport remain formal proof obligations.
