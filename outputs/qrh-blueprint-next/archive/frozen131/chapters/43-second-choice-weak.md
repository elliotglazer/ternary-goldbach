# A weak second-choice bound from an elementary totient estimate

Research proof, 2026-11-10. No Lean compilation. This note replaces the second-choice uses of the sharp global totient bound, conditional on the other inputs to the existing raw Type I/II estimates. It does not discharge those other inputs. The companion arithmetic diagnostic is `second_choice_weak_totient_check.ps1`.

## Result

Write z=T^3, L=log T, B=2^1000 and S=2^500. Assume the finite exact totient bound for q<=B and the first-choice repair in `TYPEII_TOTIENT.md`.

For the second branch of the pointwise theorem, the existing bound hfun(z) remains available when T<=S. For T>S, the actual raw second-choice terms give the elementary replacement

    |S_eta2(alpha,T^3)|/T^3 <=12000 L^2 T^(-1/4).

Equivalently, a valid bound at all scales is hfun(z) plus this new term restricted to T>S. The coefficient is intentionally loose. It has positive decay and requires no global logarithmic totient bound.

Define the additional layer envelope

    H2(r)=12000 log^2(max(r,S))/max(r,S)^(1/4).

Then the off-larger-arcs convolution is bounded by

    ghat(y,n)+1.398*(H1(n)+H2(n)),

where H1 is the already reviewed downstream GBound envelope in `GLOBAL_TOTIENT_TAIL.md`. H2 contributes less than 1e-24 to the entire normalized layer expression, including the terminal term, uniformly in x>=4.9e26 with the existing r2 choices. Adding the H1 contribution remains below 2e-24. The final minor constant 1.0376 therefore still fits the previously exhibited rational margin.

## Elementary totient input and source parameters

The elementary fourth-power argument in `TYPEII_TOTIENT.md` proves

    v=q/phi(q)<=2q^(1/4).

The new approximation selected by `SecondFinal.theorem_3_1_1_second` satisfies

    q<=Q2(T)=T^2/349,

so v<=2sqrt(T). This uniform bound is the only totient estimate used below.

The other parameters are exactly the source's:

    U=U2(T)=floor(1225T),       V=V2(T)=floor(T/3),
    1224.99T<=U<=1225T,       X=T^3/U<=T^2,
    X>=T^2/1225,              kap1<=.24083<1,
    T>=6e6,                  L>=15.6.

The source symbol zeta3 is **not** zeta(3). It is `1.27*Re(zeta(3/2))^3`, and `FirstChoice.zeta3_le` proves zeta3<=27. All bounds below use that value.

When T<=S, every newly selected q is <=B/349<B. Thus all old second-choice logarithmic totient helper conclusions follow from the finite exact theorem, with their old comparison parameters. The finite theorem has no upper bound on its real comparison parameter r. The first-choice theorem invoked in the bridge also has the separate elementary repair already described.

## Type II, cases a1 and b

The raw source theorems are `TypeIILarge.typeII_638` and `typeII_641`, instantiated in `SecondTypeIIa.typeII_a1` and `SecondTypeIIb.typeII_b`. Each consists of four positive terms M1, M2, M3 and M4.

### M1 in case a1

Here q>T/6 and 16q<=X. The raw term is

    M1=4T^3/sqrt(8phi(q))*sqrt(A*D),
    A=log(X/(16q))+log(2q)*[loglog(X/(2q))-loglog8],
    D=.15107log(X/(16q))+.0231+2zeta3*sqrt(T^3/(16q))/U.

All factors are nonnegative in the source range. Since v<=2sqrt T and q>T/6,

    4T^3/sqrt(8phi(q)) <5T^(11/4).

Use log(X/(16q))<=2L, log(2q)<=3L, and

    loglog(X/(2q))-loglog8 <=log(2L)<=2L.

Then A<=8L^2. Also sqrt(T^3/(16q))<=T and U>=1224.99T, so the zeta3 term is at most54/1224.99<.05. Consequently D<=5L, with considerable slack. It follows that

    M1<=5sqrt(40)L^(3/2)T^(11/4) <40L^2T^(11/4).

### M1 in case b

Put d=|delta|q and c=d(1+epsilon)/4, where epsilon=T^3/(2UQ2). The source proves

    4T/3<d<=349T,     0<=epsilon<=.142451,
    1<=c<=99.68T,    8d/c>28.

The raw term is

    M1=4T^3*sqrt(v/d)*sqrt(A*D),
    A=log(X/(8d))+log(c)*[loglog(X/c)-loglog(8d/c)],
    D=.15107log(X/(8d))+.0231+2zeta3*sqrt(T^3/(8d))/U.

Here X/(8d)>=T/(1225*2792)>1, so all relevant factors are nonnegative. The prefactor is less than5T^(11/4). The bounds c<=T^2, X<=T^2, and 8d/c>28 give A<=6L^2<=8L^2. The same zeta3 argument gives D<=5L. Thus the same upper bound M1<=40L^2T^(11/4) holds.

### M2 in both cases

The exact common form is

    M2=4sqrt(kap1*v*T^3/2)*
       [2sqrt(X)+sqrt(log c)*(2e sqrt(c)+4sqrt(X/log(X/c)))],

with c=2q in case a1 and c=d(1+epsilon)/4 in case b. In either case

    c<=T^2,  1<=c,  log c<=2L,  log(X/c)>=1.

For a1, X/c>=8. For b, X/c>=T/(1225*99.68)>49. The prefactor is at most4T^(7/4). Since e<3, the bracket is at most

    2T+2sqrt(L)*(6T+4T)<=22T sqrt(L).

Therefore M2<=88L^2T^(11/4).

### M3 and M4

The source lemmas `a1_M3_le`, `b_M3_le`, and `a1_M4_le` do not use any totient bound. Their displayed right sides may be retained. Directly bounding those expressions for L>=15.6 gives

    a1_M3 <=40L^(3/2)T^(5/2),
    b_M3  <=32L^(3/2)T^(5/2),
    M4    <=32T^(5/2).

For reproducibility, the a1 expression inside its outer factor `4*.49075<2` is bounded by

    12sqrt(L)+2L^(3/2)+4sqrt(L)+2sqrt(L)<=20L^(3/2).

For b, the corresponding bound is `8sqrt(L)+2L^(3/2)+4sqrt(L)+2sqrt(L)<=16L^(3/2)`. Use sqrt(L+a)<=2sqrt L for the listed a<=2.3672, sqrt(2L-b)<=2sqrt L, and 1/sqrt(L-1.0986)<=1. M4 is bounded using its exact coefficient `8*1.4262*1.73207*sqrt(.24083*.50001)<32`.

Thus M3+M4<=72L^2T^(5/2). Adding all four terms gives

    |S_II|<=200L^2T^(11/4).

### Case a2

`SecondTypeIIb.typeII_a2` comes from `typeII_639`, whose displayed bound has no phi factor. Its proof does not call any of the logarithmic totient helpers. Retain its bound `1.413L^(3/2)T^(5/2)`, which is also below200L^2T^(11/4).

## Type I and assembly, cases a and b

Only one estimate in `SecondTypeI1.typeI1_second` needs changing: its bracket hbr. Its actual form is

    (2q/phi(2q)+2.67)+log(X)*muBound(U,q).

The source already proves `2q/phi(2q)<=2v`, `muBound<=1` and log X<=2L. Hence hbr<=4sqrt T+2.67+2L. Its multiplier is at most3T^2 by `xq_delta0_le` and `minInv_le_delta0`.

Retain the source's other three terms:

    tB<=1.8414T^2,
    tC<=.001L T^2,
    tD<=(.0407L^2+.1417L+.0155)T^2.

This gives

    |S_I1|<=12T^(5/2)+(.0407L^2+6.1427L+9.8669)T^2.

The proof of `SecondTypeI2.typeI2_second` uses `b450_second`, `b451_second` and `b452_second`, not the logarithmic totient helper. Its existing bound remains

    |S_I2|<=(.031L^2+3185.8L+8455.3)T^2.

The exact assembly in `SecondFinal` adds at most9L. Combining the preceding bounds and dividing by T^3 gives

    |S_eta2|/T^3
      <=200L^2T^(-1/4)+12T^(-1/2)
        +(.0717L^2+3191.9427L+8465.1669)T^(-1)+9LT^(-3)
      <=11878.1813L^2T^(-1/4)
      <12000L^2T^(-1/4).

The second inequality uses only L>=1 and T>=1. This proves the stated weak bound in cases a and b without preserving the old second-branch constants.

## Bridge case c

Use the repaired first-choice theorem. The source proves that its t=delta0*q satisfies

    T/3.0001<=t<=T/3.

Use v<=2sqrt T, R(T^3,t)<=log t<=L and its actual four terms. Their normalized bounds are respectively

    6L^2T^(-1/4),
    5T^(-1/2),
    441L T^(-1/2),
    4T^(-1/2).

For the third term, `2/t<=6.0002/T` and its bracket is at most

    2sqrt T*(3.25L+7.82)+13.66L+37.55
      <=73.35sqrt T*L.

Their sum is at most456L^2T^(-1/4), safely below the chosen coefficient12000. This avoids `SecondBridge.div_totient_le_loglog` entirely at large T.

## From the weak bound to H2 in the convolution

The function E(T)=12000(log T)^2T^(-1/4) decreases for T>=S, since log S>8. At a scale z=wy in the source convolution, set m=min(1,w)n. The existing level hypothesis n<=y^(1/3)/6 implies

    m<=(wy)^(1/3)/6=T/6.

If T<=S, use the old second branch proved with the finite totient theorem. If T>S, then max(S,m)<=T, so

    E(T)<=E(max(S,m))=H2(m).

It is therefore enough to use hfun(wy)+H2(m) in all cases. H2 is nonincreasing, continuous at S, and rH2(r) is increasing. Exactly as for H1,

    H2(min(1,w)n)<=H2(n)*max(1,1/w).

Combine the two cases of the pointwise proof by

    max(g(y,n)+H1(n),hfun(y)+H2(n))
      <=max(g(y,n),hfun(y))+H1(n)+H2(n).

The existing Gaussian integral and small-w treatment then add at most1.398(H1(n)+H2(n)) to ghat. No interval of w and no large-w tail is omitted.

## Explicit full layer cost

Use the same exact difference formula and the generous bounds sig<=log x, sig/Dx<=3, cL(150000)<15 established in `GLOBAL_TOTIENT_TAIL.md`. Write Ls=log S. Here the envelope has no factor2 inside the logarithm, so its terminal constant must be adjusted.

For the source's large-x witness m=floor(y^(1/4)),

    log x<4+4log(2m)<8+4log m.

The function H2(m)*(8+4log m) decreases for m>=S. For m<=S it is at most H2(S)*(8+4Ls). The finite cells satisfy the same bound since log x<235<8+4Ls. Thus the complete H2 addition is at most

    1.398*12000*S^(-1/4)*
      [7Ls^3+65Ls^2+96Ls+384].

The coefficient65 is 45 from the base term, 12 from the integral tail, and8 from the terminal constant. Since Ls=500log2<350 and S^(-1/4)=2^(-125), this is less than

    16800*2^(-125)*308121484 <1e-24.

The exact integer comparison is included in the companion script. The floating diagnostic is about1.217e-25. Adding the reviewed H1 cost below1e-60 remains below2e-24, which is much less than the 1e-6 allowance already checked against the final1.0376 inequality.

## Scope and remaining work

The argument supplies an explicit paper route for all the second-choice pointwise totient uses listed in `TYPEII_TOTIENT.md`, together with a complete small error allowance in the downstream layer calculation. Its transfer lemmas and source estimates require independent review and Lean proofs. Other prime and Mobius inputs to the raw Type I/II statements remain separate obligations.

An exhaustive source search also found `LSQuot3.lean:121`, which applies the global totient theorem to a product of primes in the large-sieve quotient proof. That is outside the pointwise Type I/II branch treated here. Neither this result nor the H1/H2 layer estimate removes that additional upstream large-sieve dependency.
