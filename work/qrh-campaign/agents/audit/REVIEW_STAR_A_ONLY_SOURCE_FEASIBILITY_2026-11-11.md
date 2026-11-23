# Review of the A-only source-sieve feasibility result

2026-11-11. PASS at the stated conditional paper/source and exact-scalar scope. No correction requested. The obstruction concerns the uniform weighted coefficient-comparison method, not the actual A energy. No analytic value, prime sum, zero or transform was evaluated; no builds or source edits were made.

Author `independent-feasibility/STAR_A_ONLY_SOURCE_FEASIBILITY_2026-11-11.md`, SHA256 `B6FF600BE16B85502CD86593C5566452C8B1202CC24F49DA579E90323A642263`. I read the complete report, its scalar source and receipt, and the relevant source bodies in LargeSieveProof, LSQuot1, Bombieri and EtaCirc. The current cubic allocation and etaU coefficient theorem are used at their separately reviewed conditional scope.

## Weighted identity and source domain

The normalization is correct. Exact character Parseval for the q-dependent coprime sequence gives

    E_q = sum_b |F'_q(b/q+delta/x)/y|^2
          - mu(q)^2/phi(q)*|F'_q(delta/x)/y|^2.

Multiplying by mu(q)^2*|P(delta)|^2/phi(q)^2 produces the principal subtraction with phi(q)^3 in its denominator. Here mu^4=mu^2. The q=1 and q=2 nonprincipal energies vanish, so removing both complete full-minus-principal terms before estimation is valid. It would not be valid to remove only their principal subtraction.

`LargeSieveProof.Farc_eq:143` obtains the actual character coefficient by finite interchange. Adding a fixed nonnegative lambda_q(delta) at each delta preserves that interchange, its inverse-character labels, and the Gauss weight from `Bombieri.norm_sq_gaussSum:135`. It yields the author's W_lambda. The unrestricted denominator retains all large-family moduli. No average of lambda over q is substituted for the pointwise coefficient comparison.

The prime-supported sequence g uses primes strictly above sqrt(x)=7sqrt(y). With Q=sqrt(x/16), every modulus through 2Q is smaller than that prime threshold. This supplies the common-coprimality requirement in `prop_12_1_2:295`. At R=132900 and x>=49*10^25, its size condition 8R^2<=x/2 holds. The source's large-family arc sum is bounded by the full-circle integral, followed by Parseval. The conversion from normalized delta-energy to the coefficient norm contributes x/y=49, so the prime part is bounded by 49*C_A*tlarge.

The weighted adaptation is a new paper implication of those bodies, not a theorem already implemented in the source. Finite q sums, bounded continuous P, compact arcs and the summability of g justify integration. Open source arc endpoints and the closed target integration endpoints differ only on a finite null set.

For the small coefficient sequence h, lambda<=1/4 on q>=3. A short direct justification of the used |P|<1 is available from the same smoothing-tail input: after u=t-1, integral etaO is at most integral_-1^1(1-u^2)^3=32/35. Therefore integral |etaPlus|<=32/35+.00221<1. The Fourier norm inequality gives |P|<1 without a transform evaluation. The small-part bound 49*esmall/4 then follows from the same disjoint physical arcs and full-circle Parseval. It is an upper allowance; its being too large is not evidence that the actual small-part energy is large.

The coprime-removal weighted norm is at most d0*sqrt(.640208*sum mu^2/phi). The extra phi in this expression is the number of unit numerators, not a missing normalization. The claimed <6e-9 is safe with d0=2e-9 and the mass upper bound 13.59756. Minkowski before squaring gives all cross terms in formula (2). Keeping L_Acop as a subtraction afterward is exact and legitimate.

## Conductor-3 constraint on this method

For c=3, the q=3 and q=6 terms each have lambda=|P|^2/4 and w/phi=3/2. Their sum is (3/4)|P|^2. The large-family coefficient is 3*G_6(Q/3): c/phi(c)=3/2 and the source parity factor kap(c)=2. Natural truncation in m_Q causes no change to G at Q/3, since its defining sum depends only on the resulting integer cutoff.

All moduli are active when |delta|<4, because the narrowest delta half-width at qt(q)=2R is 4, and the same statement holds for Q. Thus the comparison requires C_A>=|P(0)|^2/(4G_6(Q/3)). If the comparison is required only almost everywhere, continuity of P and the open active neighborhood still imply this inequality by approaching zero through the full-measure set. A special exception at delta=0 does not remove the obstruction.

The actual etaO lower bound is also correct. On [-1,1], (1-u^2)^3 is nonnegative, so exp(-u^2/2)>=1-u^2/2 gives integral etaO>=272/315. The smoothing error has integral at most .00221. Hence |P(0)|>=5426077/6300000>.86. This argument uses the actual smoothing and no positivity assumption on etaPlus itself.

`LSQuot1.ramare_Gq:31` has a fixed absolute constant and an explicit decaying error. Specializing to d=6 gives G_6(z)=(1/3)log(z)+O(1). Since log(Q/3)=(1/2)log(y)+log(7/12), the necessary asymptotic comparison is

    liminf C_A(y)*log(y) >= (3/2)|P(0)|^2 > 1.1094.

The etaU two-sided coefficient theorem gives liminf tlarge/log(y)>=(1-.000468)*V_U, with V_U>49/64. Its error is O(log(y)), not O(1); the report correctly retains the factor 1-.000468. Both relevant sequences are nonnegative and their eventual lower bounds are positive, so multiplying their lower bounds is justified.

For the subtraction, the true Fourier amplitude is at most integral etaU=sqrt(pi/2)<sqrt(2). The retained inner principal coprime error is 1.502e-6. Since (1.415-1.502e-6)^2>2, the principal amplitude is below 1.415. The full |P|^2 integral and sum mu^2/phi^3<=32/13 give L_Acop<.640208*(32/13)*1.415^2<3.156. This is an upper bound on the subtraction, which is the correct direction for a lower bound on the method's upper expression.

It follows that the upper expression in formula (2), even after omitting its nonnegative small-part/removal costs, has limiting lower bound greater than

    7996571791889/208000000000 > 38.

This rules out proving A<=1e-10 uniformly by this particular scalar comparison and these subsequent bounds. It supplies no lower bound on A. In particular, the argument does not assert that the actual c=3 sum saturates its coefficient, or that a delta-dependent comparison, centered denominator, or separate variance estimate must fail.

## Conductor cutoff and actual small-conductor target

Only odd squarefree primitive conductors enter A. In each nonnegative conductor component, c|q implies q>=c. For q<=265800, at most six distinct primes divide q, since their first seven possible values have product 510510. The totient product is therefore at most 30030/5760<21/4. Consequently A_>C<=(21/(4C))^2*B_>C and the substitution B_>C<=1915 is a valid, deliberately crude bound.

I independently reproduced all four displayed fractions and checked the two adjacent integer thresholds: C=22974375 passes the scalar 1e-10 comparison, while C-1 fails. This is beyond every nonempty conductor tail in the present family. Of course a tail beyond the entire conductor domain is exactly zero; the result concerns the usefulness of the proposed scalar transfer for a nonempty tail, not a requirement to certify nonexistent conductors.

At q=3 there is exactly one nonprincipal unit-group character and its Gauss square is 3. The actual A coefficient is therefore (1/4)*(3/2)=3/8. Nonnegativity gives the necessary individual target integral |P|^2*|Schar/y|^2<=8e-10/3. This is the report's genuine necessary condition on an actual energy. It must not be confused with the unrelated >38 lower bound on the method's upper expression. Its induced contributions at other eligible q cannot be erased simply by removing q=3 from the ambient sum.

## Evidence and limits

Independent script `audit/review_star_a_source_feasibility_20261111.py`, SHA256 `CC6ED09A19DE5537CAF2477A180AA60E6B5F03BC4A594ECCB9F972874B944727`.

Independent receipt `audit/review_star_a_source_feasibility_20261111.json`, SHA256 `168C87DA2528F3E323B2C5802ADA469311395F1750CB643E814510F35F99CB21`.

All 35 exact checks passed, including all twelve input pins, independent polynomial multiplication/integration, the amplitude and subtraction bounds, the limiting rational expression, the four conductor splits and the minimal integer cutoff. The author script was not imported or run.

The source pins include LargeSieveProof `FB71222C80D0377BDF6739529E527F4BE6A0C908286FF87F0EC19D67DDE9CAF1`, LSQuot1 `9AAEAC8990CA63FE1267F24280EE89A956455EC9AC59A6246A56FDE5469E762E`, Bombieri `F3236E24D824647816AB0370CB57FB958C642194643393F20E785096888D3C79`, and EtaCirc `92491AA65FAE2EFACE1797174018FFEA43C11DD827F83B0A4B0958B54BB0D3CE`. The receipt stores the full paths and remaining pins.

Principal localization, finite arithmetic, smoothing inputs, source compatibility and kernel validation retain their existing status. A remains unproved, and even a new proof of A alone would not remove the current plus and base-gap certificate demands. No actual-A impossibility or computation saving follows from this review.
