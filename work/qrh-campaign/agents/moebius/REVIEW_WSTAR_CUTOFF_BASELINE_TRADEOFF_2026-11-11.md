# Independent review of the Wstar cutoff and baseline tradeoff

2026-11-11. Verdict: PASS at paper/source and exact-metadata scope, with one explicit domain correction below. The author file and its receipt remain unchanged. The count obstruction, conditional finite-strip option and new full-strip remainder argument are valid with that correction. No actual finite spectral statistic, energy target, zero location, sign success or computation saving is established.

Author: `zero-sum/WSTAR_CUTOFF_BASELINE_TRADEOFF_2026-11-11.md`, SHA256 `55D2E58DA0F13A77ECC3AB097E5CAC45D58EE247178F8A8D5824756A45E1C2AB`. Its script is `1CD94C0545DB1DE770EFF1A8C04BA857181D35D2B67E2528832FD75F701B58B6` and receipt is `A5CA555478A01B9785FB7F04D754AB547CCE280775862DB76863511CB29FAE18`. All paths without an absolute prefix are relative to `work/qrh-campaign/agents`.

## Required correction

Section 4's universal upper cutoff 363700 is incorrect. It is Hstar(3), but conductor 4 is active and contributes to Q_B even though its Q_A weight vanishes. The exact value is

    Hstar(4)=ceil(704*8*132900/(343*4))
            =ceil(748492800/1372)=545549.

The quotient is 545548 with remainder 944. Use the safe universal range 1000<=Hstar(c)<=545550. My initial message rounded this safe upper bound as if it were the exact Hstar(4); the equality above corrects that message. The author's arithmetic program already uses the correct formula at c=4 and all other conductors, so no profile totals change.

This correction does not change the Jensen or tail constants. The retained hybrid proof covers star heights below 1300000 and uses a much larger logarithmic envelope through 10^8 plus the small window enlargement. Thus the corrected base heights and translated low-window centers remain covered. The vertical estimate depends on the twist range, conductor and y, not on the incorrect maximum height. The author acknowledged the correction; the coordinator requested that it be recorded here while preserving frozen bytes.

## 1. Complete carriers and actual count inequalities

The statistic uses complete closed nontrivial-zero carriers with true analytic orders, both ordinate signs and real nontrivial zeros. Same-character reflection rho -> 1-conj(rho) preserves height and multiplicity. At a two-point orbit the product of the two weights is Y^-2, so their sum is at least 2/Y by AM-GM. A fixed point has beta=1/2 and contributes exactly its multiplicity divided by Y. Therefore S_chi>=C_chi(H)/Y. No same-character gamma-to-minus-gamma symmetry is presumed for a nonreal character.

This is an actual lower bound for S, not an upper bound. Equality is the hypothetical all-critical-line baseline. It is legitimate to bound that baseline from above using an analytic count upper bound, but this alone says nothing comparable about actual S without spectral information.

The count formula is consumed with the accepted canonical argument and a.e. endpoint convention. It counts actual nontrivial zeros, including real zeros. The two integrable S terms belong to chi and its inverse; the allowance 42+6.93log(cu/(2pi)) is per channel, so their integral contributes at most 2b. It has no finite-RH hypothesis in the reviewed paper assembly. The Binet phase here uses the normalized Gamma logarithm, not a pointwise principal argument.

I independently checked the phase expansion against `FINITE_U_HARDY_NORMALIZATION`, section 2. The bound for its correction is at most alpha^2/t+pi/8+1/(6t)+1/3. For alpha in {1/4,3/4} and t>50 this is less than one. Multiplying by 2/pi still leaves a bound less than one for G-g. The real Binet normalization constant has zero imaginary part. No character-specific phase reset or unstated additive count constant is introduced.

Closed count monotonicity gives

    average_[.99T,T] C <= C(T) <= average_[T,1.01T] C.

The a.e. count formula, phase error and two-channel Turing allowance then give exactly g(.99T)-1-200b/T<C(T)<g(1.01T)+1+200b/T. A zero at either endpoint does not invalidate these integrated inequalities. The script's domains have .99T>50 and g increasing on both intervals.

The rational logarithm witnesses have the correct directions. From (8/3)^k>cu/6, e>8/3 and pi>3, one gets log(cu/(2pi))<k. From 3^ell<(7/44)cl, e<3 and pi<22/7, one gets log(cl/(2pi))>ell. All relevant ell are at least one, so replacing 1/pi by 7/22 in the lower term does not reverse a negative-factor inequality. The count majorant is the ceiling of the resulting strict upper expression. This is an analytic bound on actual counts, not a count inferred from a leading asymptotic term alone.

## 2. Independent conductor and weight reconstruction

I reconstructed phi and squarefreeness independently and obtained primitive-character counts by divisor inversion of phi(n)=sum_{d|n} primitiveCount(d), rather than copying the author's prime-power product routine. I accumulated contributions by traversing each conductor and its squarefree coprime cofactors, rather than factoring each ambient modulus to generate its eligible list. This reproduces every Gauss-mass identity and all four directed profile totals.

The ambient Qset has 199350 moduli. It includes odd q<=132900 and all even q<=265800. Conductors with 2-adic valuation one have no primitive characters. The c=1 term is included in the Gauss identity and removed from the nonprincipal numerator, exactly once. No inverse-character halving occurs. For each q, the independent sum c*primitiveCount(c) over eligible c equals phi(q)^2.

The A numerator is divided by phi(q)^3 only when q is squarefree; B uses phi(q) for every eligible q. Thus nonsquarefree conductors really vanish from A but remain in B. The per-modulus upward rounding to a multiple of 10^-12 occurs before division by Y. The resulting overcount is below 199350*10^-12/Y for each profile. The independent totals exactly match the frozen receipt, including

    Hstar A numerator: 2334842208873139896,
    Hstar B numerator: 59653163807028161309694510,

with common denominator 10^37 for the displayed Q values. The exact squarefree reciprocal-totient upper bound is 13476509744286/10^12<14. All four table decimals round upward.

The two c=3 lower expressions and their target ratios also match independently. There is one primitive nonprincipal character at conductor 3, and q=3,6 already give omega_A>=3/4. Reflection plus the count lower bound proves failure of the specified Q_A target for H3>=2200000, and a factor greater than 19 at H3=10^8/3. This does not show that Wstar itself is too large: the spectral target is only one sufficient reduction and has discarded kernel information.

At Hstar, beta<=203/400 implies each weight is at most Y^-1*10^(3/8). The integer comparison (12/5)^8>1000 makes 12/5 a strict upper multiplier. Multiplying both reconstructed baselines by it still meets the two stated thresholds. This is a valid sufficient finite spectral condition on complete inclusive carriers. It is not established spectral information.

## 3. Full-strip high tail and low-window domain

The actual etaU mixture has factor r^(s-1) with respect to dr, and Gaussian argument s with twist d*r. Its absolute mass is at most integral eta2(r)/r<2 for every beta>0, since r^beta<=1 on [1/4,1]. Compact mixing scales and Gaussian decay justify the Fubini identity. No lower bound beta>=1/8 is needed.

I read `Explicit/ZeroSumBound.lean:105` and its high-zero proof at lines 504 onward. The Gaussian bound requires only -1<=Re(s)<=1; the high sum uses y^beta<=y on 0<beta<1. The low critical-line branch is separate and cannot be invoked wholesale. The new normalized tail correctly loses the old factor y^-1/8 and retains only y^(beta-1)<=1.

For the chosen cutoff, H>=1000 and H>=32pi*D, where D=Dc/49>0. Decreasing the actual twist or mixing scale decreases the EA envelope once u>=10, and the geometric exponential has the required monotonicity. At actual twist zero the EA term is zero. The author's rho_A(D) uses D rather than the source's coarser D+1 denominator. This is sound directly from `norm_G_tail`: the former decays faster, and the old inverse-denominator upper bound with D+1 still dominates it. It is not a literal substitution into a differently defined source rho.

`Explicit/ZeroSumGen.lean:121` bounds each full-strip tail window, with both signs and true multiplicities, by 2Z3+2c3(k+1). It applies to arbitrary finite source carriers. The corrected H range gives Z3<400 and c3<53/H; hence the growth coefficient is at most .106. The window sum uses this linear growth at every k. It never extends a fixed 400 count to infinite height.

The geometric denominator bounds and the positive Taylor witnesses for EA<10^-44 and EB<10^-65 were independently checked with rational arithmetic. The endpoint monotonicities are valid at u>=32 and H>=1000. Their common coefficient, even with the mixture factor enlarged to 1000, is below 10^-30. Positive geometric summability and the reviewed finite-carrier/order limit adapter justify the actual remainder. No unproved absolute convergence of an unsmoothed zero sum is used.

For the low Gram estimate, every translated 3.48 window in the full strip fits a radius-2.7 disk about real part 2 because 4+1.74^2<2.7^2. The polynomial growth envelope covers its centers through Hstar+3.48, including the corrected c=4 maximum. `sum_multRectD_le` supplies the local multiplicity count. The radius-2.3 critical-line theorem is not used. Thus the parent's full-strip Gram constant 7e6 is available at this finite cutoff, conditional on the stated analytic adapters, without QRH.

## 4. Remainder measures and remaining obligations

The separately reviewed sharp vertical estimate is applicable to the actual etaU line and these twists; its normalized vertical and zero-at-zero terms are below 10^-18 for y>=10^25. The trivial point zero is not a replacement for a nontrivial real zero. `ArcCharsStar.coprime_split_star:85` gives removal at most 10^-12*y. Multiplying the nonnegative summand majorant by character values of norm at most one proves the needed twisted removal as well. Together with the high tail this gives e<2*10^-12 uniformly for all y>=Y.

Exact Gauss Parseval mass bounds the remainder character energy at q by phi(q)*e^2. With |P|<1, 2Dq<=8R and the reciprocal-totient bound, the two measures are at most (8R)*14 and (3R/2)*(8R)*(2R). The independent integer comparisons give square-root upper bounds 4000 and 240000000. Therefore T_A<8e-9 and T_B<4.8e-4. The principal overcount in these measure bounds is harmless, but the principal residual in the full Wstar decomposition remains a separate input. Measurability and explicit-formula limit joins are inherited from their reviewed paper proofs, not proved by the metadata program.

The smaller cap500/cap1000 rows carry no corresponding high-tail theorem at the required c=3 twist. They cannot be adopted by discarding the omitted zeros or subtracting cumulative count upper bounds. At Hstar the paper remainder gap is closed, but the finite weighted Q_A/Q_B conditions or the sufficient .5075 strip remain entirely unproved. The plus residual, pointwise base gap, principal spectrum and formal checker/analytic implementation are not discharged.

## Evidence and scope

Independent script `moebius/review_wstar_cutoff_20261111.py`, SHA256 `83ED77A5347873C98ECE0EB36753359AEEC7A624A2B8A71BCA5985E7DAAF46C6`; receipt `moebius/review_wstar_cutoff_20261111.json`, SHA256 `48BD6F6E89B01FF858EDD02BD5D06CC0897B4EE5072B96C52F18ABD968B9DEC5`. The final run passed 863919 integer, rational and file-pin checks. It did not import or run the author program. The first independent run stopped at the incorrect published height bound, exposing the correction above; the corrected-domain replay then reproduced all frozen profile totals. Every one of the author's fifteen table pins was checked.

The direct source reads covered `ZeroSumBound`, `ZeroSumGen`, `ExplicitBoundGen`, `ArcCharsStar`, and the definitions of qt/Qset, together with the cited count, Binet, hybrid and smoothing proof interfaces. Prior analytic foundations and finite-character classification identities retain their paper/source status. No Lean build, numerical special-function value, prime certificate or spectral data was generated. The verdict is for the corrected bounded implication and metadata, not end-to-end proof closure.
