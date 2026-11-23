# Full residual transfer review

Independent reviewer: worker 8. Date: 2026-11-10. Source-only audit; no Lean compilation.
Pinned ternary source: 23b2d68ca344203d4384e0aff7affa4ec034bef9.

Reviewed snapshots:
- AveragedResidual.lean: 662E4DAD9FF951EF4119ECC8929213E4BA95162A5621A6245009A46679A39893.
- FullResidualTransfer.lean: 435220CBFC068E216F4B7113D86A0E95D91CA63D93EDD6CD22DD7F1F2523886A.
- FULL_TRANSFER.md: 4EFDE5749B709F3C8B1FEBB663B79CF48AD7D1473803ACE61422B7BAA6D0EC86.
- transfer_budget.py: 778FB596CC332D385F260A1C0BBBA54D0A5FCC1357C950D91B96E5F3F2DDCB7D.

## Verdict

No substantive mathematical defect found. The perturbation inequality, source eta specializations, x/y normalization, weighted-integral transfer, and mixed-error arithmetic are valid under the stated analytic premises.

One display correction was sent to major_constants. The asserted upper value 9.696000000000329e-7 rounds down from the exact full-plus expression 9.696000000000329202531e-7. Use 9.696000000000330e-7 or the exact rational. This does not affect the final safe-cap comparison. The displayed full-star upper 1.930488246677245e-6 rounds upward safely.

The proposed Lean files are uncompiled. No root closure is claimed, and J<=8.79 remains unavailable without its separate Platt-free replacement.

## Generic perturbation

For t>0, the identity

    t*u^2 + v^2/t - 2*u*v = (t*u-v)^2/t

proves the scalar Young inequality. Combined with

    f-A = (g-A)+(f-g)

and the norm triangle inequality it gives

    |f-A|^2 <= (1+t)|g-A|^2+(1+1/t)|f-g|^2.

The sum_norm_sub_main_le proof then bounds |f-g|^2 by D^2 pointwise and sums. A separate D>=0 premise is unnecessary. At each member of the finite set, the assumed norm bound already implies D>=0; if the set is empty the conclusion is 0<=0.

The appended sum_units_perturbed_sub_main_le substitutes the earlier exact Parseval residual equality and divides by phi(q). q!=0 implies phi(q)>0. This correctly produces (1+t)/phi(q) multiplying the unnormalized spectral sum and (1+1/t)*#units*D^2 for the perturbation floor.

All previous inverse-character and imprimitive-weight checks continue to apply. No maximum over characters appears, and there is no unproved functional-equation input in this algebra.

## Actual source hypotheses

ArcChars.lean:314-321 states

    x>=4.9e26, 1<=q<=300000 ->
    for every alpha,
      |S_etaPlus(x,alpha)-expTsum(coprimePart q(cP x),alpha)|
        <=1e-15*x.

ArcCharsStar.lean:100-110 states the analogous bound for etaStar with cU(x/49) and floor 1e-12*(x/49). It derives x/49>=1e25 from the same x threshold.

Neither theorem requires a rational-arc restriction on alpha or a Fact PlattGRH instance. Their source proofs use summability, the coefficient removal sums, and the norm bound for expTsum. In these files the scoped Fact PlattGRH declarations occur later, at ArcChars.lean:342 and ArcCharsStar.lean:137.

FullResidualTransfer supplies x>0, summability of the coprime parts, and their exact support property. It applies these two source norm bounds for arbitrary real beta and bounds #units<=q<=300000. Its conclusions retain an arbitrary complex A. This is correct because the perturbation is independent of the chosen main term.

To use the Fourier targets, instantiate A=x*P(delta) for plus and A=y*U(delta) for star, with y=x/49 and beta=delta/x. The Gauss factor tau(1)/phi(q) equals mu(q)/phi(q) by the previously reviewed source identity.

The simultaneous explicit hypotheses [NeZero q] and 1<=q are redundant but consistent for these internal helpers. They do not introduce any new analytic input.

## Normalization

Dividing the etaPlus squared residual inequality by x^2 gives the normalized full residual Rplus and normalized spectral/copime residual Eplus. Dividing the etaStar inequality by y^2 gives Rstar and Estar. Both divisors are positive at the source threshold.

At t=.01:

    a=1+t=1.01
    bp=(1+1/t)*300000*(1e-15)^2=3.03e-23
    bs=(1+1/t)*300000*(1e-12)^2=3.03e-17.

Thus Rplus<=a*Eplus+bp and Rstar<=a*Estar+bs. The star floor has no missing factor 49; it was normalized by y^2. Eplus and Estar must include the factor 1/phi(q) from Parseval as well as their respective scale squared.

## Weighted transfer and mixed term

Multiplying the plus relation by |mU|^2 and integrating yields

    Aplus <= a*Aplus' + bp*49*7.78*2.85.

The 49 is the change of variable in U(delta)=Fourier(etaU)(-delta/49). The sum of |m|^2 uses mPhi2 and its bound 2.85. Similarly,

    Astar <= a*Astar' + bs*.640208*2.85.

Since Eplus,Estar are nonnegative,

    Rplus*Rstar
      <=a^2 Eplus*Estar+a*bp*Estar+a*bs*Eplus+bp*bs.

Integrating gives exactly the stated Cross bound. As a>=1 and Astar'>=0, replacing a*Astar'+a^2*Cross' by a^2*(Astar'+Cross') is a valid weakening used in transfer_budget.py.

## Domain-size bounds

MinorArcs/LargeSieveWeights.lean:26 defines qt(q)=q for even q and 2q otherwise. For positive q this gives q<=qt(q). LargeSieveArcs.lean:25 proves qt(q)>=2, and its line34 defines the actual Qset. L2Major.lean:295-304 proves #Qset<=300000.

The delta interval has width Wq=2.4e6/qt(q). Therefore:

    sum_q Wq <=300000*1.2e6=3.6e11,

and, since #units<=q<=qt(q),

    sum_q Wq*#units <=300000*2.4e6=7.2e11.

The first bound is the correct factor for the product of already-summed residual floors. The second is the correct factor for a pointwise bound summed over individual residue classes. No residue-count factor has been lost or counted twice.

## Integral upper bounds used only for the mixed floors

The plus spectral residual is also the squared coprime residual by the exact identity. The pointwise three-term norm bound gives

    integral_sum Eplus
      <=3*(J + .640208*13.59756 + 7.2e11*1e-30).

With the separate premise J<=8.79, the expression is approximately 52.48580007744 and is strictly below53. The main-square term uses phi(q)|m|^2=mPhi(q), explaining why its sum bound is13.59756 rather than2.85.

MinorTotal.lean:49-65 proves, for x>0 and every alpha,

    |S_etaStar(x,alpha)|<=22.75*y.

Its proof is unconditional and uses a trivial eta2 bound. The first scoped Fact PlattGRH in that file occurs at line137. MajorTotal.lean:475-480 gives |Fourier(etaU)|<=1.2534 without a Platt input. Since |m|<=1 and the normalized removal is at most1e-12, each normalized coprime-star residual has norm at most22.75+1e-12+1.2534.

Consequently

    integral_sum Estar
      <=7.2e11*(22.75+1e-12+1.2534)^2
      approximately4.1483751232323456e14
      <4.15e14.

These estimates do not prove the small spectral target. They only make the additive removal cross terms negligible.

## Exact arithmetic

The script uses Fraction inputs throughout its assertions. I independently reconstructed the expressions with Fraction and high-precision Decimal output.

With a=1.01, bp=3.03e-23, bs=3.03e-17:

    mixed = a*bp*4.15e14+a*bs*53+bp*bs*3.6e11
          = approximately1.2700246621959e-8.

From Aplus'<=9.6e-7:

    full_A
      =9696000000000329202531/10000000000000000000000000000
      =9.696000000000329202531e-7
      <9.73116250079e-7.

From Astar'+Cross'<=1.88e-6:

    full_AX
      =4826220616693110404600826281/
        2500000000000000000000000000000000
      =1.9304882466772441618403305124e-6
      <1.936851913302e-6.

Both final comparisons are exact rational inequalities with positive slack. The display-rounding defect noted above does not change either comparison.

## Outstanding assumptions and checks

1. The small coprime spectral targets Aplus'<=9.6e-7 and Astar'+Cross'<=1.88e-6 remain unproved.
2. J<=8.79 is still a separate Platt-free obligation. It enters both the averaged cubic bound and the coarse integrated Eplus estimate. The current source L2 theorem at L2Major.lean:306 onward has a scoped Fact PlattGRH.
3. The unchanged Fourier and finite singular-series bounds must be instantiated on the exact Qset and delta domain in Lean. Their use here is a source-based mathematical derivation, not a compiled integrated-transfer theorem.
4. The full averaged Cauchy-Schwarz argument, all nonnegative/integrable product functions, and the integrated transfer have not yet been formalized in the reviewed files. FullResidualTransfer contains the pointwise-in-beta finite-sum transfer only.
5. Both Lean files need narrow compilation, exact-type checks, and transitive axiom inspection. Importing conditional source modules does not itself add a hypothesis, but only the compiled dependency check settles closure.
6. The final major/minor-arc constants and the Goldbach root remain open. No root premise may be added to assume these spectral targets.

No other worker files were edited. Findings were sent directly to major_constants and the parent.


## Superseding final-budget correction

The earlier averaged residual caps in this report only control the difference between the major and minor integrals. They do not reserve the nonprime subtraction used by Helfgott/Main.lean. They must not be called sufficient for the full Goldbach theorem. The corrected blueprint route uses J<=10, coprime Aplus<=5e-7 and coprime Astar+Cross<=9.5e-7, gives full A<=5.050000000000330e-7 and Q<=9.817952468e-7, hence dynamic loss<.008778 and major>=1.0404. The original minor bound is1.0376. The existing final numerical argument also gives nonprime<.00271 in units x^2/49, leaving positive margin .00009. Exact rational implications were independently checked in audit/check_blueprint_budget.py. All new analytic premises and the revised final assembly remain unproved in Lean.
