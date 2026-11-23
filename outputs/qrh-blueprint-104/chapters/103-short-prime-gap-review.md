# Independent review of the short finite psi gap

Date: 2026-11-11. Reviewer: moebius_route. Finding: the external pilot and the proposed source-level finite design pass this review. No mathematical correction is required. This is not a Lean validation, a completed certificate through 5e9, or a validation of the separate analytic estimate above 5e9.

## Frozen inputs and independent computation

Reviewed files under `agents/prime-estimates/`, with SHA256:

| File | SHA256 |
|---|---|
| `RESUME_PSI_SHORT_GAP_2026-11-11.md` | `143f9fdaa31241641fa217145b11b1055bb362758921acd2aa93c5854fc5f6dc` |
| `resume_psi_short_gap_20261111.py` | `15b0fc40d240a576855007d4472b3eca7444f3e004de1667e113d388cef1cedc` |
| `resume_psi_short_gap_20261111.json` | `e8065467be53708445486b2f5ea5cbbe408b3a014cf2d1fa8746ec999485f595` |

The independent script beside this note, `resume_psi_short_gap_review_20261111.py`, completed with exit code 0 and wrote the corresponding JSON. It neither imports nor executes the author's script. It uses an Eratosthenes base and an odd-only segmented sieve; the author's base uses trial division and its segmented sieve represents all integers. Only the first window is sieved. Grid construction and base-prime generation do not count primes in the other windows. No Python process remained live when the review resumed after interruption; the completed result was preserved.

The independent count in `(1000000000,1000250000]` is **12008**. The eight consecutive counts for widths 32768,32768,32768,32768,32768,32768,32768,20624 are respectively

    1566, 1591, 1597, 1565, 1554, 1567, 1581, 987.

They match every author subwindow, not just the total. The newline-terminated ASCII list of primes has SHA256 `96779ee05e044581c24f67da29904872a6777c2f4f9f654b70deab285d1fbb9f`. These are external arithmetic checks and candidate certificate data. Their hashes do not prove a Lean count theorem.

## Source contract and height extension

All source references below are relative to pinned `work/ternary-goldbach/TernaryGoldbach/`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

`Prelim/PsiSieve3.lean` proves `PS3_eq` at line 72 and `mem_PS3` at line 106: the source list contains exactly the primes at most 31622. Parsing all eight literal lists and comparing with the independent sieve gives exact equality and 3401 entries.

The existing `prime_iff_PS3` at line 113 assumes `31622 < m` and **strictly** `m < 1000014129 = 31623^2`. The current `cnt3_spec` at line 166 assumes `31622 <= n`, `n + W < 1000014129`, and `W <= 32768`, and returns the prime count on `Finset.Ioc n (n+W)`. Even the first complete pilot subwindow exceeds that height. The existing theorem cannot directly certify the pilot.

The proposed strengthened characterization is valid: for a composite `m < 31627^2`, `Nat.minFac_sq_le_self` forces its least prime factor below 31627. The integers 31623,31624,31625,31626 are composite, witnessed by divisors 3,2,5,2. Together with `Nat.minFac_prime` and `mem_PS3`, this forces the least factor into PS3. `Nat.minFac_dvd` then gives the same contradiction as the source proof. The other implication remains unchanged. No primality claim about 31627 is needed. The new strict limit is 1000267129, above the pilot endpoint 1000250000 and every subwindow endpoint.

`orP_spec3` at line 133 depends on the base-prime bound 31622, pattern length 66000, and `i + 31622 <= 66000`; it places no absolute height restriction on `n`. Every pilot width at most 32768 satisfies the index condition. Thus the definitions `pats3`, `orP`, `cnt3` (line 164), and `pcL 7` can remain unchanged. A new count-specification lemma must use the extended characterization at the final primality step of the original proof. Eight concrete equalities still need kernel checking; none was compiled in this task.

For the full interval, 70710 squared is at most 5e9, which is strictly below 70711 squared. The independent base sieve gives 7004 primes through 70710. Its completeness is not a theorem of the existing PS3 code. A new base list/completeness proof and generalized mask specification are required. With width at most 32768, pattern length 131072 suffices because `32768 + 70710 < 131072`; the old length 66000 does not. `maskP_spec` (`Prelim/PsiSieve.lean:72`) and `pcL_spec` (line 221) already provide generic interfaces. In particular `pcL k` counts `2^(k+8)` bits. The source `outerT3_spec` (`PsiSieve3.lean:233`) checks its square-root predicate, not the proposed relative-error checkpoint; the latter needs a new recurrence theorem.

## Seed, logarithms, and theta update

The exact source seed is the terminal invariant `SieveTab.stg2813`, `Prelim/PsiSieveMain.lean:28149`, using the final data in `Prelim/PsiSieveData282.lean:88`. It supplies

    999967635190289132 / 1e9 <= theta(1e9)
    theta(1e9) <= 999970323068320645 / 1e9.

This is already inside `1e9 +/- 1e9/24000`. The strict endpoint of the public `sieve_table3` does not remove the separately available terminal invariant. `SmallTab.S = 1e9` (`Prelim/SmallPsiTable.lean:216`) is retained; the logarithm-width allowance is not a replacement denominator. This review reads existing source proofs; it does not claim a fresh build or axiom audit.

The independent script reimplements the rational Taylor checker by a recurrence, using the actual `Small.chkLow`/`Small.chkStep` formulas from `Prelim/SmallMertens.lean` and `Prelim/SmallPsi.lean`. It uses no floating-point logarithm for acceptance. It verifies both the source box at A=1e9 and the candidate box at P=1000250000:

    20723265833/1e9 <= log A < 20723265841/1e9,
    20723515795/1e9 <= log P < 20723515815/1e9.

The second width is exactly 2e-8, below 1e-7. On `(A,P]`, multiplying the count by the lower log at A and the upper log at P gives the correct directions. The source `thS_sub`/`InvT` interfaces in `Prelim/PsiSieve.lean` express this interval-sum update. The resulting bounds are

    L = 250054120041602949/250000000,
    U = 200043834209245433/200000000.

The exact positive checkpoint margins are

    L - (P-P/24000) = 6117937308847/750000000,
    (P+P/24000) - U = 43503622263701/600000000.

Thus the first new checkpoint passes externally. Formal use still requires the eight count equalities, the rational checker evaluations, and their composition with the seed.

## Grid and interpolation

The exact recurrence `a_0=1e9`, `a_(i+1)=min(5e9,a_i+floor(a_i/4000))` has 6439 positive-width windows and 6440 endpoints, including 5e9. Each width is at most `a_i/4000`. Splitting at both checkpoints and 32768-sized blocks gives 125271 blocks. These figures were independently recomputed. They measure workload, not Lean runtime or memory.

Suppose every endpoint satisfies the proposed checkpoint

    a-a/24000 <= theta(a) <= a+a/24000.                 (C)

Using the separately reviewed P6 bound `0 <= psi(v)-theta(v) < 1.4262 sqrt(v)` gives, for `v >= 1e9`, an upper bound `17v/360000`: indeed `31622^2 < 1e9` and `1.4262/31622 < 17/360000`. For `a <= v <= b`, monotonicity and `b-a <= a/4000` then yield

    v-psi(v) <= 7a/24000,
    psi(v)-v <= (15251/45000000)a.

Both coefficients are strictly below `1/2300`. Since `2.7^23 > 5e9` and `e > 2.7`, the full interval has `0 < log v < 23`. Hence these inequalities imply `|psi(v)-v| < .01v/log v`. They apply directly to the real step functions and therefore require no hidden floor-error allowance. The source integer consumer follows by specialization.

The cumulative enclosure-width estimate also checks exactly:

    seed_width/1e9 + 1.387/80000 + 2e-7
      = 20225378031513/10^18 < 1/12000.

Here `log(b/a) <= 1/4000`, `log A > 20` (from `e < 2.72` and `2.72^20 < A`), and `theta(x) <= log(4)x < 1.387x` control bucket uncertainty. The `2e-7` rounding allowance is conservative. This is only a width bound: it says nothing by itself about the center of a future bracket, so it cannot establish (C) for uncomputed checkpoints.

## Accepted scope and unfinished obligations

Accepted: the bounded external pilot, exact rational margins, source-faithful height extension, grid arithmetic, and the implication from all endpoint checkpoints plus P6 to the required finite psi envelope. The author correctly labels each status.

Not completed: all 6438 remaining windows; any new Lean-checked prime count, logarithm, height-extension, or checkpoint theorem; the new complete base through 70710; and a full finite certificate through 5e9. No full-gap run was performed. The optional direct prime-power route is arithmetically consistent: exponents 2 through 32 suffice for `N <= 5e9`, and all root arguments are at most 70710, but it is not needed when P6 is used.

The proposed analytic envelope above 5e9 is outside this review. In particular this audit does not validate the refined low-zero formula, its reciprocal-moment bound, or its finite spectral premises. The finite pilot cannot discharge any of those obligations. The next bounded proof-producing task is the strengthened PS3 characterization and the eight existing-definition `cnt3` equalities, followed by the displayed log and theta checkpoint. No final Goldbach range or binary input has been altered.
