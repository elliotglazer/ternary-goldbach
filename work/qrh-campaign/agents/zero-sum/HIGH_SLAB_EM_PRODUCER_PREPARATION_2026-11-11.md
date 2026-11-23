# Prepared explicit-EM producer for one high zeta slab

2026-11-11. **Static preparation only. No producer import, model, logarithm, node, weight, panel, or special-function evaluation was executed.** A standard-library AST parse passed. The code needs static approval and a separately supplied coordinator authorization before a numerical attempt. There is no candidate receipt or numerical PASS.

## Fixed files and mathematical contract

The new producer is `zero-sum/high_slab_em_candidate_20261111.py`, SHA256 `AA4496B7EE84D4BCA497B5BDFFC237A6DC0949F45C5F9E134B29498C5B58D084`. All paths here are under `work/qrh-campaign/agents/`.

It implements the final design `moebius/PRINCIPAL_HIGH_ENDPOINT_SLAB_DESIGN_2026-11-11.md`, SHA `5163C4208A5FC6F670FF0EDBC149A43C38FA5246F1D6CA567C75E055DD7EA2C8`, and pins these support inputs:

| Input | SHA256 |
| --- | --- |
| `mellin/HIGH_SLAB_ZETA_SOURCE_ADAPTER_2026-11-11.md` | `C9C4CD0156CA987D5200DA3F4AACCF3C8F1B64BD0FEADCC3F6F12F5F10ED9ED5` |
| `major-constants/HIGH_PRINCIPAL_SLAB_SCALAR_SUPPORT_2026-11-11.md` | `5176DAF690017CF8889BF14F22A882CF93B713B76D126983AAB7359BA8ECB060` |
| `major-constants/check_high_slab_scalars_20261111.py` | `E4D3AC6451D16F8DBFC460112F63AA667DF4A85672D3A41D42458F6321E0E499` |
| Its receipt | `3E23393B1DBD5EEFB186F8D0D6C624E71F12E3433B184A10EEBB218FA6E11E17` |
| Accepted top coefficient receipt | `9F8D349077CEA0598C50C61377C80A0098FFBB0EF723A0A68D85A18FC73AEC26` |
| Accepted top source | `F0F7B331D8C3515C88845DB08A735AF9A071CC9A3D3025A46919C400FEE03D10` |
| Independent top review | `6E2E1C0F3283F62CF68FCCC8E90AB67F5626288353E7B9A6921BCE695425CA4E` |
| Generic exact polygon proof | `21ACEA6753546CB2D22E8BE2949FA02A3D6A030B21960C6A024731514F09E08B` |

The only target is the closed rectangle

`[629/1250,2]+i[1000000-1/8,1000000]`.

The counted local function is actual zeta, represented by the entire finite pole-cancelled EM expression g plus its zetaF remainder, then divided by s-1. The eventual source argument principle is applied to **entire zetaF**, after the pinned local product/logarithmic-integral adapter proves that s-1 has zero winding. The code does not treat zeta as globally entire, evaluate Gamma/xi, or reuse the old total count as a slab count.

## Model manifest and old-data reuse

Parameters are immutable: N=333334, B=333335, M=32, Taylor **length** 24 (degrees 0 through 23), outer finite-g radius 1, new arithmetic precision 192 bits.

The producer reads six old top jets from JSON only. It never imports the eager top producer. Each coefficient's four rational endpoints are parsed as Fractions, converted through outward midpoint/radius arithmetic, and checked to enclose the original whole rational rectangle. The old header, six centers, source producer pin, source disk intervals and coefficient counts are checked. Old EM/Taylor upper endpoints must fit the conservative uniform replacement error; their records are retained. No midpoint-only import or overlap test is used for acceptance.

The only seven new long models are:

* Six bottom centers with real coordinates 5/8,7/8,9/8,11/8,13/8,15/8, each at height T-1/8 and with target radius 1/8.
* One left center 629/1250+i(T-1/16), with target radius 1/16.

The finite entire expression is precisely the pinned EM g. It is built by interval truncated-series exp and exact rational Bernoulli coefficients. There is no builtin zeta, Hurwitz, Gamma, RS or zero oracle. The logarithms of 1 through N and B are initialized once. Partial model progress is recorded, but only a completed model supplies usable coefficient data. Subdivision never creates another model.

Uniform bounds from the pinned scalar proof are `Mout<2^48` and actual-region EM zetaF error `<2^-38`. The top/bottom finite-g Taylor error is `1/(7*2^21)`; the left error is `1/(15*2^44)`. These safe uniform bounds may enlarge older top errors. Every tested segment must lie both in its original fixed-model disk and in the actual slab. **The left disk crosses Re(s)=1/2; the actual EM error is asserted only on the tested slab points**, not on that entire disk. The finite-g Taylor bound independently applies to the disk.

## Whole panels, vertices, and winding

There are fourteen initial CCW segments: six bottom rightwards, analytic right side upwards, six top leftwards, left side downwards. Both first horizontal blocks are clipped to start at 629/1250. The right side uses `Re zeta(2+it)>1/4` and creates no numerical model.

For every numerical segment, Horner evaluation uses the **whole** real or imaginary offset interval relative to the original model center. It adds a coordinate square containing the EM plus Taylor error disk and divides the complete result by the whole s-1 box. The denominator's positive imaginary lower bound is checked. The four candidate half-planes use complex multipliers `u in {1,-1,i,-i}` and the convention `Re(u*z)>0`. A failed sufficient test is stored, then bisected dyadically within the original model disk.

Once all panels pass, the exact geometry checker requires one complete oriented traversal of each side, exact joins and closure, and the four correct side lengths. It does not accept an arbitrary closed boundary-point list.

For adjacent multipliers u,v, the synthetic shared rational vertex is `conj(u)+conj(v)`. Both strict half-plane inequalities are explicitly checked; opposite multipliers fail. Here u is a complex multiplier, **not** a Euclidean normal. These rational vertices need not equal actual endpoint values. Their membership in the same two half-planes as the true endpoint is the accepted polygon-transfer contract. One cyclic list provides exactly shared vertices, including the closing join.

Crossings use the pinned half-open rule: +1 for `a.im<=0<b.im` and positive determinant, -1 for the reverse ordinate crossing and negative determinant, otherwise zero. The signed sum must equal zero for the proposed exclusion to pass. No numerical arguments or endpoint-only inference enters the decision.

## Caps, checkpoints, and statuses

The planned single attempt has these fixed stopping limits:

* Seven new models and six imported models, with no precision retries or extra centers.
* 256 panel visits total, including failed attempts and the analytic right-side visit.
* Dyadic refinement depth at most 12, starting at zero.
* 180 seconds from entering the numerical run, with checks during logarithm and long model loops and between panels/models.
* 512 MiB peak process working set, checked using the Windows process counter; failure to obtain the counter stops the run.

Time and memory checks are cooperative, not OS-enforced preemption: an in-flight elementary call or checkpoint can finish before the next check. No extra numerical work is scheduled after a detected cap. These limits are operational guards, not performance predictions.

Atomic JSON checkpoints are written after each completed model, every eight panel visits, and on handled termination. They preserve all completed model boxes, attempts (including failures), accepted panels, remaining work, current model/term progress, actual operation counters, and the incomplete reason. An external process kill can lose work since the previous checkpoint. There is intentionally no continuation/refit mode: any later attempt requires separate authorization and a new output file.

The only successful label is `PASS_EXTERNAL_HIGH_SLAB_WINDING_ZERO`. `COMPLETE_BOUNDARY_NONZERO_WINDING` records a completed boundary whose count does not establish zero exclusion. `INCOMPLETE_CAP` and `INCOMPLETE_VALIDATION_FAILURE` retain partial results without claiming coverage. Only the zero-winding PASS exits zero. The producer refuses Python -O, changed source pins, missing exact authorization, existing output overwrite, or output outside its owned directory.

Counters separate logarithms, main and endpoint series exponentials, correction terms, Pochhammer updates, model builds/imports, Horner operations, quotient evaluations, failures and repeated model uses. The receipt also records model elapsed times, peak working set and serialized output size. Counts and timings are not compared as equivalent operations or treated as a controlled speed benchmark.

## Proposed command and independent review boundary

No enabled authorization file accompanies this preparation. After static review, the coordinator must supply JSON with `coordinator_authorized: true`, the exact producer SHA256, and an exact copy of its fixed `TARGET` dictionary. Importing this new module for metadata is inert with respect to numerical evaluation; the old top module must never be imported.

The proposed command, **not executed here**, is:

```text
work/qrh-campaign/interval-env/Scripts/python.exe -X utf8 work/qrh-campaign/agents/zero-sum/high_slab_em_candidate_20261111.py --authorize <approved-authorization.json> --output work/qrh-campaign/agents/zero-sum/high_slab_em_candidate_20261111_01.json
```

The optional `--check <receipt.json>` regenerates the same seven models and six imports under the same cap, writes no receipt, and compares the deterministic scientific fields, not timings. A later replay is itself numerical work and needs its authorization; preparing this mode has not run it. A capped/incomplete receipt need not replay to the identical partial stopping position on another machine.

Independent verification is being prepared separately with different finite-EM/Taylor parameters. Since its old top review did not retain jets, it may rebuild all thirteen models; that does not change this producer's seven-new-model limit. Neither static approval nor eventual external numerical replay is a Lean proof or certification beyond this one closed slab.
