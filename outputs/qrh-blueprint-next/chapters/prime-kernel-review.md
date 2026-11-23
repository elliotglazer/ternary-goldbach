# Independent review of the finite-psi kernel replay design

2026-11-11. Final verdict: **PASS as a proposed mathematical replay architecture, with the requested clarifications incorporated.** This is a source/math and structural-data review, with no Lean files, Lean builds, large masks, or new full-range sieve. The frozen 131-chapter package and canonical sources were not changed. A sound proposed architecture is not a completed proof or a demonstrated feasible compilation workload.

## Input and review status

The initial reviewed note is `prime-estimates/RESUME_PSI_KERNEL_REPLAY_ARCHITECTURE_2026-11-11.md`, SHA256 `9559b5cb51322e1227b476bda3cd57436de7b8c5b451bc1e7f9f5d434aadaa53`. Initial sizing script/JSON hashes are respectively `66e59fef5c1318803456c438f209f116e293e81a1ae6e0e895c8490b9be6020b` and `9ab9e996e7da574c35856ca346fcd5f5434124591267ab42ab7c4532796c5a64`.

The mathematical count, mask, theta-update and interpolation strategy passes this review. Three implementation/statement clarifications were sent to the author: distinguish109 outer binary ORs from110 chunk-result visits; distinguish a syntactic one-pass work count from dynamic kernel execution; and make the real floor wrappers explicit. The base primality test also needs the source guard stated explicitly. These are recorded below so a future implementation cannot silently choose an unsound or unjustified interpretation.

The author incorporated all four clarifications. The final source was re-read and the independent replay completed with exit0 against these pins:

| File in `prime-estimates/` | Final SHA256 |
|---|---|
| `RESUME_PSI_KERNEL_REPLAY_ARCHITECTURE_2026-11-11.md` | `a610492380f798e3c369f052af33662e60546180936956da78f721e42a900d97` |
| `resume_psi_kernel_replay_sizing_20261111.py` | `9345b75e48ac08927850e4bfb0cca0d07a17f55136b299ddaa1f004bf6090deb` |
| `resume_psi_kernel_replay_sizing_20261111.json` | `9b2c790fc5ae6d012e93d767b3c0a5e4e7c40272cdab6a070e3f614428cad724` |

No requested correction remains outstanding. The final sizing artifact explicitly sets `dynamic_kernel_work_bound_claimed` to false.

The independent replay is `review_psi_kernel_architecture_20261111.py`, beside this note, with its own JSON output. It reruns the read-only sizing script, independently reconstructs the small prime base, checks every grid/cell boundary and recomputes every theta state. It does not reprove the supplied 184,106,689 prime classifications over the four-billion-integer span. Those counts remain externally supplied values until the proposed kernel checks exist.

## Source contracts and endpoints

The cited Lean mathematical source is `work/ternary-goldbach/TernaryGoldbach`, pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The complete base through70710 is sufficient. If70710<m<70711^2 is composite, its prime minimum factor has square at most m, hence is at most70710. Conversely, a prime m above the base cannot equal a base prime, so none divides it. The strict cap is exactly5000045521, greater than5000000000. This is the argument of `Prelim/PsiSieve3.lean:113` with corrected constants; its existing cap1000014129 is insufficient and is not reused.

For the base itself, the adapted predicate must be

    n>=2 AND for every d in {2,...,265}, (n<d*d OR n%d!=0).

This is the guarded predicate in `isPrimeSlow3` at line46, with its trial range enlarged. A plain test excluding every divisor in that range would incorrectly reject small primes. The guard is valid because266^2=70756>70710. The independent small-base computation gives exactly7004 primes, last70709. Partitioning0..70710 into277 pieces of at most256 values is arithmetically correct; no claim is made that those proofs fit current default limits before testing them.

`PsiSieve.maskP_spec:72` requires p>0, residue r<p, and pattern length<=2^64. With r=0 and length131072 all premises hold. The exact highest set bit of its numeral is p*floor(131071/p), so the sizing formula for its bit length is correct.

The shifted leaf at index i reads pattern bit i+(n+1)%p. Because the shift is strictly less than p<=70710, the hypothesis i+70710<=131072 guarantees that bit remains inside the certified pattern. Its divisibility predicate is exactly p divides n+1+i. A balanced OR tree therefore has the same bit specification by induction: zero for an empty tree, the leaf predicate for a singleton, and logical disjunction at a binary node. The semantic theorem must identify the tree's leaf membership with the complete base. Duplicates do not affect OR, but a missing base prime would invalidate the intended conclusion.

`pcL_spec:221` gives pcL7=nbits32768. The proposed XOR/AND expression is the complement only inside the low W bits and zero beyond W. Thus for W<=32768 it counts precisely i=0,...,W-1 such that n+1+i is prime. The bijection is with the natural interval Ioc n (n+W), including its right endpoint and excluding n. The lower condition n>=70710 ensures every tested integer is strictly above the base. The upper condition n+W<70711^2 is retained for every subcell. Empty W is harmless in the generic theorem; the concrete assembly uses positive widths.

The replay checked all125271 subcells for exact adjacency, positive width<=32768, and both domain bounds. It checked all6439 macro windows for their grid recurrence, start10^9 and final endpoint5*10^9. Counts sum to the stated macro values and the supplied total184106689. These are arithmetic consistency checks, not independent prime-count proofs.

## Literal data and kernel trust

A valid implementation can define each M_p by a natural-number literal, prove M_p=maskP p 0 131072 using a closed kernel decision, and derive its bit theorem once. Later count expressions must read M_p's literal definition. An equation theorem does not cause kernel normalization to rewrite calls to maskP automatically. Soundness should consume the saved equation/bit proof by ordinary theorem application, rather than deciding all those equations again in each count theorem.

The inspected installed Lean sources are under `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/`:

| Source | SHA256 |
|---|---|
| `Lean/Elab/Tactic/Decide.lean` | `6773f54ca73ee7405a91c5ffb3b827db4ecdbb22b28a494cf5e2fe8ac224c4b3` |
| `Lean/Parser/Basic.lean` | `ce8145e7da9c5513f37dbb7f2918fef3cef9777f1b55c7bf3860846b87692447` |
| `Lean/Elab/BuiltinTerm.lean` | `8c05cb49c6f257458b4fd8e22495658c8982bc7ed421cfbad954f17e66d095b9` |

`Decide.doKernel` constructs a proof and submits an auxiliary lemma to the kernel. Its documented caches are a per-module cache indexed by the proposition's type and reuse of a proof already in the environment. This does not promise cross-declaration memoization of mask computations, nor arbitrary expression-normal-form persistence. The parser explicitly accepts0x hexadecimal numerals; elaboration obtains a natural literal and constructs the ordinary OfNat term. The literal's size does not introduce a new logical rule or a native_decide assumption.

An untrusted generator may compute wrong masks or counts; their closed equations then fail kernel checking. Hashes and external classifications are provenance, not proof premises. The proposal appropriately keeps count computations separate from later theta assembly. Acceptance still requires the exact final theorem and transitive axiom audit: existing PlattGRH would not become acceptable merely because it was already present in the repository. The final finite theorem must have no sieve-data, count, spectral, or checkpoint hypotheses left.

## Balanced-tree work and memory boundaries

The7004 leaves can be divided into109 full64-leaf chunks and one28-leaf chunk. A balanced tree within chunks and over110 chunk results has OR depth at most6+7=13. This is an OR-tree depth bound, not a bound on all elaboration or kernel recursion. No default-limit success is demonstrated by this design.

There are7003 internal binary OR nodes in an unpadded7004-leaf tree:6894 inside the chunks and109 outside. Across125271 cells this gives:

| Syntactic quantity | Amount |
|---|---:|
| Base-leaf visits | 877398084 |
| Inner binary OR nodes | 863618274 |
| Outer binary OR nodes | 13654539 |
| All binary OR nodes | 877272813 |
| Outer chunk-result visits | 13779810 |
| pcL7 256-bit leaf occurrences | 16034688 |

The initial note's110-based outer figure is correct as chunk-result visits, not as a binary-OR operation count. If an implementation adds empty/zero children deliberately, its operation count changes; such padding is not required for the stated balanced-tree semantics.

Even these corrected counts describe syntax or a one-pass traversal, not guaranteed dynamic kernel work. `pcL_succ` sends its input into both modulo and shift branches. Kernel reduction may request the shared composite OR expression repeatedly. Whether the implementation shares those reductions sufficiently must be inspected or measured; literal masks alone do not prove composite-OR memoization. If staging a composite-mask equation is later used to prevent repetition, it needs its own checked equality and resource accounting.

The independently matched literal-size totals are100387363 raw magnitude bytes,114753536 fixed-width bytes, and200771450 hexadecimal digits without leading zeroes. They omit headers, syntax and proof objects, parser buffers, imported environments and transient allocations. They are neither Lean RSS nor a peak-memory upper bound. Likewise, no extrapolation from an external sieve's runtime establishes kernel runtime. Parallel processes may replicate the imported literal data. The proposed small representative experiment is needed before selecting concurrency or generating all modules.

## Theta states and the finite real interval

`SmallPsiTable.S:216` is the natural number10^9. `InvT` is defined using scaled real bounds on thS. `PsiSieve.thS_sub:412` gives the exact increment over prime logs on Ioc a b. With the left lower log and right upper log, the update L'=L+c*ell_a, U'=U+c*u_b follows directly. `Small.le_log_of_chk` requires positive denominator and endpoint; `Small.log_lt_of_chk` with its n parameter set to1 gives the desired strict upper log bound. All concrete endpoints satisfy those positivity premises.

The seed theorem `PsiSieveMain.stg2813:28149` supplies the stated theta and log bounds at10^9. The replay recomputed every subsequent theta state exactly and checked every relaxed relative checkpoint. The final scaled pair is4999882220821805278,4999930929840072558. It did not rerun the real-log Boolean checks; their source consumption contract was inspected, and new Lean proofs remain required.

The source Helfgott psi and theta take natural arguments. For real interpolation the intended psi is the existing `Explicit.psiR(v)=Helfgott.psi(floor v)` from `PsiSandwich.lean:82`; the corresponding theta is thS(floor v). `ThetaExplicit.theta_eq:33` identifies the natural theta sum. For integer a,b and real a<=v<=b, one has a<=floor v<=b. P6 at floor v implies its real-wrapper remainder bound because sqrt(floor v)<=sqrt v. Hence no extra unit loss is needed, but the floor bridge must be present in the eventual theorem.

The exact interpolation coefficients replay as7/20000 and572053/1440000000, both below1/2300. The checks1.4262/31622<17/360000,31622^2<10^9 and2.7^23>5*10^9 are correct. Combined with P6 and the checkpoint bounds, they prove the stated .01*v/log(v) envelope on the closed finite interval, including5*10^9. P6 and the above-5*10^9 analytic continuation are separate unfinished proofs. Their dependencies must not use the finite/global psi envelope being constructed.

## Conclusion

The architecture is a sound proposed route after the explicit interpretations above. No new kernel count proof, literal-mask equality, generic balanced-tree theorem, P6 proof or finite-envelope theorem was produced by this review. All literal figures are data sizing only; operational feasibility remains unmeasured. The review does not add the architecture or any candidate data to the frozen131-chapter package.
