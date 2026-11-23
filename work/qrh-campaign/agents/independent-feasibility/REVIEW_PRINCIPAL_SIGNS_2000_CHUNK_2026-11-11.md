# Independent complete replay of the principal sign chunk [1500,2000]

2026-11-11. **PASS as external interval evidence under the accepted EM, coarse phase, count, and multiplicity contracts.** Every one of the 449 retained points was independently evaluated. All claimed strict signs hold, with exact ordering and strict alternation. The 448 disjoint brackets match the independently accepted count difference `1517-1069=448`.

Consequently the accepted external evidence and reviewed analytic argument establish finite RH and simplicity on this chunk. Combined with the accepted low-height certificate, this extends that external conclusion through `|Im rho|<=2000`. This is not a Lean proof. The higher range `2000<|Im rho|<=1000000`, other characters, and all formal bridges remain open.

**Gabcke is only a discovery method for this accepted chunk.** The independent sign acceptance uses direct explicit Euler–Maclaurin and the previously reviewed coarse bound `|theta-theta0|<.347`, not the Gabcke correction, its analytic remainder, or its fine theta expansion. The separately frozen Gabcke pilot/source reviews retain their own scope; their unformalized analytic remainder need not enter this chunk's selected proof path.

## Frozen inputs and independent artifacts

Paths are relative to `work/`, unless explicitly prefixed otherwise.

| Artifact | SHA256 |
|---|---|
| `qrh-campaign/agents/mellin/PRINCIPAL_SIGNS_2000_CHUNK_2026-11-11.md` | `316D283D8E699E8914082298770AAF12E7528F19D079BEA8959FF3E9CAD82CB2` |
| `qrh-campaign/agents/mellin/principal_signs_2000_chunk_20261111.py` | `4DF68BA9028C9B59BA795E4D241ED9C5A77892AE732DFD1C3331F6ADED1477D4` |
| Same-stem discovery JSON | `D3BCD8C499033314B54E4F354EF3FAF074BC859F2F5888EF589B051BA3A4EA73` |
| `qrh-campaign/agents/prime-estimates/REVIEW_TOP_COUNT_2000_2026-11-11.md` | `C3CA2ABA8EDA4CE9158CB4BD22203DFBEEE0CEC145A54FC8F0D630346B3FC89D` |
| `qrh-blueprint/principal-chunk-2000/em_top_2000.json` | `477BD15B17326BCE7333346491BA820C98DB2FE2B07DBDB7A0D11278CD2AE252` |
| `qrh-campaign/agents/mellin/psi_head_counts_20261111_h1500.json` | `82AD7ACDFFBCAC24D190A98ACB78BF66471249D09BFE2C43051ADD2AAEC0D030` |
| `qrh-campaign/agents/audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md` | `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE` |
| `qrh-campaign/agents/mellin/principal_signs_1500_20261111.json` | `542346DEB342369A1D53601DC051AFADB39149DB34C6E7426C33AB4094BC8CF4` |

The seven code/data/prior-review hashes are checked by the new reviewer script. The producer note arrived afterward; I read it completely and checked its hash separately. Its review-pending wording was accurate at its freeze and remains unchanged; this later independent report supplies the acceptance verdict. New files under `qrh-campaign/agents/independent-feasibility/`:

| Artifact | SHA256 |
|---|---|
| `review_principal_signs_2000_chunk_20261111.py` | `A5A45E5CD677578D9CBE90024FC0713988DDC2D43B674DBE70A43FCF3C4F3404` |
| Same-stem JSON | `6216C00002C6F5FABAB40F8C1467926116CD58DB349DB15B4444E9571B8FBDDC` |

The single complete alternate run exited 0 with `PASS_ALL_449_ALTERNATE_EM_SIGNS_AND_GEOMETRY`, taking 1.00575 internal seconds. The receipt stores every rational point, every rational proxy interval and error enclosure, count endpoints, exact minimum margin, and pins. No producer module was imported or rerun. No full discovery scan, Lean build, new dependency, canonical edit, or frozen-file edit occurred. Timing concerns this external replay only.

## Independent numerical calculation

The reviewer uses 192-bit elementary Arb arithmetic and a direct zeta EM sum with fixed `B=800`, 799 Dirichlet-series terms, and `M=40`. The discovery used Gabcke K0 at 160 bits. In particular, the new evaluator does not consume the discovery's value intervals to determine a sign, and calls no builtin zeta, Gamma, Riemann–Siegel, Hardy, indexed-zero, zero-count, or historical-count function.

At `s=1/2+it` it evaluates

```
sum_(n=1)^(B-1) n^(-s)
  + B^(-s)*(B/(s-1)+1/2)
  + B^(-s)*sum_(k=1)^M c_(2k)*(s)_(2k-1)*B^(1-2k).
```

The exact rational coefficients `c_n=B_n/n!` are obtained as coefficients of the formal reciprocal of `(exp(z)-1)/z`, using

`c_0=1`, `c_n=-sum_(k=0)^(n-1) c_k/(n+1-k)!`.

The script checks `c_2=1/12`, `c_4=-1/720`, and the vanishing odd coefficients above degree one through the used range. This is independent of the discovery helper's Bernoulli-number recurrence. Positive real logarithms define all powers.

The direct zeta error bound is

```
4 * product_(j=0)^79 sqrt((j+1/2)^2+t^2)
  * B^(1/2-80) / (6^80*(80-1/2)).
```

This is the reviewed periodic-Bernoulli EM bound with `2*zeta(80)<4` and `2*pi>6`. The exponent `1-sigma-2M=-79.5` and denominator `sigma+2M-1=79.5` are correct. Because the expression directly evaluates zeta, no `|s-1|` multiplier belongs in this error. The error disk is enlarged to a Cartesian square before subsequent arithmetic. The pole denominator excludes zero throughout `t>=1500`.

Pi is independently enclosed by rational Machin arctangent sums, using 100 alternating terms each at `1/5` and `1/239` and exact next-term errors. The script uses that enclosure in

`theta0 = t*(log(t)-log(2)-log(pi)-1)/2 - pi/8`

and computes the real proxy

`V(t)=cos(theta0)*Re(zeta(1/2+it))-sin(theta0)*Im(zeta(1/2+it))`.

This avoids the Gabcke fine phase estimate and correction. The accepted analytic coarse phase/Hardy identity gives `V=Z*cos(theta-theta0)`, where Z is real and continuous and `|theta-theta0|<.347` for `t>=14`. The purely rational inequality

`1-(347/1000)^2/2 = 1879591/2000000 > .939`

certifies positivity of the cosine factor. Thus V and actual Z have the same signs and zeros. The phase bound and Hardy realness remain analytic proof contracts; a numerical imaginary-part test is not substituted for them.

Every one of the 449 computed proxy intervals is strictly on the requested side of zero. The minimum signed lower bound exceeds `.00315272147389642`, at index 432, `t=7927/4`. The largest EM error is below `5.567e-31`. Decimal values here are summaries; acceptance uses exact rational interval endpoints in the receipt.

## Geometry, complete count, and endpoint join

I checked the retained list has exactly 449 points, starts at 1500, ends at 2000, is strictly increasing, and lies on the quarter grid. The exact sign sequence is `(-1)^i`, so both endpoints are positive. Every original stored value interval also has its claimed strict sign, but agreement with those intervals is only an additional data-integrity check; acceptance is supplied by the independent EM signs.

These 448 open intervals between adjacent retained points are pairwise disjoint. Shared endpoints are certified nonzero. No minimum zero spacing, Gram's law, simple-zero assumption, or correctness of the omitted discovery samples is needed. I did not replay the other quarter-grid samples. The producer records 2001 discovered strict samples, 448 changes, and no fallback, unresolved point, or evaluation failure; those discovery-history details are not premises of the existence proof.

The count target is independently supplied by the already accepted head and top certificates. The script checks the pinned head endpoints `N(14)=0`, `N(1500)=1069`, then takes the ceiling of the rational lower endpoint and floor of the rational upper endpoint of the top count enclosure. Both equal 1517. It also checks that the top receipt has all six horizontal panels and seven endpoints and strictly positive real lower bounds on the panels. This is a structural/pin/count extraction check, not a second top contour replay; the accepted top review supplies the independent whole-panel replay and branch normalization.

Those contour counts count all nontrivial positive-ordinate zeros, with analytic multiplicity. The accepted head and top reviews also certify no zeros on the complete horizontal boundaries at 1500 and 2000, not just nonzero line samples. Thus their difference 448 is the complete multiplicity sum in `(1500,2000)` (equivalently `(1500,2000]` here).

Continuity and the intermediate value theorem give at least one critical-line zero in each of the 448 disjoint brackets. These are 448 distinct zeros, each contributing at least one to the complete multiplicity sum of 448. Equality leaves exactly one zero in each bracket, every multiplicity equal to one, and no other zero anywhere in this ordinate band. Simplicity and the absence of off-line zeros follow from this saturation; they are not assumed during discovery or replay.

The earlier accepted low certificate has 1070 points ending at the same `t=1500` with positive sign. The new script checks that endpoint and count identity explicitly. The common endpoint is nonzero, so concatenating the two lists while retaining that endpoint once gives 1518 points and 1517 brackets from 14 to 2000. The low certificate separately excludes the lower/real nontrivial zeros. Conjugation preserves zero multiplicities and supplies the negative-ordinate conclusion through 2000.

## Proof status

The evidence supports the complete finite conclusion through 2000 at the external-computation and reviewed paper-proof level. It introduces no historical finite-RH assumption or new final-theorem premise. It does not supply a completed proof-producing checker or Lean declaration. Required formal work includes EM and its remainder, rational/interval arithmetic soundness and exact replay, the coarse Binet/phase bound and Hardy realness, contour/count normalization, analytic multiplicity transport, intermediate-value existence, and multiplicity saturation.

Neither the old one-million top count nor these 449 signs establish the remaining high strip. No claim about `2000<|Im rho|<=1000000` follows from this review.
