# Ternary Goldbach in Lean

Lean 4.35.0 compiled the following theorem on Linux. A fresh Lean process imported the result and printed its type and axioms. [Solution source](https://github.com/elliotglazer/ternary-goldbach/blob/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b/GoldbachSolution.lean) · [Verbatim Lean output](fresh-import.log)

```lean
namespace PalomarTernaryGoldbach

theorem ternary_goldbach :
    ∀ n : ℕ, Odd n → 5 < n →
      ∃ p q r : ℕ, Nat.Prime p ∧ Nat.Prime q ∧ Nat.Prime r ∧ p + q + r = n :=
  CompletedGoldbach.ternary_goldbach

end PalomarTernaryGoldbach
```

Lean reported exactly `[propext, Classical.choice, Quot.sound]`. The bridge supplies both the Riemann hypothesis and the Dirichlet L-function zero theorem from the compiled GRH sources. [Bridge source](https://github.com/elliotglazer/ternary-goldbach/blob/3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b/CompletedGoldbach.lean)

| Warm Linux build | Reused modules | Newly compiled | Wall time |
| --- | ---: | ---: | ---: |
| `Main` (compact GRH) | 781 | 13 | 138.063 s |
| `CompletedFiniteRows` | 525 | 207 | 1,358.682 s |

All 732 finite source files have identical Git blobs at the finite build commit and at the final candidate. The join checked the retained outputs of 1,526 modules, compiled the two bridge files, and ran the fresh import in **37.321 seconds total**. These timings measure work with compiled dependencies available. Cold-build time, protected independent-kernel verification of the complete theorem, and Registry acceptance remain separate questions. [Finite source inventory](../finite-terminal-22f442fa/source-closure.tsv)

[evidence.json](evidence.json) records the source trees, timings, and SHA-256 digests of the original archives and named members. It is a newly generated summary. The linked Lean output preserves the original bytes.
