# Independent review of sum-only cyclotomic certificates

2026-11-11. Verdict: PASS for the stated paper acceptance theorem, explicit circuit and six integer schedule totals. No correction is required. This is not a Lean/MM0 implementation, primality-certificate run, complete ladder, optimal-circuit claim or runtime estimate.

Reviewed author files under `work/qrh-blueprint`:

| File | SHA256 |
|---|---|
| `CYCLOTOMIC_SUM_ONLY_CERTIFICATES_2026-11-11.md` | `1289E9B4DFBB20B3FC84BB85CD35A676227DDFBFC4A3266A6FAB4A6CC3C27927` |
| `cyclotomic_sum_only_schedules_20261111.py` | `6DEC8DC6A487F2739C9EC04D290F7F95BC9543E63B6CD8CA0234F9995F13146A` |
| `cyclotomic_sum_only_schedules_20261111.json` | `F30C91250F8210F8FB0600757028C5C3CB629F0EC0144E6AE5AD66D6B582EE14` |

I read the complete note and script, the predecessor grouped-order note and its relevant saved partitions, and the actual least-factor source theorem `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean:38`. The source has SHA256 `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`. The source theorem only implements the existing power-of-two case; the generic cyclotomic argument below remains a new formalization obligation.

## 1. Acceptance and its indispensable guards

Fix a prime divisor r of the claimed odd integer n>1. For a certified prime q and e>=1, let y be the reduction of x^(q^(e-1)). From S_q(y)=0, the polynomial identity (y-1)S_q(y)=y^q-1 gives y^q=1. Thus y and x are units in the residue field. If y=1, the same sum is q=0 in that field, which implies r=q. The explicit q-not-dividing-n guard excludes this case. Therefore y has order q, because its order divides the prime q and is not one.

In particular x^(q^e)=1 while x^(q^(e-1)) is not one. The order of x divides q^e and cannot divide q^(e-1), so it equals q^e. It follows that q^e divides r-1. Applying this argument to the distinct full prime powers gives F dividing r-1. A composite n has a prime divisor r with r^2<=n, contradicting r>=F+1 and n<(F+1)^2. The stricter portfolio condition n<F^2 suffices. Repeated factors of n do not affect this least-factor argument.

For the factor two, odd n already implies 2 divides r-1. This saves the e=1 root only. For e>1, x^(2^(e-1))=-1 and r odd imply exact order 2^e by the same argument. No parity-only replacement for a higher power is used.

Keeping a proved F dividing n-1 is a sufficient economical way to discharge every q-not-dividing-n guard. Dropping that predecessor-divisibility check is allowed only if the nondivisibility guards are otherwise established. A sum congruence and size bound alone are insufficient; the author's cited n=57 example correctly distinguishes that weaker rule. I did not perform a modular candidate evaluation during this review.

For a batch, the modulus must be bound to the exact product M of all claimed candidates. Component congruences modulo M descend to every candidate and prime divisor. The guard is then q not dividing M, or its proof from the per-candidate predecessor equalities. Each factor retains its own strict size bound. Acceptance does not need distinct factors, but producing a CRT witness from roots modulo primes alone does not handle repeated prime powers. The author correctly separates those two claims.

## 2. Polynomial circuit and exact cost

For an even index, multiplying S_m(y^2) by 1+y produces each exponent from 0 through 2m-1 once. For an odd index, multiplying by y+y^2 produces exponents 1 through 2m, and the added one supplies exponent zero. These are coefficient identities over the integers, so specialization to every commutative ring is valid without an analytic or primality premise.

For n>=4 the circuit computes y^2 once, recursively computes the sum at that new base, and uses exactly one further product. The odd coefficient is the already available y+y^2, not an additional product y(1+y). Repeated halving ends at 2 or 3 after floor(log2 n)-1 steps. The base 2 costs no product; base 3 costs one square. Consequently the author's counts of floor(log2 n)-1+epsilon squares and floor(log2 n)-1 other products are correct. Epsilon is determined by the leading two bits. Base n=1 is handled separately.

The circuit never needs y^n as an output. Its omission is precisely why the old pair-output schedule is not the correct cost for this sum-only task. Conversely the circuit retains additions, residue normalization and the input prepower x^(q^(e-1)); it does not claim that those costs vanish.

My independent script reconstructs polynomials iteratively along leading-bit prefixes, rather than importing or calling the author's recursive evaluator. It checks all coefficients for n=1,...,256 and separately reconstructs the count formula. This finite check supports the implementation audit; the preceding coefficient derivation proves the general recurrence. No modular value or prime candidate was evaluated.

## 3. Portfolio totals and fair comparison

I independently reconstructed F=m*200560490130, extracted its full prime powers against the eleven fixed certified factors, checked F^2>10^27, and charged the specified leading-one binary prepower before each odd sum circuit. The accepted totals are:

| m | New squares | New other products | Total | Root coordinates | Inverse coordinates | Old ten-root total |
|---:|---:|---:|---:|---:|---:|---:|
| 160 | 33 | 22 | 55 | 11 | 0 | 70 |
| 162 | 33 | 23 | 56 | 11 | 0 | 71 |
| 165 | 32 | 25 | 57 | 10 | 0 | 72 |
| 168 | 32 | 24 | 56 | 11 | 0 | 71 |
| 175 | 32 | 25 | 57 | 10 | 0 | 72 |
| 180 | 33 | 23 | 56 | 11 | 0 | 71 |

All six sum portions use 52 additions. The factor-two shortcut saves the root in rows 165 and 175. The old comparison is genuinely the saved ten-root grouped partition, with ten aggregate-unit products and one inverse coordinate included. It is not an inflated eleven-root comparator. For m=160 the old 38 squares and 32 other products become 33 and 22, saving five squares and ten other products at the same modulus width. Both allocate eleven coordinates, but the old last coordinate is an inverse and the new last coordinate is another root. Rows 165 and 175 reduce eleven old coordinates to ten.

The difference of fifteen counted products in every row is an explicit-schedule result, not total cost dominance. A square and general product may have different costs; sums, guards, normalization, coefficient provenance, root generation, CRT, serialization and formal arithmetic proofs remain. Arbitrary anchors retain their recursive factor-prime proofs. A mixed sum/unit packet still needs the inverse for its remaining unit components. An all-sum packet does not. Nothing here assumes that enough suitable primes can be found.

The 44-square, one-root Proth branch remains a separate comparator. At large q the sum-only circuit can also cost more than binary q-power plus a unit test. No universal optimality claim follows from the six smooth-factor rows.

## 4. Reproducibility and remaining work

Owned independent files under `work/qrh-campaign/agents/moebius`:

| File | SHA256 |
|---|---|
| `review_sum_only_schedules_20261111.py` | `94F20691507DE7451EAE674D5D832CAEBF3A73A95518976F8F403E61089E9E71` |
| `review_sum_only_schedules_20261111.json` | `21AC19CE521773A3BFE53B8BE6D7137C9D446C8354BE2109D90E4E8E442B0324` |

The script completed successfully. It verified all 256 symbolic coefficient lists, ten prime-index schedules, six factorizations and size inequalities, all per-component prepower charges, every comparison above, and all five predecessor file hashes. It read the frozen grouped receipt `C0E1AAAC2EF8D90CAA841288ACCD5B3938DB981D3C3F3F3AC010CE37B1225BFC`. It neither imported nor executed the author script and did not write any author artifact.

The proof/checker still needs formal circuit semantics, prime-order and product descent lemmas, certified factor provenance, exact arithmetic implementation and a complete coverage certificate. This review accepts the bounded mathematical and schedule claim only. No new formal theorem, successful production witness or timing claim is established.
