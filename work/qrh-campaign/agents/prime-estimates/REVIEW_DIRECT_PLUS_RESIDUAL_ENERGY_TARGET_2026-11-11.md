# Independent review of the direct plus-residual energy target

2026-11-11. **PASS for the stated conditional paper implication and bounded source comparison. No correction requested.** The actual aggregate estimate E_q<=7.02*10^-13 remains unproved. This review supplies neither a new spectral input nor a replacement Lean theorem, and establishes no production or runtime saving.

Reviewed author: `major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md`, SHA256 `E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1`. Paths in this report are relative to `work/qrh-campaign/agents` unless identified otherwise. I read the full note, its scalar script and saved receipt, and the actual source declarations/bodies listed below. I did not execute or import the author script, evaluate any analytic function, run a build, or edit the author packet.

## 1. Actual normalization and exact orthogonality

`ArcChars.cP` is exactly the complex coercion of Lambda(n)*etaPlus(n/x). `summable_cP` and `norm_coprimePart_le` give absolute summability after coprime restriction for every positive x. Thus the source infinite sums and finite character transforms have the required domains; the note does not exchange an unsupported conditionally convergent sum.

`Bombieri.Schar` uses the positive character factor psi(n), and `sum_char_mul_S` consequently has `Schar psi^-1` on its right side. `totient_mul_sum_units` gives

    phi(q) sum_b |S'_q(b/q+beta)|^2
      = sum_psi |tau_q(psi)|^2 |Schar(psi^-1,a_q,beta)|^2.

The principal term is mu(q)^2 |S'_q(beta)|^2. This follows from `MajorTotal.gaussSum_one_eq` and `Schar_one_eq_expTsum`, whose coprime-support premise is present. Removing this term and dividing by phi(q)*x^2 gives exactly the note's E_q. In particular there is one factor phi(q) in its denominator, not its square or no factor.

The source `norm_sq_gaussSum` has precisely conductor times the squarefree-and-coprime indicator. All nonprincipal characters modulo the actual q are retained, including induced characters and zero-weight rows. The expression is not silently changed to a primitive-character average. The inverse conductor identity is also used explicitly in the existing `arc_chars` proof; using inverse labels consistently preserves this exact weight.

`MajorTotal.sum_units_expTsum` proves the Ramanujan sum identity for these coprime coefficients. After transfer to Bset, with v=phi(q), m=mu(q)/v and

    r_b=S'_q(b/q+beta)/x-m*S'_q(beta)/x,

it gives sum_b r_b=0. Therefore sum_b r_b*conj(m*e)=0 for every constant complex e. Expanding squared norms gives

    sum_b |r_b+m*e|^2=E_q+mu(q)^2 |e|^2/v.

This is exact orthogonality, stronger than the existing generic `norm_sq_add3_le` path. It does not assume signs of mu, e or the individual r_b. The q=1 case is valid: phi(1)=1, the nonprincipal character sum is empty and the centered vector is zero. Non-squarefree q gives mu(q)=0 without a division-by-zero problem; q>=1 ensures v>=1.

## 2. Removal, constants and the consumer implication

For x>=4.9*10^26, `ArcChars.norm_S_sub_coprime_le` gives the stated uniform normalized removal error d0=10^-15 at every real alpha. Its proof is before the scoped `Fact PlattGRH` declaration; the inspected finite prime-power removal argument has no such hypothesis. The principal part of `arc_chars` gives p0=2.83*10^-7 from the modulus-one theorem and that removal bound.

Finite-dimensional Minkowski now gives

    sqrt(sum_b |S(b/q+beta)/x-m*P|^2)
      <=sqrt(E_q+mu(q)^2*p0^2/v)+sqrt(v)*d0.

The q-dependent boundary in the note is a sufficient allocation after solving this inequality. It is not asserted necessary. Its square-root difference is positive on this domain. Using v<=265800<516^2 and mu(q)^2/v<=1 proves the uniform version.

I reconstructed the exact arithmetic directly, without running the author's checker. In common denominator10^20,

    E_target+p0^2=78208900/10^20,
    (8.844*10^-7)^2=78216336/10^20.

Their positive difference is7436/10^20. The full rounded upper root bound is

    8.844*10^-7+516*10^-15=884400516/10^15.

Its square is782164272701066256/10^30, strictly below783000000000000000/10^30. The remaining margin is835727298933744/10^30, equivalent to the author's saved52232956183359/62500000000000000000000000000. Also

    (8.85*10^-7)^2-7.83*10^-13=22500/10^20>0.

The old nonprincipal allowance is(4.25*10^-7)^2=289/1600000000000000. The new allowance divided by it is5616/1445, as stated. Thus the proof preserves the residual conclusion7.83*10^-13*x^2 and the later rho=8.85*10^-7*x, provided the new E_q theorem and the retained principal bound are actually supplied.

`MajorTotal.pointwise_bound` uses `resid_plus` only to obtain this rho inequality, then separately consumes `resid_star`. `per_modulus` integrates the resulting pointwise estimate and retains the actual plus energy integral. The new implication alone therefore cannot close either of those whole consumer theorems.

## 3. Continuum and cutoff scope

The proposed domain is all real x>=4.9*10^26, integer q>=1 with qt(q)<=265800, and all real delta with |delta|<=1063200/qt(q). It is not a mesh assertion. Positivity of x permits beta=delta/x and beta*x=delta. Since qt(q)>=2, the principal modulus-one call stays within |delta|<=531600<600000; q<=qt(q)<=265800<300000 preserves removal.

The existing `thm_7_1_4_one` obtains its `GRHUpTo` input at height10^8 from conductor one, then calls `prop_9_4_2`. That proposition explicitly separates its GRH premise from the smoothing and error algebra. Refactoring this modulus-one body can expose a principal-only hypothesis. Merely calling the existing bundled `arc_chars` theorem would retain its blanket `Fact PlattGRH`; no such hidden export is accepted by this review.

The source `resid_plus`, `pointwise_bound` and `per_modulus` currently use r0=150000 and width1200000/qt(q). The note preserves their numerical residual conclusion **on the reduced R132900 domain**. It does not prove the full original declaration for all q up to300000. The previously reviewed cutoff adapters and their range proofs must be implemented to consume this reduced-domain replacement. No grid-to-continuum or endpoint extension is supplied by the finite scalar receipt.

This note deliberately retains the original principal RH route. It does not replace its height10^8 input by a shorter principal strip, nor claim that an already selected QRH route automatically proves this modulus-one error with these constants. Those are distinct analytic inputs.

## 4. Lower-J and upper-J dependencies really differ

I inspected `L2Major.Jq_bounds` beyond its theorem header. It defines

    A0lo=-((1-t)*m*(1/t)*Cp+(1/t)*q*Cb),
    A0hi=(1+t)*m*(1+1/t)*Cp+(1+t)*Cn+(1+1/t)*q*Cb.

The lower branch uses principal approximation, the removal bound, and the exact nonnegative nonprincipal energy. It never needs the value of Cn. The lower Parseval inequality can be proved directly from the same exact identities, without the old characterwise upper estimate. Thus separating the conjunction is a legitimate source dependency reduction. Subsequent integration, Fourier lower bounds and cutoff mass are still required; the word 'lower' does not make the entire J argument unconditional automatically.

The upper branch explicitly uses Cn=(4.25*10^-7*x)^2. The weaker new target7.02*10^-13 cannot be substituted for it while retaining the old upper-J numbers. A stronger E_q target or a complete revised integrated upper-J budget is required. The author states this limitation accurately. The pointwise star/base-gap and other consumers of original RH likewise remain outside this replacement.

## 5. The unproved analytic target is not disguised by the source comparison

`large_sieve_opt` gives length-minus-one plus inverse spacing times coefficient energy for a finite head. Its q-spaced specialization yields(H-1+q) sum|a_n|^2. Taking an integer x and H=x demonstrates that a generic energy allowance of order x supplies a normalized bound of order one, not7.02*10^-13. The note does not infer a lower bound on the actual smoothed residual from this weak upper bound, and it retains the infinite tail obligation.

The q=3 artificial sequence has exactly x/3 nonzero coefficients for x divisible by3, each at residue1. Its only nonprincipal character sum is x/3, its Gauss norm squared is3 and phi(3)=2, so its E is1/6. This validates the restricted information-gap claim: generic coefficient energy, coprime support and the character identities are insufficient. It is not a counterexample for Lambda*etaPlus, principal approximation or `PrimeSupported`, which the note explicitly does not claim.

`prop_12_1_2` is an integrated total-energy statement with a `PrimeSupported` input. `cor_12_2_5` is also integrated and currently scoped under `Fact PlattGRH`. Neither interface is the pointwise centered variance target. Conversely, `Explicit.norm_SsumG_fP_le` visibly requires every relevant low zero to have real part1/2 and contains its sqrt(x)*E1g contribution. Removing that premise does not preserve its numerical output. An actual replacement needs the stated weighted variance estimate, including the genuine zero terms or another sound analytic argument.

I accept only this bounded source comparison. It is not a claim that no other unconditional route exists. There are no supplied prime-sum values, average-cancellation certificates or achieved bounds for(T) in this packet.

## 6. Hash and scope record

All nine source hashes in the author table matched the local files under `work/ternary-goldbach/TernaryGoldbach`: ArcChars, MajorTotal, Bombieri, L2Major, Thm714, Prop942, EtaPlusBound, LargeSieveMV and LargeSieveProof. The checked source bodies are identified in sections1--5 above. This is static source evidence, not a fresh elaboration or transitive axiom audit.

The author scalar script hash is `A983B94F0E5C514D8DFD2BABDB225DE30C7A8E07C6E31229D4157AC773AB0449`; its receipt hash is `B5D6502589DCA7B735D2CBAB159E888C7497D217B02ED40C34E23DC92ACEB57E`. Both bytes were checked and read. The numerical identities in this review were independently reconstructed as integer/rational arithmetic, not inferred from the receipt's success flag.

Final acceptance is for a sufficient target and its correct consumer implication. The target itself, principal finite-RH certificate/refactoring, upper-J or replacement integrated budget, star and remaining RH consumers, reduced-cutoff source adapters, formal proofs and kernel validation are all still required. No spectral-family reduction or computational speedup is established.
