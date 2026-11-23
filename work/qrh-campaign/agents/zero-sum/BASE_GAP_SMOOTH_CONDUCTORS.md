# Base-gap smooth denominators: exact conductor weights

Research only; no Lean compilation or source implementation. Target source: `work/ternary-goldbach`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Files accompanying this note are `base_gap_smooth_conductors.py`, its JSON and CSV outputs, and `smooth_conductor_certificates.py` with its JSON output. Integer factorization, primitive counts and parity counts are exact. Radical enclosures are rational and exact. Logarithmic mass totals, transform evaluations and budget decimals are diagnostics unless an explicit rational certificate is stated.

## 1. Resolve q versus Q first

The direct eta2 branch approximates 2*alpha and uses Q=q/gcd(q,2). Character reconstruction approximates alpha and uses the original q. The difficult rows in `agents/mellin/BASE_GAP_HYBRID.md` are direct denominators Q=90090 and120120. Both Q are even, so their corresponding original moduli are necessarily q=180180 and240240. They are the primary rows below.

For completeness, we also enumerate original q=90090 and120120, which instead correspond to Q=45045 and60060. These are different gap cells.

| original q | direct Q | factorization of q | phi(q) | delta_min | delta_max, excluded |
|---:|---:|---|---:|---:|---:|
| 90090 | 45045 | 2*3^2*5*7*11*13 | 17280 | .27183701 | 13.32001332 |
| 120120 | 60060 | 2^3*3*5*7*11*13 | 23040 | .20387775 | 9.99000999 |
| 180180 | 90090 | 2^2*3^2*5*7*11*13 | 34560 | .13591850 | 6.66000666 |
| 240240 | 120120 | 2^4*3*5*7*11*13 | 46080 | .10193888 | 4.995004995 |

The exact endpoints are 600000/(49Q) and600000/Q. All four q are nonsquarefree, so the principal Gauss sum is exactly zero. The Fourier main term therefore vanishes in the exact reconstruction. The generic .000481 main-term allowance is not needed for these rows. The noncoprime prime-power remainder still remains.

## 2. Exact arithmetic interface

For c dividing q the squared Gauss norm is

    |tau_q(psi)|^2 = c if q/c is squarefree and gcd(q/c,c)=1,
                    0 otherwise,

where psi is induced from a primitive character of conductor c. This is `MinorArcs/Bombieri.norm_sq_gaussSum` at line137. Each primitive character induces exactly one character modulo q. Inversion preserves the conductor and parity, so the source psi^-1 convention changes none of these counts.

Let N(c) count primitive characters modulo c. Its local factors are

    N(p)=p-2,
    N(p^a)=p^(a-2)*(p-1)^2 for a>=2,
    N(1)=1.

They follow by subtracting the characters induced from smaller prime-power levels. The total is multiplicative. The even-minus-odd count is

    Delta(c)=mu(c)+1_(2 divides c)*mu(c/2),
    N_even(c)=(N(c)+Delta(c))/2,
    N_odd(c) =(N(c)-Delta(c))/2.

These are finite character-count identities, not an assumption of a conductor-dependent analytic saving. For each of the admissible conductors in the four rows Delta(c)=0, so even and odd primitive counts are exactly equal, conductor by conductor.

An exponent a>=2 in q forces the full p^a into c: omitting even one p would either leave a nonsquarefree quotient or make the quotient share a prime with c. At exponent1, c may include or omit p. The formal option c divisible by2 to exponent1 has N(2)=0 and contributes nothing.

Consequently the admissible positive-weight families are exactly:

    q=90090:  c=9*d,   d divides5005;
    q=120120: c=8*d,   d divides15015;
    q=180180: c=36*d,  d divides5005;
    q=240240: c=16*d,  d divides15015.

This leaves16,32,16,32 conductors, respectively. No principal or conductor-one zeta contribution survives.

Define the precise amplification for a common primitive-character error by

    W(q)=sum_(admissible c) sqrt(c)*N(c)/phi(q).

It has the exact local product formula

    W(q)= product_(p^a || q, a=1) [1+(p-2)sqrt(p)]/(p-1)
          * product_(p^a || q, a>=2) [(p-1)*p^(a/2-1)].

For p=2,a=1 the first factor is1. This is the arithmetic replacement for sqrt(q); there is no new 1/sqrt(c) in the primitive analytic estimate.

## 3. Quantitative saving, including parity

| q | positive-weight characters | even | odd | W(q) | W(q)/sqrt(q) |
|---:|---:|---:|---:|---:|---:|
| 90090 | 11520 | 5760 | 5760 | 95.54022391 | .31830830 |
| 120120 | 11520 | 5760 | 5760 | 92.28476973 | .26627008 |
| 180180 | 11520 | 5760 | 5760 | 95.54022391 | .22507796 |
| 240240 | 23040 | 11520 | 11520 | 130.51037295 | .26627008 |

Thus the saving is real and substantial: a factor of roughly3.1 to4.4 over the source sqrt(q) bound. It is not an asymptotic cancellation hypothesis. The script encloses each sqrt(c) between floor(sqrt(c*10^12))/10^6 and the next rational, sums with exact weights, and records exact rational lower and upper bounds for W.

A consistency check passes exactly for every row:

    sum_(admissible c) c*N(c)=phi(q)^2.

This is the finite Gauss-square identity. It catches a missing induction multiplicity or a spurious nonzero Gauss weight.

The same W for q90090 and180180 is also exact. Their admissible conductors are related by c->4c; the square root doubles, while phi(q) doubles, and N(4)=1. This relation does not identify the characters or their L-functions. Their logarithmic masses increase because the conductors increase.

## 4. Weight remains concentrated in the largest conductor families

For the primary row q=180180, Q=90090:

| c | primitive characters | even / odd | fraction of W |
|---:|---:|---:|---:|
| 180180 | 5940 | 2970 / 2970 | .76362431 |
| 36036 | 1980 | 990 / 990 | .11383439 |
| 25740 | 1188 | 594 / 594 | .05772457 |
| 16380 | 660 | 330 / 330 | .02558238 |
| 13860 | 540 | 270 / 270 | .01925375 |

All conductors<=10000 together carry only1.9981% of W and about1.3775% of the prescribed mass total. All conductors<=100000 still carry only23.6376% of W: the remaining76.3624% is at c180180 itself.

For q=240240, Q=120120:

| c | primitive characters | even / odd | fraction of W |
|---:|---:|---:|---:|
| 240240 | 5940 | 2970 / 2970 | .48411842 |
| 80080 | 5940 | 2970 / 2970 | .27950590 |
| 48048 | 1980 | 990 / 990 | .07216811 |
| 16016 | 1980 | 990 / 990 | .04167055 |
| 34320 | 1188 | 594 / 594 | .03659591 |

Conductors<=10000 carry3.6392% of W; those<=50000 carry23.6376%. The two largest families carry76.3624%, with11880 primitive characters between them. A certificate restricted to small conductors cannot address most of this weighted error.

The CSV contains all96 conductor rows, including the two alternative original-modulus interpretations. No radical or parity contribution has been dropped.

## 5. What this means for the existing mass/kernel approach

Use the prospective mass caps from `WEIGHTED_ZERO_MOMENTS.md`:

    M_even(c)<=.5log(c)-.29,
    M_odd(c) <=.5log(c)+.017.

Their completed-log-derivative identities and scalar constants still need the proofs described there. Grant them here to assess their numerical strength. Since the parity counts balance, define the prescribed arithmetic mass total

    B(q)=sum_(admissible c) sqrt(c)*N(c)/phi(q) * [.5log(c)-.1365].

If an actual uniform pointwise kernel-to-mass inequality Z_chi(delta)<=K*M_chi is proved, the zero contribution would be at most y^(-1/8)*K*B(q). This formula is conditional on that analytic inequality; computing B does not prove it.

| q | B(q), diagnostic | y0^(-1/8)B(q), y0=1e25 | K ceiling from uniform .04712 | K ceiling from endpoint .0598 |
|---:|---:|---:|---:|---:|
| 90090 | 475.6017721 | .35665101 | .13212 | .16767 |
| 120120 | 486.0990594 | .36452287 | .12926 | .16405 |
| 180180 | 541.8252089 | .40631159 | .11597 | .14718 |
| 240240 | 732.6793310 | .54943199 | .08576 | .10884 |

The budget ceilings omit the small removal/contour costs and therefore are optimistic. The .04712 and .0598 are the separate paper lower allowances for the actual ghatY envelope communicated by the constants worker; they are not asserted newly compiled theorems. At the endpoint the source also certifies the upper envelope .060272, which is useful for an obstruction.

For a common direct zero-sum constant Z_chi<=C, the corresponding primary-row C ceilings are .65769/.83467 at q180180 and .48146/.61102 at q240240 (uniform/endpoint). Exact conductor weights therefore improve the earlier demand for constants near.03. They still do not supply a bound for even one typical worst-position zero, much less the whole zero sum.

### A rational test of the common mass-envelope recipe

Both primary rows permit delta=.136. For beta=7/8 the actual etaU transform obeys the following paper lower bound:

    |F(7/8,.136)| > .4.

The certificate uses H(s)=Mellin(etaU)(s)=A(s)G(s), A(s)=4((1-2^(-s))/s)^2, and G(s)=integral u^(s+1)exp(-u^2/2)du. Since (273/500)^8>1/128,

    A(7/8) > 4*((1-273/500)/(7/8))^2.

For G, partition [0,4] into16 intervals of length1/4. On [a,b], bound u^(7/8) below by a rational r_a with r_a^8<=a^7, so the contribution of u^(7/8)*u*exp(-u^2/2) is at least r_a*(exp(-a^2/2)-exp(-b^2/2)). Each exponential is bracketed by the even-degree80 Taylor polynomial and the degree81 polynomial. Taylor's remainder sign for exp(-x), x>=0, justifies these bounds. Everything remaining is rational arithmetic. The resulting lower bound is G>1.0872052915 (the displayed decimal is diagnostic; the calculation retains its exact fraction).

Finally, use H(7/8+2)<=135/64 and cos(v)>=1-v^2/2. This yields the exact rational comparison

    A_lower*G_lower - 2*(22/7)^2*(17/125)^2*(135/64) > 2/5.

The certificate script passes. The analytic integral and moment inequalities remain paper proofs, not Lean theorems.

At a height-zero right-edge zero, the positive mass weight is a=1/(2-7/8)=8/9. Thus a common single-zero kernel-to-mass bound must have K>.45. Even allowing a reflected pair to share its full mass is insufficient: the pair mass is8/9+8/15=64/45, and already its right-edge contribution is>.4, so a phase-independent absolute-pair envelope must have

    K > (2/5)/(64/45)=9/32=.28125.

This argument is for a bound required at every allowed pair. It does not assert that such zeros occur. If one instead bounds the complex sum of the pair with y powers retained, the partner at beta1/8 is suppressed by y^(-3/4); its H(1/8)<=8 bound makes this less than8e-18 at y0. The rational lower-bound margin above.4 exceeds that, so the same conclusion survives that particular pairing convention.

The script also obtains rational lower bounds for the *prescribed* B(q) by sqrt(c)>=floor(sqrt(c)) and log(c)>k whenever (11/4)^k<c, using e<11/4. It finds

    B(180180) > 713853823/1440000,
    B(240240) > 16204184177/23040000.

Using y0^(-1/8)>.00074, the chosen common-pair-envelope recipe must therefore spend more than

    .1031741853  at q180180,
    .1463756871  at q240240.

Both exceed the certified actual ghatY endpoint upper bound .060272. These are lower bounds on the output of this particular common-envelope-plus-prescribed-mass-cap calculation, not lower bounds on the true prime-sum error or on the actual character masses. Character-specific kernels, genuinely smaller masses, zero-location exclusions or cancellation-sensitive estimates can evade this obstruction. The exact conductor distribution by itself does not rescue this common mass-envelope argument.

The two alternative rows q90090 and120120 do not permit delta=.136, so this specific lower-transform test is not asserted for them. Their displayed diagnostic transforms at their own lower endpoints are .9774 and1.1002. Those floats are not used as rigorous obstructions.

## 6. A narrow finite certificate: few conductor families, many characters

A better certificate should preserve the weighted sum, not force every primitive character to meet the worst common threshold. For a set S of selected conductor families, certify the actual quantity

    C_S(delta)=sum_(c in S) sqrt(c)/phi(q)
                    *sum_(chi primitive mod c) Z_chi(delta),

or a cancellation-sensitive replacement justified from exact character reconstruction. Treat c outside S with an independently proved kernel bound. The remaining prescribed mass coefficient is

    R_S=y0^(-1/8)*sum_(c outside S) sqrt(c)N(c)/phi(q)
                                  *[.5log(c)-.1365].

The following are diagnostics of R_S, so if a valid residual kernel constant K_rest is later proved, the residual contribution is at most K_rest*R_S. K_rest=1 is only a benchmark, not an available theorem.

| original q | selected conductors S | primitive characters in S | R_S |
|---:|---|---:|---:|
| 180180 | 180180 | 5940 | .08273771 |
| 180180 | 180180,36036 | 7920 | .04106519 |
| 180180 | 180180,36036,25740 | 9108 | .02062913 |
| 180180 | previous plus16380,13860 | 10308 | .00559711 |
| 240240 | 240240,80080 | 11880 | .11169812 |
| 240240 | previous plus48048,16016 | 15840 | .05540986 |
| 240240 | previous plus34320 | 17028 | .03719654 |
| 240240 | previous plus11440,21840,18480 | 19416 | .01439868 |

Thus there is a narrow conductor-list certificate, but not a cheap certificate involving only a few characters. At q180180 the first three families already cover9108 characters. At q240240 even four families cover15840 characters while leaving appreciable residual cost. Every admissible conductor at q180180 contains9, and every admissible conductor at q240240 contains16. No primitive real character has conductor divisible by9 or16, so these characters come in distinct conjugate pairs. Certification can exploit that symmetry, reducing the number of independent character cases by two, while preserving multiplicities and the reflected-zero convention. It does not turn the list into a small-conductor problem.

A practical first bounded test is c180180 alone, not all96 conductor rows: certify a weighted zero count or actual transform-weighted zero bound on a short height window, for both parities together with conjugation. Then inspect whether the achieved cost plus a proved residual bound has room under the actual ghat budget. This tests the family carrying76.36% of the amplification.

For a prospective finite-height cutoff, |delta|<6.661 in the primary q180180 row and<4.996 in q240240. The Gaussian source tail regime requires T>=max(10*pi*|delta|,50), so T=256 is eligible for both. The etaU identity

    F(s,delta)=integral_(1/4)^1 eta2(r)r^(s-1)G(s,delta*r)dr

preserves that eligibility because r<=1. `Explicit/ZetaBound.norm_G_tail_floor` and the underlying `MellinRotate` bounds are source ingredients. The integral's r weights, multiplicity counts and final tail constant must still be computed; eligibility of T=256 is not a proof that its tail is small enough. It is only a concrete first height to test. A finite certificate need not prove RH equality: a weighted count in beta/gamma cells, with the actual y^(beta-1) and etaU transform retained, would be sufficient if its sum meets the budget.

An even cheaper preliminary computation is the primitive-character averaged Euler series at c180180, before attempting zero isolation. For units n,

    sum_(chi primitive mod c) chi(n)
      =sum_(d divides c, d divides n-1) mu(c/d)*phi(d).

Parity separation uses the same expression at n and -n. This gives an exact finite arithmetic method for family log-derivative means with principal/imprimitive subtraction built in. It can test whether the surviving c180180 family differs enough from the large-prime detector obstruction. Its use as a detector still needs the analytic completed-L identity, and first positive moments may remain too weak. No numerical success is assumed.

## 7. All-y and proof-status conditions

The finite weight arithmetic is independent of y. A phase-uniform bound for Z_chi(delta) on the exact gap interval therefore produces a decreasing y^(-1/8) factor, compatible with checking y0 against a genuinely uniform lower ghat allowance. An endpoint calculation of oscillatory y^(i*gamma) is not uniform in y. Any certificate retaining those phases must instead prove a uniform operator bound or a separate variable-y estimate.

All-zero sums require actual convergence and height-tail estimates. The source's noncoprime removal remains, with cost at most(1+W(q))*d when primitive sums are used. At these moduli the principal Fourier term vanishes, but removed prime powers do not. The prescribed mass caps remain analytic proof obligations, even though granting them is insufficient for the common-envelope recipe tested above.

Completed work is the exact conductor/parity enumeration, exact radical enclosures and identity checks, quantified amplification saving, rigorous rational checks for the selected common-envelope obstruction, and a ranked finite-family certificate plan. No base-gap theorem, new zero-distribution estimate or Lean proof has been completed.
