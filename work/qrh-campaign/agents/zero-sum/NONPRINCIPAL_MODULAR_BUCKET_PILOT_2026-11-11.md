# Four-case modular signed-bucket pilot

2026-11-11. **PASS for the stated external coefficient comparisons.** All 32 unit signed-bucket enclosures and all 10 matching-parity primitive-character contractions agree with separately bounded direct sums. This is a finite theta-coefficient experiment, not an L-value computation, contour certificate, spectral scan or Lean proof.

## 1. Fixed cases and definitions

The four cases are exactly

\[
 (c,H,r)=(5,64,0),(8,64,0),(5,1024,1/8),(8,1024,1/8).
\]

For each, set

\[
 b=\pi/4-1/(H+1),\quad z=\exp(2(r+ib)),\quad \tau=ic z.
\]

This b is not pi/4*(1-1/H). The parameter H chooses the tilt of this coefficient input; evaluating it does not certify zeros up to height H.

For every unit residue R modulo c and both a=0,1, the target is the actual signed bucket

\[
 B_{R,a}(z)=\sum_{n\in\mathbb Z,\ n\equiv R\bmod c}
                            n^a e^{-\pi n^2z/c}.
\]

There is no zero term because R is a unit and c>1. With the reviewed characteristic convention,

\[
 H_a[\alpha,\beta](\tau)=\sum_{k\in\mathbb Z}(k+\alpha)^a
 e^{\pi i(k+\alpha)^2\tau+2\pi i(k+\alpha)\beta},
\]

the exact initial identity is B_(R,a)=c^a H_a[R/c,0](tau). It has no extra factor c for a=0.

The source/paper inputs are hash-checked before execution:

* `../integration/NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md`, SHA256 `2EADB0ACEE2B3C8275D9C8CFA815E4E3E7CC39C3CB0EBA0A86763A4877F74F09`.
* `../major-constants/REVIEW_NONPRINCIPAL_THETA_MODULAR_BUCKETS_2026-11-11.md`, SHA256 `FB6A7BD014A4417CD4D3AD2460C0785EDE3838226AA6F9013248863FB3135E70`.

Those notes identify the actual source two-variable theta object and prove the characteristic and odd-moment adapters. This pilot implements those reviewed formulas; agreement with direct sums is additional consistency evidence, not a replacement proof of the formulas.

## 2. One certified modular word per case

At each step choose an integer n near the midpoint of Re(tau), replace tau by tau-n, and **then certify** |Re(tau)|<3/5 on its entire ball. The midpoint only selects a candidate integer; it does not establish the inequality. A terminal point requires Im(tau)>2/5. If it is not terminal, the script certifies Im(tau)<1/2 and uses tau_new=-1/tau. It checks the strict imaginary-height increase by more than 100/61. All initial and intermediate points remain enclosed throughout the calculation.

In the word table, T(n) means that n is subtracted from the current tau. Thus the old point is the new point plus n.

| c | H | r | Certified shared word | Terminal tau, diagnostic only |
|---:|---:|---:|---|---|
| 5 | 64 | 0 | T(-5), S, T(0) | -.1 + 6.4994871714 i |
| 8 | 64 | 0 | T(-8), S, T(0) | -.0625 + 4.0621794821 i |
| 5 | 1024 | 1/8 | T(-6), S, T(2), S, T(-3) | .4456155310 + .4789687642 i |
| 8 | 1024 | 1/8 | T(-10), S, T(4), S, T(2) | -.1988679053 + 1.4014664811 i |

These are one- or two-inversion words, shared by all unit residues and both parity channels at the same c,z. The words are not applied to any neighborhood or contour beyond the enclosed fixed inputs.

## 3. Exact characteristic phases and all root factors

Maintain real rational alpha,beta and a rational phase p measured in turns, so the phase factor is exp(2*pi*i*p). At a T(n) step update

\[
 p\leftarrow p-\tfrac n2\alpha(\alpha-1),\qquad
 \beta\leftarrow\beta+n(\alpha-1/2).
\]

At an S step update

\[
 p\leftarrow p+\alpha\beta,\qquad
 (\alpha,\beta)\leftarrow(\beta,-\alpha).
\]

The shared multipliers M_0,M_1 start at 1. At each S step with v=-1/tau_old, multiply M_0 by A(tau_old) and M_1 by A(tau_old)*v, where

\[
 A(\tau)=1/\sqrt{-i\tau}.
\]

The script certifies Re(-i*tau_old)>0 and takes the principal square root, whose real part is also certified positive. Every intermediate root and reciprocal factor is retained. No unproved global square-root formula replaces their ordered product. The odd multiplier is v=-1/tau_old, not +1/tau_old.

After initialization and each step, center alpha,beta in [-1/2,1/2) by exact integer shifts. If alpha_old=alpha_new+p0 and beta_old=beta_new+q0, add alpha_new*q0 to the phase, modulo one. This implements the reviewed elliptic characteristic identity. All characteristic denominators are checked to divide 2c. The receipt records the exact labels, shifts and accumulated phase at every step.

For each residue and parity, reconstruct

\[
 B_{R,a}(z)=c^a M_a\,e^{2\pi i p_R}
                         H_a[\alpha_R,\beta_R](\tau_{\rm red}).
\]

The transformed beta is not dropped when nonzero. It is part of the exact reduced series, rather than an assumed return to an untwisted residue bucket. All phases are computed from their exact rational multiples of pi; special quarter-turns are represented exactly, and other phases use elementary complex exponential balls.

## 4. Reduced and direct tail proofs

The calculation uses 192-bit balls. At the terminal point, sum the reduced characteristic series for -16<=k<=16. The certified Im(tau_red)>2/5 implies pi*Im(tau_red)>6/5. With gamma=6/5 and u=16+1/2, the reviewed common remainder for a=0 and a=1 is

\[
 E_{\rm red}=\frac{2e^{-\gamma u^2/2}}
                         {1-e^{-\gamma(2u+1)/2}}.
\]

Its value is less than 2.286e-71. The script adds a square enclosure of this error disk before multiplying by c^a, the shared S product and the unit phase. Across the tested buckets the largest norm bound for c^a M_a is below 194. Thus the reduced-series analytic error is below 4.435e-69 after reconstruction; all finite arithmetic and input-propagation errors remain in the balls as well.

For an independent direct representation, accumulate the positive and negative integer terms through |n|<=512 into their original residue buckets. Put

\[
 d_0=\frac9{2c(H+1)}.
\]

This is a rigorous lower bound for pi*Re(z)/c: since r>=0, u=2/(H+1)<=1 and sin(u)>=u-u^3/6>=3u/4, one has Re(z)>=3/(2(H+1)); then use pi>3. The script also checks the strict bound against the actual input ball.

For J=512 and n0=J+1, define

\[
 r_a=((n_0+1)/n_0)^a e^{-d_0(2J+3)},\qquad
 E_a=\frac{n_0^a e^{-d_0n_0^2}}{1-r_a}.
\]

The script certifies r_a<1. Successive omitted positive absolute terms have ratio at most r_a, so E_a bounds the full positive tail. Each signed residue bucket is conservatively assigned 2E_a, without assuming residue equidistribution or cancellation. Each direct positive character sum is assigned E_a using |chi(n)|<=1. The largest tested E_a is below 2.266e-60; no tiny tail is rounded to zero in the calculation or receipt.

Every modular/direct bucket pair overlaps. The entire ball for their difference also has norm less than 10^-35. These comparisons check consistency between two independently summed representations with explicit tails. Their validity as enclosures comes from the analytic identities and bounds, not merely from overlap.

## 5. Actual character labels and the parity factor

For c=5, use generator 2 and the exact labels

\[
 \chi_k(2^j)=e^{2\pi i k j/4},\qquad k=0,1,2,3.
\]

The primitive labels are k=1,2,3. Their parities are k mod 2; labels 1 and 3 are the nonreal conjugate pair, and label 2 is real even. Character values are exact fourth roots of unity in the script.

For c=8, use the noncyclic coordinate map

\[
 R=7^u5^v\pmod8,\qquad (u,v)\in\{0,1\}^2,
 \quad\chi_{k,l}(R)=(-1)^{ku+lv}.
\]

The primitive labels are (0,1) and (1,1), with respective parities 0 and 1. The label (1,0) has conductor 4, and (0,0) conductor 1; neither is included as primitive at c=8.

For both moduli, the script checks that the coordinate map enumerates all units, verifies every multiplication-table identity, and derives the conductor by testing constancy on every unit-reduction fiber at each divisor of c. It does not infer primitiveness merely from the number of labels. These are the concrete prime/cyclic and noncyclic instances of the already reviewed actual-character manifest.

For each primitive label and its matching a, compare

\[
 \frac12\sum_{R\in(\mathbb Z/c\mathbb Z)^\times}\chi(R)B_{R,a}(z)
       \quad\hbox{with}\quad
 \sum_{n\ge1}\chi(n)n^a e^{-\pi n^2z/c}.
\]

The factor 1/2 is applied only after the matching-parity contraction. No individual positive residue bucket is replaced by half its signed bucket. The zero term is absent because chi(0)=0. All 10 such contraction comparisons pass, including both nonreal c=5 labels in both H cases. The opposite-parity signed contractions contain zero as expected, but are not used to compute the corresponding positive sums.

## 6. Retained data and reproduction

The receipt retains exact rational endpoints of the complex balls for the original z,tau, every intermediate tau, principal root and common multiplier; all rational characteristic phases and labels; every reduced finite sum and reconstructed signed bucket; direct-sum enclosures and their tails; and all matching primitive contractions. The short reduced sums and direct sums can be regenerated from the recorded definitions and cutoffs. Decimal summaries are diagnostic only.

There are 8 signed unit buckets per case, hence 32 total, and 3,2,3,2 primitive contractions. The producing run took about .052 seconds internally, excluding interpreter startup and serialization. This is a tiny coefficient test, not a production speed or complexity claim. No FFT was executed. The JSON is 256,239 bytes.

Frozen files:

* `nonprincipal_modular_bucket_pilot_20261111.py`: SHA256 `C214A9AE38D15A1F66ADE45CF697C422F8C8282253254A2D012035BBA937845F`.
* `nonprincipal_modular_bucket_pilot_20261111.json`: SHA256 `FA310110205329FBD0E7D2710AF8267ED28E1C24320CEB7B4AE86E24486F126F`.

Read-only recomputation from the repository root:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/nonprincipal_modular_bucket_pilot_20261111.py --recompute
```

This regenerates every calculation and requires exact agreement with all non-timing receipt fields. It does not overwrite the receipt. The initial run and read-only recomputation both passed. Source/formula pins remain unchanged.

Independent review is requested with higher-precision direct progression sums and an independent word/phase replay. The current result is external coefficient evidence only. The source characteristic adapters, interval engine, complete contour assembly and actual family spectrum remain separate formal or computational obligations.
