# Expected-cost planning for Proth and smooth-factor ladders

2026-11-11. Research advice under explicitly stated probability assumptions. The arithmetic below checks those models and finite lattice geometry only. It is neither observed prime data nor a theorem about prime availability. No candidate primality test, prime search, analytic evaluator, Lean/MM0 build, declaration, or source edit was performed. Old reports remain unchanged.

The first candidate to compare is an adaptive, common-root Proth chain with a bounded smooth-factor fallback stage. Also retain direct and indexed Proth checking as backend alternatives. Do not promote the entire ladder to smooth-factor certificates merely because its candidate density is higher. Conversely, do not dismiss smooth fallback using only its heavier successful-certificate cost: it can avoid costly general-prime factor discovery. The decision depends on search failures, actual progress, root construction and checking at the actual group widths.

## Exact geometry and acceptance stay authoritative

Keep N=10^27 and F2=2^45. The earlier fixed Proth layouts are:

| B | W | S | Required slots K |
|---:|---:|---:|---:|
| 10^16 | 128 | 157 | 181029996372 |
| 2*10^16 | 256 | 313 | 90804183483 |

Their window is `[ (Si-W+1)F2+1, SiF2+1 ]`, of width D=(W-1)F2. All ordinary, smooth and general fallback records must prove an odd prime in that same window if these K values are used. The portfolio author's alternative D=B/2-2 windows have different K values; their top-window counts cannot be inserted into this table.

The separately frozen adaptive contract instead starts from a proved prime, accepts increasing primes with every gap at most B-2, and finishes with last_prime+B covering the target. A same-F2 step permits H=floor((B-2)/F2) lattice increments, hence H=284 or 568. The gap proof and final endpoint must be checked on actual records. A probable prime, exhausted search, omitted slot, or average gap cannot satisfy either contract. General fallback has to produce an actual prime with a complete accepted certificate within the required interval. This report proves neither that every small window has such a prime nor that every fallback search terminates within a practical budget.

The smooth portfolio is F=mP, P=200560490130, with m in {160,162,165,168,175,180}. Its factors are the eleven primes through 31. Every F^2>N. The exact common period is 1000716621552648000 with 161084 distinct residue classes in the union of the six `1 mod F` lattices. Intersections are `1 mod lcm(F_i)`, so a 63-term inclusion-exclusion formula counts collisions exactly. The average union density is

    d_S = 161084 / 1000716621552648000.

The six separate list densities overcount this union by the exact fraction 2439/25451 of their sum, about 9.6 percent. This is a residue-lattice statistic, not a prime statistic. The Proth/smooth intersection density is also computed exactly by replacing each subset modulus M by lcm(F2,M). A deduplicating producer must test each repeated integer once and may later choose its cheapest valid F certificate.

## The declared availability model

For a fixed arithmetic progression `p=1 mod F` near x, use the planning assumption

    rho_F(x) = F / (phi(F) log x)

per raw candidate. This is an extrapolation of average prime density to very short windows and large moduli. No uniform prime-number theorem in the present regime is being asserted. Let

    R31 = product_{ell<=31 prime} ell/(ell-1)
        = 86822723/13271040,

which is about 6.54. Proth has model probability 2/log x; every smooth F in this portfolio has R31/log x. Changing powers of these eleven factors does not increase this latter ratio.

A first model further treats candidate primality events as independent Bernoulli events. For n candidates it predicts empty-window probability

    f(n,rho)=(1-rho)^n.

All numerical probabilities below are conditional on this model. They use the rational bracket 62<log(10^27)<63 and exact rational powers. They are top-range planning scenarios, not rigorous worst-case prime bounds over the entire ladder. The rare failures in lower ranges are not controlled merely by the heuristic increase of rho there.

Sieve conditioning must be counted once. A Proth candidate's average survival fraction through the odd primes <=31 is 2/R31. Conditional on surviving that same wheel, its heuristic prime probability becomes R31/log x, equal to a raw smooth-F candidate. Thus smooth candidates offer more pre-sieved candidates per physical interval, not a second independent multiplier after Proth has already been sieved. Extending the producer sieve beyond 31 modifies both survivor counts and per-survivor costs. Screening may eliminate much of Proth's apparent per-raw-candidate disadvantage cheaply.

For a combined Proth/smooth model, use a common sieve-conditioned candidate universe and exact deduplication. It is inconsistent to assign a shared candidate both the unconditional Proth probability and an independent smooth probability. At the period-average level the combined mean intensity is

    D/log x * [2/F2 + R31*d_S - R31*d_intersection].

This equation remains a heuristic prime-intensity calculation; only the lattice densities in it are exact. At a concrete window, use actual residue counts rather than period averages. Even exact collision counts do not prove independence of distinct candidate primality events.

## Sensitivity in the same fixed windows

For the original Proth windows, exact inclusion-exclusion gives conservative all-window smooth candidate bounds without enumerating their huge period. For one F=160P the counts are 139..140 and 279..280. For the six-F union they are 689..752 and 1412..1475. These bounds allow arbitrary endpoints and are intentionally slightly wider than bounds using a particular parity phase.

The table gives conditional empty-window probability ranges. The `quarter density` column replaces rho by rho/4 while retaining independent trials. It is a stress assumption, not an asserted lower bound for actual prime density.

| Window | Branch | Nominal independent model | Quarter-density model |
|---|---|---:|---:|
| B=10^16, W=128 | Proth | .0150 to .0161 | .3547 to .3607 |
| same physical window | one smooth F | 1.65e-7 to 2.41e-7 | .0236 to .0259 |
| same physical window | six smooth F | less than 1e-18 | 1.85e-9 to 1.35e-8 |
| B=2*10^16, W=256 | Proth | .000226 to .000259 | .1258 to .1301 |
| same physical window | one smooth F | 2.75e-14 to 5.19e-14 | .000561 to .000650 |
| same physical window | six smooth F | less than 1e-18 | less than 7.6e-17 |

These are separate branch availability models. Multiplying the Proth and smooth failure probabilities to price a fallback stage additionally assumes appropriate conditional independence after deduplication and common sieving. That stronger assumption is not established here.

For scale, the nominal independent Proth model predicts up to about 2.914 billion empty slots in the first fixed layout and 23.516 million in the second. One smooth F alone predicts about 43549 or fewer than one respectively, at these particular model parameters. A statement such as “less than one expected failure” does not mean zero failures or guarantee a complete ladder. The arithmetic receipt stores directed bounds, not rounded zero probabilities.

Density errors are not the only risk. In a simple four-candidate perfectly correlated block stress model, the effective exponent is about n/4 while each candidate retains its marginal probability. The modeled empty probabilities become roughly .35 for W128 Proth and .020 to .025 for one smooth F. For the six-F union they reach about 6.5e-9 in the smaller window. Real prime correlations are not this block process; the example shows why a large mean candidate count alone does not justify a tiny fallback tail.

More seriously, a common bad-window probability delta imposes a failure floor at least delta regardless of how large the independent-trial mean is inside ordinary windows. At roughly 10^11 rungs, delta=10^-8,10^-6,10^-4 corresponds to roughly 10^3,10^5,10^7 affected rungs. Such a common component can arise in a planning model from residue effects, insufficient witness search, or a systematically unsuitable subrange. It is not established to occur at these rates. It must be allowed in cost sensitivity instead of extrapolating an exponentially tiny nominal tail.

Without dependence information, fixed marginal prime probabilities do not determine empty-window probability. Perfect positive correlation can leave that probability close to 1-rho. With no prime-distribution assumption at all the deterministic planning fallback fraction can be 1. A viable proof algorithm always keeps the exact failure path, even if its expected use is very small.

## Adaptive progress changes the comparison

Searching backward from the largest allowed same-F2 increment gives deficit d=H-(k_next-k). In the independent model, with r=1-rho,

    P(no success)=r^H,
    E[d | success]=r/rho - H*r^H/(1-r^H),
    E[number of raw tests]=(1-r^H)/rho.

At log x=63 the conditional mean deficits are about 30.47 and 30.50 for H284 and H568. The conditional mean successful progress is about 8.9203e15 or 1.89116e16. Model empty-step probabilities are .0000903 to .00010495, or 8.15e-9 to 1.102e-8. These differ greatly from W128/W256 fixed-window probabilities because the searched intervals differ. They do not prove an adaptive total rung count. General-fallback progress, changing x, initialization and boundary steps still need inclusion.

For adaptive selection compare cost per expected progress, with the full joint law of cost, deficit and fallback. A policy that finds cheaper Proth primes farther from the endpoint may require more rungs than one that selects a closer smooth prime. A fixed K multiplier cannot price that tradeoff. Nor may the same-F H formula be reused after a general prime changes the lattice phase without recomputing the exact permitted k interval.

## Witness production and the current checker frontier

The newest common-root formats remove base choice from checker grouping. Proth acceptance binds M to the candidate product and checks a supplied X by X^(2^44)=M-1 modulo M. The fixed candidate bounds then prove each factor prime. There are 44 product-modulus squares, plus product construction, decoding, bounds and coverage. No checked a^k initialization, base tag, offset power or per-factor gcd is required in this format. These are paper algorithms, not measured implementations.

A same-F smooth group supplies X and one aggregate inverse. Its fixed tree uses 128 squares, 46..50 other tree products, and ten aggregate-unit products modulo the actual M. The q=2 output is -1; the ten odd-q outputs minus one have a product with a supplied inverse. The order argument proves each bounded factor prime. It needs no checker replay of X=a^k. Both formats still pay for generation of useful roots, CRT construction, source-factor proofs and serialization.

For n factors, M and X have at most 90n bits. The smooth inverse adds another numeral of that size. Direct root payload is therefore roughly up to 90 bits per Proth factor or 180 per smooth factor before encoding overhead; intermediate arithmetic proof witnesses are additional. Taking n=1 gives a direct Proth root checker with 44 squares at a 90-bit modulus and no CRT production. Grouping by base is unnecessary for these common-root formats, but grouping by F remains relevant for the smooth tree. Small-base residue selection still matters for producer work. The old grouped-progression cost table remains a valid alternative, not the mandatory cost of the new root checker.

Let S(b), M(b), R(b) be backend-specific costs of a modular square, product, and its reduction/proof work at b-bit modulus. At equal group size the new Proth arithmetic vector is 44 squares, whereas smooth adds 84 squares and 56..60 other modular products. This is not a runtime ratio. Actual group sizes, square/product implementations, proof sharing, product trees and sparse F groups can change the comparison. Direct 90-bit verification may still beat wide product arithmetic in an ordinary-rule MM0 proof representation. The existing 55-microsecond rung observation does not calibrate either new common-root format.

There is also an exact finite-group witness proportion, separate from prime availability. Conditional on an actual prime p=kF+1, uniform a among the nonzero residues gives x=a^k uniformly among the F-th roots of unity. The proportion giving order exactly F is phi(F)/F. It is 1/2 for Proth and 1/R31 for this smooth portfolio. Thus truly uniform independent root trials would require means 2 and R31, respectively. After deliberately selecting a quadratic nonresidue for the q=2 condition, the remaining smooth success proportion is 2/R31, with mean R31/2. These are group-theoretic sampling facts, not frequency claims for a fixed list of small bases.

Early rejection and shared partial powers can reduce failed smooth trial cost; replaying the whole tree for every failed base is only an upper schedule. Distinct bases for different q are another sound certificate option, with different sharing and payload costs. A producer must record candidate screening, unsuccessful base trials, inversions and CRT work separately from the final accepted check. Uniform-base expectations cannot silently be applied to a deterministic small-base search.

## Expected-cost decision equations

For a fixed-window policy write g_P for expected Proth generation cost, f_P for its failure probability, and c_P for successful checking/proof cost. Let a conditional smooth stage have generation g_S, success probability 1-f_{S|P}, and checking cost c_S. Let G include the conditional generation and complete-check cost of general fallback. Then the simplified per-slot expectation is

    g_P + (1-f_P)c_P
      + f_P [g_S + (1-f_{S|P})c_S + f_{S|P}G].

This formula requires each conditional expectation at the actual selected windows, not a period-average prime density. It also omits shared setup only if that setup is separately charged. A smooth stage is beneficial against immediate general fallback precisely when, under the same conditional model,

    g_S < (1-f_{S|P})(G-c_S).

Adding another F has the analogous test on the failures remaining after earlier stages. It can be rational to search only one or two smooth lattices even when the full union has much smaller modeled failure probability. Conversely, a tiny general-fallback rate can still dominate expected work if its certificate-generation tail is expensive. Factor-discovery costs and hard instances must be included, not replaced by a typical successful generic certificate.

If equal-progress trials were independent with fixed success probabilities, ordering two candidate tests by generation cost divided by success probability minimizes expected search work. Here progress, checker type, shared sieving, root caches and correlated residue classes violate that simplification. Use it only as a baseline scheduling model. Cache every successful residue/root so switching certificate formats does not repeat work unnecessarily.

For adaptive chains use a renewal-style objective E[cost]/E[advance] only under a declared stationary approximation. The real target changes with x, so the final estimate should sum or integrate local cost/progress scenarios and explicitly handle the endpoints. Checking work is proportional to the actual chosen certificate records and groups, not unsuccessful searches. Generation work includes all of them.

## Recommended bounded comparisons and rejection tests

1. Compare adaptive common-root Proth alone, Proth plus one smooth F, and Proth plus a bounded six-F fallback on identical physical intervals and backend settings. Keep a complete exact general-certificate path. Measure generation and checking separately, including failed trials, actual gaps and source/group sizes. These future tests require separate authorization; none was run here.
2. Reject an all-smooth recommendation unless its gain in progress and avoided fallback exceeds its heavier root production, checker and payload costs under both nominal and stressed conditional failure rates. Compare direct small-modulus proofs as well as common-product proofs. A native throughput winner need not minimize Lean or MM0 standard-axioms work.
3. Test the failure tail before extrapolating billions of slots. Stratify by height and lattice phase; keep exact collision/sieve counts and distinguish no candidate prime, no found root, and failed general certification. Zero observed failures in a small experiment does not establish a probability below 1/K. Any confidence calculation itself needs a sampling/dependence assumption. Preserve a nonzero bad-window component in cost sensitivity until data justify narrowing it.

The present models favor investigating cheap Proth first and smooth fallback before expensive arbitrary factorization. They do not select a final B, F portfolio, batch size, or expected runtime. The dominant uncertainty is the joint distribution of search cost, progress and rare fallback work under the actual arithmetic/proof backend, rather than the exact period-average candidate count.

## Evidence and provenance

The historical [Helfgott–Platt ladder paper](https://arxiv.org/pdf/1305.3062) uses a backward Proth search, small-base selection, sieving and general-prime fallback with independent primality checking. It supports this algorithmic comparison. Its reported rates and timings concern another domain and implementation and are not transferred here.

| Artifact | SHA256 |
|---|---|
| `prime-estimates/SMOOTH_FACTOR_LADDER_PORTFOLIO_2026-11-11.md` | `5C49B39D44D432A71F7A5F45E924F6C76E9E173666DB6301EF0469F1AAD5F59A` |
| `prime-estimates/smooth_factor_ladder_geometry_20261111.py` | `BF15FD32B8B933DD463159810F84248CCC2DEFF2211F1F285E832DE3DF6B2B01` |
| `prime-estimates/smooth_factor_ladder_geometry_20261111.json` | `122AD820955BC6753C3DFB5550D3451693848410A295A2EC8B47D61499C72655` |
| `major-constants/EFFICIENCY_ADAPTIVE_PRIME_CHAIN_2026-11-11.md` | `77ADA365011EA6069D3D2F8131950AD65ECAD285400BBD5C307C7444F0093785` |
| `independent-feasibility/EFFICIENCY_MIXED_LADDER_2026-11-11.md` | `9AACAF7FC0B5DCD9145AB3006D40248A2C7D57319677C57600890D21E5F75783` |
| `work/qrh-blueprint/MULTIBASE_PROTH_RESEARCH_2026-11-11.md` | `555DA959A4591205291DB862E1FE1FBA885545C4E3EC920D2FDF48F8A200D337` |
| Owned `heuristic_ladder_portfolio_20261111.py` | `D191900C461A31C1623C27D73BDF6CC217A4206F422BB2974E39D4575DFBB6CE` |
| Owned `heuristic_ladder_portfolio_20261111.json` | `FA84A4017DFF53B5CFE889262480ED8EDC11F5F9FFE2F8099DE334A636D27380` |

Agent paths are relative to `work/qrh-campaign/agents`. The new script independently reconstructs the finite union period/density, same-window bounds, exact group proportions and rational model probabilities. It performs no candidate tests and imports no producer. Its PASS means only that the declared finite/model arithmetic completed. I read the frozen adaptive contract's coverage, index and supplied-root sections and verified its pin, alongside the full smooth portfolio note. Their independent acceptance reviews remain separate from this heuristic research advice.
