# Actual-envelope and direct basegap branch review

Independent research review, 2026-11-10. No Lean compiler or source implementation. Reviewed the pinned project at calr3/ternary-goldbach commit23b2d68ca344203d4384e0aff7affa4ec034bef9 and the following notes:

- major-constants/BASE_GAP_VARIABLE_BUDGET.md, SHA256880489DAAD877D7585BC10A09185DED1B32305D961A6E6953D033FB342C24FEE.
- major-constants/base_gap_variable_budget.py, SHA2565E176FB0F084F6A6E1DB7562FC833594CC2B95E9BB5E83CF264B03342D970C18.
- independent-feasibility/BASE_GAP_ALTERNATIVES.md, SHA2563CDE26DD0699CD1BEEE48C94390D21172A77EB578E5255663E588C25039E913D.

## Verdict

Both requested deductions pass this paper-level review. The defined ghatY has a uniform lower bound greater than.04712 and the scaled allowance exceeds79 as stated. The direct convolution argument proves a conditional bound less than.038*y on the specified denominator branch. It therefore fits the actual ghatY consumer with margin. The direct branch retains the source Type I/II theorem's Fact PlattGRH requirement until that theorem's inputs are replaced. It is not an unconditional or Lean-validated basegap theorem.

The earlier artificial-inventory lower bound near.03485 does not obstruct this branch or the actual ghatY target. It only obstructed the narrower fixed.0121/.01398 targets for the specified absolute-envelope recipe. No claim about a newer family-detector obstruction is reviewed here.

## Actual ghatY lower envelope

Source PointwiseBound.R, GBound.Fr/Lg/gx and LinftyLevels.ghatY give, at n=150000 and t=log(y),

R(t)=.41415+.27125*log(1+H/(2*v(t))),
H=log1200000,
v(t)=t/3+log(9/601200).

All constants and the factor601200=2.004*300000 agree with the source. On y>=1e25, v>8 and0<H<14. The note bounds Fr from below using exp(gamma)>1.78 and directed bounds on loglog150000. The numerator quantities are nonnegative and sqrt300000 is bounded above, so all reciprocal comparisons have the correct direction. Dropping the positive y^(-1/6) and cubic terms, and using max(gx,hfun)>=gx, gives the stated lower envelope a*R(t)+b. The displayed rational a and b are positive.

The Euler constant certificate uses H5000-log5001, exactly Mathlib's lower eulerMascheroniSeq5000. I inspected eulerMascheroniSeq_lt_eulerMascheroniConstant in the pinned dependency. The positive Taylor lower sum at.577 then yields exp(gamma)>1.78. The logarithm checker uses the correct positive atanh-series remainder after range reduction, including reversed interval endpoints when multiplying the log2 interval by a negative integer. Nested logarithms preserve inequalities by monotonicity. The scalar script replayed successfully.

The derivative is exactly R'(t)=-.27125*H/[3*v*(2*v+H)]. For f(t)=exp(t/8)*(aR+b-epsilon), epsilon=.000482098, its derivative bracket is(aR+b-epsilon)/8+aR'. Using R>=.41415, .07<=a<=.076, b>0 and abs(R')<.01 gives the positive rational lower.00280355025. Therefore f increases over the entire domain. This argument differentiates the explicit lower envelope only; it does not assume differentiability or monotonicity of the max in ghatY.

At y=1e25 the directed cube-root and logarithm intervals give the claimed lower endpoint. The rational1333.5 is below y^(1/8); the multiplier aR+b-epsilon is positive, so replacing the root by this lower bound is valid. The checked result exceeds79.11134 and hence79. Independently the limit-style floor a*.41415+b exceeds.04712152 and hence.04712.

Thus, as paper inequalities for the source-defined function,

ghatY(y,150000)>.04712,
y^(1/8)*(ghatY(y,150000)-.000482098)>79

hold for every y>=1e25. No Platt input is needed for these inequalities about the definition. They do not themselves prove an upper bound for any exponential sum. In the scaled consumer implication all character errors and remainders not included in epsilon must be covered by the coefficient C<=79. The reserved epsilon accounts only for the stated.000481 main term and1.098e-6 removal terms.

## Direct branch: hypotheses and exact geometry

The branch assumes the rational a/q selected by wider-arc membership has reduced denominator Q for2a/q satisfying100000<=Q<=150000 and Q/phi(Q)<=1.05. For odd q, Q=q and the new numerator is2a. For even q, coprimality forces a odd, Q=q/2 and the new numerator is a. These reductions preserve coprimality, including when q is divisible by4.

In both parity cases the source wide-arc upper bound gives Q*abs(delta)<600000, where delta=(alpha-a/q)*y. At z=w*y the correct Approx2 parameter is Delta_w=2*w*delta. It yields delta0=max(2,w*abs(delta)/2) and pointwise t=delta0*Q. On1/20<=w<=8:

z>=5e23,
200000<=t<2400000,
Q<=150000<z^(1/3)/6.

The Approx2 error condition becomes(3/2)*Q*abs(delta)*w^(2/3)<=y^(1/3). Its left side is below3600000 and right side exceeds200000000. The remaining approximation-height condition Q<=(3/4)*z^(2/3), positive denominator, coprimality and real-equality/mod-integer condition follow directly. I checked the actual Approx2 and PointwiseBound.theorem_3_1_1 interfaces. There is no omitted w>1 rescaling restriction.

Notably the direct estimate only uses wide-arc membership and the displayed Q/totient restrictions, so it covers the relevant gap subset without requiring a stronger assertion about all selected rational approximations. It does not cover denominators outside that subset.

## Direct branch: pointwise constants

The first component of PointwiseBound.theorem_3_1_1, divided by z, has exactly the coefficient in the note:

(R(z,t)*log(t)+.8764)*sqrt(v/t)+2.526/sqrt(t)
 +2*[v*(3.25*log(t)+7.82)+13.66*log(t)+37.55]/t
 +3.8*z^(-1/6),

where v=Q/phi(Q). In particular the first term's square-root totient factor and the factor2 before L/t have not been lost.

On the central rectangle, z^(1/3)>79000000 and t<2400000 give9*z^(1/3)/(2.004*t)>140. Hence the logarithmic denominator is positive and exceeds4.9, while log(4t)<16.1. These imply R<.27125*.98+.41415=.679975<.68. This upper bound is uniform as y grows.

After replacing R by.68 and v by1.05, each remaining t-dependent term decreases for t>=200000. The derivatives of(A*log(t)+B)/sqrt(t) and(A*log(t)+B)/t have the stated negative numerators since A,B>0 and log(t)>2. Replacing t by200000 therefore gives a valid simultaneous upper bound. The sixth-root remainder is largest at z=5e23.

The independent exact check gives the central coefficient
C=593191013/20000000000=.02965955065.
The exponential Taylor bounds, squared rational inequalities, sixth-power comparison and geometry constants all passed. These checks do not use floating-point decisions.

## Direct branch: integration and tails

The source norm_S_etaStar_le_of_pointwise_Ici is an unconditional transport theorem with an explicit pointwise premise. It applies with w0=1/20 and a piecewise envelope C on[w0,8],17 above8. That piecewise function is measurable and bounded; multiplying by the Gaussian phi gives the required integrability. The endpoint choice at8 is harmless and the pointwise bound is valid there.

The central mass is at most the full positive Gaussian mass sqrt(pi/2)<1.254. Using it overcounts the tails harmlessly. At the lower tail17*integral_0^.05 phi<=17*.05^3/3<.000709. At the upper tail an integration by parts gives integral_8^infinity phi=8*exp(-32)+integral_8^infinity exp(-w^2/2). Since w>=8, the latter is at most exp(-32)/8. The note's bound below2e-9 follows from exp32>1e13 with ample margin. All tail estimates apply to the source unconditional trivial bound norm(S eta2 z alpha)<=17*z, so no unproved large-scale estimate is used outside the central interval.

Consequently the exact total is bounded by
379020785151/10000000000000=.0379020785151<.038.
This is below the independently proved ghatY floor.04712 by more than.0092179. The bound is uniform over every y>=1e25 and the entire stated wide-arc twist range; it is not an extrapolation from a numerical sample at the endpoint. It changes no arc, cell, major constant or final positivity budget.

## Source dependency and evidence boundaries

The direct central estimate explicitly uses the existing Fact PlattGRH-bound theorem_3_1_1. It cannot be called unconditional because its convolution transport and arithmetic are unconditional. Its application with an explicit v<=1.05 avoids using GBound's global totient upper bound at this step; dependencies already inside the Type I/II theorem remain.

The separate general off-larger-arcs theorem norm_S_etaStar_le_ghat is also conditional. The corrected integration map traces it through Prop1123b.norm_S_eta2_le_of_not_mem, GBound.norm_S_eta2_le_gx and the two components of theorem_3_1_1, with a separate global div_totient_lt edge in GBound. A finite q<=300000 totient argument does not discharge that variable-r global edge. Integration reports this classification corrected in MINOR_INTERFACE_MAP.md SHA256DE693366A449EF7A65E96272B6CD88D3856CC8250D585E74E717D9787596E996.

My check_base_gap_direct.py independently replayed the logarithm/exponential, square/sixth-root, interval, tail, exact total and compatibility checks, and reran the lower-envelope checker. All passed. The parent's denominator sieve count is a useful classification diagnostic, not needed for the theorem and not promoted here to a kernel-checked fact. The later complex-character detector discussion in BASE_GAP_ALTERNATIVES.md is outside this bounded review.

Remaining work: formalize the lower-envelope certificates and calculus, implement the exact direct-branch statement and application, replace the Type I/II theorem's tracked Platt-consuming inputs, check exact types and axioms, and treat the remaining denominators. No complete basegap or Goldbach closure follows yet.
