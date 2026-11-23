# Independent review of the conditional Möbius input reduction

Research audit, 2026-11-11. Pinned source: `work/ternary-goldbach` at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical source edit was performed.

**Verdict:** no mathematical defect found in the stated conditional reduction. The exact scalar replay passed all 214 cells and the matching infinite tail. The unresolved arithmetic input remains

\[
\tag{E} |\operatorname{psiN}(v)-v|\le \frac{v}{100\log v}
\quad(v\in\mathbb N,\ v\ge10^9).
\]

Neither this audit nor the replay proves E. Subject to E, the reviewed finite psi repair, P2, and the existing finite Möbius/weight certificates, the proposed proof supports the profile .03 on `[11815,100000001)` and .10 on `[100000001,infinity)`. The changed evaluator, cell soundness adapter, and parameterized tail still need formal proofs. This is not approval to add E as a premise to the final Goldbach statement.

## 1. Exact artifacts and replay

Reviewed integration artifacts:

| Artifact | SHA256 |
|---|---|
| `RESUME_MOBIUS_INPUT_2026-11-11.md` | `2F292201BDB9E2E2E65CDB37733235A9B1107DC42DBF7233CA8D9E3761F64E52` |
| `resume_mobius_input_20261111.py` | `D7AF8530701E7FD85E184716B1F220D464D709A36F5714E651AEFFE7985DF339` |
| `resume_mobius_input_20261111.json` | `AC5E02A7AF0B78F6BA7E4ACB563AB067B02B9C50AD501751FDA1A29D9E038F89` |

The independent harness `resume_mobius_review_20261111.py` executes the author's arithmetic with additional assertions and redirects all output into this reviewer's directory. It does not call the source generator's `run` or `write` functions. I read the executed prefix: its top-level work reads the weight table and defines arithmetic/checker functions; the file-removal and writer functions lie after the excluded `def run():` boundary.

The replay completed with exit 0. It agrees exactly with the author's parsed JSON, including source hashes. Added checks establish that the 214 cells are contiguous, start at 100000001, include exactly one right endpoint and one left endpoint at `10^9`, and use `12<=Y<=10^6`. Every logarithmic-piece list starts at `10^9`, ends at A, and has strictly increasing integer entries in `[10^9,A]`. I separately asserted positivity and the three scalar cell inequalities, the current coverage endpoint, positivity of the solved denominator, and the certified logarithms of the final T. Tail exponent ordering and geometric domain conditions were also checked exactly.

| Audit artifact | SHA256 |
|---|---|
| `resume_mobius_review_20261111.py` | `6CA816630E0A2A00F4317BB75A415BDED13F064A2DCE2917E97A9CD9B5E46921` |
| `resume_mobius_review_20261111.json` | `62128E4FEB5C57947FA2DCAE114D3C35BFFB3A1A4DF01EE90C6A8B7BBDFE56C4` |
| `resume_mobius_review_20261111.log` | `7378FECAEEE9D466053D2F103DC31B826F053B3B2C2C7562A684BE03872A0EF3` |

This is an independent source review plus an instrumented replay, not a wholly independent implementation of every source arithmetic function. Floating values choose candidate mesh points and initial log approximations only. Acceptance uses `Fraction` arithmetic and the source `Small.chkLow/chkStep` formulas. No floating comparison certifies the resulting bounds.

## 2. The actual source contracts

`Schoenfeld69.lean:20,22` defines

\[
N(n)=\sum_{1\le m\le n}\mu(m)\log m,
\qquad \rho(n)=\sum_{1\le j\le n}(\Lambda(j)-1).
\]

`SchoenfeldJ.rho_eq:19` proves **exactly** `rho(n)=psiN(n)-n`. This uses the integer carrier and includes the summand at 1; there is no hidden endpoint correction. It is not a bound for `theta`, a smoothed prime sum, or the real error at nonintegral arguments. Every application of E here is at an integer: `D/m` is natural-number division, and Y or the tail boundary y is an integer.

`SchoenfeldStep.N_abs_le:27` has the J-sum over `Ioc 0 (D/(Y+1))`, with nonnegative `musq m=|mu(m)|`, and the boundary term `|rho(Y)| |M(D/(Y+1))|`. Thus both signs of the prime error are needed. The report retains these summation ranges and the boundary term. Neither P2 alone nor a signed mean error can replace E at this interface.

No tau declaration occurs in the inspected induction contract. The author's parameters are nu, eta, rho, X, and the weighted partial sum I. The result audited here is the stated .03/.10 bound on `|m(x)| log x`; it does not certify a downstream minor-arc tau or retain all older stronger profile values. The author confirmed this scope explicitly.

The finite bridge is correctly separated from E. On `12<=v<10^6`, use the unconditional small table directly. On `10^6<=v<10^9`, the theta sieve and the reviewed P6 replacement imply

\[
v-2\sqrt v\le\psi(v)\le v+1.5262\sqrt v.
\]

Therefore `|rho(v)|<=2sqrt(v)` below `10^9`. The existing `EOneRanges.psi_le_two:155` has a Fact binder because its proof calls broader wrappers; that declaration cannot be imported unchanged as an unconditional theorem. The finite repair remains a proof obligation, albeit with identified unconditional ingredients. The upper sieve endpoint is strict, so E must include `v=10^9`, as it does.

## 3. Modified J and boundary bounds

For all integer `v>=12`, the combined valid majorant is

\[
2\sqrt v+\mathbf1_{v\ge10^9}\frac{v}{100\log v}.
\]

Above `10^9` the first summand is harmless overcounting, not an assertion that the square-root bound still holds. The sum is nonnegative throughout. For each piece `10^9<=V<=W<=D`, its inverse-floor index interval is exactly

\[
D/W<m\le D/V.
\]

For these m, `V<=floor(D/m)<W`. Positivity and monotonicity of `1/log` give

\[
\mu(m)^2\frac{\lfloor D/m\rfloor}{100\log\lfloor D/m\rfloor}
\le \frac{D}{100\log V}\frac{\mu(m)^2}{m}.
\]

The proof of `SchoenfeldJ.eps_piece:168` then applies with this new coefficient: `Sqf.Q1_diff_le` bounds the remaining sum by `kap log(W/V)+.588`. Its logarithmic ratio is obtained from the real arguments D/V and D/W, so no estimate of a floor by a continuous derivative is being assumed. The last piece uses `Q1(D/V)<=kap log(D/V)+1.166` as in `eps_last:212`.

The old `V>=10^12` requirement belongs to the old epsv input. The squarefree-sum step requires `D/W>=1`; that remains true because every retained endpoint is at most A and `A<=D`. Lowering V to `10^9` is therefore mathematically sound for E, but requires a new lemma rather than applying the old theorem with a false hypothesis.

The rational evaluator replaces `log V` by a positive lower certificate, the next `log W` by an upper certificate, and the last `log D` by the upper certificate for B-1. All factors being enlarged are nonnegative: `log W-log V>=0`, kap is positive, and both additive constants are positive. Replacing kap by its source upper bound has the correct direction. The new piece checks added by this audit are important because the original `chkCell` only checks its old `10^12` epsv list, not the newly generated `10^9` list.

For `D<10^9`, `D/m<=D<10^9`, so the extra part is zero. The split at `10^9` makes this true on the entire preceding cell and activates the new term on the following cell, including `D=10^9`. No threshold is crossed inside a cell.

The unchanged square-root contribution is `jVal(...,coef=2)`. The existing `sqrt_piece` and `sum_sq_sqrt_le` require only positivity and integer geometry. The retained Y lies in `[12,10^6]`, so the boundary uses the finite square-root bound, not E. `SchoenfeldGen.bTerm_le:437` has exactly `rY^2<=Y+1`; the generator's `r1=isqrt(Y+1)` matches it. Its factor `2p1/sA+2p2/rY` follows from `sqrt(Y)sqrt(D/(Y+1))<=D/sA` and `sqrt(Y)(D/(Y+1))<=D/rY`. The Fact-dependent call to rho_le inside bTerm_le must be replaced by the finite repair.

## 4. Induction, positive coefficients, and the real profile

`SchoenfeldCell.cell_step:46` is the precise scalar consumer. The replayed inequalities match its coefficients and weighted-sum range `Ioo X0 A`. Updating I by `nu(B-A)/L^2` includes the new integer points `A,...,B-1`; no last point is dropped. The identity used is `M_of_N`, not an inferred relation between differently normalized Möbius sums.

The initial I is zero because `Ioo 10^8 (10^8+1)` is empty. The initial S bound 11519 is exactly `99+1.142sqrt(10^8)` from `MoebiusSch.Ssum_low:81`. The unchanged C0 is 626. All regenerated nu and eta values are nonnegative; consequently the source `Mrange`, k-block, square-root and boundary comparisons retain their directions. Although the source checker need not assert a separate eta nonnegativity field, its second scalar inequality and positive terms imply it; the audit checks it directly.

`MoebiusSch.mqv:195` has the maximum of **both** endpoint quotients. The script uses that exact maximum, not the left endpoint alone. This handles either sign of `ub+S-eta(A-1)`. The underlying proof `mChk_spec:229` also establishes the resulting bound is nonnegative before multiplying by `log x<=ub`. S updates by `eta(B-A)`, giving the correct bound on `Ssum(B-1)`.

The largest cell profile is approximately .086371196202, with an exact assertion that it is below .10. Changing to the constant .10 means the old profile breakpoint checks are unnecessary, but a new constant-profile soundness adapter is necessary. Existing `m_small_real:54` and `m_mid:123` cover the earlier half-open ranges without a gap. At x=100000001 the new cell applies; at x=T the infinite tail applies.

## 5. P2 really removes P3 from this tail consumer

`SchoenfeldTail.G_tail_le:427` only needs a bound on the weighted absolute coefficient sum from `10^6` to y. Since `aw(k)=|Lambda(k)-1|<=Lambda(k)+1`, positivity, P2, and the harmonic interval bound give

\[
G(y)-G(10^6)
\le\sum_{10^6<k\le y}\frac{\Lambda(k)}k+\sum_{10^6<k\le y}\frac1k
\le 2\log y-\log(10^6)
\le2\log y-13.8155.
\]

P2 bounds the full first sum through y, with the omitted initial sum nonnegative. No lower Mertens estimate is required. The old `sum_Lambda_div_Ioc` cannot be reused because it proves a stronger subtraction using P3; replace this one consumer's bound instead.

Writing L=log D and `l2=.82L-.6933`, the resulting coefficient is `.36L-13.8155`. It is positive for `L>=160.54`, and

\[
\frac{(.36L-13.8155)\nu}{.82L-.6933}\le\frac{.36\nu}{.82}
\]

because `13.8155*.82>.36*.6933`. For the b/l2^2 contribution, dropping the subtraction gives the same upper expression as the source tail. Thus the unchanged final scalar majorant is valid despite weakening G_tail_le. This removes P3 only from this Schoenfeld-tail use, not from every consumer in the project.

## 6. All terminal data and the infinite range

The terminal integer T is unchanged. Its rational logarithm certificates give `160.54<=log T<=160.55`. The replay verifies

\[
S(T-1)\le .000135T,\qquad
(626+I)160.55^2\le .022T,
\]

and `etaMax` on `[10^57,T-1]` is at most `.037/160.55`. These are separate checks, not consequences of the cell profile bound. The diagnostics are respectively .000134586823899479 for S/T and .000158259840634 for etaMax. The printed .021590700271358853 diagnostic concerns I alone with its certified upper logarithm; the accepted K0 comparison includes **626+I** and uses 160.55.

Use `nu=.037`, `b=.060`, `K0=.022`, and `eta(l)=nu/l+b/l^2`. The exact inequality `1.013nu+K0=.059481<b` supplies the M_above estimate. Below T, the etaMax comparison implies `|M(u)|<=nu*u/log u`, and the positive b term may be added. This proves the two cases of the proposed M_unif bound without silently retaining the old cell constants.

For D>=T, set `y=floor(exp(.18L))`. Source `vfloor:314` applies since `.18*160.54>28`; it gives `y>=10^12`. The exponent mesh is ordered and lies in `(0,1]`. The exact inequality `131.25+.18*160.54+1e-9<=160.54` ensures `10^57(y+1)<=D`, as needed for the boundary M_unif application. Every rho input in the tail J-sum is at least y+1, and the boundary input y is also at least `10^12`, so E covers all of them.

The new jV expression matches the source recurrence at `SchoenfeldTail.jV:521`, with only `.00985` replaced by `.01`. The report's first interval uses y+1, not y; the source's `+/-1e-9` logarithm bounds cover this change. There is no omitted first slice.

Monotonicity beyond L0=160.54 is justified term by term. Eta decreases on positive arguments; `L/(.82L-.6933)^2` decreases there; each jV summand has form `(aL+b)/(cL-d)` with a,b,d nonnegative and c positive, and therefore derivative `-(ad+bc)/(cL-d)^2<=0`. The boundary is a product of nonnegative decreasing functions. The right side `nu(1-1/L)` increases. These are the same hypotheses used by source `frac_anti:342`, `jV_anti:550`, and `tail_step:710-731`; replacing the positive constants does not invalidate them.

The exact tail margin is positive. The final real-variable conversion reproduces `MoebiusSch.m_tail:303`: it retains the floor-log reserve `1e-60`, the nonnegative extra inverse-log-square term, the S(T-1) contribution with the **new** coefficient .000135, and the reserve `1e-30` for log-squared/x. The final bound is approximately .09712681333845141 and is asserted rationally below .10. Because T is unchanged and exceeds `10^69`, the source's real-floor estimates remain applicable for all x>=T.

## 7. Status and remaining obligations

This audit accepts the mathematics of the conditional reduction and the scalar evidence. It does not prove E, formalize the finite P2/P6 repairs, or turn Python assertions into Lean theorems. The source `chkCell`, `rho_le`, `rho_C5`, `M_tail`, and `m_tail` still have their old evaluators/constants or Fact dependencies. They must be adapted with proved soundness, not imported as though the numerical experiment changed their types.

The necessary implementation work is explicit: prove E or a sufficient weighted-J replacement; expose the finite rho repair; prove the new monotone-piece bound and checker soundness; export and kernel-check the regenerated cell data, S/K0/etaMax and tail comparisons; parameterize the tail; and then verify the separate relaxed-profile downstream adapters. The report correctly states that the original G2 .0082 result is not automatic and that its separate .0089 adapter is still required. No new analytic cap, tau value, axiom, or result-shaped hypothesis is approved by this review.
