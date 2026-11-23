# Original finite-RH cutoff: bounded refinement to R=138000

2026-11-11. Supplement to the independently reviewed original-RH modest-cutoff V2 report. Source/paper and exact rational arithmetic only; no function, prime or zero evaluations, Lean builds, source changes or changes to frozen packets.

## Result

**R=138000 is the smallest demonstrated cutoff in the prescribed bounded search.** It preserves the original major constant1.049, minor constant1.0376 and the already reviewed analytic threshold N0=989*10^24. The search tested 140000,139000,138000,137000 on the coarse1000 grid, stopping at the first failure, then tested137900 on a single100-step refinement and stopped at its failure. No finer search was made. This is not a global minimum or a proof that all smaller cutoffs fail.

The complete accepted V2 envelope is unchanged: actual original finite-RH heights, original sig(x) total energy, recomputed J_R and prime-supported I_R, original major per-modulus error, new base-gap bound, nine finite cells and the asymptotic branch. In particular no QRH .555/7/8 premise, .65 energy branch or1.0404 major estimate enters.

## Exact comparisons and stopping rule

The new script copies the corrected V2 parser and scalar formulas. Each source cell is bounded at the next theorem, exactly one full scientific Y literal is required, and the vector of parsed values must be

    [1e25,3e25,1e26,1e27,1e28,1e30,1e34,1e42,1e58].

The receipt includes these values, source section hashes and the full NumericsCells source hash. It records all exact rational intermediate values, not just rounded displays. The passing predicate requires all of:

* original major lower bound >1.049;
* each of the nine minor upper bounds and the asymptotic minor upper bound <1.0376;
* base-gap bound <.014, with the inherited uniform ghat lower bound >.03;
* positive mass, J_R, I_R and singular-series lower bounds;
* positive numerical upper factors cL(150000)*sD-j_R in every finite cell and in the asymptotic branch.

All cutoffs are even and in[100000,150000]. For every constructed ghat bound the script checks Y>=1e25, R>=670, 6R<=floor(cuberoot(Y)), and positive logarithmic denominators. The original source large-sieve guard R>=100000 is therefore retained. The N0 scale comparisons are repeated exactly; no cell domain changes.

| R | all guards pass? | controlling minor upper bound | first failed requirement |
|---:|:---:|---:|---|
|140000|yes|1.0318185|none|
|139000|yes|1.0346785|none|
|138000|yes|1.0375704|none|
|137000|no|1.0404968|minor target1.0376|
|137900|no|1.0378625|minor target1.0376|

These minor displays round upward; cell0 controls every tested row. The failure at137900 or137000 means this particular sufficient rational upper envelope does not prove the unchanged minor constant. It is not a lower bound on the actual minor integral. In fact the separate major-minus-minor-minus-.00271 diagnostic remains positive there; that is not the criterion of this task and is not used to change any final constant.

At R138000 the exact reserve below the minor target is

    1.0376 - max(all ten minor upper bounds)
      = 118403703823830928586557 / 4000040000000000000000000000
      > .0000296.

The exact reserve above the major target is

    major_lower -1.049
      = 1107777376393857101 / 4290937500000000000000
      > .000258.

Further safe displays are I_R/x>8.53683, major_lower>1.049258, basegap<.013036, asymptotic_minor<.766953. The finite cell upper vector at R138000 is

    [1.0375704,1.0157760,.9955832,.9603746,.9343028,
     .8991721,.8462128,.8011274,.7752987].

All quantities are in the same normalizations as V2. In particular the minor numbers already include the factor1.0005 and the term2001*22.75*8e-11; those are not omitted reserves to be charged later.

## Source and spectral interfaces preserved

V2's paper derivations apply throughout this tested range. The q-tilde arc cutoff is q-tilde<=2R; retained primitive conductors are odd c<=R and 4|c<=2R. Their heights remain respectively1e8/c and max(1e8/c,200+7.5e7/c). The inverse-character and conductor-one conventions are unchanged. At R138000 all q<=276000 remain below the old300000 scalar domain, every arc width satisfies wx>=4 and 2w<=1200000/x, and every character twist remains within the original Thm714/Cor713 domains. The proof must retain q-tilde in the base-gap witness to establish the odd-conductor cutoff, as in V2.

The mass loss uses the same proven bound C*log(150000/R), C=15015/5760; the singular lower bound uses the same22.1/R tail. The short added minor chain R<n<=150000 is bounded directly by ghat(y,R), with its logarithms telescoping into cL(150000). This does not use pointwise major estimates at any omitted conductor. All higher minor-level bounds and their principal-only spectral inputs are retained.

The accepted N0 argument gives x=N/c0>4.9e26 and y=x/49>1e25 including N=N0. Thus the same first cell and every original square-root error bound apply. Because the original final constants1.049 and1.0376 survive, the already reviewed original nonprime/crude-positivity argument applies without modification. No new large-N threshold, finite gap, or uniform-prime-gap height is introduced.

Implementation remains conditional on V2's listed source refactors: local finite-RH assumptions, parameterized arcs, recomputed J_R/I_R and the revised numerical goal. The frozen existing theorems with broad PlattGRH hypotheses do not themselves prove a smaller dependency set.

## Work reduction and limits

Relative to the already restricted R150000 original-RH family, the eligible nonprincipal conductor indices drop from149999 to137999: odd c in(138000,150000] and multiples of4 in(276000,300000] are omitted. This is12000 integer indices, not12000 characters. Compared with the accepted R140000 candidate it removes a further2000 indices. An actual primitive-character and height inventory is required to price the spectral saving; this report claims no runtime or bit-complexity reduction.

N0, binary B, the explicit prime-chain coverage target, and retained principal heights are unchanged. Hence this refinement adds no finite-range ladder work. No further cutoff search is proposed here.

## Frozen pins

All paths are workspace-relative. The V2 report contains the23 source pins and the N0 report/review pins; this supplement uses those same source bodies. The new receipt also directly binds NumericsCells.

| Artifact | SHA256 |
|---|---|
|`work/qrh-campaign/agents/major-constants/EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_V2_2026-11-11.md`|`33A3D9645BD9A8F856DD13A40028FF314A2769E8938FA90050A194C048C84517`|
|`work/qrh-campaign/agents/integration/REVIEW_EFFICIENCY_ORIGINAL_RH_MODEST_CUTOFF_2026-11-11.md`|`3DDA3A1073AD671AA418816D96966D07B0AA0B08D686C67E701B2B81302DC3A2`|
|`work/qrh-campaign/agents/major-constants/original_rh_cutoff_frontier_20261111.py`|`7CBAD3B4F0FF7CCA678EE364860F243EE9FB4F548F6517CF5E67A6F325FE7001`|
|`work/qrh-campaign/agents/major-constants/original_rh_cutoff_frontier_20261111.json`|`A573B8409CEFBE8E21614FB305B1C57A9D71B16FD8DDA94ABA132C9ACB41CB7C`|
