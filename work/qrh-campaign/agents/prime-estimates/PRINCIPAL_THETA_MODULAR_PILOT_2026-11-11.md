# Four-point modular theta kernel pilot

This bounded external calculation evaluates the principal kernel and its underlying theta derivative jets at four specified inputs. All four modular evaluations overlap direct, untransformed Gaussian evaluations with explicit tails. This is coefficient-evaluation evidence, not a Lean proof, an implementation of xi quadrature, or a zero/spectral certificate.

## Frozen inputs and implementation

The mathematical source is `../integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md`, SHA256 `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D`. Its independent source/paper review is `../audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md`, SHA256 `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED`.

This pilot's files are:

- `principal_theta_modular_pilot_20261111.py`, SHA256 `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14`.
- `principal_theta_modular_pilot_20261111.json`, SHA256 `C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF`.

The script uses Python-flint's 256-bit elementary interval arithmetic: field operations, pi, square root, exponential, sine and cosine. It never calls theta, zeta, Gamma, or a Hardy-Z/Riemann-Siegel evaluator. Those elementary library results remain external arithmetic evidence; no claim of kernel-checked elementary enclosures is made here.

For each `T` in `{1000000,60343058}` and `r` in `{0,1/8}`, define exactly

\[
\eta=1/(T+1),\qquad w=r+i(\pi/4-\eta),\qquad
\tau=i e^{2w}=e^{2r}(-\cos(2\eta)+i\sin(2\eta)).
\]

The final expression is

\[
P(w)=e^{w/2}\left(6\tau\theta_3'(\tau)+4\tau^2\theta_3''(\tau)\right).
\]

The inputs are the specified exact expressions, not the floating midpoints used to display results. The stable formula for tau avoids subtracting nearly equal multiples of pi. The script certifies `Im(tau)>=eta`.

## Transformation certificate

At each stage an integer `n` is proposed by rounding a floating midpoint, then accepted only after the interval proof `abs(Re(tau-n))<3/5`. Thus the floating proposal is not an acceptance oracle. Put `z=tau-n`. Stop if `Im(z)>2/5`; otherwise certify `0<Im(z)<1/2`, apply `S:z -> -1/z`, and certify an imaginary-part increase by more than `100/61`. All executed decisions have strict margins. No equality test at a fundamental-domain boundary is needed.

Types are ordered `(theta2,theta3,theta4)`. Translation multiplies theta2 by `exp(pi*i*n/4)` and, for odd n, swaps theta3/theta4. The phase is evaluated from the exact eighth-root table using `1/sqrt(2)`. Translation applies the same factor/permutation to all three derivatives.

For an inversion, let `v=-1/z` and `A=1/sqrt(-i*z)`. The original types use the transformed types in order `(theta4,theta3,theta2)`. A transformed jet `(g,g1,g2)` returns

\[
A g,\quad A\left(-g/(2z)+g_1/z^2\right),\quad
A\left(3g/(4z^2)-3g_1/z^3+g_2/z^4\right).
\]

The root branch is explicit. For `-i*z=x+i*y`, `x=Im(z)>0`, compute

\[
R=\sqrt{x^2+y^2},\quad u=\sqrt{(R+x)/2}>0,
\quad v_0=y/(2u),\quad \sqrt{-iz}=u+i v_0.
\]

The receipt retains every translation/inversion input and output, root witness, reduced finite jet, and reverse propagation stage. This prevents replacing a branch-sensitive factor by an unspecified square root.

## Finite Gaussian sums and tails

At the reduced point, theta3/theta4 retain the central term and pairs at `n=1,...,20`; theta2 retains pairs at `n+1/2` for `n=0,...,19`. A pair's j-th derivative is `2*(pi*i*x^2)^j*exp(pi*i*tau*x^2)`, with the alternating sign for theta4. Derivatives have their ordinary derivative normalization, not Taylor coefficients divided by factorials.

For `alpha>0`, `j=0,1,2`, set `M0=1` and `Mj=(2j/alpha)^j` when `j>0`. Whenever `pi*Im(tau)>=alpha`, the omitted pair tail starting at frequency at least `u` is bounded by

\[
E_j(\alpha,u)=
\frac{2\,4^j M_j e^{-\alpha u^2/2}}
 {1-e^{-\alpha(2u+1)/2}}.
\]

Indeed `pi^j<=4^j`, `x^(2j)*exp(-alpha*x^2/2)<=Mj`, and consecutive frequencies are separated by one, giving the displayed geometric majorant. For all reduced types the script uses `alpha=6/5` and `u=41/2`; this also bounds the integer tail whose actual first frequency is 21. Each complex error disc is safely replaced by a coordinate box of radius `E_j`.

For the direct comparison, take a rational dyadic lower bound `ylo<=Im(tau)`, put `alpha=3*ylo`, and choose a positive integer `N` with `alpha*N^2>=400`. The same formula with `u=N+1` bounds each omitted derivative tail. There is a 100000-term cap and a 550-second guard; neither is approached in the completed run. The direct calculation evaluates each Gaussian exponential separately, rather than calling a theta routine.

Both the direct theta-jet expression for P and the original finite kernel sum are computed. The latter is

\[
8\pi^2e^{9w/2}\sum_{n=1}^N n^4e^{-\pi n^2 e^{2w}}
-12\pi e^{5w/2}\sum_{n=1}^N n^2e^{-\pi n^2 e^{2w}}.
\]

Its tail is bounded by `|exp(w/2)|*(6*|tau|*E1+4*|tau|^2*E2)`. The two direct formulas overlap, all three modular theta3 jets overlap their direct counterparts, and modular/direct P intervals overlap at every input. Overlap is a diagnostic; the enclosure claim rests on the transformation identities, finite arithmetic and explicit tails, not on overlap alone.

## Results

In a word below, `Tn` subtracts n before the next step. Displayed decimals are only summaries; exact intervals are in the receipt.

| T | r | Reduction word | Reduced Im(tau), approximately | Direct N |
|---:|---:|---|---:|---:|
| 1000000 | 0 | T-1, S, T0 | 500000.500 | 8165 |
| 1000000 | 1/8 | T-1, S, T4, S, T2, S, T-12, S, T-2, S, T6 | 9.31704701 | 7206 |
| 60343058 | 0 | T-1, S, T0 | 30171529.500 | 63427 |
| 60343058 | 1/8 | T-1, S, T4, S, T2, S, T-12, S, T-2, S, T19 | 0.487347227 | 55974 |

The r=0 P display boxes are `[-2^-128,2^-128]` in each coordinate. They do not assert exact vanishing. The r=1/8 values are approximately

\[
P_{1000000}=1.089752494945126\,10^{12}
-2.208954416969382\,10^{12}i,
\]
\[
P_{60343058}=-1.012805102814437\,10^{17}
+7.949489973474485\,10^{16}i.
\]

Their displayed coordinate widths are at most one `2^-128` unit. All four final coordinate widths pass the weaker explicit script check `<10^-8`.

There are 12 inversions in total, 160 reduced positive-frequency pair evaluations across the four inputs, and 134772 direct positive-frequency evaluations. The saved run records 0.4368671 seconds wall time and 0.4375 seconds process CPU for the computation, excluding subsequent JSON serialization. These are measurements of this four-point external prototype, not Lean timing or a large-grid throughput prediction.

An initial unretained prototype used repeated rectangular complex rotations for the direct Gaussian terms and suffered severe interval wrapping. The frozen version evaluates each exponential directly; it passed without a precision increase. This issue concerned interval evaluation, not the modular transformation identity.

## Receipt semantics and remaining work

Every complex box has readable `re`/`im` endpoints rounded outward to multiples of `2^-128`. These coarse display boxes must not be substituted for the finer internal inputs in a downstream precision argument. The parallel `binary_re`/`binary_im` endpoints preserve compact exact dyadics as `mantissa*2^exponent`; corresponding binary fields retain pi, root intermediates and tail bounds. This avoids enormous decimal denominators for exponentially small terms while preserving the computed interval endpoints. Zero and very small boxes are retained rather than suppressed.

The script is a deterministic arithmetic recipe apart from timing fields. It retains all reduced pair terms and propagation jets; direct pair terms are reproducible from the exact input and recorded N. Independent review should check the exact transformation word, root branches, derivatives and tail majorants, and repeat direct evaluation with different parameters. A formal elementary interval checker, theta transformation proofs in the target library, and a composition proof for the serialized arithmetic remain separate implementation work. No integration error, Fourier truncation error, spectral count, or improved proof status for the Goldbach theorem is inferred here.
