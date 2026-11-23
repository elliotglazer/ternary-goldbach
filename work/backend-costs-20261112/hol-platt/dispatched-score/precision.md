# Precision of projected Hurwitz amplitudes

For an integer projection `(v,d)` at precision `p`, the true completed real amplitude belongs to `2^(-3p)[v-d,v+d]`. When `abs(v)>d`, the archived enclosure certifies relative error at most `d/(abs(v)-d)`. The guaranteed bits below are the floor of the base-two logarithm of its reciprocal. An enclosure meeting zero gives no relative guarantee. Multiplication by a known positive scale preserves this ratio. Uncertainty in a computed scale must be propagated separately.

| Conductor, coarse index | p | Unique modes | Scores meeting zero | 1st / median / 99th percentile bits | Below 8 / 12 / 16 guaranteed bits |
|---|---:|---:|---:|---:|---:|
| 10004, 1 | 81 | 2,301 | 0 | 67 / 73 / 76 | 0 / 0 / 0 |
| 131071, 5695 | 24 | 131,069 | 84 | 3 / 10 / 14 | 20,203 / 110,533 / 131,068 |
| 131071, 5695 | 28 | 131,069 | 10 | 7 / 14 / 18 | 1,379 / 20,136 / 110,523 |

The worst strict p81 row is frequency `(10,24)` with 63 guaranteed bits. For q131071, mode 43541 has the greatest radius relative to the center at both precisions and both enclosures meet zero. Among strict scores the worst relative guarantees are −8 bits at p24 and −3 bits at p28. A strict sign may coexist with poor relative precision. The full postchirp reconstruction matched all 2,688 archived tile instances and each strict sign matched its independent reference. The original quadrant or sector detector may certify an additional sign. [Exact radii, percentile rows and input hashes](precision-audit.json)

## Compact storage

The compact simulation uses `b` unsigned magnitude bits plus sign and a dyadic quantum. Each recipient keeps the inherited source radius and adds half the quantum after round-to-nearest. For a stencil with weights `w_i`, the resulting enclosure includes `sum(abs(w_i)*(d_i + quantum_i/2))` in common physical units, as well as the interpolation remainder. This absolute error calculation still applies when an individual ordinate has poor relative accuracy. It excludes any implied compression savings for exponent, sign, radius and index metadata.

The adjacent q10004 archive supplies 34,515 physical half-grid targets and 13 hidden pairs. Every strict interpolation agreed with the independently stored direct midpoint. The following entries give inconclusive targets and recovered hidden pairs.

| Quantum policy | 8 bits | 12 bits | 16 bits |
|---|---:|---:|---:|
| Per ordinate | 140 / 11 | 26 / 13 | 9 / 13 |
| Shared over 16 ordinates of one character | 585 / 6 | 51 / 13 | 16 / 13 |

The uncompressed intervals left two targets inconclusive and recovered all 13 events. At 12 and 16 bits all inconclusive targets already had opposite coarse endpoint signs. An actual extra repair request depends on what the count inequality still needs. [Complete compact replay](precision-stencil.json)

## Twelve consecutive q131071 heights

At indices 5689 through 5700, the pilot reused one archived raw Hurwitz row and generated eleven more using interval Taylor evaluation, including four direct Hurwitz checks at each new height. It projected 12 specified character frequencies through the original even Bluestein circuit at p24 and p28 with the production enclosure radii. Both precisions reused the same p28 source rounding. The completion includes the height-dependent gamma factor, exponential scale, conductor power and original character phase. The 288 output intervals took 90.48 CPU seconds, including 69.91 seconds for residue sources. Their receipt occupies about 43 kB. This measures sparse production on this conductor. A full transform and many more output taps require a separate timing. [Matched amplitudes and timing](precision-contiguous.json)

The 12 frequencies comprise eight equally spaced modes and four known examples whose signs alternate at 5694, 5695 and 5696. For those four, withholding the integer ordinate 5695 creates a double-width coarse interval. All 12 withheld integer signs were recovered at both precisions. A separate off-grid comparison evaluated all **132 distinct ordinary midpoints** in the 11 elementary intervals for the same 12 modes. Independent unrounded midpoint Hurwitz transforms agreed with every certified sign. The one p24 ambiguity was mode 18725 at 5689.5. All p28 midpoints were strict. These 132 rows contain no hidden pair across an elementary interval. [Direct off-grid reference](precision-midpoints.json)

| Precision | Full-radius ambiguities | Per-value 8 / 12 / 16 bits | Shared quantum 8 / 12 / 16 bits |
|---|---:|---:|---:|
| p24 | 1 | 2 / 1 / 1 | 3 / 2 / 1 |
| p28 | 0 | 1 / 0 / 0 | 3 / 0 / 0 |

Each entry is out of the same 132 true midpoints. The quantization experiment takes actual p-specific radii through each weighted sum and selects the first strict Cauchy-bounded stencil. The full-axis single-height audit above alone cannot estimate this failure rate. These correlated samples also leave the production-wide retry rate undetermined. [Off-grid precision and fallback rows](precision-contiguous-storage.json)

Four additional modes were selected retrospectively from the independent midpoint transform at 5694.5 because the midpoint sign reversed both equal endpoint signs. The coarse Hurwitz computation was then repeated at 12 consecutive heights for these four modes. At both p24 and p28, a six-point stencil recovered the hidden pair for mode 266 and seven-point stencils recovered modes 286, 1083 and 1707. All four recovered both flips with 8, 12 and 16 magnitude bits under both storage conventions. This experiment demonstrates a repair on a single production interval. Selection on the known outcome precludes a success-rate estimate. [Per-mode interval receipts](precision-fine-hidden.json) · [Compact replay](precision-fine-storage.json)

## A hard case selected before repair

The frozen rule chose the hidden midpoint whose absolute direct amplitude divided by the magnitude of its parity-specific completion factor was smallest. All 59 hidden events at 5694.5 were ranked. Mode 21039 was uniquely first at 0.2737098445, ahead of mode 75470 at 0.2817481965. Discovery took 15.78 CPU seconds. [Selection rule](precision-hard-rule.json) · [Selection receipt](precision-hard-selection.json)

Both endpoints were strictly positive at p24, but every tested order from 2 through 12 left the midpoint unresolved. At p28 the first strict stencil used nine nodes, 5690 through 5698. It recovered the negative midpoint and both sign changes. The independently evaluated midpoint was −21.36478074434. The nine sparse p28 projections consumed 3.125 CPU seconds when their source residues and roots were available. Reconstructing the eight missing source rows and reading the archived center added 60.656 CPU seconds. Both precisions together used 1.984 CPU seconds for shared setup. The specified rescue rule ended at p28. This case supplies no measured p48 replay time. [All attempted orders and stage timings](precision-hard-coarse.json) · [Escalation outcome](precision-hard-rescue.json)
