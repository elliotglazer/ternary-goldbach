# Fourier parameters for arbitrary auxiliary heights

2026-11-11. Research adapter pending independent review. This extends the reviewed family alias rules to an arbitrary rational target height H>=1. In particular H may be T+h for a Turing auxiliary zone, with no restriction cH<=10^8. It changes neither the spectral target Hcert nor the family of characters. It gives sufficient parameter choices, not a practical runtime estimate or a sign certificate.

The predecessor is `agents/zero-sum/FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `E7D5CD24F5FAA6B75ED5E1167F3165EACBD7BCA7FEDF73D521C6B74BD04776EF`, with independent review `agents/moebius/REVIEW_FAMILY_FOURIER_ALIAS_PROOF_PLAN_2026-11-11.md`, SHA256 `A1B71C24E818CD5628C7A5F5B24105E19BDF5FC4840CCFC47239CAB435A85B33`. All its analytic and exact-character prerequisites are inherited. The conductor is an integer c>1 and the character is actual primitive nonprincipal, of either parity.

## General envelopes

Put C=cH, choose a rational tolerance 0<e<=1, and set

```
eta=1-1/H, b=pi*eta/4, R=pi*(1+eta)/8.
```

The same sine chord inequalities as in the predecessor give

```
cos(pi*eta/2)>=1/H, cos(2R)>=1/(2H),
d=pi*cos(pi*eta/2)/c > 3/C,
A<=C, M_R<=8C, lambda_plus,lambda_minus>3/(8H).
```

The strict d and lambda bounds use pi>3. They hold also at H=1, where eta=0. Here A and M_R are the predecessor's parity-dependent frequency envelope and time envelope. The root phase remains fixed for the character. These bounds use no selected-family product cap.

Write r=3/8. The elementary positive exponential series gives exp(1)>8/3, so exp(-j)<r^j for positive integer j. All parameter tests below are rational.

## Time period and frequency cutoff

Choose integers K,L>=1 satisfying

```
32*C*r^K < e/4,
16*C*r^L < e/4.
```

Such integers exist by geometric decay. Set `P=(1+8K/3)*H`. Then P>2H and both geometric time denominators exceed1/2, since lambda*P>3/8+K>1 and exp(1)>2. The predecessor's signed time-alias sum on |t|<=H is therefore

`E_time < 32*C*exp(-K) < e/4`.

Choose an integer x>=2 such that

`(3/(2C))*(8/3)^(2x) >= L`.

This exists because the base exceeds1. Choose N to be the smallest power of two at least P*x/3. Since P>=11/3 and x>=2, that lower threshold exceeds2, so

```
P*x/3 <= N < 2*P*x/3,
omega=2*pi/P < 2,
Xcut=pi*N/P > x,
omega*N < 4*pi*x/3 < D := 88*x/21.
```

The omega bound uses pi<22/7 and P>=11/3. N is even and the centered frequency block has Lfold=0; the integer L above controls an exponential target and is not a fold index.

The strong frequency envelope in the predecessor has parity factor at most2 and satisfies

`Q(Xcut) < 2*C*exp(-L)`

because `d*exp(2Xcut)/2>L`; the additional exp(-Xcut/2) is discarded conservatively. Its stable omitted-frequency bound gives

```
E_freq <= 2*Q(Xcut)*(omega+1/(1/2+d*exp(2Xcut)))
       < 16*C*exp(-L) < e/4.
```

Both frequency sides and both time sides remain included. The DFT multiplier is still omega for the unnormalized positive transform, or omega*N for Mathlib invDFT. Radix-two rounding must separately preserve that normalization.

## Common Gaussian-series cutoff

Choose an integer M>=1; put n0=M+1 and define the rational quantities

```
z = 3*(2M+3)/C - 1/n0,
j = floor(3*n0^2/C).
```

Require all three tests

```
z>0,
3*n0^2/C >= 3/4,
D * 2*n0*(1+1/z)*r^j < e/4.
```

For either parity, log(1+1/n0)<=1/n0 implies that the omitted Gaussian-series ratio is at most exp(-z). The bound `1/(1-exp(-z))<=1+1/z` then controls its denominator. The second test is sufficient for the numerator to decrease as |frequency| increases, since k/2<=3/4. Thus the error at every retained coefficient is bounded by

```
E_series < 2*n0*(1+1/z)*exp(-3*n0^2/C)
         <= 2*n0*(1+1/z)*r^j.
```

The harmless non-strict last step also covers j=0. The prefactor c^(-k/2)<=1 was discarded. Multiplication by the total DFT weight omega*N<D proves the total series contribution is below e/4.

Doubling M until these conditions hold terminates: z grows linearly and is eventually positive, j grows quadratically, and the polynomial prefactor times r^j tends to zero. This is a mathematical termination argument for fixed positive C,D,e, not a claim that the first tested M succeeds or that a resulting transform is cheap.

## Remaining numerical targets and scope

It suffices to certify each retained coefficient's additional rounding error at most `e/(8D)` and the normalized finite FFT error at most e/8. Their total contributions are below e/8 and at most e/8. Together with the three preceding bounds, the radius around the actual F(t_m) is below e for every grid point |t_m|<=H. These rounding targets remain obligations on actual data; parameter arithmetic does not establish them.

There is no off-grid interpolation claim. F is a positively scaled real completed L-function after the exact fixed phase is supplied. A sign is certified only when the resulting interval excludes zero. Choosing smaller e adaptively is allowed only after recomputing all associated bounds. Integer saturation still needs main signs, auxiliary weighted signs, Gamma integrals and a proved Turing allowance. An enlarged H does not automatically supply those data.

## Exact parameter witnesses

The script `auxiliary_fourier_parameters.py` uses Fraction arithmetic to choose and check K,L,x,N,M. It computes no Fourier coefficients, character values, L-functions or FFT outputs. Five bounded parameter examples use tolerance10^-30, including cH above10^8 and noninteger H. All checks passed. The output includes the actual radix-two lengths, which can be very large. These examples establish finite sufficient choices only; they are not recommended production settings or evidence of feasible compilation.

The script's receipt is `auxiliary_fourier_parameters.json`. Its proof-relevant comparisons are exact; the script digest is recorded there. Independent review should check the envelope transfer, cutoff and folding conventions, every norm multiplier, geometric denominator, common-cutoff monotonicity, and the scope of future rounding hypotheses. All analytic adapters and kernel replay remain unimplemented. Existing frozen family receipts and parameter rules are unchanged.
