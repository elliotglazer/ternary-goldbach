# Independent review of the two-fifths theta-jet tail

2026-11-11. **PASS at paper-proof and source-interface scope. No correction requested.** For each classical theta constant 2, 3 or 4, ordinary derivative order j=0,1,2, and the author's exact N-term truncation,

`|theta_r^(j)(v)-T_(r,N)^(j)(v)| <=384 exp(-(N+1/2)^2/5)`

holds throughout the closed half-plane `Im(v)>=2/5`, including N=0. The rational cutoff rule is sufficient and terminates. No theta values, numerical grids, Lean builds or author-file changes were used in this review. This is separate from any proposed sharper sixteen-mode bound.

## Reviewed source and pins

The complete author note [THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-campaign/agents/major-constants/THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md) was read and its SHA256 confirmed:

`478DEDD2DC613670A5B2E6ECA18317733006D82CDE06860719302301B80FFE88`.

The relevant Mathlib source was inspected at dependency pin `56a005855ea17e0b0958f73ec801ae140b0a1679`:

| Source file | SHA256 |
|---|---|
| `NumberTheory/ModularForms/JacobiTheta/OneVariable.lean` | `7C29B4B07AED2E46D40FE408362F2A707126BFBBF05C3B374420AA0EDDF06B5C` |
| `NumberTheory/ModularForms/JacobiTheta/TwoVariable.lean` | `CC4E420DA8441AD20DDBE3709040C4CFBEBB530C6DDD8E101FF2FC1F0B6F8820` |
| `Analysis/Calculus/SmoothSeries.lean` | `4EE4C5646105728EE6A257B0ECE7FB80FFA6FB246370471EBFA8FEFF567EC0E7` |

`jacobiTheta` is the integer series with exponent `pi*i*n^2*v`. The positive-index source theorem retains the central 1 and multiplies the positive sum by 2. The two-variable term has exponent `2*pi*i*n*z+pi*i*n^2*v`; hence the stated classical theta4 and theta2 adapters are correct. In particular, classical theta2 is `exp(pi*i*v/4)*jacobiTheta₂(v/2,v)`, not the two-variable function alone.

## Pairing, derivatives and zero modes

For a fixed real a, the ordinary j-th complex derivative of `exp(pi*i*a^2*v)` is `(pi*i*a^2)^j` times the same exponential. There is no extra `2*pi`, factorial division, or derivative in another variable. For theta2, this is the derivative of the combined shifted exponent; differentiating only the second argument of its two-variable adapter would be wrong, but the author does not do that.

Theta2 pairs integer indices n and -n-1. Its positive absolute modes are 1/2,3/2,...; after N retained pairs the first omitted mode is exactly u=N+1/2. Theta3 and theta4 pair n with -n; their first omitted positive mode is N+1, larger than u. The theta4 phases agree within each pair and have modulus one. No cancellation is needed for its upper bound.

For theta3 and theta4 the zero mode is 1 at derivative order zero and vanishes at positive derivative orders. It is retained in the finite approximant, so never enters the tail estimate. Theta2 has no zero mode. When N=0, the integer approximants are still 1 and the half-integer approximant is 0. These endpoint conventions are consistent with the proof.

## Independent reconstruction of the constant

For a>=1/2 and j=0,1,2, one has `(pi*a^2)^j<=16a^4`. The three cases respectively use `16a^4>=1`, `16a^2>=4>pi`, and `pi^2<16`. This bound must not be applied to the integer zero mode; that mode has already been removed.

The positive exponential Taylor series gives `a^4<=2exp(a^2)`. Thus a paired contribution to the derivative tail has norm at most

`32a^4 exp(-pi*Y*a^2) <=64 exp(-(pi*Y-1)*a^2)`

`<=64 exp(-(3Y-1)*a^2) <=64 exp(-a^2/5)`.

The last step holds at equality Y=2/5 as well as above it. For u=N+1/2 and every natural k,

`(u+k)^2-u^2-k=(2u-1)k+k^2>=0`.

Consequently the theta2 tail, and the no-larger integer-mode majorant, is bounded by

`64 exp(-u^2/5) sum_(k>=0) exp(-1/5)^k`.

Since `exp(1/5)>=6/5`, the geometric ratio is at most 5/6 and its sum is at most 6. This produces exactly the claimed constant 384. All inequalities concern every omitted index. No finite test is being used to infer a tail estimate.

## Why these are the actual derivatives at the closed endpoint

The author correctly separates the domain of estimation from the domain of differentiation. Work on the open convex half-plane `Im(v)>1/5`, which contains every point with `Im(v)>=2/5`.

For any fixed eta>0 and integer j>=0, let t=pi*eta*a^2/2. From `exp(t)>=t^j/j!` one obtains

`(pi*a^2)^j exp(-pi*eta*a^2) <=j!*(2/eta)^j exp(-pi*eta*a^2/2)`.

For the paired sequences a>=k+1/2, the squared mode is at least k. The right-hand side is therefore at most a constant times the geometric sequence `exp(-pi*eta/2)^k`, whose ratio is strictly between zero and one. The pair factor 2 is absorbed in the constant; a separate integer central term is finite. This proves absolute convergence at a base point and a uniform summable majorant on the whole open half-plane, for orders 0,1 and 2.

The actual [hasDerivAt_tsum_of_isPreconnected](C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib/Analysis/Calculus/SmoothSeries.lean:89) takes an open preconnected set, termwise derivatives, a summable uniform bound on those derivatives, and summability at one base point. These hypotheses are available with eta=1/5. Apply it to order-zero terms to identify the first derivative, then to the order-one series to identify the second derivative. The second application uses the order-two bound and order-one convergence; it does not require a third derivative. Finite-sum differentiation and absolute convergence then identify the omitted tails.

This argument avoids both possible gaps: differentiating only from convergence on a closed set, and presuming that a bound on formal derivative terms proves they are derivatives of the summed function. No such gap remains in the paper proof.

## Exact cutoff and termination

For positive integers p,q and epsilon=p/q, the first search stops when `p*2^M>=384q`. Powers of two are unbounded, so a finite natural M exists. Then `384*2^-M<=epsilon`.

The second test `(2N+1)^2>=20M` is exactly `5M<=(N+1/2)^2`. It implies `exp(-u^2/5)<=exp(-M)<=2^-M`. The proposed explicit upper search bound N=5(M+1) is valid because

`(2N+1)^2-20M=100M^2+200M+121>=0`.

This also covers M=0 and the permitted N=0 search outcome. If a caller needs strict error less than epsilon, use the strict first comparison as stated by the author. These are all-index algebraic proofs of finite termination, not empirical cutoff tests.

## Verdict boundary

The theorem supplies a conservative uniform reduced-jet tail at the actual modular stopping threshold, including equality. A full input enclosure must lie in `Im(v)>=2/5`; knowing only that its midpoint does so is insufficient. The tolerance is for ordinary derivatives. Coefficient normalization by j!, chain-rule changes of variable, and amplification through modular transforms remain caller obligations.

Classical wrapper definitions, their source identifications, the sum-derivative instantiations and exact finite arithmetic still need Lean implementation. Finite theta terms and their elementary-function enclosures are not supplied by this tail lemma. No fixed sixteen-mode optimization, numerical node, complete evaluator or spectral result is accepted by this review.
