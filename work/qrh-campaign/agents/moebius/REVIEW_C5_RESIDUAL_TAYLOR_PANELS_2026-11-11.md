# Independent review of four fixed conductor-5 residual Taylor panels

2026-11-11. **PASS for exactly the four saved panels. No correction required.** The actual L-function error, finite-function Taylor error, and fixed rational-candidate error are separately bounded and correctly propagated. The independent calculation below passes all four panels without subdividing them. This does not complete the predecessor boundary or establish a new full-rectangle zero-free certificate.

## Frozen scope and verification

Reviewed author note `../zero-sum/C5_RESIDUAL_TAYLOR_PANELS_2026-11-11.md`, SHA256 `91AFE6E39AE15CC85DC5A8C7E74D18A8CFBF60F2106DACD361946002A43D371A`. Its script has SHA256 `F1F91D5BC8B9DAF5BCA8B44FA55C1D333500662496157A453FB9E70CBD37FE4C`; its receipt has SHA256 `8801DEBF7956C20403B20A1A04819B61E5FAFAF2A8FA39DA10E3888132C28F8C`.

The unchanged exact rational candidate has SHA256 `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`. The predecessor's incomplete receipt has SHA256 `7FAA8640C48E48C6BB03CE3AA0921CE77042F42A464E1F371221E888AEE946EA`. The indices are exactly29999,3871,457,24860 in its saved attempt array. I checked their exact endpoints against that array. No new fit, pole, panel, subdivision, or boundary extension is used in the author or independent calculation.

The author's read-only `--recompute` completed successfully and reproduced every non-timing receipt field, including all coefficient balls, error bounds, old classifications and new residual tests. The recorded status is `FOUR_FIXED_PANELS_ONLY`, with `full_rectangle_certified: false`.

The independent script is `review_c5_taylor_panels_20261111.py`, SHA256 `B00458A4885C842DAF57CBC6A095BA9134E115898A7670D49111E92B8385409F`. Its receipt has SHA256 `C5EF4C18324F26E09FF3C1B5FFBBD094075EDBDF5796963ABF576476E87F5F6B`. The script asserts all five author input hashes before calculation. It uses N80/M24 rather than N64/M20, degree14 rather than12, outer radius1/8 rather than1/4, and224-bit arithmetic with freshly formed constants. It implements truncated polynomial addition/multiplication and the exponential coefficients explicitly; it does not call acb_series, L, zeta, Gamma, theta, or a zero oracle. An initial local Fraction/ball coercion error was fixed before the numerical calculation; it produced no accepted receipt.

The independent result uses radial coefficient sums rather than the author's vertical-segment Horner boxes. If U_k bounds the three scalar residuals, then `||r||_1 <= sum_k U_k` by the exact inverse transform, and `T16 <= sum_k U_k^32`. These stronger-than-needed sufficient tests both pass:

| Saved attempt | Independent group l1 upper, rounded upward | Independent T16 upper, rounded upward |
| --- | ---: | ---: |
|29999|.017980|2.740e-61|
|3871|.115872|3.884e-36|
|457|.041341|1.798e-54|
|24860|.005702|1.573e-84|

This is a second rigorous analytic enclosure calculation, not a comparison based only on overlapping outputs. The exact rational bounds and parameters are retained in the independent receipt.

## The actual analytic function and finite Taylor coefficients

The reviewed c5 Euler–Maclaurin source is unchanged. For each residue, the finite function includes the initial Dirichlet sum, half endpoint, Bernoulli corrections, and the common-pole difference with exprel replaced by its degree18 polynomial. The nonprincipal positive transform, including the factor5^(-s), defines a finite entire function g_k. The actual function L_k is the entire primitive Dirichlet L-function with chi_k(2^j)=i^(kj), k=1,2,3.

The identity with actual L is first obtained on Re(s)>1 by the Hurwitz Dirichlet series, then continued. The common scalar term disappears from all three character sums. This respects the source's individual totalized-Hurwitz convention at1; no separate scalar pole-subtracted value is silently identified with that convention. The expanded control disks introduce no extra nonvanishing hypothesis.

For a disk of radius r about s0, put sigma=Re(s0)-r and S=|s0|+r. The rising-factorial norm is bounded by `product_(j=0..2M-1)(S+j)`. The periodic-Bernoulli estimate used in the reviewed EM proof gives the component remainder

`4 product(S+j) B^(1-sigma-2M) / [6^(2M)(sigma+2M-1)]`.

The integral converges because sigma+2M>1. All author control disks satisfy the stronger sigma>0:61/200 at a left center and7/4 at the right center. The independent radius1/8 gives43/100 and15/8 respectively. Thus the author does not reuse the original111/200 floor on a disk extending to its left.

For the replaced exprel, let delta be the logarithm difference and Z=(S+1)|delta|. Its omitted analytic tail is at most `exp(Z) Z^19/20!`. Multiplying by the appropriate common exponential and |delta|, summing all four residues, and multiplying by5^(-sigma) yields the stated E(r) for actual L_k-g_k. This bound is uniform on the disk, including points where the formal divided difference would have a removable singularity. The polynomial form never divides by s-1.

## Finite-function growth and Cauchy estimates

The g_k growth bound is a direct sum of the finite terms, not a borrowed bound for actual L. In particular, an initial term with base n+alpha has maximum modulus

`exp(-Re(s0) log(n+alpha) + r |log(n+alpha)|)`.

This correctly handles n=0, for which the base is below1 and the logarithm is negative. Using only the lower real endpoint for these terms would be wrong. The frozen formula includes the necessary absolute logarithm. The initially incorrect local version is explicitly disclosed by the author and is not an input to this review.

The finite corrections are bounded using positive B powers, absolute Bernoulli coefficients and the rising-factorial norm. The scale factor is bounded at sigma. All quantities are evaluated with enclosing balls. The resulting M_g controls the finite entire g_k on the full closed outer disk.

If G is its degreeD Taylor polynomial, Cauchy's estimate bounds the omitted part on radius rho<R by

`M_g (rho/R)^(D+1)/(1-rho/R)`.

The author uses D12; the independent calculation uses D14. The coefficient enclosures contain the exact finite-function coefficients, with no rounding term omitted. The actual function therefore differs from G by the sum of this finite Taylor tail and E(rho).

The optional actual-derivative interpretation is also correct. Since actual L_k-g_k is analytic on a neighborhood of the control disk, its normalized j-th derivative at the center is bounded by E(R)/R^j. These are additional coefficient error bounds, not an assertion that the finite-g coefficient balls alone contain the actual L derivatives. The panel computation does not mistakenly add or omit these derivative bounds; it instead uses the uniform actual-function error directly.

## Fixed rational candidate and residual product

Each candidate B_k is the same constant plus385 exact rational residues divided by s-p, with Re(p)=1/2. Its Taylor coefficient at s0 from one pole is `(-1)^j w/(s0-p)^(j+1)`. The code checks a strict lower bound `|s0-p|>rho` for every pole, on every panel. The geometric tail is

`sum_p |w_p| rho^(D+1) / [|s0-p|^(D+1)(|s0-p|-rho)]`.

The outer radius used for finite-g Cauchy estimates need not lie inside the pole clearance: B's analytic bound is only taken on the smaller panel disk and uses its own exact pole distances. This distinction is respected. In particular, there is no invalid attempt to apply the finite-g radius1/4 Cauchy estimate to B near the left edge.

Let P approximate B and let E_B be its tail. Let E_L bound actual L-G. Then

`|(1-LB)-(1-GP)| <= E_L (||P||+E_B)+||G|| E_B`.

The author retains both the cross term E_L E_B and all polynomial coefficient rounding. It multiplies the G and P coefficient arrays first, producing the degree24 residual polynomial. Only then does it enclose the full vertical panel. This is a valid way to preserve cancellation; it is not an evaluation at the center alone. The independent degree28 residual construction uses the same algebraic identity with independently computed coefficients and a radial polynomial norm.

The inverse transform is exactly `(1/4) sum_(k=1..3) i^(-kj)(1-L_k B_k)`. It has zero principal component. The group convolution normalization and moment identity remain those already independently reviewed in the product-feasibility and capped-run notes. No additional factor of4, principal character, or conductor factor is missing.

## Interpretation and remaining limit

The four exact panels previously had large sufficient interval bounds, but now have rigorous small bounds for the same actual residual functions and the same candidate. Thus the large earlier enclosures on these panels were not forced by large true residuals. This supports the author's limited statement about enclosure overestimation on these four panels. It does not quantify the same effect elsewhere or isolate a universal gain from one arithmetic change.

The operation counts describe finite series and coefficient operations, not equal-cost scalar operations or production throughput. The short four-panel timing is not a global benchmark. The predecessor still lacks a complete boundary certificate. No winding, full rectangle, Hcert height, larger conductor family, historical GRH, or Lean-kernel assertion is newly established here.
