# Damped symmetry and the finite Gaussian psi zero sum

2026-11-11. Paper derivation against the pinned source; no Lean declaration, evaluator run, zero scan, or change to frozen evidence. The selected application uses the accepted RH head through 1500, not the optional extension through 2000. The conclusion below is an explicit finite-zero bound. Closing the numerical `0.01/log x` budget remains a separate scalar and smoothing-assembly task.

## 1. Exact statement and inputs

Write `rho=beta+i gamma`, `x=exp L>0`, `q=delta^2/2>=0`. The source transform is

\[
 M(\rho)=M_g(a,b,\delta;\rho)
 =e^{\delta^2\rho^2/2}\int_b^a e^{\rho w}\,dw.
\]

For `h>=0` define, for each real endpoint `e`,

\[
 B_h(e)=\exp\{e/2+q(1/4+h^2)\}
          \cosh\{h(L+e+q)\},\qquad
 C_h=B_h(a)+B_h(b).                                      \tag{1}
\]

In particular `C_0=exp(q/4)(exp(a/2)+exp(b/2))`. Let `A>0`, `T>=A`. Assume every nontrivial zeta zero with `|gamma|<=A` has `beta=1/2`, and every such zero with `A<|gamma|<=T` has `|beta-1/2|<=h`. All zeros and sums below retain their true positive analytic multiplicities. These are inclusive finite-height hypotheses. No simplicity assumption is used.

Put

\[
 f_q(t)=e^{-qt^2}/t\quad(t>0),\qquad
 N(t)=\sum_{0<\gamma\le t}m_\rho.
\]

For the complete finite nontrivial-zero carrier through `T`,

\[
 \boxed{\quad
 {1\over x}\sum_{|\gamma|\le T}m_\rho
       |M(\rho)x^\rho|
 \le 2e^{-L/2}\left[
 C_0\sum_{0<\gamma\le A}m_\rho f_q(\gamma)
 +C_h\sum_{A<\gamma\le T}m_\rho f_q(\gamma)\right].\quad} \tag{2}
\]

Real zeros are addressed in Section 2; they are not silently discarded. Formula (2) also bounds the norm of the corresponding complex zero sum by the triangle inequality. It bounds any selected subset only after enlarging its nonnegative norm majorant to the full carrier, not by asserting that an arbitrary subset is invariant under reflection.

The selected main/scalar application uses `A=1500`, `T=H=60343058`, `h=11/200`; it covers the entire shared conductor-1 finite height without an intermediate cutoff at 1000000. The shared finite `.555` upper bound, together with zeta functional-equation symmetry, gives the lower bound `.445`. The global `7/8` hypothesis is not used to prove (2); it remains available for the separate high-zero estimates beyond the shared finite range. The common finite height for conductor 1 is exactly this selected `T`.

## 2. Carrier, order and boundary transport

Fix an auxiliary `U>T`. Use the source `zerosRectD zetaF U`, filtered by `|Im rho|<=T`. This is a finite carrier for exactly the desired nontrivial zeros. `zerosRectD_zetaF_strip` proves that its members satisfy `0<beta<1`, `zeta rho=0`, and `xiF rho=0`. Conversely, for a nontrivial zero with `|gamma|<=T`,

\[
 |\rho-2|\le |\beta-2|+|\gamma|<2+T<U+3=RT(U)/2.
\]

Thus the zero belongs to the inner zero disk and all the strict rectangle inequalities at height `U`; the nonzero entire function has positive local order there. This gives membership in `zerosRectD`, including zeros exactly at `|gamma|=T`. It does not require `U` to avoid a zero ordinate because no contour formula is applied at `U` in this argument.

The weight is `multRectD zetaF U rho=(divB zetaF 2 (RT U) rho).toNat`. For an entire nonzero function and a point in this ball, the divisor equals its finite analytic order. `divB_eq_of_mem` makes this independent of the auxiliary containing ball. In the strict strip, `analyticOrderAt_xiF_eq` identifies the order of `xiF` with that of `zetaF`; the factor `s GammaR(s)` is analytic and nonzero there.

Let `J rho=1-conj rho`. The identities `xiF(1-s)=xiF(s)` and `xiF(conj s)=conj(xiF(s))` imply `xiF(J rho)=conj(xiF(rho))`. If the first nonzero Taylor coefficient at `rho` is of degree `m`, the first nonzero coefficient at `J rho` is its conjugate times `(-1)^m`. Hence the orders are equal. The same argument without `(-1)^m` proves order preservation under `rho -> conj rho`. This is a local analytic-order argument; it does not infer multiplicity from cardinality or from an assumed simple zero.

Consequently `J` is an order-preserving involution of the complete positive-ordinate carrier in any band defined by gamma alone. It preserves each closed or half-open band used here. Conjugation is an order-preserving bijection between the positive and negative carriers. The source balls need not be invariant: both the zero and its image separately belong to the auxiliary carrier, and their weights agree by true-order transport.

A possible real nontrivial zero belongs to the closed head `|gamma|<=A`. The head hypothesis forces it to be `rho=1/2`, contradicted by `xiF_half_ne_zero`. This discharges the real-axis contribution before doubling the positive carrier. Alternatively the separately derived unconditional low-height exclusion could discharge it, but is not an additional selected dependency here. The removable points 0 and 1 are not nontrivial zeros, and source `zetaF` has no zero at either point.

## 3. Weighted orbit identity and actual Gaussian factors

For a finite carrier `S`, an involution `J:S->S`, weights `m>=0` satisfying `m(J rho)=m(rho)`, and any real-valued `F`, reindexing gives

\[
 \sum_S mF={1\over2}\sum_Sm\{F+F\circ J\}.              \tag{3}
\]

This identity includes fixed points. It does not split into disjoint two-element orbits or divide the number of distinct zeros by two.

The exact source norm identity and endpoint estimate give, for `gamma!=0`,

\[
 { |M(\rho)x^\rho|\over x}
 \le e^{L(\beta-1)}e^{q(\beta^2-\gamma^2)}
       {e^{a\beta}+e^{b\beta}\over|\rho|}
 \le e^{-L/2}f_q(|\gamma|)
       e^{Lu+q(1/2+u)^2}
       \{e^{a(1/2+u)}+e^{b(1/2+u)}\},                  \tag{4}
\]

where `u=beta-1/2`. The second inequality replaces each denominator separately by `|gamma|`. In particular it never asserts `|rho|=|J rho|`.

For a single endpoint `e`, the arithmetic mean of the last beta factor at `u` and `-u` is exactly

\[
 e^{e/2+q/4}e^{qu^2}\cosh\{u(L+e+q)\}.                \tag{5}
\]

For `|u|<=h`, this is at most `B_h(e)`: `q>=0`, and cosh is even and increasing on the nonnegative axis. There is no sign restriction on `L+e+q`. Applying (3) to (4), then adding the two endpoint terms, proves the positive-band version of (2). The head uses `h=0`. Conjugation gives the identical bound for negative ordinates because all parameters are real and the norm in (4) depends on gamma only through its absolute value.

Thus the actual Gaussian beta dependence has not been replaced by an untracked constant. A simpler optional estimate is available when `b<=0` and `0<=h<=1/2`:

\[
 C_h\le e^{q(1/2+h)^2}
       \{e^{(1/2+h)|a|}+e^{(1/2-h)b}\}\cosh(hL).       \tag{6}
\]

For (6), bound the Gaussian and both endpoint factors uniformly first, then average only `exp(Lu)` using (3). It is a valid bound for the averaged expression even if obtained without directly comparing each separate formula in (1). Formula (1) is the sharper retained interface.

## 4. Exact damped partial summation

For `0<u<v`, finite summation by parts, with the closed count convention, gives

\[
 J_q(u,v):=\sum_{u<\gamma\le v}m_\rho f_q(\gamma)
 =f_q(v)N(v)-f_q(u)N(u)
   +\int_u^v[-f_q'(t)]N(t)\,dt,                       \tag{7}
\]

where `-f_q'(t)=exp(-qt^2)(t^{-2}+2q)>=0`. A zero at `u` is excluded from the left side and removed by the exact term `-f_q(u)N(u)`; a zero at `v` is included. The integral is unchanged by values at individual jump points. One can prove (7) by expanding `N` as the finite sum of indicators for ordinates up to `v` and integrating each indicator, so no infinite-zero interchange is needed.

Suppose `N(t)<=C(t)` throughout `[u,v]`, with continuously differentiable `C`, and `N(u)=n_u`. Then

\[
 J_q(u,v)\le f_q(u)\{C(u)-n_u\}
                 +\int_u^v f_q(t)C'(t)\,dt.           \tag{8}
\]

The upper endpoint term `f_q(v)C(v)` from (7) has been incorporated by integration by parts. It has not been dropped. If `N(v)=n_v` is also known exactly, the stronger bound is

\[
 J_q(u,v)\le f_q(u)\{C(u)-n_u\}
       -f_q(v)\{C(v)-n_v\}
       +\int_u^v f_q(t)C'(t)\,dt.                      \tag{9}
\]

For `v=u`, the band is empty and can be assigned zero directly. Formula (8) is still a valid but unnecessary overestimate in that case.

Use the existing analytic count majorant, for `t>=1500`,

\[
 C(t)={t\over2\pi}\left(\log{t\over2\pi}-1\right)
             +{7\over8}+5\log t+20,
 \qquad C'(t)={1\over2\pi}\log{t\over2\pi}+{5\over t}>0. \tag{10}
\]

Its proof uses no finite zero data or RH. The note proving it includes the passage from nonexceptional heights to the closed count. If `q>0`, `f_q(R)C(R)->0` and the integral in (8) converges at infinity. Therefore one may safely replace the finite upper limit by infinity. This enlarges a positive scalar upper bound after applying the finite-strip estimate to zeros only through `T`; it does not apply that strip to zeros above `T`. For `q=0` retain a finite upper limit.

## 5. Selected head and usable bound

The accepted head records give

\[
 n_A=N(1500)=1069,\quad
 Q_A=\sum_{0<\gamma\le A}m_\rho(1/\gamma-1/A)<1.668.
\]

Hence

\[
 \sum_{0<\gamma\le A}m_\rho f_q(\gamma)
 \le\sum_{0<\gamma\le A}m_\rho/\gamma
 < H_A:=1.668+1069/1500.                               \tag{11}
\]

Combining (2), (8), and (11) yields the selected finite bound

\[
 \boxed{\quad E_{\rm low}(T)
 <2e^{-L/2}\left[
 C_0H_A+C_h\left(f_q(A)(C(A)-1069)
                  +\int_A^T f_q(t)C'(t)\,dt\right)
                  \right].\quad}                     \tag{12}
\]

Here `E_low` is the normalized norm-sum in (2). For positive delta, the integral to infinity is an optional upper bound. The head RH input is the accepted sign-saturation certificate, not the head-count receipt alone.

Do not replace `H_A` by `Q_A+1069*f_q(A)`. Such a replacement would require an additional inequality and is generally false: the derivative weight `exp(-qt^2)(1+2qt^2)` can exceed 1. If the same coefficient were applied to head and tail, the retained correction would be `1069*(1/A-f_q(A))`, not zero. With distinct coefficients `C_0` and `C_h`, the corresponding exact bookkeeping is already explicit in (12).

For comparison only, the accepted RH extension to `B=2000`, `n_B=1517`, allows the stronger three-band expression

\[
 E_{\rm low}(T)\le2e^{-L/2}\{C_0H_A+C_0M_{AB}+C_hM_{BT}\}, \tag{13}
\]

where

\[
 M_{AB}=f_q(A)(C(A)-1069)-f_q(B)(C(B)-1517)
                 +\int_A^Bf_qC',\qquad
 M_{BT}=f_q(B)(C(B)-1517)+\int_B^Tf_qC'.
\]

Formula (13) uses (9) on the middle band. This extra RH/count dependency is not required by the selected formula (12).

## 6. Consumption and limits

The intended Gaussian sandwich sets `delta=.002/(L sqrt(L+10))`, `a=+.002/L` or `a=-.002/L`, and `b=log(1000)-L`, over `22.33<=L<=35`. Formula (12) applies separately to each endpoint choice, with its own exact `C_h`. Multiplication by `L` gives the contribution to a `constant/log x` error budget. The other smoothing, intermediate-zero, high-zero, vertical, and normalization terms must still be added with the appropriate upper/lower sandwich denominators. This note does not certify the numerical `.01/log x` conclusion or the scalar integral enclosures.

The new mathematical join is finite, multiplicity-preserving symmetry plus damped summation by parts. It needs no minimum zero spacing, no pairing of equal denominators, no simplicity, no arbitrary-subset invariance, and no finite strip above its stated cutoff. The accepted external head evidence is not a Lean proof. The shared finite `.555` spectral certificate, global `7/8` provider, scalar closure, and formalization retain their existing separate statuses.

## 7. Source and evidence pins

All Lean paths below are relative to `work/ternary-goldbach/TernaryGoldbach/`, commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. SHA256 identifies the full file.

| Source | Exact role | SHA256 |
|---|---|---|
| `Explicit/GaussSmooth.lean` | `Mg` definition108; `norm_cexp_gauss`317; `norm_intExp_le'`355 | `40ACFCF56E61C411BAF8DD3E7B5504B3DB48F34740B256A4D03F1CDBE37FEBA8` |
| `Explicit/ZetaZeroSums.lean` | `zerosRectD_zetaF_strip`39, excludes trivial/removable points | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `Explicit/Xi.lean` | entire xi; `xiF_one_sub`24; `xiF_half_ne_zero`104 | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| `Explicit/XiPartial.lean` | `xiF_conj`669 | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| `Explicit/WeilBridge.lean` | `analyticOrderAt_xiF_eq`38; equal-order divisor transport55 | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| `Explicit/ExplicitFormula.lean` | `RT`295; `divB_eq_of_mem`384 | `8CDDDBE6934871CA37260E435BE639A49AC33F4A8D92CBB2E33AB9D330869C35` |
| `Explicit/Datum.lean` | `zerosRectD`81; `multRectD`85 | `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE` |

Research/evidence paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | Role | SHA256 |
|---|---|---|
| `mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md` | actual closed-count upper bound (10), paper analytic proof | `4648E4C454F4344D4F110E878F6CF619F5AC2128CAC91C2658E443FA3D1DF303` |
| `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | accepted external `N(1500)=1069`, `Q1500<1.668` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` |
| `audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md` | accepted external finite RH through closed height1500, including real-axis exclusion/completeness | `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE` |
| `independent-feasibility/REVIEW_PRINCIPAL_SIGNS_2000_CHUNK_2026-11-11.md` | optional RH extension/count1517 for (13) only | `8EC2B71F288EFF6B2C4ABE01362E8A467C23D22BA1648B62EAABE89EC7F016E8` |
| `zero-sum/FINITE_MASS_ORDER_TRANSPORT_2026-11-11.md` | previously reviewed containing-ball/true-order transport | `C62CB504C15A02CB954C35F8F5DAB5B551C483014F6FEE1F957FF37C444C5E0D` |

No numerical special-function evaluation or new finite zero evidence was produced for this note.
