# Review of the plus residual to major L2 upper join

2026-11-11. Independent paper/source review. Verdict: PASS, with no requested correction. This accepts the conditional implication, not the proposed nonprincipal residual estimate or a new Lean proof. Only source/report reads, file hashes and written rational arithmetic were used. No evaluator, scalar script, Lean build or spectral computation was run.

## Frozen inputs

Paths below are relative to the workspace.

| Artifact | SHA256 |
| --- | --- |
| `work/qrh-blueprint/PLUS_RESIDUAL_TO_MAJOR_L2_UPPER_2026-11-11.md` | `F3EBC1B68CC57B607496D9E6445137A08A0F17C3202D986301F8EC25F14F4663` |
| `work/qrh-blueprint/plus_residual_l2_upper_scalars_20261111.json` | `40EBC027159B10C3ACA116644E8D823FEE1835557A1190EF34B20FCF9C069B28` |
| `work/qrh-blueprint/INTEGRATED_CUBIC_RESIDUAL_CONTRACT_2026-11-11.md` | `943DE38EE628CFA9E7221100E75933D101C7593B613945F19B7CBDF90E97C128` |

The precursor direct target is `major-constants/DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md`, hash `E69701B4AE8145B016015A2C355151DFAA5D4946D2281BAE3CC08A86422196B1`. Its completed independent review is `prime-estimates/REVIEW_DIRECT_PLUS_RESIDUAL_ENERGY_TARGET_2026-11-11.md`, hash `89DEB7CACE2D0AC4030C349D5E8E715C0B8DFFC69A7D33383D701DAB836F6B12`, both under `work/qrh-campaign/agents`.

## Reciprocal sum and arc measure

For natural R at least 1, the actual definitions of Qset and qt give a disjoint union of odd q with 1 <= q <= R and even q = 2k with 1 <= k <= R. The even reindexing is injective. Therefore

    sum_(q in Qset R) 1/qt(q)
      = (sum_(odd q <= R) 1/q + H_R)/2 <= H_R.

This uses every even modulus, including nonsquarefree ones. It does not silently replace the reciprocal sum by the Mobius-weighted mass sum. The q = 1 and q = 2 terms are both present, each contributing 1/2. All denominators are positive.

For R <= 150000 < 2^18, enlarge H_R to 1 plus the eighteen full blocks 2^j < n <= 2^(j+1), j = 0,...,17. Each block has 2^j entries of size at most 2^(-j). Thus H_R <= 19. The bound is deliberately coarse and covers every stated endpoint.

At x > 0, the q interval has length 16R/(qt(q)x). The assumed residual bound is already the sum over b in Bset q. Integrating this bound and then summing over q gives

    Z <= 16 R rho^2 x sum_(q in Qset R) 1/qt(q).

There is no additional cardinality or totient factor. Finite sums and integrals commute here; the actual S and Fourier main term are continuous on these compact intervals, so their squared norms are integrable. Open, closed and half-open endpoints differ only by null sets.

For rho = 177/200000000, the coefficient at R = 150000 is

    16*150000*19*rho^2 = 1785753/50000000000.

Its gap below (6/1000)^2 is 14247/50000000000 > 0. This matches the saved JSON exactly.

## Main-term normalization and conditional conclusion

The actual main term is Ap = (mu(q)/phi(q))*Fourier(etaPC)(-beta*x)*x, independent of b. Since q >= 1, phi(q) > 0, and the cardinality of Bset q is phi(q), its squared coefficient after summing over b is mu(q)^2/phi(q) = mPhi(q). This is the place where the residue cardinality is used; it does not reappear in Z.

`L2Major.integral_main_term` transforms the beta integral to x times a truncated Fourier squared-norm integral. `EtaPlusL2.integrable_norm_sq_fourier`, `integral_norm_sq_fourier_etaPC` and `integral_sq_etaPlus_bounds` give the unconditional upper coefficient .640208. These declarations have no Platt premise. Although the corresponding local calculation in `MajorTotal` occurs inside a larger conditional theorem, its displayed Fourier argument uses just these unconditional inputs. No call to the old nonprincipal-dependent `L2Major` upper theorem is required.

Qset R is contained in Qset 150000 for the natural R under consideration. Nonnegativity of mPhi and `SumMuPhi.sum_Qset_mPhi_bounds` give its upper mass 13.59756. No reduced-radius lower mass is used. Consequently

    Y <= a*x,
    a = .640208*13.59756 = 13601979207/1562500000
      = 8.70526669248 < 8.708401 = 2.951^2.

On the tagged finite arc space, S = Ap + (S-Ap). The L2 triangle inequality gives sqrt(X) <= sqrt(Y) + sqrt(Z). Both functions belong to L2 by the preceding compact-interval continuity. Since x > 0,

    X < (2.951+.006)^2*x = 8.743849*x < 8.79*x.

The last gap is .046151*x > 0. The saved JSON's upper coefficient 8743849/1000000 is correct. No independence or cancellation of the main term and residual is assumed.

For an upper bound on physical major-arc energy, `LargeSieveArcs.integral_majorArcs_le` and the translated-arc identity already give physical energy <= tagged X. Equality or disjointness is unnecessary in this direction. Their continuity, periodicity, nonnegativity and width hypotheses must still be instantiated. The declared x >= 4.9e26, R = 132900 and delta0 = 8 satisfy the width conditions with ample room. Exact partition/reduced-radius adapters remain relevant to stronger identities and other consumers, so the author's caution is safe.

## Scope retained

The geometry proof works for natural 1 <= R <= 150000 when its full pointwise residual premise is provided. The selected direct-energy proposal supplies that premise only at R = 132900 and every real x >= 4.9e26, on the entire required beta interval. Nothing in this review extends actual residual control to larger R or substitutes a finite sample check for the continuum premise.

The proposed E_q <= 7.02e-13 remains unproved. Its retained principal estimate and coprime-removal step are needed to obtain the actual residual bound. Once that bound is assumed, the integrated argument adds no nonprincipal RH input. Principal RH through 1e8 remains in the upstream proposal. The lower-J argument, star estimates, integrated cubic mixed moments, base-gap bounds, finite certificates and kernel validation are separate obligations. This new conditional upper join legitimately supersedes only the former statement that this particular upper-J join was absent.

## Source pins

All paths in this table start at `work/ternary-goldbach/TernaryGoldbach/`. These are source inspections, not fresh elaboration or transitive axiom checks.

| File and checked interfaces | SHA256 |
| --- | --- |
| `MinorArcs/LargeSieveWeights.lean`, qt definition | `4577368FF4AD237E00D04259B813AFE2755ED165766070711CA33FB75E6F2304` |
| `MinorArcs/LargeSieveArcs.lean`, wrad/Qset/Bset and integral_majorArcs_le | `0794C8853D9B1AA91EFEC3C9D91F5F1EFCECB98B484C701C360DD8EF5AC592BF` |
| `MajorArcs/L2Major.lean:49-95`, translated arc, main integral and continuity | `8C9424D92074ABB35DF00273D598F5A3F95C49A34F07F4146DD83FD2B6F3A5FC` |
| `MajorArcs/EtaPlusL2.lean:115-156`, etaPlus and Fourier L2 bounds | `0E86FF780F7F4A817F3093787D24D0C5DC10290B56B8555C7EA62362E049D949` |
| `MajorArcs/SumMuPhi.lean:20-112`, mPhi, Mobius square, parity pairing and upper mass | `7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4` |
| `MajorArcs/MajorTotal.lean:890-911`, local Fourier main-term estimate | `106293987C887D3586DC3483260B135853730F3A20466D0D7E71ABC61AB9F84A` |

