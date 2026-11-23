# Finite-range cost research with variable binary and analytic cutoffs

2026-11-11. The objective is the full ternary theorem from standard foundations, minimizing eventual generation and verification costs in Lean and MM0. This report changes neither the target nor an existing artifact. It uses source inspection, primary literature and small integer calculations only. No Lean/Lake, prime search, function evaluation, benchmark or production scan was run.

The most useful new candidate is a mixed ladder: retain batched Proth certificates on a fixed lattice, narrow their search windows when the binary cutoff falls, and supply separately certified primes in failed windows. This is less disruptive than replacing every rung with a general primality proof. Evaluate it jointly with blockwise binary-existence certificates. Keep the current `B=4e18, N=1e27` construction as a reference; it is not an optimization constraint.

## 1. Exact reduction and endpoints

Let B be an even integer at least 4. Suppose binary Goldbach is proved for every even integer in [4,B]. An odd prime p then certifies every odd integer in

    [p+4,p+B].                                                   (1)

Indeed n-p is even and in [4,B]. Starting with p0=3 covers all odd n from 7 through B+3. For increasing odd prime rungs p0,...,pm, these discrete intervals have no missing odd integer exactly when

    p_(i+1)-p_i <= B-2.                                         (2)

The last odd integer of one interval is p_i+B; the next required one is p_i+B+2. Thus (2), rather than the informal gap<=B, is the sharp adjacent-interval condition for this reduction. If a gap equals B, the odd integer p_i+B+2 is not covered by either adjacent rung. The source uses stronger slack and is safe.

It suffices that pm+B reaches the largest odd integer needing finite verification; the simpler bound pm+B>=N covers every odd integer through N. Together with a proved analytic theorem for every odd n>=N, this gives the full theorem. One does not need to search for a prime above N. A finite cover using extra primes need not be ordered in storage, but its coverage proof must establish the same union property.

`Helfgott/SmallCases.lean:21` implements this at B=4e18, N=1e27, using `3+(n-3)` below B+3 and a certified prime in [n-B,n-4] above it. Binary Goldbach remains an explicit hypothesis there. Full standard-axioms completion must prove it at the chosen B, not merely cite a published run.

The number of odd targets in [7,N] is floor((N-5)/2). Each prime supplies at most B/2-1 of them. Therefore this particular binary-plus-prime-cover architecture requires at least

    ceil(floor((N-5)/2)/(B/2-1))

prime cover intervals, counting p0. This is an architecture-specific lower bound, approximately N/B, not a lower bound on every possible ternary proof.

## 2. What the existing ladder actually fixes

The inspected checker uses

    F=2^45=35184372088832, S=111616, 0<=t<=2047,
    p_i=(S*i-t_i)*F+1.

`Ladder/Spec.lean:38,58` derives primality from a modular certificate and p<(F+1)^2; the sufficient parameter condition is 1<=S*i-t_i<F. `Spec:198,287` also fixes the exponentiation and rung-index bounds, including i<2^28. `Check.lean:61` checks 32 rungs modulo their product. There are 128 such blocks in a chunk of 4096. `LadderHints.lean:31-53` searches untrusted offsets, requiring p mod 3=2, sieving the first 512 offsets and then trying through 2047. Its failure is explicit.

More generally, retain F and use W candidate positions per window, so w=W-1 is the maximum offset. If every window contains a certified odd prime in

    [(S*i-w)*F+1, S*i*F+1],

then a sufficient coverage condition is

    (S+w)*F+2 <= B.                                             (3)

This follows either from (2), when the selected primes are ordered, or directly from the overlapping cover intervals using the lower bound for each next window. Overlapping windows do not require the chosen primes themselves to be distinct. Start at an index with S*i>w; a suitable first index has S*i<=w+S, so its upper endpoint is below B+1 under (3), joining p0=3. The final window must meet the terminal inequality in section 1.

For the existing W=2048, any positive S requires

    B >= 2048*F+2 = 72057594037927938.

Thus merely changing S cannot reach B=1e16 or 1e15. The old 28-bit rung-index bound also fails much earlier than an aggressive shrink in B. The current F is near the smallest power of two whose square exceeds 1e27. Reducing F uniformly loses the current primality proof near the top.

The following integer calculations illustrate the fixed-window design. They assume the missing window certificates can actually be produced. The rung column is ceil(N/(S*F)) at N=1e27, a conservative geometric scale, not a proved available ladder or an exact minimal count.

| B | floor((B-2)/F) | Largest S with W=2048 | Rung scale |
|---:|---:|---:|---:|
| 1e15 | 28 | none | none |
| 1e16 | 284 | none | none |
| 1e17 | 2842 | 795 | 35,750,577,900 |
| 2e17 | 5684 | 3637 | 7,814,602,538 |
| 1e18 | 28421 | 26374 | 1,077,641,216 |
| 4e18 | 113686 | 111639 | 254,585,848 |

The last row is a newly calculated maximal stride, not the source's S=111616 or its existing certified data. The source public ladder uses 254638308 rungs. Neither this table nor existing certificates establish all windows for a new stride.

The README reports approximately 15 microseconds per rung for search and 55 microseconds for kernel checking, about five single-core hours in total. Those are source-reported measurements for this exact architecture. They cannot be reused as measured rates after changing S, W, F, batch size, bases, index lengths or primality fallback. In particular, the source computes `(B mod p)^t` as an integer before taking its remainder. Increasing t changes intermediate sizes; a generalized checker should compare this with modular exponentiation rather than assume constant work.

## 3. Three ladder constructions worth comparing

### Narrow fixed windows with certified fallback

At B=1e16, equation (3) permits W=64 with S=221, or W=128 with S=157. W=256 leaves only S=29, so its lower failure rate would have to compensate for many more rungs. At B=1e15, W=8 permits S=21 and W=16 permits S=13. These are exact design choices, not prime-existence assertions.

For the especially simple source-style choice starting at i=1, require S>=W. The coordinator's exact-only `hybrid_ladder_tradeoff_20261111.py` uses this stronger condition and K=floor((N-5)/(S*F)). It gives K=181029996372 for B=1e16,W=128,S=157, and K=90804183483 for B=2e16,W=256,S=313. I inspected its endpoint and cost-identity arguments without rerunning it. The S<W examples above instead require the later first index and base join established in section 2; they are not accepted by that script. The table in section 2 uses a conservative ceiling scale, not this exact source-style K.

Search the ordinary Proth candidates first. On failure, supply any separately certified prime in the same prescribed window. Verify both its primality and its interval membership. The coverage theorem is unchanged. If even that search fails, the producer must change the local covering schedule with a checked join, or reject; it cannot silently enlarge a gap. The source's fixed-base-3 search uses only one residue class of k modulo 3. Allowing other small bases can recover more Proth primes, but requires a new certificate layout and measured batching costs.

A block can retain modular sharing despite fallback holes: build the product over its Proth candidates, advance the common residue along every lattice position, and test only the Proth-tagged positions. Separately check the other prime certificates. Empty Proth products and all-fallback blocks need explicit cases. Alternatively group by a small set of bases; this preserves an arithmetic progression or records the exact skipped index increments. The proof must bind each tag to the correct rung. No independence or pairwise coprimality of the product factors is needed merely to reduce a congruence modulo each factor.

Let R be the number of windows, f the fallback fraction, cP the ordinary per-window generation-plus-check cost after amortized batching, and cG=r*cP the corresponding fallback cost, with r>1. Include failed Proth search in cG, or charge it separately. Then

    C_ladder = R*cP*(1+f*(r-1)) + setup + assembly.              (4)

If the competing design costs C0 in total, and the new binary/setup/assembly cost is Cother, the new design wins only if

    f < ((C0-Cother)/(R*cP)-1)/(r-1).                          (5)

A nonpositive right side rejects the proposal even with no fallback. A right side at least one means the stated comparison is not limited by f. Apply (4)-(5) separately to generation and to each proof system's checking costs before combining them. They are useful falsifiable tests without inventing a rate for a 90-bit general-prime proof.

Prime-density heuristics can propose W but cannot establish f, bound the largest exceptional run, or guarantee a certifiable prime in every window. A window only a few dozen lattice positions wide is materially different from the current 2048-position search. No heuristic is used as an acceptance condition here.

### Adaptive rungs and variable power-of-two bands

Instead of fixed windows, choose the next certified prime near p_i+B-2 and explicitly check the actual gap. This removes unused window slack and can approach the N/B cover scale. It loses the simplest constant-stride residue recurrence; variable increments require additional modular powers, grouping or another batch construction. Adaptation does not imply every rung needs a general certificate: keep Proth primes ordinarily and use certified fallback locally.

This is an established algorithmic direction. Helfgott–Platt's primary paper uses Proth search with a general-prime fallback, a separate checker, and an independent check of fallback primes. Its published computation reaches above 8.875e30 with the existing binary result through 4e18. It reports about 40000 core-hours and 130917 general-prime fallbacks. These results show why an all-Proth existence assumption is unnecessary, but do not measure a modern Lean or MM0 checker. [Helfgott–Platt, §§2–5, arXiv v2](https://arxiv.org/pdf/1305.3062).

Vary F=2^f by height band to satisfy k<F for each p=kF+1. For example F=2^40,2^42,2^44,2^45,2^47 respectively has square exceeding 1e24,1e25,1e26,1e27,1e28. The actual terminal prime and search-window overshoot must also fit; these are not just bounds on N. Lower bands can use denser lattices. Raising f above its necessary size adds no new candidates to the smaller power-of-two lattice.

### Smaller powers with factored p-1 certificates

One may reduce F and certify more factors of k, using a general Pocklington criterion. This requires actual factor certificates, modular/gcd checks and the theorem's full hypotheses. It is not the current Proth checker. Forcing a fixed extra divisor d so that F*d>sqrt(p) leaves the combined progression spacing F*d at least about sqrt(p). Thus a single forced progression does not automatically solve the density problem. Several progressions, factoring variable k, or a genuinely general primality certificate are different designs to cost explicitly.

The useful first B range for extending the old wide-window checker is roughly 2e17 to 1e18, with 4e18 as a reference. The higher-potential narrow-window/fallback comparison should include 1e16 and then 1e15. These are structural test ranges, not a claim that the optimum lies there. At the top near 1e27, B=1e15 contains only 28 steps of the 2^45 lattice. Below F+2 a ladder made solely of distinct primes on that lattice cannot meet (2). A different primality architecture would then be essential.

## 4. Binary existence certificates should also change with B

Do not charge the entire historical minimal-partition/statistics computation as a necessary proof cost. The author's project page explicitly distinguishes finding one partition from its chosen minimal-partition search and records additional statistics. This does not quantify the savings of omitting them. [Oliveira e Silva's project description](https://sweet.ua.pt/tos/goldbach.html).

The local sparse-anchor construction is a credible alternative. Write E=B/2. For a block of L even targets and r>=1, use

    n=2(rL+t), 0<=t<min(L,E-rL+1),
    q_i=2rL-(2s_i+1), 0<=s_i<=D,
    p_i(t)=2(t+s_i)+1.

Then n=q_i+p_i(t) exactly. Certify the anchor primes q_i and a shared prime bitmap for indices j in [0,L+D), representing 2j+1. Clear 1, handle 2/base cases, and check that every target is covered by some shifted prime bit. The initial range 4<=n<2L requires its own smaller construction. If E is divisible by L, the final block has width one and must not be omitted. A source tile [a,b) needs the halo [a,b+D).

This proves existence, without proving that a chosen partition is minimal. A predetermined number of anchors is not a theorem: unresolved targets need more certified anchors or separate decompositions. A sufficient source bitmap need only mark actual primes; it need not mark every prime, provided coverage succeeds. A sieve-based proof must nevertheless justify every marked survivor as prime, not only every cleared bit as composite.

The same masks admit two useful checks. Shift/OR operations are efficient native candidates. Radix packing reduces coverage to a large multiplication/addition/mask equality: coefficients count coverings, a radix exceeding twice the anchor count avoids carries, and the added half-radix-minus-one digit tests positivity. Prime interpretation, offsets and complete target ranges are separate obligations. The local `PACKED_REPORT` and `FORECAST` contain actual fixtures and Lean arithmetic checks, but do not supply the full generic Goldbach checker. The MM0 template timings there use a schematic arithmetic library and conclusion `ok`; they are not completed PA coverage proofs.

Useful existing component observations are the Lean kernel's 3.400 ms for the 262144-target packed fixture, native FLINT's 0.608 ms for shift/OR on the same fixture, and 55.08 ms CPU per anchor for a complete 32-root Lean Lucas–Pratt cohort including auxiliary declarations. These are specific measured components on the earlier host. The first excludes generic prime/coverage semantics, the second is not formal checking, and the third is not a measurement of the 90-bit ladder primes or a universal rate for smaller B. Repeated MM0 templates and native optimized-checker experiments cannot fill these gaps by multiplication alone. The earlier headline year estimates are not evidence for a new B,N choice.

L is another optimization parameter. Larger L amortizes anchor certificates but expands the source table and lowers its prime density. Streaming can avoid a giant resident table but must preserve halo and certified factor-cache dependencies. It does not erase sieve work. Reuse the source across many outer blocks rather than regenerate it for each one.

## 5. Joint cost model for B and N

For each proposed analytic route a and verifier v, retain a vector of generation work, checking work, storage, peak memory and engineering obligations:

    C_v(a,N,B,L,W,...) = C_analytic,v(a,N)
                      + C_binary,v(B,L,...)
                      + C_ladder,v(N,B,W,...)
                      + C_join,v.

Here C_analytic includes the finite spectral work required by that route and threshold. For a word width z, average checked mask count d, and A anchors per outer block, a useful binary decomposition is

    C_binary ~= C_source(L+D)
              + ceil(B/(2L))*A*C_anchor(log B)
              + B/(2z)*d*C_word(z) + C_exceptions + C_assembly.

The generator has a separate search term. For packed checking replace the mask term by the actual large-integer multiplication schedule and input-expansion costs. Use observed distributions and maximum failures later, not the assumption that A,d are globally constant.

For K Proth rungs per batch and prime bit length ell, the product modulus has about K*ell bits. A generalized modular checker pays product construction, O(f+log S+log i0) initial modular operations, approximately K updates on the product modulus, reductions to the individual factors, and offset powers. If the offset powers are computed modularly, their operation count is O(log W) per rung. Current literal integer powering is a different schedule. Let M_v(b) and D_v(b,b') denote the verifier's checked multiply/reduction work; these costs, not merely the number of modular operations, determine the useful K. Batch size 32 is a measured source choice, not a universal optimum.

The toy model a*B+c*N/B has optimum B=sqrt(c*N/a) and minimum 2*sqrt(a*c*N). It illustrates why jointly optimizing B changes the N tradeoff. It is not a forecast: a and c depend on bit lengths, fallback frequency, proof representation and both generators. Combining historical native binary years with the current 55-microsecond kernel rung rate would mix incompatible costs. The old headline Lean/MM0 year estimates are not reused here.

N is not freely replaceable in the analytic proof. `Helfgott/Inputs.lean:56-126` specializes x>=4.9e26 to n>=1e27. Lowering N requires new valid major/minor/nonprime estimates and all-range numerical coverage. Raising N preserves the existing implication but only reduces spectral work if stronger x-decay is actually traded for weaker finite inputs. For a term proportional to x^(beta-1), decreasing x by ten multiplies that term by 10^(1-beta). The finite ladder reduction alone cannot determine the best analytic threshold.

A useful first analytic comparison is the current N=1e27 against a larger N such as 1e28 with explicitly relaxed spectral requirements. A smaller N such as 1e26 is a research candidate only after its analytic inequalities pass. Under the toy optimized-B model a hundredfold N increase costs tenfold in the finite component, rather than hundredfold; real fallback and lattice changes can alter this conclusion. Select N by the complete cost difference, not by a wish to minimize either spectral height or the ladder alone.

## 6. What transfers to MM0, and what remains unpaid

The mathematical DAG transfers: Proth/Pocklington criteria, modular residues, product divisibility, exact prime-cover endpoints, sieve soundness, bitset coverage and finite range composition. Shared small-prime/factor certificates and batch products should be facts proved once, with typed indexed references. No rung needs an independent full primality library or every modular multiplication expanded as a separate declaration.

Lean's inspected implementation has native big-integer arithmetic in kernel reduction. Stock MM0/PA needs arithmetic theorems and a concrete proof representation; the old `ok` templates do not provide that library. Product-modulus batching changes the relative burden of big multiplication/division versus many small operations, so a Lean-optimal K need not be MM0-optimal. Standard-axioms claims must also discharge the interpretation of bit operations and every prime predicate.

A proved-admissible arithmetic accelerator may retain the foundations while changing the MM0 verifier boundary. It still needs a proof-preservation/implementation argument and an exact input binding; an observed fast C run is not an ordinary stock MMB proof. Give Lean the same implementation latitude if that is the comparison. Certificate generation, library construction, serialization, checking and final shard assembly remain separate charges. Hashes bind artifacts but do not prove them; cached or distributed results need sound composition.

## 7. Concrete go/no-go questions

1. **Does a narrow-window mixed ladder reduce total cost?** Freeze B=1e16 with W=64 and 128, and the B=2e17 wide-window reference, then propose bounded high-end and band-boundary tests. Measure ordinary/fallback generation and complete checking in each target architecture, preserving failed windows. Require exact coverage, new index bounds and all fallback primality facts. Apply (5), including failed-search and batching costs. If fallback work exceeds the threshold, widen B/W, add base groups or reject that design. A successful sample estimates cost; only the eventual complete certificate establishes the full ladder.

2. **Can binary checking retain its bulk advantage at the smaller B?** For each B candidate, compare at least two L values, certify the source and actual anchor primes, and prove a whole block including an exceptional target path and a boundary join. Count unique checked operations and library dependencies, not just native OR time. Reject a projected saving that disappears after prime provenance, source extraction or assembly is included. Preserve the full [4,B] target and a terminating fallback strategy; no fixed 512-anchor guarantee is assumed.

3. **Does changing N save more spectral work than it adds finite work?** Require an explicit analytic input/output table for each N, including final positive Goldbach margin and the complete finite spectral domain. Compare the resulting C_analytic difference with binary-plus-ladder costs after reoptimizing B. No N change is adopted solely from monotonicity of one error term. First complete the reusable finite checker libraries; their measured cost functions will make this decision substantially better than a fixed per-rung extrapolation.

These are proposed research tests, not authorization to run them. The cheapest credible plan at present is to preserve the reusable reduction, develop a mixed batched ladder and an existence-only binary block checker, then choose B and N from their complete costs. The mathematical full-range target remains unchanged.

## Source pins

All paths are relative to the workspace. Source and existing experimental reports were read, not executed.

| File | SHA256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Main.lean` | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean` | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| `work/ternary-goldbach/LadderHints.lean` | `3AA4E7D3357E5D544288249ED13616B3D9F9151C21D1DAE82AEFD7355C53505D` |
| `work/ternary-goldbach/README.md` | `D884FCAD91275B30AED6A96223503EF1ED5E3B234B8FAFD85D095CDCE7C5C3D7` |
| `work/ternary-goldbach/TernaryGoldbach/Helfgott/Inputs.lean` | `5680D400F0A1795B984BBDFFA863DBF4F721576B3BE673155E0883F0C5D64B83` |
| `work/mm0-efficient/SCOPE.md` | `9864941BD71B90706032B21D202E3D9A5043B2E63EB9CBE699EBAA073AE8DC63` |
| `work/formal-goldbach-bench/prime-cover/PACKED_REPORT.md` | `B0C0E3431ECD29273D053115DCB2433FBC932FB29DFB85A0167164FB536182CA` |
| `work/mm0-efficient/soundness.md` | `C967F8059920C80635238FC2955C9D4FAD55327B26B1BAB6F2746F7440661FD8` |
| `work/formal-goldbach-bench/FORECAST.md` | `5B2F23382BA1A950D6BD79707E2CE45DB912B196D0117CC1C0E3E923D272B262` |
| `work/formal-goldbach-bench/architecture.md` | `81B26063AD5F60DF8CEC8B1174C2FC3DA5F8234CFB13DF746FF9BB952318D3A9` |
| `work/qrh-blueprint/hybrid_ladder_tradeoff_20261111.py` | `C06D1AAE3FDD3C7E197074A41CEB7C7573F5155E908446EAFD891862CFFB3239` |
| `work/qrh-blueprint/hybrid_ladder_tradeoff_20261111.json` | `0673A7389EFD85EFF7B4988F45D78C46B39B82F89EE646484DF039400C9EE28A` |

The historical `work/formal-goldbach-bench/FORECAST.md` and `architecture.md` were also read for component evidence and limitations. Their headline estimates are not adopted as current end-to-end forecasts. The published primary ladder paper and the binary author's project page are linked above. No fresh performance measurement is claimed.
