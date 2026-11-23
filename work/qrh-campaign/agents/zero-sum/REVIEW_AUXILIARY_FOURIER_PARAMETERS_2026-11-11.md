# Independent review of arbitrary-height Fourier parameters

2026-11-11. Verdict: PASS for the mathematical parameter implication and exact scalar witnesses. No producer correction is requested. This is not a review of actual FFT outputs, signs or finite zero data, and it supplies no Lean proof or practical runtime claim.

## Frozen inputs

All three files are in `work/qrh-blueprint/turing-scalars`:

| File | SHA256 |
| --- | --- |
| `AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md` | `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47` |
| `auxiliary_fourier_parameters.py` | `7C1A901FEF4B9A9289E82849DFDADDE1C97AB3AB238B4BFFC90C6A15D71BFAF8` |
| `auxiliary_fourier_parameters.json` | `E32CEB4C944E8732472EB70A53D45778203860989785F296C7D2ACA241956F20` |

The accepted predecessor is the exact primitive nonprincipal Gaussian/Fourier identity and alias proof, with the same conductor, parity, root phase and positive inverse-transform convention. This review checked the adapter against those analytic formulas, not only against its own arithmetic script. Producer files were read only; their hashes were checked before and after the independent calculation.

## Mathematical checks

Write C=cH with integer c>1 and rational H>=1; let0<e<=1. The choices eta=1-1/H and R=pi*(1+eta)/8 satisfy0<=eta<1 and |pi*eta/4|<R<pi/4, including H=1. The sine chord inequality gives the same bounds as in the predecessor, now without a product cap:

\[
 d>3/C,\qquad A\le C,\qquad M_R\le8C,
 \qquad\lambda_\pm>3/(8H).
\]

For example A_even<=c^(1/4)*sqrt(H)<=cH and A_odd< c^(1/4)*H<=cH. The outer-strip bounds likewise imply M_R<=8c^(1/4)H<=8C. Thus no hidden use of C<=10^8 remains in this transfer.

With r=3/8 and integers K,L>=1 chosen by the two strict rational tests, P=(1+8K/3)H satisfies P>2H. Moreover

\[
 \frac3{8H}P=K+3/8>1,\qquad
 \frac3{8H}(P-H)=K.
\]

Each time-tail geometric denominator therefore exceeds1/2. Both signed copies together have error below32C exp(-K)<32C r^K<e/4. The factor32 includes both channels and both denominator bounds.

For integer x>=2, the frequency test (3/(2C))*(8/3)^(2x)>=L is sufficient. Choosing the least power of two N>=Px/3 gives

\[
 N\ge Px/3>2,\quad N<2Px/3,\quad X_{cut}=\pi N/P>x.
\]

Thus N is even. P>=11/3 and pi<22/7 imply omega=2pi/P<2. The normalized total DFT weight satisfies

\[
 \omega N<4\pi x/3<88x/21=D.
\]

Since exp(1)>8/3 and Xcut>x, the actual Gaussian exponent d exp(2Xcut)/2 is strictly greater than L even when the rational frequency test is an equality. The kernel envelope is consequently Q(Xcut)<2C exp(-L). The predecessor's stable two-sided frequency error is

\[
 2Q(X_{cut})\left(\omega+
          \frac1{1/2+d e^{2X_{cut}}}\right)
 < 2Q(X_{cut})(2+2)<16C e^{-L}<e/4.
\]

The integer L is an exponent target, not a number of retained folds. The adapter uses the single centered block, Lfold=0, with the predecessor's conservative Nyquist endpoint overcount. Its inverse DFT remains positive-exponent, with multiplier omega for an unnormalized sum or omega*N for Mathlib's normalized inverse. No sign or normalization change is introduced by rounding N to a power of two.

For the common Gaussian cutoff, put n0=M+1, z=3(2M+3)/C-1/n0 and j=floor(3n0^2/C). The exact test z>0 implies that the odd-parity successive-term ratio, which is the larger of the two parity ratios, is strictly below exp(-z). Its denominator is bounded by1+1/z. The test3n0^2/C>=3/4, together with actual d>3/C, implies d*n0^2>k/2 for both k=1/2 and k=3/2. Therefore the full prefactor times the first omitted Gaussian term decreases with |frequency|. This check includes the reciprocal-theta formula on the negative side; it does not assume that the original untransformed negative-frequency sum has a large Gaussian parameter.

The per-coefficient series error is below

\[
 2n_0(1+1/z)\exp(-3n_0^2/C)
 \le2n_0(1+1/z)r^j.
\]

The non-strict last inequality is valid also for j=0. Multiplication by D and the third strict test give total series error below e/4. For fixed positive C,D,e, doubling M terminates: z is eventually positive and grows linearly, j grows quadratically, and the remaining polynomial factor times r^j tends to0. This establishes existence of sufficient finite parameters, without any cost bound.

Finally, the future coefficient rounding requirement e/(8D) contributes less than e/8 after the actual DFT weight omega*N<D. The future normalized FFT requirement contributes at most e/8. The three strict quarter-budget terms and these two eighth-budget terms sum to strictly less than e. Every one of these comparisons has the correct direction.

## Independent exact reconstruction

The review script does not import or execute the producer's parameter constructor. It reconstructs K and L by repeated multiplication of a geometric bound, x by a separate exponential recurrence, N by integer bit length after an exact rational ceiling, and M by an independent exponent search. It compares every field of each reconstructed row with the frozen receipt and checks the complete rational error ledger.

All five complete producer rows matched:

| c | H | K/L | x | N | M |
| ---: | --- | --- | ---: | ---: | ---: |
| 3 | 1000000 | 91/90 | 10 | 1073741824 | 16384 |
| 300000 | 1000 | 96/95 | 13 | 2097152 | 131072 |
| 4 | 100000000 | 96/95 | 13 | 137438953472 | 131072 |
| 101 | 10001/2 | 89/89 | 9 | 4194304 | 4096 |
| 8 | 7/3 | 79/78 | 4 | 1024 | 32 |

All use e=10^(-30). Three additional parameter cases also passed: c=2,H=1,e=1; c=3,H=1,e=10^(-60); and c=300000,H=1001/3,e=10^(-60). The c=2 case tests scalar boundary conditions only; it is not asserted to carry an actual primitive nonprincipal character.

Independent files, under `work/qrh-campaign/agents/zero-sum`:

* `review_auxiliary_fourier_parameters_20261111.py`, SHA256 `70936FD43BCF1BB69F097E4AE4AF0A9D8AB679E6064624DD3731F33A8F14595E`.
* `review_auxiliary_fourier_parameters_20261111.json`, SHA256 `EB6F4CC8D51C1A81BD3C4D38B49CD7E1320A0F647E17E85ABD7A13F412B5FA55`.

The script exited0 and reported five complete matched rows, three additional boundary cases, and unchanged producer pins. Its receipt contains exact rational error-to-budget ratios. It generated no analytic values or FFT data.

## Scope retained

This adapter correctly permits H=T+h with no cH cap, while leaving the required character family and target Hcert unchanged. Its estimates hold at grid points with |t_m|<=H. It does not give off-grid interpolation, locate zeros, prove signs or establish the Turing count inputs.

The numerical FFT error target is still a premise about future data. In particular the c=4,H=10^8 example has N=2^37. It exceeds the earlier fixed36-stage FFT example, so that example's fixed precision and rounding bound cannot simply be reused. The general stagewise error rule or a new precision certificate must establish e/8 for this new length and tolerance. The adapter already leaves that obligation explicit; this is an implementation caution, not a defect in its mathematical implication.

The very large radix-two lengths are sufficient witnesses only. Neither their existence nor the scalar check asserts practical runtime, storage feasibility, successful sign separation, or a completed spectral certificate. The formal analytic adapters, interval primitives, actual coefficient data, normalized FFT enclosures and complete count remain separate work.
