# Precision escalation and repair for the large branch

2026-11-11. Bounded paper policy. No values, signs, zeros, scans, declarations, proof emission or builds. This note prescribes conditional checks and work accounting. It assumes neither successful repairs nor their frequency, and changes no frozen circuit or inventory.

The m41 window and the common-radius allocation separate three questions: whether a producer meets its error contract, whether an actual output has a strict sign, and whether the retained critical evidence closes the count. A failure of one is not evidence about either of the others.

## Frozen mathematical interfaces

Paths are relative to `work/qrh-campaign/agents`.

|Input|SHA256|
|---|---|
|audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md|96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D|
|zero-sum/REVIEW_LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md|F6F38CBFC4237AB0C4AAC978EF1D0157754DFAA461D01FC3D54D921B1FE45D54|
|audit/SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md|32ED0BD63C247134910FAE3BE124880EF7548422368230B59EF0F52E39FFB96E|
|major-constants/REVIEW_SHORTER_LARGE_BRANCH_WINDOW_CERTIFICATES_2026-11-11.md|61FA9D6594264FBA3EF26AA60157CDB22C5FFD66EB52AEE0DB16C19267E5A730|
|audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md|6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA|
|major-constants/REVIEW_LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md|3D8831ABB2BBD69A1AD82389B8A2082DBCE18D5E6C47E73230F6808F0EBFF589|

The independently reviewed stability allocation is consumed conditionally here, with its explicit producer hypotheses. Its paper review supplies no actual sample data. The actual function is the real endpoint-normalized Y, not a sign-equivalent proxy. The route has h=159/500, m=41, Delta=5/64, primitive nonprincipal c<=265800, and every retained sample satisfies |t|<=7000. The analytic allowance is below `0.927193523*2^-46`; a simpler admissible allowance is2^-46. It is an upper-bound certificate, not an actual error lower bound.

For the direct finite sum the complete radius can be organized as

    r_I = E_analytic + E_source/head + E_transform
          + E_scale/completion + E_negative
          + E_kernel + E_accumulation.

All terms refer to the actual retained dependency graph and its centers. The full A_alpha already contains Taylor, shift, seed/source and polynomial-evaluation errors. Changing the name of a downstream producer does not remove those terms or charge them again.

## 1. Diagnose the failed inequality

Keep the specific failing obligation in the candidate record. A coarse upper bound may fail even when the true value would admit a better enclosure.

|Observed certificate failure|Possible repair|What that repair alone cannot establish|
|---|---|---|
|Intrinsic transform bound exceeds its allocation|Increase transform p, or use a separately proved tighter circuit bound; recheck its safety, inputs and cache errors|Smaller source, head, phase, kernel or analytic errors|
|A_alpha, head or new input-representation error is too large|Refine the responsible producer or select another admitted source circuit with a proved complete bound|Improvement from transform p alone; free deletion of old source terms|
|Scale, actual completion, inverse-channel or elementary leaf error is too large|Refine that exact factor/phase/leaf and its arithmetic, retaining source identities|A small canonical-phase error from the coarse positive-cosine proxy|
|Kernel or finite-sum arithmetic exceeds its allocation|Refine kernels/accumulation or prove another finite circuit computes the same sum with a smaller radius|A smaller omitted-sample or Fourier-tail bound|
|Complete radius is valid but `|Ihat|<=r_I`|Recompute a tighter full enclosure or choose other targets/evidence|A strict sign, nonzero value, zero multiplicity or off-line zero|
|Signs are valid but the count surplus fails|Improve critical evidence/auxiliary weights/count enclosures under their actual theorems|Completeness from more value bits alone|

An implementation should distinguish failure to construct a requested enclosure from failure of the resulting strict sign inequality. Neither can be silently converted into a successful certificate.

## 2. What changing p alone means

Under the stability hypotheses, the exact interpolation kernel has l1 norm below5 and the actual completion amplitude is below27. If all non-transform producer bounds are held fixed, a sufficient p-dependent radius has the form

    r_I(p) <= R_fixed + 135*C_T*2^-p,
    C_T=1266*202305920*2^14.                         (P)

R_fixed includes the analytic allowance and all remaining source/head/scale/completion/negative/kernel/arithmetic contributions. The inverse-channel exact damping is at most1, so it does not increase this transform coefficient. The certified magnitude caps used in the other terms remain valid for p>=112 under the same hypotheses. A different transform algorithm needs its own sufficient intrinsic coefficient and exact output normalization.

For a prescribed radius tau, increasing p can satisfy this sufficient bound only after `R_fixed<tau` has been established. Then it is enough to check the exact inequality `135*C_T*2^-p<tau-R_fixed` together with all circuit conditions. If R_fixed>=tau, p alone does not close this particular bound. This says nothing about the true error or the possibility of improving R_fixed.

For a sign, every new candidate must instead pass `|Ihat_p|>r_I(p)`. The center changes when p, root/chirp centers, source data or the circuit changes. An old center's apparent margin is not transferable merely because the new radius is smaller. An exact equality or certified relation between the two center constructions would be needed for such a shortcut. A heuristic margin may guide generation but is not an acceptance premise.

The p112 allocation shows compatibility with one common radius2^-45. It neither promises that this radius resolves all needed signs nor makes p134 the mandatory next step. More bits may be wasted when another component dominates. Conversely an individual successful sign at a larger radius needs no unnecessary recomputation merely to fit a global preferred precision, provided the checker accepts that complete source-bound certificate.

## 3. Analytic-tail repairs and new grids

For a fixed h,Delta and target domain, increasing m reduces the proved omitted-sample contribution. The Fourier bound is independent of m. Once that Fourier allowance dominates, adding guards alone does not improve the complete sufficient radius enough. This is a certificate limitation, not proof that the actual interpolation error has that size.

Changing h changes both analytic contributions and every Gaussian kernel. A smaller h improves Gaussian sample decay but worsens the right-contour exponent `M^2/(2h^2)`; a larger h changes the prefactor and the opposite tradeoff. No global monotonicity or winning choice is assumed. The joint inequalities, off-grid decrease/ratio conditions, all sample domains and new kernel enclosures must be recertified. The finite grid search supporting m41 proves no optimality among these repairs.

A genuinely finer coarse sample lattice reduces Delta and raises the Nyquist parameter B=1/(2Delta) in the Fourier bound. At fixed m it also shrinks the physical truncation window mDelta, so its sample tail and guards must be recomputed. New sample values and their errors must be produced, either directly or through a separately justified dependency chain. Refining only the target offsets theta while reusing the old coarse lattice does not change its B or Fourier allowance. Interpolated points cannot be declared exact new samples; their inherited radii remain when they feed another interpolation.

Each target set Q requires the exact dependency union

    J(Q,m,Delta) = union_(t in Q)
        {floor(t/Delta)-m,...,floor(t/Delta)+m}.

Negative indices use the actual inverse-character multiplier and fixed phase sign. Upper guards outside the current source domain require an admitted source extension or direct alternative. A changed h leaves this index formula unchanged but changes the kernel cache; a changed m or Delta changes the index set as well. No saved global count is silently reused for a new union.

Direct point evaluation with a complete actual-L/Hardy sign contract can avoid these interpolation tails. It still needs its source, head, scale, phase and arithmetic bounds. It is an alternative certified route, not a claim that the current fixed-budget producer reaches arbitrary accuracy or has a known repair cost.

## 4. Zeros, central points and multiplicity

A true zero never has a strict sign at that exact point. Repeatedly increasing p cannot change this. An interval containing zero does not prove that the actual value vanishes, is multiple or lies off the critical line.

Moving or subdividing target points may find signs on either side of an isolated crossing, but no spacing or nonzero-margin assumption is available here. A smaller geometric mesh can also place points closer to zeros and reduce their margins. Closely spaced pairs may require both finer geometry and smaller errors. This policy assigns no probability, frequency or success guarantee to that event.

Opposite certified signs in an interval establish at least one critical zero, not its exact multiplicity. Even critical multiplicity need not change sign, so arbitrarily dense sign sampling does not by itself certify all multiplicities. Nested or overlapping replacement brackets must not be counted twice; the retained K must use the actual disjoint-evidence rule. Additional multiplicity or location claims need a separately proved certificate, such as an appropriate local argument-principle/derivative/symmetry construction. A contour count alone is not automatically critical-line evidence.

The central point is handled by the exact central adapter. A failed t=0 sign enclosure does not establish a critical zero, exclude real off-line zeros, or authorize doubling central evidence. A proved central multiplicity may be counted under its actual theorem; alternatively the finite-RH pair-deficit rule can leave at most one uncounted critical multiplicity if its strict surplus succeeds. That is not a complete zero list. Real characters and nonreal inverse pairs retain their distinct positive-channel and central conventions.

One useful conditional termination statement is much narrower than a production guarantee: at a fixed nonzero actual real value, an evaluation scheme whose sound radii tend to zero and whose centers approximate that same value eventually proves a sign. For a known true-value margin mu>0, the simple sufficient condition is 2r<mu: soundness then gives `|center|>=mu-r>r`. Merely r<mu is insufficient for that uniform conclusion. Neither nonzeroness of every selected target nor vanishing radii for the fixed m41/h window is supplied here. Therefore this statement cannot bound the number of repairs or close an unresolved case.

## 5. Turing repairs are separate

Using the exact count adapter and its domain/endpoint hypotheses, the finite-RH test remains

    h_T*(K+2)-Abar+W-2*Bbar > 0.                    (T)

Here h_T is the auxiliary count interval length, not the Gaussian width h. K is proved main critical multiplicity evidence; W is a proved auxiliary lower weight; Abar bounds the canonical Gamma-phase integral; and Bbar is the actual Turing allowance. Failed sign boxes supply none of these objects.

More precise value computations can help only by enabling additional valid critical/auxiliary evidence. Narrower certified brackets can improve W. Refining the canonical integral enclosure can reduce Abar's excess, but the elementary sign-proxy phase cannot replace that integral. A smaller Bbar requires an applicable strengthened count bound or another proved input, not simply larger transform p. A longer auxiliary interval changes the source height, signs, phase integral, allowances and guard dependencies; it must be checked as a new complete count candidate.

The strict pair-deficit inequality permits finite RH without claiming exact count saturation. Under its reflection argument an off-critical contribution costs at least two, while the integer total can exceed K by at most one. Exact-count/list consumers require their stronger evidence. Even when every needed zero is critical, pure sign evidence may miss too much multiplicity for (T); precision alone cannot cure that logical deficit. Principal certification remains separate.

## 6. Conditional work accounting

Record the actual attempted repairs rather than multiplying the baseline by an assumed failure percentage. For attempt j retain its target set Q_j, coarse grid Delta_j, h_j,m_j, transform/source/phase/kernel precisions, guard union J_j, exact character/channel labels and chosen evaluator. These determine work variables, not success claims.

Let G_j be newly generated source/head/elementary records, T_j newly executed transform blocks, K_j newly constructed kernel/cache records, and R_j retained direct interpolation targets. A direct interpolation attempt has `(2m_j+1)*|R_j|` real products and `2m_j*|R_j|` additions before per-gate widths, rounding witnesses and serialization. A convolution alternative needs its own proved finite-circuit counts and setup. Extra point evaluations, interval/derivative evidence and count integrations are separate categories.

Generation work sums every attempted block, including failed or discarded repairs. Proof checking uses the union of actually retained dependency DAGs plus generic libraries, exact source/statement bindings and count joins. Shared nodes are paid once only when the exact checked object and its dependency/radius contract are reused. Changing precision, normalization, root phase, h,Delta, offset or a source vector may invalidate that reuse. A digest identifies bytes but does not prove a new arithmetic or analytic fact.

The symbolic cost is consequently a sum of typed, width-dependent producer/circuit/checker prices over those actual sets, with library construction/residency and cache rebuilds explicit. No number of attempts, retained success rate, fixed precision distribution, whole-pipeline winner or core-hour estimate is assigned. The baseline remains a conditional first attempt; the acceptance predicates, rather than an assumed repair schedule, decide what can enter the final proof.

This completes the bounded policy handoff. All frozen inputs remain unchanged, and no repair has been executed.
