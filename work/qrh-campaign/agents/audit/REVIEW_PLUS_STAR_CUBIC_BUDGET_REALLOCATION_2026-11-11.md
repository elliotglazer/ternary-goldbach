# Review of the plus/star cubic reallocation

2026-11-11. PASS for the conditional paper implication and exact scalar allocation. No correction requested. The smaller plus radius permits the stated larger star moment allowance without enlarging the original cubic error constant. This does not establish the remaining actual A bound, finite RH certificates, or a Lean theorem.

Author: `major-constants/PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md`, SHA256 `7A5B81DA0290BE52D8E64A521702D0299114FF9DE2923E1897AE608E5241ECAD`.

I read the full note, scalar source and saved receipt, the integrated cubic and weighted-principal contracts, the plus residual adapter, and the relevant actual `MajorTotal` and prime-sieve bodies. I independently reconstructed the rational allocations without importing or running the author's script. No analytic function, prime, zero, spectral value, transform or integral was evaluated. No source or frozen artifact was changed.

## Actual residuals and scales

The domain remains R=132900, x>=4.9e26, y=x/49>=1e25. The q,b carrier and coprime character transform are unchanged. In particular Eplus already sums the nonprincipal numerator energy after character orthogonality; no extra factor phi belongs outside it. The principal constant vector is orthogonal to the centered coprime nonprincipal vector. With the independently reviewed direct-plus identity, the full numerator energy is at most

    [sqrt(Eplus + mu(q)^2*p0^2/phi(q)) + sqrt(phi(q))*d0]^2.

Here p0=2.83e-7 includes the inner principal removal and d0=1e-15 is the outer removal. Using phi<=265800<516^2 gives the claimed rho=5.12e-7, since rho-516d0>0 and its square exceeds 1.80625e-13+p0^2. This is a conditional improvement from the preserved old Eplus bound, not a new proof that the finite RH inputs hold. At q=1 the empty nonprincipal sum causes no exception.

Integrating in delta gives Z<.006^2 by the existing harmonic-sum bound. There is no additional phi here because each pointwise bound already summed over b. Together with a=.640208*13.59756<2.951^2, Minkowski yields X/x<(2.951+.006)^2<8.79=j. The weighted-principal argument uses the same Z. Its finite sum bound M3<=32/13 gives the main weighted norm <1.256 and hence ||a*s||<1.262. Thus

    ||s*v|| < 1.502e-6*1.262 + 2e-9*3
            = 1.901524e-6 < 1.902e-6.

This is already an integrated norm. Multiplying it by sqrt(j) again would be an error; the author does not do so. The prior weighted-principal proof and its principal-only inputs remain dependencies.

I checked the Jacobian independently. The physical measure is d beta=d delta/x, Sp=x*s and Ss-As=y*(u+v). Therefore

    49^2*Wstar/x^3 = ||s*(u+v)||_2^2.

Likewise Wplus is x^3/49^2 times the tagged integral of a_q^2*|Fourier etaUC(-delta/49)|^2*|r|^2. The Fourier change of variable contributes 49, so its normalized upper bound is 49*rho^2*v, v=7.78*2.85. The factor 2.85 bounds the actual sum mu^2/phi^2; it is not a character average.

## Cubic identity and exact allowance

For the actual complex functions,

    Sp^2*Ss-Ap^2*As = Sp^2*(Ss-As)+As*(Sp-Ap)*(Sp+Ap).

Cauchy and the triangle inequality give sqrt(X*Wstar)+(sqrt(X)+sqrt(Y))*sqrt(Wplus). The oscillatory factor has norm one. This argument keeps the residual cross terms and requires no cancellation or probabilistic independence. All integrals have the same finite tagged arc carrier; the reviewed analytic regularity supplies their existence.

In units x^2/49, the proposed moment target gives the upper bound

    j*u + rho*sqrt(49*v)*(sqrt(j)+sqrt(a)).

The nonnegative rational envelope C=49*(j+a)/9+9*v/2 dominates the second coefficient, because (sqrt(j)+sqrt(a))^2<=2*(j+a) and

    C^2-98*v*(j+a) = [49*(j+a)/9-9*v/2]^2.

This matches the source's original three error coefficients. `MajorArcs/MajorTotal.lean:760` has the plus/star pointwise constants; `:808` integrates them; `:887` and `:905` supply the Fourier energy bounds; `:1020` supplies the 8.79*x upper moment. After summing and dividing by x^2/49, the old coefficients are exactly

    Eold = j*3.67e-6 + 8.85e-7*C
         = 64019155993729/312500000000000000.

The new choice u=1.194e-5 leaves the strict reserve

    Eold-j*u-rho*C = 248809290863/4687500000000000000 > 0.

The exact linear-envelope maximum lies between 1.194e-5 and 1.195e-5. Thus the claim about the largest multiple of 1e-8 is correct within this fixed envelope. It is not an optimization over all moment inequalities. The Fourier truncation error remains 49*2.03e-5*2.85 in the same units.

## Nonlinear A/B target

Write the normalized nonprincipal star contribution as u_q,b and keep its actual energy E_q=sum_b|u_q,b|^2. The definitions

    A=sum_q integral a_q^2*|P|^2*E_q,
    B=sum_q integral E_q

retain the source inverse-character and Gauss weights. Since s=a_q*P+r and max_b|r|^2<=rho^2, Cauchy on the tagged carrier gives ||s*u||<=sqrt(A)+rho*sqrt(B). Combining this with the integrated principal bound gives the stated sufficient frontier

    sqrt(A)+rho*sqrt(B) <= sqrt(j)*u-1.902e-6.

I checked all six rows separately with the lower root witness 2.964^2<j. For each row, 2.964*u-1.902e-6-sqrt(A) is positive before it is squared, and its square strictly exceeds rho^2*B. In particular A<=1e-10 and B<=2000 suffice. No conclusion relies on squaring a negative reserve. The A=0 row is only an allocation endpoint, not a vanishing assertion.

## Conditional B composition and independent coefficient review

The coefficient estimate is my earlier producer result, so this review does not count as an independent review of that result. The separate review by prime_estimates is now frozen at `REVIEW_ETA_U_PRIME_COEFFICIENT_ENERGY_2026-11-11.md`, SHA256 `91057A3117C6E469E633F532206E783FBC4BCAC1620384E09756AB4E3C7AB6E4`. I read it and verified its pin. It accepts the conditional coefficient derivation at the stated source/paper scope, including the actual etaU mixture, strict large-prime support, cutoff equality, real-floor conversion and uniform unbounded-y error. Its existence supersedes the author's historical statement that this independent review was pending at freeze; the frozen author bytes need no edit.

For the present composition I checked that x=49y makes the strict prime support threshold sqrt(x)=7sqrt(y). The prime-sieve carrier is the same disjoint physical-arc sum used in Cfull. The correction to the coprime sequence is still charged by .0010632, and the exact principal energy Lcop is nonnegative. Dropping Lcop therefore weakens the upper bound safely; neither of the adverse square-root cross terms is dropped.

The source `MinorArcs/LargeSieveProof.lean:378`, `cor_12_2_5`, has the prime-supported sequence, domain and size conditions used in the reduction. Its bundled Fact PlattGRH is not automatically eliminated. The previously inspected principal-only localization of its quotient/totient chain and the coefficient theorem's principal analytic and finite arithmetic inputs must still be proved in the replacement assembly.

For every y>=1e25, L=log(y)>50 and log(2R)<13. Thus C_R<30/L and the coefficient bound gives C_R*tlarge<39 uniformly, not merely at the endpoint. The remaining exact comparisons yield

    sqrt(B) < 7*(6.25+46e-6)+.0010632 = 43.7513852,
    B < 1915 < 2000.

The source size conditions are true at x=49e25 and persist for larger x. This conditional upper bound removes the old fixed-allocation obstruction for this particular source-sieve comparison. It does not contradict the earlier lower bound on that comparison's limiting expression, and it does not supply A<=1e-10.

The author pins the original direct-B report. The relevant source-sieve formulas are unchanged in its corrected successor, `DIRECT_STAR_B_SOURCE_OBSTRUCTION_V2_2026-11-11.md`, SHA256 `65B892756EA24A086C673082D3CA551AF99EECA5DDA63CB3523EE3F5514A88A9`. This review uses that successor. Its correction to an ancillary totient attribution is not used in the present B estimate. The original predecessor remains intact.

## Exact evidence and remaining scope

The independent script `audit/review_plus_star_reallocation_20261111.py`, SHA256 `380A272A63B0C3BDCB6F5DAA4857025133AA9919CA3E76A3B59E5F946CAE092F`, performs 50 exact checks. Its receipt is `audit/review_plus_star_reallocation_20261111.json`, SHA256 `43056FC0A3273FA229EA4FCB442C203FD1D8695161086D6789F571BBDFA9F590`. It reconstructs the allocations and every saved scalar/row, checks positivity before squaring, verifies the nine input pins and the separate coefficient review, and checks the two source-sieve size inequalities.

Author scalar source SHA256: `1EF89EB87CA60FC98D71EB63111E304A0D48C34AFD42706E47C35F74B86ED6DC`. Author receipt SHA256: `107C37AF8925AC5E209198E85724B37F4080E3E1768A91AC616FF479922584C2`.

Actual source pins: `MajorArcs/MajorTotal.lean` is `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A`; `MinorArcs/LargeSieveProof.lean` is `FB71222C80D0377BDF6739529E527F4BE6A0C908286FF87F0EC19D67DDE9CAF1`. The receipt retains the remaining contract pins.

The result preserves the old cubic allowance after its stated inputs. It leaves actual A, the finite plus and principal certificates, principal-only helper refactors, independent base-gap control, remaining final consumers, kernel validation and finite coverage open. No computation-cost saving or complete PlattGRH removal follows from this review alone.
