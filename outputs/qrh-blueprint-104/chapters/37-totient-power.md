# Elementary fourth-root totient envelope

Research derivation, 2026-11-10. This is not a Lean declaration or a checked replacement for the global Fr theorem.

For every integer q>=1,

    (q/phi(q))^4 <= (27/2) q < 16q,

and hence q/phi(q) <= 2 q^(1/4). This uses only the finite prime factorization of q.

For each prime p>=5, (p-1)^4>=p^3. For example, p>=5 gives p*(1-1/p)^4 >=5*(4/5)^4=256/125>1. Consequently (p/(p-1))^4<=p. The exceptional prime2 contributes a correction factor8 over p; prime3 contributes27/16. Each factor exceeds1, so their product is at most8*(27/16)=27/2 even when one or both primes are absent. Multiply over distinct prime divisors and use rad(q)<=q. The empty product q=1 is also covered. Taking positive fourth roots yields the stated envelope.

## Why this matters for the current source

At `MinorArcs/FirstChoiceTypeII.lean:153`, the sharp global totient theorem is used only to establish

    q/phi(q) <= 7.2539 sqrt(T/6000000),  q<=T.

For q<=2^1000, the proposed finite exact Fr theorem reproduces the current proof for any r=T>=q. For q>2^1000, also T>2^1000, and the elementary fourth-root envelope is enough. Indeed

    2 T^(1/4) <= 7.2539 sqrt(T/6000000)

is equivalent to the positive rational inequality

    (2/7.2539)^4 * 6000000^2 <= T.

Its left side is less than 6000000^2, which is less than 2^1000. Thus this particular internal use of the sharp global Fr theorem can be replaced without changing its downstream coefficient.

This does not yet cover the separate calls in SecondTypeIIa, SecondTypeIIb, SecondBridge, or the final GBound conversion. Those calls need their own range and coefficient checks. The remote-layer envelope is designed for the last conversion; it must not silently assume the upstream global totient calls have disappeared.

No zero-free region, RH verification, PNT estimate, or analytic Mertens theorem is used in this power bound. Its formal proof would require the standard totient product formula, finite prime-factor products, and elementary nonnegative-power inequalities.
