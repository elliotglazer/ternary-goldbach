# Independent review of the auxiliary-margin design

2026-11-11. Verdict: PASS for the conditional design and all 24 exact scalar witnesses. No correction is requested. The design does not establish a measured discrepancy bound, a sign packet, or saturation for any character. No spectral computation, FFT, Lean/Lake command, dependency change, canonical edit, or frozen-source mutation occurred.

The reviewed note is `integration/TURING_AUXILIARY_MARGIN_DESIGN_2026-11-11.md`, SHA256 `36AFA1DF2A38D56A0677816038B08821B6CD5919118CEADB7616717047209943`. Its producer script is pinned to `5C49EE7A33C86186ADA1A7F11AC2CE424124A2065623D8366C81ADAA684DBAC1` and its JSON to `25B7183974DFBFE3018A8FB0011D7BD942758DFFE602957BC6E3105D2FA59A35`. Paths below are relative to `work/qrh-campaign/agents/` unless stated otherwise.

## Independent checks

I read the note, its script and receipt, the selected character-manifest height formula, the arbitrary-height Fourier parameter note and its independent review, and the previously reviewed Turing assembly and actual closed-count consumer. The reviewer-owned script imports no producer code. It checks ten frozen pins before and after the computation, reconstructs each selected height using the equivalent outer-ceiling formula, and checks every proof-relevant field in all 24 rows.

The script `mellin/review_turing_auxiliary_margin_20261111.py`, SHA256 `6106B656C90BF9D61B24CC8FF0DC82023892CF318C11B5B32AE73C5D8FBC4EF0`, returned exit 0 with `PASS_24_CONDITIONAL_WITNESSES_AND_10_PINS`. Its separate receipt `mellin/review_turing_auxiliary_margin_20261111.json` has SHA256 `DE2CB5E9F69710B84A816FBDC0252116466908D664F1B2D191D4572415977857`. Arithmetic is exact Python Fraction/integer arithmetic. No floating logarithm is used. The checker also verifies the first-success k property, though minimality in this particular search is not necessary for validity.

## The measured deficit and the actual consumer

The accepted closed-count formula gives, for H=T+h,

    h C_chi(T) = A + s - L,

where A is the actual integral of G, s is the sum of the two canonical S integrals, and L is the actual integrated added-zero count. Certified data provide Abar>=A and a lower weight W<=L. The per-character Turing bound is at most a proved rational b. Therefore

    C_chi(T) <= U=(Abar-W+2b)/h.

For a certified main lower count K, the note defines exactly

    D=(Abar-W)/h-K,
    U-K=D+2b/h.

The criterion D+2b/h<1 is consequently sufficient for integer saturation. D is rational once the actual data and enclosures are supplied; it is not a theoretical typical density and it is not determined by h. The note includes all Gamma enclosure error in Abar and uses upper endpoints of proven sign intervals in W. Replacing those endpoints by unverified root midpoints would not be sound.

Writing e=Abar-A>=0 yields the explanatory identity

    D=(C_chi(T)-K)-s/h+(L-W+e)/h.

Its signs are correct. The missed auxiliary weight, interval-localization loss, and Gamma error occur with nonnegative sign. Selected roots inside disjoint intervals contribute localization losses v_j-gamma_j bounded by their interval widths. Their existence is furnished by sign changes; no approximate root list is being treated as exact.

For real characters the two channels represent positive and negative roots and occur twice in W and in the S allowance. For a nonreal pair each positive channel occurs once. The central main contribution occurs once. Zeros at T are already in the closed main count, and zeros at H contribute zero integrated added weight at that endpoint. These conventions agree with the actual consumer.

If K omits a main zero, integer-valuedness gives C_chi(T)>=K+1. Every sound upper U is then at least K+1. No choice of h can make that unchanged incomplete main count pass. The design explicitly retains this restriction.

## Strict margin and logarithm certificates

For 0<rho<1, the two conditions

    D<=1-rho,    2b/h<(8/9)rho

give U-K<1-rho/9. The displayed margins 1/36, 1/18, and 1/12 for rho=1/4,1/2,3/4 are correct and strict. They are conditional on the measured D bound, not consequences of the selected length alone.

The rational logarithm test is valid even when its non-strict comparison is an equality. Indeed pi>3 and k>=1 give

    c(T+h)/(2pi) < c(T+h)/6 <= (8/3)^k < exp(k).

The final inequality follows from exp(1)>8/3. The independent checker confirms the explicit positive Taylor sum through degree 4 is 65/24, exceeding 8/3 by 1/24. Taking logarithms proves the strict upper bound log(c(T+h)/(2pi))<k. Thus b_k=42+(693/100)k is a valid rational upper bound for the actual B, with room for equality in the input test.

The chosen integer

    h=floor((9/8)*2b_k/rho)+1

is strictly greater than its threshold, even when that threshold is an integer. This proves 2b_k/h<(8/9)rho. Checking the exponential test again at this same h resolves the occurrence of h inside the logarithm. It would be wrong to evaluate the logarithm at T while using an auxiliary interval ending at T+h; the script does not do that.

For fixed c,T, the derivative of the actual allowance ratio is

    d(2B(c,T+h)/h)/dh
      =2/h^2*((693/100)*h/(T+h)-B(c,T+h))<0.

Here T>50 and c>1 make B>42>693/100. Its limit is zero by log(T+h)/h tending to zero. This monotonicity concerns the allowance alone. No monotonicity or upper bound for D(h) follows, and none is claimed. Similarly, the exponential search eventually has a witness because h_k grows linearly while (8/3)^k grows exponentially; this says nothing about obtaining the required measured data.

## Family heights and the 24 rows

The selected profile in the manifest is

    qt(c)=c for even c, and 2c for odd c,
    Hp(c)=200+max(1000,ceil(704*1200000/(7qt(c)))),
    Hcert(c)=min(Hp(c),100000000/c).

It is identical to ceil(200+max(1000,704*1200000/(7qt(c)))) followed by the same minimum, because 200 and 1000 are integers. The second branch of the minimum stays rational and is not rounded up. All representative conductors belong to the selected odd or divisible-by-four classes. Conductor one is excluded from this nonprincipal design.

All eight displayed T values, all 24 h and k values, the conditional margins, and the cT/cH fields match the independent reconstruction. For rho=1/2, the three allowance ratios are exactly 5327/12000, 8337/18775, and 17367/39100, each below 4/9. The flags saying no measured D, Gamma integral, or sign data were supplied are false-valued in every row, as required.

The enlargement examples are exact. At c=4, c(T+h)=100002880. At c=300000, T=1000/3, h=782, H=3346/3, h/T=1173/500, and cH=334600000. Among the eight middle-design rows, only c=3 and c=101 stay within cH<=100000000. The height selection is therefore not compatible with blindly retaining the old product-cap evaluator bounds.

## Evaluator and proof-status boundary

The cited arbitrary-height Fourier adapter allows H_eval>=T+h, or larger if the actual evaluated grid requires it, with C=cH_eval and newly checked parameter choices. Its reviewed implication has no cH cap and covers both parities. It is an analytic parameter implication, not a certificate of coefficient rounding, FFT output, strict signs, or feasible cost. The design preserves those distinctions and correctly warns that old stage/precision caps may fail after enlarging the transform.

Only intervals strictly inside the actual auxiliary interval contribute to W; evaluating a broader grid does not change its weight formula. Previously proved signs may be reused only as facts about the same correctly normalized actual function. Sparse sign intervals can suffice, but neither a dense grid nor a shrinking numerical tolerance proves that enough ordinary sign changes exist. Saturation through ordinary critical-line signs is a stronger goal than the selected beta<=.555 assertion, and may fail in cases that still satisfy that assertion. The note states this limitation.

This review accepts the sufficient conditional design and its exact witnesses. Actual main and auxiliary signs, central multiplicities, Gamma-integral enclosures, measured D bounds, coefficient/FFT error certificates if that evaluator is used, and the strict integer check remain unsupplied. All analytic and arithmetic Lean implementations remain open. No character or enlarged height is certified by these scalar witnesses alone.
