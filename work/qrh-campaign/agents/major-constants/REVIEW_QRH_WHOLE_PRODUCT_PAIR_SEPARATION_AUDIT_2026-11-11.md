# Independent review of whole-product pair separation

Verdict: PASS for the bounded consumer join, with no correction requested. This review binds `independent-feasibility/QRH_WHOLE_PRODUCT_PAIR_SEPARATION_AUDIT_2026-11-11.md`, SHA256 `12DB7738EB0BA0DA10E64424785C6C6B62277976CC05FECC21F9CF2E86C93A6E`. Its four source pins match the files inspected. Source baseline is `work/openai-math` at `4eaee87548250b2682affda7d05d947c05554bae`. No Lean build, source edit or analytic evaluation was performed.

The radial input is reused from the accepted author audit `EE7C7B00310ED151CAD460CE31D36A725E128681201B5959D607691DD8FD1D3D` and my independent review `7D1C5EB031F3F26F0952786F85F367CCA1BA138F69747F11D0CB28ABF526CEAD`; both hashes were checked again. Their lower analytic and library-version limitations remain. This report adds a check of the actual consumer bodies, not a second claim to have established the radial estimate.

## Exact kernel and phase check

I read `Moments/Smooth.lean:13–135` in full and compared its call with `QuadraticSieve/IdealQuotients.lean:305–436`. The root window is exactly V(u)/sqrt(exp(u)), and the whole radial argument is R exp(rho+x-u-v). The envelope receives four windows V0,V1,rootWindow(V2),rootWindow(V3), with slopes 1,1,-1,-1.

The support implication is sufficient and correctly proved: a nonzero root window forces its numerator V to be nonzero. There is no division by V, and the real denominator sqrt(exp(u)) is positive for every real u. Its magnitude is retained in both sides of the identity; it is not absorbed into the density's bound.

The definition at `Mellin/LogProfiles.lean:1188–1189` is exp(2*pi*i*t*y). Thus the separated product has phase exp(2*pi*i*t*(rho+x-u-v)). The two finite coefficient factors are c_i and conjugate(d_j). The right-hand column expression is literally the sum of conjugate(d_j) times the negative-v phase. It is not the conjugate of the same-phase column sum. This distinction prevents a sign reversal of the second column.

## One density and both bounds

For fixed W,V,M,A,J, the conclusion chooses C>=0, then for every R>0 chooses a Schwartz density b. Only after that choice does it quantify all finite index types, sets, coefficients, coordinate lists and row positions. The consumer preserves that order exactly. It also preserves, without rescaling, the weighted integrability, weighted integral bound and weighted pointwise bound from the radial envelope.

The inherited construction uses T=sum M_i, a logarithmic cutoff supported in a slightly larger box, and the lower bound exp(-(T+1)) on its active scale. These constants are independent of row and column coordinates because outside the permitted support the relevant window product is zero. No regularity or size bound on the arbitrary windows V_i is required by this consumer: at a fixed row/column tuple they are constant complex factors in the Fourier integration variable.

The statement does not choose one b for different R, assert a measurable selection in R, or provide uniformity over arbitrary changing W,M,A,J. In particular, later integration over R would require a further argument. The positive-scale condition R>0 remains essential. The stronger shared-box result in the earlier radial packet is available only where separately invoked.

## Finite exchange is justified, including degenerate cases

`Smooth.separated_integrable:61–76` proves genuine integrability before exchanging sums and the integral. For each fixed scalar c and tuple rho,x,u,v, the integrand norm equals

\[
|c|\,|V_0(\rho)|\,|V_1(x)|\,
|\operatorname{rootWindow}(V_2,u)|\,
|\operatorname{rootWindow}(V_3,v)|\,|b(t)|.
\]

Every phase has norm one (`GaussSum/LocalProductAssembly.lean:182–188`), and continuity in t follows from those phases and b. The fixed window values need not form measurable functions of their own arguments for this claim. Schwartz integrability of b supplies the majorant.

`finite_pair_separation:78–115` applies the pointwise identity, moves constant coefficients inside, and interchanges two finite sums using that integrability lemma. Factoring the resulting finite sum is exact complex algebra. It introduces no cardinality loss and requires no summability in the index types. Empty sets, zero coefficients and zero windows give the corresponding zero identity. The theorem does not rely on a totalized nonintegrable integral.

`whole_product_pair_separation:117–135` packages this finite identity with the same density and all three analytic properties. I found no missing bound, changed normalization or strengthened quantifier in this packaging.

## Boundary of this verdict

The source spans complete this finite consumer join relative to the accepted radial envelope. They do not prove any later Cauchy–Schwarz estimate or live-allocation bound. I read the statements and immediate bodies of `Moments/FirstCommonSourceBudget.lean:28–105` and `FirstCommonSourcePowerBudget.lean:17–47` to check the author report's next-boundary description only. The gain involving norm(C)^(epsilon-1) requires the separate allocation/control-mass mechanism and child-energy hypotheses; it does not follow from Fourier separation. That production is reserved for its own audit.

No full QRH provider validation or successful elaboration is claimed.

## Source pins

Paths are relative to `lean/OAI/NumberTheory/DirichletL/`. Hashes identify full files; the inspected scope is specified above.

| File | SHA256 |
|---|---|
| Moments/Smooth.lean | `2C1337F3B8F06D4221F45A81973D9793A59CE876CDDD36A9A443D08C115ED556` |
| QuadraticSieve/IdealQuotients.lean | `3961EF95BA392A9352CADD3A9EC9C3336081BDC468B89A14FB099D00FD64D499` |
| Mellin/LogProfiles.lean | `0F808D2AD89AF54F26A3308078B12920B0A4E93C3B206727A22B26CC80AAE4E1` |
| GaussSum/LocalProductAssembly.lean | `ADB01A606D71EE0E178FA4BD5D8F6CC9709035065EC089472155BCDB323156EC` |
| Moments/FirstCommonSourceBudget.lean | `C409066589A7187C223E1A60088B1E8BC4E6F0A8FFC444FD94DF45DF393E3A4C` |
| Moments/FirstCommonSourcePowerBudget.lean | `F369306E785677A776C3BAF09EAE64B6D834141E294F504F690FE1054DC346D1` |
