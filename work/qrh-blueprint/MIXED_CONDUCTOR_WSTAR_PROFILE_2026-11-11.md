# A weaker star-location requirement for nonsquarefree conductors

2026-11-11. Conditional paper composition and exact rational checks. This supplies a sufficient Wstar profile, not actual zero-location evidence or a whole-proof cost reduction. Its cutoff/tail producer is independently reviewed separately. No Lean declaration, build or analytic evaluator was used.

Use the actual functions, weighted finite statistics QA,QB and remainder norms TA,TB of WSTAR_WEIGHTED_SPECTRAL_STATISTIC. Retain R132900, x>=4.9e26, y=x/49>=Y=10^25, the proposed plus-energy input and principal RH through1e8. Let

    Dc=8R/qt(c), H0(c)=ceil(max(1000,(704/343)Dc)).

The baseline producer's exact metadata includes conductor4. Its exact H0(4)=545549, and H0<=545550 is a safe global bound. The frozen producer's prose upper bound363700 omits this case; its forthcoming review must validate the analytic constants on the corrected range. This composition does not adopt the erroneous range.

For each primitive nonprincipal character, take a complete closed finite zero carrier through a height Hc<=H0(c), with actual orders, both signs and all real nontrivial zeros. Suppose its full-strip Gram/window conditions and actual normalized remainders are proved, with

    G=7000000, TA<8e-9, TB<.00048.

These are the producer's claimed bounds at H0. A lower Hc needs its own tail proof. Merely dropping zeros from a carrier does not preserve the remainder bound.

## 1. The two location requirements

Require every zero in the actual carrier to satisfy

    beta<=203/400=.5075, if c is squarefree;
    beta<=31/50=.62, otherwise.

Only the upper real-part bound is used. Same-character reflection and actual multiplicities remain part of the underlying spectral and count interfaces. This does not silently replace an RH hypothesis in the plus or base-gap branch.

For A, the exact supported conductor weight is

    omegaA(c)=sum_eligible_q mu(q)^2*c/phi(q)^3.

If c is not squarefree, every multiple q is not squarefree, so omegaA(c)=0. In particular every primitive conductor divisible by four disappears from A. Such conductors still occur in B and in the other proof branches.

The baseline count report gives uniform upper bounds for the all-critical-line comparison quantities

    LA<2.335e-19, LB<5.966e-12.

These bounds are based on analytic zero-count majorants and exact arithmetic weights, not sampled or discovered zeros. Since Hc<=H0(c), monotonicity of complete counts preserves these same comparison upper bounds at Hc. Their interpretation as actual QA,QB requires the location assumptions above.

For squarefree c, the largest coefficient relative to the line weight is

    Y^(2beta-1)<=10^(3/8)<12/5,

where (12/5)^8>1000 proves the last inequality without numerical exponent evaluation. Hence QA<(12/5)LA. For B, all retained zeros obey beta<=.62, including the squarefree ones. Its factor is exactly

    Y^(2*(31/50)-1)=10^6,

so QB<=10^6 LB. All coefficients remain nonnegative; no cancellation or average-per-character replacement is used. For scales y>=Y, y^(2beta-2)<=Y^(2beta-2), so the same envelopes are uniform over the unbounded scale.

## 2. Full moment and budget

The reviewed Gram/remainder implications give

    sqrt(A)<=sqrt(G QA)+TA,
    sqrt(B)<=sqrt(G QB)+TB.

Exact scalar comparisons prove

    G*(12/5)*LA <(2e-6-8e-9)^2,
    G*10^6*LB <6.47^2,
    6.47+.00048<6.48, 6.48^2<42.

Consequently A<4e-12 and B<42. The independently reviewed weighted-principal root budget permits A<=4e-12,B<=62, so this profile meets the full Wstar target with reserve, conditional on the stated plus, principal, count, location, Gram and tail evidence. All principal/removal and mixed terms are paid by that root budget.

This weakens the earlier uniform .5075 sufficient star profile on every nonsquarefree conductor. It is a mathematical relaxation, not a verified speedup: proving a strip bound can have a different cost from proving finite RH, and the actual evidence has not been produced. The same unweakened plus/base-gap requirements can still dominate the certification work.

## 3. The end-to-end height test

If separate accepted finite-RH arguments for plus, star and base gap require heights Hplus(c),Hstar(c),Hgap(c), then a shared finite-RH certificate through their maximum suffices by restriction. Costs should be charged to that union once, rather than summed as three full spectra. This sharing requires the same actual functions, closed-height and multiplicity conventions, and any auxiliary/guard domains must also be included.

Conversely a shorter star cutoff alone does not reduce the union where another consumer still requires the old height. With different location bounds, a height maximum alone also loses information: the strongest required real-part bound at each height must be retained. The relaxed .62 star requirement cannot discharge a critical-line requirement from another consumer. No union saving is claimed in this note.

Pending research on a lower fixed floor for the star tail can use this composition if it proves the same or smaller remainder norms and its full-strip window domain. The monotone baseline argument above permits smaller heights; it does not prove their tails or their finite location evidence.

## Evidence

The exact script check_mixed_wstar_profile_20261111.py reads the pinned baseline JSON and performs only rational comparisons. Its output mixed_wstar_profile_20261111.json does not enumerate or evaluate zeros. The analytic count and tail arguments remain separate proofs.

| Input | SHA256 |
|---|---|
|agents/zero-sum/WSTAR_CUTOFF_BASELINE_TRADEOFF_2026-11-11.md|55D2E58DA0F13A77ECC3AB097E5CAC45D58EE247178F8A8D5824756A45E1C2AB|
|agents/zero-sum/wstar_critical_baseline_metadata_20261111.json|A5CA555478A01B9785FB7F04D754AB547CCE280775862DB76863511CB29FAE18|
|agents/audit/WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md|AFDBBF90157F5170666C481D512D475A1F719366C8FB785D312A213864C38D0B|
|agents/independent-feasibility/REVIEW_WSTAR_WEIGHTED_SPECTRAL_STATISTIC_2026-11-11.md|85849ED642AEED600A71F41E56D4C7DC86ACAB23F338E19979CD15B58B8D60DE|
|qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md|22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7|
|agents/prime-estimates/REVIEW_WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md|52C3D991DE018E5B21682DD498819A5DDC66BDE484A43969DDB54026CE4E40D5|

Agent paths are under work/qrh-campaign; the root path is under work. Independent review of this new composition is pending. Actual aggregate plus/base-gap bounds, principal and finite arithmetic certificates, source refactors and kernel validation remain open.

DRAFT_ANCHORS: none created; repository-wide state not audited.
UNREGISTERED_SORRIES: none introduced; repository-wide state not audited.
DRAFT_IMPORT_VIOLATIONS: no imports changed; repository-wide state not audited.
SEALED_THIS_TURN: 0.
