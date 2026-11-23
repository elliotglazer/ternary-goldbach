# Adversarial review: fastest credible path to the n ≥ 10^27 milestone

## Research question

Our primary publication milestone is an axiom-audited Lean proof of every odd n >= 10^27 being a sum of three primes by composing the published GRH term with the existing calr3 large theorem. The actual GRH build is running under Lean 4.33.1 and the pinned Goldbach checkout uses 4.35.0. The Goldbach authors report a separate 22h56 comparator acceptance of the same conditional large statement in RSBounds. An artifact of the statements is public; an importable full GRH cache is not yet confirmed. The full all-n corollary would additionally require the interval theorem and a finite certificate. Please give a short adversarial review of the fastest credible integration path, and identify one technical or mathematical shortcut that would actually remove an obligation. Explain exactly what can be claimed if only the separately checked conditional theorem and separately checked GRH term are available in two toolchains. Distinguish a standard mathematical consequence from a single checked Lean theorem.

## Claude’s response

### Weak points in the plan

1. **Statement identity is the real risk, not the build.** The Lean version gap between 4.33.1 and 4.35.0 matters less than the **Mathlib revision** gap. Definitions like `DirichletCharacter.LFunction`, "nontrivial zero", primitive versus all characters, and the junk value at s = 1 can differ silently between revisions. Two specific hazards:
   - A naive GRH for *imprimitive* characters that calls zeros on Re s = 0 "nontrivial" is **false**.
   - A hypothesis that never fires is **vacuous**.
   
   Elaborate both GRH statements in one environment before trusting either one.
2. **Axiom audit.** Run `#print axioms` on both terms. You want exactly `propext`, `Classical.choice`, `Quot.sound`, with no `sorryAx`, no `Lean.ofReduceBool`, and no project-declared `axiom`. Do this in each toolchain.
3. **Comparator acceptance.** Confirm that the 22h56 RSBounds run checked the *same* declaration name, statement, Mathlib revision, and commit that you will compose. Otherwise it is evidence, not a certificate.

### Fastest credible path

Backport **only the import cone of the large conditional theorem** to the GRH toolchain and its Mathlib revision. Leave out the interval theorem, the Proth ladder, and the finite certificates. Then in one file:

```lean
theorem ternary_large : ∀ n, Odd n → 10^27 ≤ n → IsSumOfThreePrimes n :=
  large_conditional grh_published
```

If the hypothesis types differ, add a bridging lemma `GRH_pub → GRH_calr3`.

### Shortcut that actually removes an obligation

The milestone only needs n ≥ 10^27. So **pruning the backport to that cone removes the whole kernel-replayed ladder and certificate rebuild** from the critical path. That rebuild is the expensive part, and it doesn't depend on the GRH term at all.

If the backport still stalls, use a statement-only port. Copy the GRH *definitions*, not the proof, into 4.35.0 and prove there that `GRH_pub_stmt → GRH_calr3`. That machine-checks the glue and leaves only a syntactic-faithfulness check of the copied definitions to humans.

### What can be claimed with two toolchains

Suppose all you have is:
- **A:** `⊢ GRH_A`, checked in Lean 4.33.1 at Mathlib revision X;
- **B:** `⊢ GRH_B → T`, checked in Lean 4.35.0 at Mathlib revision Y.

**Claimable:** "Two independently kernel-checked theorems, together with a human-verified identification of GRH_A with GRH_B, establish T as a standard mathematical consequence." The trust base is both kernels, both Mathlib definition sets, and the identification step. Report it in exactly those terms.

**Not claimable:** "a Lean proof of T" or "axiom-audited T". No single kernel ever checked a term of type T, so there is nothing to run `#print axioms` on. A single checked theorem requires both proof terms in one environment, through the backport or a port of the GRH proof.
