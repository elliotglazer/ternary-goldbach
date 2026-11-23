# Independent review: prime-envelope assembly

Date: 2026-11-11. Reviewer: prime-estimates worker. Verdict: PASS as a paper implication from the explicitly unproved envelope E, together with the reviewed P6 repair and identified existing finite theorems. This is not a proof of E, a Lean validation, or a closure of Goldbach.

## Reviewed artifacts and source contracts

- `work/qrh-blueprint/PRIME_ENVELOPE_ASSEMBLY.md`, accepted SHA256 `B54EA110CCDAB0ADD5F3FE4D10189A38F04AD89E93426725F05C2EE80D63EDDE`.
- `work/qrh-campaign/prime_envelope_assembly.py`, SHA256 `13E33129E34CA903B75951E5DD669B4AAE174838466238DF08554617B630EA6B`.
- Canonical source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

I read the actual public declarations in `Prelim/LambdaMu.lean`: P1 `sum_vonMangoldt_lt:337` is strict for every real y>0; P4 `sum_vonMangoldt_le_a14:1375` is weak for y>=2.5e7; P5 `sum_vonMangoldt_mul_lt_a17:1362` is strict with coefficient1.022 for y>=2.5e7; P7 `sum_log_sq_primes_le:1884` is weak with coefficient1/2 for y>=2e6. Their carriers and endpoint conventions match this assembly.

The finite table is `Prelim/PsiSieveMain.lean:28160`, `sieve_table3`, with real domain 1e6<=t<1e9. Its conclusion `RtT 2 1 1 10 t` unfolds at `PsiSieve.lean:424` to the stated upper .1sqrt(t) and lower 2sqrt(t) bounds for thS(floor t). It is a real-cutoff table, so no extra floor error needs to be added to that finite theta estimate.

The P6 dependency is the separately reviewed complete paper repair recorded in `prime-estimates/RESUME_PRIMES_2026-11-11.md`, not an assumption that an unfinished scratch Lean declaration is already proved. It supplies the entire real contract NP(t)<1.4262sqrt(t), t>0. Its eventual Lean implementation and the normal compiled audits are still outstanding.

## 1. Integer-to-real correction: accepted

E is exactly the integer assertion abs(psiN(v)-v)<=.01*v/log(v) for all integers v>=1e9. For real t>=1e9, N=floor(t)>=1e9, and psi(t)=psiN(N). Since u/log(u) increases for u>e,

    psi(t)-t <= .01*N/log(N) <= .01*t/log(t),
    t-psi(t) < 1+.01*N/log(N) <= 1+.01*t/log(t).

The strict inequality in the second line uses t-N<1. The extra unit is real and must not be omitted. The proposed allowance .001*t/log(t)>1 is valid: monotonicity reduces it to t=1e9, log(1e9)<21, and .001*1e9/21>1. Hence the safe weak real envelope abs(psi(t)-t)<=.011*t/log(t) follows, including the exact junction t=1e9.

The source exponential bounds and exact powers in the script justify 20<log(1e9)<21: exp(1)<2.72 with 2.72^20<1e9 gives the lower bound, and exp(1)>2.7 with 2.7^21>1e9 gives the upper bound. Thus .011/log(t)<.002 for all t>=1e9.

## 2. Uniform coarse bound and P1/P4: accepted

For 1e6<=t<1e9, theta upper plus P6 gives psi(t)<=t+1.5262sqrt(t), and nonnegative NP plus theta lower gives psi(t)>=t-2sqrt(t). Since sqrt(t)>=1000, these imply .998t<=psi(t)<=1.002t. The upper estimate actually has strict spare margin because1.5262/1000<.002. At t>=1e9, ER proves the same coarse bound. The two intervals cover every real t>=1e6 without a hole or an illicit use of the strict upper sieve endpoint.

P1 above1e6 follows from1.002<1.03883 and t>0, giving the required strict inequality. Below1e6 the already reviewed SmallPsi700/SmallTab argument supplies the strict original coefficient; for0<t<1 the sum is zero. This last strictness matters at integer t and is available from the finite proof, not merely from a weak coefficient comparison at equality.

P4 starts at2.5e7 and therefore follows directly, with margin1.0064-1.002=.0044. No smaller-domain assertion is needed.

## 3. Weighted P5: accepted

For the right-continuous step function psi, including an integer upper endpoint y,

    sum_{n<=y} n*Lambda(n) = y*psi(y)-integral_0^y psi(t)dt.

This can be checked term by term: each n<=y contributes Lambda(n)*(y-(y-n))=n*Lambda(n); a jump at y itself has zero integration length. Therefore the identity includes n=y correctly. The interval below A=1e6 may be discarded in a lower bound for the integral because psi>=0. Inserting the upper coarse bound at y and the lower coarse bound in the integral gives

    sum n*Lambda(n) <= [(1+3epsilon)+(1-epsilon)*(A/y)^2]*y^2/2,

with epsilon=.002. At y>=25A, (A/y)^2<=1/625. The resulting coefficient is exactly157437/156250=1.0075968. Its difference from1.022 is .0144032>0. Since y>0, the source's strict P5 conclusion follows. All signs of the substituted bounds are correct.

## 4. Hybrid theta bound and dyadic P7: accepted

The uniform bounds T are valid on all t>=A:

    theta(t)<=t+.011*t/log(t)+.1sqrt(t),
    theta(t)>=t-.011*t/log(t)-2sqrt(t).

On the finite part the positive logarithmic allowances weaken the actual sieve bounds. On the large part, theta<=psi supplies the upper bound even without its positive sqrt allowance; theta=psi-NP and P6 give a lower bound with1.4262sqrt(t), which is stronger than the displayed2sqrt(t). Log(t)>0 throughout. Consequently an interval crossing1e9 requires no unsupported mixed-range argument.

For y>=2e6 put a=y/2>=A. The exact identity

    sum_{a<p<=y}log(p)^2
      =log(y)*theta(y)-log(a)*theta(a)-integral_a^y theta(t)/t dt

has the correct open lower and closed upper prime endpoints. A prime p=a is subtracted by theta(a) and is absent from the sum; a prime p=y occurs in the upper term and is included. For integer primes, a<p<=y is equivalent to floor(a)<p<=floor(y), exactly the source filtered Ioc carrier. No replacement by floor(y)/2 has occurred.

Both log(y) and log(a) are positive. Thus the upper theta estimate belongs only at y, and the lower theta estimate belongs at a and under the negatively signed integral. The assembly uses precisely those directions. The main term is .5*y*log(y)+.5*(log2-1)*y.

The logarithmic errors sum to at most .011y+.0055y+.011*(y/2)/log(y/2). Since log(y/2)>=log(1e6)>10, this is at most .01705y. The integral comparison uses1/log(t)<=1/log(y/2), valid over the whole interval. Independently checked2.72^10<1e6 proves the stated lower log bound using exp(1)<2.72.

The sqrt errors are bounded by1.6sqrt(y)log(y)+4sqrt(y): use log(y/2)<=log(y), sqrt2<1.5, and discard the negative -4sqrt(y/2). The functions log(y)/sqrt(y) and1/sqrt(y) decrease throughout y>=2e6. Using sqrt(2e6)>1400 and log(2e6)<=14.51 gives their combined ratio less than .02. This uses the actual weak statement of `LambdaMu.log_2e6_le:1529`; weak input suffices because the final rational comparison is strict.

Finally log2<.7 gives a negative main correction strictly below-.15y. The total positive allowance is less than(.01705+.02)y=.03705y. The remaining margin is at least .11295y. Hence the original P7 bound holds at every scale, including y=2e6, y=1e9, and y=2e9, where one or both dyadic endpoints meet a range boundary.

## Checks, correction, and limits

I ran the root Fraction script; all10 checks passed with exit0. I independently replayed nine additional rational comparisons: 2.72^10<1e6,1.5^2>2,1400^2<2e6, both finite coarse coefficients,1.4262<2, the exact .01705 error sum, the P5 margin .0144032, and the P7 margin .11295. These passed. These scalar computations do not by themselves verify the analytic identities; the arguments above separately review those identities and signs.

The first note version, hashF0291EB51917CE467A6BAC5D296E07DE2E301BFBEE89F9C5957BDD9118C8C0B8, cited log(2e6)<14.51 while its named source proves <=. I requested the weaker wording, and the coordinator corrected it. The accepted hash at the top contains that correction. No numerical budget or mathematical conclusion changed.

No blocking defect remains in this reduction. The assertion E remains unproved and must not be installed as a new Goldbach premise or reported as a consequence of QRH without a full quantitative argument. Even after E is proved, future Lean work must implement the finite/real Abel identities, floor transport, and the reviewed P6 repair, then check exact types and axioms. The original final10^27 and BinaryGoldbachInput are unchanged.
