# Independent review of the complete one-node P bound

2026-11-11. **PASS at paper proof plus exact external arithmetic scope. No correction requested.** The reviewed route proves

`|P(i*(pi/4-1/1000001))| <= 2^-408 < 2^-128`

for the actual, unhalved-xi-normalized principal kernel. It is a positive-radius absolute enclosure at one exact point, not an exact-zero claim or a spectral certificate.

## Frozen packet and independent replay

Paths are relative to `work/qrh-campaign/agents`.

| Item | SHA256 |
|---|---|
| `integration/PRINCIPAL_ONE_NODE_BOUND_2026-11-11.md` | `5EF2C88A9C98B0CAEE8C8DB277238CAC0EADD1AC00E311D7277F9E563D7C0B14` |
| `integration/principal_one_node_bound_20261111.py` | `A6BB7EB9EA22790C953C6476963632B9DE60EAAACEBEC395F137CA15DE569CA1` |
| `integration/principal_one_node_bound_20261111.json` | `3395166C8A2A5804A19EB9449336FB12224E682DC04DC39315443585C9AAE029` |
| Independent `mellin/review_principal_one_node_bound_20261111.py` | `2FB2F1FAA67EF10C98160D6BD52270D5DC3190A48E401836C864F49F48D1A37D` |
| Independent `mellin/review_principal_one_node_bound_20261111.json` | `C9971353F12EC6CDDC0C2EA63C0B5081052B0ACB0AD1D30C4DFBBD20CE301D97` |

Both the author's read-only replay and the independent checker exited zero. The independent checker imports no producer or numerical library. It checks ten artifact pins and two source hashes, reconstructs interval endpoints from exact midpoint/radius pairs, independently maximizes norm squared over rectangle corners, checks the nine domain/norm assertions, and rederives all eleven scalar checks. It also checks the actual graph operand IDs and the rational approximations needed to select both translations. The seed and full-input arithmetic operation gates were already independently reviewed; their frozen reports are pinned and remain prerequisites, not replaced by testing this intended point alone.

The preceding seed review has SHA `A842B04F0C18005A89C48F2F377A063E1B9F98B47CFCC9B9CFA1FE579DFD102A`; the preceding two-step arithmetic review has SHA `46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697`. Their source receipts and old failure records are unchanged.

## Actual point, word and theta type

Put eta=1/1000001, b=pi/4-eta, w=ib. Since `0<eta<3/4<pi/4`, the point is strictly in the kernel strip. The identity

`tau=i*exp(2w)=-cos(2eta)+i*sin(2eta)`

identifies exactly the previously certified seed. Also `|exp(w/2)|=1`, without evaluating its phase.

The word T(-1), S, T(0) means `t=tau+1`, `v=-1/t`, followed by no final shift. The exact boxes give `|Re(t)|<3/5`, `0<Im(t)<1/2`, `|Re(v)|<3/5`, and `Im(v)>=1024>2/5`. Thus the inversion and terminal guards hold strictly where required. For the nearest-integer selection rule, xhat=-1 initially and xhat=-1/2 finally approximate the respective real parts with error less than 1/10; the latter permits integer zero as a nearest-integer tie choice. The independent checker verifies these additional bounds. There is no undecided exact half-integer comparison.

For classical theta constants the correct holomorphic identity is

`theta3(tau)=theta4(t)=A(t)*theta2(v)`, `A(t)=1/sqrt(-i*t)`.

The odd translation swaps theta3 and theta4, and the S transformation sends theta4 to theta2. It does not produce a theta2 translation phase here. The last translation is zero. The principal square root is the previously verified branch on `Re(-i*t)>0`. Mathlib's two-variable `jacobiTheta₂` is not being mistaken for classical theta2.

I checked this against the frozen modular plan and its independent review, respectively SHA `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` and `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED`. The theta2 half-integer series has no zero mode. That fact is essential to the conclusion.

## Entire reduced jet bound

For Y=Im(v)>=1024 and a=n+1/2, pairing the modes n and -n-1 yields, for j=0,1,2,

`|theta2^(j)(v)| <= 2 sum_(n>=0) (pi*a^2)^j exp(-pi*Y*a^2)`.

Derivatives are with respect to the theta argument. Normal convergence on compact upper-half-plane subsets justifies the pairing and both differentiations; it is part of the reviewed analytic route, not inferred from a finite numerical sum.

For every a>=1/2, each of the three polynomial factors is at most `16a^4`: the j=0 case uses `a^4>=1/16`, j=1 uses `4a^2<=16a^4`, and j=2 uses pi<4. The nonnegative exponential series gives `a^4<=2 exp(a^2)`. Using pi>3 and Y>=1 therefore bounds the whole sum by

`64 sum exp(-(3Y-1)*a^2) <= 64 sum exp(-2Y*a^2)`

`<= 64 exp(-Y/2)/(1-exp(-2Y)) <= 128 exp(-Y/2)`.

Here `a^2>=n+1/4` holds for all natural n, and `exp(-2Y)<=1/4` follows from exp(1)>=2. Finally `Y/2>=512` and `exp(512)=exp(1)^512>=2^512` prove the uniform whole-series bound `G=2^-505`. No modes, tails or rounding terms are omitted: the jet is bounded directly in norm without computing a center.

I read the actual source statements `Real.sum_le_exp_of_nonneg`, `Real.exp_nat_mul`, `Real.exp_neg` and the cited pi bounds. The new checker verifies the source file hashes `58E8B7A97645F6F1BD3CA1D08860CB27B8C705C394FA101E057542970F34B036` (Pi/Bounds) and `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0` (Complex/Exponential). The all-n inequalities above remain a paper proof, not a claim that Python proves those analytic source statements.

## Transport, normalization and final radius

Independent differentiation gives `A'/A=-1/(2t)`, `A''/A=3/(4t^2)`, `v'=1/t^2` and `v''=-2/t^3`. Consequently

`f'=A*(-g0/(2t)+g1/t^2)`,

`f''=A*(3g0/(4t^2)-3g1/t^3+g2/t^4)`.

These include the value component g0 and the full coefficient -3 of g1 in the second derivative. The preceding translation has derivative one, so these are theta3 derivatives at tau. The recorded whole-box bounds `|A|<=2^10`, `1/|t|<=2^20` imply, with E=2^20,

`|theta3'| <= 2^10*(E/2+E^2)*G <= 2^51 G`,

`|theta3''| <= 2^10*(3E^2/4+3E^3+E^4)*G <= 2^92 G`.

The independent checker reproduces both exact coefficient inequalities. There is no approximate coefficient substituted for its true value, so no missing coefficient-rounding term.

Expanding the actual identity

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`

recovers precisely `-12*pi*n^2*exp(5w/2)` and `8*pi^2*n^4*exp(9w/2)` in the positive-index kernel series. This agrees with the pinned xi evaluator `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, including its factor of two convention. With the certified `|tau|<=2`, the final amplification is at most `12*2^51+16*2^92<=2^97`. Hence the radius is `2^97 G=2^-408`.

This proves a disk bound. Converting it to separate coordinate intervals is sound, but later forgetting the disk and reconstructing a generic norm from the coordinate box would incur sqrt(2). The producer states this distinction correctly.

## Accepted scope and open work

This is a complete local mathematical bound supported by exact finite arithmetic, using the previously reviewed seed, arithmetic and analytic theta identities. It is not yet a Lean proof: theta adapters, normal convergence and derivative formulas, typed graph soundness and rational replay must still be formalized. No general numerical exponential oracle is required for this particular node.

The result supplies no other real node or height and no whole-panel enclosure, Fourier integral, zero count or family coverage. Theta3/theta4 terminal types or a smaller terminal imaginary part require a different estimate. Earlier compact-receipt failures are neither contradicted nor repaired outside the separately verified lossless graph.
