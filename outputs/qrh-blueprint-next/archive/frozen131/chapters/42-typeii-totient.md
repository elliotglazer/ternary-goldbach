# Upstream totient uses in the pointwise theorem

Research-only source audit, 2026-11-10. No Lean compilation. This is a scope correction and a partial paper repair for the totient route. The current downstream envelope in `GLOBAL_TOTIENT_TAIL.md` assumes the full pointwise theorem. That theorem also has upstream totient dependencies, which must be removed independently before the envelope eliminates the global totient input from the full proof.

Write B=2^1000 for the finite denominator cutoff and T=z^(1/3) for the analytic scale. These are different quantities.

## Exact uses and ranges

| Source | Required bound | Actual denominator range | Finite bound sufficient globally? |
|---|---|---|---|
| `FirstChoiceTypeII.lean:153` | q/phi(q)<=7.2539 sqrt(T/6e6) | 1<=q<=T, T>=6e6 | Yes after the elementary power repair below |
| `SecondTypeIIa.lean:172` | q/phi(q)<=1.7882 loglog(q)+.9549 | Helper states every q>=1e6; consumers use the new second-choice denominator q'<=T^2/349 | Only when q'<=B |
| `SecondTypeIIb.lean:216` | q/phi(q)<=a1F0(log T) | 1<=q'<=T/6 | Only when q'<=B |
| `SecondBridge.lean:58` | q/phi(q)<=1.948 loglog(T)+1 | 1<=q'<=T/6 | Only when q'<=B |
| `SecondTypeI1.lean:50,60` | Calls the preceding large-q and F0 helpers | Same second-choice q' | Same limitation |

The line references are source reads of the current clone. These bounds are not all interchangeable. The first-choice proof only needs a loose power envelope. The other helpers state logarithmic envelopes and are used in the numerical reduction of the second-choice Type I and Type II terms.

## A complete paper repair of the first-choice use

For every positive integer q,

    (q/phi(q))^4 <= (27/2) rad(q) <=16q,
    hence q/phi(q)<=2q^(1/4).

To prove the first inequality, multiply the factors

    [(p/(p-1))^4]/p =p^3/(p-1)^4

over the distinct prime divisors. For every prime p>=5 this factor is at most1: expanding gives

    (p-1)^4-p^3 =p^3(p-5)+6p^2-4p+1 >=0.

The exceptional factors are8 at p=2 and27/16 at p=3. Both exceed1, so their product bounds any subset of them and equals27/2. This proof needs no prime-distribution information.

Now suppose the hypotheses of `typeII_rest_le` hold, in particular q<=T and T>=6e6. If q<=B, use the finite exact theorem with r=T and then the existing algebraic `F_le` estimate, exactly as the source proof does.

If q>B, then T>B>10^12, and

    q/phi(q)<=2q^(1/4)<=2T^(1/4)
       <=.002 sqrt(T)
       <=7.2539 sqrt(T/6e6).

The middle inequality uses T^(1/4)>=1000. The final inequality follows by squaring the positive constants: `.002^2*6e6=24<7.2539^2`. Thus the exact hF estimate used by `typeII_rest_le` holds with unchanged constants. All subsequent steps of that proof can remain the same.

This removes the specific global-totient call in the first-choice lower-order bound, conditional only on the finite exact theorem for q<=B. It does not remove other prime or Mobius inputs of first-choice Type I/II.

## Why the second-choice ranges are unbounded

`SecondFinal.theorem_3_1_1_second` starts with an approximation whose denominator exceeds T/6. It then calls `exists_approx2` again with

    Q2(T)=T^2/349.

The new denominator q' satisfies q'<=Q2(T). Its case split is:

* case a: q'>T/6;
* case b: q'<=T/6 with a large twist;
* case c: q'<=T/6 and the bridge conditions.

There is no scale-independent upper bound on q'. All internal denominators are below B when T<=2^500, since T^2/349<B. Equivalently, this gives a sufficient range z<=2^1500 for the second-choice calls. Cases b and c individually are covered throughout T<=6B, but case a can already exceed B much earlier. The analytic scale z=wy is unbounded in the etaStar convolution even at fixed y.

For a particular approximation with q'<=B, the finite exact totient theorem works for every T, because its comparison parameter r has no upper cutoff. Thus it is only the q'>B subcase that needs new work, not every large T.

The power estimate 2q^(1/4) does not prove an O(loglog q) bound on an unbounded range. It cannot simply be substituted in `div_totient_le_large`, `div_totient_le_F0`, or `div_totient_le_loglog` while preserving their conclusions. In case b or c, the power estimate may grow like T^(1/4), whereas the claimed helper grows only like loglog T. This is a failure of that implication, not a counterexample to the actual logarithmic totient theorem.

## The remaining bounded research task

One option is to prove the genuine global logarithmic envelope by analytic number theory. The elementary alternative is to retain the exact second-choice calculation for q'<=B and re-estimate the raw second-choice terms for q'>B using the power bound. That would produce a new decaying error term, rather than the unchanged hfun(z).

The required source targets are explicit:

1. `SecondTypeIIa.a1_M1_le` and its secondary-term consumers of `div_totient_le_large`.
2. The case b primary and secondary terms using `div_totient_le_F0`.
3. The two Type I branches in `SecondTypeI1`.
4. `SecondBridge.bridge_le`, where the first-choice theorem can now be used but the final phi denominator must receive a weaker large-q' estimate.

The new bounds must be assembled into `theorem_3_1_1_second`, transported through the fresh-approximation convolution, and included in the layer and terminal budgets. No explicit total coefficient for this new second-choice error has been established here.

The scale at which this error can first occur matters. From q'>B and q'<=T^2/349 one only gets T>sqrt(349B), not T>B. Therefore the downstream H plateau at r=B cannot automatically absorb the additional error. The first proof of a second-choice replacement should state its coefficient and starting scale before choosing the new plateau radius. The existing 1e-60 result accounts only for the downstream GBound replacement.

## Current conclusion

The first-choice global-totient use has a simple paper repair with unchanged constants. The second-choice logarithmic helpers remain open on q'>2^1000. The finite exact theorem and downstream envelope are useful components, but together they are not yet a full removal of the global totient dependency from the pointwise minor-arc theorem.
