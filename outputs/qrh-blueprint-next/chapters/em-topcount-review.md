# Independent review of the explicit-EM top count

2026-11-11. **PASS as an external interval certificate and paper-level mathematical derivation.** A full independent alternative calculation covers all six blocks, with different EM/Taylor parameters and independently constructed exponential coefficients. The calculation and reviewed analytic count contract give N(1000000)=1747146, counting positive ordinates with analytic multiplicity. No mathematical correction is needed. One stale research-status sentence is corrected below.

This removes builtin zeta/RS evaluation from this short top-path/count leaf. It is not a Lean theorem, a verified arithmetic checker, or a certificate locating all zeros below the top. Neither the earlier RS receipt nor any historical count is an acceptance premise.

## Frozen inputs and fresh checks

All three producer hashes were checked directly, before any computation:

| Artifact in `agents/zero-sum/` | SHA256 |
|---|---|
| `EM_TOP_HORIZONTAL_2026-11-11.md` | `C8062D1BB197EF9A2FD8450BEAAF7E093B1448865751D0DB30623394C76F13BF` |
| `em_top_horizontal_20261111.py` | `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10` |
| `em_top_horizontal_20261111.json` | `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26` |

The original `--recompute` completed all six blocks in 15.72 seconds and returned `PASS_EXPLICIT_EM_TOP_PATH`. Its S and count endpoints reproduced the frozen rational endpoints. This mode did not overwrite the original JSON. Acceptance requires the PASS status and all six blocks: the script catches a time-budget RuntimeError and can otherwise exit normally with an INCOMPLETE receipt, so exit code zero by itself is insufficient.

New independent files in this directory:

| Artifact | SHA256 |
|---|---|
| `review_em_top_horizontal_20261111.py` | `CD6C4E02FA2CB3F3D8F24EDA9B41C038466764C442E55C7997E6608DF9BC4A1E` |
| `review_em_top_horizontal_20261111.json` | `A6AFF2F64A0EC83FA9E1A4B5727361AE46A133AE01464606C9D87CF648C580D3` |

The independent program imports no producer code. It uses N=300001, M=36, K=26, R=3/4 and 160-bit coefficient arithmetic, instead of 333334/32/24/1/128. For each n it starts with exp(-c log n), then constructs the coefficients by a_j=a_(j-1)(-log n)/j. It does not use the producer's power-series exponential construction. The Bernoulli numbers are recomputed by exact rational recurrence; the pole-cancelled exponential is independently assembled as B times the B^(-s) series.

All six full blocks, not a selected subset, passed in 61.16 seconds. The respective real lower endpoints, rounded here only for display, are .07608735429, .93272699330, .92661202445, .92933010960, .93693382775 and .95076533134. Every one of the seven new actual endpoint balls overlaps its original ball, and both models at each shared endpoint overlap. The proofs of enclosure, rather than overlap alone, justify that they enclose the same actual value.

No evaluator in this replay calls builtin zeta, Hurwitz, Gamma, RS, indexed zeros, nzeros, or backlund_s. FLINT elementary interval exp/log, arithmetic, complex division and finite series multiplication remain external computational dependencies. There was no Lean build, installation, canonical edit, or frozen-package edit.

## Exact evaluator and domain audit

I reread `moebius/EM_SOURCE_PROOF_REVIEW_2026-11-11.md`, hash `5D261401E8D4490DCE78CF284418E840253EB47ADBF0C9654E4A794B75C87CF1`, and the actual source `work/ternary-goldbach/TernaryGoldbach/Explicit/ZetaGrowth.lean:17–30`. The source function is the entire `zetaF`, updated to 1 at s=1, and equals (s-1)zeta(s) for s different from 1. The top path has imaginary part 1000000, so the division adapter applies everywhere on it.

With B=N+1, the finite sum includes precisely n=1,...,N. The EM correction indexed k has rising-factorial length 2k-1 and power B^(1-s-2k), and the remainder has length 2M. The Bernoulli recurrence includes B1=-1/2. These indices, the half endpoint term and the positive correction signs agree with the reviewed finite-cell integration-by-parts derivation. Multiplying by s-1 cancels the sole displayed pole before constructing the finite entire model g.

For actual sigma at least 1/2, absolute integration of the periodic-Bernoulli remainder gives

    |zetaF(s)-g(s)| <= 4 |s-1| |(s)_(2M)|
        * B^(1-1/2-2M) / [6^(2M)(1/2+2M-1)].

The constant follows from the Fourier Bernoulli bound and 2*pi>6; no computed special-function value is required. For an actual target point in the block, S=|c+iT|+1/8 bounds |s|, S+1 bounds |s-1| and S+j bounds each rising factor. The positive denominator is retained. The original maximum error is below 1.975e-12 for zetaF, not for zeta. In the independent model it is below 1.282e-11. Neither calculation discards the factor |s-1|.

For the Cauchy bound, only the finite entire g is evaluated on the outer disk. If sigma_o=Re(c)-R and S_o=|c+iT|+R, then

    sum_(n<=N) n^(-sigma_o) <= N max(1,N^(-sigma_o)),

including n=1. Bounds for the B powers, rising factors and |s-1| yield exactly the displayed outer majorant. It remains valid when sigma_o is negative. The original leftmost outer disk reaches -3/8; no assertion of an EM remainder at that real part is needed for this argument.

Cauchy estimates for g give the coefficient tail Mout(h/R)^K/(1-h/R) on |s-c|<=h. Both runs satisfy 0<h<R. Truncated series products compute all required coefficients through degree K-1; discarded higher degrees cannot influence these coefficients. The original maximum Taylor remainder is below 9.502e-9 for zetaF. The independent maximum is below 1.021e-8. Adding the two error disks, enclosing that disk in a coordinate square, and then dividing by the whole s-1 interval encloses actual zeta throughout each panel. A disk is contained in that square without a sqrt(2) factor; the reverse containment is not used. The denominator excludes zero because its imaginary part is exactly T.

## Continuous argument, orientation and exact count

The exact seven vertices are 1/2,3/4,1,5/4,3/2,7/4,2, each at height T. Adjacent closed quarter-unit blocks cover the entire horizontal segment without gaps. Models are constructed left-to-right, while the canonical argument path traverses them right-to-left. Since every whole image lies in the same right half-plane, the analytic principal logarithm is valid globally on this image. Its increments telescope in the canonical orientation; no separate winding integer or sampled continuity assumption is omitted.

On the preceding vertical segment from 2 to 2+iT, the absolutely convergent Dirichlet series gives Re zeta(2+it)>=2-zeta(2)>1/4. The initial zeta(2) is positive. Thus the initial argument is zero and the entire vertical argument remains the principal argument. The horizontal endpoint at 2+iT has real part greater than 1/4 in both computations. It follows that the canonical S(T) is exactly Im log zeta(1/2+iT)/pi. Endpoint positivity alone would not prove this; the whole-block inequalities supply the missing path control.

Top nonvanishing covers beta in [1/2,1]. Functional reflection and conjugation carry any hypothetical nontrivial zero with beta<1/2 at ordinate T into that covered range, preserving multiplicity. Thus no nontrivial zero lies at the counting height and there is no half-weight ambiguity.

The reviewed normalized analytic identity is

    N(T)=1+theta(T)/pi+S(T),
    F(T)=T/(2*pi)*(log(T/(2*pi))-1)+7/8,
    |1+theta(T)/pi-F(T)|<1/8  (T>=1500).

I reread the count/path derivation in `audit/PRINCIPAL_COMPLETENESS_ROUTE_REVIEW_2026-11-11.md`, hash `FB268AD7ACE08954435194D51BF6FC3C358AE7838E8CCFAE7087B0E0F84EAA11`. The +1 and Gamma logarithm normalization are fixed analytically, not calibrated to a finite zero count. The new replay evaluates only elementary F and the endpoint logarithm; theta and Gamma are not numerically evaluated.

The independent S interval is

    [148506830597234441060409/302231454903657293676544,
     148506830597235160753607/302231454903657293676544].

Adding exact rational endpoint bounds for F and the allowance +/-1/8 gives a count interval approximately [1747145.8749999935,1747146.1249999935]. Its exact lower ceiling and upper floor both equal 1747146. The program tests that equality without comparing to a known count, rounding a midpoint, or treating width less than one as sufficient. This is an all-zero multiplicity count under the analytic count contract, not a critical-line count.

## Status correction and remaining obligations

The producer's final paragraph says the principal strip still needs both [14,1500] and [1500,1000000]. That is stale status, not a flaw in the evaluator or its count. The accepted `audit/PRINCIPAL_SIGNS_1500_REVIEW_2026-11-11.md`, hash `A2961DEBB4BF2734FB048F1500D6E495E42B5DCB8439DD2412299F803A37FFFE`, now supplies the external low-height line-location and simplicity result when joined to the independent complete head count. The remaining external principal location interval is 1500<|Im rho|<=1000000. Head counts alone still do not locate zeros. This review preserves the frozen producer file and records that correction here.

The new top count supplies neither the high-strip boundary certificate nor 1747146 critical-line sign changes. The finite family Hcert rectangles also remain separate. Formal obligations include the source-faithful EM identity and Bernoulli bound, finite coefficient semantics, Cauchy remainder, sound elementary interval operations, branch/count identity with normalized Binet remainder, and actual-zero multiplicity/carrier transport. None may be replaced by a permanent numerical premise of the final theorem. The earlier RS-backed top receipt remains unchanged and is unnecessary as a premise for this new EM route.
