# Raw finite-polynomial signs without output rescaling

2026-11-11. Conditional paper construction and exact saved-metadata arithmetic. No function values, transforms, primes, zeros or builds were evaluated. No frozen ledger is changed by this note.

The small-theta sign route can omit both the final multiplication by omega and every positive Y-rescaling operation. It must retain the actual phase-normalized coefficient array and interpolate its raw finite-DFT polynomial with errors in the corresponding units. A raw sign, without the translated error threshold, is not sufficient. This construction keeps all Gaussian, character, phase and counting obligations.

## 1. Exact function and source boundary

Use the finite-polynomial interpolation report `integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md`, SHA256 `19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081`, and its independent review `moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md`, SHA256 `B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F`.

For one actual primitive nonprincipal character, fix its canonical unit phase epsilon_chi for the entire record. Distinguish that phase from the positive error budget `eps=tau/(4*3^theta)`. Let Delta=5/64, P=N*Delta, omega=2*pi/P and J=ceil(P*10/6)<N/2. The exact stored coefficient centers A satisfy A_0 real and A_-j=conj(A_j). Define

    U(t)=A_0+2 Re sum_(j=1)^J A_j exp(i*j*omega*t),
    T(t)=omega*U(t).

U and T are exact real periodic finite polynomials. Neither is the exact L-function. The accepted pre-time-arithmetic comparison is

    |F_b(t)-omega*U(t)| < 3*eps/4,       0<=t<=V,
    Y(t)=exp(theta*t/V)*F_b(t),
    b=pi/4-theta/V.

The first line includes time periodization, frequency truncation and coefficient errors. It is applied once at the target, not once at every interpolation sample. The second line has a strictly positive multiplier. Multiplication by omega is also strictly positive, so strict signs of F_b/omega, F_b and Y agree with the canonical Hardy signs.

The actual computed time transform is the positive unnormalized DFT. Its exact grid values are U(k*Delta). A normalized implementation instead gives U/N and has positive multiplier omega*N=2*pi/Delta. The factor N must be bound explicitly; it is not a character-group dimension. The formulas below choose the unnormalized implementation and introduce no new division gates.

## 2. Rational error units and strict sign contract

Put L=6/P and H=44/(7P). The elementary bounds 3<pi<22/7 give

    0<L<omega<H.

These are rational metadata. They do not require a new numerical omega enclosure. Every occurrence of omega in the coefficient construction, transform roots and exact frequency grid remains; only its final output multiplication is removed.

Let B=2*Wbar^2+1, C_U=(2J+1)B and M=44B. Then |U(t)|<=C_U and |U^(r)(t)|<=C_U*Omega^r, with the same Omega=J*omega<=242/21 as in the accepted interpolation proof. Moreover

    H*(2J+1) <= (44/7)*(10/3+3/P) <=506/21<44

because P>=6. Thus H*C_U<M. The same 340-point centered Lagrange interpolant has remainder less than eps/(16H), since the already checked worst-case inequality is `M*(605/1344)^340<eps/16`. This holds for all accepted integer theta in [64,128]: Wbar never exceeds1250000 and eps never falls below the theta128 budget.

Require each raw grid sample center to enclose its exact U value with radius at most eps/(64H). The seven exact Lagrange kernels have l1 norm below4, so sample uncertainty contributes less than eps/(16H). Allow another eps/(16H) for kernel representation and all interpolation arithmetic. Then an interpolated real center z obeys

    |F_b(t)/omega-z|
      < 3*eps/(4L)+3*eps/(16H)
      = (109/704)*eps*P =: E_raw.                         (1)

The generic record can therefore use the exact rational tests `z>E_raw` or `z<-E_raw`. For coarse grid targets the same radius is conservative because interpolation errors are absent. The looser radius `5*eps*P/32` is also sufficient. Each common radius, or a verified upward dyadic rounding of it, can be shared by all requests with the same parameters. The individual strict comparisons still require proof.

For perspective, H*E_raw=(109/112)*eps<eps. Thus even this rationally overestimated radius has physical F-scale error below eps. A direct proof before overestimating omega gives the sharper physical bound15*eps/16. These statements do not compute omega*z or produce an exported Y value. If the threshold rejects a near-zero center, no sign is proved; no guaranteed success or repair rate is claimed.

## 3. Time FFT and interpolation arithmetic

The actual radix-two lemma in `zero-sum/MIXED_RADIX_PRECISION_ERROR_SUPPLEMENT_2026-11-11.md`, equations1–3, gives for exact stored input bounded by B and k=log2N

    |computed_DFT-U| <= N*Ctime*u*(B+1),
    Ctime=2k+4,       0<u<=1/(2k).

The backend's old gate tolerance is at most `eps*Delta/[56*Ctime*(B+1)]`. Divide this tolerance by8. The raw output error is then at most eps*P/448, which is strictly less than eps/(64H), since H<7/P. This includes twiddle uncertainty and arithmetic under the same complex norm gate contract. Real projection cannot enlarge the error because exact U is real.

Consequently three extra fractional bits relative to that old sufficient time-gate budget suffice for this raw interpolation route. The accepted scaled-T interpolation used four extra bits to tighten its whole time-output allowance, including omega approximation and final scaling. Retaining those four bits is also valid. The one-bit relaxation here is only for this stated time-gate contract; it does not relax Gaussian, character or phase tolerances, and it is not a statement about total word widths or runtime.

For completeness, take raw sample centers bounded by C_U+1, as eps/(64H)<1 on these finite rows. Indeed P<2^31 and eps<=2^-80 give eps*7P/2816<1. A sufficient kernel error per weight is

    eps/[32*340*H*(C_U+1)],

with total product/accumulation rounding at most eps/(32H). Decompose using exact weights on the uncertain samples first, then weight error times the stored centers. This accounts for the cross term. The two arithmetic contributions total at most eps/(16H).

No tighter weight representation is required than the old sufficient `eps/[32*340*(M+1)]`, because

    H*(C_U+1) <= (506/21)B+22/21 <=44B+1=M+1.

The current P>=V>=2700 also implies H<1, so retaining the former eps/32 total rounding allowance is safe. The raw operands can nevertheless have larger integer parts than the T operands. Exact product width, rounding implementation and proof costs must be rechecked for that representation. The proof above is not permission to use the old scaled operands or to ignore their magnitude change.

The finite polynomial can wrap indices modulo N at either end of a stencil. This remains periodicity of U only. All final physical targets stay in [0,V]. Raw samples outside the exported physical prefix can support a stencil, since the finite DFT arithmetic theorem holds at all N indices. The retained/recomputed raw sample dependency union and its coefficient-array identity remain mandatory. Omitting Y output does not remove that union or the time transform.

## 4. Which consumers admit the shortcut

Strict endpoint signs, sign-change brackets, their rational interval weights, and the same sign-based Turing lower-count interface can use (1). All signs must refer to the same actual character and fixed phase. Two positive channels for a nonreal pair remain distinct. Frequency Hermitian symmetry is not a reason to identify them. Central nonzero signs are possible through the same contract, but exact central multiplicity requires its own evidence.

The canonical Turing phase and count formulas are unchanged. An argument or logarithmic derivative of U is not substituted for an argument or logarithmic derivative of the actual L-function. A root of U is not automatically an L-function zero. Only the proved strict signs transfer, after which the existing continuity and disjoint-interval argument applies. Simplicity and completeness do not follow without their existing count conditions.

Numerical Y outputs at absolute tolerance tau still need their actual amplitude conversion. Historical Gaussian/sinc interpolation of Y cannot consume raw U samples without a different theorem. Amplitude integrals, absolute L-values, general contour winding and nonzero derivative bounds likewise need their proper function and normalization contracts. This note changes none of those interfaces. It supplies an alternative finite-polynomial sign circuit, not a replacement for every output consumer.

## 5. Exact schedule deductions and limits

For the reviewed whole-small-family metadata, these coarse-prefix categories can be deleted if all exported values are used only for signs or the raw-polynomial interpolation above:

| Extra grid nodes | Removed omega complex scalings | Removed final Y real products | Removed shared positive-scale updates |
|---:|---:|---:|---:|
|0|1775431871117|1775431871117|3791938303|
|167|1778517548153|1778517548153|3793190636|
|320|1781344545677|1781344545677|3794337983|
|640|1787257220237|1787257220237|3796737663|

In each separate scenario, remove7499 positive-scale exponential seeds. Retain7499 radial exponential seeds, all outer Gaussian exponentials, roots, fixed phases and prefactors. The two real seeds have different purposes; dropping the radial one would break coefficient construction. The counts above are identical for theta64, theta128 and the accepted per-row minimal-theta choice because the exported grid geometry is unchanged.

These are typed operation counts, not interchangeable machine instructions. They do not include or cancel the large Gaussian, character or time-transform totals. The nominal main time output array has9237783904256 complex slots at theta128 or the accepted minimal choice; deleting scaling does not delete these FFT outputs or their arithmetic. If a comparator explicitly scaled the whole array to T, omitting that scaling saves one operation per consumed array slot, potentially the full number. That is a different comparator from the original prefix ledger. Do not add both the prefix count and the full-array count for the same samples.

The main dense eightfold union has14203325629180 endpoints, of which12427893758063 are new. This sign route needs no Y rescaling at any of them and no new off-grid positive-scale leaves. Those off-grid operations were not in the frozen coarse ledger, so they are avoided additions rather than a second deduction from it. The fixed 340-point direct scheme still costs4225483877741420 weighted interpolation terms if applied densely. Selected requests, polyphase convolution and different interpolation orders are separate priced choices; none is assumed here.

For Q coarse outputs, U_s shared scale updates and C conductors, the old prefix deduction has the symbolic form

    Q*cost(omega scaling)+Q*cost(Y product)
      +U_s*cost(scale update)+C*cost(scale exponential),

with actual widths and dependency reuse. Net savings must subtract any extra cost of raw interpolation widths, translated threshold handling and implementation changes. Runtime and proof-byte savings cannot be inferred from these counts alone. The new off-grid arithmetic schedule and variable-order interpolation research are not consumed by this note.

## 6. Evidence and remaining status

The owned `audit/raw_small_theta_sign_scalars_20261111.py`, SHA256 `77F9FF9C0E903F9CF723934C3DDEB6773CACD0168BA4E8243E71D0810B47C384`, and same-stem JSON, SHA256 `D6FA13513E2A01B4B3ACFFD0A93B7B0C811F864A1C4FDAB3E907FA23626532CB`, verify39 exact comparisons and saved-count identities. They bind the two interpolation reports, the whole-family receipt, the backend and shared elementary circuit, the radix-two error source, the minimal-theta review and the selected-sign contract. The receipt contains all four schedule rows and dense endpoint counts. It performs no evaluator call or author-program import.

This is a proposed paper interface for independent review. It does not silently alter an accepted ledger or create a numerical certificate. The unchanged actual coefficient bounds, analytic tails, all finite arithmetic, source bindings, signs, counts and standard-rule checker acceptance remain required. No finite RH assertion or new final mathematical premise is supplied.
