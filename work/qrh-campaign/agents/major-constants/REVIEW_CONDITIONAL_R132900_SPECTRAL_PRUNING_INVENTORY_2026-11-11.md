# Independent review: conditional R132900 pruning inventory

2026-11-11. PASS for the conditional conductor inventory, exact operation counts, setup comparison and unchanged shared seed schedule. No author correction required. This does not establish finite RH, execute a transform, adopt the cutoff, or predict end-to-end runtime.

## Version and inherited proof

The reviewed author report is `zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md`, SHA256 `7AA9BF4D456CE25685D69427966DC7F61D0914DD091A95B74F9C242B95CADB27`. Its script has SHA256 `074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D`; its JSON receipt has SHA256 `E94D87827C3A4D37CA34F07001F16EA7AEE8854684F8BC156C3D4AC6D96B65CF`. All match the inspected files.

I read the complete report and script. The mathematical primitive-output circuit is unchanged from the previously reviewed report `CB4085D00AED0BFDA9ADC1BB7306DB24EF052502C99F30D45E15AEF6EEC3F8B8`, independently reviewed in `REVIEW_PRIMITIVE_OUTPUT_PRUNING_EFFICIENCY_2026-11-11.md`, SHA256 `A8B844581DC6E1D562B575A5973246F8C5ACBF06A47880FFA697A524AE36343D`. That review supplies the conductor-kernel restriction, inverse-label closure, CT dependency proof, preserved full Bluestein inverse, normalization, and rounding-subgraph qualifications. No new character restriction is introduced here.

The separate conditional analytic cutoff uses `prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md` (`429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D`) and my review (`0B224BB58D88D63D9F787D88CA1CB33CA85C411DB8B733307064AE8D82EA84BD`). The inventory is not additional evidence for its spectral premises.

## Domain, heights and labels

The loop selects precisely odd c with 3<=c<=132900, and multiples of 4 with c<=265800. These sets are disjoint. Their cardinalities are 66449 and 66450, hence 132899. Conductor one and conductors with exact two-adic valuation one are not accidentally included. The c<=10000 subset is unchanged.

For even c, comparison of 100000000/c and 200+75000000/c gives the transition at c=125000 exactly. The script's height numerator is therefore correct, including equality. For odd c it remains 100000000. Integer division computes

    J(c) = ceil(64 H(c)/5)+1

without real rounding. The last grid point may exceed H(c), as in the predecessor; the report does not identify this nominal grid with successful sign-test coverage.

I independently reconstructed phi(c), the product of local primitive counts, and the actual local restricted axes. The two primitive totals are 4351723951 for the full domain and 4333246843 for c>10000. The small branch still has 7499 conductors and 18477108 primitive labels. Thus the removed conductors are the only source of reduced label obligations. No inverse label, sign coordinate, central-zero convention or primitive output is additionally removed.

## Independent counts and setup

The owned script `review_r132900_pruning_inventory_20261111.py` reconstructs a linear smallest-prime-factor sieve, all full and restricted circuits, both axis orders, whole-axis comparison, conductor multiplicities, height weights and setup unions. It does not import or execute the author script. It reuses the independently written recurrence code from my preceding review and reads the author receipt only for comparison.

Every all/large/small row, every example, both sets of ratio brackets and every setup field matched. It checked 12781 recursive requests, 12523 top-level restrictions and 210 finite inverse/index/CT identities. The general circuit proof remains the inherited proof, not a claim inferred from these finite tests.

For c>10000 the independently reconstructed central counts are:

| Circuit | General complex products | Complex additions/subtractions |
|---|---:|---:|
| Whole-axis | 4177915060902296 | 9791843685676132 |
| Full mixed | 2607460638032558 | 5400371016768720 |
| Fixed-original-order pruning | 1849018578634950 | 3808420069398260 |
| Optimized-order pruning | 1847683359499690 | 3796803390649934 |
| Optimized order, filtering only between axes | 1851503934864292 | 3849917737815492 |

The fixed-order G/full ratio lies in [.709126,.709127]; the optimized ratio lies in [.708614,.708615]. All five operation categories were reconstructed, not only G/A. The ratio denominators are the correct baseline for each comparison.

Setup traversal follows only nodes of selected full circuits; rejected candidate subtrees are not accidentally cached. The whole-axis union has 12496 original lengths and 12480 Bluestein kernels; the selected mixed union has 32942 active lengths and 6004 kernels. Kernel entries, chirp entries, CT table upper bound and the single forward-transform setup costs match. This is a union count, not concurrent memory. Pruning claims no additional setup saving.

## Shared seed grid and scope

The large-branch residue-height count is 99513098256768. Every such input remains required. All grids are prefixes of the common j*5/64 grid. Conductor 10001 remains and attains J=127989; all other large-branch conductors have no greater J. Consequently the shared union still ends at j=127988, height 9999.0625.

I checked the unchanged P24 band schedule in `zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md`, SHA256 `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC`, sections 2 and 4. The successive closed upper heights 500,1000,2000,5000,10000 use D=512,1024,2048,4096,8192. Assigning boundary grid points to the first containing band gives respectively 6401,6400,12800,38400,63988 heights. The exact sum of 24(D+1) times those counts is 17223585528 coefficient slots. This is unchanged reuse of one schedule, not a universal lower bound on optimized seed generation. The separate P20 or shifted-jet proposals are not imported.

Original-order pruning inherits peak and fractional-error bounds only under the existing identical-gate refinement contract. Reordering retains the permutation-invariant fractional-error argument but still requires a new prefix-dependent peak-width analysis. The author preserves that distinction. No bit-cost advantage is inferred from the optimized-order ratio.

## Owned artifacts and limitations

Independent script SHA256: `1F8BE2FA285957A55A4E4D97FE092FB1A7BB1AB03F1A2C9A3E202D50CE7146DE`.

Independent receipt `review_r132900_pruning_inventory_20261111.json` SHA256: `838786B25544F60F195414076D99FD86FC55118E760486219832D4DA1C3FF365`.

The successful check evaluated only integer/rational metadata. No Fourier, character, root, analytic-function or prime values were generated. No Lean build occurred, and no frozen author artifact was changed. Analytic localization, coefficient enclosures, actual retained-gate certificates, auxiliary ranges, successful signs, completeness and the final proof implementation remain separate obligations.
