# Independent review of the current root assembly

2026-11-11. **PASS at the stated source/paper-composition scope. No blocking correction requested.** This is not a proof that PlattGRH has been removed from the current Lean development. The actual source still takes it; the shared finite spectral assertion, formalized intermediate arguments, compatible global-provider proof and final elaborated type/axiom checks remain required.

Reviewed author: `integration/CURRENT_ROOT_ASSEMBLY_2026-11-11.md`, SHA256 `43D3C9522BD97E083BD276CE38D69BF80A00A9E3DF0A24B678A3A892A86F0705`. All 42 source/packet rows in its version table were independently rehashed and match. I read the frozen note in full. No author bytes were changed. Work consisted of source/packet reads, hashes and five small exact Fraction comparisons; no Lean build, evaluator, spectral computation, process probe or new declaration was performed.

## 1. Exact target and source root

I reread `Statement.lean`, `MainTheorems.lean`, `Helfgott/Defs.lean`, `Inputs.lean`, `Main.lean`, `Numerics.lean`, `SmallCases.lean`, and `Ladder/Main.lean` at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`.

The intended large conclusion is exactly `TernaryGoldbachFrom (10^27)`: every natural odd N with the inclusive lower bound is a sum of three natural primes. Neither distinctness nor an upper bound is present. The full `Statement` covers odd N with `5<N`. Its sole permitted mathematical premise is the original `BinaryGoldbachInput`, with binary Goldbach for every even natural n satisfying `4<=n<=4*10^18`. A replacement spectral assertion or common psi envelope must be proved inside the development, not added to either root.

The source full root joins the inclusive `TernaryGoldbachUpTo (10^27)` and `TernaryGoldbachFrom (10^27)` conclusions. The small-case proof explicitly omits Platt. For `N<=4*10^18+3` it uses 3 and binary Goldbach for N-3. Otherwise its existing ladder gives a prime p with `N-4*10^18<=p<=N-4`, and binary Goldbach applies to N-p. Its rung index and upper bound 254638308 cover N=10^27. This review checks that source use and its declared range; it does not rebuild the ladder data.

At the representation-sum assembly the only direct conditional analytic calls are `major_arcs_input` and `minor_arcs_input`. The circle identity, `nonprime_input`, prime extraction and small-case bridge do not acquire Platt merely from sharing imported files or an enclosing section. Conversely, the existing explicit hGRH wrappers in `MainTheorems` and the instance-bound large proof cannot be declared repaired without new proof terms and a final expanded-type audit.

## 2. Scaling and strict final subtraction

The actual definitions give

`D=2+9/(196*sqrt(2*pi)), x=N/D, y=x/49`.

The source proves `0<D<=2.02`. Thus N>=10^27 implies x>=4.9e26 and y>=10^25, including the endpoint. The identity supplied to the major theorem is

`N/x=2+9/(8*sqrt(pi/2))/49`.

In the major arc substitution alpha=b/q+delta/x, the original cubic scales as x^2*y and the measure contributes 1/x. Its integrated scale is therefore x*y=x^2/49. The star smoothing is etaU at y, with the same alpha; it does not contribute another 49 or change the final phase e(-N*alpha).

The reviewed constants give representation-sum lower bound `.0028*x^2/49`. The existing unconditional nonprime estimate is `6.7e6*N*sqrt(N)*log N`. The source's six-square-root argument sets v=N^(1/64), proves v>=2.64 and bounds that quantity by `158900000*v^97`. Since D^2<=4.0804, division by x^2/49 gives at most

`158900000*4.0804*49/(2.64^31)`.

I independently checked the strict comparison with .00271 by exact fractions. Its integer form in the author note is correct: multiplying by the positive denominators yields

`158900000*10201*49*40*25^31 < 271*66^31`.

No stronger analytic estimate or monotonic-log lemma is needed for this step. Subtraction yields the **strict** positive lower bound `.00009*x^2/49`, since `1.0404-1.0376-.00271=9/100000`. The old .0114 numerical wrapper is insufficient as a named result, even though its internal proof supplies the sharper comparison. The finite-sum extraction uses nonzero representation sum and the implication from the selected predicate to primality; it does not require an additional positivity theorem for each smoothing weight.

## 3. Major and minor dependency checks

The latest major-final join, not the old pointwise residual theorem, supplies the 1.0404 constant. Its main value 1.052105346, fixed loss .002834895 and dynamic loss below .008778 give 1.040492451. The author correctly retains actual character/Gauss weights, both removals and the mixed norm remainder. The lower energy J uses the weighted principal Ep over all q, with its stronger bound `Ep<(.00020001)^2`; `Ep<=1e-4` alone and an isolated q=1 assertion do not prove that step. The independent low-star integral bound removes a potential dependency on the later minor estimate. The qualitative smoothing result is not substituted for the sharp 900/106000 bounds.

I checked the following separate branches in `MinorTotal`, `Thm1321`, `LinftyLevels`, `EBound`, `NumericsFinal` and `LSQuot3`:

* The complementary coefficient energy remains `sum norm(a2)^2<=8e-11*x`. The unconditional EBound relaxation can prove this with its own weaker global constants; alternatively the repaired P1/P6 interfaces recover the relevant original estimates. These are sufficient routes, not extra requirements on the final nonprime subtraction.
* The actual a1 is supported on primes n>sqrt(x). The new smoothed energy proves summability and bounds T by `(.65*log x-.021095)*x`. It does not establish the old sig expression or the old signed Prop7.1.5 identity.
* The lower J bound and the unchanged a2 energy, with split parameter 1e-5, provide `I0>=8.6294*x`.
* The base-gap input at level150000 and the off-y-arc input for higher levels are distinct. The gap only needs `y*ghatY(y,150000)`; the old `.0121*y` conclusion need not be recovered.
* The repaired integrated layer theorem uses the separate quotient large-sieve branch through `LSQuot6` and `LSQuot3.regionS`. Type II's own S2 large sieve does not repair this branch. The elementary regionS proof is for its actual large-q/small-R production call, not the more general old c'-parameterized theorem.
* The numerical proof must be rebuilt for the changed sig and enlarged ghat, keeping the same nine finite x-cells and asymptotic coverage. All source level, radius, prime-support, logarithm and summability conditions remain present. `numerics_M` for old definitions cannot simply be cited.

The source's initial layer coefficient can be signed. For a nonnegative added envelope e, expanding its contribution gives `e(r0)*(cL(r0)*sigma/Dx-8.6294)`, which is at most `e(r0)*cL(r0)*sigma/Dx`. The middle terms are nonnegative, and the terminal term is nonnegative under the retained `cL(r2-1)<=Dx` condition. This validates the author's comparison without falsely asserting full coordinatewise monotonicity of Mexpr.

Both reviewed H1 and H2 envelopes are retained. Their combined complete layer cost is below 2e-24, including the terminal term. This fits the conservative replacement cap 1.037001. My exact check gives

`1.0005*1.037001+2001*22.75*8e-11 = 12969039279/12500000000 = 1.03752314232 < 1.0376`.

The finite sharp-totient result for q<=2^1000 has an unrestricted comparison radius subject to its original inequalities; the remote repair does not prove the original unrestricted `div_totient_lt`. The author preserves this distinction.

## 4. Latest prime, Mobius and finite-spectrum amendments

The ten-producer table agrees with the source-facing boundary: P1-P7, the Liouville/coprime Mobius estimate, the T2 estimate and the selected totient consumers. In particular P7 is a main Type II dyadic log-square input; it is not omitted. P2/P3/P6 have elementary replacement routes; the common two-sided E input supplies the other prime estimates and the modified Mobius induction. The root nonprime estimate is independent of this P6 route.

The new selected psi route retains the RH head through1500, count1069 and Q1500<1.668, hence the stated undamped head bound 3571/1500. It uses the same closed shared .555 strip through60343058, true orders and the genuine global7/8 provider. The extra narrow strip through one million and W35<24 are no longer selected requirements. The external finite grid comprises 6439 windows through5e9; the analytic branches cover from5e9 to exp35 and from exp35 onward. Their finite/formal acceptance remains open. The note properly keeps the .011 real-floor transport where the only available input is the integer assertion from1e9.

The Mobius profile is .03 before100000001 and .10 afterwards, starting at11815. Its modified 214-cell induction and infinite tail remain necessary; an upper-only psi estimate cannot supply the absolute error input. The new G2 bound is .0089, not .0082. Independently,

`1.4423050431/4+9.2185538/10000+(5/4)*.0089 < .37273`.

For the gap, m is the original rational modulus and q=m/gcd(m,2) is the modulus after doubling alpha. The original character expansion stays at m. The range `1200000/49<=u<1200000`, with u=2q|d| and d=(alpha-a/m)y, is correct. The selected low-prefix and high-u intervals overlap for q=1,2,3; q>=4 has its distinct finite-family comparison. No part of that conditional coverage certifies the finite family itself.

The minimum height must remain `min(Hp_old(c),1e8/c)`, without rounding it upward. Actual conductors, inverse characters, closed-height endpoints and nontrivial real zeros remain obligations. The accepted closed-cover/deflation assembly permits allowed left-boundary zeros only after exact vanishing/divisor and whole-boundary quotient certificates; it supplies an acceptance rule, not missing data. Sampled nonvanishing or small local pilots cannot fill this gap.

## 5. Limits and final disposition

No additional independent input or normalization defect was found at the inspected final-consumer boundary. This conclusion comes from following the actual calls and reviewing the replacement arguments, not from a textual absence of Platt, a standard axiom list, or the old status reports.

The main outstanding work is unchanged: validated global-provider proof terms and adapters; complete shared finite certificates and formal head/data acceptance; formal smoothing, zero-sum, psi, prime/Mobius, energy, totient/quotient and modified numerical arguments; then revised root assembly. The source currently remains conditional. Only a later expanded-type and transitive-axiom audit can verify that the full theorem has exactly the original binary premise and the large theorem has none.

For additional source provenance, the files directly checked here but absent from the author's source table have these SHA256 values:

| Source under TernaryGoldbach | SHA256 |
| --- | --- |
| Helfgott/Defs.lean | `4CE6EA7FB475024DF403775F9480D7D01B6336A798E0CF254BD61B5AFEC79DC7` |
| Helfgott/SmallCases.lean | `61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359` |
| Ladder/Main.lean | `A68289240152DDF2D6ADBD98A0055B45284D924F4F64820D851C01CA6FA250E9` |
| MinorArcs/LinftyLevels.lean | `12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409` |
