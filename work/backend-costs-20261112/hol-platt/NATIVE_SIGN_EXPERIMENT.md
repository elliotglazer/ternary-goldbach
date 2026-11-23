# A native sign-margin screen for the actual conductor-10000 block

13 November 2026. Source-only proposal. No character, L-value, Gamma value, coefficient, transform or sign was computed. No package was imported, benchmark run or frozen model changed.

The shortest useful next implementation is an **eight-value native interval screen**, before constructing the full theta coefficient array. It can determine whether a fixed lower time-transform precision has enough mathematical margin at low, middle and top heights of the actual selected block. It cannot measure that transform's speed or certify its remaining samples. The installed python-flint interface already exposes the required actual Dirichlet L-function, complex Gamma and interval arithmetic. A full HOL analytic library is not required to run this diagnostic; its results would still be native interval evidence, not HOL theorems.

## One fixed experiment

Retain the selected conductor-10000 block from `SMALL_FAMILY_PILOT.md`: theta=64, V=6580, Delta=5/64, N=524288, period P=40960, omega=pi/20480, J=68267, Wbar=1250000 and eps=2^-80/(4*3^64). The current sufficient raw time-gate tolerance is 2^-243. Test the single alternative u=2^-160, retaining the original coefficient/source budgets. This is a gate error in complex norm, **not** a request to set a floating-point package to 160 significant bits.

Use the same two primitive odd characters specified in the earlier packet. Their CRT coordinates modulo 16 and 625 are

    chi((-1)^e * 5^j, 2^h) = exp(2*pi*i*(j/4+h/500)),
    chi_inverse = conjugate(chi).

The candidate native Conrey numbers are 1877 and 2813. The constructor is documented in its versioned implementation as using Conrey numbers. Do not silently assume that its internal generators match these coordinates. Before any L-function call, check modulus and conductor 10000, primitiveness, odd parity, group exponent 500, mutual inverse, and these exact character exponents:

| CRT generator as a residue modulo 10000 | chi exponent / 500 | inverse exponent / 500 |
|---|---:|---:|
|8751 = (-1,1)|0|0|
|2501 = (5,1)|125|375|
|9377 = (1,2)|1|499|

The two coordinate-generator order/bijection facts remain part of the mathematical descriptor. The proposed numeric labels come from 1877 congruent to (5,2) and its inverse 2813; their product is 5280001. A mismatch is a stopped diagnostic, not permission to relabel a result after the fact. Use exact integer character metadata for these checks. There is no need to enumerate 1600 characters.

Evaluate both channels at the four fixed rational heights

    t = 0, 5/64, 3290, 6580.

These are actual requested grid indices 0, 1, 42112 and 84224. No easy-point search, height truncation or replacement small FFT is involved. Start the reference evaluator at one declared working precision, for example 512 significant bits. Record its achieved ball radii; that working precision alone proves no error bound. If it cannot return finite useful enclosures within a separately approved execution cap, stop. This proposal does not authorize an unbounded retry loop.

## Exact reference function and acceptance inequality

For odd chi put w=3/4+i*t/2, s=1/2+i*t and b=pi/4-16/1645. The actual source normalization, on this pole-free line, is

    Q_chi(t) = exp(-3*log(pi)/4 + b*t
                    + i*t*log(10000/pi)/2 + logGamma(w)) * L(s,chi),
    F_b,chi(t) = epsilon_chi * Q_chi(t).

Here epsilon_chi is the fixed unit phase of the source character. The identity follows from `completedLFunction(s)=pi^(-3/4-it/2)*Gamma(w)*L(s,chi)` and the existing definition of F_b. Combining logGamma and the real exponential in one exponent avoids constructing a very small Gamma factor and a very large positive factor separately. It does not change their product or remove any conditioning of L. All constants and input rationals must enter the ball API exactly or as certified intervals. Do not use Python binary floating-point pi, 0.75 or 5/64 as an untracked input approximation.

The first screen needs no phase computation: |F_b|=|Q| because |epsilon_chi|=1. This is a modulus comparison for a known real normalized function, not a sign output. Use the complete proposed raw-output radius

    R = 3*eps/(4*L0)
        + N*42*2^-160*(2*Wbar^2+2),
    L0 = 6/P,     H0 = 44/(7*P),     0<L0<omega<H0.

The first term bounds all retained pre-time errors after dividing by omega; the second is the existing radix-two theorem including root and arithmetic errors. The hypotheses about the coefficient centers, root enclosures, gate errors and N remain mandatory. No interpolation error is included, since these eight targets are on the original coarse grid.

Let a be a rigorous lower bound for |Q_chi(t)| from the reference ball. Record **pass** only if the strict, outward-checked inequality

    a > 2*H0*R

holds. This deliberately avoids computing omega in the comparison. It implies |F_b/omega|>2R. Consequently, any real center z from a correctly implemented candidate transform with |z-F_b/omega|<=R satisfies |z|>R and has the true sign. This is the complete short argument: |z| >= |F_b/omega|-R > R. A failed inequality means only that this sufficient screen did not certify the chosen precision at that point. It does not prove the actual candidate transform, or its sign, would fail.

To report **canonical signs** as well as margin passes, compute the fixed phase once per channel. Form the positive Gauss sum tau=sum_r chi(r)*exp(2*pi*i*r/10000), W=tau/(100*i), and use the existing certified chart construction for epsilon^2*W=1. Preserve the source's chart/branch identifier at all four heights. Then enclose Re(epsilon*Q) and check its interval excludes zero. The equality that epsilon*Q is real comes from the actual functional equation and phase convention, not from a small observed imaginary interval. Do not substitute `hardy_z` without first proving its normalization and phase agreement. Computing tau directly requires at most 4000 nonzero terms per channel; this is separate setup, not eight cheap scalar operations. The phase-free margin screen can precede it and does not purport to export signs.

## Available implementation, and the short missing adapter

The installed `work/qrh-campaign/interval-env/Lib/site-packages/flint/types/dirichlet.pyi` exposes `dirichlet_char`, exact character metadata, `chi_exponent`, `l_function` and `hardy_z`. Its compiled Windows extension is present. The versioned python-flint 0.9.0 implementation constructs Conrey characters and calls `acb_dirichlet_l` for `l_function`; this is an actual L-function evaluator, not a stored zero list. See the [versioned implementation](https://raw.githubusercontent.com/flintlib/python-flint/0.9.0/src/flint/types/dirichlet.pyx) and [official API description](https://python-flint.readthedocs.io/en/latest/dirichlet.html). No claim of a formal proof of FLINT's implementation is made here.

The installed `acb.pyi` exposes `lgamma`, `exp`, `abs_lower` and a native `dft` entry point. The first screen needs only the scalar operations. The missing adapter is small and specific: exact character binding, exact rational arguments, the displayed completion formula, outward comparison with the rational 2*H0*R, and a receipt containing all eight input identities and enclosures. The optional sign stage adds the fixed Gauss/phase certificate. Bind package/binary versions and precision in that receipt; neither a type stub nor a successful import certifies the numerical output.

Use an exclusive bounded result file, for example at most 256 KiB for the eight scalar records plus character/phase summaries. Keep no time array. Report measured resource use only if a later run is authorized. Native L-function calls may allocate internal tables; the small exported record is not a bound on peak memory. A later run needs an explicit process memory/time cap and must preserve any stopped or inconclusive result.

The saved historical `low_q_f1.3.cpp` supplies a positive unnormalized FFT but explicitly reads output from `split1.2`. It does not close the coefficient-generation gap. The installed native DFT likewise does not generate coefficients or establish our sign/normalization convention. No complete coefficient fixture for this block was found in the bounded inspection.

## What a pass would justify next

A pass would provide concrete native evidence that the inherited absolute-output budget is unnecessarily tight at the eight chosen targets, and a conditional mathematical guarantee for those targets under the stated time-transform contract. It would justify implementing the already specified two-channel full-N block with the same fine coefficients and a 2^-160 gate budget. That later experiment must test all 168450 requested channel/grid sites, report every inconclusive point and separately price repair. Its 9961472 butterflies and up-to-111924567 Gaussian source terms cannot be inferred from eight direct L calls or omitted from a timing comparison.

The 83-bit reduction concerns the sufficient **time-gate tolerance** only. It does not lower the current 302-bit Gaussian seed budget, the finer phase/ancillary budgets, the coefficient count, N, or the Turing auxiliary workload. It does not guarantee that 53-bit arithmetic suffices. To change the full historical-hours comparison, later measurements must include source construction, actual full-transform error control and repair costs. A pointwise native evaluator can also be a repair backend, but evaluating every requested point directly is a different algorithm whose cost is not measured here.

No finite-RH, zero count, simplicity or central multiplicity follows from this diagnostic. Opposite strict signs may later supply disjoint critical-line lower evidence. Canonical Turing upper bounds, auxiliary domains and all remaining channels are unchanged. The existing HOL proof gap also remains: native interval evidence can guide the algorithm before the analytic library exists, but it is not an ordinary-rule HOL certificate.

## Local evidence pins

| File | SHA256 |
|---|---|
|hol-platt/SMALL_FAMILY_PILOT.md|2F1C199CABC9B438D03A887C581BACC0FEF016B50FD8336577EB623EDFEC0F35|
|hol-platt/PRECISION_RESEARCH.md|957B4878CD16FD7EBC7F5DE235A4FBB707F3CD92C2753E58C50AC8E1584540A8|
|agents/audit/SMALL_THETA_RAW_POLYNOMIAL_SIGN_INTERFACE_2026-11-11.md|076030481DEB4A922356A5BC0B8CCB243DF3FBB15A0DD427A29DEB044E82D430|
|agents/integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md|19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081|
|flint/types/dirichlet.pyi|2FA0555EB5D6D10F51B807F4194F8A6CBF27654B86CCDC092F0751C964F86401|
|flint/types/acb.pyi|661B8C4076559FE71B5DB475DEBAAF0E1B90F2D350DAC5FC71E0508C80FF78D0|
|flint/flint_base/flint_context.pyi|72BF036F201F38270A7EDA8E66DA4DA966DAEFCF3E9AD57C9FC114062356F5DC|

The first two prefixes are under `work/backend-costs-20261112`; `agents` is under `work/qrh-campaign`; `flint` is under the existing interval environment's `Lib/site-packages`. The earlier pilot pins the selected metadata and coefficient-source papers. This report adds no evaluator result or claim that a future full-array implementation is already present.
