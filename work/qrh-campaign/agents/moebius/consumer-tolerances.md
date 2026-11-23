# Möbius consumer audit and numerical tolerances

This note audits calr3/ternary-goldbach at commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. Source was read through the GitHub connector and local read-only access. No Lean compilation was performed. The companion consumer_tolerances.py reproduces the floating-point calculations below. These calculations are research diagnostics, not newly proved inequalities.

## Source dependencies and existing finite coverage

Prelim/MoebiusProfile.lean lines 16–24 and 75–126 bounds |m(x)| log x by 0.03, 0.092, 0.09, 0.08, 0.035 and 0.075. The boundaries are 100000001, 9001713129, 1525381771989686, 747499893696668303884288 and T, with 160.54 ≤ log T ≤ 160.55.

The interval 11815 ≤ x < 100000001 already has a proof independent of PlattGRH. MoebiusProfile.m_small_real uses the finite Möbius walk below 2160535. Sch.m_mid uses unconditional Sch.M_low, namely |M(n)| ≤ 0.571 sqrt(n) for 100 ≤ n ≤ 100001092. The induction starts at X0 = 100000000, with |C(X0)| ≤ 626 and Ssum X0 ≤ 11519. Thus no replacement psi theorem is required for the existing profile below 1e8.

Prelim/SchoenfeldJ.lean lines 24–88 supplies the prime-estimate input. For integer v ≥ 12 its additive rho envelope is

    2 sqrt(v)
    + 1[v ≥ 1e9] 35.5 sqrt(v)
    + 1[v ≥ 32000000001] 72 sqrt(v)
    + 1[v ≥ 1e12] v (1/log(v)^3 + 4.92e-7 + 1.4262/sqrt(v)).

The first range invokes psi_le_two, the middle ranges psi_two_sided, and the final range theta_explicit. All currently reach PlattGRH.

SchoenfeldGen.bTerm_le only uses the first estimate at Y. The generator restricts Y to at most 1000000. This boundary term can be handled by finite prime certificates, with the endpoint 1000000 checked separately if using the strict small-table range. The j-sum requires prime estimates all the way through D and is the substantive obstacle.

SchoenfeldTailAux.rho_C5 requires |psi(v)-v| ≤ 0.00985 v/log(v) for v ≥ 1e12. The tail also invokes sum_Lambda_div_Ioc through G_tail_le. Replacing rho_C5 alone therefore leaves a second PlattGRH dependency.

## Liouville tolerance

Prelim/LiouvilleBound.lean lines 239–356 consumes |m(y)| log(y) ≤ 0.14 for y ≥ 11815. The final numerical inequality is

    c (1.64495 + (2/9) 1.0117) + 1.414214 × 5.6 × 0.04 ≤ 0.99.

At c = 0.14 this equals 0.5785520471111112. The same argument permits c ≤ 0.3600524470300898. A proved uniform c = 0.36 would therefore preserve the public 0.99 Liouville statement after changing the internal bound and arithmetic. The small Liouville range through 100000 has its own kernel walk.

## G2 tolerance

MinorArcs/G2Tail.lean lines 400–617 reduces its analytic input to

    Σ[j ≥ 11815] m(j)^2 log(1 + 1/j) ≤ 0.00050423.

For step constants c_i on intervals [a_i,a_(i+1)), the source proves the sufficient bound

    1.00001 Σ_i c_i^2 (1/log(a_i) - 1/log(a_(i+1))),

with 1/log(infinity) interpreted as zero.

Keeping the proved profile 0.03 below 100000001, a uniform c thereafter meets the existing tailV budget when c ≤ 0.09176155186921095. A uniform c = 0.09 gives 0.0004868481449238132. A uniform c = 0.092 gives 0.000506608741443673, exceeding the present budget.

The final constants in G2Tail.lean lines 1205–1217 evaluate to 0.008150877672866425 against the public ceiling 0.0082, leaving about 0.00004912232713357584.

A separate floating-point replay of the Euler-product sum uses direct Möbius values through 11814 and the source's powers-of-two lambda selection. It produces 0.008149960393738276 at the original tailV, about 9.17e-7 below the certified source constants because it omits fixed-point rounding overestimates. Its estimated maximum tailV is 0.0005101566636338. This corresponds to a uniform profile about 0.0923545 after 1e8. This is an experimental ceiling that requires a new exact certificate. It gives only about 1.2 percent more tailV than the current budget.

## Tail induction tolerance

Prelim/SchoenfeldTail.lean lines 584–590 contains the final rational tail inequality. Holding its other constants fixed, the left side is approximately

    0.019162008259280185 + 1.2471594028866984 C5.

The right side is 0.033 (1 - 1/160.54). The rho coefficient C5 can therefore rise from 0.00985 to approximately 0.010930788367150016. This is only an eleven percent relaxation.

## Concrete QRH interface and remaining gap

A theorem |psi(x)-x| ≤ C x^(7/8) log(x)^2 gives relative envelope C exp(-L/8) L^2, where L = log(x). It is decreasing for L ≥ 16. Generalizing eps_piece and eps_last to this envelope gives a direct route into the existing cell induction. The exact rational generator scripts/gen_schoenfeld_cells.py exposes the corresponding numerical operations as epsq, eVal, Xq and make_cell. Its output then needs a revised soundness proof and kernel replay.

For C5 = 0.00985 the tail comparison is C exp(-L/8) L^3 ≤ 0.00985. Experimental crossover values are

| C | log(x) crossover |
|---|---:|
| 1 | 158.54758505692928 |
| 10 | 180.01605653102564 |
| 100 | 201.0941943201865 |

No coefficient C of this shape has been proved in the campaign. Even the optimistic C = 1 leaves a long interval after the unconditional Möbius certificate ends near 1e8.

A uniform theorem |m(x)| ≤ 0.09/log(x) for x ≥ 1e8 would suffice for both consumers. It remains a substantive missing theorem. The current evidence supports adapting the cell machinery once a strong enough finite-range psi or direct Möbius estimate is available. It does not yet supply such an estimate without finite RH.

The next useful numerical test is a full regeneration from a specified and proved replacement psi envelope. Reject candidates whose induced squared-profile sum exceeds 0.00050423, or approximately 0.0005101 if the downstream G2 certificates are regenerated. Improving Liouville alone does not resolve the G2 requirement.


## Follow-up on principal-only L2 and the immediate Type II consumer

The principal-only lower bound in agents/prime-estimates/L2_REPLACEMENT.md preserves the existing J ≥ 8.6296 target, and therefore supplies the same 8.6294 subtraction in MinorTotal.Mexpr. It does not alter the Möbius/Liouville profile requirements. An upper target J ≤ 9 or J ≤ 10 changes the major-arc residual budget but has no direct call to G2Tail.

A wider tolerance appears one level beyond G2Tail. T2Bound.T2_le' proves, for S ≥ 10000,

    T2(S) ≤ 1.4423050431/4 + 9.2185538/10000 + (5/4) G,

where G bounds the G2 tail integral. Its public output is T2(S) ≤ 0.37273. Hence any

    G ≤ 2246376769/250000000000 = 0.008985507076

preserves that output by exact rational arithmetic. The finite range 16 ≤ S < 10000 uses the existing independent T2_le_small certificate. Source search found only T2Bound as a direct consumer of tail_integral_le. TypeIIS1 consumes the preserved 0.37273 statement.

The updated consumer_tolerances.py repeats the G2 model against this larger G target. Its bisection finds a candidate tailV boundary near 0.0006029387477622. This is a floating-point local crossover, with source rounding omitted, rather than a certified maximum. It corresponds to a uniform |m(x)| log(x) constant near 0.101185 after 100000001 while retaining 0.03 below that point.

The simpler candidate constant 0.10 gives a profile tail bound of approximately 0.0005899941157692, leaving some numerical room below the modeled crossover. Thus a proved |m(x)| ≤ 0.10/log(x) for x ≥ 100000001 could be tested by regenerating the exact G2 certificates and relaxing its internal integral bound, while preserving T2_le' and all downstream Type II constants. The new Möbius theorem and exact recertification are still missing.


### Exact replay of the relaxed G2 budget

The additional script g2_exact_replay.py implements the integer formulas from G2TailNum and the rational logarithm numerators from T2Kernel. Before testing the new budget it reproduces all three original values exactly: cP, Macc, and tv_one. Its new run uses tailV = 59100 × 10^16 and returns

    Macc = 83880895988858868494442540089180897636298467585444092347657730
    tv_one = (549755813888, 1483444053877)

The exact final rational G2 bound is

    8884671087630412081042571269947465763629846758544409234765773
    / 1000000000000000000000000000000000000000000000000000000000000000

which is approximately 0.008884671087630412 and is less than 0.0089 by exact fraction comparison. The script also checks, with fractions only,

    1.00001 × (0.0009/9.377 + 0.0091/18.42) ≤ 0.000591,
    1.4423050431/4 + 9.2185538/10000 + (5/4) × 0.0089 ≤ 0.37273.

Thus the computational data for a uniform 0.10 Möbius profile above 100000001 are now available with all source rounding included. The Python replay is not a Lean kernel certificate. A Lean replay of the modified numerical constants and a proof of the new Möbius profile remain required. No repository source was changed.


## Global unconditional upper bounds available to the energy argument

The target pins Mathlib commit 56a005855ea17e0b0958f73ec801ae140b0a1679, and the inspected cached source has that same HEAD.

- Explicit/PsiSandwich.lean:34 exports psi_le_four for every natural N, giving Helfgott.psi N ≤ 4N. Its real-argument wrapper psiR_le at line 90 gives psiR(y) ≤ 4y for y ≥ 0.
- Mathlib/NumberTheory/Chebyshev.lean:441 proves the sharper explicit form psi(x) ≤ (log 4)x + 2 sqrt(x) log(x) for every real x ≥ 1.
- Helfgott/Chebyshev.lean:207 exports psi_le with coefficient 1.387 only for natural N ≥ 10^27. This threshold is above the starting scale x = 4.9e26.
- For prime-supported energy, Helfgott/Chebyshev.lean:24 gives theta(N) ≤ N log 4 for every natural N. Mathlib Chebyshev.theta_le_log4_mul_x at line 191 gives its real-argument version for x ≥ 0.
- LambdaMu.psiN_le at line 353, the global coefficient 1.03883, retains Fact PlattGRH. The exported unconditional coefficient 1.03883 in SmallPsi700 applies only to 1 ≤ n ≤ 700. Extending that coefficient below 10^6 is the queued finite scratch proof, using SmallTab.small_table.

The global theta bound may be preferable in an energy sum supported on primes, since it avoids adding prime-power terms.

