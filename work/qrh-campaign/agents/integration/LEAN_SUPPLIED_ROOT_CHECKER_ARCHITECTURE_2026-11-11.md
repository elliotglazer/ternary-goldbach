# Supplied-root batches without enormous ordinary powers

2026-11-11. Source architecture only. No declaration, checker implementation, build, prime search or modular-power evaluation was made. The recommendation is a new bounded Boolean checker and a generic soundness theorem whose exported conclusion mentions primes and interval coverage, never a concrete ordinary power. It is not a claim that the proposed implementation has been checked or timed.

## 1. What the inspected source already supplies

`Ladder/Check.lean:27–38` defines the candidate, product fold and `sqPow`. The latter performs exactly f updates `x := x*x % m`; its zero-step result is x, without an initial reduction. `Spec.lean:105–118` proves the generic relation

    sqPow m f x ≡ x^(2^f) (mod m).

This is the reusable modular loop. It does not calculate the right-hand side. `Spec:38–55` proves the already sufficient criterion: an odd c with 1<c<(2^45+1)^2 that divides x^(2^44)+1 is prime. Its proof uses the least prime factor and Mathlib's prime-divisor congruence, not a concrete primality decision.

The old certificate has an additional base-3 cancellation. Its comment immediately before `Spec:68–70` explicitly keeps D variable so that the kernel must not evaluate `3^(2^44)`. That cancellation, `powM`, per-offset exponentiation in `chk`, and progression updates in `blkWith` are unnecessary for the common-root criterion. They should not be carried into the new executable checker merely to reuse the old block theorem. The old `prime_of_runsOK:287–304` also has fixed stride/window/index restrictions; it is not the generalized coverage theorem.

`Check:61–85` and `Spec:198–282` show the useful proof architecture: parameterized `With` functions keep symbolic branches unreduced while proving the fold invariant. `Spec:83–86` warns that careless definitional unfolding can recurse through the literal 111616; its equations are used by `rw`. Reuse this separation of executable loops from generic loop equations.

## 2. Mathematical boundary, proved once with variables

Fix F=2^45. A batch has q actual decoded candidates c_j, q>0, a supplied M>1, and a reduced supplied root X<M. Its metadata check establishes all of the following:

1. the exact domain, consecutive indices and offset decoding;
2. each c_j is odd and 1<c_j<(F+1)^2;
3. M is exactly the product of those q candidates, with multiplicity;
4. all field/count/size bounds and exhaustion conditions hold.

The only modular acceptance test is `sqPow M 44 X == M-1`. Prove soundness with M and X still bound variables. Generic congruence gives X^(2^44) congruent to M-1. Add one and use M>1 to identify (M-1)+1=M; hence M divides X^(2^44)+1. Every c_j divides M by the product invariant, so `prime_of_dvd_pow_add_one` applies. This proves the batch prime conclusion. Nothing requires computing this ordinary power, even in the proof: use congruence/divisibility lemmas, with an auxiliary variable D where rewriting the exponent could otherwise expose reduction.

Export the resulting implication in the form “the Boolean batch check returns true, therefore every decoded candidate is prime and lies in its stated window.” The public theorem type contains the checker, indices and candidates, but **no X^(2^44)**. A second generic theorem composes batches into exact range coverage. Concrete packs apply these theorems; they never construct a concrete divisibility or power-equality goal as an intermediate step.

No separately checked gcd, base, k-exponent, or pairwise coprimality is necessary for this implication. Repeated factors are mathematically permitted by acceptance. Constructing X modulo a repeated-factor product is a separate producer issue: ordinary CRT on prime residues alone does not provide the required lift. The checker does not assume that production succeeded.

The new reducedness invariant is simple: X<M initially; after each update the remainder is <M because M>0. Each temporary square is <M^2. With the current separately checked bound c_j<2^90, M<2^(90q), so q<=32 bounds a product to 2880 bits and a square to at most 5760 bits. The generic criterion c_j<(F+1)^2 alone does not imply c_j<2^90; enforce the stronger current geometry bound separately if using this resource bound.

## 3. A concrete bounded record and traversal

Use separate bounded literal fields `(q, offsets, M, X)`, with a pack-level exact geometry identifier and starting index. A reasonable first design retains q<=32 and at most 128 batches per pack, but these are test parameters, not a claimed optimum. Require 1<=q<=32; only the final batch may have the explicitly specified short length. No padding can silently create or remove a rung.

For offset width w and window size W<=2^w, decode the low w bits, check t<W, and shift only the bounded offset field. After q fields require the remaining offset word to be zero. The fold increments the actual index, constructs `(S*i-t)*F+1`, and checks 1<c (or t<S*i), preventing Nat subtraction saturation from becoming a hidden geometry assumption. Its terminal case checks that the accumulated exact product equals supplied M. Fix S,W,F and the total covered range in the proposition; an unverified source hash or metadata tag is insufficient.

M is a redundant literal witness deliberately included to avoid depending on reduction sharing. The product is computed once along the metadata fold and compared to this literal. Every square then uses the literal M, not an expression such as `prod candidates`. A source-level `let M := prod candidates` by itself is not evidence that kernel reduction computes the product only once. The literal design trades up to 90q additional bits per batch for a clear reduction boundary. X contributes another at most 90q bits; offsets add qw bits. For q=32 and w=7 or 8, raw integer payload is at most 5984 or 6016 bits per batch, before framing, syntax and proof/module overhead. These are bit budgets, not serialized file or RAM predictions.

Do not include a supplied V as a substitute for the root chain. The checker computes its terminal residue once. If a future trace stores intermediate residues, each transition must be checked, which is a different cost model.

One pack is a bounded structural list or shallow tree of bounded records. The check walks it in order, threading the next index and remaining expected count. It checks exact exhaustion of both. The offset word is at most qw bits; neither M nor X is extracted by shifting through a giant concatenation of all future roots. Do not pack billions of records into a single Nat or use random-access suffix shifts over that value. A literal constructor spine still has traversal/type-checking costs; bounded packs avoid claiming constant-time access or automatic global sharing.

The arithmetic checker should use primitive recursion and a short-circuit Boolean branch, as the existing source does. A parameterized generic fold makes its soundness proof independent of concrete literals. Constant powers such as 2^44, 2^45 and 2^(90q) are small bounded integers here; these are not the dangerous ordinary power whose base is X. Size guards should precede expensive modular work. Input/parser resource caps remain additional implementation controls: a mathematical guard cannot retroactively prevent allocating an adversarially huge literal while parsing it.

## 4. Safe reflection and the opacity boundary

For each concrete bounded pack, kernel reflection is applied only to the proposition that this Boolean checker returns true. The prime-range theorem follows by the generic implication. Never ask `decide`, `norm_num` or definitional equality to evaluate a concrete X^(2^44), nor reflect the final primality proposition itself.

This uses actual existing APIs. `LadderHints.lean:64–89` produces a raw Nat literal and a `ChunkOK` theorem with `decide +kernel`. `Lean/Expr.lean:727–750` identifies `mkRawNatLit` as `.lit (.natVal n)` and distinguishes the frontend OfNat wrapper. Literal generation is untrusted; its result must pass the kernel checker. The new producer can emit bounded literals offline rather than repeating search during elaboration.

`Lean/Elab/Tactic/Decide.lean:83–131` separates native and kernel modes. The kernel branch constructs the decision proof and passes it to `mkAuxLemma`; the source comments describe a type-indexed per-module cache and reuse after the lemma is added to the environment. This supports one closed check per pack followed by theorem references. It is not a promise of cross-process caching, cheap imports, or one evaluation of every subexpression.

`Init/Tactics.lean:1428–1436,1459–1473` explicitly says kernel reduction ignores transparency settings and distinguishes native acceptance. Thus an `irreducible` annotation is not protection for an executable ordinary power. Keep the checker transparent enough to reduce; keep costly semantic reasoning behind generic theorem constants whose public types avoid the concrete power. Proved theorem opacity is the intended application boundary, not an unproved opaque computation oracle. Making M an opaque Nat would obstruct computation; a bounded transparent literal M is different from a transparent expensive product expression.

The source architecture prevents enormous-power normalization by construction: executable definitions contain only bounded recursion, arithmetic, remainders, bit operations and comparisons; exported generic conclusions contain no instantiated huge powers; concrete proof terms apply these conclusions. A future implementation still needs a source/term audit confirming these properties and actual focused validation. This report inspected the installed tactic and expression APIs, not a C++ kernel implementation or a compiled execution trace.

## 5. Pack and root composition costs that remain

Hide a pack's data witness behind a short existential checked-pack proposition, then export exact prime coverage for its interval. Adjacent interval composition checks endpoint equality and covers the final short interval explicitly. A balanced assembly reduces composition depth; it does not erase the individual checks. The existing `Check:88–117` and `Main:18–25` demonstrate this split, though their fixed constants cannot be copied unchanged.

Separate the small checker from the generic arithmetic proof module. Data modules need the checker and a short checked-pack interface; a later semantic assembly imports the soundness theorem. Importing millions of individual theorem interfaces still costs environment space and deserialization. Pack size, shard size and maximum simultaneous elaboration are separate choices. `Data/L000.lean:15–18` explicitly disables asynchronous elaboration and records a historical memory warning for 486 chunks; that is source evidence for controlling concurrency, not a benchmark for this new larger-root format.

Witness hiding shrinks downstream theorem types. It does not mean omitted proof bodies or external shard success logs can be trusted without checking the required dependency chain. The full generation/verification accounting retains literal production, CRT/search, data loading, closed kernel reductions, module checking/imports and final assembly. Existing composition and ordinary-MM0 reports remain applicable. MM0 can prove the same 44 modular transitions by ordinary PA quotient/remainder certificates with shared digit facts; Lean's native numeral reduction and MM0's explicit arithmetic events are different cost mechanisms. A widened or streaming MM0 implementation preserving ordinary inference is still a valid implementation candidate, not an arithmetic axiom. Neither side receives a runtime forecast from this source plan.

## 6. Exact remaining work

The source already has the primality criterion and generic `sqPow_modEq`. The missing implementation/theorem work is narrowly identified:

* the parameterized metadata decoder/product fold and its exact candidate/cardinality/exhaustion invariant;
* repeated-square reducedness and a generic terminal-minus-one divisibility adapter, with powers kept symbolic;
* the new batch soundness theorem exporting only primes/window membership, and the short-final-batch/pack coverage theorem;
* structural bounded record encoding, explicit rejection branches, and generic loop equations avoiding accidental large-literal unfolding;
* concrete pack acceptance, exact global geometry and final root assembly, with the original root premises unchanged;
* focused reduction, import/environment and proof-generation measurements after separate authorization, plus standard-axiom/dependency checks.

No prime existence, candidate availability, concrete pack acceptance, build compatibility or speedup follows from this design alone. The smallest useful later experiment is one complete bounded pack through the generic theorem, including product and coverage checks—not an isolated fast modular-square benchmark.

## Source pins

Paths are workspace-relative except the installed Lean source root `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean/`.

| Source | SHA256 |
|---|---|
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Check.lean` | `A7993B4D1E8A70112403B85B15CF586B4DA84B962A04416531BDE9F35817A42D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean` | `0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Main.lean` | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |
| `work/ternary-goldbach/LadderHints.lean` | `3AA4E7D3357E5D544288249ED13616B3D9F9151C21D1DAE82AEFD7355C53505D` |
| `work/ternary-goldbach/TernaryGoldbach/Ladder/Data/L000.lean` | `650B391D462C1562143D879DAB8EFFC973F917081C276369FB9201985131DC6D` |
| installed `Lean/Expr.lean` | `B9A91D9D170201C2A3622B9C55D694466F54E0E1B8F6068A2D296FF98650169C` |
| installed `Lean/Elab/Tactic/Decide.lean` | `6773F54CA73EE7405A91C5FFB3B827DB4ECDBB22B28A494CF5E2FE8AC224C4B3` |
| installed `Init/Tactics.lean` | `0F98C09E7E56ED3431292D6996A20237EC8E5EB4D322E5701B33D6396638E056` |
| `work/qrh-blueprint/COMMON_ROOT_PRIMALITY_CERTIFICATE_2026-11-11.md` | `8D4E43987A576E7B18D849E94CB613A4F16C6E15B65DFE4204D1905C3D5FDF95` |
| `work/qrh-campaign/agents/integration/EFFICIENCY_PROOF_COMPOSITION_2026-11-11.md` | `FE62515193754C19CDB4A34728765CFA09DD5BEDD1694E5D575DCC79EE7D4E9B` |

Only this new Markdown note was created. No prior report, Lean source or runtime artifact was changed.
