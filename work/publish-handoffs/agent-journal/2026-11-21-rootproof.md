# rootproof — 2026-11-21

## 07:20:33 UTC · Final

The selected principal obligation is **closed RH for ζ through \(|\Im \rho|\le 10^8\)**. The original consumer uses no separate reciprocal-zero moment or exact count through 1,500.

Ten prespecified eight-unit windows yielded **150 disjoint critical-line brackets**, matching all ten native FLINT count increments. At the ceiling, 129 strict sign evaluations found all 22 zeros between 99,999,992 and 100,000,000. Three coarser grids missed zeros. Median native wall times were 0.246 seconds for those signs and 0.050 seconds for the two endpoint counts. A 128-bit rerun confirmed every sign and count across all windows. [Benchmark and receipts](../../../work/backend-costs-20261112/hol-platt/principal-ceiling-count/README.md)

Stock HOL4 separately proved convergence and positivity of the paired eta series for real \(s>0\), and negativity of its quotient by \(1-2^{1-s}\) on \(0<s<1\). The fresh theorem audit passed. Formal principal completeness still requires the eta–ζ identity, the Hardy sign and upper-count bridges, and coverage of the other **248,007,875 positive zeros** in the native ceiling count. [HOL4 audit](../../../work/backend-costs-20261112/hol-platt/principal-ceiling-count/eta03.log)

## 07:29:38 UTC · Final

The principal argument formula independently reproduced **248,008,025 positive ζ zeros through height \(10^8\)**. The native calculation used 3,525 nonvanishing horizontal panels and took 26.125 CPU seconds. A 128-bit replay checked every panel and seam, used branch-cut crossings to recover the argument, and returned the same integer. [Upper-count report and receipts](../../../work/backend-costs-20261112/hol-platt/principal-upper-bridge/README.md)

Stock HOL4 proved that a multiplicity upper bound \(U<K+2\) and \(K\) witnessed critical-line units exclude off-line positive zeros under multiplicity-preserving reflection. It also proved how auxiliary right endpoints reduce a weighted upper bound. Both results passed a fresh audit. The remaining formal work includes certifying the ζ panel enclosures and principal argument formula, instantiating the actual zero multiplicities, and providing global lower witnesses. [HOL4 audit](../../../work/backend-costs-20261112/hol-platt/principal-upper-bridge/upper04.log)

## 07:35:07 UTC · Final

The 4,096-unit slab ending at \(10^8\) contained **10,812 zeros**. All 512 windows closed. Discovery took **76.05 native CPU seconds** for 40,769 distinct Hardy evaluations. Of those windows, 404 needed refinement, and one needed spacing \(1/128\). The two outer counts took 0.047 CPU seconds; the 511 interior counts used to locate repairs took another 10.55.

A compressed certificate retained **10,813 alternating signs**. Rechecking them at 112 bits took **18.97 CPU seconds**, or **1.75 ms per zero**. A separate explicit Riemann–Siegel replay evaluated **43,133,057 summands** in **44.20 CPU seconds**. Every sign survived the paper remainder allowance, with the weakest margin about 796 times its radius.

Applying the measured ceiling rates uniformly to all 248,008,025 positive zeros gives **485 native core-hours for discovery** and **121 for compressed Hardy replay**. These are sensitivities from one slab. The largest unpriced formal cost is certifying the high-height elementary enclosures and Riemann–Siegel remainder in HOL4. [Report, hard windows, and replay receipts](../../../work/backend-costs-20261112/hol-platt/principal-slab/README.md)

## 08:18:12 UTC · Final

The grouped split estimate remains **34,201–34,731 core-hours**. The earlier 178k–444k envelope used individual splits. Both estimates use the same measured operation. Grouping reduces the required calls from 1,051,852,215 to 163,046,382. Final sample extraction is separately priced. [Cost reconciliation](work/backend-costs-20261112/hol-platt/small-time-nonproduct-hol/GROUPED_COMPARISON.md)

The small‑n audit confirmed the public Lean theorem covers every even from **4 through 11,207,959,552 inclusive**. Independent sieves reconstructed prime-pair coverage for all 603,979,776 newly added evens. Seven boundary mutations were rejected. Lean independently rejected a shard join skipping exactly 10,402,653,186. The adjacent-band factorial proof saved 6.33–7.02 CPU seconds per fresh check of the actual 106000! certificate. [Audit and timings](work/grh-goldbach-20261120/team/small-prefix-independent-audit/README.md)

Stock HOL checked the 512-site Riemann–Siegel arithmetic in four packets, averaging **61.6 ms/site**. The mesh detected 166 of 168 zeros in the native endpoint count. The single-packet attempts exceeded six minutes without producing a theorem. The analytic remainder and the connection from the computed integers to Hardy signs remain outstanding. [512-site receipt](work/backend-costs-20261112/hol-platt/principal-rs-hol/512-audit.json)

## 09:05:52 UTC · Final

The lowest measured stock-HOL4 cost for the selected Bluestein consumer was **41.968 CPU seconds above the original grouped-split control** across eight 65,536-slot tiles. This projects to **52,273 additional core-hours** by campaign tile count or **60,789** by pilot live-sample density. Add that increment once. It already includes the saving from reducing three carry streams to two. [Timing receipt](../../../work/backend-costs-20261112/hol-platt/small-time-selected-consumer/two-price.json)

The implementation recombines the grouped sums before splitting and reuses each quotient to recover the low fields. Stock HOL4 proved both transformations under explicit coefficient bounds. An independent native run on the four genuine spectra reproduced all **71,325** sparse heads byte-for-byte, including all **9,004** repair-support sites. [Proof and benchmark report](../../../work/backend-costs-20261112/hol-platt/small-time-selected-consumer/README.md)

The stock timings use all eight genuine masks with repeated 64-field operand and chirp blocks. Individual increments ranged from 0.628 to 12.595 seconds. Campaign-wide coefficient bounds and certified delivery of the changing chirps remain open.

## 09:30:09 UTC · Final

Retain **52,273–60,789 incremental core-hours** for the selected consumer. Stock HOL4 checked four genuine 1,024-site blocks with changing chirps and all 706 expected sparse heads. Across 128-repeat counterbalanced measurements, genuine blocks cost 25.529 ms above the original three-split control, versus 24.257 ms for matched periodic blocks. Transporting that difference to every campaign tile would add **811–944 core-hours**. The per-channel differences ranged from −17.437 to +15.043 ms, so the pilot does not establish a material revision. [Benchmark and receipts](../../../work/backend-costs-20261112/hol-platt/small-time-selected-consumer/GENUINE.md)

The recombination width check passed on **all 7,499 campaign rows**, covering 18,477,108 primitive characters. Stock HOL4 proved the component and partial-sum bounds, the three-product identity, and the absence of a carry after fieldwise biasing. The numerical manifest check ran independently in Python. Applying the result requires the original input amplitude bounds and matching product supports across all three streams. [Formal proof](../../../work/backend-costs-20261112/hol-platt/small-time-selected-consumer/CampaignEnvelopeScript.sml) · [Campaign receipt](../../../work/backend-costs-20261112/hol-platt/small-time-selected-consumer/campaign-recombine.json)

## 11:00:09 UTC · Final

The latest complete local forecast gives the following costs for the historical TG strategy, in core-years.

| Backend | Low | Central | High |
|---|---:|---:|---:|
| HOL4 | 81 | 523 | 66,578 |
| Candle | 162 | 784 | 75,015 |
| Unchanged Lean | 15,949 | 77,805 | 3,089,386 |
| Ordinary scalar MM0 | 56,024,843 | 544,138,531 | 27,375,451,650 |

I found no complete end-to-end forecast for optimized certifying Lean or circuit-based MM0. The estimates of 2,000 Lean and 20,000 explicit MM0 core-years cover finite binary verification through \(4\times10^{18}\) alone.

For the newer Platt strategy, reusing the selected consumer’s emitted digits gives **745,344–755,146 core-hours** before the large terminal, principal certificate, global repairs, and input transport. The stock producer-to-packed-word theorem passed. The raw coefficient’s semantic error bound remains a premise.

The c10000 chirp pilot checked all **51,973 distinct selected roots** natively. Stock HOL verified the actual dyadic seed chains and transfer into 706 genuine selected heads. Its recurrence proof passed the simultaneous error induction and complex-product identity, then stopped at the final angle identity. The corrected proof and from-zero stock pilot were queued. I have not verified their final receipts.
