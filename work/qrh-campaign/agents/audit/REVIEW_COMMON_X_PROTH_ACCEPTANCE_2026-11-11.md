# Common-X batched primality acceptance

2026-11-11. Independent mathematical/source check of the proposed acceptance contract, coordinated with independent_feasibility. **PASS for the contract below**, not for an implemented checker, a populated prime ladder, or a runtime saving. No builds, Lean edits, prime search, modular-power evaluations, or new numerical run.

## Exact criterion

Write F=2^45 and D=2^44. For every Proth-tagged slot i let k_i=S*i-t_i be an actual positive integer, and require

    p_i=k_i*F+1,  1<p_i<(F+1)^2,
    p_i | M,  gcd(X,M)=1,
    p_i | X^(D*S*i)+X^(D*t_i).

Here S,i,t_i,X are natural numbers and `S*i=k_i+t_i` must be established. Natural subtraction alone does not justify this equality; enforce t_i<S*i. The usual window conditions imply it, but it cannot be omitted when generalizing the source checker.

The exact factorization is

    X^(D*S*i)+X^(D*t_i)
      = X^(D*t_i) * ((X^k_i)^D+1).

Since p_i divides M, batch coprimality implies gcd(X,p_i)=1. Thus p_i is coprime to X^(D*t_i), even before primality is known, and cancellation gives p_i | (X^k_i)^D+1. Each p_i is odd. `Ladder/Spec.lean:38-55`, `prime_of_dvd_pow_add_one`, already proves precisely the remaining primality implication for an arbitrary natural base x. Instantiate x=X^k_i. Its current base-3 specialization at58-79 needs only the replacement of its base-specific coprimality proof.

Independently, let ell be a prime divisor of p_i. It is odd, and z=X^k_i is a unit modulo ell with z^D=-1. Its order divides 2D=F but not D. Because F is a power of two, its order is F, so F divides ell-1 and ell>=F+1. Were p_i composite, its least prime factor would have square at most p_i, contradicting p_i<(F+1)^2. Multiplicities and repeated product factors do not change this argument. **Oddness of k_i is unnecessary.** The source's stronger k_i<F is a convenient sufficient size check, not a logical requirement of this criterion.

## Necessary checks and redundant checks

The common witness X need not be prime, odd, small, or equal to any prescribed small base modulo a factor. Per-factor Jacobi tests, residue-class selectors, base tags, and comparisons X mod p_i=a_i mod p_i are unnecessary for primality acceptance if the displayed gcd and modular tests are all checked. They can guide production, but add no acceptance theorem.

Batch coprimality is substantive for the uncancelled sum. For a symbolic counterexample, take S=1,i=3,t=1,X=0. Then k=2 and p=2^46+1 is divisible by5, is greater than5 and lies below (F+1)^2; both tested powers of zero vanish. Without coprimality this composite would pass. For t=0 the factor being cancelled is1, so a special branch could omit that slot's coprimality need, but one uniform batch gcd is simpler. X=0 cannot pass a nonempty product gcd; X=1 cannot pass any p>2 because its tested sum is2.

Factor inclusion must come from the exact product over the accepted Proth-tagged records, or from separate checked divisibility. Distinctness and pairwise coprimality of the factors are not required. Do not assume the factors prime in order to validate the product or use CRT inside the acceptance proof.

## Shared modular schedule and mixed slots

Compute, with proved modular routines,

    V=X^D mod M, A=V^S mod M, U=A^i0 mod M.

At slot i0+j, U represents X^(D*S*(i0+j)) modulo M. The test against the factor p is `(U + (V mod p)^t) mod p = 0`. Advance U by A at every original slot position, including general-prime slots; alternatively prove an exact gap-jump invariant. Every modular-power routine must cover the full bit width of its exponent. The original source's 28-bit index limit is not adequate automatically for a denser ladder.

The computation of V is still essential. An unconstrained supplied V is not equivalent to supplied X with a checked 44-squaring chain. For example V=-1 modulo M makes `V^(S*i)+V^t` vanish whenever k_i is odd, without forcing a prime divisor's order to contain 2^45. Keep the X-to-V proof.

General-prime slots require an independent sound primality certificate and the prescribed window membership. They need not divide M and need no gcd with X. Every ladder slot must receive exactly its required prime-and-window conclusion. Empty Proth products are M=1: skip the modular batch and verify all general slots directly. Never infer coverage from an empty ordinary batch or omitted slots.

## Shorter witness encoding

An exact encoding X=a0+M0*y is sound without per-factor CRT checks when the full acceptance tests above are retained. Its decoder must bind M0 and y to the intended records, reject malformed integer encodings, and compute the actual X used by gcd and every modular routine. It is not legitimate to use this expression only as metadata while testing a different residue.

If M=M0*M1, 0<=a0<M0 and 0<=y<M1, then 0<=X<M; thus y can be encoded using roughly the residual product's bit length rather than M's. If a0=3 is fixed and M0=1, this normalization does not apply; use an explicit empty-baseline case or an adjusted bounded encoding. Reducing X modulo M is also valid if the checker proves the reduction congruence and uses it consistently.

Every p dividing M0 inherits X congruent a0 modulo p. This alone is **not** its primality certificate. To omit an M0-factor modular test, retain a previously checked a0 certificate for that factor and prove the congruence transport. Likewise gcd(a0,M0)=1 and gcd(X,M1)=1 can replace gcd(X,M), but only with the exact product identity. The uncomplicated first design checks the full gcd and all slot tests; it needs no baseline-certificate partition in its soundness argument.

Pairwise coprimality is relevant to a producer's guarantee that independently chosen residues have a common CRT solution. It is not an extra premise for accepting an actually supplied X that passes the tests. Duplicate factors with incompatible proposed bases can obstruct that construction; they do not invalidate the generic acceptance theorem.

## Cost scope and source pins

One common X can remove duplicated initialization/advancement schedules across small-base groups. It adds a potentially product-sized witness and a general gcd instead of the source's very cheap mod3 check. Encoding y can reduce witness bytes when many factors share a baseline base, but it does not automatically shrink the product-modulus operands. A Bezout witness is an optional exact gcd certificate, with its own signed arithmetic and size checks. Net Lean/MM0 savings require measured complete decoding, gcd, powering, factor checks and proof consumption. No runtime ratio or successful-window frequency follows here.

The inspected source files are `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` and `Check.lean`; the frozen multibase review is used for comparison, not as a substitute for this derivation.

| File | SHA256 |
|---|---|
| `Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |

This review concerns the generic mathematical contract before any new common-X implementation or receipt. It does not approve future code by inheritance.
