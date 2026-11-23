# Independent scalar energy inequalities

All six proposed inequalities hold. The following argument uses elementary calculus and rational comparisons. It requires no numerical quadrature, zero-location assumption, or sampled maximum. It has not been compiled in Lean.

Let beta lie in [0,7/8], k=beta+2, a=2-beta=4-k, t=exp(2u)>0 and r=k/2. Then

    2<=k<=23/8, 1<=r<=23/16<3/2,
    E=t^r exp(-t),
    E'=(k-2t)E,
    E''=((k-2t)^2-4t)E,
    a^2 E-E''=Q(t)E,
    Q(t)=16-8k+(4k+4)t-4t^2.

Primes denote differentiation in u. The constant term in Q lies in [-7,0], while 4k+4<=31/2.

## Four moment bounds

For all t>0 and all the allowed r,

    E<=1/2, tE<=1, t^2 E<=3, t^3 E<=12.

If t<=1, t^(r+j)exp(-t)<=t exp(-t)<=1/e<1/2, which proves all four bounds. If t>=1, t^(r+j)exp(-t)<=t^(j+3/2)exp(-t). Elementary differentiation shows that t^s exp(-t) has maximum s^s exp(-s), for s>0. To verify the four claimed maxima, square the comparison and use e>8/3. The latter follows from the exponential series through degree3, with its positive tail. The required rational inequalities are

    (3/2)^3 < (1/2)^2*(8/3)^3,
    (5/2)^5 < (8/3)^5,
    (7/2)^7 < 9*(8/3)^7,
    (9/2)^9 < 144*(8/3)^9.

Clearing positive denominators verifies each inequality with integers. Thus the moment estimates are uniform in beta and u.

## Unweighted derivatives

When k-2t>=0, |E'|<=(23/8)E<=23/16<2. When k-2t<0, |E'|<=2tE<=2.

When Q>=0, QE<=(31/2)tE<=31/2. When Q<0, -QE<=(7+4t^2)E<=7/2+12=31/2. Hence

    E<=1/2,
    |E'|<=2,
    |a^2E-E''|<=31/2=15.5.

## Log-weighted bounds

For t>=1, u=(log t)/2 and log t<=t. The moment bounds imply

    |u|E<=tE/2<=1/2,
    |uE'|<=((23/8)tE+2t^2E)/2<=71/16,
    |u Q E|<=max((31/4)t^2E, (7/2)tE+2t^3E)
             <=max(93/4,55/2)=55/2.

For 0<t<=1, elementary calculus gives (-log t)t^r<=1/(e*r)<=1/e. Also |k-2t|<=k<=23/8. Since Q<=15.5t<=15.5 and -Q<=7+4t^2<=11, |Q|<=15.5. Dropping exp(-t)<=1 now gives

    |u|E<=1/(2e)<1/2,
    |uE'|<=23/(16e)<71/16,
    |u Q E|<=31/(4e)<55/2.

Together these prove the stronger uniform estimates

    |u|E<=1/2,
    |uE'|<=71/16=4.4375,
    |u(a^2E-E'')|<=55/2=27.5.

They imply the proposed bounds1,7,58 with substantial slack. The identity for Q and the derivative variable u should be retained explicitly when inserting these estimates into the Mellin integration-by-parts argument. This review establishes these scalar inequalities only; it does not validate the remaining transform argument or its proposed constants172 and566.
