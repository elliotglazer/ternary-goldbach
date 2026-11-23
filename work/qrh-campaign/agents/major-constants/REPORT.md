# Major-arc QRH replacement audit

Source commit is 23b2d68ca344203d4384e0aff7affa4ec034bef9 in calr3/ternary-goldbach. This report records a source audit and exploratory floating-point arithmetic. It proves no replacement analytic estimate. No Lean files were edited or built.

## Result

The current major-arc proof cannot consume the available coarse QRH strip estimates at x >= 4.9e26. The obstacle survives the correct character aggregation and the integration over arcs. A bound of the form |E_chi(z,delta)| <= C z^(7/8) would need C about 1.27e-4 for the cubic major-arc budget alone under the existing worst-conductor aggregation. Preserving the current intermediate bounds is more demanding. The etaPlus character coefficient must be at most 1.6831e-6 for uniform conductor-independent C, or 9.2186e-4 when the bound includes 1/sqrt(conductor).

These are requirements on one particular error analysis. They do not disprove a QRH-based proof. Estimates using cancellation among zeros or characters, estimates integrated in delta, smaller local heights, and improved finite input can change them.

## Exact consumers in the pinned source

All paths below are relative to TernaryGoldbach.

- MajorArcs/Prop942.lean defines errP and errPZ as a zero-height term divided by x, E1g divided by sqrt(x), E2g for the high-zero tail, and VgL divided by 2*pi*x*sqrt(x). prop_9_4_2 consumes GRHUpTo at T0 >= 200 + max(10*pi*|delta|,50). Replacing the exponent requires replacing the actual low-zero argument and its Mellin evaluation.
- MajorArcs/Thm714.lean lines 568-680 uses Platt for the three output lemmas. The principal etaPlus bound is 1e-18 + 6.24e6/sqrt(x), for |delta| <= 600000. The nonprincipal bound is (7.5e-8 + 7.7e6/sqrt(x))/sqrt(q), on odd q <= 150000 with |delta| <= 600000/q and even q <= 300000 with |delta| <= 1200000/q.
- MajorArcs/ArcChars.lean lines 192-232 proves the exact character mean-square identity and its upper bound. If every nonprincipal |tau(psi) S_psi| <= E, the aggregate nonprincipal contribution is <= E^2. The division by phi(q) cancels the number of characters. The Gauss factor sqrt(conductor) still matters.
- ArcChars.lean lines 323-465 turns the previous primitive-character bounds into E_plus <= 4.25e-7*x and principal error F_plus <= 2.83e-7*x. The coprime-removal error is <= 1e-15*x.
- MajorArcs/ArcCharsStar.lean lines 112-245 uses |E_star|/y <= 1e-17 + 4.7e6/(sqrt(conductor)*sqrt(y)) with y=x/49. Its aggregate and principal bounds are both 1.49e-6*y. Coprime removal is <= 1e-12*y.
- MajorArcs/MajorTotal.lean lines 165-193 proves residual squared <= 3*(phi(q)*D^2 + E^2 + phi(q)*|mu(q)/phi(q)|^2*F^2). Lines 231-296 obtain r^2=7.83e-13 for the normalized etaPlus aggregate residual and u^2=1.34e-11 for etaStar. Lines 731 onward round their square roots to r=8.85e-7 and u=3.67e-6.
- MajorArcs/MajorTotal.lean lines 992-1044 sums the cubic error with sum mPhi2 <= 2.85, sum mPhi <= 13.59756, and major-arc L2 <= 8.79*x. The main term is >= 1.314*0.800689*x^2/49. The fixed smoothing loss is 2.03e-5*x^2 times sum mPhi2.
- MinorArcs/MinorTotal.lean lines 69-87 defines sig, Dx, Mexpr and NumericsGoal. Its analytic assembly yields 1.0376*x^2/49 assuming the preceding estimates and Mexpr <= 1.037. Lines 137 onward and 206 onward also use Platt through the small-prime L2 bound, total L2 bound and major-arc lower L2 bound.

The final major arcs use q <= 300000. The larger q <= 400000 in Platt's declaration is not directly the modulus bound of this consumer.

## Cubic error budget

Write r*x for the etaPlus aggregate residual L2 norm at a fixed modulus and beta, and u*y for the etaStar pointwise residual, with y=x/49. Retain the source's major-arc L2 upper bound 8.79*x and all Fourier and singular-series constants. The summed normalized error is

    8.79*u + 195.03050754794666*r + 0.002834895.

The main term is 1.052105346. The dynamic budget remaining above the minor-arc bound 1.0376 is 0.011670451. Hence the sufficient inequality for this cubic calculation is

    8.79*u + 195.03050754794666*r < 0.011670451.

The current r,u produce 1.04906558970082, which is rounded down to 1.049 in Lean. Holding u at its current value gives r < 5.9673698471e-5. Holding r at its current value gives u < 0.0013080601822. Both statements assume the L2 and minor-arc constants have already been established with the new estimates.

At x=4.9e26 and y=1e25, x^(-1/8)=0.000461026075864 and y^(-1/8)=0.000749894209332.

For a hypothetical uniform primitive error C*z^(7/8), applying the current worst-conductor Gauss estimate at q=300000 and the factor-three residual inequality yields

    r = sqrt(3*(300000+1))*C*x^(-1/8)
    u = sqrt(3*(300000+1))*C*y^(-1/8).

The cubic budget requires C < 0.000127471356446. With a hypothetical primitive error C*z^(7/8)/sqrt(conductor), the corresponding r=sqrt(6)*C*x^(-1/8) and u=sqrt(6)*C*y^(-1/8) give C < 0.049369526346. The use of the same C for both smoothings is an explicit modeling assumption.

## Intermediate targets

To preserve the current ArcChars outputs at the bottom endpoint, sufficient coefficient limits for |E| <= C*z^(7/8) are

| Primitive error model | etaPlus nonprincipal C | etaStar C |
| --- | ---: | ---: |
| Uniform in conductor <=300000 | 1.6830724560e-6 | 3.6276521876e-6 |
| Divided by sqrt(conductor) | 9.2185675008e-4 | 1.9869469339e-3 |

The principal etaPlus limit is C <= 6.1384814182e-4. Negligible coprime-removal and constant-tail terms must be reserved in a rigorous replacement. These figures allocate the full displayed output cap and therefore describe near-endpoint targets.

Using 400000 in a hypothetical larger modulus family shrinks the uniform coefficient caps by sqrt(3/4). The pinned cubic consumer itself uses 300000.

## Minor-arc base gap

MinorArcs/BaseGap2.lean lines 241-400 proves |S_etaStar| <= 0.0121*y on the gap between majorArcs(y) and majorArcs(x). The source gives the principal Fourier term <= 0.01125*y, uses sqrt(q) <= 548 and a coprime-removal error D <= 2e-9*y. BaseGap.lean lines 89-98 bounds the total by

    D + |M|/phi(q) + sqrt(q)*(E+D).

Consequently a sufficient uniform primitive-error target is

    E/y <= (0.0121 - 0.01125 - 549*2e-9)/548
         = 1.549091240876e-6.

For E=C*y^(7/8), this becomes C <= 0.00206574637008. This is a separate consumer from the cubic major arcs.

The gap uses |delta| between 600000/(49*q) and 1200000/q. Keeping conductor-dependent estimates through the character sum can improve the current sqrt(q)*sup(E) loss. A replacement must actually establish the resulting bound on this entire delta range. MinorTotal uses ghatY(y,150000) >= 0.0121 to absorb the gap bound.

## L2 sensitivity

MajorArcs/L2Major.lean lines 122-290 contains a reusable algebraic derivation before its numerical rounding. For t>0, principal error F=f*x, aggregate character error E=e_q*x and coprime error D=d*x, its lower and upper bounds after integration retain the exact width

    w_q*x = 1200000/qt(q).

Let m_q=mu(q)^2/phi(q) and W_q=2400000/qt(q). Summing gives, with the source Fourier integral limits 0.6392 and 0.640208,

    J_lower/x >= (1-t)^2*0.6392*sum(m_q)
                  -(1-t)/t*f^2*sum(W_q*m_q)
                  -d^2/t*sum(W_q*q),

    J_upper/x <= (1+t)^2*0.640208*sum(m_q)
                  +(1+t)*(1+1/t)*f^2*sum(W_q*m_q)
                  +(1+t)*sum(W_q*e_q^2)
                  +(1+1/t)*d^2*sum(W_q*q).

The script enumerates Qset(150000), calculates phi and squarefree indicators, and obtains the following exploratory sums.

    Number of moduli = 225000
    sum W_q = 22907983.53670072
    sum W_q*m_q = 3109746.2990135746
    sum W_q*q = 450000000000

The source instead uses a common width upper bound 1200000/x for the final roundings. Retaining exact widths materially reduces the pessimism.

For example, assuming uniform C=0.01 and t=1e-4 gives J_upper/x about 18.9336 and J_lower/x about 8.02893. This fails the current 8.79 upper and 8.6296 lower targets. Assuming uniform C=1e-4 with the same t gives about 8.70803 and 8.68975 and passes those two modeled targets. This calculation omits the tiny coprime error, whose original bound can be inserted. All prime-estimate dependencies in the minor arcs still require separate proofs.

## Available strip estimates and higher-threshold arithmetic

The Mellin worker's exploratory rectangle-Sobolev analysis proposes a low-zero bound

    x^(7/8) * Zstrip * 8.239 * sqrt(L),

where L is the total vertical interval length and Zstrip is a Jensen count per 3.48 window with radius 2.7. The moment inequalities, numerical integrals and rectangle lemma still require proof and certification. Taking L about 2e8/q, as in the existing height split, gives a coefficient about 116517.0554*Zstrip/sqrt(q). Its Gauss-weighted normalized error at the bottom x is 53.7174008*Zstrip. The current target is 4.25e-7. This route is far from closing the existing constants.

The already available exponential envelope has K about 105393 and a=min(0.28/(1+|delta|),0.005), according to the Mellin worker. Even at delta=0, summing this envelope over windows costs millions times Zstrip before multiplication by x^(-1/8). The elementary uniform transform estimate 4.72 still incurs the count of low-zero windows. These coarse routes do not give a useful current-threshold estimate.

Assuming a uniform C=1 error with no logarithms, retaining every other bound and using only the cubic budget predicts x around 10^57.8469. A conductor-weighted C=1 model predicts x around 10^37.1425. Preserving the current etaPlus ArcChars output with uniform C=1 instead predicts x around 10^72.8814. These are conditional scaling estimates, not sufficient Goldbach thresholds. They omit the change in low-zero constants, logarithmic factors, tail terms and every other analytic consumer.

Any threshold increase leaves a finite interval above 1e27 that the present BinaryGoldbachInput and existing large-case split must cover through an additional verified argument. No such coverage was supplied here.

## Next mathematical step

A useful replacement theorem should expose an explicit delta-dependent and conductor-dependent primitive error, together with an integrated squared error on each major arc. Deriving a loose pointwise strip bound first and maximizing over all delta discards too much. The fixed etaPlus bandwidth 200 and the small-q large-delta ranges are especially expensive. A proof could instead combine an effective zero-free region and zero-density or zero-sum cancellation for the low zeros, keeping QRH for the far asymptotic range. This requires new analytic work.

For a bounded next task, derive the generic exact-width L2 inequalities above in a scratch Lean module and independently verify the arithmetic in the script. This would provide a sound consumer for improved estimates. It would not discharge the QRH replacement.

## Reproduction and unproved premises

Run python work/qrh-campaign/agents/major-constants/qrh_budget_model.py. The saved JSON captures its output. Python uses ordinary binary floating point. The source-level finite sums should receive rational certificates before becoming Lean inputs.

Every hypothetical primitive error used by the script remains unproved. The common etaPlus/etaStar C, preservation of the Fourier and singular-series constants, survival of the prime-estimate and minor-arc bounds, certification of Mellin moment values, and any increased-threshold finite bridge remain obligations. The source constants were read from the pinned repository through the GitHub connector, with L2Major also checked against the local source after sandbox failure required an escalated read.

