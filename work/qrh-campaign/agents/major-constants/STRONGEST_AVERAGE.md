# Strongest available average and the missing analytic estimates

This is a source-level audit and a mathematical derivation. No Lean compilation or new analytic theorem is claimed. Source pins are those recorded in AVERAGING.md. All numerical high-conductor maxima below are reproducible floating-point diagnostics, not certified rational maxima.

## What the source actually supplies

The strongest directly usable fully explicit character-average theorem found is the implemented

    LeanLab.PNTPort.LargeSieve.multiplicative_large_sieve

in comparison entries/bombierivinogradov1965/LeanLab/PNTPort/LargeSieve/Multiplicative.lean:246. For a common coefficient sequence a on M<n<=M+N it states

    sum_(c<=Q) c/phi(c) * sum_(chi primitive mod c) |sum a_n chi(n)|^2
      <= (N+2Q^2) * sum |a_n|^2.

Its proof is present and its statement has no Platt or prime-distribution hypothesis. This audit has read the proof but has not independently compiled or printed axioms for it. Multiplying the coefficients by exp(2*pi*i*delta*n/x) preserves the right side, so the result is uniform in each fixed delta. This is genuinely useful for the present second moment.

Bilinear.lean:56 controls the square of a weighted sum of ABSOLUTE VALUES of same-character products, using a factorized coefficient a_m*b_n*chi(mn). It is not a fourth moment over two independent characters at each modulus. Inserting exp(2*pi*i*delta*m*n/x) breaks the simple coefficient factorization. The implemented BV results improve arithmetic cancellation asymptotically but export existential constants and/or thresholds, as detailed in AVERAGING.md. No usable explicit hybrid fourth-moment or zero-density theorem was found in the scoped PNTPort search.

The pinned ternary Bombieri.lean supplies exact Parseval identities and exact imprimitive Gauss weights, not a prime-cancellation estimate. They are the correct algebraic bridge to the comparison large sieve.

## A precise high-conductor corollary, with a proof path

This is an ordinary weighted corollary of the displayed source theorem, not a new number-theoretic assumption. Let Q=150000, D>=3, and let a be a finitely supported common coefficient sequence on an integer interval of length N. Define

    S_chi(delta)=sum_n a_n chi(n) exp(2*pi*i*delta*n/x).

For odd squarefree c set

    K_D=max_(D<=c<=Q, odd squarefree)
         2*phi(c)*sum_(r<=Q, odd squarefree, c|r) 1/phi(r)^3.

If the index set is empty take K_D=0. Put I_D=min(381.22,1200000*1.2534^2/D). Then the primitive-error contribution from conductor>=D to the idealized coprime Aplus satisfies

    Aplus_(c>=D) <= K_D * I_D * L,
    L=(N+2Q^2)/x^2 * sum_n |a_n|^2.

Here the idealized expression uses the induced primitive sums S_chi, prior to adding the separately controlled q-dependent removed prime powers. No principal subtraction is needed because c>=D>=3.

Proof steps:
1. Restrict Aplus to squarefree q and pair q=r,2r. Preserve Gauss weight c exactly once, giving coefficient2c/phi(r)^3 for every primitive chi mod c dividing r.
2. Every delta interval has radius600000/r<=600000/D. Extend each to that common interval by nonnegativity.
3. Regroup by primitive c. The coefficient of each |S_chi|^2 is at most K_D*c/phi(c), by the definition of K_D.
4. Apply multiplicative_large_sieve to a_n*exp(2*pi*i*delta*n/x). All additional primitive conductors in the source sum are harmless nonnegative terms.
5. Integrate the Fourier weight. MajorTotal.lean:469,475 gives its integral<=I_D. Divide by x^2.

This reduces the high-conductor task to a finite rational maximum and a concrete coefficient-energy bound. It does not replace either with an assumption wrapper. A Lean helper expressing steps1-5 would have only the ordinary support/interval/positivity inputs and use the existing theorem as proof.

high_conductor_sieve_model.py evaluates the finite coefficients. At D=100000 it finds K_D*I_D approximately2.11321071152e-8, so the whole old Aplus budget would permit L about46.05. At D=140000 the coefficient is7.80220355095e-9, permitting L about124.72. Benchmark L=40 gives Aplus<=8.45284e-7 at D=100000; L=100 gives7.80220e-7 at D=140000. These consume most of the budget and leave the small-conductor part outstanding. They are not estimates of the actual smoothed prime energy.

For the actual unbounded smoothing, partition the integers into finite intervals I_j of lengths N_j and apply Minkowski in the Hilbert space indexed by delta and primitive characters. The corresponding concrete energy expression is

    L_blocks = [sum_j sqrt((N_j+2Q^2) * sum_(n in I_j) Lambda(n)^2 etaPlus(n/x)^2)/x]^2.

A proof of convergence plus a numerical upper bound for L_blocks, including tails, would make the high-conductor corollary applicable. The smooth integral norm integral etaPlus^2<=.640208 alone is NOT such a prime coefficient bound. MinorArcs/EBound.lean bounds removed small-prime/prime-power energy, and its global E_partial theorem at:173 currently explicitly assumes PlattGRH. It does not supply the required full prime energy in unbounded smoothing. Source Chebyshev and Gaussian bounds may support a new coarse block estimate; that work has not been completed here.

Also, raw prime energy grows approximately log(x). A fixed numerical high-conductor bound derived this way at x=4.9e26 is not automatically uniform for all larger x. A completed proof would combine a bounded-x energy argument with an eventual decaying QRH estimate, or otherwise retain the x-dependence explicitly.

## Exact remaining low-conductor and mixed-moment theorem

Write cP(x)(n)=Lambda(n)*etaPlus(n/x) and cStar(x)(n)=Lambda(n)*etaStar(n/x)=Lambda(n)*etaU(n/y). Use the actual coprime-supported residuals

    e_(q,psi,+)(delta)=Schar(psi^-1,coprimePart(q,cP(x)),delta/x)/x
                      -1_(psi=1)*P(delta),
    e_(q,psi,*)(delta)=Schar(psi^-1,coprimePart(q,cStar(x)),delta/x)/y
                      -1_(psi=1)*U(delta),  y=x/49.

The etaStar main transform U is evaluated at -delta/49. Put w_(q,psi)=|tau_q(psi)|^2, retaining the source's exact conductor/squarefree/coprimality indicator, and

    Eplus(q,delta)=1/phi(q)*sum_psi w_(q,psi)*|e_(q,psi,+)(delta)|^2,
    Estar(q,delta)=1/phi(q)*sum_psi w_(q,psi)*|e_(q,psi,*)(delta)|^2.

For the reviewed J<=10 transfer, the concrete analytic claims still needed at every x>=4.9e26 are

    sum_q integral_|delta|<=Dq |mu(q)/phi(q)*U(delta)|^2 Eplus(q,delta)
       <=9e-7,

    sum_q integral_|delta|<=Dq [|mu(q)/phi(q)*P(delta)|^2 Estar(q,delta)
                              +Eplus(q,delta)*Estar(q,delta)]
       <=1.65e-6.

They imply the full-S caps through the already derived removal transfer. These formulas identify the missing prime-sum estimates; they have NOT been introduced as axioms, typeclasses, or substitute Goldbach theorems. Their actual proof would need the low-conductor spectral calculation plus high-conductor mean estimates.

The product term is a mixed fourth moment:

    sum_q 1/phi(q)^2 * integral sum_(psi,xi)
       w_(q,psi)*w_(q,xi)*|e_(q,psi,+)|^2*|e_(q,xi,*)|^2.

Unlike Aplus, this includes nonsquarefree q and therefore primitive even conductors as well. A second-moment theorem cannot control it without a fourth-moment, correlation, or pointwise input: even scalar functions f_n=g_n=sqrt(n)*1_[0,1/n] have fixed L2 norms but integral|f_n|^2|g_n|^2=n. Thus the existing large sieve is structurally insufficient for Cross by itself.

One precise alternative is a pointwise Estar bound plus a proved unweighted Eplus integral. For example, the proposed J route Ep<=1e-4,N<=.23 also gives integral Eplus<=.2301. To spend at most8e-7 on Cross would then suffice to prove Estar(q,delta)<=8e-7/.2301 everywhere; the remaining8.5e-7 could be reserved for Astar. This is only an alternative target, not an achieved estimate, and it may be harder than a direct mixed moment. No source theorem presently proves it without the old Platt-based major-arc estimates.

The genuine missing result is therefore not merely an algebraic rewrite: it is an explicit low-conductor twisted prime estimate and an explicit mixed fourth-moment/pointwise-star estimate at this x scale. The existing comparison large sieve can address part of the high-conductor SECOND moment, but cannot close the whole averaged cubic argument alone.

