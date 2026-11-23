# Independent review of arbitrary-height FFT rounding

2026-11-11. **PASS for the universal mathematical precision rule and its bounded exact witnesses.** No correction to the frozen producer is required. The rule genuinely permits arbitrary finite stage count d, nonnegative rational center bound B, positive rational scale bound D, and arbitrary positive rational tolerance. It does not reuse the old d<=36 or multiplier-51 specialization.

This is not a certificate for an FFT trace, coefficient packet, sign, or zero. No FFT, actual coefficient generation, twiddle table, Lean/Lake build, or canonical edit was performed. Producer and prior frozen files were read only.

## Pins and reviewed dependencies

Producer files under `agents/major-constants/`:

| File | SHA256 |
|---|---|
| `AUXILIARY_FFT_ROUNDING_EXTENSION_2026-11-11.md` | `DA25013DFEAAACEFEAC5CF173A45B632C03BE42D1412A4EDD9D9A44E77CA4870` |
| `auxiliary_fft_rounding_extension_20261111.py` | `2DF3B740F6CE29771E82F219B9D50C4269100096C4AA987C6E692F170CD4CC9B` |
| `auxiliary_fft_rounding_extension_20261111.json` | `BC4B2631574D5BF806AD14170AEEA7F7D09F770895CE63310DC26398EA45D683` |

The accepted finite-algorithm plan is `moebius/FAMILY_FINITE_FFT_PROOF_PLAN_2026-11-11.md`, SHA256 `6E303D60C855E2CAD444EBC4EB3B1A3BD192D9BEAFAE0448F3F6D63CD9CDAC2E`, with major-constants review SHA256 `B98A0735B223EBA01922044733750DC13A3C806B531AA1894D54589B68A88B0D`. Only its general exact invariant, local error recurrence, and scale perturbation formula are needed here.

The arbitrary-height sampling plan is `work/qrh-blueprint/turing-scalars/AUXILIARY_FOURIER_PARAMETERS_2026-11-11.md`, SHA256 `45E848935AC76C8450550DFE02279C697514BF227B37EA6FD25221B3F7C37F47`. It and the independent zero-sum review were read, together with the frozen parameter receipt. The selected Hcert is unchanged; the adapter separately permits the larger auxiliary sampling height.

## Universal error rule, including boundary cases

The exact finite target is sY, where Y is the normalized positive-exponent inverse DFT of rational complex centers, N=2^d, and s=2*pi*N/P satisfies 0<s<=D. The proof needs an actual bound |a_k|<=B for those centers. It does not claim that arbitrary input centers are Fourier coefficients.

For any d>=0, B>=0, D>0 and eps>0 in the stated rational domains, define

    delta=min(1/[2(d+1)],
              1/[(d+1)(B+2)],
              eps/[2(B+2)(D*d+1)]).

Every denominator is positive, so delta>0 even at d=0 and B=0. No upper bound on eps and no lower bound D>=1 are needed.

The accepted normalized-butterfly recurrence is

    E_j <= (1+delta/2)*E_(j−1)+delta*B/2+delta, E_0=0.

I independently checked its solution bound. Since d*delta/2<=d/[4(d+1)]<1/4, the binomial/geometric comparison gives

    (1+delta/2)^d <= 1/(1−d*delta/2)<4/3<2.

Expanding the recurrence and bounding each amplification product by 2 yields

    E_d <= d*(B+2)*delta = E_star <= d/(d+1)<1.

For d=0 the sum is empty and E_star=0, so no exception is hidden in this derivation. The final scale/product estimate gives

    |V−sY| <= D*E_star+delta*(B+E_star)+delta
            < (B+2)*(D*d+1)*delta <= eps/2 < eps.

The strict middle inequality uses E_star<1 and delta>0. It remains strict at d=0. This accounts for the final pi-dependent scale and product rounding; controlling only the butterflies would not suffice.

The d=0 case is correctly separated from the centered-frequency alias adapter, which requires even N>=2. It is a valid single-entry transform theorem but is not used to invent a centered Nyquist convention at N=1.

## Precision searches and twiddle termination

All three searches terminate for each fixed admissible input, for mathematical reasons independent of the tested examples.

1. Increase p until 2^(1−p)<=delta/4. Dyadic powers tend to zero. Componentwise floor rounding has real error less than 2^(−p), and hence complex error less than 2^(1−p), including negative inputs. The precision p counts **fractional binary digits**, not the total mantissa size of a floating representation.
2. Increase J>=2 until e_pi(J)<=delta/[4(D+1)], where e_pi is the sum of the two Machin arctangent remainder bounds. The bound e_pi(J)<=20/5^(2J+1) proves convergence to zero. The alternating partial sums for every J>=2 lie between S_2 and S_3. The exact combined endpoints are

       306134117864772/97476408149875
       and 670143059704/213311234375,

   both strictly between 3 and 22/7. Thus every accepted pi center has the required range. There is no circular assumption that a sufficiently precise but unchecked center lies in the desired interval.
3. Increase K>=6 until T_K<=delta/4, with

       T_K=(22/7)^(K+1)/(K+1)! / [1−(22/7)/(K+2)].

   The denominator is positive and its reciprocal is less than 2. The successive first-omitted terms have ratio at most (22/7)/8<1/2. Therefore T_K is bounded by a fixed positive constant times 2^(−(K−6)), proving termination. This remains valid for arbitrarily small positive tolerance; it does not rely on the old fixed degree 64.

For any actual stage angle, 0<=2*r/m<1. Thus the rational angle center lies in [0,22/7), and its error from using pi_hat is at most e_pi. The exponential tail T_K is a bound for the exact complex power series at that center. Adding the real-axis exponential Lipschitz bound and componentwise rounding gives

    twiddle error < delta/[4(D+1)]+delta/4+delta/4 < delta.

The last inequality holds also when D is very small, because D>0. It does not require the rounded twiddle to have modulus 1. Exact twiddle modulus 1, plus its error bound, is what the recurrence uses.

The output scale is checked independently. Since pi>1 and s<=D,

    2*N/P=s/pi<D.

Consequently pi error is amplified by less than D, and the real rounding contribution is at most half the complex-rounding cap. The bound

    scale error < D*delta/[4(D+1)]+delta/8 < delta

is valid without a cap on N/P. This is the essential change from the fixed-height factor 16. The final complex product uses the same floor-rounding proof.

These are termination and correctness statements for the mathematical rational specification. They do not assert unlimited machine resources, a total-runtime bound, or automatic correctness of an arbitrary floating implementation.

## Join to the auxiliary Fourier protocol

The root adapter supplies c>1, H>=1, C=cH, a tolerance 0<e<=1, the actual period P, and N with

    s=omega*N < D=88*x/21, x>=2.

It separately proves the three analytic contributions below e/4 and requests additional coefficient rounding at most e/(8D). The common series construction proves each coefficient's series radius below e/(4D). Therefore, once the actual coefficient enclosures exist,

    |a_j| < C+3e/(8D) < C+1,

since D>=176/21>8. The choice B=C+1 is justified by the source coefficient envelope plus its checked radius, not by treating a computed center as exact.

Applying the universal rule with eps=e/8 gives scaled FFT arithmetic error below e/16. The additional coefficient uncertainty remains a separate term below e/8 after multiplication by s<D. The series uncertainty is already in its analytic e/4 contribution; it is not counted again in the FFT recurrence. The resulting combined radius is below

    3e/4+e/8+e/16=15e/16<e.

This permits arbitrary auxiliary height without silently preserving cH<=10^8, d<=36, B<100000001, or the multiplier 51. No actual coefficient packet, transform trace, sign, or Turing count is supplied by this implication.

## Exact reconstruction and the 37-stage witness

The independent script `review_auxiliary_fft_rounding_20261111.py` does not import or execute author code. It reads the frozen receipt, reconstructs p by exact rational ceiling and bit length, and reconstructs J and K by doubling followed by integer bisection. It checks the accepted thresholds and verifies failure of the preceding candidate when applicable. All fields of all four producer rows match exactly, including the full rational bounds, not just p,J,K.

The main witness is

    c=4, H=10^8, N=137438953472=2^37,
    d=37, B=400000001, D=1144/21, eps=10^(−30)/8.

The independently recovered parameters are p=147, J=32 and K=53. The exact local delta is

    21 / 271033602032752000000000000000000000000000000.

The stage cap is 777/677584000000000000000000000000000000, and the scaled cap is exactly 10^(−30)/16. The actual proven arithmetic bound is strictly smaller than that cap. The value d=37 is used throughout the recurrence, so the example does not rely on a 36-stage lemma.

The script also checks eight independently selected boundary cases, including d=0 with B=0, large B with no butterflies, D=10^(−30), tolerance 10^30, tolerance 10^(−120), and a stage-count parameter of 1,000,000. These are scalar tests only; no array of length 2^d is created. The tests support the implementation check, while universal coverage comes from the proof above.

All author hashes were checked before and after the independent run and remained unchanged. The run exited 0 and wrote only the review's own receipt.

- Independent script SHA256: `2A1ECDB7E375649AD0A7CFA066211D79EA39DA1C0A206350D4588F06116A5B9C`.
- Independent receipt `review_auxiliary_fft_rounding_20261111.json` SHA256: `AB0F7CB1DB72B0C01DABA37A7CA5F4D04CB6745E55CFA0993CE1A63E85F0484E`.
- Reproduction: `python work/qrh-campaign/agents/moebius/review_auxiliary_fft_rounding_20261111.py`.

## Limits retained

The reviewed result closes the paper-level precision-selection gap for the specified normalized rational radix-two algorithm. Lean implementation, proof-producing integer arithmetic, actual source-bound coefficient enclosures, and a checked full transform trace remain absent. A different numerical library still needs a refinement proof or a checked operation trace. More precision alone does not prove that its outputs are correct.

The result also does not prove that any real-part interval excludes zero, does not supply off-grid interpolation, and does not establish sign-count completeness or a finite-family spectral certificate. Those tasks remain unchanged.
