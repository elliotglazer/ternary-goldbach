# Primary-source audit of the proposed Turing bound

2026-11-11. The proposed bound is a published mathematical target with the correct conductor, height and argument normalization for the family plan. Its final rounding is independently checked below. The analytic producer remains unproved in the campaign. This is not an implemented Turing checker or an audit of a historical GRH computation.

The original article was read through a full-text OCR reproduction. A readable original page image was not obtained. In particular, the direction of one endpoint-limit arrow remains a documentary gap. That gap does not affect the intended integral consumer, for the reason given below. No Lean build, dependency installation, production run or frozen-file edit occurred.

Reviewed consumer: `zero-sum/FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF`.

## Original theorem and access limitation

[Rumely, Numerical computations concerning the ERH, Math. Comp. 61 (1993), 415–440](https://www.ams.org/journals/mcom/1993-61-203/S0025-5718-1993-1195435-0/S0025-5718-1993-1195435-0.pdf), DOI 10.1090/S0025-5718-1993-1195435-0, is the original source. Its [full-text reproduction](https://paperzz.com/doc/8887603/numerical-computations-concerning-the-erh-%E2%80%94-all-q) gives the following content in section 3, pages 426 and 429–433.

The standing hypothesis is a primitive character of conductor Q>1, without a parity restriction. S is the imaginary horizontal logarithmic variation of L, divided by pi. Theorem 2 states, for 50<t1<t2,

    |integral_(t1)^(t2) S(t,chi) dt|
        < 1.8397 + .1242 log(Q*t2/(2*pi)).

It follows from Littlewood's identity and Theorem 3. For I(t)=integral_(1/2)^infinity log|L(sigma+it,chi)| d sigma, their inputs are

    pi*integral_(t1)^(t2) S = I(t2)-I(t1),
    -3.4507-.24 log(Qt/(2*pi)) < I(t)
        < 2.3288+.15 log(Qt/(2*pi)),  t>50.

The proof uses Rademacher convexity for the upper bound; Euler products, a Hadamard product, logarithmic derivatives, gamma estimates and Lehman's auxiliary inequalities for the lower bound. It has no RH, finite-zero-list, Gram-law or simplicity premise. This is the ordinary-height integral, not the separate Gram-coordinate Theorem 1.

The AMS and CiteSeer PDF requests failed. The paper link on the [author's university page](https://www.math.uga.edu/directory/robert-rumely) redirected to a login. The OCR corrupts the one-sided-limit arrow in the definition of S. I therefore do not certify that the original convention was left-continuous or right-continuous, nor attach a hash purporting to authenticate an unread original PDF.

## Independent published corroboration

[Platt's 2013 preprint, Theorem 3.3](https://arxiv.org/pdf/1305.3087), explicitly uses the same constants for T>50 and h>0 and cites Rumely's Theorem 2. Its S is normalized by 1/pi times the imaginary integral of L'/L from infinity to 1/2. This supports the consumer's far-right logarithm convention. The subsequent improved constants in that version are attributed to personal communication; they are not used here. The preprint's separate count formula is not used to infer factors of pi in this audit.

[Trudgian, Improvements to Turing's Method, section 3, arXiv:0903.1885v3](https://arxiv.org/pdf/0903.1885), independently records Rumely's exact triple (1.8397,.1242,50). Its Lemma 3.4 gives the horizontal-log identity, and Theorem 3.8 supplies a proved parameterized alternative with explicit a and b for t2>t1>t0>50. Its warning about the printed example 4.824 concerns a different Gram-weighted bound. It does not invalidate the triple used here. I do not adopt the improved numerical constants or claim to have recomputed all integrals in its parameterized theorem.

## Normalization contract for implementation

The following is the review's proposed exact interface, rather than a transcription of a possibly ambiguous endpoint convention. Let chi be primitive with conductor c>1. For a nonexceptional real t, define S_can(t) by continuing the Euler-product logarithm, normalized to tend to zero as the real part tends to positive infinity, along the horizontal ray to 1/2+it, then divide its imaginary part by pi. Require

    50<T, 0<h,
    |integral_T^(T+h) S_can(t) dt|
      <= 18397/10000 + (621/5000)*log(c*(T+h)/(2*pi)).

These rational constants are exactly the stated decimals. Primitivity and c>1 exclude the principal pole case. The zeta entry needs its own theorem. There is no conductor upper limit or requirement that T*h, c*T, or the height be integral in this interface.

For a nonreal character, L(2,chi) need not be a positive real number. Initializing its argument to zero would generally change the function being bounded. An arbitrary branch shift by 2*pi*k changes S by 2k and the integral by 2kh. Thus a bounded principal endpoint argument, or an unspecified continuous branch, is insufficient. The consumer's normalization at the far right is the appropriate one.

The completion's root-number phase belongs to the gamma/count phase; it must not be inserted into S_can. The conjugate character is another primitive character with the same conductor, so the same bound applies separately. Consequently the consumer may use B_chi+B_barchi=2B. For a real character these are two occurrences of the same integral allowance, not permission to omit one.

For consumption, define values at exceptional ordinates explicitly and prove local integrability. On every bounded height interval, there are only finitely many relevant zero ordinates because the nontrivial zeros lie in a bounded strip and are discrete. Left, right or midpoint choices at those ordinates have the same integral if they agree away from them. This is an almost-everywhere adapter, not a claim about which arrow Rumely printed. The family plan independently excludes zeros at its count endpoints. Therefore neither that documentary ambiguity nor the distinction between open and closed integration intervals changes its inequality. Count endpoint conventions still need their own proof; the integral theorem alone does not discharge them.

## Exact rounding replay

Let Z_j=log(c*t_j/(2*pi)). In the stated domain, Z_1<=Z_2 and Z_2>0. From the two horizontal bounds, both signs of I(t2)-I(t1) are bounded above by

    5.7795 + .39 Z_2.

The independent script derives pi>3.14159 from rational Machin sums and checks

    1.8397*3.14159 - 5.7795 = 83123/10^9 > 0,
    .1242*3.14159 - .39 = 92739/(5*10^8) > 0.

Division by pi proves the proposed rounding once the analytic horizontal bounds are supplied. It does not presume a floating-point pi value.

The script also checks two final arithmetic combinations in the printed proof. The lower constant combines to 3.450608<3.4507. For the upper combination, an exact positive exponential Taylor sum proves log(4.596)<1.526; the resulting rational combination is 2.3286546875<2.3288. Those checks do not prove the imported zeta-integral, zeta-derivative, gamma or convexity inputs. Their exact analytic inequalities must remain visible proof obligations.

| New artifact | SHA256 |
|---|---|
| `turing_bound_constant_audit_20261111.py` | `3B7A6DD7D059F2DEBF5FA6B7314225C3F7DDCF1A0CE14B9BDBD198EFA7C76938` |
| `turing_bound_constant_audit_20261111.json` | `EF07363498B9094FE8003A7A72F316B4239C83A29E4A02F6516D5C8F092D661A` |

The exact script exits zero. It uses standard-library integer and rational arithmetic, not an L-function evaluator.

## What remains and whether a weaker bound helps

The candidate can be retained as the published target. The campaign still needs an actual proof of the canonical-log/Littlewood identity, the horizontal estimates and their numerical inputs, the source L-function identification, and the almost-everywhere endpoint adapter. This audit does not close that analytic producer merely by citing a paper. Recovering a readable original page would settle the remaining documentary arrow question, but is not logically required if the adapter above is proved.

A weaker proved integrated-S bound would be logically sufficient for the same acceptance rule. Substitute its rational upper allowance in the consumer's U and require U<K_main+1. This changes how much auxiliary sign evidence is needed; it does not guarantee that a particular finite zone will pass. The accessible parameterized Trudgian theorem offers a published alternative route, but specializing and certifying its constants is still work. No substitute numerical constant is invented here, and no assertion about production runtime or finite-spectrum completion follows.
