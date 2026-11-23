# Independent review of the integrated cubic residual contract

2026-11-11. PASS at paper/source scope. The two weighted moments imply an error no larger than the existing cubic allowance. The current pointwise inputs imply the proposed moment inputs. This is a sufficient relaxation of one consumer interface, not a proof of its quantitative premises or of reduced spectral work.

Reviewed [root contract](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md), final SHA256 `943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128`. The final version incorporates the requested cutoff and integer-phase qualifications. No further correction is requested. The scalar receipt has SHA256 `3C500B077B9FD4EA4B464E2E58E79E3CAA177B245E43EEFC29C94D0CC1BF786A`.

No Lean build, declaration, source change, special-function evaluation, spectral computation or prime computation was performed. The saved rational fields were independently recomputed with `Fraction`, without importing author code.

## Independent inequality

Work on the finite disjoint union of intervals tagged by `(q,b)`, with counting measure on the tags and Lebesgue measure on each interval. All four functions are continuous on each compact interval. Their products and squares are integrable, so the following Cauchy-Schwarz applications are legitimate, including zero-norm cases.

Write `p=Sp`, `s=Ss`, `A=Ap`, `B=As`, `r=p-A`, and `t=s-B`. Direct expansion gives

    p^2 s - A^2 B = p^2 t + B r (p+A).

For any measurable unit-modulus phase, triangle inequality, Cauchy-Schwarz and the L2 triangle inequality yield

    |integral (p^2 s-A^2 B)eN|
      <= integral |p| |pt| + integral |Br| |p+A|
      <= sqrt(X Wstar) + sqrt(Wplus) ||p+A||_2
      <= sqrt(X Wstar) + (sqrt(X)+sqrt(Y)) sqrt(Wplus).

Here `X=integral |p|^2`, `Y=integral |A|^2`, `Wstar=integral |p|^2|t|^2`, and `Wplus=integral |B|^2|r|^2`. This proves equation (1) without a pointwise star bound, without independence between residuals, and without a diagonal restriction on character indices. The weighted moment `Wstar` is still a mixed fourth-degree quantity; removing a separate unweighted fourth-moment premise does not make this weighted premise automatic.

## Scaling and exact comparison

With the contract's nonnegative rational constants and `kappa=49`, the four sufficient bounds give

    sqrt(X Wstar) <= j u x^2/kappa,
    (sqrt(X)+sqrt(Y))sqrt(Wplus)
      <= (x^2/kappa) rho sqrt(kappa v)(sqrt(j)+sqrt(a)).

The factors of `x` and `kappa` therefore match the stated normalization. For the second term, set `C=kappa(j+a)/9` and `D=9v/2`. Then

    (sqrt(j)+sqrt(a))^2 <= 2(j+a),
    (C+D)^2 - 2 kappa v(j+a) = (C-D)^2 >= 0.

Since `C+D` is nonnegative, the normalized error is at most

    j u + rho [kappa(j+a)/9 + 9v/2].

Reading `per_modulus` and `major_total` in the source gives its original cubic error as

    (u x/kappa + rho x/9)(j x)
      + (9 rho x/2)(2.85)(7.78 x/kappa)
      + (rho x/9)(13.59756)(.640208 x).

Dividing by `x^2/kappa` produces exactly the preceding expression because `a=.640208*13.59756` and `v=7.78*2.85`. Thus this comparison spends no additional numerical reserve. It compares with the same sufficient cubic allowance, not with the unknown actual cubic error or an optimal bound.

The unchanged Fourier-tail contribution is `kappa*2.03e-5*2.85`. It is separate from the cubic comparison and is retained. Independent exact arithmetic matched all ten rational fields of the saved receipt, including both normalized moment bounds, the cubic allowance, the nonnegative square slack and the tail allowance. It also verified `8*150000 <= 4.9e26` and `16*150000^2 <= 4.9e26`. No square-root approximation is needed.

## Actual residuals and implication from the old interface

The residuals use the full source prime sums. The star main term uses scale `y=x/kappa`, while `S etaStar x` retains its source definition at scale `x`. `As_eq` at `MajorTotal.lean:367` is the exact Fourier scaling identity. Both main terms carry the factor `mu(q)/phi(q)`; omitting it would invalidate the allocations.

The source pointwise star estimate gives

    Wstar <= (u x/kappa)^2 X <= j u^2 x^3/kappa^2.

At fixed `(q,beta)`, `As` is constant with respect to `b`. Therefore the source summed plus residual estimate gives

    sum_b |As|^2 |rp|^2 <= |As|^2 (rho x)^2.

Here `|As|^2=mPhi2(q)|Fourier(etaUC)(-beta y)y|^2`. There is no extra factor `phi(q)` in this step, since the plus residual has already been summed over `b`. The source whole-line Fourier L2 estimate and `sum mPhi2<=2.85` yield

    Wplus <= rho^2 x^2 * 2.85 * 7.78 x/kappa.

This is precisely the fourth sufficient bound after multiplication by `kappa^2/x^3`. Similarly, summing the main plus term over `b` uses

    card(Bset q) |mu(q)/phi(q)|^2 = mPhi(q),

so `Y<=.640208*13.59756*x`. These are genuine implications from the older sufficient inputs. They do not use an inverse inference from an integrated bound to pointwise control.

The reviewed bodies are `resid_plus:233`, `resid_star:264`, `pointwise_bound:760`, `per_modulus:808`, its two Fourier estimates at 887 and 907, and `major_total:974`. The source still has `[Fact PlattGRH]` on the residual and major-arc theorems. These implications cannot be used to claim unconditional new moment bounds while silently retaining that fact.

## Cutoff, endpoints and final assembly

The abstract inequality is valid on the stated finite tagged measure space. The final contract separately restricts the source application to natural `1<=R<=150000` and `x>=4.9e26`, with selected `R=132900`.

From the actual `Qset` definition, `q>=1` and `qt(q)<=2R`. The natural-floor bound in `Qset` is monotone in `R`, so `Qset R` is contained in `Qset 150000`. Also `w_q=8R/(qt(q)x)` is nonnegative and no larger than its original-cutoff value. Thus the inherited pointwise twist range and the nonnegative mass upper sums may be restricted to the smaller family and intervals. Lower sums do not inherit their original lower bounds by this argument.

For every surviving modulus,

    w_q x = 8R/qt(q) >= 4.

This checks the lower width condition of `main_comparison:561`. The geometric requirements in the source arc-partition lemmas are `8R<=x` and `8R^2<=x/2`, both satisfied in the declared application range. Endpoint changes between closed intervals and `Ioo`/`Ioc` do not change these integrals because finitely many endpoints have measure zero. They do not remove any separate pointwise endpoint obligation elsewhere.

The main-term phase is also correct. Summing `Ap^2 As eN` over `b` gives the existing `coefN N q` times the modulus main integrand, by `coef_eq` and the factorization of the additive phase. The source carries this equality at `MajorTotal.lean:786`. Its coefficient norm is at most `mPhi2(q)`, by `abs_coefN_le:714`, which justifies the unchanged summed Fourier-tail bound.

The new bound controls the norm of the total tagged cubic error, which is sufficient for a lower bound on the real part of the total integral. One need not first bound each modulus error separately. To identify that sum with the physical major arcs, however, the actual disjointness and periodization lemmas are still required. The source `integral_majorArcs_eq:27` is fixed to `r0`; its underlying general-radius lemmas provide the reduced-radius proof ingredients. This paper does not assert that a new radius-parametric Lean theorem already exists.

An integer `N` makes the cubic phase periodic. The final source assembly further retains natural odd `N` and the original relation `N/x=2+9/(8 sqrt(pi/2) kappa)`. None of these final binders is lost in the revised contract.

## Remaining consumer obligations

The proposal does not establish `X<=8.79x`. The source `L2Major.l2_major_bounds:309` still depends on `PlattGRH`. Its upper half can be restricted once proved for the chosen route; its lower half cannot be transported to smaller arcs merely by nonnegativity. The reduced-radius main-term/singular-series lower bound, principal estimates used elsewhere, minor-arc energy bounds, all scale ranges, nonprime correction and finite coverage remain separate.

In particular, the all-point base-gap estimate is not implied by either new moment. This contract changes one sufficient major-arc interface, not the entire final proof. No available quantitative producer for these moments, runtime bound, spectral certificate or completed kernel proof is supplied or inferred.

## Source pins

All entries below were checked against local bytes. The paths are under `work/ternary-goldbach/TernaryGoldbach` in the current workspace.

| Source | SHA256 |
|---|---|
| MajorArcs/MajorTotal.lean | 106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A |
| MajorArcs/Singular.lean | 152DC0302216E9E2B23E9DFCA7FE1BCA2087F275662F9988FC524D101C1B8DB9 |
| MajorArcs/SumMuPhi.lean | 7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4 |
| MinorArcs/LargeSieveArcs.lean | 0794C8853D9B1AA91EFEC3C9D91F5F1EFCECB98B484C701C360DD8EF5AC592BF |
| MinorArcs/LargeSieveWeights.lean | 4577368FF4AD237E00D04259B813AFE2755ED165766070711CA33FB75E6F2304 |
| MajorArcs/ArcsEq.lean | 302D1DB08BC05B0A3E649AC07C3E37F74E0EDE7DCE5041A8952AA9021FBF2976 |
| MajorArcs/L2Major.lean | 8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC |
