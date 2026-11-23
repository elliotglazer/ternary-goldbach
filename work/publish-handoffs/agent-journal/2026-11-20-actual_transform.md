# actual transform — 2026-11-20

## 19:30:03 UTC · Final

Computed all 2,301 primitive character channels at both heights. The native cross-check bounds the complex absolute error of every unnormalized Hurwitz sum by \(13{,}391 \cdot 2^{-81}\), below \(5.54\times10^{-21}\). Six independent Arb Dirichlet L evaluations agreed within \(141\cdot 2^{-81}\).

The rounded transform took 0.093 and 0.086 seconds on the two direct-source inputs. These timings exclude HOL replay and the historical source producer. [Results and error derivation](</work/backend-costs-20261112/hol-platt/c10004-real-transform/README.md>)

## 19:32:11 UTC · Final

All 4,602 native completed-value intervals excluded zero. At \(5/64\), 1,732 channels were positive and 569 negative. At \(10/64\), 1,679 were positive and 622 negative. The smallest certified distances from zero were 0.054714599808 and 0.020481192915, respectively. Across the two heights, 153 channels changed sign.

The calculation used one fixed phase per character at both heights, with conjugate phases for inverse pairs. These results provide native interval evidence for the two sampled heights. HOL verification and zero-count closure remain open. [Results and phase convention](</work/backend-costs-20261112/hol-platt/c10004-real-transform/README.md>)

## 19:35:18 UTC · Final

All 2,301 native sign intervals excluded zero at both high grid points. **453 channels changed sign** between \(t=6577.96875\) and \(t=6578.046875\). The smallest certified absolute values after scaling by \(e^{\pi t/4}\) were 0.001867768720 and 0.002725689110.

The 9,600 direct Hurwitz evaluations took 46.47 CPU seconds and 61.61 wall seconds, about 28.9 times the CPU cost at the two low heights. This measures the native direct-source diagnostic. Historical P20 and HOL replay costs remain separate. [High-grid results and timing breakdown](</work/backend-costs-20261112/hol-platt/c10004-high-reference/README.md>)

## 19:46:16 UTC · Final

The conductor-10000 Bluestein check passed for all 500 outputs of an actual Gauss-sum input slice. The maximum certified complex error was \(704\cdot2^{-307}\). Building the normalized kernel took 0.0212 seconds, and applying the cached transform took 0.0326 seconds. [Bluestein results](</work/backend-costs-20261112/hol-platt/c10000-bluestein/README.md>)

The completeness receipt now records the exact FLINT functions, analytic assumptions, and principal reciprocal sums. It includes 1,069 positive zeta zeros through 1,500 and the certified damped bound \(Q_{1500}<1.655669267707\). Both receipts are native numerical evidence. [Completeness results](</work/backend-costs-20261112/hol-platt/one-character-completeness/README.md>)

## 20:02:57 UTC · Final

The saved schedule contains **546,144 length-500 character transforms at exactly p307**, all at conductor 10,000. The historical model priced their butterfly and point-product work at 17.76 core-hours. Five stock-HOL resident runs give **39.44 core-hours at the median or 61.90 at the mean**, conditional on comparable input magnitudes. Including output decoding and verification raises the mean projection to 137.33 hours.

The fold identified another 5,461,452 character transforms at other precisions and 42 higher-precision Gauss-phase transforms. Their counts and separate pricing assumptions are in the [Bluestein price receipt](</work/backend-costs-20261112/hol-platt/c10000-bluestein-price/README.md>).

## 20:08:46 UTC · Final

The matched large-conductor ledger contains **269.92 billion eligible whole-axis transforms** at lengths of at least 32 and precisions p80–p105. The old model assigns **797,331 HOL core-hours** to their arithmetic. The native Kronecker panel projects **122,263 hours**, or **85,758 hours** under linear within-bin scaling. Neither figure measures HOL replay. At the first price, a formal implementation must stay below **6.52× native cost** to improve on the old subtotal.

The fold reproduces the ledger’s residue-input and primitive-output totals. Source generation, Horner evaluation, short axes, and zero-count work remain separately priced. [Full report and measurement assumptions](</work/backend-costs-20261112/hol-platt/large-kronecker-price/README.md>)
