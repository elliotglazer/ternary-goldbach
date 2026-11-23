# Finite radix-two Fourier proof and rounding certificate

2026-11-11. This is a finite algebra and checker design, with a paper error proof and 13 exact scalar checks. No FFT, twiddle table, character value, sign packet, Lean build, or full scan was run. No canonical source or frozen artifact was edited. The construction supplies no zero certificate.

The analytic input is the reviewed `zero-sum/FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF`. Its independent review is `moebius/REVIEW_FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`. Their exact primitive, nonprincipal conductor-c>1 domain and their normalization are retained.

## 1. Alternative power-of-two protocol

Let T=Hcert(c), so T>=1 and c*T<=10^8, and retain

    eta=1−1/T, b=pi*eta/4, R=pi*(1+eta)/8, P=257*T.

Choose N=2^d to be the **smallest power of two with N>=4*P**, and retain one centered frequency block, with no additional folds. Then

    4*P <= N < 8*P,
    omega=2*pi/P,
    8*pi <= omega*N < 16*pi < 51,
    X=N*omega/2 >= 4*pi > 12.                                      (1)

The strict upper bound follows from minimality of d. It is not 8*pi and it is not the predecessor's bound 26. The time-alias bound is unchanged because P, eta and R are unchanged. The omitted-frequency bound is unchanged because its proof used only X>12 and omega<1. Thus the accepted analytic errors remain

    E_time < 10^(−30), E_frequency < 10^(−75).

This is a new alternative protocol, not an edit to the frozen predecessor. The common Gaussian cutoff M=100000 still gives per-frequency series error below 10^(−119), and its aggregate is now at most 51*10^(−119)<10^(−117).

The stage count has a convenient uniform bound. Since c is an integer greater than 1, T<=5*10^7. Therefore

    N < 8*257*5*10^7 = 102800000000 < 2^37.

As N=2^d, this implies d<=36. No existence of primitive characters at c=2 is needed; using that impossible row only makes the bound more conservative. These are size inequalities, not runtime or memory forecasts.

## 2. Meaning of actual-character input intervals

The exact input function remains

    F(t)=epsilon_chi*exp(b*t)*c^(i*t/2)
         *completedLFunction_chi(1/2+i*t),
    G(x)=(1/(2*pi))*integral F(t)*exp(−i*x*t) dt.

The phase epsilon_chi is one fixed exact unit complex number satisfying epsilon_chi^2*W_chi=1. Character, conductor, parity and inverse-character labels refer to the actual source objects, not independently named arrays. In particular no spectral statement is hidden in this input definition.

For j in J_N={−N/2,...,N/2−1}, put C_j=G(j*omega). A coefficient packet contains a rational complex center z_j and a nonnegative rational radius r_j, with a checked proof

    |C_j−z_j| <= r_j.                                              (2)

The packet must obtain (2) from the Gaussian identity and its finite-series tail, together with interval proofs for every numerical ingredient. Those ingredients include the character values, fixed root phase, the exact frequency j*(2*pi/P), the tilt, conductor powers, exponentials, and all arithmetic. A numerical sample that merely resembles G is insufficient. For negative frequency the accepted reciprocal formula uses epsilon_chi*W_chi and the inverse character with the opposite imaginary shift. It does not substitute an unrelated inverse-character phase.

One admissible uniform packet target is

    r_j <= 10^(−119)+10^(−50),

where the first term is the proved series tail and the second is a separately verified rounding enclosure. Those coefficient packets have **not** been generated in this task. Relation (2) is a temporary correctness interface for finite data, not a proposed permanent assumption in Goldbach.

Rectangular complex intervals may be converted to this disk form. If the real and imaginary errors are bounded by rational r_re and r_im, one can use r_re+r_im, or prove a tighter rational r with r^2>=r_re^2+r_im^2. Correlations from reusing one epsilon, pi interval or character value do not invalidate any bound below: the proofs use pointwise deterministic enclosures, never independence or statistical cancellation.

## 3. Centered indices, bit reversal, and the exact invariant

Convert the coefficient centers to a residue-indexed array a_0,...,a_(N−1) by

    j(k)=k if k<N/2, and j(k)=k−N otherwise,
    a_k=z_(j(k)).

This maps k=N/2 to the negative Nyquist index −N/2. For every integer output label m,

    exp(2*pi*i*j(k)*m/N)=exp(2*pi*i*k*m/N).

Hence centered indexing is an exact permutation, with no extra phase. The desired normalized transform of these centers is

\[
 Y_m=\frac1N\sum_{k=0}^{N-1}a_k e^{2\pi i km/N}.                    \tag{3}
\]

Define rev_h to reverse exactly h binary digits, with rev_0(0)=0. Start an array with a_(rev_d(k)). At stage ell=1,...,d, set mlen=2^ell. For each block and each r=0,...,mlen/2−1, read its two entries u,v at positions r and r+mlen/2, and replace them simultaneously by

\[
 \frac{u+\zeta_{\mathrm{mlen},r}v}{2},\qquad
 \frac{u-\zeta_{\mathrm{mlen},r}v}{2},\qquad
 \zeta_{\mathrm{mlen},r}=e^{2\pi i r/\mathrm{mlen}}.                 \tag{4}
\]

Every stage is normalized by 1/2. All twiddles have the **positive** exponent. Output entries are in ordinary residue order after the final stage.

Here is a precise invariant that proves this claim. After stage ell, let mlen=2^ell and let b index a contiguous block of length mlen. Its entry r equals

\[
 \frac1{\mathrm{mlen}}\sum_{j=0}^{\mathrm{mlen}-1}
 a_{\operatorname{rev}_{d-\ell}(b)+2^{d-\ell}j}
             e^{2\pi i jr/\mathrm{mlen}}.                           \tag{5}
\]

At ell=0, this is the bit-reversed input. To pass to the next stage, put h=d−ell. The preceding subblocks have labels 2*b and 2*b+1, and

    rev_(h+1)(2*b)=rev_h(b),
    rev_(h+1)(2*b+1)=rev_h(b)+2^h.

Their sums are the even-j and odd-j parts of (5). Multiplication of the odd part by exp(2*pi*i*r/mlen) produces the first output. Replacing r by r+mlen/2 changes only that odd contribution's sign, producing the second output. The extra 1/2 gives the correct normalization. At ell=d there is one block, the offset is 0, and (5) is (3).

This is an exact induction, not an assertion about a library's FFT. A concrete implementation may use another schedule only after proving its correspondence to (4) or directly to (3). In pinned Mathlib `Analysis/Fourier/ZMod.lean:114`, `invDFT_apply` has exactly the positive exponent and 1/N in (3).

For a target centered time label m with |m*P/N|<=T, read the output at residue m mod N and set t_m=m*P/N. The exact output scale is

    s_fft=omega*N=2*pi*N/P.

Thus the desired finite sum is s_fft*Y_(m mod N), not omega*Y and not Y alone. The accepted alias theorem relates it to F(t_m); F itself is not asserted to be periodic.

## 4. Exact input error and arithmetic error are separate

Let Y^C be (3) with the actual C_j in place of their centers. For every m,

\[
 |Y^C_m-Y_m|\le\frac1N\sum_{j\in J_N}r_j.                          \tag{6}
\]

After multiplication by s_fft this is omega*sum r_j, exactly the input term in the alias proof. It need not be multiplied by a stagewise twiddle-error amplification. We measure the arithmetic algorithm's error against the **exact transform of the rational centers**, and use (6) separately.

Write B=max_k|a_k|. In the exact normalized algorithm every intermediate entry has norm at most B, either from (5) or the triangle inequality in (4). The accepted envelope gives |C_j|<=10^8. With the proposed input radii, therefore

    B < B_star=100000001.                                          (7)

An actual checker may instead verify a tighter rational B directly from its centers. Inequality (7) is only used for a uniform example.

## 5. A stagewise rounding theorem including twiddles

Suppose every twiddle used in stage ell has a rational center zeta_hat with

    |zeta_hat−zeta| <= delta_ell,

and each computed output center differs from the exact rational expression (u_hat +/- zeta_hat*v_hat)/2 by at most rho_ell. These are absolute complex errors, separately for both outputs.

Let E_ell bound the maximum difference between the computed stage-ell centers and the ideal stage-ell array for input a. Then E_0=0, assuming bit reversal is exact, and

\[
 E_\ell\le(1+\delta_\ell/2)E_{\ell-1}
                 +(\delta_\ell/2)B+\rho_\ell.                     \tag{8}
\]

Indeed |zeta_hat|<=1+delta_ell, and for either sign

    |u_hat +/- zeta_hat*v_hat − (u +/- zeta*v)|
      <= E_(ell−1)+(1+delta_ell)*E_(ell−1)+delta_ell*B.

Division by 2 and the local rounding radius give (8). This proof permits every twiddle and rounding error to be correlated or adversarial. No numerical-stability black box is used.

One useful nonuniform form is

\[
 E_d\le\sum_{j=1}^d
       (\delta_j B/2+\rho_j)
       \prod_{r=j+1}^d(1+\delta_r/2).                              \tag{9}
\]

Alternatively, a checker can propagate different error radii per entry. From exact-twiddle norm 1 and a bound |zeta_hat−zeta|<=delta, a direct disk rule is

    radius_out <= (radius_u+radius_v+delta*|v_hat|)/2+rho_out.

This follows by writing zeta*v−zeta_hat*v_hat as zeta*(v−v_hat)+(zeta−zeta_hat)*v_hat. Either rule is valid; the proof must use the same reference quantities as its implementation.

Finally suppose a rational scale center s_hat satisfies |s_hat−s_fft|<=delta_scale, and the final rounded center V differs from s_hat*Y_hat by at most rho_final. Then

\[
 |V-s_{\rm fft}Y|
 \le s_{\rm fft}E_d+\delta_{\rm scale}(B+E_d)+\rho_{\rm final}.      \tag{10}
\]

This includes both the final pi-dependent scale and the final multiplication. Omitting either would leave an unaccounted numerical error.

## 6. Constructive twiddle and rounding enclosures

The following is a simple finite construction proving that the local radii in (8) and (10) can be met in principle. It is not an optimized implementation and no twiddle table was evaluated.

For a rational real q define

    Round_p(q)=floor(2^p*q)/2^p,

and apply it separately to complex components. For all signed q, the real error is less than 2^(−p). The complex error is less than 2^(1−p). Choose p=180. In every butterfly compute the exact rational expression in (4) using rational centers, then apply Round_180 componentwise. This gives

    rho_ell < 2^(−179) < 10^(−52).                                 (11)

Equivalently a certificate checker can verify the exact integer floor inequalities by cross multiplication. A floating implementation would need to prove it obeys equivalent bounds; this note does not grant it those bounds automatically.

For a rational pi center, define S_50(x)=sum_(j=0)^49 (−1)^j*x^(2*j+1)/(2*j+1), and

    pi_hat=16*S_50(1/5)−4*S_50(1/239),
    e_pi=16/(101*5^101)+4/(101*239^101).

The finite geometric identity for 1/(1+t^2), integrated from 0 to x, proves

    |arctan(x)−S_50(x)| <= x^101/101, 0<=x<=1.

Machin's identity gives |pi_hat−pi|<=e_pi. To recall its elementary proof, tan(2*arctan(1/5))=5/12, tan(4*arctan(1/5))=120/119, and subtraction of arctan(1/239) gives tangent 1 exactly. The angle is positive and less than 4/5<pi/2, so it equals pi/4. Consequently pi=16*arctan(1/5)−4*arctan(1/239), with no branch ambiguity. The accompanying rational checks give

    3<pi_hat<22/7, e_pi<10^(−60).

For each mlen=2^ell and 0<=r<mlen/2 put theta_hat=2*pi_hat*r/mlen, and form the exact rational complex polynomial

    T_64(i*theta_hat)=sum_(j=0)^64 (i*theta_hat)^j/j!.

Because 0<=theta_hat<22/7, its exponential remainder is bounded by

\[
 E_{64}=\frac{(22/7)^{65}}{65!}
           \frac1{1-(22/7)/66}.                                  \tag{12}
\]

This is the first omitted absolute term times a geometric majorant for subsequent ratios. The true angle differs from theta_hat by at most e_pi, since 2*r/mlen<1. The real-axis exponential Lipschitz bound gives a corresponding error at most e_pi in the unit complex exponential. Therefore taking

    zeta_hat=Round_180(T_64(i*theta_hat))

ensures

    |zeta_hat−exp(2*pi*i*r/mlen)|
      <= e_pi+E_64+2^(−179) < delta=10^(−52).                       (13)

No assumption that zeta_hat itself has norm 1 is made. The exact twiddle has norm 1, which is what the stage proof uses. Exact special twiddles such as 1 or i can be substituted if desired, but the uniform construction already suffices.

For the output scale choose s_hat=Round_180(2*pi_hat*N/P). Here P is rational because the selected T is rational. Since 2*N/P<16,

    |s_hat−s_fft| <= 16*e_pi+2^(−180) < delta.                      (14)

Round the exact rational final product s_hat*Y_hat componentwise as well, giving rho_final<delta. These instructions define local error proofs using integer arithmetic and finite rational sums. They do not supply any of the actual-character coefficient centers from section 2.

## 7. Uniform finite-arithmetic budget

With d<=36, B<=B_star, and delta_ell,rho_ell<=delta=10^(−52), formula (9) gives a convenient coarse bound. For x=delta/2,

    (1+x)^36 <= 1/(1−36*x) < 2.

For example, expand the binomial and use each binomial coefficient <=36^j before summing the geometric series. The rational condition 36*x<1/2 is checked. Thus

    E_d <= 36*(B_star+2)*delta =: E_star < 1.                       (15)

Using s_fft<51, delta_scale,rho_final<=delta, and B+E_d<B_star+1, equation (10) yields

    E_finite < 51*E_star+(B_star+1)*delta+delta < 10^(−40).          (16)

This derives the predecessor's future normalized-DFT arithmetic target from explicit local rules. It is a paper theorem for the specified rational-rounding algorithm. It is not evidence that an unexamined FFT library satisfies those rules.

Combining (6), (16), and the accepted alias bounds, the alternative protocol has total radius

    E_time + E_frequency + omega*sum_j r_j + E_finite
      < 10^(−30)+10^(−75)+51*10^(−119)+51*10^(−50)+10^(−40)
      < 2*10^(−30).                                                (17)

All retained coefficients, including the negative Nyquist one, occur in this sum. The change from 26 to 51 is explicit. The same total-radius target survives with ample arithmetic slack, but still depends on actual coefficient packets satisfying (2).

## 8. Finite checker contract and proof obligations

A proof-producing checker for this design would verify the following concrete objects and relations:

1. The actual character/conductor/parity/root-phase identifiers, rational T and P, minimal power-of-two N, and target output labels m. These must match the analytic input theorem and the inclusive height target. No auxiliary Turing zone is included unless separately requested and bounded.
2. Exactly N coefficient packets indexed by J_N, with proofs of (2). A root-phase enclosure shared by all coefficients is accounted for in each numerical enclosure; repetition does not justify dropping its contribution.
3. The centered-to-residue permutation and exact bit-reversal permutation. The stage schedule must cover every block and pair once, with simultaneous reads before writes.
4. Twiddle centers from the specified finite polynomial construction, or independently certified centers satisfying (13). The positive exponent and exact stage indices must be checked, not inferred from a library flag.
5. For each arithmetic output, either recompute the exact rational expression and its dyadic rounding or check an exact residual inequality sufficient for (8). Hashes can bind the trace to inputs, but hashes alone prove none of these arithmetic relations.
6. The stagewise error invariant and the final scale/multiplication certificate. The final radius combines the input term, arithmetic term, and both analytic alias terms exactly as in (17).
7. The real-valued source adapter for F. A real-part interval excluding zero gives a sign. A packet whose interval includes zero must remain unresolved; no finite-FFT correctness theorem forces a successful sign search.

The remaining Lean lemmas are a centered-index equivalence; bit-reversal identities; the induction (5); a normalized-butterfly disk bound; the scalar recurrence (9); componentwise dyadic-rounding bounds; the finite arctangent and exponential remainders; and the final perturbation adapter to `ZMod.invDFT`. The analytic Fourier/alias adapters and character-to-source coefficient proofs remain separate dependencies. None has been silently added as a final assumption.

The construction does not prove off-grid interpolation, completeness of a sign mesh, count saturation, or a finite-family zero statement. Those remain independent tasks. It also does not reduce the principal conductor-one row to this nonprincipal theta transform.

## Reproducible scalar evidence

The owned script `family_finite_fft_scalar_20261111.py` checks 13 exact rational inequalities: the pi center and tail, twiddle remainder plus rounding, scale error, multiplier 51, maximum stage count, recurrence product bound, final arithmetic budget, and the changed total ledger. It does not execute an FFT, construct a twiddle table, or evaluate an L-function.

- Script SHA256: `A7D160D81FAB8D1EEC287FF0380FCC11A528C1CF682428D529EB939A03943EF6`.
- Receipt SHA256: `135E736D19975DB598AE2F49EE540CB8E0570E28CE04E013280BE1E600EFB184`.
- Command: `python work/qrh-campaign/agents/moebius/family_finite_fft_scalar_20261111.py`.

The paper argument and exact scalar implications are ready for independent review. Actual coefficient packets, a checked transform trace, and Lean implementation remain absent.
