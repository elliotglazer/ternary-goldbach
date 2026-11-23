# Independent review of Gamma growth inputs

2026-11-11. Verdict: PASS for the two bounded source-level mathematical implications and their primitive-strip application. No correction is required to the [author report](../qrh-campaign/agents/prime-estimates/QRH_GAMMA_GROWTH_ANALYTIC_AUDIT_2026-11-11.md), SHA256 `A7D461828B1832622C66F5E450BB25EAF3C98EE4B75BD3BD240DE00B5861A7FF`.

The report was read in full. The reviewer independently read the relevant OAI proof bodies and the target Mathlib beta identity, Gamma nonvanishing, all-argument reciprocal recurrence and entire-reciprocal proof. This is neither a build result nor validation of the entire QRH provider. The inspected Mathlib is the target cache at revision `56a005855ea17e0b0958f73ec801ae140b0a1679`; OAI revision `4eaee87548250b2682affda7d05d947c05554bae` pins a different Mathlib revision, `d13f23b723b8a846827a245b89c10fc7d3f11612`. Matching these mathematical uses is not a compatibility test.

## Shifted ratio from a convergent beta integral

Let p=a+sigma>0 and d=n-2sigma>0. Both p and p+d are positive. The beta integral gives

    Gamma(p+it)/Gamma(p+d+it) = B(p+it,d)/Gamma(d).

For x in (0,1), the modulus of x^(p+it-1) is x^(p-1). The other factor is real and nonnegative. Both endpoint singularities are integrable because p,d>0. Taking the norm inside the integral therefore gives

    |B(p+it,d)| <= B(p,d).

The positive real beta-Gamma identity then yields

    |Gamma(p+it)/Gamma(p+d+it)| <= Gamma(p)/Gamma(p+d).

This is the body of `Gamma_vertical_ratio_bound`, not a consequence of a numerical Gamma estimate. Gamma(d)>0 justifies its cancellation. Mathlib first proves the product beta identity from the absolutely integrable positive convolution; its quotient version is derived only after nonvanishing is available.

The target `Gamma_shifted_pair_bound` has denominator Gamma(a-sigma+n-it). Gamma conjugation changes the sign of t without changing this denominator's norm. The proof makes this norm replacement, rather than asserting equality of the two complex quotients. It holds for every real t under the strict p,d hypotheses. No claim at p=0 or d=0 follows.

At the primitive-strip specialization a=1/2, sigma=3/5, n=2 and height -t, the beta parameters are 11/10 and 4/5. The bound becomes

    |Gamma(1-s)/Gamma(s+2)| <= Gamma(11/10)/Gamma(19/10),
    Re(s)=-1/10.

The all-argument reciprocal recurrence implies Gamma(s)^(-1)=s*(s+1)*Gamma(s+2)^(-1). Bounding this two-factor product by (3+|t|)^2 yields the source's left-boundary estimate. The ratio constant is independent of conductor and height.

## Entire reciprocal and the direction of the shift

Write R(z)=Gamma(z)^(-1) in Mathlib's convention. This is an entire function, with value zero at each nonpositive integer. The source uses the all-argument identity

    R(z) = product_{k=0}^{n-1}(z+k) * R(z+n).

At z=0 this follows from the explicitly handled zero case of the reciprocal recurrence. The library proves entire differentiability by shifting a point finitely many times to the positive half-plane and applying the recurrence. Thus continuity of R on a rectangle including poles of Gamma is valid; continuity of Gamma there would not be.

For Im(z) nonzero, Gamma(z), Gamma(1-z) and sin(pi*z) are nonzero. Reflection can then be rearranged to

    R(z) = Gamma(1-z)*sin(pi*z)/pi.

For Re(z)<1, the Euler integral implies |Gamma(1-z)|<=Gamma(1-Re(z)). The elementary exponential expression for sine gives |sin(pi*z)|<=exp(pi*|Im(z)|). Both uses preserve their stated domains.

On a fixed real strip [a,b], choose a natural n>b and put w=z-n. For |Im(z)|>=1, each recurrence factor w+k has norm at least one. Consequently

    |R(z)| <= |R(z-n)|.

This direction is essential. It is proved by a lower bound on the recurrence product, not an upper bound. Since 1-Re(w)=n+1-Re(z) lies in a fixed positive compact interval, the real Gamma factor is bounded by some Cg. Reflection now gives (Cg/pi)*exp(pi*|Im(z)|) for |Im(z)|>1.

The complementary rectangle, a<=Re(z)<=b and |Im(z)|<=1, is compact. Entire continuity gives |R(z)|<=Cc there. Taking C=Cc+Cg/pi proves the full strip bound, including t=0 and t=+/-1. An empty interval a>b causes no problem. The constants may depend on a,b; they are uniform in z on that strip. They are existential constants, not a numerical evaluator or a sharp pi/2 exponential rate.

## Consumption and remaining boundary

`Hecke/Strip.uncompleted_exp_bound` combines the fixed-strip reciprocal bound with bounded Mellin data and a positive real completion scale. The real scale power is bounded by the sum of its endpoint values. Its temporary exponential-growth constant can depend on that scale and hence on the conductor. The later Phragmen-Lindelof argument only requires the existence of this growth witness; its final uniform boundary constant is controlled separately by the actual conductor-height bounds. No uniformity in conductor has been inferred from the Gamma strip compactness argument itself.

This review resolves the two Gamma estimate assemblies relative to the inspected standard library facts. It does not independently prove the Euler sine product, all Gamma-limit dominated convergence, general integration or compactness results, nor the OAI theta functional equation, principal residue or final zero-supremum continuation. All of those remain outside this bounded verdict. No Lean source was edited, no Lean command ran, and no analytic value was computed.

## Source pins and read scope

Hashes bind whole-file bytes. Ranges record independent reading, not validation of every imported result.

| Source | Independent read scope | SHA256 |
|---|---|---|
| OAI QuadraticSieve/MainTermDifference.lean | 151-325 | 3B2152A57FB0EA580EEC5CB32ADE8709F9892890B6DBDD93392300BFB1CA3924 |
| OAI Mellin/VerticalContourShift.lean | 283-462 | 134E7C35AFB52CFE6282F1415F7304F84FC18C31C93AD9086FEE8440414C7ABD |
| OAI Hecke/Strip.lean | 1-76 and 279-322 | E6E35BDEA0A7595D8AD88FB185A8C38367E8EC1878C9312E3D2BB0BE3C4F8AB8 |
| Mathlib Analysis/SpecialFunctions/Gamma/Beta.lean | 117-160 and 420-552 | C166D25802EDF2883DB91226CFF7B5F5432BB9E8DCF1A0EDD88932D59C3E724C |
