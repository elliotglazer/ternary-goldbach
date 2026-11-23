# Finite zero-exclusion certificates: evaluator and contour pilot

Research and external interval computation, 2026-11-11. No Lean build, canonical source edit, new axiom, or admitted proof. The target finite rectangles through heights4e7 and14e6 remain unverified. This task produced small complete contour checks, an explicit evaluator/remainder specification, and a concrete route to a formal checker.

The hybrid report's Section5 now explicitly requires a product Gram basis for Cross, with both character and zero indices, multiplicity products, and actual q-window measure. Its prior reviewed hash and the independent review hash are preserved in that report. The amended hybrid report SHA256 is `D9D4807F8465EBDA115F0675F4A9EE4DBFF30EED85719AADA963B5F2C0E49B2F`.

## 1. What ran

The environment has python-flint0.9.0 linked to FLINT3.6.0. All runs used128-bit ball arithmetic and one process. These are native interval computations, not kernel-checked proofs. One wall-time observation per run is reported, with no scheduling or full-height forecast.

| Exact rectangle | Evaluation method | Accepted boundary segments | Winding enclosure | Wall time |
|---|---|---:|---|---:|
| zetaF, `[2/3,2] x [0,20]` | Explicit Euler–Maclaurin, N=80, M=24 | 443 | `0 +/-9.42e-34` | .168 s |
| chi3, `[16/25,2] x [0,20]` | Explicit Euler–Maclaurin, N=80, M=24 | 616 | `0 +/-2.46e-33` | .457 s |
| zetaF, `[2/3,2] x [40000000,40000000+1/16]` | FLINT builtin zeta | 1296 | `0 +/-3.41e-33` | 6.821 s |

Every accepted segment encloses the image of the whole segment in a convex complex rectangle excluding zero. The total winding enclosure contains exactly the integer0. Given the evaluator and argument-principle lemmas specified below, these checks establish zero exclusion on those rectangles, including their boundaries. They say nothing about the intervening heights. The high rectangle lies just above the desired endpoint and is a local evaluation test, not coverage of `[20,4e7]`.

The low acceptance path does not call Arb's zeta/L evaluator. It uses exact Bernoulli rationals, explicit finite sums, the remainder below, and Arb elementary arithmetic. Eight independent builtin-value overlap checks are diagnostics only. The source's removable value `zetaF(1)=1` was also checked. A separate builtin point evaluation at `2/3+4e7*i` took .00538 s and returned a narrow enclosure; a point does not certify a neighboring region.

Artifacts in this directory:

| Artifact | SHA256 |
|---|---|
| `finite_contour_pilot_2026_11_11.py` | `77DF7383E75296DF1CAE2703B82E0073F1286121136DE971DDEEA36DA95E5226` |
| `finite_contour_pilot_2026_11_11.json` | `B71A4918FCEA797E9662B3C51BA523F8F149890391B5DF1BC25F59CF971496C0` |
| `finite_high_pilot_2026_11_11.py` | `A7D626431E45005323E96C7A72082339D57E688699E8B84C74C5F090EE68C2B2` |
| `finite_high_pilot_2026_11_11.json` | `5F0FE5A69E1C29EB9112CD57BFD899600DDD34B7A6AD83BE7ED0421C7A34B202` |

Each JSON records the complete ordered rational boundary partition. The high pilot imports the low pilot's contour driver and records its exact hash. Neither JSON contains a claimed full-height certificate.

## 2. A simple rigorous evaluator with a rational remainder

For real a>0, integers N,M>=1, b=N+a, and `sigma=Re(s)>1-2M`, Euler–Maclaurin gives

```text
zeta(s,a) = sum_(0<=n<N) (n+a)^(-s)
          + b^(1-s)/(s-1) + b^(-s)/2
          + sum_(1<=k<=M) B_(2k)/(2k)! * (s)_(2k-1)*b^(1-s-2k)
          + R_M.
```

Its remainder is the integral of a periodic Bernoulli polynomial times `(s)_(2M)(t+a)^(-s-2M)/(2M)!`. For real a, `|Btilde_(2M)|/(2M)!<=2*zeta(2M)/(2pi)^(2M)<4/6^(2M)`. Thus

```text
|R_M| <=4 |(s)_(2M)| b^(1-sigma-2M)
                       /[6^(2M)(sigma+2M-1)].
```

This is a deliberately coarse specialization of the rigorous Euler–Maclaurin approach, valid also for complex interval inputs by bounding the rising factorial and replacing sigma by a proved lower endpoint. The pilot uses the common lower endpoint16/25. Analytic continuation supplies the identity throughout this half-plane away from the pole. [Johansson, Rigorous high-precision computation of the Hurwitz zeta function and its derivatives, Section2](https://arxiv.org/pdf/1309.2877).

All Bernoulli coefficients in the pilot are exact Fractions. Its elementary interval arithmetic encloses powers as `exp(-s*log(real_positive_base))`; the remainder disk is enlarged to a rectangular error box. A future rational checker can replace each elementary ball call with dyadic interval operations and proved log/exp/sin/cos series, range reduction and remainders. The untrusted producer supplies subdivisions and precision choices; it does not supply unchecked function values.

The evaluator handles the two removable poles explicitly:

* For zetaF, multiply the regular finite part by s-1 and replace the singular integral term by `b^(1-s)`. This is the analytic continuation with value1 at s=1, rather than the literal pointwise product of the library's zeta value there.
* For chi3 use `L(s,chi3)=3^(-s)[zeta(s,1/3)-zeta(s,2/3)]`. The two singular integral terms cancel. If `b1=N+1/3`, `b2=N+2/3`, `h=log(b2/b1)`, their difference is `b1^(1-s)*h*exprel((1-s)h)`, where `exprel(z)=sum_(k>=0)z^k/(k+1)!`. The pilot uses terms0..18 and error `exp(|z|)|z|^19/20!`. Thus no division by an interval containing s-1 occurs.

The character is exactly the real primitive character modulo3, with values1 on residue1, -1 on residue2, and0 on multiples of3. Its pairing identity and analytic continuation must be proved against the source character, not inferred from a label in the JSON.

## 3. The winding checker contract

For a closed positively oriented rational rectangle and an analytic function f on a neighborhood of it:

1. Check that the ordered segments form its boundary exactly, with adjacent rational endpoints equal and no omitted or duplicated edge interval.
2. Recompute an enclosure B_j of f on each entire segment. Require B_j finite and0 not in B_j. Failed enclosures cause subdivision or rejection.
3. Recompute endpoint-value enclosures and a principal-argument enclosure for `f(v_(j+1))/f(v_j)`. Require an unambiguous increment; the pilot imposes absolute upper bound3, strictly below pi.
4. Sum the increment intervals and divide by2pi. Accept a claimed winding integer only if the enclosure isolates that integer. The pilot requires the interval strictly inside `(-1/4,1/4)` and containing0.
5. Apply the proved argument principle, with the correct pole count. For entire zetaF and this primitive L-function there are no poles inside, so winding0 and boundary nonvanishing imply no zeros in the closed rectangle.

The local topological fact is important: a convex image rectangle excluding0 lies in an open half-plane through0. Every path inside it is homotopic, avoiding0, to its endpoint chord. Its argument increment has magnitude below pi, so the principal endpoint ratio gives the correct local lift. This controls the whole contour, unlike sampled argument values with guessed unwrapping.

For an efficient full-height implementation, only the left edge and top edge need costly general evaluations. On Re(s)=2, the Dirichlet series satisfies `|L(s)-1|<=zeta(2)-1<1`, so it stays in the right half-plane. Its endpoint arguments determine the lift; for zetaF also include the known factor s-1. On the real bottom edge zetaF is positive for s>0, including its continuation at1. The paired positive series for chi3 proves L(s,chi3)>0 for real s>0. These analytic shortcuts need proofs before omitting edges from a certificate.

For a finite target at height H, enclose the top boundary at H itself, or certify a larger H' and restrict the conclusion. A genuine zero on a chosen contour requires moving that contour or another mathematically valid treatment. Raising precision does not prove nonvanishing at an actual zero.

## 4. High-height feasibility and the algorithm choice

The simple evaluator is mathematically sufficient at any finite height but not a demonstrated practical full-height method. For sigma in[16/25,2], `|(s)_(2M)|<=(|t|+2M+2)^(2M)`. Taking `N+a>=(|t|+2M+2)/3` makes the main remainder ratio at most `4^(-M)`, times the displayed mild factor. M around64 therefore allows useful accuracy, but at t=4e7 the prefix contains roughly13.3 million terms per evaluation. Repeating that work along a long contour is an avoidable and potentially dominant expense. No runtime claim is based on this asymptotic observation.

The installed FLINT3.6.0 zeta path selects Riemann–Siegel at the tested high point. Its source provides an explicit remainder routine attributed to Arias de Reyna's Theorem4.2. The auxiliary RS remainder is bounded using a factor of the form `c1*((11/10)*sqrt(2pi/t))^(K+1)*Gamma((K+1)/2)`, with domain checks and outward upper bounds. A formal port must retain the auxiliary-function normalization, its prefactors, and the reflected term when converting to zeta; this formula alone is not a full-zeta error estimate. [Pinned zeta dispatch](https://github.com/flintlib/flint/blob/v3.6.0/src/acb_dirichlet/zeta.c), [pinned RS remainder implementation](https://github.com/flintlib/flint/blob/v3.6.0/src/acb_dirichlet/zeta_rs_bound.c).

The RS main sum has about `sqrt(t/(2pi))` terms, approximately2523 at4e7, rather than millions. The high contour pilot confirms that this implementation can enclose small complex input segments at the relevant height. It does not measure a full left-edge sweep or establish the best segment sizes. Many of its1296 panels lie on the horizontal sides; multiplying6.821 seconds by a number of height strips would be a misleading forecast.

The same speed evidence does not transfer to chi3. FLINT3.6.0's general L-function path uses Hurwitz evaluation in this region; it does not dispatch this case to the zeta RS routine. [Pinned general L-function implementation](https://github.com/flintlib/flint/blob/v3.6.0/src/acb_dirichlet/l.c). A high-height chi3 certificate needs a separately justified fast evaluator, such as a suitable approximate functional equation or the rigorous fixed-modulus multi-evaluation approach used by Platt. The generic algorithm and its error budget must be ported, not presumed from the fast zeta point. [Platt's algorithms](https://arxiv.org/pdf/1305.3087).

A naive theta-integral split followed by division by the completed gamma factor is not automatically an efficient substitute: absolute-error bounds can lose exponentially many bits at large imaginary part. The fast evaluator must control that cancellation or use a contour/normalization that avoids it.

## 5. What remains to make the finite evidence usable

The pilot supplies a functioning finite producer and an exact checker specification. Formal work remains for Euler–Maclaurin and its remainder, source-function identification, elementary interval replay, contour homotopy and the argument principle, and the complete rational partition check. For the fast backend add the actual RS or Dirichlet approximate-functional-equation theorem and all error factors. External Arb correctness is currently part of the numerical evidence boundary, not an axiom accepted by the final Lean theorem.

The next bounded step is to replay the two low rectangles with a small proved rational interval evaluator and verify a deliberately rejected contour containing a known zero or a corrupted partition. Separately, measure longer high zeta edge segments with the proposed analytic right/bottom shortcuts, and develop the chi3 high evaluator. Those tasks produce evidence about checker correctness and sustained cost. They must precede any claim that the entire principal4e7 or conductor-3 fourteen-million rectangle has been certified.

If these full finite rectangles are eventually proved, they discharge the specific principal and conductor-3 interfaces identified by the Mellin and major-constants workers. They still do not prove the finite mixed aggregate for all active conductors, Astar, or the final Goldbach theorem.
