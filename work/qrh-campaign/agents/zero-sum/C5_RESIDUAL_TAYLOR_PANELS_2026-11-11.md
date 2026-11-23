# Centered residual models on four fixed conductor-5 panels

2026-11-11. All four selected panels pass both inverse-residual tests with the centered model below. Three failed both original interval tests; the fourth previously passed only the l1 test. This establishes substantial enclosure overestimation on these particular panels. It does not complete the original boundary, fit a new candidate, prove a full rectangle zero count, or supply a Lean theorem.

The candidate is exactly the385-pole rational candidate frozen in `c5_global_inverse_candidate_20261111.json`, SHA256 `02C623629D3DF9218AFB7689F39698AF5C4F4D6FB6776056C4B275220D148E6E`. Every pole has real part1/2; the rectangle remains [111/200,2]+i[-12,12]. Characters, positive exponent, primitive projector and normalization are exactly those in the independently reviewed capped comparison. The predecessor receipt has SHA256 `7FAA8640C48E48C6BB03CE3AA0921CE77042F42A464E1F371221E888AEE946EA`.

## 1. Exact fixed inputs and result

The zero-based attempt indices below refer to the predecessor's saved attempt array. They were fixed before evaluating the new models. Selection takes the last attempted panel, a deepest panel failing both tests, a deepest such right-edge panel, and a near-real-axis left-edge panel failing both tests. No subdivision or extension was performed.

| Attempt | Exact oriented panel | Old l1 upper | New l1 upper | New T16 upper |
| --- | --- | ---: | ---: | ---: |
|29999|.555+i[-33783/8192,-16893/4096]|.763433|.013267|4.0e-60|
|3871|.555+i[46527/4096,11631/1024]|1.002806|.081271|6.4e-35|
|457|2+i[-12,-381/32]|1.173053|.024519|9.1e-52|
|24860|.555+i[3/1024,0]|1.086723|.003444|1.5e-77|

Table bounds are rounded upward; exact dyadic upper bounds are in the receipt. Old T16 failed on all four. Old tests were recomputed in the new192-bit context with the same inherited128-bit constants and give the same pass/fail classifications as the original saved attempts. This comparison is not just increased precision: it changes how analytic cancellation is retained before enclosing a panel.

The four calculations together took0.26061 seconds after imports, on one recorded run. The read-only recomputation matched every non-timing receipt field and took0.26117 seconds. These four local timings are not a throughput forecast or a claim that a full boundary will pass at the same cost.

## 2. Finite Euler-Maclaurin function and actual L error

Let s0 be a panel center, rho its half-length, and R=1/4. The four rho values are3/16384,3/8192,3/64,3/2048. All are strictly below R. For residues r=[1,2,4,3], put alpha_r=r/5, B_r=64+alpha_r, ell_r=log B_r and delta_r=ell_r-ell_1. Define P18(z)=sum_{j=0}^{18} z^j/(j+1)!, with19 terms. The finite entire expression is

    g_r(s) = sum_{n=0}^{63}(n+alpha_r)^(-s) + B_r^(-s)/2
       + B_r^(-s) sum_{k=1}^{20} [B_(2k)/(2k)!] (s)_(2k-1) B_r^(1-2k)
       - exp((1-s)ell_1) delta_r P18((1-s)delta_r).

The finite entire character function is

    g_k(s)=5^(-s) sum_{j=0}^3 i^(k*j) g_{r_j}(s),   k=1,2,3.

This is the same pole-cancelled EM expression as the prior evaluator, with its exprel remainder made explicit instead of inserted into every coefficient operation. The subtracted common pole term cancels under each nonprincipal character. It does not identify individual totalized Hurwitz values at s=1 with a new convention. Both g_k and the actual nonprincipal L_k are entire.

For any control disk |s-s0|<=r, use sigma_minus=Re(s0)-r, S=|s0|+r and d_r=|delta_r|. To avoid overloading the residue index in prose, write Z_r=(S+1)d_r. The EM remainder per Hurwitz component is bounded by

    4 product_{j=0}^{39}(S+j) B_r^(1-sigma_minus-40)
      / [6^40 (sigma_minus+39)].

This follows from the periodic Bernoulli remainder, its bound4/6^40 after division by40!, and the integral of u^(-sigma_minus-40). The only integrability condition is sigma_minus+39>0. The exprel replacement adds at most

    B_1^(1-sigma_minus) d_r exp(Z_r) Z_r^19 / 20!.

Sum these four bounds and multiply by5^(-sigma_minus) to obtain E(r), uniform for every actual character L_k-g_k on that disk. It is not a reuse of a bound with the old sigma floor. At the left-edge centers the outer disk has sigma_minus=61/200=.305; at the right edge it is7/4. The script substitutes these actual floors. On the target panel it substitutes the smaller panel disk's own floor. The expanded disks are analytic control domains only; no nonvanishing or spectral claim is made on them.

The source EM derivation remains the one used by the reviewed conductor-5 evaluator; the displayed integral calculation explicitly supplies the changed floor. All exponentials, rational powers, Bernoulli coefficients and logarithms use external ball arithmetic, not a builtin L/zeta/Gamma oracle.

## 3. Cauchy bounds and true derivative interpretation

A uniform bound M_g for g_k on |s-s0|<=R is obtained by the triangle inequality in its finite expression. Each initial power is bounded by

    exp(-Re(s0)*log(n+alpha_r) + R*|log(n+alpha_r)|).

The absolute logarithm is essential: n=0 gives a base below1, whose maximum occurs at the upper real endpoint. Using sigma_minus for all such initial powers would be wrong. The correction terms use product(S+j), positive B_r powers and the absolute Bernoulli coefficients. The final finite exprel polynomial uses sum_{j=0}^{18} Z_r^j/(j+1)! and B_1^(1-sigma_minus)d_r. Finally multiply the sum over residues by5^(-sigma_minus). The script applies these bounds directly. The resulting M_g values are approximately65.609,65.621,3.293,65.603.

The degree12 Taylor coefficients of finite g_k are computed with acb_series and retain all ball uncertainty. Cauchy's estimate gives the finite-g truncation bound

    E_g = M_g (rho/R)^13 / (1-rho/R).

Thus the actual L-function is within E_L=E(rho)+E_g of that polynomial throughout the panel disk. The finite-g Taylor coefficients are not silently called actual L derivatives. Since L_k-g_k is analytic and bounded by E(R) on the outer disk, its j-th normalized derivative at the center has error at most E(R)/R^j. These actual-derivative error bounds, j=0,...,12, are separately recorded in the receipt. No unknown derivative of L is an input.

## 4. Exact rational Taylor model and residual assembly

For each frozen candidate B_k(s)=b_k0+sum_p w_kp/(s-p), use its exact binary-rational coefficients. At s0 the normalized degree-j coefficient of a pole term is (-1)^j w_kp/(s0-p)^(j+1). If rho<min_p|s0-p|, its degree12 tail is bounded by

    E_B,k = sum_p |w_kp| rho^13 /
          [|s0-p|^13 (|s0-p|-rho)].

All four strict distance inequalities are checked with interval lower bounds. There is no new pole, fit, or rational approximation choice. Let G_k and P_k be the degree12 polynomials for finite g_k and the candidate respectively. The script forms the degree24 residual polynomial

    R_k(z)=1-G_k(z)P_k(z)

by coefficient multiplication BEFORE enclosing z on the full panel. This preserves cancellation of the constant and low-degree terms. If Gsup and Psup are the coefficient-sum polynomial bounds on |z|<=rho, a uniform error for the actual residual 1-L_k B_k is

    E_res,k = E_L (Psup+E_B,k) + Gsup E_B,k.

This comes from (L_k-G_k)B_k+G_k(B_k-P_k). It includes the cross term and does not assume independence. Polynomial coefficient rounding remains in the coefficient balls. The error disk is conservatively inserted as a rectangular complex ball before further operations.

The three resulting scalar residual boxes are converted to the exact primitive-supported group coefficients by

    r_{2^j}=(1/4) sum_{k=1}^3 i^(-k*j) (1-L_k B_k).

Then the same l1 and T16=4 sum_g |r^{*16}_g|^2 tests are evaluated with intervals. No test is based on the center samples alone. The maximum residual analytic errors on the four panels are, rounded upward,6.2e-33,9.6e-29,1.672e-9,5.6e-22. The right-edge panel's finite-g Taylor tail dominates its analytic error; the others have much smaller analytic tails.

## 5. Counts, limits and interpretation

Per panel the implementation calls262 truncated-series exponentials at degree12,385 pole reciprocals,15015 rational-jet coefficient products,5005 inverse-power updates and507 products to form the three degree24 residual polynomials. Four convolution squarings then evaluate T16. Coefficient-sum bounds, scalar exponentials for the explicit error controls, interval operations and imports are additional work. The run also recomputes the old whole-panel bound four times and evaluates the old EM function at the four centers for diagnostics. These operation categories have different costs and are not converted into a machine-independent operation rate.

An initial local version of the control bound treated every initial Hurwitz base as at least1. It was corrected before freezing to the absolute-log formula above; both corrected construction and corrected read-only recomputation passed. No frozen predecessor artifact changed. The previous capped report's separate wording erratum records that exprel has19 terms of degree18 and that1037 historical diagnostic calls were author-reconstructed.

For these exact panels the new rigorous bounds certify that the old large enclosures were not forced by large actual residuals. Centering and coefficient-level multiplication remove a material loss. The outcome does not prove that all other panels have the same behavior, that fewer than3034 global panels suffice, or that this inverse representation is faster than the already complete character polygons. The incomplete predecessor receipt stays incomplete. A complete new boundary run would be a separate task; none was attempted here.

## Frozen files

* `c5_residual_taylor_panels_20261111.py`: SHA256 `F1F91D5BC8B9DAF5BCA8B44FA55C1D333500662496157A453FB9E70CBD37FE4C`.
* `c5_residual_taylor_panels_20261111.json`: SHA256 `8801DEBF7956C20403B20A1A04819B61E5FAFAF2A8FA39DA10E3888132C28F8C`,416055 bytes.

The receipt contains the four exact panels, control floors and radii, every finite-g/B/residual coefficient enclosure, actual-derivative error bounds, rational tails, residual image boxes and both tests. Run the script with the existing interval-environment Python and `--recompute` to compare every non-timing field without changing the receipt. A successful status is explicitly `FOUR_FIXED_PANELS_ONLY`, with `full_rectangle_certified: false`.
