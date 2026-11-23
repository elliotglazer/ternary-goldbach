# Scope and final assembly

This research blueprint targets the original ternary Goldbach statement: every odd natural number greater than 5 is a sum of three primes. The only retained external mathematical hypothesis is BinaryGoldbachInput, the binary Goldbach verification through 4 times 10^18. PlattGRH must disappear from the final theorem type and its proof dependencies. QRH must enter through a proved theorem, not a new hypothesis.

The current reference is calr3/ternary-goldbach at commit 23b2d68ca344203d4384e0aff7affa4ec034bef9, branch cde-moebius. The root declarations are in TernaryGoldbach/MainTheorems.lean. The large-case threshold remains 10^27. The existing prime ladder and binary input already cover the complementary range.

This is a research blueprint, not an author-approved frozen declaration manifest. Proposed statements and dependency diagrams describe obligations. They do not certify that a theorem has been elaborated or proved. No new Lean placeholder files or axioms are introduced by this document.

## Existing root and intended change

The existing root is:

```lean
theorem TernaryGoldbach.ternary_goldbach_of_hypotheses
    (hGRH : TernaryGoldbach.PlattGRH)
    (hBG : TernaryGoldbach.BinaryGoldbachInput) : TernaryGoldbach.Statement
```

The intended final type removes only the hGRH premise. The large-case theorem must likewise prove TernaryGoldbachFrom (10 ^ 27) without a Platt premise. These intended changes are not currently implemented or kernel-checked.

Expand Statement before auditing: for every n : Nat, Odd n and 5 < n imply existence of prime p, q, r with p + q + r = n. Expand BinaryGoldbachInput to BinaryGoldbachUpTo (4 * 10 ^ 18). A theorem that assumes an averaged-error bound, a zero-free theorem, a stronger binary input, or the large-case conclusion has not met this target.

## Mathematical assembly

For odd N >= 10^27, let

    kappa = 49,
    d = 2 + 9 / (8 sqrt(pi/2) kappa),
    x = N / d.

The existing xOf_ge gives x >= 4.9e26. The circle identity expresses the smoothed representation count as the integral of S_etaPlus(alpha,x)^2 S_etaStar(alpha,x) exp(-2 pi i N alpha). Split into the existing major arcs and their complement.

The current proof uses major contribution at least 1.049 x^2/kappa and minor absolute contribution at most 1.0376 x^2/kappa. It subtracts the existing bound 6.7e6 N sqrt(N) log(N) for nonprime and even terms. Positivity then supplies a representation by odd primes. The circle identity, nonprime estimate, and extraction of a representation have existing unconditional proofs; the major/minor estimates still depend on PlattGRH.

The small-case branch is separate. It uses the retained binary input and the kernel-checkable prime ladder to cover odd 5 < N <= 10^27. Altering the analytic threshold without extending that coverage would leave a gap.

## Corrected final error budget

A major/minor difference is not enough: the nonprime subtraction must be included. Earlier exploratory budgets used

    1.052105346 - 0.002834895 - 1.0376 = 0.011670451

as if it were entirely available for new cubic errors. That is only the major-minus-minor margin and is superseded as a full-Goldbach budget.

The primary package uses major lower bound 1.0404, minor upper bound 1.0376, and nonprime reserve .00271. The final positive reserve is .00009, in units x^2/49. These choices preserve the public threshold and statement.

For upper major energy J<=10, set B(J)=2J+17.41053338496. The proposed coprime residual targets are

    Aplus' <= 5e-7,
    Astar' + Cross' <= 9.5e-7.

The reviewed removal algebra gives the full residual bounds

    Aplus <= 5.050000000000330e-7,
    Astar + Cross <= 9.817952468e-7.

Retain the factor 2 in the mixed term. The dynamic loss is bounded by

    sqrt(B(J)*Aplus) + sqrt(2*J*(Astar+Cross))
      < .0043466 + .0044313 < .008778.

Thus the major coefficient is greater than

    1.052105346 - .002834895 - .008778 = 1.040492451 > 1.0404.

The nonprime reserve reuses the structure of Numerics.final_inequality_crude. Since d<=2.02, the endpoint argument with v=N^(1/64)>=2.64 gives

    1.589e8 * 4.0804 * 49 / (2.64^31) < .00271.

The exact rational comparisons have been independently checked outside Lean. The revised numerical lemma, analytic residual estimates, and upper J bound remain proof obligations. Preserving the original major lower bound 1.049 is an alternative requiring dynamic loss <=.000270451. The variable-J alternative in the averages chapter requires its own smaller residual budgets. Do not mix either alternative with the primary caps above.

## Status vocabulary

- Kernel checked: a specific declaration compiled and passed exact-type/axiom checks in this campaign.
- Existing source: an upstream proof is present; this label does not assert a fresh full build or axiom audit.
- Reviewed draft: a mathematical/source argument was independently checked, but its Lean proof is not validated.
- Computational certificate: complete interval or exact-rational checks exist, with stated analytic assumptions and error bounds; Lean replay remains separate.
- Open research: a quantitatively sufficient mathematical proof has not been supplied.
- Alternative route: a possible replacement for a stated dependency, not an additional assumption silently conjoined with it.

Only three new helper theorems currently have kernel/type/axiom evidence. The principal-character finite computation has all 2,750 cells checked but is not a Lean theorem. The nonprincipal and mixed-moment estimates remain open research.

## Completion criteria

A completed proof must compile the revised large and full roots, print their full types, and audit their transitive axioms. It must retain exactly the allowed binary input; preserve all quantifiers, prime predicates and ranges; discharge every numerical and analytic predecessor; and avoid circular imports or conditional substitutes. A blueprint graph, a passing Python run, or an unchanged theorem with a hidden Fact PlattGRH binder cannot establish completion.
