# Independent review: principal RH height and the lower-height Weil window

Date: 2026-11-11. Verdict: **PASS within the stated source/paper scope; no mathematical correction requested.** No smaller complete principal RH target, Lean implementation, numerical zero certificate, or end-to-end cost improvement is established.

## Frozen inputs and work performed

The reviewed author packet is:

| File under `work/qrh-campaign/agents/integration/` | SHA-256 |
|---|---|
| `PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `207EEAF68F7FB51351B4C37E991A09664F1B7852CCE29D82C75B2D4B8B776D63` |
| `principal_height_consumer_metadata_20261111.py` | `5F44A6C1CB303450235C94DBA1B3419424C2A508249C07B3613CEB994F7B5BE7` |
| `principal_height_consumer_metadata_20261111.json` | `DE7F46C08544A2EDE1548935591E12159EC785C995E1B8F79276A8286484642F` |

I read the note and scalar program, independently reconstructed its rational expressions without importing or executing that program, and checked all 32 source hashes in the receipt against disk. The independent calculation reproduced both threshold fractions, the off-line coefficient and its positive margin, and the polynomial coefficients. It also checked the other scalar comparisons represented by the author's nine checks. Author files were unchanged.

The main independently read proof bodies were `Explicit/WeilWindow.lean`, `PsiPlateau1e8.lean`, `PsiLarge.psi_upper_of_err`, the relevant `ZeroSumGen` counting definitions/proof, and the actual `RHBelow` definition. I checked the cited downstream height-sensitive interfaces and uses in `PsiRange`, `PsiRange1`, `PsiAsymp`, `ThetaExplicit`, and the major-arc propositions. The 32-file hash check is not a claim to have independently reconstructed every proof in those files. The additional scalar source `Explicit/PsiPlateau.lean` has SHA-256 `9138464FF2638DEEB39EAA58E7FB39F0CFD68895CE599CCB189EF3F6EE8F8D4D`.

## 1. The plateau restriction is a restriction on a sufficient proof expression

`Explicit/ZetaZeroSums.lean:23–33` defines the principal input using actual zeta zeros, both signs, and the closed condition `abs(im rho) <= H`. Its `rh_upto_1e8` obtains this predicate from `Fact PlattGRH`. Counts, simplicity and reciprocal moments are not consequences encoded by this predicate.

`PsiPlateau1e8.psi_plateau8:120ff` fixes K=7, delta=7/1e8 and y0=1e10. `PsiLarge.psi_upper_of_err:296ff` really retains

    exp(delta^2/2 + K*delta)/(1 - 2*exp(-K^2/2))

as the coefficient of x before adding its nonnegative error estimate and low-end correction. The denominator is strictly between zero and one for K=7. For the proposed retuning delta=7/H, H>0, the excess above one is strictly greater than 49/H: use exp(t)>=1+t with t=49/H+49/(2H^2)>49/H, then division by the smaller positive denominator. No bound on the actual sign of psi(x)-x was used.

Therefore domination of this sufficient expression by the retained all-x plateau allowance forces

    H > 49,000,000,000/491,
    99,796,334 < 49,000,000,000/491 < 99,796,335.

The all-x qualification matters. Fixed sqrt(x) and constant terms cannot absorb a larger coefficient of x over an unbounded domain. Conversely this calculation is neither a lower bound for actual psi error nor a proof that every possible argument needs this height. It does not cover a fixed delta with falling H, a different K, a different smoothing, or a cancellation-aware replacement argument. The author explicitly makes these distinctions. Even passing this necessary inequality does not pay the other positive errors.

The comparison with 4.92e-7 is likewise exact and weaker: its threshold is 49,000,000,000/492, between 99,593,495 and 99,593,496. The old finite-range window support condition Y1+13<=H/2, with Y1=49,000,000, gives H>=98,000,026. Neither comparison supplies a replacement finite-range certificate.

## 2. The lower-height off-line adapter is complete at this proof level

`WeilWindow.off_line_leH:99–234` treats an arbitrary finite `rectZerosXi T` with T>=1. Its tail is strictly above H; no RH assumption occurs in this tail lemma. The proof transports actual multiplicities to `zerosRectD zetaF T`, bins using floor((abs(gamma)-H)/4.4), and applies `ZeroSumGen.count_tail_windowG:121ff`. This counting lemma assumes only the full open real strip 0<beta<1, not beta=1/2. Thus lowering H does not accidentally apply a critical-line counting lemma to unknown tail zeros.

The pointwise estimate still has factor

    E = 4^m exp(m ell) * 64,
    f(k) = 1/(H+4.4k)^2.

The proof uses abs(T0)<=H/2 to obtain abs(gamma-T0)>=abs(gamma)/2. The premises 0<ell<=1, integer m>=2 and positive H suffice for this part; its old 1e8 lower bound was not used geometrically.

`ZeroSumGen.lean:81` gives c3g(10,H)=44/(H log(10/3)). `PsiPlateau.log_10_3_ge:44` and `Z3g_H_le:74` supply log(10/3)>=1.2039 and Z3g(BPz2,3e10)<=210.6. Consequently, for 0<H<=3e10,

    c3g(10,H) <= 36.6/H,
    Z3g(BPz2,H) <= 210.6.

The numerical comparison is strict: 36.6*1.2039>44. Retaining this H dependence, the source's finite fiber estimates and finite telescoping bound yield exactly

    F(H) = 64*[421.2/H^2 + (73.2/H)*(1/(8.8H)+1/H^2)]
                 *[1/H^2 + 1/(4.4H)].

Writing u=1/H, A=421.2+73.2/8.8 and B=73.2, this is

    (64A/4.4)u^3 + 64(A+B/4.4)u^4 + 64B u^5.

All coefficients are positive. Thus the endpoint calculation proves the whole range H>=2e6, rather than sampling it. Independently,

    F(2e6) = 118117769923522143 /
             151250000000000000000000000000000
           < 7.81e-16 < 1e-15.

This proves the unchanged OffC=4^m exp(m ell)*1e-15 on 2e6<=H<=3e10, with every other original premise retained. The source's finite maximum bin index is used only to reorganize a finite sum. No unproved absolute convergence or default infinite-sum value is needed.

## 3. Transfer to the actual Weil-window statement

`WeilWindow.weil_windowH:259ff` needs, in addition, RHBelow H and exp(2m ell)<2. Its limiting formula has the actual WPhi normalization, including the 1/(2pi) archimedean integral. Nothing in the proposed adapter changes that normalization.

For each arbitrary finite target carrier `zerosRectD zetaF T`, the proof eventually takes goodT larger than both T and H. The target's zeros embed in the on-line part of this larger Xi carrier with equal multiplicities. RHBelow H makes the extra on-line terms nonnegative; the newly bounded off-line terms contribute at worst minus OffC. Taking the existing Weil limit proves the same conclusion. This argument includes possible zeros at abs(gamma)=H in the on-line part; they are not lost at a strict tail boundary. The strict outer rectangle cutoff causes no difficulty because goodT is eventually strictly larger.

Thus the lower-height transfer is valid on paper for the stated window theorem. It does not automatically lower the hypotheses of its other consumers, whose numerical estimates and extra geometric conditions must be checked separately.

## 4. The surviving dependency and cost conclusions are appropriately limited

The report correctly distinguishes geometric lower heights for individual principal plus/star estimates from preservation of their full error bounds. `Prop942.prop_9_4_2:77ff` retains the complete errPZ expression. `Cor713.err933Z_le:774ff` is actually specialized to height1e8 and its stated twist range; a smaller geometric height does not imply that scalar conclusion.

The arithmetic route being audited is also not bounded above by the final odd-input lower threshold. `ThetaExplicit` directly consumes the plateau and the large-x range/asymptotic theorems; the latter use the source zero-free estimate with abs(gamma)>=1e8. The finite cB tables and separate Mertens/E1 windows require their own replacements. A smaller off-line Weil constant alone supplies none of those replacements. Previously proposed alternative prime estimates or totient arguments may remove selected uses only after their precise joins are adopted; the present note does not rule them out.

Accordingly, “the present complete principal target remains 1e8” is accepted as a statement about the retained original-RH proof route and available consumer joins, not a universal minimal height. “No end-to-end benefit established” must likewise remain a statement about this isolated adapter, not a measured cost comparison or a claim that alternative mathematics cannot help. The report observes these qualifications.

The deeper zero-count, smoothing, explicit-formula and Weil-formula foundations are reused source inputs, not newly proved here. Formal implementation, elaborated axiom checking, actual spectral data, and any changed end-to-end cost remain outside this review. No Lean build, numerical analytic evaluation or author-file mutation was performed.
