# Conditional R132900 spectral circuit inventory

2026-11-11. Exact integer schedule metadata only. No character, root, FFT, L-function, zero or prime evaluation, and no build. All predecessor artifacts remain unchanged.

For the large-conductor branch, fixed-original-order primitive pruning uses between .709126 and .709127 of the full mixed-radix circuit's general complex products. Optimized axis ordering uses between .708614 and .708615. These are distinct circuits: only the former inherits the existing fixed-order peak-width bound directly. Neither ratio is a runtime ratio.

## 1. Domain and unchanged inputs

The conditional domain contains odd conductors 3 <= c <= 132900 and conductors 4 | c <= 265800. Conductor one is separate. It has 132899 nonprincipal conductors and exactly 4351723951 primitive character labels. The source-mass cutoff paper and review below supply the separate conditional analytic interpretation; this inventory does not prove finite RH or adopt a new spectral premise.

Retain the old heights: H(c)=100000000/c for odd c, and H(c)=max(100000000/c,200+75000000/c) for even c. The common coarse height grid has J(c)=ceil(64H(c)/5)+1 nodes, including the possible last node beyond H(c). It is the same grid as in the frozen R138000 inventory. Heights, seed inputs, primitive predicates and inverse-character coverage are unchanged except for removing conductors outside this smaller domain.

The primary transform comparison is c>10000. The c<=10000 branch is unchanged and retains its separate algorithmic treatment. The all-conductor circuit totals below are the same schedule's metadata extension to that branch, not a claim that replacing its evaluator is advantageous.

| Quantity | All nonprincipal conductors | c>10000 |
|---|---:|---:|
| Conductors | 132899 | 125400 |
| Primitive character labels | 4351723951 | 4333246843 |
| Sum of unit-group sizes | 7158345954 | 7133015232 |
| Coarse residue-height inputs, sum phi(c) J(c) | 105996466892478 | 99513098256768 |
| Coarse primitive outputs, sum n_prim(c) J(c) | 70901831171273 | 66172730256514 |
| Sum J(c) | 10851352539 | 2735223455 |
| Maximum J(c) | 426666668 | 127989 |

The unchanged small branch has 7499 conductors and 18477108 primitive labels. The script checks its full mixed operation totals and label total against the frozen R138000 receipt.

## 2. Exact circuit comparison

Use the five categories from the reviewed mixed-radix schedule: G general complex products; A complex additions/subtractions; Q quarter turns; N negations; S dyadic scales. Counts include every coarse grid node and every required output, not interpolated signs. They do not include Hurwitz seed construction, residue contractions, general elementary-function certificates, precision-dependent limb costs, Turing certification, or exceptional repairs.

Whole-axis means radix two for power-of-two axes and Bluestein for every other axis. Full mixed uses the frozen direct-small-prime/Cooley--Tukey/Bluestein selection. Fixed-order pruning keeps that circuit's original axis order. Optimized-order pruning orders axes by the proven G/deficit comparison, with its declared tie rule. The optional between-axes row uses that optimized order but computes each surviving line's full one-dimensional transform before filtering.

All c>10000 totals are exact:

| Circuit | G | A | Q | N | S |
|---|---:|---:|---:|---:|---:|
| Whole-axis baseline | 4177915060902296 | 9791843685676132 | 507082061846612 | 2593032081628 | 498143940781504 |
| Full mixed | 2607460638032558 | 5400371016768720 | 240054302964318 | 57789691484 | 232751136096768 |
| Fixed-original-order pruning | 1849018578634950 | 3808420069398260 | 168298416860166 | 36476401602 | 163078435471936 |
| Optimized-order pruning | 1847683359499690 | 3796803390649934 | 168236872075977 | 36434539750 | 163045183990656 |
| Optimized order, filtering only between axes | 1851503934864292 | 3849917737815492 | 169007020652139 | 39250570800 | 163049057400832 |

Outward decimal brackets, obtained by integer floor/ceiling at six decimal places:

| Circuit | G / full mixed | A / full mixed | G / whole-axis | A / whole-axis |
|---|---|---|---|---|
| Full mixed | 1 | 1 | [.624105,.624106] | [.551517,.551518] |
| Fixed-original-order pruning | [.709126,.709127] | [.705214,.705215] | [.442569,.442570] | [.388937,.388938] |
| Optimized-order pruning | [.708614,.708615] | [.703063,.703064] | [.442250,.442251] | [.387751,.387752] |

Thus the approximately 29.09% fixed-order G saving and 29.14% optimized-order G saving are relative to full mixed, not to the whole-axis baseline. The extra ordering gain is small here and must not be credited to the fixed-order circuit. Primitive-label ratios are not used as operation-saving ratios.

For completeness, all-conductor totals under the same circuit schedule are:

| Circuit | G | A | Q | N | S |
|---|---:|---:|---:|---:|---:|
| Whole-axis baseline | 4378998593151538 | 10273983576331982 | 535460879511746 | 2762002272202 | 526026905970400 |
| Full mixed | 2723561559319894 | 5637292564035782 | 251314378062644 | 60634924224 | 243599872671552 |
| Fixed-original-order pruning | 1941557922157446 | 3996039694160357 | 177248423464234 | 38585884732 | 171721172292160 |
| Optimized-order pruning | 1940137684651640 | 3983990254975193 | 177188075124068 | 38544022880 | 171685764454592 |

## 3. Why the restricted schedule is the same mathematical transform

The parent pruning proof applies without change. At an odd prime p retain k!=0 on the p-1 axis; at p^e with e>=2 retain p not dividing k on the (p-1)p^(e-1) axis. At conductor4 retain the nontrivial sign index. At 2^e with e>=3 retain both sign indices and odd indices on the power-of-five axis. Their Cartesian product is the actual primitive-character set by the source conductor-kernel proof. Each set is closed under k -> -k. No inverse partner, real character, negative-ordinate obligation, or central-zero obligation is silently removed.

For n=rm the positive transform writes j=a+rb and k=v+mu. A requested output set retains V={k mod m} in the first transforms and U_v={floor(k/m): k mod m=v} in each second transform. Every retained gate retains all its dependencies. Direct sum chains retain their original arithmetic order; Bluestein leaves keep their full padded forward/inverse transforms and pointwise products, deleting only unused final chirp outputs. Filtering after an outer tensor axis removes only prefixes absent from every requested output.

For fixed original order, this is a dependency-closed subgraph of the chosen full mixed circuit. With identical input/coefficient enclosures, arithmetic formulas and rounding rules at every retained gate, induction in topological order gives identical stored values at retained gates. Therefore the existing conservative full-circuit error and peak bounds remain valid; this inventory introduces no extra precision assumption. Normalization still uses the full original axis sizes, hence overall phi(c), never the number of retained labels.

Optimized outer-axis order has a different full reference circuit. Its conservative fractional-error composition transfers by the symmetric product of per-axis bounds. The old fixed-order integer-width bound does not automatically transfer because intermediate prefix lengths change. This report leaves that peak-width comparison separate and makes no same-total-bit-width or wall-time claim for the optimized row.

## 4. Setup, caches and unchanged seed floor

The following counts are for the union of large-branch axis lengths, shared across conductors. Kernel entries are the sum of padded lengths for distinct cached Bluestein kernels; they are not simultaneous-RAM requirements. Chirp entries use the same per-kernel length convention as the parent inventory. The CT root count is a conservative full-table upper bound, not a minimal set of distinct algebraic roots.

| Quantity | Whole-axis | Full mixed, also retained for both pruning variants |
|---|---:|---:|
| Distinct original axis lengths | 12496 | 12496 |
| Active recursive node lengths | 12496 | 32942 |
| Distinct Bluestein kernels | 12480 | 6004 |
| Cached kernel entries | 2127173008 | 337702368 |
| Chirp entries | 784839302 | 140276846 |
| Maximum padded length | 524288 | 262144 |
| CT full-root-table entry upper bound | 0 | 1116142487 |
| Kernel forward-FFT G | 15621796520 | 2244782056 |
| Kernel forward-FFT A | 37625062144 | 5502647200 |
| Kernel forward-FFT Q | 1063574024 | 168845180 |

Kernel forward-FFT N and S are zero under this convention. Setup appears once here, separately from per-height transforms. Pruning receives no further setup saving. Certified kernel errors, precision, root construction and storage policy remain required implementation inputs.

All 99513098256768 large-branch residue-height contractions remain. The common shared-height union still reaches J=127989 because conductor10001 remains. Thus the existing selected P24 seed floor of 17223585528 coefficient slots remains under that unchanged schedule. This report neither substitutes the separately proposed P20/shifted-jet schedule nor treats a removed character output as a removed Hurwitz input.

## 5. Reproduction and evidence scope

Run from the repository root:

```powershell
& 'work/qrh-campaign/interval-env/Scripts/python.exe' 'work/qrh-campaign/agents/zero-sum/conditional_r132900_pruning_inventory_20261111.py'
```

The completed run returned `PASS_CONDITIONAL_R132900_PRUNING_INVENTORY`. It uses integers and exact fractions only. It recomputes conductor factorizations, local primitive restrictions, full/partial recursive circuit costs, outer-stage line multiplicities and setup unions. It asserts the independently supplied primitive total, unchanged small-branch totals, cost domination and 133 small finite-index/inverse-closure checks. These checks support the inventory and do not replace the general dependency proof. No actual Fourier output or spectral certificate is generated.

The analytic cutoff, finite-RH truth, sign success, Turing/closed-height completeness, elementary leaf certificates and end-to-end proof checker remain separate. The output is suitable for comparing operation categories on one fixed conditional domain, not for multiplying a historical runtime by a single ratio.

## 6. Frozen inputs and output pins

Paths below are relative to `work/qrh-campaign/agents`. SHA256 values bind the exact source artifacts used here.

| Artifact | SHA256 |
|---|---|
| prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md | 429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D |
| major-constants/REVIEW_EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md | 0B224BB58D88D63D9F787D88CA1CB33CA85C411DB8B733307064AE8D82EA84BD |
| zero-sum/PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md | CB4085D00AED0BFDA9ADC1BB7306DB24EF052502C99F30D45E15AEF6EEC3F8B8 |
| major-constants/REVIEW_PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md | A8B844581DC6E1D562B575A5973246F8C5ACBF06A47880FFA697A524AE36343D |
| zero-sum/primitive_output_pruning_inventory_20261111.py | EFA92DB65FC1419243CF9A6FF1DE063E19718E5AE4ADCB297D195B34D25F41D5 |
| zero-sum/conditional_r138000_mixed_inventory_20261111.json | 0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F |
| zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md | 4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4 |
| audit/REVIEW_MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md | 1268986720865E47569FC5E568546194C0A61EDC9AE80CDD78502CDC77385537 |
| zero-sum/conditional_r132900_pruning_inventory_20261111.py | 074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D |
| zero-sum/conditional_r132900_pruning_inventory_20261111.json | E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF |
