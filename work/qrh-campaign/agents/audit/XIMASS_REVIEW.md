# XiMass source review

Reviewed source SHA256: DC2F179566C4DD7EFEBBC295CD49C1E40CD1B861EAC5555ABF6EA4377765A899.
Target: `TernaryGoldbach.Explicit.XiMass.re_logDeriv_xiF_two_le : (logDeriv xiF (2 : Complex)).re <= 0.07`.

Verdict: no mathematical defect found in the current source or the exact arithmetic certificate. This is a source review of an uncompiled helper, not a frozen-declaration approval or proof/axiom closure. No Lean process was launched.

## Declaration and assumptions

| Binder | Classification | Evidence |
| --- | --- | --- |
| None | No logical input | The target declaration has no explicit, implicit, or instance binders; its namespace has no section variables. |

SOURCE 0; STANDING 0; TYPING 0; RULED 0; EXCESS 0.
The conclusion concerns the actual project `xiF` and ordinary complex logarithmic derivative at 2. The helper introduces no replacement object. No `sorry`, custom axiom, `native_decide`, local resource option, Platt input, or QRH input occurs in this file. The displayed project dependencies used in the proof are unconditional. This does not replace a future `#print axioms` check.

## Exact arithmetic replay

Own script `check_ximass.py` parses the table directly from the hashed Lean source, compares it entry for entry with XiMassLogData.txt, independently enumerates primes by trial division, and generates prime powers by repeated multiplication. It uses Fraction throughout all acceptance checks. It does not import or run the author's generator, nor write into its directory.

The successful run checked 303 distinct prime entries and 333 distinct prime powers at most 2000. Every table entry passes the exact predicate in SmallMertens.lean:23, including the upper exponential base 27182818286/10^10 and the Taylor remainder f^12*13/(12*12!). The finite sum is approximately 0.5694599657696959, with a margin of approximately 0.000009965769695888224 over 0.56945. All comparisons themselves are rational.

The harmonic certificate passes with margin approximately 5.503449126565182e-10. The log(1001) certificate passes the exact SmallPsi.lean:27 predicate at n=1, with lower exponential base 27182818283/10^10 and terms of degree 0 through 11. Consequently H_1000 - log(1001) exceeds 28835793/50000000 = 0.57671586, which exceeds the retained 0.576715.

The final rational upper bound is 27937/400000 = 0.0698425. Its margin below 0.07 is 63/400000 = 0.0001575.

## Finite Lambda and infinite sum

Mathlib ArithmeticFunction/VonMangoldt.lean:74 defines Lambda(n) as log(minFac n) for prime powers and zero otherwise, exactly matching vmLower. minFac_pos is unconditional in Data/Nat/Prime/Defs.lean:300. The value n=0 is not a prime power; both finite summands vanish under the field's zero-division convention. The HasSum proof also splits n=0 explicitly, so it never uses exp(log 0)=0. n=1 contributes zero.

For positive n, exp(-2 log n)=1/n^2. ZeroFreeRegion.lean:140 supplies the absolutely convergent real von Mangoldt series for sigma>1, specialized at sigma=2 and tau=0. Nonnegative Lambda(n)/n^2 then justifies extending the finite sum to the full series via sum_le_hasSum. No prime-power geometric-series interchange is used.

The lookup default zero is only an internal certificate lower bound; correctness is checked for every argument in range 2001. It is not a fallback definition for an analytic object. The actual parsed table also covers all primes needed by the finite sum.

## Euler constant and xi normalization

Mathlib NumberTheory/Harmonic/Defs.lean:23 uses H_n=sum_{i<n}1/(i+1). EulerMascheroni.lean:50 defines the lower approximant as H_n-log(n+1), and line158 gives its strict inequality below the Euler constant. Thus the index 1000 and the logarithm 1001 are correct.

Project Xi.lean:18 defines xiF as Riemann xi without the factor 1/2. The constant normalization does not change its logarithmic derivative. Xi.lean:142 and ZetaDatum.lean:222 yield the exact identity used by ZeroFreeRegion.lean:192. At s=2 it is

`LSeries(Lambda,2).re = -Re(xiF'/xiF)(2) + 3/2 - log(pi)/2 - EulerGamma/2`.

Mathlib Complex.digamma_one supplies the minus sign on EulerGamma. Therefore lower bounds for the series, log(pi), and EulerGamma all give an upper bound for the desired xi logarithmic derivative. The project log_pi_ge at ZeroFreeRegion.lean:243 supplies 1.1447. The point 2 satisfies every positivity and nonvanishing premise; no pole cancellation at 0 or 1 is needed. No sign or factor-of-two discrepancy was found.

## Remaining checks

Lean compilation has not been attempted here. Exact-type and axiom inspection must still run against a successful artifact. Resource feasibility of the kernel decision proofs is also unverified. This target bounds a logarithmic derivative; identifying it with the positive weighted zero mass W2 still requires the separate finite-sum/exhaustion argument with multiplicities. It does not by itself establish the proposed quartet estimate or any Goldbach root.
