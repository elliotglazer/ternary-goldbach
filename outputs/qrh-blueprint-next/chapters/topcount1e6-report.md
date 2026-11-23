# External principal top-path count at height one million

2026-11-11. Bounded external interval computation only. No Lean build, canonical change, frozen-report edit, vertical million-height contour, zero enumeration, indexed-zero routine, `nzeros`, or `backlund_s` call. Independent review is required before acceptance. FLINT's zeta point enclosures and elementary interval arithmetic remain external dependencies; no formal RS proof is claimed.

## Result

At the unchanged endpoint `T=1000000`, the six proposed quarter-unit blocks all certify the complete horizontal path from `2+iT` to `1/2+iT`. Each whole block lies in the strict right half-plane under zeta; no subdivision or endpoint change was needed. The smallest certified real lower endpoint among the six panel images is greater than .07608.

The continuous argument calculation gives

`S(T) in [0.4913678844069175813986793384168674481 +/- 3.33e-38]`.

This displayed decimal is informational; the data store exact rational interval endpoints. Combining it with the elementary main term F and the reviewed Binet allowance gives an exact interval I with

`1747145.87 < inf I <= N(T) <= sup I < 1747146.13`,
`ceil(inf I)=floor(sup I)=1747146`.

Thus the external certificate yields the total positive-ordinate multiplicity count `N(1000000)=1747146`, conditional only on the stated analytic and external interval-evaluator soundness contracts. This is not a Lean count theorem. It proves neither finite RH nor the remaining narrow strip, and supplies no sign-change intervals.

## Reproducible files and scope

All files are in `agents/integration/`:

| File | SHA256 |
|---|---|
| `principal_top_count_20261111.py` | `323EF8E439DB952972A81D11BD4216A56F27D8F93E665AD482AB328AB0E9846A` |
| `principal_top_count_20261111.json` | `452E2D603602DA6FB05558F79F8451FF1E9AC26031F54E30A0B9A349CB3C2B2A` |

The JSON is363249 bytes. It records all384 complex sample enclosures, all384 model-coefficient enclosures, six whole-panel boxes, seven shared actual endpoint balls, every argument increment, the exact F/S/count intervals, and exact ceil/floor results. Every real interval uses two exact rational bounds rather than rounded display strings.

The guiding design is `mellin/PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md`, read at SHA256 `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C`. Its separate analytic review was still in progress at this task's start; this computation does not itself complete that review. The frozen height14/head/provider reports are unchanged.

Reproduction, from the workspace root:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/integration/principal_top_count_20261111.py --replay
```

`--replay` recomputes all point values, coefficients, panel bounds and argument intervals, and requires exact equality with the stored certificate section. It writes nothing. This completed with exit0 and `PASS_EXTERNAL_REGENERATED_CERTIFICATE_MATCH`. Running without `--replay` constructs the owned JSON anew, including new timing metadata; it is not needed to check the frozen data.

The recorded construction used Python3.14.7 on Windows11 with128-bit FLINT interval precision. It made384 model sample calls and7 endpoint calls,391 zeta calls total. Construction before JSON serialization took .54133 seconds wall and .53125 seconds process CPU in the final saved run; complete console invocation reported about .629 seconds. These are measurements for this short path only, not a forecast for a sign search or family computation.

## Uniform whole-panel enclosure

The block centers, in descending real part, are `15/8,13/8,11/8,9/8,7/8,5/8`, each at imaginary part T. Set outer radius R=1/2, sample radius rho=1/4, target radius r=1/8, and m=64. Each closed target disk contains its horizontal quarter-unit segment. Every outer disk has real part at least1/8, norm at most T+3, and distance from1 at least T−1/2.

The existing source `Explicit/ZetaGrowth.lean:177`, `norm_zetaF_le`, and `zetaF_of_ne` give

`|zeta(s)| <= |s|/|s-1| + |s|/Re(s)`.

All outer disks are far from the pole, and `(T+3)/(T−1/2)<2`. Therefore the common bound `M=8*(T+3)+2=8000026` is valid throughout each outer disk. This uses the existing elementary source growth estimate, not the new Rademacher proposal.

For roots `omega_j=exp(2*pi*i*j/64)`, the interval samples enclose `zeta(c+rho*omega_j)`. The direct discrete Fourier sum encloses

`b_k=(1/64)*sum_j zeta(c+rho*omega_j)*omega_j^(-k)`.

The model is `P(s)=sum_(k<64) b_k*((s-c)/rho)^k`. Cauchy's coefficient bound and roots-of-unity orthogonality give the uniform alias-plus-truncation error

`M/(1-r/R)*[(r/R)^64 + (rho/R)^64/(1-(rho/R)^64)]`,

whose stored upper endpoint is below `5.783e-13`. Each finite interval polynomial is evaluated over the whole real panel by Horner arithmetic; a coordinate square containing this error disk is then added. Sample, root, coefficient and arithmetic uncertainty remain in the interval model. No midpoint-only nonvanishing test is used. The discrete-Cauchy wrapper still requires its analytic proof and arithmetic replay inside Lean.

## Actual endpoint balls and continuous argument

The exact rational endpoints are shared across neighboring blocks and evaluated once each. Every panel test checks both its full image and its two actual endpoint balls in the chosen rotated open right half-plane. The implementation supports the rotations1,−1,i,−i, but this data set selected rotation1 on every panel.

Initialization uses the analytic Dirichlet-series inequality `Re zeta(2+iu)>=2−zeta(2)>1/4` for every real u. Starting from positive zeta(2), the continuous argument along the entire vertical segment is therefore its principal argument at the endpoint. The stored actual value ball at `2+iT` has real part strictly greater than1/4. No sampling of the vertical segment is needed or performed.

For each oriented panel s_right to s_left, the increment is

`Im(Log(rotation*zeta(s_left))−Log(rotation*zeta(s_right)))`.

The principal logarithm is continuous on the rotated right half-plane containing the entire panel. Hence this difference is the actual continuous increment, with no missing multiple of2*pi. The initial vertical argument plus these increments, divided by pi, gives the S interval. Exact endpoint sharing makes neighboring increments compatible. Since all panels happen to use the same half-plane, this particular path also admits the simpler telescoping check; the program did not infer branch consistency from endpoint values alone.

The panel nonvanishing includes the critical-line endpoint and all real parts between1/2 and2 at ordinate T. The zeta functional equation and conjugation reflect any remaining nontrivial zero at this ordinate into this segment. Thus no zero lies at the counting height, and the closed positive-ordinate count agrees with the argument-principle convention. This carrier/reflection step remains part of the future formal proof.

## Exact integer extraction and remaining obligations

The computation uses

`F(T)=T/(2*pi)*(log(T/(2*pi))−1)+7/8`,
`N(T)=1+theta(T)/pi+S(T)`,
`|1+theta(T)/pi−F(T)|<1/8`.

The normalized counting identity and Binet bound are the separate analytic inputs from the reviewed count construction and current completeness-route design. The program evaluates only elementary F, the newly propagated S, and the symmetric allowance1/8. It never evaluates Gamma or theta directly, calibrates against the head count, calls a count helper, or rounds the midpoint to the nearest integer. Exact rational ceil/floor of the stored interval are equal. The actual enclosure is

```text
[283490626192642055771359059207506452119 / 162259276829213363391578010288128,
 283490666757461414190427358930655862423 / 162259276829213363391578010288128].
```

Independent review must check the growth/model hypotheses, complete geometry, actual endpoint compatibility, branch increments, integer extraction and exact analytic count normalization. A different-parameter point/model replay would strengthen the external evidence. Eventual Lean use additionally requires the RS point evaluator's analytic remainder and numerical primitive contracts, interval arithmetic, discrete-Cauchy enclosure soundness, normalized count identity, and multiplicity/closed-height transport. This result supplies the missing short external top-count computation; it does not supply the1747146 disjoint sign-change intervals required by the stronger completeness route.
