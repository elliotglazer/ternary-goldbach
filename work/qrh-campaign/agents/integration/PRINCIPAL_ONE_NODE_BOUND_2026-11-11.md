# One complete principal P-kernel node by an absolute bound

2026-11-11. For the exact prescribed point

`eta=1/1000001`, `b=pi/4-eta`, `w=i*b`,

the argument below and the accompanying exact rational checks establish

**`norm(P(w)) <= 2^-408 < 2^-128`.**

P is the actual differentiated-theta kernel of the reviewed principal xi evaluator, with its unhalved source normalization. The output is an enclosure centered at zero with the positive absolute radius `2^-408`, not an assertion that P vanishes.

This is a complete local paper/exact-external-certificate route: the rational seed certificate, lossless arithmetic graph, terminal guards, entire reduced theta2 series bound, derivative transport, and final P prefactors are all included. It remains unformalized. No grid, other height, analytic jet computation, contour, or spectral claim is made. All prior frozen artifacts remain unchanged.

## 1. Packet and dependencies

All paths in this section are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
|---|---|---|
| New exact checker | `integration/principal_one_node_bound_20261111.py` | `A6BB7EB9EA22790C953C6476963632B9DE60EAAACEBEC395F137CA15DE569CA1` |
| New receipt | `integration/principal_one_node_bound_20261111.json` | `3395166C8A2A5804A19EB9449336FB12224E682DC04DC39315443585C9AAE029` |
| Seed certificate | `integration/lossless_seed_taylor_20261111.json` | `6C3EE4AE09014B64541899F276405C607624A5DABF70DFBA3AEE5EF654E82C3F` |
| Seed proof | `integration/LOSSLESS_SEED_TAYLOR_2026-11-11.md` | `E5AB4A2B4B7A81DC6731F337D032A39F6DF2509F580D4E00B109DC2DF9A7D00B` |
| Seed review | `mellin/REVIEW_LOSSLESS_SEED_TAYLOR_2026-11-11.md` | `A842B04F0C18005A89C48F2F377A063E1B9F98B47CFCC9B9CFA1FE579DFD102A` |
| Lossless arithmetic receipt | `integration/lossless_modular_two_step_20261111.json` | `31DD05C2F85A02D29037E91BA63BE85AEC5C55063FED96010552C5BCF0034FBE` |
| Arithmetic proof | `integration/LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `2AC88432744B5D99FC821A16E2A0AD2B3AC9AB5483956F1A0B8DB2FAD8CD4230` |
| Arithmetic review | `mellin/REVIEW_LOSSLESS_MODULAR_TWO_STEP_2026-11-11.md` | `46BDD3D1CA0AD8C730A693AC4CFA7F5D55C3043EDBF4180B82C939C5BC18B697` |
| Modular theta/jet plan | `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` |
| Modular plan review | `audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED` |
| Actual P normalization | `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99` |
| Xi evaluator review | `audit/REVIEW_PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2` |

The new script hash-checks the operative receipts, replay code, and analytic plan files, then reruns both existing exact checkers. Their generators are not executed. No Arb or numerical transcendental function is imported by this path.

Read-only command, from the repository root:

```
python work/qrh-campaign/agents/integration/principal_one_node_bound_20261111.py --check work/qrh-campaign/agents/integration/principal_one_node_bound_20261111.json
```

It passed. The receipt records nine exact domain/norm guards and eleven scalar checks. Corruptions of the node, height, selected theta type, or final radius are rejected. Successful replay checks the finite inputs and constants of this paper argument; it does not prove the analytic lemmas inside Python.

## 2. Exact point and completed modular word

Let `tau=i*exp(2w)`. Euler's identities with `2b=pi/2-2eta` give

`tau=-cos(2eta)+i*sin(2eta)`.

This is precisely the seed enclosed by the reviewed rational Taylor certificate. Since `0<eta<3/4<pi/4`, b lies strictly between zero and pi/4, so w is in the kernel's holomorphic strip. The fact `norm(exp(w/2))=1` follows from `Re(w)=0`; it requires no numerical exponential enclosure.

The complete word is `T(-1), S, T(0)`. Put

`t=tau+1`, `v=-1/t`, `A=1/sqrt(-i*t)`.

The lossless graph proves the actual point enclosures and the principal square-root branch. Exact checks on those same enclosures now give

```
-3/5 < Re(t) < 3/5,       0 < Im(t) < 1/2,
-3/5 < Re(v) < 3/5,       Im(v) >= 1024 > 2/5,
norm(tau) <= 2,           norm(t) >= Im(t) >= 2^-20,
norm(A) <= 2^10.
```

Norm upper bounds are checked by bounding `Re^2+Im^2` over the entire recorded box. The lower bound for norm(t) uses its positive imaginary lower endpoint. Thus the selected S step and final T(0) stopping decision are valid without a boundary equality test. T(0) is the identity; no extra arithmetic approximation or phase is introduced.

## 3. The reduced type is theta2, with no constant term

Use the classical theta functions of the reviewed plan:

`theta2(z)=sum_(n in Z) exp(pi*i*(n+1/2)^2*z)`,

`theta3(z)=sum_(n in Z) exp(pi*i*n^2*z)`,

`theta4(z)=sum_(n in Z) (-1)^n*exp(pi*i*n^2*z)`.

The exact T identity for an odd shift gives `theta3(tau)=theta4(t)`. The S identity gives

`theta4(t)=A*theta2(v)`.

There is no omitted eighth-root phase in this particular path: the T step swaps theta3/theta4, the S step uses the recorded principal A, and the terminal shift is zero. The half-integer theta2 series has no zero mode or additive constant. Accidentally using theta3 here would invalidate the small bound.

These identities hold holomorphically on the upper half-plane, not merely at the numerical point. Their first two derivatives may therefore be transported as identities. The classical adapters and their derivation from Mathlib's two-variable Jacobi theta functional equation are in the reviewed modular plan, sections 2–3. In particular, Mathlib's symbol `jacobiTheta₂` means the two-variable function, not classical theta2.

## 4. Uniform absolute bound for the whole theta2 jet

Write `Y=Im(v)>=1024`, and `g_j=theta2^(j)(v)` for j=0,1,2, where derivatives are with respect to v. Local normal convergence of the Gaussian series justifies differentiation termwise. Pairing n with −n−1 gives

`norm(g_j) <= 2*sum_(n>=0) (pi*a_n^2)^j * exp(-pi*Y*a_n^2)`,

where `a_n=n+1/2`. For a>=1/2, `pi<4` implies, for each j=0,1,2,

`(pi*a^2)^j <= 16*a^4`.

For j=0 this is `1<=16a^4`; for j=1 use `4a^2<=16a^4`; for j=2 use `pi^2<16`. The factor 2 for the paired half-integers is retained, giving 32 before the next bound.

For u>=0 the nonnegative exponential series gives `exp(u)>=u^2/2`. At u=a^2, this yields `a^4<=2*exp(a^2)`. Also `pi>3`, `Y>=1`, and `(n+1/2)^2=n^2+n+1/4>=n+1/4`. Consequently,

```
norm(g_j)
 <= 32 sum a_n^4 exp(-3Y*a_n^2)
 <= 64 sum exp(-(3Y-1)*a_n^2)
 <= 64 sum exp(-2Y*a_n^2)
 <= 64 exp(-Y/2) sum_(n>=0) exp(-2Y)^n.
```

Since `exp(1)>=2` and Y>=1, `exp(-2Y)<=1/4`; the geometric sum is at most 4/3, hence at most 2. Finally Y>=1024 gives

`norm(g_j) <= 128*exp(-512) <= 128*2^-512 = 2^-505`.

Set `G=2^-505`. This bounds the **entire** value and both derivatives, including every half-integer mode. No finite theta terms or tiny floating-point values are used, and no tail is dropped. The argument is uniform for all v in the certified terminal box because it uses only its imaginary lower bound.

The elementary source inputs, in Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`, are `Real.pi_gt_three` and `Real.pi_lt_four` (`Analysis/Real/Pi/Bounds.lean:151,155`), and `Real.sum_le_exp_of_nonneg`, `Real.exp_nat_mul`, and `Real.add_one_le_exp` (`Analysis/Complex/Exponential.lean:249,234,633`). The latter two give `exp(512)=exp(1)^512>=2^512`; positivity and the negative-exponent identity reverse this into the displayed upper bound. File hashes are respectively `58E8B7A97645F6F1BD3CA1D08860CB27B8C705C394FA101E057542970F34B036` and `564992EF54C295F97D4E00CA0D07A396C068F331D09EFD29B85E4863511986F0`.

## 5. All derivative and P prefactors

For `f(t)=A(t)*theta2(-1/t)`, the reviewed derivatives are

```
f'  = A*(-g_0/(2t)+g_1/t^2),
f'' = A*(3g_0/(4t^2)-3g_1/t^3+g_2/t^4).
```

They follow from `A'/A=-1/(2t)`, `A''/A=3/(4t^2)`, `v'=1/t^2`, and `v''=-2/t^3`. Translation from tau to t has derivative one, so these are also the first and second derivatives of theta3 at tau. In particular the terms involving g_0 must not be discarded.

Put `E=2^20`. With `norm(A)<=2^10`, `1/norm(t)<=E`, and all three jet norms at most G,

```
norm(theta3'(tau))
 <= 2^10*(E/2+E^2)*G <= 2^51*G,

norm(theta3''(tau))
 <= 2^10*(3E^2/4+3E^3+E^4)*G <= 2^92*G.
```

Both loose coefficient inequalities are checked exactly in the new receipt. No approximate A, inverse, or derivative center is substituted in these bounds.

The actual kernel identity is

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`.

It expands to the source-normalized series with coefficients `8*pi^2*n^4*exp(9w/2)` and `-12*pi*n^2*exp(5w/2)` in the xi evaluator. With `norm(exp(w/2))=1` and `norm(tau)<=2`,

```
norm(P(w)) <= (12*2^51 + 16*2^92)*G
           <= 2^97*G
           = 2^-408.
```

Thus a center-zero disk of radius `2^-408` is a valid coefficient enclosure. A rectangular representation may use coordinate intervals `[-2^-408,2^-408]`; if only that rectangle is later retained, its generic Euclidean-radius bound is sqrt(2) times the coordinate radius. Here the stronger disk bound itself has been proved and should be retained as such.

## 6. Exact scope and next obligations

The previous missing local numerical seed is supplied by its reviewed rational certificate, and the entire reduced theta series is controlled analytically. This reaches the actual P coefficient at this one node without general exp/trig replay or reproducing huge-negative-exponent theta values.

The remaining work is formalization of the already identified analytic adapters and exact checkers, and production/verification for other required nodes. This packet does not establish that the same zero-centered shortcut succeeds elsewhere: a different modular word can select theta3 or theta4, which have a constant term, or have a much smaller reduced imaginary part. It does not change Fourier quadrature, whole-panel, zero-count, or finite-family obligations. No Lean theorem or complete spectral certificate is claimed.
