# A squarefree-only finite condition for the enlarged Wstar allowance

2026-11-11. Conditional paper implication and exact metadata only. No zero, prime, L-function or transform values were evaluated; no build or Lean declaration was made. Prior frozen reports are unchanged.

The enlarged A allowance admits the concrete sufficient strip beta<=0.5357 through the existing floor300 star heights, only for squarefree primitive conductors. No nonsquarefree finite spectral condition is needed for A. The separately reviewed conditional direct bound B<1915 replaces the star-side B certificate. However, this does not reduce the current full spectral union: the finite-RH plus requirement already covers all these heights and all primitive conductors, and base-gap remains separate. The isolated A task is smaller; the present total certificate is not.

## 1. Exact conditional consumer

Use the reviewed cubic reallocation at R=132900, x>=4.9e26 and y=x/49>=Y=10^25. Its new plus radius is rho=5.12e-7. Under its plus/principal/analytic inputs, A<=1e-10 and B<=2000 suffice without increasing the old cubic error allowance. The review also accepts the conditional direct-sieve estimate B<1915. Its coefficient theorem and principal-only source localization remain dependencies; this report does not make them unconditional or erase bundled source hypotheses by assertion.

The remaining spectral quantity is exactly

    QA = sum_(c>1) omegaA(c) sum_(chi primitive mod c)
             sum_(rho in closed finite carrier) m(rho)Y^(2 beta-2),
    omegaA(c)=sum_(eligible q) mu(q)^2 c/phi(q)^3.

Eligibility is q in Qset(R), c|q, q/c squarefree and coprime to c. This is the actual Gauss-weight contraction. Every multiplicity and both ordinate signs are retained, including nontrivial real zeros. Inverse characters merely permute the character labels; no halving is performed.

If c is nonsquarefree, every eligible q is nonsquarefree, so omegaA(c)=0 exactly. Active squarefree primitive conductors here are odd c<=R. Conversely q=c and q=2c are eligible for every such c, so omegaA(c)>0: there is no further conductor deletion merely from this weight.

## 2. Finite weighted condition and a usable uniform strip

For each retained squarefree conductor use

    Hstar(c)=ceil(max(300,(704/343)*(1063200/(2c)))).     (1)

The complete source/paper floor300 argument gives the full-strip Gram constant G=7e6 and actual remainder norm TA<8e-9. Its tail uses only the unconditional0<beta<1 above Hstar, not global QRH. It keeps zero-at-zero, vertical and coprime-removal terms. Restricting to squarefree conductors does not increase its nonnegative remainder majorant.

Therefore the exact sufficient weighted test in this proof is

    QA <= Qmax = (1e-5-8e-9)^2/(7e6)
               =1560001/109375000000000000000000.      (2)

Then sqrt(A)<=sqrt(G QA)+TA<1e-5, so A<1e-10. This is the direct certificate interface; it does not demand a common beta cap when a cheaper weighted enclosure is available. It is only a sufficient interface within the chosen Gram/remainder bound, not a characterization of actual A.

The independently reviewed floor300 metadata bounds the critical-line count baseline by

    q0=1160130359892187791/
         5000000000000000000000000000000000000.

This is an upper bound for sum omegaA(c) Cchi(Hstar)/Y, not an upper bound on actual QA without a spectral input. If every retained zero has beta<=5357/10000, then

    Y^(2 beta-2) <=Y^-1*10^(357/200)<61/Y,

because the exact integer comparison61^200>10^357 holds. The companion checks

    7e6*61*q0 < (1e-5-8e-9)^2.                       (3)

Thus this squarefree-only finite strip proves (2). The same carrier, counts and kernel cover arbitrary orders, central zeros and closed top heights. Interval boxes crossing the beta boundary are not sufficient location evidence; the existing whole-contour/finite-carrier acceptance obligations remain.

The uniform-strip boundary in this particular coarse comparison is narrow. Its available multiplier is exactly

    Qmax/q0=499200320000000000000/8120912519245314537.

At beta=.5358 the exponent is1.79. The exact checks (308/5)^100<10^179 and (7e6)*(308/5)*q0>1e-10 show that this selected upper-envelope expression already exceeds the allocation, even before the remainder. This is a failure of this sufficient comparison, not a lower bound on actual QA or A. A sharper count, weighted-P kernel, nonuniform beta profile or direct A proof can improve it. The report does not claim global optimality or that .5358 is mathematically impossible.

## 3. Direct B composition and what is removed

No QB test is used in this new A-only implication. In particular the earlier nonsquarefree beta<=.62 condition may be dropped from the star-side proof when the reviewed direct B estimate and its hypotheses are supplied.

For an independent scalar check, the companion verifies44.722^2>2000,2.964^2<8.79 and

    1.902e-6+1e-5+5.12e-7*44.722 <2.964*1.194e-5.

The cubic reallocation review proves that this normalized moment allowance preserves the original complete cubic budget. No new Wplus or principal bound is invented here, and the right side is not the old narrower Wstar-only allocation.

## 4. Isolated A footprint versus the actual global union

Exact squarefree factor metadata gives:

| Isolated A carrier | Conductors | Primitive labels |
|---|---:|---:|
|All odd squarefree c<=132900, c>1|53861|2532069219|
|Large branch c>10000|49806|2517716220|
|Small branch c<=10000|4055|14352999|

The squarefree maximum Hstar is363700 at c3. Every large-branch A conductor has Hstar=300, hence the old5/64 grid would have3841 nodes. If one deliberately used the existing full-input fixed-order pruned character evaluator for just that isolated grid, its exact counts would be:

    residue inputs 11554576707360,
    primitive outputs 9670548001020,
    G 292079020835890, A 602464577890232,
    Q 26031891874688, N 5054279716, S 25578754170880.

G/A/Q/N/S are the previously reviewed complex-product/addition/quarter-turn/negation/dyadic-scale categories. This is a hypothetical evaluator schedule, not a construction of a .5357-strip certificate. A strict-sign Turing certificate would prove the stronger RH statement and may retain multiplicity/separation difficulties; a contour or weighted certificate has its own costs. No actual saving is credited from replacing one certificate type with another without an implementation/error/coverage plan.

At present the plus consumer still asks for RH through

    Tplus(c)=ceil(200+max(260,u(c)*3.1416*1063200/qt(c))),

with u=23.3 except u=19.89 for even c>60000. The base-gap height is also at most this proposed plus height. For every squarefree A conductor, u=23.3 and the plus height strictly dominates (1); its critical-line statement is stronger than beta<=.5357. The script checks all53861 comparisons, and the general coefficient/floor comparison is immediate. The reviewed full large-branch inventory already checked the entire plus/base/star union.

Consequently the full current requirement remains all primitive labels at Tplus, plus the retained principal input. Nonsquarefree conductors disappear only from this A proof, not from the full plus or base-gap hypotheses. Even deleting the entire A certificate would leave the same current global union. This is the quantitative obstruction to claiming a total spectral reduction from this reallocation alone.

The same reasoning applies to further shortening Hstar: while it stays below Tplus, it cannot lower the union. Moreover the present floor300 tail proof uses a specific Gaussian twist/height ratio and separate EB/EA sums; it cannot be reused at an arbitrarily lower cutoff without new tail estimates. There is no reason to optimize that cutoff for total current cost before another consumer changes.

## 5. Next useful change and proof scope

This task supplies one coherent A-only candidate: test the exact weighted condition (2), with the squarefree .5357 strip through (1) as a convenient sufficient fallback. It removes unnecessary nonsquarefree star spectral requirements after direct B, but produces no current total-work saving. A consequential next step must replace or weaken the remaining plus/base-gap spectral consumer, or show how its existing certificate also yields the weighted test with negligible extra checking. Repeating A-only height reductions cannot do that.

No actual zeros, sign lists, count certificates or contours were generated. Canonical source character transport, whole-carrier completeness, true-order accounting, the floor300 analytic wrappers and all proof-system implementations remain governed by their prior contracts.

## Evidence

The new script uses only integer factor metadata, rational comparisons and exact integer powers. It binds the frozen floor300 receipt, reuses the reviewed character-circuit metadata definitions without running an evaluator, and refuses to overwrite its own receipt. The saved counts are not an empirical zero count. Reproduction uses the existing interval-environment Python on `wstar_A_only_reallocation_20261111.py` in a separate replay location.

The key predecessor pins are floor300 author E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794, review422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4, and receipt7750B7D1BB25A96D9B4F54A75C4090B9C7ECE591D905DEDC7D244FBA12CCDAD5. The reallocation author is7A5B81DA0290BE52D8E64A521702D0299114FF9DE2923E1897AE608E5241ECAD at `major-constants/PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md`; its independent review is `audit/REVIEW_PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md`. The conditional plus-height author is3F91F39B485607833A5FADD061BEC7602B1DCC02C77B8FB82CA10B6C076FA6A0. The script binds character metadata074E6B512F595DD174C45F3D273212FDFCF76CD6EFF6F82699F260E447CA986D.

The independent reallocation review has SHA256 `AD993398C6E41DCCE3A9826C0FA5BF6DA89A3B0139672429D7BD61E797DE9F0E`. The new script `zero-sum/wstar_A_only_reallocation_20261111.py` has SHA256 `815E1348E9D4C1AF39E5F6A185F5534A1C096C2A520E64EDB747F47E2595FAC5`, and its JSON receipt has SHA256 `7C04E9D875083A922B6EE9689F4B74969F55C6C3B6E5B5620D825F63A3BD91D8`. All agent paths are under `work/qrh-campaign/agents/`.
