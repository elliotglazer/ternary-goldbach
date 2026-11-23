# Independent review of the family-detector test

Reviewed `../zero-sum/FAMILY_DETECTOR_TEST.md` and its accompanying script against the mathematics and the pinned Goldbach source. No Lean compiler ran and no proof source changed.

The claimed obstruction is valid for the stated positive, pointwise, absolute-majorant recipe with one detector combination shared across the family, or separate combinations shared within each parity. I found no factor-of-two error in the family average, parity counts, reflected-pair detector, or Gauss normalization. The exact lower certificate is

```text
255834649 / 3749800000 = 0.06822621179796255...
> 0.068 > 0.060272.
```

Two scope clarifications should accompany the result. The reflection within one character uses the functional equation together with conjugation, rather than the functional equation alone. Also, a lower bound for a family mean does not by itself cover arbitrary character-dependent detector coefficients. Those would require weighted family information.

## Exact parity and principal subtraction

Let p=149993. Independent trial division through floor(sqrt(p)) confirms it is prime. There are p-1 characters, half of each parity. The even principal character is the only imprimitive character, so

```text
n_e=(p-3)/2=74995, n_o=(p-1)/2=74996, N=p-2=149991.
```

For a unit n mod p, orthogonality gives

```text
sum_all chi(n) = (p-1)*1[n=1],
sum_even chi(n) = (p-1)/2*(1[n=1]+1[n=-1]),
sum_odd chi(n) = (p-1)/2*(1[n=1]-1[n=-1]).
```

Removing the principal character subtracts 1 on every unit n from the all-character and even sums. It makes no change to the odd sum. Multiplying by the minus sign in

`L'/L(z,chi)=-sum_n Lambda(n)*chi(n)*n^(-z)`

therefore gives exactly the three formulas in the note:

```text
sum_primitive L'/L = B-(p-1)C+,
sum_even_primitive L'/L = B-(p-1)(C++C-)/2,
sum_odd_primitive L'/L = -(p-1)(C+-C-)/2.
```

B must exclude multiples of p. This is the Euler series of the principal character modulo p, not the full zeta series. After dividing the odd identity by n_o, its Euler term is exactly `-(C+-C-)`; the displayed odd mean has no missing divisor.

Writing the completed function as

`Lambda_chi(z)=(p/pi)^((z+a)/2)*Gamma((z+a)/2)*L(z,chi)`

shows that its logarithmic derivative is

`.5*log(p/pi)+.5*digamma((z+a)/2)+L'/L(z,chi)`.

Thus both parity gamma terms and the weighted mean `(n_e*M_e+n_o*M_o)/N` are correct. The completed functions in this family have no principal pole.

## Positive-zero identity and reflection

The identity

`Re(Lambda_chi'/Lambda_chi)(sigma+it) = sum_rho m_rho*(sigma-beta)/((sigma-beta)^2+(t-gamma)^2)`

has the stated normalization. Here the sum is over all nontrivial zeros of that character, with multiplicity, not one representative from each reflection orbit.

One way to see the absence of an extra constant is to begin with the order-one Hadamard product. Its real logarithmic derivative is a real constant plus the displayed kernel sum. The functional equation combined with conjugation gives

`Lambda_chi(s)=epsilon_chi*overline(Lambda_chi(1-overline(s)))`.

It follows that zeros within this character are paired as `rho ↔ 1-overline(rho)`, with equal multiplicity. At a nonzero point on the critical line the logarithmic derivative is purely imaginary, and the real kernel sum cancels pairwise. This forces the real constant to vanish. Standard zero counting gives absolute convergence of the real kernel sum for sigma>1. The Hadamard representation, convergence, nonvanishing at the evaluation point, and zero correspondence remain analytic formalization obligations.

The two operations must be distinguished:

- Functional equation alone sends a zero rho of chi to 1-rho of the conjugate character.
- Conjugation sends rho of chi to overline(rho) of the conjugate character.
- Their composition sends rho to 1-overline(rho) inside chi.

Thus horizontal reflection preserves gamma. It does not assert gamma ↔ -gamma inside a nonreal character. At gamma=0 the within-character orbit is exactly beta and 1-beta. Complex conjugate characters have corresponding real zeros, and both characters are already included in N.

Consequently, at the test pair beta=7/8,1/8 and gamma=0, the detector value is exactly

`W=(sigma-7/8)/((sigma-7/8)^2+t^2)+(sigma-1/8)/((sigma-1/8)^2+t^2)`.

There is no factor 2 to insert. If one instead used an average per zero of the pair, both the detector and its assigned target would have to be divided by 2, leaving the cost ratio unchanged.

## Uniform lower bound for the family means

The proof of `M_e>4` and `M_o>4` for every sigma>=1.02 and real t is sound.

For u>0,

`Re digamma(u+iv)-digamma(u)=sum_{n>=0} v^2/((n+u)*((n+u)^2+v^2)) >=0`.

This follows as well from the standard integral formula by subtracting its value at u. Digamma is increasing on the positive reals, and `digamma(1/2)=-gammaEuler-2log2>-2`. These classical formulas agree with [DLMF 5.9.16](https://dlmf.nist.gov/5.9.E16) and [DLMF 5.4.13](https://dlmf.nist.gov/5.4.E13). Hence the half-digamma contribution is greater than -1 for both parities.

The rational exponential comparison proves `.5log(p/pi)>41/8`. The absolute Euler estimates are uniform in t because the imaginary twist has modulus one. At a=1/50 the displayed even bound evaluates exactly to

`2634241925021/35152265734375 = 0.0749380408343... < 1/8`.

It also dominates the odd bound. For the B estimate, n=2 and n=3 contribute less than 1 each. For n>=4, log(n)/n^(1+a) is decreasing and integral comparison applies. For each progression, its first possibly nonzero term is p-1 or p+1, and the first-term-plus-integral estimate is valid. Therefore `M_a>41/8-1-1/8=4`.

For sigma>=1.02, positivity gives

`W<=1/(1.02-7/8)+1/(1.02-1/8)=41600/5191<8.1`.

For sigma>=9/8, the corresponding bound is W<=5. Both are uniform over all t; no sampled-grid inference is used.

## Actual etaU transform and the test target

The source etaU is the unscaled convolution from `MinorArcs/EtaU.lean:24`. Its Mellin transform factors as

`H(s)=A(s)*2^(s/2)*Gamma(1+s/2)`, with `A(s)=4*((1-2^(-s))/s)^2`.

At beta=7/8, A(beta)>=1 follows from eta2>=0, support [1/4,1], and integral 1. The Gaussian integrand is u^(15/8)*exp(-u^2/2). Its integral on (0,1) exceeds .6/3 and that on (1,infinity) exceeds .6, so H(beta)>.8.

For beta+2, A(beta+2)<=A(2)=9/16. Weighted AM-GM bounds the Gaussian integrand u^3*u^(7/8) by u^3/8+7u^4/8. The two Gaussian moments are 2 and 3*sqrt(pi/2)<4. Hence H(beta+2)<=135/64. The cosine bound therefore proves

`Re F(7/8,.082)>10188173/19600000 = .519804744897959... > .51`.

These calculations use the actual smoothing and its actual twist delta=.082. No factor 49 belongs inside this F. It has already entered y=x/49.

The note's necessary condition `sum lambda_j*W_j >=.51` is valid for a pointwise majorant of the sum of absolute zero contributions. If “absolute pair contribution” means the norm after first adding the two reflected terms, the same lower threshold still follows here, but an extra sentence is appropriate. The left-edge term is attenuated by y^(-3/4). An elementary bound is H(1/8)<=8: A(1/8)<=4 from the support, while weighted AM-GM gives u^(1/8)<=7/8+u/8, so the Gaussian factor is at most 7/8+sqrt(pi/2)/8<2. Since y=10^25, the left-edge contribution is less than 8*10^(-18). Subtracting this from .5198047 still leaves more than .51. Thus pair cancellation at this particular gamma=0 test point does not create a factor or threshold problem.

The test pair is a condition on what the universal majorant must cover. It is not claimed to be an actual zero pair. Additional zero-location information excluding it falls outside the obstruction as stated.

## Gauss normalization and comparison with the source

For prime p every nonprincipal character is primitive and has Gauss magnitude sqrt(p). The character expansion has divisor phi(p)=p-1. Summing the N per-character majorant costs and dividing the exponential sum by y gives exactly

`Fp=y^(-1/8)*N*sqrt(p)/(p-1)`.

There is no second parity factor. Separate parity combinations yield the weighted sum n_e*cost_e+n_o*cost_o; since each cost has the same lower bound, they give the same obstruction.

Using the independent rational lower certificate

`Fp > (7/10000)*387*(149991/149992) =406325619/1499920000`

gives

`Fp*(4/8.1)*.51 >255834649/3749800000>.068`.

The difference from .060272 is exactly bounded below by

`149133517/18749000000=.00795421179796...`.

The source comparison is the correct one. `MinorArcs/NumericsCells.lean:10 c0_g0` states `ghatY(1e25,150000)<=.060272`. Thus the recipe's unavoidable positive allowance already exceeds an upper bound on the actual source target. Adding its other nonnegative allowances cannot close this gap. This proves no lower bound on the true exponential-sum error.

The chosen cell is compatible with the relevant odd-q gap geometry: `600000/(49*p)<.082<600000/p`. At y=1e25 this corresponds to x=4.9e26, the exact threshold, not a different scale.

## Review conclusion and limits

The paper obstruction passes this independent mathematical review for finite nonnegative detector combinations shared across all primitive characters, or shared separately within parity. The exact rational inequalities were independently recomputed without running the author's sieve or floating digamma calculation. The diagnostic decimal table is not needed.

For clarity, the note should explicitly retain these restrictions when saying “all nonnegative combinations.” Character-dependent coefficients, signed combinations with a nonnegative total kernel, extra zero constraints, and cancellation across characters are not excluded. No claim is made about centers 1<sigma<1.02 or about impossibility of QRH-based proofs.

No numerical correction is required. The completed-log-derivative identity and its Lean instantiation remain uncompiled analytic work, and the obstruction remains a result about the specified method.

