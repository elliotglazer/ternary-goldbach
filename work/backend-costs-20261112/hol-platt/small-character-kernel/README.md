# Character transforms for the small conductors

The 7,499-conductor ledger initially assigned 153,260 core-hours to character transforms. Pricing the original schedule from stock HOL4 timings gives 46,273 projected core-hours. Restricting it to frequencies with at least two retained coprime indices gives 33,216. Between-draw standard errors are 1,477 and 1,067 hours respectively. They measure sampling variation within this benchmark. They do not cover differences between the benchmark and a production proof. [Projection](costs.json) · [Reweighting calculation](price.py)

Four draws per FFT length and eight per scalar operation give 72 sampled panels. Each panel ran three paired full and control computations. The fixtures test the schedule's transform sizes and integer precisions. One five-stage transform at conductor 10,000 was also replayed with actual inputs. Its 8,144 signed stage coordinates agreed with a separate implementation, including the archived final vector. Table construction, proof admission, transposes between axes and file I/O require separate pricing. [Panel fixtures](fixtures.py) · [Paired timings](panels02.log) · [Actual conductor replay](actual01.log)

For the shorter schedule, write the Gaussian decay rate as
\(d=(\pi/c)e^{2x}\sin t\), with \(t=2\theta/V\). For \(0<t\le1\),
\(d\ge D e^{2x}\) with \(D=(157/(50c))t(1-t^2/6)\). Both parities are bounded by the same positive series. For a first omitted index \(u\ge1\) with \(du^2\ge1\), the summand \(v e^{-d v^2}\) decreases for \(v\ge u\). The first term and the integral give
\(\sum_{n\ge u} n e^{-dn^2}\le(u+1/(2d))e^{-du^2}\).

The calculator chooses an integer exponent for each conductor so that this tail, including the outer prefactor, fits the previous error allowance. It rounds the cutoff upwards using rational arithmetic. A sum with no retained units gives zero. With only the index 1 retained, every character has value 1 there, so direct evaluation suffices. The ledger skips 509,741,529 empty and 243,833,376 singleton character transforms. The time transform keeps its full length. The revised recurrence uses 2,285,390,500,061 complex multiplication gates. The analytic tail argument still needs its HOL4 proof. [Integer cutoff calculation](cutoff.py) · [Count ledger](cutoff.json)

Replacing the original row gives a subtotal of 639,842–640,371 core-hours. Applying the shorter schedule lowers this to 626,785–627,315. This subtotal excludes the Gaussian recurrence, certified analytic seeds, complete sign and zero counts, and production proof handling. It cannot yet support an end-to-end comparison with Platt. [Comparison requirements](../CONFIDENCE_REQUIREMENTS.md)
