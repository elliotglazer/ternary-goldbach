# Remaining Hurwitz seed and contraction work at R138000

2026-11-11. Bounded paper and exact scalar/metadata analysis. No roots, Hurwitz values, L-values, FFTs, zeros or primes were evaluated; no builds were run. Older files are unchanged. The R138000 family and the nominal coarse grid are held fixed conditionally; this report does not adopt the analytic cutoff or produce spectral evidence.

**A valid contraction reduction is available:** double each existing alpha-grid denominator and use20 Taylor coefficients instead of24. The character-summed alpha remainder then remains below the old2^-82 allocation, in fact below2^-84. On this nominal family it removes415473756569784 real-times-complex Horner products and the same number of complex additions. It increases shared seed slots from17223585528 to28703416100. Whether the complete checked computation improves depends on the seed producer's cost; slot counts alone cannot settle that question.

## 1. The remaining work is substantial

The inspected frozen Hurwitz plan shares a lattice at each exact coarse height across all conductors, then evaluates the alpha polynomial at each reduced fraction a/c before a unit-group transform. Its actual function identity is

    zeta(s,alpha)=alpha^(-s)+zeta(s,1+alpha),
    L(s,chi)=c^(-s) sum_(a unit mod c) chi(a) zeta(s,a/c),
    C_k(s,alpha0)=(-1)^k (s)_k zeta(s+k,1+alpha0)/k!.

Here s=1/2+it and alpha0 is a nearest mesh point in[0,1]. These are continued-function identities, first proved where the series converges absolutely. One must not obtain them by manipulating a conditionally convergent critical-line series. This is the shared Hurwitz-lattice/character-transform architecture described by Platt; the new degree/grid choice below is our sufficient bound, not a claim about his implementation. [Primary algorithm, sections4–7](https://arxiv.org/pdf/1305.3087).

For c>10000 the R138000 inventory has N_res=103868439142446 residue-height inputs and127989 shared heights. P24 therefore has2492842539418704 coefficient contributions. Literal Horner evaluation uses23N_res=2388974100276258 real-times-complex multiplications and as many complex additions, before short-head/scaling costs. Multiplication by an exact real displacement uses two real products; it must not be priced as an arbitrary complex product without explanation.

The mixed-radix character circuit still uses2736537742659260 general complex products and5668480164659994 complex additions. These transform costs did not reduce the alpha contractions or seed generation. Both are leading arithmetic categories. Which dominates wall time, proof generation or checking cannot be deduced without operation widths and the seed implementation.

The small-conductor theta/time branch, elementary head values, conductor/root phases, ordinary interpolation, exceptional repairs, and Turing completeness are separate. None is removed by changing alpha degree.

## 2. One complete alpha-tail substitution

Retain M=1 and the same five height bands, but use the following grid and length:

| Upper | Old D | New D' | Old P | New P |
|---:|---:|---:|---:|---:|
|500|512|1024|24|20|
|1000|1024|2048|24|20|
|2000|2048|4096|24|20|
|5000|4096|8192|24|20|
|10000|8192|16384|24|20|

Choose alpha0=j/D' by exact nearest-grid integer arithmetic; d=alpha-alpha0 satisfies |d|<=1/(2D'). Ties may select either endpoint. The real segment between alpha and alpha0 remains in[0,1]. For P>=2, its actual P-th derivative is absolutely bounded by

    |(s)_P| [1+1/(P-1/2)] < 2(V+P)^P.

This follows from the first term plus decreasing integral for the Hurwitz series at real part P+1/2, and |s+j|<=V+j+1. Real Taylor's integral remainder therefore gives

    |R_P| < 2/P! * [(V+P)/(2D')]^P.                         (1)

Multiplication by c^-s and summation over unit residues amplify by at most v/sqrt(c)<=sqrt(c)<633. The retained constant633 is valid even on the larger old c<=400000 domain. In each new row (V+20)/(2D')<5/16, so

    E_alpha < 1266(5/16)^20/20!
            =32196044921875/784319481140539136558604399419068514304
            <2^-84 <2^-82.                                 (2)

The companion checks each row and the final rational inequality exactly. No assertion about unknown seed centers is needed for (1) or (2). The bound covers both signs of t. It applies to the point grid only; a complex s-panel extension would need its own domain and remainder check. It supplies no nonvanishing or sign margin.

## 3. Seed reuse and finite arithmetic

The new mesh contains every old anchor as an even-indexed anchor. At those anchors the first20 coefficients are exactly the old first20 coefficients. Existing certified balls for them may be reused if their precision is sufficient. New odd-indexed anchors need new certified seeds; old orders20..23 are unnecessary for this contraction. This is literal equality of the actual coefficients, not interpolation between old seed values.

The shared prefactor R_k=(-1)^k(s)_k/k! can also be computed once per height, using R_0=1 and R_(k+1)=-R_k(s+k)/(k+1), then multiplied into the separate Hurwitz seed values. Its rounding and enclosure errors remain charged. There is no reason to reconstruct this same prefactor independently at every anchor, but this observation does not supply the Hurwitz values themselves.

Let eta_k bound a seed-coefficient error and suppose d is exact. With complex absolute rounding error at most u for each real-times-complex multiplication and each addition, Horner's propagated radius is bounded by

    sum_(k=0)^19 |d|^k eta_k + 2u sum_(k=0)^18 |d|^k.       (3)

The last coefficient is imported directly and is not given an extra multiplication. Since D'>=1024, |d|<=1/2048. If eta_k<=eta, a sufficient character-summed seed/arithmetic allocation is

    E_seed+E_Horner <1266 eta+2532 u.                        (4)

This is separate from (2), the finite head, conductor scaling and the group-transform error. The exact input normalization and positive DFT conventions do not change. In particular, no extra1/v may be dropped and no full error budget may be identified with alpha truncation alone.

The rational d usually is not dyadic. If it is replaced by a dyadic d_hat of error xi, set a*=|d|+xi and additionally charge

    xi sum_(k=1)^19 k M_k (a*)^(k-1),                       (5)

where M_k bounds the relevant coefficient magnitude, and propagate (3) using a*. This is the polynomial derivative bound along the joining segment. Certified coefficient balls supply M_k, including their uncertainty if the stored polynomial is used. Alternatively, implement exact rational multiplication with its actual denominator cost. Calling the displacement “fixed” does not justify ignoring (5).

Equations(3)–(5) give a conditional precision choice for any positive allocation left after the analytic tail. They do not guarantee that the present fixed tail meets arbitrarily small requests: if an output requires less than this tail, increase the degree/grid or use a separately certified repair. No current global precision or repair frequency is assumed.

## 4. Exact cost tradeoff

| Nominal large-branch category | P24/old mesh | P20/double mesh |
|---|---:|---:|
|Coefficient-contribution slots|2492842539418704|2077368782848920|
|Horner real-times-complex products|2388974100276258|1973500343706474|
|Horner complex additions|2388974100276258|1973500343706474|
|Shared seed slots|17223585528|28703416100|
|Maximum seeds at one height|196632|327700|
|Shared coarse heights|127989|127989|

The saved415473756569784 Horner stages contain830947513139568 real-coordinate products before any backend-specific optimization. The new seed count is about5/3 of the old, not twice, because the degree falls. Both are aggregate slots, not simultaneous RAM or arithmetic generation counts.

For one old denominator D and one height,20(D+1) old-anchor coefficients survive,20D new-anchor coefficients are added, and4(D+1) old high-order coefficients are omitted. The net increase is16D-4. Across all heights the increase is11479830572 seed slots. Reusing already generated old P24 data as a sunk artifact has a different incremental cost: it can reuse the retained balls but cannot recover their old construction cost.

Let C_seed,24 and C_seed,20 be the actual complete checked seed costs, including all elementary leaves, remainders, prefactors, precision and serialization. Let c_stage price a Horner real-times-complex multiplication plus its complex addition at the relevant widths. The substitution improves this part of the checker if

    C_seed,20-C_seed,24 <415473756569784*c_stage.             (6)

As a sensitivity model only, if every seed slot had the same cost c_seed in both designs, the crossover would be

    c_seed/c_stage <103868439142446/2869957643.

No such uniform seed cost is established. Different orders, heights and magnitudes can have different costs, and sharing a seed jet can change the entire model. This is why the concrete saved contraction count is not a claimed end-to-end speedup.

The larger mesh also has new nearest-anchor indices and fixed rational displacements. Cache this metadata by conductor/residue/height band, not per height within a band, with exact indexing proofs. This avoids repeated divisions but does not remove the runtime coefficient products or permit discarding residues. Across different conductors the fractions a/c with unit a are reduced fractions with different denominators, so they are not identical alpha arguments; direct cross-conductor reuse of whole residue values cannot be assumed merely from similar alpha positions.

## 5. The next consequential missing component

This substitution is valid at the analytic-tail interface and exposes a concrete tradeoff. It does not close the expensive missing producer: actual shared Hurwitz seeds with complete correction, precision and proof costs. The previous plan leaves C_lat(t,D,P,p) symbolic. A proposal that prices only the number of seed slots, or treats every seed as a fixed-cost special-function oracle, would miss that obligation.

The useful next decision is a bounded comparison of complete seed-generation circuits or a paper bound for their reused jets, followed by (6). There is no need to repeat a family scan or to re-evaluate character transforms for this decision. Existing mixed-radix precision/peak bounds concern a later stage and cannot bound these seed magnitudes or truncation errors by themselves.

## Pins and checks

The inspected source interface is `REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md`, SHA256 `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC`, with independent review `E2C984CC219E5EA3B3AC1C41623A14B7EF0C3517313BE1BE3FE641318342179F`. Its seed-band receipt is `6F661E61A212D3F65C24625E6A211DCC0494853BDD3D875162E8521E306F296F`.

The fixed conditional family is `CONDITIONAL_R138000_SPECTRAL_INVENTORY_2026-11-11.md`, SHA256 `C14E47FBD3EFBC67C541076B99CCF2949FA2BEDFA9217EFD3C87B9AA8617E78B`; its receipt is `0D48AF7655976B5B0A0BC2750CA92F26E30B33E1F45540015627EEFFC5C60D5F`.

New script `r138000_p20_alpha_tradeoff_20261111.py` SHA256 `9EF1BC728B42B9E11E109AEAB6D742BFCD413F0E78FA6C06BD2E377AE40EB891`; new receipt `r138000_p20_alpha_tradeoff_20261111.json` SHA256 `F7D5E9CC9AE271B5DA2FC60A33CE8DFC23C9EED5F05999B442C20182573A8323`. These read only hash-pinned metadata, check five rational remainder ratios and exact factorial inequalities, and count slots. PASS does not mean seed values, signs, spectral completeness or runtime have been checked.
