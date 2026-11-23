# Assembly review of the combined odd/even height profile

2026-11-11. PASS as a conditional source/paper assembly. The independently reviewed components give a complete nonprincipal plus-energy bound on the required domain. Together with the retained principal input and the already reviewed common-RH star and base-gap implications, they preserve the original cubic allowance. This is not a finite spectral certificate, a source implementation, a kernel proof or a runtime estimate.

No analytic values, spectra, primes or transforms were evaluated. No Lean declarations, source edits or builds were made. The independent exact arithmetic checks did not import or run either component's producer script.

## Bound components and combined statement

The odd component is `major-constants/ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md`, SHA256 `C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D`. Its independent review is `zero-sum/REVIEW_ODD_PLUS_SHARED_RH_HEIGHT_2026-11-11.md`, SHA256 `96D6929824BEBEFC14D5657E9E0134E9B5F0C7ADE194181A3FDE80908994ADC2`.

The even component is `moebius/EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md`, SHA256 `D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B`. Its independent review is `audit/REVIEW_EVEN_GAUSS_PLUS_HEIGHT_PROFILE_2026-11-11.md`, SHA256 `BF2502B9F1138B381518EFB4421A14F8E2F689C3F3C088F4172ACE2749B3F46E`.

Set R=132900, x>=4.9e26 and y=x/49. The combined finite-RH requirement for primitive nonprincipal characters is:

| Conductors | Height prescription |
|---|---|
| Odd 1<c<=132900 | ceil(200+max(240,3.1416*u_o(c)*531600/c)) |
| 4|c, c<=265800 | ceil(200+max(255,3.1416*u_e(c)*1063200/c)) |

On the four half-open bands split at c=100,1000,10000, use u_o=(21,20,19.5,19.2) and u_e=(22.6,21.1,20.1,19.1). Principal RH through the closed height 10^8 remains separate. There are no primitive characters of conductor congruent to 2 modulo 4, but ambient moduli in that class remain in the sums.

The premise is actual ordinary RH for every nontrivial zero through the indicated closed height, with both ordinate signs, real nontrivial zeros and true multiplicities. It is not a list of observed critical-line zeros or an assumption of simple zeros. Inversion preserves the conductor, so the same certificate covers the inverse labels used by the source transforms.

I read both author reports and both completed reviews. This integration review uses the component analytic estimates at their reviewed scope, and checks their domains and downstream compatibility. It does not replace either component's detailed error analysis.

## Ambient support and the full plus residual

For an ambient q with qt(q)<=265800 and |delta|<=1063200/qt(q), write

    t(q,psi)=|tau_q(psi)|*|Schar(psi^-1,coprimePart(q,cP(x)),delta/x)|/x.

The odd component gives t<7.41e-7 when the inducing conductor is odd. The even component gives t<9.94e-7 for inducing conductors divisible by four, including its inner coprime removal. These are bounds on the same source quantity, not on differently normalized primitive sums.

For 4|q, every nonzero Gauss-weight conductor contains the full 2-adic exponent of q and is divisible by four. The supported nonprincipal character fraction is at most 1/2. For 4 not dividing q, every nonzero supported primitive conductor is odd. Thus the two component estimates never require a mixed unsupported averaging argument. Exact character Parseval gives

    Eplus(q) <= max((7.41e-7)^2,(9.94e-7)^2/2)
              = 5.49081e-13 < 7.02e-13.

At q=1,2 the nonprincipal energy is zero. All other imprimitive characters with nonzero Gauss weight remain included. The principal constant vector is handled separately; its orthogonality to the centered nonprincipal vector and the outer removal give the existing direct-plus interface.

Specifically, with p0=2.83e-7 and d0=1e-15,

    7.02e-13+p0^2 < (8.844e-7)^2,
    (8.844e-7+516*d0)^2 < 7.83e-13 < (8.85e-7)^2.

Therefore the complete actual residual sum over unit numerators is bounded by rho^2*x^2 with rho=8.85e-7. Both the inner removal already present in t and the outer removal in this calculation are paid. This does not recover the old stronger Eplus<=1.80625e-13, and an unchanged wrapper requiring that stronger bound cannot be used.

## Upper and lower major energy

The direct residual argument gives the normalized integrated residual Z<.006^2, since 16*150000*19*rho^2<.006^2. There is no extra factor phi(q) after a hypothesis already summing over b. The unchanged principal Fourier bound gives Y/x<=a=.640208*13.59756<2.951^2. Minkowski yields X/x<(2.951+.006)^2<8.79=j.

The lower J bound is a different implication. The principal projection in `ArcChars.sum_units_sq_bounds:192` discards nonnegative nonprincipal squares. The source lower half of `L2Major` uses only that projection, the principal estimate and removal; its old nonprincipal upper constant is unnecessary. As in the reviewed three-target source map, the R132900 lower mass and its finite certificate must be used. One cannot restrict the R150000 lower integral or call the bundled old `l2_major_14_7` unchanged.

This distinction preserves both inputs to the final major/minor comparison while avoiding a hidden use of the old stronger plus-energy theorem.

## Shared RH supplies the old star allocation

For odd c, 19.2*3*531600>27000000. For even c, 19.1*3*1063200>54000000. The respective floors give heights at least 440 and 455. These inequalities imply that the combined heights dominate both Hbase and Hstar=ceil(max(300,(704/343)*D_c)), where D_c=1063200/qt(c). Ceiling monotonicity applies after the real comparisons.

For star, restrict the common RH certificate to Hstar. Do not enlarge the low-zero statistic to the taller plus height and then reuse the old count budget. Ordinary RH on this restricted closed carrier implies the weaker beta<=.5075 squarefree and beta<=.62 nonsquarefree conditions of the reviewed floor300 packet. That packet, including its growing-window count, high-tail and coprime-removal estimates, gives A<4e-12 and B<42<62 uniformly for all y>=1e25.

The already reviewed weighted-principal norm is pbar=1.902e-6. It is an integrated norm and is added once. The conservative rational witnesses give

    pbar+2e-6+(8.85e-7)*7.875 < 2.964*(3.67e-6),
    7.875^2>62, 2.964^2<8.79.

Consequently the full normalized star moment satisfies 49^2*Wstar/x^3<=j*(3.67e-6)^2. This integration uses only the reviewed A4e-12/B62 route. It does not use the newer line-statistic bounds, direct B<1915, the etaU coefficient-sieve theorem, or the larger-u reallocation.

The plus mixed moment follows from the same rho and the source Fourier energy: 49^2*Wplus/x^3<=49*rho^2*(7.78*2.85). Cauchy applied to the exact cubic residual identity then gives the original rational allowance

    j*(3.67e-6)+rho*[49*(j+a)/9+9*(7.78*2.85)/2]
      =64019155993729/312500000000000000.

The Fourier truncation allowance is unchanged. No favorable cancellation among residuals or character terms is assumed.

## Base gap and final assembly boundary

Restricting the same common certificate to Hbase supplies the reviewed base-gap implication. Its original-modulus parity geometry, both signs of d and closed lower gap endpoint remain mandatory. The star twist delta/49 is not substituted for the separate base-gap twist. With the principal term and removals retained, the bound is .024547036*y<.03*y<ghatY(y,R)*y. This reaches the actual `MinorTotal` envelope consumer directly, without claiming the old .014 sufficient guard.

The source path to the final theorem is therefore the same conditional localized path recorded in `THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT` and its independent review. The present combination fills its nonprincipal plus, star and base-gap inputs by one ordinary finite-RH family. Its other inputs are unchanged: principal estimates, source mass and singular series, finite minor cells and asymptotic range, off-arc estimates, nonprime subtraction and final finite coverage.

I checked the actual final consumer bodies. `Helfgott/Inputs.lean` supplies the circle identity, xOf scale, major/minor inputs and nonprime error; `Helfgott/Main.lean` splits the circle integral, subtracts the nonprime contribution, extracts three primes, and joins the small range. These source wrappers still carry broad Fact PlattGRH and hardcode R150000 with separate constants 1.049 and 1.0376. This review does not authorize calling them unchanged or assert those separate bounds at R132900. They must be refactored to the already audited joint R132900 scalar budget and localized hypotheses. Preserving the cubic error is the needed compatibility statement, not a new proof of the entire final budget.

The desired large root remains unconditional TernaryGoldbachFrom(10^27). The full Statement retains only its original inclusive BinaryGoldbachInput through 4e18. Finite RH and the other new intermediate obligations must be discharged internally; they are not added final premises. The unbounded real scale and other unbounded arithmetic parameters of the original analysis remain intact.

## Exact evidence and scope

Independent exact checker: `audit/review_combined_odd_even_profile_20261111.py`, SHA256 `AA410D7B851E708D9AC9203ED0F3B8C3391C9585E5967686E513295432B2BE71`.

Receipt: `audit/review_combined_odd_even_profile_20261111.json`, SHA256 `FFD25BA54BD236580EA33D7BD0503ED94046239DBF8BB202374E93414757B323`.

All 23 checks passed. They verify the bound component/review pins and the exact energy maximum, residual interface, integrated norms, old star allocation, original cubic constant, both height dominations and actual base-gap envelope. The receipt also records the exact source and contract hashes, including the final Inputs/Main bodies.

The three-target source audit is `78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28`; its independent review is `4AD1F28880997030F9F5EF0ABACC637461203E50397964D1247A63D6651E65B5`. The floor300 source/review pins are `E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794` and `422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4`. The base-gap source/review pins are `776CD34413ECC389D10CE510913C694C6D6C34E8555FFE0D66702582B3A23898` and `2E902497CE7445F78CEF7A2F229D0A9042FAF4FB573AB1A01B79D05331635076`.

Actual finite spectra, auxiliary count completeness, finite certificate replay, localized formal proofs, compatible kernel validation and final assembly remain open. No production or proof-cost saving is inferred merely from this successful conditional integration.
