# Shorter certified windows for the large branch

2026-11-11. Bounded exact-rational analytic-tail research. No samples, function values, roots, coefficients, transforms, signs, prime values, builds or declarations were produced. The frozen h=1,m=256 baseline remains unchanged. The alternatives below need independent review and retain every sample/kernel arithmetic and completeness obligation.

An 83-sample candidate is sufficient: h=159/500 and m=41 give a certified analytic interpolation error below `0.927193523*2^-46`. This is stronger than the baseline allowance `2^-46+2^-243`. It changes a local stencil and its guards, not an accepted global inventory or measured runtime. The search establishes no optimality outside its finite sufficient test.

## 1. Inherited exact function and theorem

The source is `audit/LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md`, SHA256 `DA67CB3B463FED71B6545CD13DF374B7713924DFA92C44B37E83862FBA4CCE69`, independently reviewed in `major-constants/REVIEW_LARGE_BRANCH_WINDOW_INTERPOLATION_ROUTE_2026-11-11.md`, SHA `873F9A0A15D77D5F90032139F42B29329F812C370FD122716504A207E6828AEF`. Its primary input is Platt arXiv:1305.3087v1, lemmas 5.3 and 6.3–6.5 and the section 6 Weiss/window argument. The baseline pins the exact primary PDF and source-normalization evidence.

The actual function remains

    Y_chi(t)=epsilon_chi (c/pi)^(it/2) Gamma(alpha+it/2)
             exp(pi*t/4) L(1/2+it,chi),
    alpha=(2a+1)/4,    a in {0,1}.

The scope is primitive nonprincipal chi, c<=265800 and targets 0<=t0<=7000. The fixed root phase and positive/negative-channel rules are unchanged. The interpolated window is `Y(t)exp(-(t-t0)^2/(2h^2))`, with Delta=5/64, B=32/5. No strict-tilt Fourier theorem is applied at eta=1.

For M=5/2-a, the admitted Fourier upper bound is

    [2(c/pi)^(M/2) zeta(M+1/2)/(pi M)]
       *exp(M^2/(2h^2)-2pi B M)
       *h*pi*(t0+h/sqrt(2pi)+1+1/(2sqrt(2))).           (F)

The sample-tail proof in the baseline remains valid with any proved uniform bound `|Y(t)|<=C_Y(2+|t|)`. Section 2 improves that constant, without changing the function or theorem.

## 2. Rational constants and the uniform sample envelope

Use pi_L=157/50 and pi_U=22/7. The companion certifies these inequalities using the alternating arctangent series and the exact Machin identity

    pi=16 atan(1/5)-4 atan(1/239).

The identity follows from tangent addition and the angle in the principal interval; it is an elementary analytic input to the rational series certificate. The script uses ten terms at 1/5 and three at 1/239, brackets each by the next alternating partial sum, and checks the stated rational endpoints. It calls no arctangent evaluator. The elementary series estimate e<3 is also used below.

The following comparisons are all exact integer-power tests:

    5000^4 > (265800/pi_L)^3,
    1500000^4 > (265800/pi_L)^5,
    28^16 > (265800/(2pi_L))^5.

Positivity therefore gives uniform bounds 5000 and 1500000 for the two conductor powers in (F), and 28 for `(c/(2pi))^(5/16)`. Integral-test bounds give

    zeta(2) <= sum_(j=1)^8 1/j^2 + 1/8 < 5/3,
    zeta(3) <= sum_(j=1)^4 1/j^3 + 1/32 < 5/4,
    zeta(9/8) <= 1+integral_1^infinity t^(-9/8)dt = 9.

Platt lemma 6.3 bounds the scaled Gamma factor by the maximum of

    2^(1/4)*sqrt(pi)*exp(1/6)*(3/2+max(t,0))^(1/4),
    sqrt(2pi)*exp(pi/8+1/4).

For the first expression use `2^(1/4)<6/5`, `sqrt(pi)<9/5`, and `exp(1/6)<5/4`, the last from e<3 and `(5/4)^6>3`. Its constant is below 27/10. For the second, `sqrt(2pi)<18/7`, `pi/8+1/4<3/4` and `exp(3/4)<3^(3/4)<7/3`; the last inequality is the rational fourth-power test `(7/3)^4>27`. Their product is below 6. Thus for all real t the scaled Gamma factor is below `6*(3/2+|t|)^(1/4)`.

Combining with lemma 5.3 gives

    |Y_chi(t)| < 6*9*28*(3/2+|t|)^(9/16)
               <=1512*(2+|t|).                        (G)

This is uniform in both parities, signs of t and the complete stated conductor range. It improves the baseline's coarse `144c` prefactor. It makes no assumption about RH, zero positions or actual computed magnitudes.

## 3. Entirely rational tail certificates

For x>=0 define the rational function

    E(x) = [sum_(j=0)^24 (x/16)^j/j!]^(-16).

Positivity of the exponential series proves `exp(-x)<=E(x)`. There is no omitted upper-tail estimate in this direction: a positive partial sum is a lower bound for exp(x/16), and taking the reciprocal sixteenth power gives the required upper bound. All evaluations of E below use rational arithmetic only.

Set V=7000 and

    P_h = h*pi_U*(V+(2/5)h+1+5/14).

This dominates the last factor of (F), since sqrt(2pi)>5/2 and sqrt(2)>7/5. For each parity use its M and the corresponding pair `(power,zeta)=(5000,5/3)` or `(1500000,5/4)`, and define

    x_M = 2*pi_L*B*M - M^2/(2h^2),
    F_M = 2*power*zeta*P_h/(pi_L*M)*E(x_M),
    F = max(F_(3/2), F_(5/2)).

Every tested candidate checks x_M>0. Then T_F<=F, uniformly in the required target/conductor range.

Write t0=(k+theta)Delta with k=floor(t0/Delta) and 0<=theta<1. Retain n=k-m,...,k+m and put z=m Delta. The baseline's decreasing-envelope argument applies if `z*(2+z)>=h^2`. Use the conservative rational ratio

    r=(1+Delta/(2+z))*E((2z Delta+Delta^2)/(2h^2)).

The denominator 2+z takes t0=0 to maximize the polynomial ratio. The tail numerator separately takes t0=V to maximize the envelope. With r<1, (G) gives

    S = 3024*(2+V+z)*E(z^2/(2h^2))/(1-r),
    T_S <= S.                                         (S)

Thus F+S is a single uniform upper bound. Mixing these two different endpoint maximizations is conservative; it does not assume both endpoints occur for the same target. The off-grid proof and all-height validity remain those of the reviewed baseline.

## 4. Finite search and admitted examples

The fixed candidate set is h=j/1000 for integers 300<=j<=400, and 36<=m<=64. It contains 2929 pairs. For each pair the companion checks both positive x_M values, the decreasing-envelope condition and r<1. It then tests the exact rational inequality

    F+S < 2^-46.                                     (A)

The smallest m passing this particular sufficient test in that finite grid is 41. Its complete passing h list is below. Each decimal is an upward rational bound with denominator 10^9 for the ratio to 2^-46, not a floating-point approximation.

|h|m|Upper F ratio|Upper S ratio|Upper total ratio|
|---|---:|---:|---:|---:|
|79/250|41|.888223689|.079120683|.967344372|
|317/1000|41|.829991178|.109507952|.939499130|
|159/500|41|.776087317|.151106206|.927193523|
|319/1000|41|.726156241|.207881818|.934038059|
|8/25|41|.679873933|.285144210|.965018142|

The displayed separate upward entries need not sum to exactly the separately rounded total. Every acceptance uses the underlying exact rational sum, not rounded decimals.

Two useful alternatives with more analytic slack are h=13/40,m=42, with total ratio below .613566911, and h=1/3,m=48, with total ratio below .299287241. The latter h is outside the finite denominator-1000 grid and is checked separately. It is not included in any grid-minimality claim.

Failure of (A) for another candidate means only that this certificate does not establish the desired budget there. It is not an analytic lower bound or proof of impossible interpolation. There is no assertion of optimality over arbitrary h, smaller m, sharper source bounds or other evaluators. No runtime price chooses among the passing candidates.

## 5. Exact guard and operation changes

For m=41 the direct finite candidate has 83 samples and 83 kernel products, compared with 513 at m=256. A nonempty left-to-right accumulation has 82 instead of 512 additions. Thus the direct stencil loses 430 product terms and 430 additions per evaluated target. These are arithmetic-operation counts before widths, source production, kernel proof/setup, sharing and precision costs. A new h changes the Gaussian kernel values and cache key, so no old kernel centers or margins can be reused without proof.

The exact support remains `[floor(t0/Delta)-m, floor(t0/Delta)+m]`. For a set of selected targets, the required sample union is the union of these sets, including reused endpoints. It must be recomputed from those targets before claiming a global guard or sample saving. A simple conservative per-target distance bound is `(m+1)Delta`, equal to 105/32 for m=41, instead of 1285/64 for m=256. At t0=0 the actual leftmost sample is -205/64. At the current maximal extra-node target 424195/64 the conservative upper extension is still below 7000.

This height comparison is only compatibility with the existing analytic seed domain. It does not supply unproduced samples or adopt a new inventory. The fixed baseline guard plan stays frozen; a successor must bind the selected h,m, targets, inverse channels and exact newly required positive source indices. For negative u, the actual endpoint-normalized relation is still

    Y_chi(-u)=kappa exp(-pi*u/2) Y_(chi inverse)(u), u>=0.

The exact root-phase sign, positive multiplier enclosure and rounding remain charged. Both channel and central-count rules are unchanged. A direct point evaluator can still replace interpolation locally under its own complete source/error contract.

## 6. Full error and cost boundary

For every admitted alternative the final radius remains

    F+S+e_acc+sum_n[(|Khat_n|+rK_n)rY_n+|Yhat_n|rK_n].

The source/input/head/transform/scaling/actual-amplitude-and-phase errors remain in rY_n once. Kernel enclosures and their rounding are new obligations for the selected h. No old per-addition/product allowance, aggregate arithmetic radius or integer width is inherited merely because the analytic tail improved. A smaller stencil can change the weighted sample-error sum, but that sum must be proved for the actual kernel and sample radii.

Since (A) is stronger than the frozen analytic allowance, a downstream proof may retain that old analytic budget while repricing and rechecking the new finite circuit. This is a valid modular substitution of the analytic part only. Strict signs still require their actual centers to exceed the complete radius, and Turing/count closure still requires its independent evidence. The optimization chooses neither a useful p112/134/152 transform case nor a whole-pipeline winner.

## Evidence

`audit/shorter_large_branch_windows_20261111.py` has SHA256 `7C51A4655CE47873A3352BB8BE74EE9FB8A371A4F38365A1CFFA91564C005FA4`; its exclusive receipt has SHA256 `745A2EF89CF23580562D76DDAD5D4C6EB57CC4F1C4FA50329148021745953A41`. It passes 12093 exact assertions and records the finite candidate domain, minimum accepted m at each h, all five m41 rows, separately named alternatives and the two predecessor pins. It imports no analytic evaluator and runs no function, character or proof-checker code. The author result is pending independent review; all old artifacts remain unchanged.
