# Original-RH cutoff reduction: independent consumer review

2026-11-11. **PASS at source/paper and exact scalar-composition scope**, bound to `major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_V2_2026-11-11.md`, SHA256 `33A3D9645BD9A8F856DD13A40028FF314A2769E8938FA90050A194C048C84517`. No Lean build, declaration, spectral evaluation or source edit. This review concerns the original finite-RH branch, not the later QRH branch. It does not assert that the proposed localized interfaces have been implemented or kernel checked.

The initial author report was `major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_2026-11-11.md`, SHA256 `D4CA567BCAFAC04709B18B1B0EF892721C473B32F51C2901086A5ED609D8F03F`. I found one required scalar-source correction: its script searched each unbounded theorem suffix for a `cell_bound (Y := 1e...)` expression. Cell 1 actually uses `Y := 3e25` at `NumericsCells.lean:688`; the search instead found cell 2's `1e26`. This understated the new cell-1 base envelope. Version 2 repairs the parser with bounded theorem sections, complete scientific literals and assertions of all nine scales, and serializes the source sections and row scales. I verified these repairs and the replacement receipt. The old packet is not accepted for all-cell coverage. No further correction is required.

## The exact family retained

`MajorArcs/GRH.lean:32–37` states actual L-function RH with inclusive ordinate height. `MinorArcs/LargeSieveArcs.lean:30–41` gives radius `8R/(qtilde*x)` and `Q_R={q>=1:qtilde<=2R}`. At R=140000 the needed primitive conductors are odd c<=140000 and 4|c<=280000, including every inverse character. Conductor one is retained. There is no primitive conductor of exact 2-adic valuation one.

The odd-conductor implication is elementary but essential: if odd c divides even q, write q=c*k; k is even and positive, hence c<=q/2<=R. For odd q, qtilde=2q immediately gives c<=q<=R. Thus the weaker statement q<=2R alone would not justify the reduced odd family. `BaseGap2.gap_point:185–227` must retain its actual odd/even arc membership, or equivalently qtilde<=2R, when generalized. The report explicitly requests this repair rather than importing the old conclusion alone.

The required height remains 1e8/c for odd c, and max(1e8/c,200+7.5e7/c) for even c. `Thm714:568–680` actually uses these two even regimes, with its switch at125000. `Cor713:807–827` uses 1e8/c. For the plus bound the parity-sensitive width gives at most 600000/c for odd c and1200000/c for even c. For the base-gap star bound, 8R/q<=1200000/c suffices. Smaller R does not increase any of these widths. No weakened height, strict/inclusive swap, or hidden omitted-conductor call is allowed.

The residual prime estimates are genuinely principal. `Prop715:355–366` obtains the original quadratic coefficient energy from RH at conductor one through500. `Explicit/ZetaZeroSums:23–33` obtains the zeta RHBelow1e8 premise from conductor one. `Explicit/IEANTNBridge:20–32` transports it to the lower one-sided height used by its consumer. `LSQuot3:37–54` uses `psiN_le`, not RH for its variable rational denominator. The original Type I/II, Mertens/Moebius and prime-power estimates must be rethreaded through these principal interfaces. Retaining their unchanged mathematical estimates does not authorize retaining a blanket `[Fact PlattGRH]` argument in the new final chain.

## Lower J and the original major integral

The mass comparison is valid for the even cutoffs tested. Odd-centered intervals [q-1,q+1] for R<q<=150000 tile [R,150000], and convexity gives 2/q<=the integral of1/t on the corresponding interval. An odd integer in this range has at most five distinct prime divisors; the smallest six have product255255. Thus q/phi(q)<=15015/5760 and the report's logarithmic mass loss follows. This is a bound on an elementary finite sum, not a new spectral computation.

I read the actual `L2Major.Jq_bounds:100` proof. Its needed geometric inequalities are wx>=4 and2w<=1200000/x, both preserved by R<=150000 and qtilde<=2R. The character estimate and coprime removal remain local to q. Integration of the negative constant error uses the upper width in the safe direction. Consequently summing the stated per-q lower bound gives

    J_R/x >= .638108*s_R - .00108.

The upper bound8.79 follows either by the same positive per-q upper estimates on Q_R or their sum over the containing old set. It is not inferred by monotonicity of a signed major integral. `MinorTotal.I0_ge:277–316` then applies the complete norm-square triangle inequality at t=1e-5 and the period-wide a2 energy. It gives exactly `(Jlower-100001*8e-11)/1.00001`. The old8.6294 lower bound is not carried over.

`Singular.expansion_ge:298–331` is a signed Rankin expansion with an absolute tail. `prod_lower_bound:440` is already uniform for R>=200. The error product at R is at most its value at150000 because every factor `1+p*abs(aP)` is at least1. This justifies22.1/R. The signed singular sum itself need not be monotone. The square-weight and mass upper bounds similarly use nonnegative summands. The odd/even pairing then gives the report's C_R.

I matched every coefficient in the report's major error E to `MajorTotal:992–1039`, after division by x^2/49. C_R is positive at the proposed cutoff, as is Cmain; this sign is needed when combining the separate main-term lower bounds. All error multipliers are nonnegative. No factor49, factor9 or separate squared-weight error is dropped. The major result therefore remains1.049 once its stated exact scalar comparison is checked.

## The enlarged minor domain and all cells

The source energy is exactly `MinorTotal.sig:70`: `(.640208+366.91/sqrt(x))*log(x)-.021095`. Its proof is `T_le:216–263` using Prop715. No .65 replacement or QRH energy result enters this review.

The base-gap derivation in `BaseGap2:291–390` has two distinct coprime/character errors and the Fourier main term. With |delta|>=4R/(49q), q<=2R, and q/phi(q)<5.53, the Fourier contribution is at most `1.016*49^2*5.53/(8R)`. The remaining terms in the report are the safe `548*(E1+D/y)+D/y`. Its lower bound for ghat uses positive terms of gx, Fr>3 and sqrt(Fr)>1.7, so .014<.03 supplies the needed gap comparison. This replaces the old .0121 claim instead of assuming it.

`LinftyLevels.norm_S_etaStar_le_ghat:358–425` is available for every670<=n<=y^(1/3)/6 satisfying2.16e20*n<=670*y. These conditions hold down to R because the old r2 satisfies them. Its source proof integrates the corrected scale-wise eta2 bounds. The higher minor levels require no new nonprincipal spectral band. `Thm1321:153–211` is already generic in its base level with R>=100000 and uses the mixed x/y arc family. Its large-sieve conditions on r2 are unchanged.

The extra finite sum is over R<n<=150000, including n=150000. The old remainder starts at150001. With s=sig/Dx>=0 and antitone nonnegative G,

    sum_(R<n<=150000) G(n)*log((n+1)/n)
      <= G(R)*log(150001/(R+1)),
    cL(R)+log(150001/(R+1)) = cL(150000).

This proves the report's replacement base term and covers the new annulus. It is not an application of the old minor-total theorem. For a scalar upper evaluation, first replace cL*s-j by its scalar upper bound using G>=0, then use the upper G only after checking that scalar coefficient is nonnegative. This avoids an unjustified product inequality when an intermediate actual coefficient is negative. The terminal factor is nonnegative because cL(r2-1)<=Dx. Those are the same signs used in `NumericsCore.cell_bound:274–389`.

The exact lower Y values for cells0–8 are `[1e25,3e25,1e26,1e27,1e28,1e30,1e34,1e42,1e58]`. Their closed x ranges cover from4.9e26 to4.9e101, with joins at1.47e27,4.9e27,4.9e28,4.9e29,4.9e31,4.9e35,4.9e43 and4.9e59 (`NumericsFinal:12–33`). The asymptotic branch begins at4.9e101 and legitimately reuses the smaller Y=1e58 base envelope. Its old chain/tail estimates remain unchanged. `ghatY_le_num:54–128` gives the exact scalar upper recipe; `ghatY_mono_y:130–139` extends each lower-Y estimate through its cell. This supplies continuum coverage when combined with the corrected cell data, rather than merely sampled endpoint estimates.

Finally the prime-power split is unchanged: multiply the new main minor expression by1.0005 and add2001*22.75*8e-11. The all-alpha22.75 bound is source-independent of the cutoff (`MinorTotal:49–65`). No error is absorbed by an unsupported cancellation.

## Threshold, final roots and remaining implementation

I read the accepted lower-threshold report and review and rechecked the scaling algebra. From pi>3.14 one has sqrt(2pi)>5/2, hence `0<c0=2+9/(196sqrt(2pi))<989/490`. Since `(989/490)*4.9e26=989*10^24`, all N>=N0 give x=N/c0>4.9e26 and y>1e25. This uses a sharper denominator bound than2.02 and does not move the analytic x floor. The already reviewed `(6.9)^32<N0` and `(2.64)^64<N0` preserve the original nonprime argument and its strict .0114 normalized bound.

Once the localized mathematical inputs and the new arc decomposition are actually proved, the unchanged1.049/1.0376 conclusions give the same strict positive prime count. The large result at N0 requires no binary premise. The full Statement still requires the original inclusive BinaryGoldbachInput through4e18 and the checked ladder prefix. The published large result from1e27 remains a restriction of the stronger threshold. No QRH7/8 provider or blanket finite-RH hypothesis is part of this proposed reduced chain.

This review does not certify an existing Lean refactor. Required work still includes parameterized arc identities/disjointness, local character/RH supplier interfaces, the new J/I/singular/base-gap estimates, the changed numerical goal, and rethreading every old Platt-bearing prime wrapper through principal-only inputs. Nor does the10,000 reduction in eligible conductor indices measure primitive-character, zero-count or runtime savings.

## Source binding

All 27 source/report/script/receipt table pins in version 2 were verified. Its scalar script is pinned at `69B5CB77F324040E534DAD50B76E489F24F51AB2B79DA34AE09477E72F711C99` and its JSON at `7E3136E7DCE05A89022B12EEE7CE9A3B94B0AF1E83B3FF413319E4701300FC50`.

A separate read-only rational calculation, without importing the author's script, checked all nine source-section hashes and scales, parsed chain dot products and tail products, all 36 finite-cell compositions and four asymptotic compositions, positive multiplier signs, the major and base-gap compositions, and the N0/nonprime inequalities. At R=140000 it confirms I_R/x>8.56077, major>1.0492 and every minor cell<1.031819. Corrected cell 1 has G<=.0616144 and minor<=1.0100535; cell 0 still controls. This calculation used recorded rational envelope values: it did not independently regenerate logarithm/root enclosures or evaluate analytic functions. Those enclosure recipes were inspected against the source scalar theorem; this is not a claim of a second executed elementary evaluator.

Besides the author's pinned source files, this review directly inspected these source interfaces under `work/ternary-goldbach/TernaryGoldbach`:

| Path | SHA256 |
|---|---|
| `Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `Explicit/IEANTNBridge.lean` | `54E839497E66C7444A7B03BA5C62096E7C526BF2999EF5888CC5BB17481D72FE` |
| `MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `MinorArcs/EtaStarBound.lean` | `FC66FFD3C2D83CDD0CA1D9C00A62FD5709E8B62179AB9D1943645EF292B8AB99` |
| `MinorArcs/LinftyLevels.lean` | `12605A6C6B8E97BA5ABADEC4F761E322F8C04E8D4C6557AC5BE1084194EA6409` |
| `MinorArcs/PartIICited.lean` | `0447F5A3D00DBB6B11CEA1A729FA4CCA2FEF993A8242574D2241A33195B14D30` |
