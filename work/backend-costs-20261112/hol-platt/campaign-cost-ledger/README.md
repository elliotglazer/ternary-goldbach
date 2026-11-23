# Campaign cost ledger for the guarded small-family sign route

Platt's historical comparison is 400,000 core-hours. Twice that figure is 800,000. The existing shortened-schedule subtotal is 628,472.026–629,001.383 projected core-hours, leaving 170,998.617–171,527.974 before any additional work. This ledger examines an explicit downstream route for every small-family raw sample. It keeps that previous subtotal fixed when varying the guard; changes to the cost of upstream guard generation are additional. The historical and proposed campaigns differ in domain, hardware and formal checking.

## Exact populations

The selected small-family manifest has 7,499 conductors and 18,477,108 primitive labels. For each scenario, sum φ_primitive(c) times (last coarse index + 1) over conductors. The four-channel measured layout had two 128-sample interpolation halos per label. Repeating this layout would add 4,730,139,648 sample occurrences in each scenario. These are layout-dependent extras. The large-family counts independently include the existing +41 prefix guard in each case.

| Extra coarse nodes | Small coarse samples | Small samples with modeled halos | Large conductor/height pairs | Large residue inputs | Large primitive outputs |
|---:|---:|---:|---:|---:|---:|
| 0 | 1,775,431,871,117 | 1,780,162,010,765 | 1,528,006,797 | 60,254,515,577,760 | 36,468,561,640,066 |
| 167 | 1,778,517,548,153 | 1,783,247,687,801 | 1,548,948,597 | 61,445,729,121,504 | 37,192,213,862,847 |
| 320 | 1,781,344,545,677 | 1,786,074,685,325 | 1,568,134,797 | 62,537,080,452,000 | 37,855,200,629,826 |
| 640 | 1,787,257,220,237 | 1,791,987,359,885 | 1,608,262,797 | 64,819,645,326,240 | 39,241,839,619,586 |

At spacing 5/64 these additional nodes represent 0, 835/64, 25 and 50 height units. The 50-unit theorem only exercised four labels. Changing a row's sample count does not prove that a different guard length suffices for completeness.

## Two explicit interfaces

On the same four conductor-10000 channels, one HOL worker checked raw→compressed projection on 340,484 sample occurrences in 51.291886 CPU seconds, including 25.787085 seconds to construct numerals and 23.961195 seconds for checking. It rejected all eight deliberately altered heads. The second measurement read compressed samples and checked regular sign bits plus the bundled 114 repair-interpolation evaluations in 66.614640 CPU seconds. These input domains and outputs meet, so their timed **inner** phases may be added for this explicit two-interface implementation. Neither process startup nor every count-theorem premise is thereby priced.

| Extra nodes | Projection hours | Compressed join hours | Remaining to 800,000 after both |
|---:|---:|---:|---:|
| 0 | 74,492 | 96,745 | −239 to +291 |
| 167 | 74,621 | 96,913 | −535 to −6 |
| 320 | 74,739 | 97,067 | −807 to −278 |
| 640 | 74,987 | 97,388 | −1,376 to −847 |

At +640 their conditional sum is 172,374.721 hours. The resulting partial subtotal is 800,846.747–801,376.104. The 629k baseline already includes its time-product, source and Gaussian recurrence components. New estimates for those stages are replacements unless the exact superseded rows are removed. The figures above are sensitivities from one conductor; the small overshoot relative to the modeled total has no statistical or completion significance.

## Alternatives and omissions

At +640, if fusion removed only the measured raw-projection numeral-build segment and every remaining measured cost persisted, the remaining allowance would be 36,324–36,853 hours. Pricing only the two measured evaluation/check segments, assuming all other inputs and interfaces were supplied at zero marginal cost, would leave 124,035–124,564 hours. Neither fusion model has run end to end. A witness-only scheme that proves fewer endpoints is another circuit and requires its own measured population and throughput. No witness-only savings have been subtracted.

The earlier bit-packet count and targeted-dot experiment supplies an alternative model based on four or six edge probes per label and the observed interior repair density. Its separate sparse-dot time overlaps the 114 repair checks folded into the compressed-grid route. Its whole-process and inner-phase prices are alternatives; process prices include initialization. Its independent numerical discovery could be charged if absent from the selected subtotal and needed by the deployed producer. Its bracket-count arithmetic can be added only after excluding the identical bit tests, count scans or parent-theorem applications already included in the chosen path. ledger.json retains these categories separately and never adds the whole alternative row on top of the compressed-grid projection.

Shared kernel-table construction, later theorem assembly, principal and large-family closure, off-sample or failed repairs, gamma-phase analytic bounds, raw Gaussian certification, external I/O and future proof handling require explicit ownership and pricing. Four successful character counts do not establish their campaign incidence. The JSON contains SHA256 pins for every population, baseline and timing source. ledger.py reconstructs the populations, checks the +640 independent fold, and reports every budget alternative relative to the same 800,000-hour comparator.
