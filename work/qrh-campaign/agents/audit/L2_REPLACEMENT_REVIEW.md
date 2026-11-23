# Principal/nonprincipal L2 replacement review

Independent reviewer: worker 8. Date: 2026-11-10. No compiler run.
Pinned ternary source: 23b2d68ca344203d4384e0aff7affa4ec034bef9.

Reviewed snapshots:
- L2_REPLACEMENT.md SHA256 0AAFA6C61ADBB22C0478FF485815714A205679A5A6BA990EB6FAB6649C54D33D.
- QrhL2Structure.lean SHA256 5CCD50A98302DBC0F327BA9D67D847A3470E4CA3977B4F4EC844A9D60866DA52.

## Verdict

The principal/nonprincipal decomposition, normalized removal error, two upper-budget reductions, and local q=1 implication for the full lower bound are mathematically valid. They retain the correct Gauss weights, principal coefficient, and coprime corrections.

In particular, the proposed uniform q=1 estimate on |delta|<=4 is sufficient for J>=8.6296. It is not necessary to control nonprincipal characters for this lower bound. The uniform q=1 estimate remains unproved.

One tiny display correction was sent to prime_estimates: the J=10 cubic V cap is exactly3.404985663585025e-6, so the displayed3.40498566358503e-6 rounds upward. Use3.40498566358502e-6 or the exact value. All other displayed sufficient caps tested below round downward safely.

The uncompiled structural and rational helpers are not completed analytic replacement theorems.

## Exact principal decomposition

For each q let a_q=coprimePart q(cP x). Absolute summability and support on integers coprime to q follow from the existing cP summability and coprimePart construction. Define

    g_q(delta)=expTsum a_q(delta/x)/x,
    mPhi(q)=mu(q)^2/phi(q).

Bombieri.lean:114-120 gives the exact reduced-residue energy identity. Separate the principal character, use Schar_one_eq_expTsum and norm_sq_gaussSum_one from ArcChars.lean:161-180, and divide by phi(q)*x^2. The principal term is precisely

    mPhi(q)*|g_q(delta)|^2.

The nonprincipal term is precisely the N integrand in L2_REPLACEMENT.md:

    (1/phi(q))*sum_(psi!=1)
      |tau_q(psi)|^2*|Schar(psi^-1,a_q,delta/x)/x|^2.

No extra phi(q), q, or x factor is missing. The psi^-1 convention is correct. The exact imprimitive Gauss weights remain present, including zeros. All character terms are nonnegative.

The new principal_le_sum_units_sq is a direct extraction of the principal summand from this identity. It avoids the old sum_units_sq_bounds helper's irrelevant nonprincipal upper premise. Its argument is mathematically valid for q=1 as well.

There is no primitive-character or Euler-factor replacement in this structural identity. Any later attempt to estimate N using primitive L-functions must still transport the actual coprime coefficients and preserve the removed-prime corrections.

## Domain and normalization

J uses the delta variable, with d(delta)=x*d(beta). Since the squared S is divided by x^2, J is x^-1 times the original major-arc L2 integral. This is the correct source normalization.

For q in Qset(150000), 1<=q, qt(q)<=300000 and qt(q)>=2. Thus Dq=1200000/qt(q)>=4. Every local interval (-4,4) lies in (-Dq,Dq); equality at an endpoint causes no integration problem. Closed versus open endpoints have measure zero.

The source's arc decomposition and disjointness apply at x>=4.9e26 and do not require PlattGRH. Consequently the sum over full q,b arc domains represents the required major-arc energy.

All relevant exponential sums are continuous by absolute coefficient summability. There are finitely many moduli, residues, and characters, with bounded delta intervals. Squared norms, differences and products are therefore integrable on these domains. These facts need explicit Lean witnesses when the integrated statements are formalized.

## Removal energy

ArcChars.lean:314-321 gives the unconditional uniform estimate

    |S_etaPlus(x,alpha)-expTsum a_q(alpha)|<=1e-15*x

for every alpha, provided x>=4.9e26 and1<=q<=300000.

After division by x and squaring, the pointwise error is <=1e-30. Since phi(q)<=q<=qt(q),

    sum_q 2Dq*phi(q)
      <=300000*2400000
      =7.2e11.

Thus Eremove<=7.2e-19 on the full arc domain. On the restricted intervals of length8, the same upper bound follows from #Q<=300000 and phi(q)<=300000. There is no need to assume the coefficient removal is zero, even for induced principal characters.

## Upper reductions

The square split of g_q=P+(g_q-P) gives

    J_coprime <=(1+t)M0+(1+1/t)Ep+N,

where M0=.640208*13.59756=8.70526669248.

A second split for full minus coprime sums gives

    J <=(1+u)*((1+t)M0+(1+1/t)Ep+N)
         +(1+1/u)*7.2e-19.

The hypotheses t>0,u>0 are met by t=.0034,u=1e-6. Independent exact Fraction arithmetic yields:

    Ep<=1e-4, N<=.23:
      J<=8.9943853583173982939755294117647...<9.

    Ep<=1e-4, N<=1.23:
      J<=9.9943863583173982939755294117647...<10.

The numerical proofs in QrhL2Structure state these exact rational inequalities. They do not supply Ep or N.

For the alternate total-residual route, Minkowski gives sqrt(J)<=sqrt(M0)+sqrt(R). The quoted sufficient thresholds R<=.00245333049 for J<=9 and R<=.04486295356 for J<=10 are conservative. The exact thresholds are approximately.002453330494849138... and.04486295356802543....

A bound on the weighted cubic residual A does not generally bound Ep,N,R because its multiplier may vanish or be small. The note correctly identifies this limitation.

## Why the local q=1 estimate gives the global lower energy

Fix any x>=4.9e26 and assume

    |S_etaPlus(x,delta/x)/x-P(delta)|<=.001
      for every |delta|<=4.

This is a statement about the full untwisted sum near zero. For every q, the same source removal estimate gives

    |g_q(delta)-P(delta)|<=epsilon=.001+1e-15

on that interval. No nonprincipal estimate is used.

The source norm_sq_add_ge at L2Major.lean:23-38 gives

    |g_q|^2 >=(1-t)|P|^2-|g_q-P|^2/t,

with t=.00354. EtaPlusL2.lean:199-230 gives

    integral_(-4,4)|P(delta)|^2 >=.6392

unconditionally. The negative error integrates over length8, so

    integral_(-4,4)|g_q|^2
      >=(1-.00354)*.6392-8*epsilon^2/.00354.

This bracket is positive. Multiplying by mPhi(q)>=0, summing, and using the unconditional SumMuPhi.lean:108-114 lower bound sum mPhi>=13.597558 gives

    J_coprime,restricted
      >=8.630062009846626180528813528593... .

The principal energy lower bound from the structural helper justifies discarding every nonprincipal term. Positivity justifies discarding all arc regions outside(-4,4).

Apply the full/coprime lower square split with u=1e-6 and the restricted removal energy bound:

    J >=(1-u)*J_coprime,restricted-Eremove/u
      >=8.630053379783896333902632999779...>8.6296.

Thus the mathematical implication is sound. The local q=1 hypothesis must hold for every x for which the resulting lower theorem is claimed.

A weighted q=1 integral bound A1 alone does not imply this uniform local hypothesis. The note's final reference to a stronger q=1 result is valid only if that stronger result actually supplies the stated uniform error bound, as its wording qualifies. No claim of deriving L-infinity control from a weighted L2 bound should be made.

## Dependency audit and minor-arc consumer

The decomposition, norm square splits, removal bound, local Fourier energy, finite mPhi sum, and arc geometry have no Fact PlattGRH premise.

The old analytic ArcChars results begin under the scoped Fact at ArcChars.lean:342. The original Jq_bounds is scoped under Fact at L2Major.lean:97; the original l2_major_bounds is similarly conditional. None is needed for the new structural implications.

MinorTotal.I0_ge at line276 is currently under Fact because it invokes l2_major_14_7 for the lower major-arc energy. Its subsequent split into prime and nonprime powers uses the source squared nonprime-power bound8e-11*x and ordinary norm/integral inequalities. A replacement providing only J>=8.6296 can replace that particular input, but the existing I0_ge theorem still cannot simply be called without its required instance. The proof must be replayed or factored into an unconditional consumer.

Likewise the proposed upper bounds9 or10 do not prove the old upper8.79. They require the downstream cubic constants to use the corresponding new J, as the note explicitly does. Other Platt-dependent minor-arc inputs remain separate.

## Cubic arithmetic caps

For dynamic budget b=.011670451 and B(J)=2J+17.41053338496:

    J=9:
      A cap=9.61574237407910001452...e-7,
      V cap=3.783317403983361111...e-6.

    J=10:
      A cap=9.10167633416827229910...e-7,
      V cap=3.404985663585025e-6 exactly.

The displayed J=9 A,V and J=10 A values round down. The displayed J=10 V value rounds up and needs the correction stated at the top.

## Outstanding work

1. Prove the local uniform q=1 target, or a sufficient integrated principal lower target, for the full x range.
2. Prove Ep<=1e-4 and the chosen N bound, or an alternative sufficient upper-energy estimate.
3. Formalize the exact integrated decomposition and removal transfers, with all continuity, positivity, and domain embeddings.
4. Replace the conditional source consumers rather than supplying a Fact instance.
5. Compile the new structural and numerical helpers and inspect their exact types/axioms.
6. Recheck all downstream major/minor constants for J=9 or10; this is not the old8.79 conclusion.

No compiler, source mutation, new axiom, or final proof claim was made in this review.


## Superseding final-budget correction

The historical cubic caps here and in L2_REPLACEMENT.md do not reserve the final nonprime subtraction. They are insufficient for a full Goldbach closure claim. See BLUEPRINT_REQUIREMENTS.md and check_blueprint_budget.py for the corrected J<=10 route with coprime Aplus<=5e-7, Astar+Cross<=9.5e-7 and positive final margin .00009 after the explicit nonprime reserve .00271.
