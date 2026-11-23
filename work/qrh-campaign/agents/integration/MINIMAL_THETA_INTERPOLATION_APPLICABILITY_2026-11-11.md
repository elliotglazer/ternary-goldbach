# Interpolation for the corrected minimal-theta schedule

2026-11-11. Paper applicability supplement. No values, transforms, builds, source edits or new parameter searches. The earlier interpolation report remains unchanged.

## Exact extension

The full-range finite-polynomial interpolation construction in `SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md`, SHA 19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081, explicitly stated theta in {64,128}. This supplement extends that construction to every selected integer theta in [64,128] in the corrected minimal-theta schedule. It does not claim that the old statement already covered those intermediate values.

The inputs are the minimal-theta report, SHA 73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A, its mandatory bucket-rounding clarification, SHA 4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41, and their independent review, SHA 58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B. In particular, the incorrect exact-bucket sentence in the original report is not an input to this argument.

Fix any of the 29,996 selected conductor/guard rows. It retains the same primitive labels, parity channels, closed [0,V] target, Delta=5/64 and tau=2^-80. Let theta be its selected integer, epsilon=tau/(4*3^theta), Wbar its cohort bound, N its selected time length, P=N*Delta, omega=2pi/P and J=ceil(P*10/6). Let A_j be the newly certified coefficient centers for THIS theta, including the real A_0 and conjugate negative coefficients. Use the finite real polynomial

    T(t)=omega [A_0+2 Re sum_(j=1)^J A_j exp(i*j*omega*t)].

The result is unchanged: for every requested eighth-grid target t=(k+ell/8)Delta in [0,V], the 340-node interpolation procedure below yields an enclosure of F_b(t), b=pi/4-theta/V, with error below epsilon. It therefore yields its strict Hardy sign whenever the enclosure excludes zero. The optional positive scaling gives a Y enclosure with error below3tau/4 under the previous final-scale allocation.

## Why every intermediate theta satisfies the analytic hypotheses

The minimal-theta packet and review verify the full selector separately at all 130 cohort/integer-theta combinations, rather than infer admission from the two endpoints. This includes the time-periodization conditions, omitted-frequency bound, Gaussian truncation and elementary-circuit conditions. For every selected row,

    64<=theta<=128, V>=2theta, 1<=cV/theta<=Wbar<=1250000,
    X=10, C=44, n0=8192,
    P>=max(2VK/theta,V+2K,6), J<N/2.

Consequently the same three pre-time-FFT errors give |F_b(t)-T(t)|<3epsilon/4 uniformly on [0,V]. The corrected rounded bucket additions are part of this coefficient error, not omitted work. Their per-addition norm allowance remains epsilon/(32*C*Bpref*n0), and the hT additions remain charged. The Gaussian seed, intrinsic character-transform, prefactor and coefficient-product allocations also remain those of the selected row.

The interpolation proof uses only bounds that are uniform on this range:

    |A_j|<=B=2Wbar^2+1,
    |T^(r)(t)|<=M*Omega^r,
    M=44B<=44(2*1250000^2+1)<2^48,
    Omega=J*omega<=242/21,
    epsilon>=epsilon128=2^-80/(4*3^128).

Thus the already verified rational inequality

    44(2*1250000^2+1)*(605/1344)^340 <epsilon128/16

implies the required interpolation remainder below epsilon/16. The exact seven Lagrange kernels at ell/8 are independent of theta, conductor, parity and N; their norm sums remain below4. Their earlier proof and exact rational metadata apply without a new evaluation.

These inequalities establish applicability to intermediate theta, but do not license reuse of the old theta128 coefficient values. Equal transform lengths do not make different tilted functions identical. Their centers and all their numerical certificates still need to be produced for the selected theta.

## Exact change to the selected row's time allocations

Put k=log2(N) and Ctime=2k+4. The corrected minimal-theta schedule's local time tolerance is

    u_time(theta)=min(1/(2k),epsilon*Delta/[56*Ctime*(B+1)]).

For interpolation, take

    u_time,I =u_time(theta)/16
             =min(1/(32k),epsilon*Delta/[896*Ctime*(B+1)]).

Divide the other two time-output tolerances by the same factor:

    omega approximation: epsilon/[256*N*(B+1)],
    final omega-output multiplication rounding: epsilon/256.

The original values were epsilon/[16*N*(B+1)] and epsilon/16. Under the same radix-two error theorem, the intrinsic FFT contribution is then at most epsilon/128, and omega approximation plus final multiplication contribute at most epsilon/128. Every one of the N resulting samples encloses T(jDelta) with error at most epsilon/64.

“Four extra bits” means four extra fractional bits relative to each SELECTED THETA's own sufficient time-root/gate, omega and final time-output rounding requirements. If a dyadic radius 2^-p met the old local tolerance, 2^(-p-4) meets its divided tolerance. It is not four bits added to every stage, not a claim about total word width, and not a rule to reuse theta128 bit counts unchanged. Shared caches still use the strictest request among their actual consumers.

The earlier interpolation ledger now applies verbatim:

    target-only analytic/coefficient error <3epsilon/4,
    sample errors through sum|l_j|<4       <epsilon/16,
    real interpolation remainder          <epsilon/16,
    rounded kernels and accumulation      <=epsilon/16.

The total is below15epsilon/16. Sample indices wrap modulo N only for T; those beyond V make no claim about the analytic F_b or Y there. All final targets stay in [0,V]. No additional analytic halo or zero-separation premise is introduced.

For explicit Y values, the previous off-grid positive-scale construction uses the selected theta, V and B. Its optional coarse-scale refinement is separate from these four time-arithmetic bits. For sign-only endpoints this final positive scaling can be omitted, using the proved identity Y=exp(theta*t/V)F_b. Neither choice changes the canonical Turing phase or supplies a successful count.

## Cost and scope

There is no new Gaussian/bucket/character operation or precision requirement from this extension. All of those previously required operations, including rounded bucket additions, remain mandatory. N, J, the 340-term local query cost and the seven shared rational kernels are unchanged. Time arithmetic has the explicit stricter tolerances above. Retaining or reconstructing the T samples and their exact coefficient bindings remains necessary; the old exported Y prefix alone is insufficient.

This is an applicability proof, not a new all-row metadata computation. It relies on the independently reviewed 130 selector and 29,996 selected-row admissions, and on the earlier exact worst-case interpolation inequality and kernel norms. It does not add checks to either frozen receipt. Actual values, sign success, auxiliary sufficiency, finite-RH closure and implementation performance remain open.

## Frozen inputs

| File | SHA-256 |
|---|---|
| `work/qrh-campaign/agents/prime-estimates/MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md` | `73337A5EB2688E5B1A5196A901232A314D89F3E48B5EEFC013CA178A8FFA238A` |
| `work/qrh-campaign/agents/prime-estimates/CLARIFICATION_MINIMAL_THETA_BUCKET_ROUNDING_2026-11-11.md` | `4ACF800D0F7C773FA5A2DF013BD5F1341ED3CC98C0F9D257D81A2EE63B480D41` |
| `work/qrh-campaign/agents/audit/REVIEW_MINIMAL_THETA_AT_FIXED_TIME_LENGTH_2026-11-11.md` | `58215EA3A0D697D229AD746F6FCE340DE913165D63599DC197798E705392308B` |
| `work/qrh-campaign/agents/integration/SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md` | `19E411982E0D504C52F604145D6404ACB3BEBA51B662CB7BB1CDBD5D31E83081` |
| `work/qrh-campaign/agents/moebius/REVIEW_SMALL_THETA_OUTPUT_INTERPOLATION_AUDIT_2026-11-11.md` | `B815BBEEF96C0E8D1259A915E8BB0F3BEB98BBD1CFB9473B038E0B3D64F3A38F` |
| `work/qrh-campaign/agents/integration/small_theta_polynomial_interpolation_20261111.py` | `5222B885C5BF9B506356C0EEFAEF2C1970AEC55BC0EFDFE24A3D267342949445` |
| `work/qrh-campaign/agents/integration/small_theta_polynomial_interpolation_20261111.json` | `F3A780AEFBD7C31BAE7CF6A7355FF5699143A3E1FFEE04B9AA00A03C667E9406` |
| `work/qrh-campaign/agents/prime-estimates/NONPRINCIPAL_SMALL_CONDUCTOR_BACKEND_COST_2026-11-11.md` | `6AA4F11AD9103A1176F24BDF045CDF798193B726B1B3A925B8540476E6823043` |
