# Minimal principal RH receipt through 100000000

2026-11-11. Source/paper research and small integer metadata checks only. No ordinate archive was downloaded, no zeta/Hardy/Gamma values or zeros were evaluated, and no build or Lean source was changed. This is a proposed acceptance design, not a successful spectral certificate or a runtime forecast.

The useful reduction is to specialize the principal production output to its actual consumer: **closed finite RH**, with one global count upper bound and checked critical-line lower counts. The reviewed reflection argument allows a deficit strictly below two. It does not require an exact high-height count or a complete ordinate list. Shards need not each prove their own exact count. Historical ordinate indices can remain entirely outside the mathematical acceptance interface. The separate low-head count and reciprocal-moment obligations stay in place.

This does not remove the dominant unfinished task: rigorously certify enough actual signs, including difficult samples and all arithmetic/analytic errors. Coordinate compression and weaker counting gates are smaller improvements to that task, not substitutes for it.

## 1. Consumer boundary and the inputs that remain separate

`MajorArcs/GRH.lean:32–38` defines the exact accessor

    GRHUpTo chi H := forall rho, chi.LFunction rho = 0 ->
      0 < rho.re -> rho.re < 1 -> |rho.im| <= H -> rho.re = 1/2.

For conductor one, `prop_9_4_2` in `MajorArcs/Prop942.lean:77–93` uses only this predicate, converts the actual L-function to zeta with `Explicit.LFunction_one_mod_one`, and passes the resulting predicate into `norm_SsumG_fP_zeta_le`. The scalar envelope contains analytic zero-count bounds, not a numerically supplied high-zero list.

`thm_7_1_4_one` in `MajorArcs/Thm714.lean:572–589` consumes it at H=1e8 for x>=4.9e26 and |delta|<=600000. `cor_7_1_3'` in `MajorArcs/Cor713.lean:807ff` has a principal branch at the same height, with the principal scalar estimate `err933Z_le:774ff` on y>=1e25 and |delta|<=1200000. Their present source wrappers still obtain this fact from `Fact PlattGRH`; localizing the proved bodies to the actual finite predicate is a remaining implementation task, not an edit made here. `prop_7_1_5'` in `MajorArcs/Prop715.lean:355ff` needs only principal RH through 500 at its explicit-formula call, and can use monotonicity from an already accepted low head. Its eta-square integrals are not zero-ordinate moments.

These direct interfaces do not request simplicity, root indices, exact N(1e8), individual ordinate accuracy, or a reciprocal-zero moment through 1e8. This is a statement about the traced principal interfaces, not proof that every other campaign consumer is RH-only.

In particular the separate common-psi route retains its head data: the reviewed head gives N(1500)=1069, no low real zeros, and

    Q1500 = sum_(0<gamma<=1500) m*(1/gamma - 1/1500) < 1.668.

The positive reciprocal sum is Q1500+1069/1500, not Q1500. `PSI_DAMPED_SHARED_STRIP` consumes this correction explicitly; `RECIPROCAL_HEAD_REUSE` uses the head moment with an analytic count envelope for a different prime-gap application. A pure RH accessor neither proves nor replaces these outputs. Their actual external evidence must still be replayed formally. They can be imported once as separate checked head facts. Historical narrow-strip/moment variants are not silently adopted by this report.

## 2. A sufficient RH-only receipt

Let H=100000000. Choose a rational top Tstar>=H and a complete finite carrier of actual nontrivial positive-ordinate zeros through Tstar, with true analytic multiplicities. Let C=N_+(Tstar). Supply:

1. K units of certified multiplicity supported on the critical line. A strict sign change of the actual continuous real Hardy function across an open interval contributes one unit. The represented intervals must be disjoint; shared endpoints must have certified nonzero values. A previously checked complete head count contributes its known critical support without repeating its sign evaluations.
2. A correctly normalized principal upper count C<=U and the strict rational comparison U<K+2.
3. Separate real-axis exclusion and conjugation of actual zeta/xi zeros.

If an off-line positive zero rho existed, `rho -> 1-conj(rho)` would be a distinct positive zero at the same ordinate. Neither is in the support of the K critical units. Each has positive true order, so C>=K+2, contradicting the strict comparison. Negative ordinates follow by conjugation; the real axis is handled separately. The result covers the **closed** requested height. The source `Explicit/ZeroFree.lean:102` already gives `xiF_zero_one_sub_conj`; completion/order transport and finite-carrier completeness remain part of the analytic checker bridge.

This is the reviewed principal specialization of `REVIEW_FINITE_RH_PAIR_DEFICIT`. It permits one unrepresented critical multiplicity unit. It therefore does not imply simplicity, C=K, absence of critical boundary zeros, or completeness of a stored list. Exact count/list/moment consumers must use their own stronger evidence. If one instead proves U<K+1, integrality and C>=K give C=K and the usual saturation conclusions.

There are two count producers, with different endpoint costs:

- A certified zero-free horizontal top path and the principal identity N_+(Tstar)=1+theta(Tstar)/pi+S(Tstar). Right-line positivity initializes the argument without sampling the entire vertical segment. It is enough to enclose the right side from above below K+2; a unique-integer interval is unnecessary. A top path proves more boundary nonvanishing than the relaxed gate itself needs.
- A principal closed-count Turing upper bound at Tstar, using auxiliary signs and an integrated canonical phase. This can include zeros at the top, but requires the actual principal allowance and auxiliary data. The nonprincipal count normalization cannot be substituted.

The first option avoids assuming a new principal Turing producer. An attempted Tstar in (H,H+1] is a bounded design choice, not a claim that a particular point/path can be certified cheaply or that every requested precision succeeds. If no allowed top succeeds, stop or obtain authorization for a revised range; do not retain an old count after changing the top. The integer sensitivity below uses H+1 only conditionally.

## 3. Shards prove lower counts, not local completeness

Partition the proposed signs into shards with exact rational bounds and a common actual-function normalization. A shard exports a theorem that its disjoint open sign intervals provide k_j distinct critical zeros in its assigned range, together with its first/last sample and boundary signs. Adjacent shards may share one nonzero sample; their open intervals then remain disjoint. Count that sample's value proof once when the proof context permits reuse. Do not count an interval in both shards.

The final assembly checks exact range/order and seam conditions, forms K=K_head+sum k_j, and applies **one** global upper-count gate. There is no requirement that the slabs between shards be covered by certified zero-free regions: omissions decrease K and make the global gate harder to pass; they cannot create false RH. There must nevertheless be a proof that all K witnesses refer to distinct critical-line zeros below the same top. Claimed interval counts or hashes alone do not provide it.

For S shards, this design removes S-1 local count/argument certifications from an otherwise identical strategy that proves exact completeness at every shard boundary. Symbolically the removable cost is the sum of those local count certificates, not the sign-evaluation work or the one global count. A global deficit gives poor localization of a missed zero, so local counts may still be worthwhile **generation diagnostics**, with their cost charged. No numerical count-saving ratio is asserted.

For Lean, a checked shard theorem must be referenced with its actual statement and definitions. For ordinary MM0, either retain the checked context or carry a valid proof/context-import mechanism. A shard hash is not an axiom and is not a substitute for checking its proof. O(S) final count assembly does not mean O(S) total proof bytes or arithmetic work.

## 4. Historical ordinates need not enter the trusted receipt

The prior `PLATT_ARTIFACT_REUSE_RESEARCH` already identifies advertised principal data covering this height and a 13-byte delta-record decoder. That report inspected availability/schema; this report performs no new availability check or download. The prior `PRINCIPAL_COMPLETENESS_ROUTE` already observes that successful alternating signs can be compressed to K+1 samples and that old ordinates can guide inter-zero sample selection. Neither fact is claimed as a new analytic result here.

The narrower acceptance boundary is useful: if the final receipt contains only exact sample coordinates, certified actual signs and the global count bound, it need not prove that a sample is the midpoint between historical roots numbered i and i+1. The mathematical proof never consumes those indices. A malformed historical decoder can hurt discovery, skip useful roots or make generation fail, but cannot invalidate a correctly checked receipt whose actual coordinates and signs satisfy sections 2–3. Archive provenance, bounds checks and indices remain good generation/reproducibility practice; they are not additional premises of the accepted RH proof.

No published reliability statement, old ordinate error radius, header count or native interval output is accepted as a sign or completeness theorem. Existing proof packets through 1500/2000 likewise count as proof reuse only after their actual arithmetic and analytic bridges are checked in the selected system.

## 5. Optional exact coordinate encoding with fine exceptions

This is a proposed format, not an implemented decoder or a claim that coarse sample points have sufficient sign margin. Suppose n ordered samples lie in [0,Uheight], Uheight=100000001. Fix b and define coarse keys k_i=floor(2^b t_i). Keys may repeat. Most samples may be stored exactly as t_i=k_i/2^b. A fine exception stores

    t_i = (k_i + v_i/2^d_i)/2^b,  0 < v_i < 2^d_i.

This represents every nonnegative dyadic sample with a sufficiently fine exception; it assumes no minimum zero spacing. The checker verifies exact order of the reconstructed t_i, not merely the order of k_i. A finite admitted d_max is a resource cap, not a theorem that all difficult samples fit it. Non-dyadic rational samples would require a separate tagged encoding and its cost.

Let M=2^b Uheight and choose ell>=0. Store the low ell bits of every k_i and an ordered bitvector whose ith one is at

    position_i = floor(k_i/2^ell) + i,  i=0,...,n-1.

Its one positions are strictly increasing even when keys repeat. Recover each key by subtracting i, shifting ell bits, then adding its low bits. A safe total base bit bound is

    n*ell + floor(M/2^ell) + n + 1.

The checker must validate the number of ones, bounds, nondecreasing keys and increasing actual times. Arbitrary low-bit fields with ordered high parts do not automatically give ordered keys. Padding bits and shard boundaries need exact lengths. All sign and count evidence must bind to the same decoded coordinate object.

Fine exceptions cost additional bits. One explicit format uses E fixed-width indices, d_i fields and v_i fields, costing at most

    E*ceil(log2 n) + E*ceil(log2(d_max+1)) + sum_i d_i

before tags/header overhead. An n-bit exception bitmap is another option. These are alternatives, not free metadata. No bound on E or d_max is established here. A shard may reset high keys to its own declared exact offset, with proof that the offset and decoded positions reconstruct the global times.

For an **illustrative n=250000001, not an asserted zero/sample count**, the small integer script obtains:

| b | ell | Base payload bytes upper | Byte-aligned fixed coordinates |
|---:|---:|---:|---:|
| 8 | 6 | 268750002 | 1250000005 |
| 10 | 8 | 331250002 | 1250000005 |
| 16 | 14 | 518750003 | 1500000006 |

All exclude exceptions, headers, interval values and proofs. A 13-byte-per-item archive proxy would be 3250000013 bytes, but those historical records encode a different, much more accurate object. This is a payload comparison only. Ordinary PA/MM0 bitvector decoding needs proved integer operations and exact object binding; Lean also needs an actual decoder/soundness theorem. Nothing here gives a byte-to-kernel-time conversion.

## 6. Remaining dominant cost and a bounded next experiment

The accepted K0 interval plan provides a finite exact evaluator and an analytic Hardy radius; it does not promise a sign at any selected point. At t<=100000001, pi>3 gives sqrt(t/(2pi))<4096 because 6*4096^2=100663296. Thus a direct independently evaluated K0 main sum has at most 4095 terms per high sample. For the illustrative n above, the simple upper schedule contains 1023750004095 main summands before phases, correction, tails, arbitrary precision or repairs. This is an upper count for that particular unshared schedule, not an actual operation count, a complexity lower bound, or a reason to reject shared wave/window/FFT methods.

Prior windowed-principal and wave reports already seek that sharing. They still need certified truncation/alias/interpolation bounds, arithmetic replay, point margins and an exception policy at this height. The fixed analytic K0 radius .47*t^(-3/4) is not removed by increasing arithmetic precision. An inconclusive sign can require a different sample or a stronger analytic evaluator. Multiple critical zeros may prevent sufficient sign witnesses even if RH holds. The +2 gate tolerates only one missing multiplicity unit; it does not prove sign-discovery termination. Higher-order critical-zero certificates or another completeness route remain possible fallbacks, with their own cost.

The most useful next bounded experiment, if separately authorized, would hold one actual-source evaluator and one short height block fixed, use old ordinates only as hints, and record: attempted samples, successful signs, fine exceptions, unresolved signs, each source of error, arithmetic proof size, and the shard lower-count theorem. Compare a shared evaluator with its unshared counterpart on exactly the same retained samples and precision/error contract. Include generator time, arithmetic-witness production, checker time and memory separately; do not infer the full-height cost from one easy block. No such experiment is run or authorized by this note.

The selected principal H=1e8 obligation, current N0 and the nonprincipal family remain unchanged. If a later prime-gap route extends principal RH above H, this head is a shared proof cost, not a second independent spectral computation. This report establishes no production feasibility or end-to-end winner.

## 7. Pinned evidence and check limits

Paths are relative to `work/qrh-campaign/agents`, except repository paths prefixed `TernaryGoldbach/`, relative to `work/ternary-goldbach`. Source was read directly; this is not a build/axiom audit.

| Artifact | SHA256 |
|---|---|
| `TernaryGoldbach/MajorArcs/GRH.lean` | `89C6DF8490955EEA8F4141498BCA6D163355C2E7765C9ECD09F8CEE5B257A070` |
| `TernaryGoldbach/MajorArcs/Prop942.lean` | `35B170971DBD0F1C6646CD86ECE8C3A86021085C1B07730141CD6311D9CA5716` |
| `TernaryGoldbach/MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `TernaryGoldbach/MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `TernaryGoldbach/MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `TernaryGoldbach/Explicit/ZeroFree.lean` | `E8096BB9CACE76603D8B14429596279046D0E9F99DFDBD6E4BDCF8368A89084A` |
| `independent-feasibility/REVIEW_FINITE_RH_PAIR_DEFICIT_2026-11-11.md` | `97645AB7A3A9EC3B807DD4BFDD022175455A0F1DEF46F676141E6C587164C7E5` |
| `mellin/PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md` | `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C` |
| `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md` | `0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028` |
| `moebius/PLATT_ARTIFACT_REUSE_RESEARCH_2026-11-11.md` | `CD45B84C3B3BE752AFEFD27B228E9950AE50AE0A167FD6444B0FA1D90986B55F` |
| `zero-sum/PRINCIPAL_EXTENSION_VERSUS_LADDER_COST_2026-11-11.md` | `CE5139A66022791E362117330291F8FA3DA670B778355EA61B2CF9737CF813E2` |
| `zero-sum/RECIPROCAL_HEAD_REUSE_2026-11-11.md` | `8EC98EEAC527630E0D3F558B63A0CE9897189DA389932FC7B0F536510EA9D27F` |
| `prime-estimates/PSI_DAMPED_SHARED_STRIP_2026-11-11.md` | `8764E3EFDC940A4F302A761CFD2DE51778A91A5BF30F059F39CD0911F00CF5D0` |
| `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md` | `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491` |
| `prime-estimates/PRINCIPAL_K0_INTERVAL_EVALUATION_PLAN_2026-11-11.md` | `E3B6843DA11022ACBC0A7BBAFA5B8C125CF38B88127B69DCB3B8FF6EB90B157A` |
| `prime-estimates/principal_rh_minimal_receipt_metadata_20261111.py` | `B0FD4D81B295ECC85AE8E7A0F889CD2D4A8A6B69677FC5CE70CC707FF024F017` |
| `prime-estimates/principal_rh_minimal_receipt_metadata_20261111.json` | `047A9107D6551D39947C4900B89A9642D2C169799F5DA478717822F49A8FF10F` |

The owned script uses integer arithmetic only: three hypothetical size rows, the direct-main-sum ceiling, and 16 bounded synthetic integer-codec round trips. It imports no campaign evaluator or analytic library. Its successful run is not a formal proof of the decoder, a count of actual zeros, a high-height sign certificate, or a performance benchmark.
