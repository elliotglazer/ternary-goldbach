# Variable-real-part zero sums

Source checkout is calr3/ternary-goldbach at 23b2d68ca344203d4384e0aff7affa4ec034bef9. The source tree was read only. Scratch code is ZeroSumStrip.lean. Compilation is pending an import environment from the integration worker. A standalone CheckMathlib.lean probe was launched against the compatible v4.35 cache, then stopped with Ctrl-C after the Lean process stalled without diagnostic output. The integration worker is diagnosing this runtime issue. No Lean proof in this directory has completed validation.

## Existing argument

Explicit/ZeroSumGen.lean lines 200–216 state zero_sum_boundG. Its low-zero proof at lines 251–286 uses the equality Re(rho)=1/2 twice. It places zeros in radius-2.3 Jensen discs and identifies every Mellin value with the same critical-line function F. The exponent then becomes sqrt(x). Changing only this exponent leaves both uses unresolved.

PolyDatum provides an entire function, a nonzero value at each center 2+iT, an upper bound on radius-10 discs, and logarithmic growth of that upper bound. Its sum_multRectD_le counts zeros with their natural-number divisor multiplicities. All formulas below retain these multiplicities.

## Finite strip estimate

Put h=3.48, J=floor(T0/h)+1 and

    Z = log(B(T0+h)/0.355)/log(10/2.7).

For S contained in zerosRectD f T, with 0<=Re(rho)<=1 and |Im(rho)|<=T0, each of the 2J height windows has total multiplicity at most Z. A window has half-height 1.74 and horizontal distance at most 2 from its center 2+ic. Thus every zero lies in the radius-2.7 disc, because 4+1.74^2=7.0276<7.29. The center has |c|<=T0+h, so PolyDatum.log_mono bounds the numerator. No assumption about distinct imaginary parts or conjugation is used.

Assume x>=1 and Re(rho)<=theta for every included zero. Then

    |sum m(rho) M(rho) x^rho|
      <= x^theta sum m(rho)|M(rho)|.

With |M(rho)|<=K, K>=0, this gives

    |sum m(rho) M(rho) x^rho| <= x^theta (2 J Z K).

With the stronger envelope |M(rho)|<=K exp(-a|Im(rho)|), a>0, the sharper result is

    |sum m(rho) M(rho) x^rho|
      <= x^theta 2 K Z (1-exp(-a h J))/(1-exp(-a h)).

For k=0,...,J-1 the positive window [kh,(k+1)h) and the negative window [-(k+1)h,-kh) each contribute at most K Z exp(-a h k). The floor partition assigns gamma=0 once. The use of two upper bounds at k=0 is harmless. The audit worker independently checked this finite geometric derivation. Its Lean formalization is still pending.

The zero at rho=0 remains bounded by G0*Z3g(B,0). The old tail proof only uses 0<Re(rho)<1, so its x*E2g term survives. Consequently the generic QRH replacement has the same zero and tail terms, and either of the displayed x^theta low-zero terms. If the QRH bound is supplied at every height, the tail exponent can also be reduced to x^theta.

## Available Mellin inputs

Explicit/EtaPlusMellin.lean already proves norm_mellin_fP_uniform on -1/2<=Re(s)<=2. It supplies

    K = Cg*(300*exp(1))*(2*aH),
    a = min(0.28/(1+|delta|),0.005).

This closes the analytic input for the coarse exponential estimate once the QRH zero bound is connected. The coefficient is too large for the existing numerical large-case argument. The Mellin worker bounded K by 105391. At delta=0, even the infinite geometric multiplier 2K/(1-exp(-3.48a)) is about 1.22e7, before multiplying by Z.

The Mellin worker derived improved strip Sobolev estimates on 1/8<=Re(s)<=7/8. These require a bound on the supremum over real parts and its vertical variation. Critical-line Q1 and Q2 alone do not supply this. Their derivation uses three weighted Plancherel moments, including the log^4 moment, and obtains a coarse coefficient below 19.76 multiplying Z*sqrt(2Jh). This derivation has separate proof obligations recorded by that worker.

## Coarse zeta lemma for the far-asymptotic prime route

The prime-estimates worker only needs the range x>=exp(35000), where large coefficients are acceptable. The scratch code includes a deliberately coarse bound

    sum_{rho in S} m(rho) <= 1e18

for S contained in zerosRectD zetaF T, 0<=Re(rho)<=1, and |Im(rho)|<=1e8. It uses the strip window count, J<=1e8, log(BPz2(T)/0.355)<=37+2.6|T| from XiPartial.log_BPz2_lin, and log(10/2.7)>=1/2. The resulting Z is at most 1e9.

If g>=0, C>=0 and g(rho)*max(1/8,|Im(rho)|)<=C on S, the scratch theorem sum_weight_zeta_low_le concludes

    sum_{rho in S} m(rho)*g(rho) <= 1e20*C.

The prime worker's norm_Mg_qrh_strip_le supplies C=2 exp(delta^2/2+|a|), using the lower real-part bound 1/8. Their far-asymptotic absorption lemma has room for coefficient 1e24. The lower bound requires a functional-equation argument in addition to right-half-plane nonvanishing, unless the Mellin bound is reworked to avoid division by rho.

## Outstanding work

1. Compile ZeroSumStrip.lean against the pinned project and repair any elaboration errors. All five substantive proof bodies are present, with no sorry or custom axiom.
2. Connect a pinned, compiled QRH provider to actual zeta and Dirichlet-character zeros, including the lower strip bound where used.
3. For the prime route, combine the finite low-zero estimate with the existing middle and tail estimates, and justify the limit using the established explicit-formula convergence API.
4. For the full major-arc route, formalize a substantially sharper Mellin/zero-sum estimate and rerun all numerical consumers. The finite helper does not establish those downstream constants.


A separate sharper count is now drafted as `sum_mult_zeta_low_sharp_le`: for the same finite carrier and multiplicity weights, the total below height 1e8 is at most 3e10. It retains the logarithmic form of `log_BPz2_le'`. At T=1e8+3.48, both logarithm arguments are below 1.3e8, which is below exp(19) by the existing `exp_nat_ge' 19` certificate. Hence the numerator is at most 200.24. The existing denominator lower bound 1/2 gives ZStrip<=401; Jl<=3e7 gives total at most 2.406e10, rounded to 3e10. This statement is still awaiting Lean compilation. Existing coarse helper APIs are unchanged.
