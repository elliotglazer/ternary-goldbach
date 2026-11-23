# Finite principal RH as a replacement for the dense prime ladder

2026-11-11. Coverage and cost interface only. This note does **not** prove a finite-RH prime-gap estimate or certify additional zeta zeros. The analytic theorem is a separately required input to the proposed proof route; it must ultimately be proved and its finite spectral premise checked, not added to the final Goldbach theorem. No prime, zero or analytic-function evaluation, build, or source edit was performed.

The potential saving is real only if one uniform analytic interval theorem replaces many separate prime certificates. Computing the same number of local interval predicates in a different representation is batching, not elimination of their arithmetic work. This distinction controls the comparison below.

## 1. Exact source replacement interface

`TernaryGoldbach/Helfgott/SmallCases.lean:21` proves the finite ternary range from `BinaryGoldbachInput` and `Ladder.ladder_prime`. Its two branches are exactly: use 3+(n-3) for n<=4e18+3, and otherwise produce a prime in [n-4e18,n-4]. `Ladder/Main.lean:19` supplies the latter through certified windows. The current declarations hard-code 4e18; a proof through a smaller B does not inhabit the existing `BinaryGoldbachInput`.

For a proposed even B>=4 and the unchanged even N=10^27, the required replacement lemma is simply:

    for every odd n with B+5<=n<N,
    there exists a prime p with n-B<=p<=n-4.          (C)

Given a **proved** binary theorem for all even m in [4,B], (C) proves all odd 5<n<N. For n<=B+3 use 3+(n-3). For n>=B+5 the prime p is at least5, hence odd; n-p is even and belongs to [4,B]. The large-odd theorem supplies n>=N. Since N is even, the original inclusive small-range endpoint causes no discrepancy.

An explicit prime-interval theorem can supply (C) without materializing p. One sufficient endpoint convention is

    for every relevant odd integer x>=3,
    there is a prime in (x,x+B-2].                  (G)

Set x=n-B-2. The prime is odd, so p>x implies p>=x+2=n-B, while the upper endpoint is n-4. At the first n=B+5, x=3. At the last n=N-1, x=N-B-3. Thus the exact required x-grid is the odd integers in [3,N-B-3]. A real-x theorem over that closed range is stronger and sufficient. A theorem for (x,x+h] with 0<h<=B-2 also suffices.

For an integer lower validity threshold X0>=3, (G) leaves the odd n with B+5<=n<B+2+X0 uncovered. At equality the analytic theorem applies if its lower bound is closed. This low range needs a separate proof, such as the existing ladder through that smaller endpoint or a certified finite computation. A theorem starting only at a large X0 must not be called a full replacement of the finite ladder. If the theorem has a strict cutoff, rational/real cutoff, upper endpoint, or x+h domain restriction, convert those inequalities explicitly before instantiating x.

An upper-endpoint version with p in [y-g,y], y=n-4, suffices if g<=B-4. These different constants are not contradictory: (G) uses an open odd left endpoint and gains the parity step of two. “Gap at most B” without a specified endpoint/parity convention is insufficient as an exact interface.

## 2. What the finite spectral premise must mean

The proposed analytic theorem may require genuine principal finite RH: every actual nontrivial zeta zero with |Im rho|<=H has Re rho=1/2, with the theorem's chosen inclusive/strict height convention. A list of critical-line zeros without completeness is not that premise. The finite certificate must account for multiplicities, both signs or a proved conjugation reduction, real zeros, and a top boundary. A previously certified beta<=.555 strip is not finite RH and cannot be silently substituted.

Only compatible already certified information can be reused. If the analytic route already plans a principal certificate to height H0, the marginal cost of a stronger RH certificate is not automatically the cost of the height increment: strengthening the old region also needs verification unless the old packet actually proves RH. The shared nonprincipal family is unchanged by this principal-only optimization. Neither global RH nor a new finite-RH assumption appears in the desired final theorem.

An estimate for psi is not itself a prime interval theorem. To obtain a prime in (x,x+h], either prove theta(x+h)-theta(x)>0, or prove

    psi(x+h)-psi(x)
      > sum_{x<p^k<=x+h, k>=2} log p.

The latter requires an actual prime-power upper bound valid on the whole range. For example, a proved absolute psi error E(t,H) and a proved prime-power bound P(x,h) give the sufficient scalar inequality

    h > E(x+h,H)+E(x,H)+P(x,h).

This is an implication, not a supplied estimate. Uniform scalar bounds can be verified on finitely many monotonicity cells if the analytic theorem proves that those cells bound **every** x; sampling selected x does not suffice.

## 3. Which compressions eliminate rung enumeration?

### A. A uniform analytic theorem does

A proved formula of the form `FiniteRH(H) -> forall x in I, PrimeIn(x,x+h(x,H)]`, followed by a scalar bound h(x,H)<=B-2 and the endpoint conversion above, yields (C) by universal instantiation. There is no need to choose, store or primality-check one particular prime for each n or each ladder interval. Classical existence is adequate for this theorem; no executable prime-selection algorithm is required by the Goldbach conclusion.

The work has moved to a precisely stated object: finite spectral verification, its explicit-formula/prime-power proof, uniform scalar inequalities, and the low-range patch. That may be much cheaper, but must be counted. This is the only route here that removes the numerical prime-window array itself.

### B. Local interval predicates alone generally do not

For x in a cell [a,b], a certificate that theta(a+h)-theta(b)>0 proves a prime in the common core (b,a+h], hence in every (x,x+h]. If a+h<=b, that core is empty and this certificate cannot work. Thus such common-core cells have width less than h. This method can avoid *naming* their primes, but a local-predicate implementation still needs on the order of N/h cells unless one theorem generates all their positivity proofs uniformly.

Checking many interval counts with a shared transform may lower arithmetic per cell. It still has to connect each output to the actual prime-count expression, control all transform/tail/rounding errors, and establish positivity for every cell. A sampled count, unexplained FFT output, or positive total sum cannot prove each individual count positive. Shared source or spectral data and their full transform costs belong in the comparison.

For nonnegative integer counts c_i, product_i c_i>0 or sum_i 1_{c_i=0}=0 are sound aggregate formulations. They do not provide a cheap computation of the actual c_i. Packed digit positivity is another valid batching method only after actual coefficients and carry bounds are established. No universal computational lower bound is asserted, but an implementation that computes every c_i cannot omit that work from its ledger merely because its final assertion is one product or one equality.

### C. Explicit prime-window certificates have a representation-count bound

An odd prime p covers exactly the odd targets in [p+4,p+B], at most B/2-1 of them. The targets not already handled by 3+(n-3) are the (N-B-4)/2 odd integers from B+5 to N-1, assuming B<=N-5. Therefore any proof whose finite coverage object is only a union of K such individually certified prime windows must have

    K >= ceil((N-B-4)/(B-2)).                       (R)

Overlaps and endpoint clipping can only increase the required K. This is a bound on that representation, not on all mathematical proofs. A prime-generating family theorem or (A) can evade the representation entirely. Compressing offsets, batching primality proofs, or using an existential count for each common-core cell may reduce bytes or per-instance work while retaining the same order of instances.

At N=1e27, (R) gives 100000000000 such windows for B=1e16 and 50000000000 for B=2e16. The earlier mixed ladders use about181 billion and91 billion windows because their guaranteed stride is smaller than B. A better explicit-prime placement can improve that constant, but cannot turn this particular representation into a polylogarithmic certificate.

## 4. B versus principal height H

Let G(N,H,X0) be a rigorously proved **uniform sufficient interval length** for the exact x-range above, with any extra scalar parameters already included. It may be a bound on primes directly or the result of the psi/prime-power inequality. Define

    H_req(B) = least permitted certified height satisfying
               G(N,H,X0)<=B-2 and every theorem side condition.

If G is not proved monotone in H, use its actual sufficient parameter set instead of assuming a least-height monotonic search. If no such H exists, this theorem does not support B. If X0 changes with B or H, its finite patch changes too.

For each proof system S the proposed alternative costs

    C_alt(B,L,pi,H)
      = C_binary_S(B,L,pi)
        + C_principal_S(H; compatible reused evidence)
        + C_gap_proof_S + C_scalar_S + C_low_patch_S(X0,B)
        + C_assembly_S + common_other_analytic_S.

Compare it with the explicit ladder at the same B,L,pi by the exact inequality

    added principal verification + gap proof/scalars + low patch
      + changed assembly < complete ladder generation/checking removed. (E)

The common binary cost cancels in this comparison. When optimizing B it no longer cancels: use the joint binary frontier and add the new H_req(B) term. A zero-count proxy proportional to H log H is useful for sizing a family of algorithms but is not a measured certificate runtime. Complete verification includes all local enclosures, sign/count topology, transforms, tails, serialization and rechecking, not merely the number of expected zeros.

### Conditional model showing the limiting tradeoff

Suppose a separately proved theorem has the sufficient envelope

    G(N,H,X0) <= A(N,X0)+D(N,X0)/H,

with A>=0,D>0. These symbols are not established constants in this note. Then B>2+A is necessary for this envelope to give a finite solution, and

    H >= D/(B-2-A)

is sufficient for that part of the condition. As B approaches the analytic floor 2+A, the required height diverges. No amount of finite spectral checking removes A from this particular bound; a better gap theorem would be needed. If the actual envelope contains log H factors or other restrictions, solve that actual inequality instead.

For a local binary cost aB and a conditional principal work model d*H*log H, the smooth objective after setting H=D/(B-2-A) is

    aB + d*[D/(B-2-A)]*log[D/(B-2-A)] + fixed terms.

Writing z=B-2-A, its stationary balance is

    a = d*D*(log(D/z)+1)/z^2.

This is a sensitivity identity, not a forecast. It shows a steep penalty near the floor. A theorem with an irreducible square-root term and a finite-height truncation term must be optimized as both terms, not by treating H merely as N/B. Restoring changing L, source costs and low patches can move the optimum further.

## 5. What would decide the route

First obtain the exact analytic theorem, including its true-prime conclusion, lower x threshold, upper range, complete finite-height hypothesis and constants. Without it there is no H_req(B) to compare. Next determine a credible complete principal-certificate cost at the resulting height using a shared evaluation/counting implementation. A low-height easy panel is not a calibration for production height, and a list of computed zeta zeros is not a finite-RH certificate.

The most useful small numerical experiment, if separately authorized later, is one complete **principal RH verification block near the required H**, including local evaluations and completeness/count joins, with full checked cost. Its scope must be compared with the same method's stated high-height arithmetic model; it cannot establish every block succeeds. The corresponding analytic scalar check should be exact interval/rational work derived from the theorem, not numerical sampling of prime gaps.

If (E) fails even under a favorable justified principal-cost bound, keep the explicit ladder. If (E) has a substantial margin, optimize B,L jointly and build the missing principal/gap formal interfaces. No present statement in this note changes the final theorem's assumptions or claims a completed finite-RH certificate.

## 7. Coordinated candidate and a constant-size low-end patch

The analytic worker `independent_feasibility` reports a candidate based on Johnston's finite-height theta estimate: validity for t>=599 with a height condition, and proposed H=9e12 sufficient through N=1e27 with a two-endpoint error below 9.75e15. This is a **pending analytic handoff**, not an independently verified theorem or constant in this note. Its final primary-source audit, exact scalar inequalities, finite-RH certificate and formal translation remain required. The following coverage deduction is independent of how that estimate is obtained.

Assume the reported estimate is proved. Put y=n-4 and h=B-4, so y-h=n-B. For B=1e16 the asserted strict error bound gives

    theta(n-4)-theta(n-B) > (B-4)-9.75e15 > 0

whenever n-B>=599 and both endpoints are in its proved domain. The resulting prime lies in (n-B,n-4], which supplies (C). No prime-power subtraction is needed for a theta estimate.

The remaining endpoint patch is constant-size: separately certify one odd prime p0 with 599<=p0<=B+1. Its interval [p0+4,B+p0] overlaps or is adjacent on the odd grid to the base interval ending at B+3, and it extends past the analytic start B+599. Indeed p0+4<=B+5 and B+p0>=B+599. Thus the patch does not require a low-range ladder, provided the candidate really has the stated lower threshold. No particular p0 was searched for or evaluated in this task; its small prime proof is an explicit finite obligation, not a final assumption.

The same worker is investigating a distinct corrected Cully-Hugill–Lee interval theorem at H=3e12 for B=2e16. Its reported use includes zero-density, zero-free-region and low-zero-sum inputs in addition to finite RH, and lower-range stitching is still being checked. It must not be priced or stated as an RH-only theorem until those exact dependencies are discharged. Either concrete route would be a genuine uniform replacement of the numerical ladder array if all its analytic and finite spectral obligations are proved.

For an initial comparison at these reported heights, inequality (E) asks whether the **complete added principal and analytic work** is below the complete cost of the old candidate's 181029996372 or 90804183483 ladder windows, respectively. Being one character rather than billions of characters does not answer this: H=9e12 or 3e12 is a much higher principal computation than the small accepted pilot packets. Actual high-height arithmetic and complete zero counting remain the decisive cost inputs.

## Evidence and scalar checks

The companion `finite_rh_binary_coverage_interface_20261111.py` records hashes of the actual small-case and ladder source files, the preceding joint-cost note, and this note's exact integer window counts and endpoint margins. It does not evaluate primes, logarithms, zeros or special functions. Its checks are examples supporting the displayed integer arithmetic; the universal coverage proofs are the arguments above. No primary analytic theorem is imported by that script.
