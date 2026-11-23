# Independent review of the whole small-conductor theta inventory

2026-11-11. **PASS for the conditional universal parameter construction and exact operation inventory. No correction requested.** The bounds apply to every included conductor and all four stated guard scenarios. This is not extrapolation from the earlier five-conductor examples. It supplies neither actual theta values nor a successful finite-RH certificate, and does not select a runtime winner.

## Evidence and independent reconstruction

Author files are under `work/qrh-campaign/agents/prime-estimates`.

| Object | SHA256 |
|---|---|
| WHOLE_SMALL_CONDUCTOR_THETA_INVENTORY_2026-11-11.md | 74CE66BE4E051AEC1222AB67DF66F124DB1A1774498E6FBE52BDF59EDD9BC9BE |
| small_family_theta_inventory_20261111.py | 4FD7D0F84E3057F74B7F151ABEA73A392739CEA48B12B0B04F1A3F71913A98C2 |
| small_family_theta_inventory_final_20261111.json | 26ED3C86420123A7629DB41C07999990A53A4DAAA4C7146C3FC64D527B578B69 |
| small_family_theta_choice_20261111.py | 9BA5645C165FD51CBFADCF867B1A877F821F894624C51BD4A6DFA99051947794 |
| small_family_theta_choice_final_20261111.json | FB20993DD8C1186E06B4B22D07DBC40CDCA38D7AD3D2503F8E17469648A1FCF4 |

I read the complete frozen note, both scripts, the underlying small-conductor backend and shared-elementary construction, its independent review, and the mixed-radix error contract. All five packet pins and eight input pins match. The earlier draft receipts are not the accepted outputs of this review.

The independent script `work/qrh-campaign/agents/audit/review_small_family_theta_20261111.py` has SHA256 `7798B9594EF5A0088034CD6E70AEACA74776135B5D9AE58194EB610C02476497`. Its final receipt `review_small_family_theta_final_20261111.json` has SHA256 `53971716793EF1818A5F83A348F04832E9FCEA6BA63969849D61E71926367CD5`. It passed **851350 exact checks**. The earlier same-directory non-final receipt is a preliminary reconstruction, not the final review receipt.

The reconstruction imports no author generator or evaluator. It derives ordinary character counts and performs divisor inversion to recover primitive totals and parity counts, rather than taking the author's primitive product formula as the counting algorithm. It rebuilds all59992 conductor/extension/theta records, every aggregate and precision range, the row digest, all example records, and the complete same/half-length conductor lists. The digest comparison follows this full independent reconstruction; a matching hash alone is not the mathematical check. No elementary value, character value, transform, zero, prime candidate or build was evaluated.

## Family, parity and exact heights

The family is precisely odd c or4|c in3<=c<=10000. There are7499 conductors and18477108 primitive labels, split into9238543 even and9238565 odd labels. Primitive characters with v2(c)=1 are absent, and conductor1 is separately excluded. Divisor inversion of the ordinary parity trace gives

`n_even(c)-n_odd(c)=mu(c)+1_(2|c)mu(c/2)`.

Only c3 and c4 are odd-only; c12 is even-only. The other7496 conductors require both parity bucket transforms. Sharing the Gaussian sequence does not identify those two transforms, nor the positive-height channels of inverse characters. The phase-setup Gauss transform is correctly charged once per conductor, with one phase extraction per primitive label.

I independently rebuilt the unit-group axis dimensions, including C2 for4 and C2 times C_(2^(e-2)) for higher powers of two. Their products equal phi(c). This checks dimensions and counts, not the actual generator or character-label certificates, which remain required.

The four conductor bands are genuinely half-open at100,1000,10000. At c10000 the final even coefficient19.1 applies. Each H uses the correct combined odd/even coefficient and floor, and each satisfies the separately checked base-gap and star lower height. The grid is then constructed by a second ceiling:

`m=ceil(64H/5)+extra`, `V=5m/64`, `Jout=m+1`.

Thus the complete closed prefix0,...,m is retained. The integer endpoint is never replaced by a grid point below it. I checked the grid overshoot and all extra-node domains directly. The three extensions are835/64,25 and50 beyond the main grid endpoint. They are not proved sufficient Turing intervals.

The target remains the same normalized real Y for both theta choices, with a fixed root phase. The factor from F_b to Y is positive. Negative-frequency conjugation occurs after that phase and does not eliminate inverse-character outputs. A phase chosen by a different numerical chart must still be aligned to the fixed phase if old signed data are reused.

## Universal analytic parameter admission

The universal upper bounds are valid including the largest guard. From the ceiling and grid rules,

`cV < 201c + max(c*floor,3.1416*u*d_c*c) + (50+5/64)c`.

Taking c<=10000 and u<=21 for odd conductors or22.6 for even conductors gives cV<40 million or80 million respectively. The base-height bound also gives V>=2700, hence V>=2theta for both64 and128, and W=cV/theta>=1. These are uniform inequalities, independently checked as exact rational inequalities and for every finite row.

The replacement of W by Wbar has the correct direction throughout the source proof. Its Gaussian majorant and integral/time bounds increase with W. For fixed n0, reducing W increases v0 and z0, so it can only improve the tail inequality. The logarithmic-tail test is also harder at larger W. The smaller D=min(delta/16,1/Wbar) and larger magnitude denominators in the precision choices remain conservative for the actual W.

I reconstructed the four parameter choices, obtaining K162/164 at theta64 and233/234 at theta128, with L148/219 respectively. All use X10 and n0=8192. The Gaussian seed tolerances require302 and404 fractional bits. All defining rational inequalities pass, including the full Gaussian-tail expression, not merely positivity of its exponent. Delta=5/64 is admitted because XDelta=25/32<1.

For every row, the selected power-of-two N satisfies the source period bound `NDelta>=max(2VK/theta,V+2K,6)`. The retained frequency cutoff has `J=ceil(NDelta X/6)<N/2`, and the closed output prefix has Jout<=N. These checks keep the zero and Nyquist conventions valid. The periodization, frequency-tail, Gaussian-truncation and finite-rounding estimates are inherited from the reviewed source construction at their stated hypotheses; this metadata does not independently generate their actual coefficient enclosures.

The finite Gaussian term count is an upper schedule derived from admitted interval cutoffs. It is not a measured term count. Its use requires the actual radial/cutoff certificates later, including the endpoint inequalities for each selected integer cutoff.

## Counts, setup and precision

All eight aggregate rows, their conductor-parity splits, time-length histograms, optional shared-cache counts and precision ranges match. Main-prefix values include:

| Category | theta64 | theta128 |
|---|---:|---:|
| Required Y outputs |1775431871117|1775431871117|
| Main character butterflies |178774519697023|128941391789290|
| Main character extra products |35506875596080|25399177848072|
| Main character inverse dyadic scales |20967349847456|15046227780352|
| Time butterflies |129247714213888|89858217607168|

The conservative character circuit uses whole-axis radix two or Bluestein. Its latter butterfly count includes both data transforms, while cached kernel construction remains setup. The B inverse-normalization scales for each Bluestein call are explicitly counted. No primitive-output pruning, favorable twiddle or mixed-radix improvement is silently imported.

The initial contracted Gaussian seed is separately charged from the subsequent unit-disk recurrence gates. A unit gate includes its product, two rounds and shrink; it is not one ordinary complex multiply. Bucket additions retain their own rounding tolerance. Odd integer weighting is charged only when an odd channel exists. The radial/prefactor count correctly uses the indicator o, so the even-only c12 case is not treated as having an odd cubic radial factor.

Setup retains one Gauss transform per conductor, its inverse dyadic scales, additive roots, the conductor roots, phase roots/divisions, cached K products, chart undo, real exponential seeds and the bounded fixed arithmetic. Time and character root sharing requires the strictest consumer tolerance and exact mathematical indexing. The optional global cache totals do not permit reuse of a lower-precision kernel. Neither cache counts nor the fixed16+12n call bound count primitive proof steps or all bit operations.

The reconstructed precision ranges match the report. I also checked the new two-choice conclusion more directly than comparing bit ranges. For every same-N conductor and guard, all recorded operation categories agree, and each theta128 absolute tolerance is no larger than its theta64 counterpart. These comparisons cover the Gaussian seed, sigma, radial, setup, main-character, Gauss, time and scale tolerances. The same-N counts are3876,3866,3853 and3830 for the four guard scenarios. Every other conductor has N128=N64/2. This supports the stated static comparison under these fixed sufficient contracts. It says nothing about sharper data-dependent enclosures, different elementary algorithms, runtime, or sign margins.

## Remaining limits

The point-EM comparison is correctly incomplete: its character and formal P20 contraction counts do not establish an admitted high-t EM seed or the same Y normalization. In particular the old V<=10000 seed construction cannot cover the largest small-conductor height. A runtime comparison must add both methods' actual elementary work, widths, seed/phase conversion, transpose and retained-proof costs.

The actual finite-RH certificate still needs correct label/phase data, elementary and coefficient enclosures, implemented arithmetic and transform acceptance, storage bindings, interpolation, strict signs or another zero-localization method, central/real-zero handling and closed completeness counts. The current universal parameter proof removes the example-only admission gap for this selected schedule. It does not fill those numerical or kernel gates, change the final theorem, or turn a guard choice into evidence of successful completion.
