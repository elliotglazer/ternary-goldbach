# Reusable transform contracts for finite-EM vertical batching

2026-11-11. Source/interface support for moebius_route. No numerical transform, function evaluation, timing, Lean declaration or build was performed. The existing FFT proofs are reviewed paper contracts; the frequency-bin/Taylor identity below is a new adapter to prove in the vertical-batching plan. A character-transform theorem alone does not establish that identity.

## Exact sign and scale

The accepted radix-two schedule, for L=2^d>=1, returns

`P_L(a)_j=(1/L)*sum_(k=0)^(L-1) a_k*exp(+2*pi*i*k*j/L)`.

It uses bit-reversed input, simultaneous butterflies `(u+w*v)/2,(u-w*v)/2`, and positive twiddles. Consequently the **unnormalized negative** transform is

`Dminus_L(a)_j=L*P_L(a)_((-j) mod L)`.

The output index reverses; the input coefficients are not conjugated. Multiplication by integer L can be exact for the rational/dyadic reference implementation. If a fixed-width implementation rounds or overflows that scale, it needs an additional error/overflow proof.

Pinned Mathlib `Mathlib/Analysis/Fourier/ZMod.lean:104` gives `dft_apply` with negative `stdAddChar (-(j*k))`; line 114 gives `invDFT_apply` with positive `stdAddChar (j*k)` and factor `(L:Complex)^-1`. The file SHA256 is `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10`, at Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. These source APIs are finite-transform identities, not proofs about a floating FFT implementation.

## Adapter for the proposed moment arrays

Use moebius_route's proposed exact grid `t_j=t0+j*Delta`, j=0,...,J-1, J>=1, and a power-of-two L>=4J. For the finite Dirichlet polynomial with n>=1, write lambda_n=log n and s0=sigma+i*t0. For each n retain a full integer q_n and define

```
k_n = q_n mod L,
delta_n = Delta*lambda_n - 2*pi*q_n/L,
r_n = J*delta_n,
y_j = j/J,
A_(h,m,k) = sum_(n:k_n=k) n^(-s0) * (-lambda_n)^h/h! * (-i*r_n)^m/m!.
```

The exact finite identity before truncation is

`n^(-s0-i*j*Delta)=n^(-s0)*exp(-2*pi*i*q_n*j/L)*exp(-i*y_j*r_n)`.

Replace only the last exponential by its first p terms. The resulting approximation to the h-th normalized s-derivative of the **finite Dirichlet polynomial** at s0+i*j*Delta is

`L * sum_(m=0)^(p-1) y_j^m * P_L(A_(h,m,*))_((-j) mod L)`.

This equation needs a new proof by exponent algebra, finite partition/reindexing and finite sum interchange. Keep h! and m! each exactly once. Keep the actual j/J in the outer polynomial even though the transform output is indexed modulo L. q_n modulo L is used only for the bin; replacing the full q_n by that residue inside delta_n generally destroys the small-residual bound. Empty bins are zero and every original finite summand belongs to exactly one bin.

For shifted positive bases n+a, replace lambda_n by log(n+a) and prove n+a>0. The actual Euler–Maclaurin correction terms and remainder are separate: if their polynomial/rational factors vary with t_j, they must be included by a valid additional finite decomposition or evaluated with their own bounds. They cannot be hidden in coefficients advertised as independent of j.

## Certified labels without a separation assumption

The proposed bin rule supplies a rational approximation xhat_n to `x_n=L*Delta*lambda_n/(2*pi)` with proved error at most 1/8, and sets q_n=floor(xhat_n+1/2). Then

`|x_n-q_n|<=5/8`, hence `|r_n|<=5*pi*J/(4L)<=5*pi/16<1`.

Only the rational floor is decided; no comparison of the exact x_n to a half integer is required. The full log/pi uncertainty must enter the xhat certificate and the residual coefficient enclosure. Neither a midpoint label alone nor informal nearest-bin rounding is an acceptance argument. The simple `pi<22/7` bound proves the last strict inequality. Zero Delta and n=1 cause no singularity in this algebra; log n=0 gives the usual zero-power conventions. The actual EM target may impose narrower domains independently.

## Error ledger for each h

Let `C_sigma=sum_n n^(-sigma)` and choose Lambda>=max_n |log n|. If R bounds all |r_n| and p>=1, the residual exponential tail gives, uniformly on j=0,...,J-1,

`E_Taylor,h <= C_sigma * Lambda^h/h! * exp(R)*R^p/p!`.

This is the elementary all-index exponential remainder, not an FFT error. The alternative bound `2*R^p/p!` requires the source complex-exponential theorem's additional checked ratio condition. A rational certificate must also enclose C_sigma, Lambda and exp(R) or valid upper bounds. Truncation of an infinite L-series and Euler–Maclaurin remainder are additional source errors.

Suppose actual bin coefficients have rational centers ahat_(h,m,k) and norm errors epsilon_(h,m,k)>=0. Include finite bin-summation rounding in those epsilons; grouping terms into bins does not remove their errors. Source input uncertainty in the **unnormalized** moment transform is at most

`sum_k epsilon_(h,m,k)`.

After the outer polynomial, its contribution is at most `sum_m y_j^m * sum_k epsilon_(h,m,k)`. There is no additional L on this term: normalization and final scaling cancel. All errors may be correlated.

Separately, if alpha_(h,m) bounds the arithmetic error in the normalized transform of its exact rational input centers, its contribution is `L*sum_m y_j^m*alpha_(h,m)`. Final polynomial arithmetic/rounding must be charged as another term. The reference implementation may instead use exact rational y_j, powers, products and sums, setting that last term to zero. Horner evaluation preserves the same polynomial but needs its own rounding recurrence if rounded.

If a later consumer transforms these outputs over character labels, its operator norm amplifies the already accumulated errors. This time-axis transform and a unit-group character transform have distinct axes and source meanings; their scales must be composed explicitly.

## Generic finite precision, without a fixed-height budget

For a moment line, provide a rational B>=max_k |ahat_k|, not merely a bound on the true coefficients. One way is the actual coefficient bound

`max_k |A_(h,m,k)| <= C_sigma * Lambda^h/h! * R^m/m!`

plus the maximum certified input radius. Cancellation may improve a certified bound, but is not presumed.

For twiddle and local complex rounding errors at most q>0, the accepted normalized FFT recurrence gives

`R_d(B,q)=(q*B/2+q)*sum_(i=0)^(d-1)(1+q/2)^i`.

If q<=1/(d+1), then `R_d(B,q)<=d*q*(B+2)`. Thus, for any positive rational **unnormalized arithmetic** allowance tau_(h,m), it suffices to choose a dyadic q satisfying

`q<=min(1/(d+1), tau_(h,m)/(2*L*(d+1)*(B+2)))`.

Then `L*R_d(B,q)<=tau_(h,m)/2`. For d=0 the transform is the identity and has no butterflies. Increasing dyadic precision terminates for finite d,L,B and positive tau. The accepted arbitrary-stage construction supplies finite Machin/Taylor twiddle certificates and directed rounding with these local errors. Approximate twiddles need not have norm exactly one. No fixed 180-bit prescription, stage cap36, Gaussian coefficient envelope, or `2*pi*L/P` output scale is imported into this new application.

To choose the moment allowances, use the exact finite weights y_j^m<=1, for example tau_(h,m)=tau_h/(2p) for p>0, leaving explicit room for input and final arithmetic errors. This is a sufficient allocation, not an efficiency claim. Increasing FFT precision cannot cure excessive source coefficient error or residual Taylor truncation.

## Arbitrary-length option and pins

The accepted Bluestein adapter permits any transform length m>=1. It returns the **unnormalized positive** DFT; use output reversal alone for the negative transform, with no extra m. Internally it pads to L>=2m-1, embeds all signed kernel differences, and has scale L^2 because all three internal transforms are normalized. Its proven arithmetic error includes chirps, products, transforms and that scale. Source input uncertainty still adds as its full sum at the external m-point DFT boundary. This alternative is unnecessary for the present power-of-two proposal, but is available if another length is justified later.

| Accepted paper contract | SHA256 / review |
|---|---|
| `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md` | `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`; review `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D` |
| `major-constants/AUXILIARY_FFT_ROUNDING_EXTENSION_2026-11-11.md` | `DA25013DFEAAACEFEAC5CF173A45B632C03BE42D1412A4EDD9D9A44E77CA4870`; review `2D3A8B62D027353636C656318E587E73DF8860982A11E3EE105F532B03982118` |
| `integration/ARBITRARY_LENGTH_CHARACTER_DFT_2026-11-11.md` | `FFF8C45E75DA6EF89D13E657C0E7C05713F861FCF7FFE47E87497C7ED624F5F1`; review `7DFADC932B61242CB39C8F840948ACCE8BED43A6F01D58860805A19B691BCA37` |

Remaining new obligations are the actual finite-EM decomposition, certified bin labels/residuals and moment centers, the residual Taylor bound at the selected parameters, schedule/refinement correctness and all arithmetic checks, final varying-factor/EM error composition, and closed panel coverage. These contracts do not produce any arrays or prove their positivity/nonvanishing. They provide no runtime, memory or production-height feasibility estimate.
