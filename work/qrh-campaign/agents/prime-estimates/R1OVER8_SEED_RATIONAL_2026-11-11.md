# Rational certificate for the r=1/8 modular seed

2026-11-11. Exact rational Taylor bounds enclose

`exp(1/4)*(-cos(2/1000001) + i*sin(2/1000001))`

strictly inside the unchanged internal midpoint/radius seed box of the new `T=1000000,r=1/8` lossless word. This supplies the seed at paper-proof plus exact-external-arithmetic scope. It is not a Lean proof, a theta evaluation, or a certificate of the rest of the word.

## 1. Exact target and reproducible files

Paths are relative to `work/qrh-campaign/agents/`.

| Item | Path | SHA256 |
| --- | --- | --- |
| Unchanged target payload | `integration/lossless_modular_word_20261111.json` | `E60FCABF3A3A71F7FBDD39CDD58A00495973B0A3B2D2245F91A317F46D6C6910` |
| New exact generator/checker | `prime-estimates/r1over8_seed_rational_20261111.py` | `099E38BEAF5C184234FA35D30C896C996FC166CBE5E0002B532692D4F298C173` |
| New certificate and verification | `prime-estimates/r1over8_seed_rational_20261111.json` | `E4EFD292003D1216EDA8E4BD9BFF7921050874F9378222C34A5A71EC39974E89` |
| Previously reviewed trigonometric argument | `integration/LOSSLESS_SEED_TAYLOR_2026-11-11.md` | Read-only mathematical reuse of its section 2; the new product is checked separately. |

The target is exactly `packet.nodes[0]`, with ID `tau`, kind `complex`, operation `unproved_seed`, and no operands. The checker requires packet format `lossless-modular-word-r1over8-v1`, integer T=1000000, r string `1/8`, and the literal seed expression above. It first verifies the full target hash. For each real and imaginary component, it then verifies radius>=0, lo=mid-radius, and hi=mid+radius, using the supplied exact signed-exponent dyadics. No seed byte is rewritten.

The certificate separately binds the same target hash and node, T, r, expression, trigonometric argument x=2/1000001 and exponential argument u=1/4. The dependence 2r=u is exact. The underlying modular expression has this form by `tau=i*exp(2w)` at `w=r+i*(pi/4-1/(T+1))`; alternatively the target's fixed expression is the direct object certified here. There is no substitution of a nearby parameter.

Read-only replay from the repository root:

```
python work/qrh-campaign/agents/prime-estimates/r1over8_seed_rational_20261111.py --check work/qrh-campaign/agents/prime-estimates/r1over8_seed_rational_20261111.json
```

Generation and this read-only replay both exited 0. The script imports only Python standard-library exact integers and fractions; it imports no earlier numerical producer, Arb, numerical exp/trig routine, or Lean module.

## 2. The exponential enclosure and its all-index tail

Set u=1/4, N=48 and `t_k=u^k/k!`. These are strictly positive rational numbers. The actual real exponential has the absolutely convergent series

`exp(u)=sum_{k>=0} t_k`.

Let `EL=sum_{k=0}^{47} t_k` and `rho=1/196`. For every integer j>=0,

`t_(48+j+1)/t_(48+j) = 1/(4*(49+j)) <= 1/196 = rho < 1`.

Induction gives `t_(48+j) <= t_48*rho^j` for every j>=0, including equality at j=0. Summing nonnegative terms and the geometric majorant yields

`0 < exp(u)-EL <= t_48/(1-rho)`.

Define `EU=EL+t_48/(1-rho)`. Then `0<EL<=exp(u)<=EU`. The finite certificate stores t_0 through t_48, EL, EU, rho, and the exact tail bound. It checks `tail*(1-rho)=t_48`; this cannot silently omit the first tail term. The inequality for all j is the induction and denominator comparison above, not an assertion inferred from finitely many tested ratios.

The generator obtains terms recursively, while the checker independently reconstructs each term as `(1/4)^k/k!` using integer factorials and powers. It also checks every supplied recurrence. No approximation to exp(1/4) is accepted as an input.

## 3. Trigonometric bounds

Put x=2/1000001, so 0<x<1. For a in {0,1}, define

`f_a(k)=x^(2k+a)/(2k+a)!`,

`P_a(n)=sum_{k=0}^{n-1} (-1)^k*f_a(k)`.

For every k>=0,

`f_a(k+1)/f_a(k)=x²/((2k+a+1)*(2k+a+2)) <= x²/((a+1)*(a+2)) < 1`.

Thus the terms decrease to zero, with a geometric majorant. The actual sine/cosine series and the alternating-series inequalities give

`CL=P_0(6) <= cos(x) <= P_0(7)=CU`,

`SL=P_1(6) <= sin(x) <= P_1(7)=SU`.

Both interval widths equal the corresponding positive term f_a(6). This is the already-reviewed small-argument proof, reused with exactly the same x. The current checker recomputes all fourteen terms directly from powers and factorials and checks both bounds and both global ratio constants. It also verifies `0<CL<CU` and `0<SL<SU`; positivity is used in the product rule.

## 4. Products, signs and error accounting

All three factor intervals are positive. Consequently the actual complex seed lies in the exact rational box

`Re(tau) in [-EU*CU, -EL*CL]`,

`Im(tau) in [EL*SL, EU*SU]`.

The minus sign reverses both real endpoints. Each product uses independent factor bounds, so no correlation assumption is needed. The exponential tail and trigonometric truncation errors are already included in their intervals; forming these products includes their cross term as well. There is no additional floating-point or directed-rounding error because every multiplication and endpoint comparison is exact rational arithmetic.

The checker verifies strict inclusion of this product box in the target lo/hi values. Exact margins are stored as full numerator/denominator pairs. Their strict dyadic lower bounds are:

| Clearance inside frozen target | Strict lower bound |
| --- | ---: |
| Real lower | 2^-255 |
| Real upper | 2^-254 |
| Imaginary lower | 2^-271 |
| Imaginary upper | 2^-275 |

There are 63 stored positive terms: 49 exponential terms including the first omitted term, plus seven terms in each trigonometric channel. The largest integer in the checked term/bound/product/margin ledger has 743 bits. These are small bounded rational computations; no claim is made that this representation is suitable for the later extreme-exponent modular coefficients.

Twelve corruptions are rejected: wrong T, wrong r, wrong x, wrong u, wrong expression, wrong source hash, wrong node ID, wrong alternating truncation parity, a false exponential term, a zero exponential tail, a false tail ratio, and a false cosine upper bound. These are targeted controls, not comprehensive parser-security tests. The checker requires the expected product formula and does not accept a user-supplied product interval.

## 5. Actual source bridge

Mathlib pin is `56a005855ea17e0b0958f73ec801ae140b0a1679`, under `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/`. The following exact source statements were inspected without running Lean:

| File | Relevant statement | SHA256 |
| --- | --- | --- |
| `Mathlib/Analysis/Normed/Algebra/Exponential.lean` | `NormedSpace.expSeries_div_hasSum_exp` at 640 gives `HasSum (fun n => x^n/n!) (exp x)` in a complete normed division algebra. Specialize to the reals. The nearby `expSeries_div_summable` supplies absolute-series context. | `A0D4349C556CC8E9C1D637C183F75B4457BBA1733733131EE908E0BD645E798C` |
| `Mathlib/Analysis/SpecialFunctions/Exponential.lean` | `Real.exp_eq_exp_ℝ` at 214 identifies the actual Real.exp with NormedSpace.exp. This prevents an implicit change of exponential normalization. | `AAC75D08A408C7DFAAA39A7F3EC9D9E5E3764B8887FDC447FB5AD32305075E79` |
| `Mathlib/Analysis/SpecificLimits/Basic.lean` | `hasSum_geometric_of_lt_one` at 317 requires 0<=rho and rho<1 and gives sum rho^n=(1-rho)^-1. | `26D6BE249C6B40826AA20DF04166887CB3F496EF87BBB38633BD559A2F5B93D9` |
| `Mathlib/Analysis/SpecialFunctions/Trigonometric/Series.lean` | `Real.hasSum_cos` at 100 and `Real.hasSum_sin` at 105 are exactly the two real Taylor series used here. | `1C8457816ED5E9D72967890E7C25EECE5A5FF2D9B90248B768E060993ADFC9FF` |
| `Mathlib/Analysis/SpecificLimits/Normed.lean` | `Antitone.alternating_series_le_tendsto` at 1007 gives the even lower bound, and `Antitone.tendsto_le_alternating_series` at 1021 gives the odd upper bound. | `29AA06CCC31F1BFD454DBF888C108F4C3FBE8AA5A9AEDE4F95D3D7473C03EE70` |

The remaining general formal steps are the elementary term-ratio induction, nonnegative infinite-sum comparison and tail split, the existing alternating-series specialization, positive interval multiplication, and sound evaluation of the supplied rational identities. The source has the actual analytic functions and convergence theorems; none of this says that the new checker or specialized bridge has already been formalized.

The historical target file still labels its seed unproved and remains untouched. This separate version-bound supplement supplies the missing local mathematical argument at its stated paper/external level. Composition with the 87 operation/constant checks and 43 domain checks of the lossless word requires their separate accepted arithmetic argument. The present task evaluated only the seed. It supplies no derivative jets, theta sums, contours, zero counts, or Goldbach conclusion.
