# Operation inventory for a mixed Proth ladder checker

2026-11-11. Source-level design and exact integer counts only. No new checker, Lean declaration, build, prime search or timing run is claimed. Existing source and reports remain unchanged.

The two proposed strides almost exactly trade fewer stride-exponent bits for more index-exponent bits. The old eager initialization schedule has 89 modular-square steps; each proposed schedule has 90. This supports testing the ordinary batch architecture at the smaller binary cutoffs. It does not support carrying over the measured per-rung time: there are many more blocks, the offset computation changes, and fallback costs and proof construction remain unmeasured.

## 1. Source and parameters

The inspected bodies are `Ladder/Check.lean:27-89` and `Ladder/Spec.lean:16-80,92-245,263-301`. `Check` contains the actual Nat recursion, products, exponentiations and tests. `Spec` proves divisibility, modular invariants and the specialized primality criterion. The current code hard-codes S, hint widths and exponent loop bounds. The following are proposed specializations, not existing parameterized Lean declarations.

All designs use F=2^45, N=1e27 and candidates p_i=(S*i-t_i)*F+1, with 0<=t_i<W. Put K=floor((N-5)/(S*F)). The proposed cutoffs and K agree with the coordinator's exact geometry packet.

| Parameter | Current mathematical range | Candidate 1 | Candidate 2 |
|---|---:|---:|---:|
| Binary cutoff | 4e18 | 1e16 | 2e16 |
| S | 111616 | 157 | 313 |
| W | 2048 | 128 | 256 |
| Offset bits d | 11 | 7 | 8 |
| K | 254638308 | 181029996372 | 90804183483 |
| S exponent width s | 17 | 8 | 9 |
| Index exponent width b | 28 | 38 | 37 |
| popcount(S) | 5 | 5 | 5 |
| ceil(K/32) | 7957448 | 5657187387 | 2837630734 |
| Last partial block length | 4 | 20 | 27 |

This table uses only the needed K rungs and permits a short final block. The current repository actually checks 254640128 rungs in 62168 chunks, hence 7957504 complete 32-rung blocks. Those padded counts are not the first column's minimal block count. A new implementation may likewise pad, but must include padded indices in every bound and cost.

For each column S*K<2^45. It also holds with K replaced by K+31, so padding the last block to 32 does not break the specialized primality range. The candidates have at most 90 bits. No giant integer 3^(2^44*S*i) is constructed: that expression belongs only to the modular-invariant proof.

The coverage conditions are S>=W and (S+W-1)*F+2<=B. For i=floor((n-5)/(S*F)), every candidate in the window gives 4<=n-p_i<=B. The first window joins the binary-plus-three base range. General fallback primes in exactly the same window satisfy the same inequalities; they need not have Proth form.

## 2. What one ordinary block computes

Use q for the number of slots in a block, q<=32, and initially suppose every slot is Proth-tagged. To avoid confusing the binary cutoff with the source variable named B, call that variable V here:

    M = product_j p_(i0+j)
    V = 3^(2^44) mod M
    A = V^S mod M
    U = A^i0 mod M.

At slot j the invariant is U congruent to 3^(2^44*S*(i0+j)) modulo M. The test is

    (U + (V mod p)^t mod p) mod p = 0,

and the source advances U to U*A mod M. It also checks M mod 3 != 0. Since p divides M, this proves the source certificate. Writing k=S*i-t gives

    3^(2^44*S*i)+3^(2^44*t)
      =3^(2^44*t)*((3^k)^(2^44)+1).

The nondivisibility by 3 permits cancellation. Every odd prime factor of the resulting power-plus-one is at least F+1. A composite p would therefore be at least (F+1)^2, contradicting k<F. This is exactly the source proof mechanism. The product argument does not require the different candidates to be relatively prime.

## 3. Operation counts and bit sizes

The following counts describe an eager evaluation of the displayed source recursion or a deliberately specified modular algorithm. They are arithmetic-operation counts, not exact Lean kernel instruction counts. A kernel may discard unused arguments, share reductions differently or perform specialized arithmetic. Do not infer time from the counts alone.

| Stage | Modular squares | Other modular multiplies | Other work |
|---|---:|---:|---|
| Build M | 0 | 0 | q ordinary integer multiplications in source, including multiplication by initial 1 |
| `sqPow M 44 3` | 44 | 0 | 44 reductions modulo M |
| `powM M s V S 1` | s | popcount(S)=5 | One reduction after each square/multiply; bit tests/shifts |
| `powM M b A i0 1` | b | popcount(i0) | Same bit operations and reductions |
| Slot advancement | 0 | q | q reductions modulo M in the literal source schedule |
| One slot test | see below | see below | V mod p; addition to U; final reduction modulo p |
| Check base coprimality | 0 | 0 | M mod 3 and comparison |

Thus initialization has 44+s+b squares, or 89,90,90 respectively. The 5 fixed accumulator multiplies are unchanged. For unrestricted i0<2^b the index contributes at most b multiplies. For i0<=K those maxima sharpen to 27,37,36. For the actual block starts i0=1+32j, the maxima sharpen further to 23,33,32, so total initialization accumulator-multiply bounds are 28,38,37.

The final square in binary exponentiation is unused. An explicitly optimized algorithm that stops at the highest set bit uses bitlength(e)-1 squares for a positive exponent e. Its largest initialization square totals are 87,88,88. This is not a claim that the current kernel executes exactly those totals. Similarly the final slot update can be omitted after the last consumed slot, saving one product-modulus multiply per nonempty block. Such changes need their own invariant proof.

If there are a Proth factors in M, each below 2^90, then M<2^(90a), so its bit length is at most 90a for a>=1. With all 32 factors this is at most 2880 bits, consistent with the source's approximate 3000-bit description. Reduced residues are below M; a square or product before reduction is below 2^(180a), at most 5760 bits. Product construction never needs a larger retained product than M. Bit size varies with actual heights and a; the bound is not a prediction of typical size.

The current offset expression uses `Nat.pow`, followed by a single remainder. It does not reduce between its internal multiplications. Since V mod p<2^90, its output has at most 90*t bits for t>0. The worst output-size bounds are 184230,11430,22950 bits in the three columns; t=0 returns 1. This can make narrower offsets materially useful, but does not determine a speed ratio.

A new offset routine `powM p d (V mod p) t 1` has at most d modular squares and popcount(t)<=d modular multiplies, all on at most 90-bit residues and 180-bit products. This gives upper totals 22,14,16 per Proth slot. It avoids the large unreduced power. Whether it beats the current intrinsic Nat power at the actual small offsets must be measured, and the new routine's congruence must be consumed by the test proof.

The final `(U+v) mod p` receives U<M and v<p. For a>=1 the sum has at most 90a+1 bits. These reductions from the product modulus to each factor are separate costs; they are not 90-bit modular operations merely because the output is 90 bits. The same applies to V mod p.

For a hypothetical all-Proth ladder with short final block, the exact upper schedule counts below exclude product construction, all offset powers, slot-test reductions, parsing and proof assembly:

| Count | Current K | Candidate 1 | Candidate 2 |
|---|---:|---:|---:|
| Initialization squares | 708212872 | 509146864830 | 255386766060 |
| Initialization accumulator multiplies | 138259292 | 124436949138 | 60998216469 |
| Source-style slot updates | 254638308 | 181029996372 | 90804183483 |

These are work inventories, not forecasts. For C=ceil(K/32), the middle row is `5*C + C + sum_(j<C) popcount(j)`, because block starts are 1+32j. The sum is computed without iterating over the ladder:

    sum_(j<C) popcount(j)
      = sum_b [floor(C/2^(b+1))*2^b
               + max(0,C mod 2^(b+1)-2^b)].

Only O(log C) integer terms are needed to reproduce the inventory. No candidate prime was tested.

## 4. Mixed blocks and fallback semantics

For each of q slots, accept one of two typed records:

* A Proth record contains t in [0,W), defining p=(S*i-t)*F+1. Require 1<=S*i-t<F and the modular certificate described above.
* A general record contains p and a sound primality certificate, with p odd and `(S*i-(W-1))*F+1 <= p <= S*i*F+1`. No congruence class, Proth shape or base-3 property is required for this p.

Construct M from Proth records only. If a=0, skip every product-modulus computation, including the base-3 check; verify only the q general records and their bounds. If a>0, compute V,A,U as above and require M mod 3 != 0. Traverse all q slots in order. At a Proth slot, perform its test and verify its candidate divides M through the product construction. At a general slot, check the separate certificate instead. Advance U by A at every slot, including general slots, except an explicitly omitted final update.

Skipping an update at a fallback slot without accounting for its exponent would be unsound. One can jump across g skipped slots by A^g mod M, but must prove that invariant and count the extra powers. A simpler first implementation advances all slots. Optionally begin at the first Proth slot and stop after the last, with adjusted initial exponent; this is another proved optimization, not inherited behavior.

Every accepted slot must produce the same output proposition: an actual prime inside its assigned interval. Then exact slot/range assembly consumes that proposition without caring about the certificate tag. Check the block start, q, final partial length and adjacent block indices. A bitmask alone must not be allowed to omit a required slot.

Fallback fraction does not determine exact checker work. The per-block a determines M's bit length; all-fallback blocks save initialization, while sparse mixed blocks still require it. The correct model is

    sum_blocks C_block(a, Proth-position pattern, indices, offsets)
      + sum_general_records C_prime(record)
      + parsing, interval checks and assembly.

The previous `R*cP*(1+f*(r-1))` model is a fitted aggregate comparison once these effects are included in cP and r. It is not an exact consequence of the mixed checker, nor is r>1 guaranteed by arithmetic-operation counts.

### Optional separate base groups

The counts above fix the source's base 3. A future middle tier can partition ordinary slots by a selected small base u. For each nonempty group, form its own product M_u and replace V by u^(2^44) mod M_u. Require gcd(u,M_u)=1. The same factorization and power-plus-one proof applies; the checker need not assume a quadratic-reciprocity table. Such a table may guide untrusted search only.

If group u contains a_u factors, its modulus has at most 90*a_u bits. The straightforward full-position schedule pays 44+s+b squares, 5+popcount(i0) initialization multiplies, and q updates for each nonempty group. Total initialization/update work is therefore a sum over groups at their respective modulus sizes, while product construction and slot tests remain charged only to their assigned factors. The number of updates can be q times the number of nonempty groups; it is not automatically q. Starting at each group's first slot and stopping at its last, or jumping over gaps, needs the modified invariant and costs described above.

Splitting one large modulus into smaller moduli may offset repeated initialization because multiplication cost is nonlinear, but that is an arithmetic-backend question. Empty groups are skipped. Every ordinary slot must belong to exactly one checked group. Neither residue-class proportions nor successful modular tests for selected candidates establish how frequently complete prime windows will succeed. This extension does not change the base-3 inventory or supply a measured fallback rate.

## 5. A sound unstructured partial-Pocklington option

One possible general record gives a fully factored divisor D of p-1 and leaves the remaining cofactor unfactored. Require p>1, the exact product/divisibility identity, D^2>p, and primality certificates for every distinct prime ell dividing D. For each such ell, require a base a_ell with

    a_ell^(p-1) = 1 mod p,
    gcd(a_ell^((p-1)/ell)-1,p)=1.

These force D to divide r-1 for every prime r dividing p. The resulting lower bound on r contradicts compositeness when D^2>p. Prime-power exponents in D must be correct; merely listing distinct factors without their powers is insufficient. This is a proposed general mathematical interface, not a claim that the current specialized source already implements it.

A modular implementation can use gcd(v+p-1,p), with v the reduced second power, avoiding a natural-number subtraction convention for v-1. Check the gcd by a proved algorithm or a valid Bezout certificate with signed integers. Each factor-prime reference must point to an already proved fact, with a terminating dependency order. Producer factorization and probable-prime tests are untrusted search aids.

With d distinct factors, a naive checker uses at most 2d modular powers with exponents at most 90 bits. An eager binary schedule gives at most 180d modular squares and 180d accumulator multiplies on the p modulus, plus factor products, d gcd checks and recursive prime certificates. Common bases can share the Fermat power; multi-exponent algorithms may share more. This count excludes certificate generation and does not bound the recursive closure's total size.

The existing prime benchmark involves 61/62-bit roots near 2e18/4e18 and full Lucas–Pratt factorizations. Its 55.078 ms per root includes a particular 32-root shared closure. It is not a calibration for 90-bit partial-Pocklington ladder fallbacks, their factorization search, or a different cache. No fallback timing is supplied here.

## 6. Representation, sharing and proof-system costs

Old ordinary offsets use 352 bits per 32 slots. The new ordinary offsets need 224 or 256 bits; a simple mixed layout adds a 32-bit tag mask and separate general records. At the required K, fixed offset-plus-tag payloads would be 181029996372 bytes for candidate 1 and 102154706419 bytes for candidate 2, before framing and fallback records. These are layout counts, not proof-object or resident-memory estimates. Sparse tags or omitted general-slot offsets change them.

The same 4096-rung chunk size gives 44196777 or 22168991 chunks. One declaration per chunk would add substantial metadata. A hierarchical checked range summary, streaming chunks and sound shard composition deserve explicit implementation; neither prover was shown retaining this entire future environment at once.

Within one block, the reusable DAG contains the product, V, A, the chain of U residues, and each consumed slot certificate. It must not recompute V/A for every slot or copy a full shared factor proof into every fallback. Across blocks M changes, so reusing a residue modulo the previous M is invalid. A larger product tree or batch modulus can share further exponentiation only through a new congruence construction whose larger bit costs are counted.

Lean can check native Nat arithmetic equalities inside kernel reduction, with the generic modular/primality theorem checked once. Its actual evaluator sharing, literal handling and auxiliary proof generation determine costs beyond this inventory. MM0 can use the same arithmetic DAG mathematically, but ordinary MMB needs genuine arithmetic and primality derivations plus efficient references. The earlier schematic `ok` benchmark does not supply them. A proved-admissible arithmetic accelerator changes the verification implementation and must have a closed soundness path; it is not automatically an ordinary MMB artifact.

Compare each system's cost for multiplication and reduction at 90, 2880 and up to 5760 bits, and for the current large unreduced offset power if retained. Also count reference lookup, parsing, proof construction, witness storage and final interval composition. The smaller stride establishes no universal Lean/MM0 speed relation.

## 7. Required work before a runtime estimate

Generalize and prove the parameter bounds and modular loop invariants, replace hard-coded hint/index widths, prove both tagged branches give the same interval-prime proposition, and prove final range coverage including the short tail. Establish the general-prime certificate library and its recursive dependency closure. Decide whether to retain raw offset powers or replace them with modular powers, and ensure the runtime DAG actually shares V/A/U as priced.

A useful next measurement would separate ordinary all-Proth blocks, sparse and dense mixed blocks, and all-general blocks near the highest required bit sizes. It must include actual fallback certificate closures and generator failures, not just supplied prime literals. Measure both offset algorithms and complete proof consumption. No such run is authorized or performed in this report.

## Source snapshot

| Read-only source | SHA256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/qrh-blueprint/hybrid_ladder_tradeoff_20261111.py` | `C06D1AAE3FDD3C7E197074A41CEB7C7573F5155E908446EAFD891862CFFB3239` |
| `work/qrh-blueprint/hybrid_ladder_tradeoff_20261111.json` | `0673A7389EFD85EFF7B4988F45D78C46B39B82F89EE646484DF039400C9EE28A` |
| `work/formal-goldbach-bench/prime-cert/REPORT.md` | `4F806BD887B187043AAC4180DBF40E2C9C78AD023F8248311BBDC397D43C2ACB` |

The prior `FINITE_RANGE_COST_RESEARCH_2026-11-11.md` is frozen at `0D4A300D37845AE20EB3242F89F08ED5984C0048646B60C1EECD2874945D8D48`. The local `work/formal-goldbach-bench/prime-cert/REPORT.md` was read for the precise scope of the existing prime measurements. This inventory supplies new integer operation counts and a proposed mixed interface; it does not validate new prime data or complete either prover implementation.
