# Independent review of the smooth-factor ladder portfolio

2026-11-11. Verdict: **PASS at paper acceptance-rule and exact integer-geometry scope.** No correction is needed to the frozen note. No candidate prime, modular-power certificate, or complete ladder was evaluated. No Lean/MM0 build or implementation was performed.

Reviewed `prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md`, SHA256 `5C49B39D44D432A71F7A5F45E924F6C76E9E173666DB6301EF0469F1AAD5F59A`. Its scalar source is `BF15FD32B8B933DD463159810F84248CCC2DEFF2211F1F285E832DE3DF6B2B01`, receipt `122AD820955BC6753C3DFB5550D3451693848410A295A2EC8B47D61499C72655`. All six frozen input pins in the note match current files. The reviewed data and earlier artifacts were not modified.

## Primality implication and repeated prime powers

Let F have its full certified prime factorization and let p>1. For the conventional formulation, p-1=kF. Fix a prime divisor r of p. The Fermat equality makes a a unit modulo r and its order d divide p-1. For each distinct q dividing F, the gcd condition implies d does not divide (p-1)/q. Therefore the q-adic valuation of d equals that of p-1. In particular it is at least that of F, even when q also divides k. Combining distinct prime powers proves F divides d, hence F divides r-1. A composite p has a prime divisor r with r^2<=p, contradicting p<(F+1)^2.

Thus neither factoring k nor requiring gcd(k,F)=1 is necessary. The usual factored-n-minus-one test has this structure, as also described in [FLINT's Pocklington interface](https://flintlib.org/doc/fmpz/fmpz_is_prime_pocklington.html). This review uses the order argument itself, not a native primality routine as evidence.

The exponent must remove one q, not all of q's powers. For example, the incorrect full-prime-power deletion would accept the composite 9 with F=8 and residue -1: the eighth power is 1 and gcd((-1)-1,9)=1. The correct fourth-power leaf equals 1 and rejects it. The actual portfolio tree has the correct exponents.

For the final supplied-root criterion, the argument is simpler. A supplied x with x^F=1 and every x^(F/q)-1 a unit modulo p forces ord_r(x)=F. The q=2 leaf equal to -1 supplies x^F=1 by squaring and supplies its own unit condition since p is odd. The product of all ten odd-q leaf-minus-one values is a unit exactly when every value is a unit. One modular inverse witness therefore suffices. No check of x=a^k or gcd(x,p) is needed. The producer may still construct x=a^k, but that construction is not part of acceptance.

The complete factor list is essential. Here rad(F)=P because every prime dividing m already divides P. Starting with y=x^m and following the squarefree complement tree produces x^(mP/q)=x^(F/q), retaining all repeated powers. The once-checked global inequality min(F)^2>10^27 and the per-candidate upper endpoint p<=10^27 imply the strict size condition. Candidates outside that domain would need their own bound.

## Product-modulus transfer

For a same-F batch, all congruences and the aggregate unit condition modulo the exact product M descend to every candidate p dividing M. The preceding proof then establishes primality of each candidate. Distinctness is unnecessary for soundness. It matters for the proposed ordinary CRT construction: roots modulo distinct primes alone do not supply roots modulo repeated prime powers. The note correctly requires either distinct candidates, deduplication, or appropriate lifts.

The factor list, product construction, F tag, candidate range and slot partition are mandatory data bindings. A product supplied without this binding does not certify the claimed candidates. A nonempty batch of p>1 has M>1; an empty batch proves only a vacuous conclusion and cannot cover a slot. A concrete implementation should reject empty productive batches or handle them explicitly rather than treating modulo-one acceptance as progress.

The common-root Proth comparator is also valid. For odd 1<p<(2^45+1)^2, a divisor r of p satisfying X^(2^44)=-1 has order exactly 2^45, so r>=2^45+1. This is precisely the existing generic criterion at `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean:38`, SHA256 `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F`. The checked body uses the least-prime-factor square bound. Consequently an exact common product and 44 modular squarings suffice for this primality branch, without offset, progression, base-reconstruction or gcd checks. Interval and complete-coverage checks remain separate.

## Independent integer replay and coverage

The new owned script `review_smooth_factor_geometry_20261111.py` reads only the frozen JSON and uses integer arithmetic. It does not import the author script, run primality tests even on the small factors, or evaluate modular powers. It independently reconstructs:

* all six factor products, size margins, k bounds and exponent outputs;
* all ten tree splits and all eleven exact complement exponents;
* the binary-method square/product counts, including the multiplier m;
* all 63 inclusion-exclusion terms, the period and its 161084 distinct classes;
* the five physical-window tables and their top-window collision counts.

The replay passes. Its script SHA256 is `FB6AE82F0AC786E31313AA052EAAF4672EC105A50CAB5DDCF3581471BDC0F240`; receipt SHA256 is `EE4701C9DC506FE107954A9F7F2C87927F9D51AF147B18148C37F4D5F62A1FF5`. The eleven small-prime facts remain mathematical proof inputs to be checked once in the eventual kernel; this integer replay only verifies their uses and factor products.

The floor/ceiling window bound has an important domain restriction that the final note states correctly: e,D and F are even, so neither endpoint is a lattice candidate. When F divides D, the count is exactly D/F; otherwise the usual floor/ceiling alternatives apply. Without the endpoint exclusion, a closed window of width divisible by F could contain D/F+1 candidates. All inclusion-exclusion intersections also have even lcm, so the same argument applies to them.

The mixed portfolio requires one actual certified prime per physical interval, not one prime from every lattice. Any accepted smooth, Proth or general-prime branch may supply that interval. The intervals are strictly ordered; their prime gaps are at most S+D=B-2. This joins the odd coverage intervals [p+4,p+B] without an odd gap. The initial prime 3 and the last-window bound give the claimed endpoints. All five table rows have S dividing N. The stated floor-index variant for nondivisible N also works because p_K+B>=KS+S+2>N, provided K>=1 and that final bound is actually checked.

The exact union counts are counts of integers only. They establish neither prime existence nor successful witness search in any window. An exhausted portfolio therefore needs fallback or a failed result. Reordering by F cannot omit or duplicate a required slot unnoticed.

## Efficiency consequence and remaining work

The useful logical reductions are now included in the final note: supply x directly, derive Fermat from the minus-one leaf, aggregate the ten unit witnesses, and amortize the fixed factor/size facts. Reproducing x=a^k would add avoidable checked work. The complement tree uses 128 squares and 46–50 other products, plus ten aggregate-unit products, on the actual product modulus. These are operation counts, not timings. The Proth comparison needs fewer such operations at equal group size; the smooth portfolio's possible benefit is avoiding unsuccessful searches or arbitrary-factor certificates.

Whole-product arithmetic acts on up to about 90 bits per factor. Root and inverse payloads, CRT construction, multiplication/reduction proof costs, failed searches, serialization and kernel behavior remain part of the comparison. The present packet establishes no lower end-to-end cost and no prime success rate. Its remaining work is a sound executable acceptance/coverage adapter and actual complete certificate production under the unchanged final theorem and binary-input contract.
