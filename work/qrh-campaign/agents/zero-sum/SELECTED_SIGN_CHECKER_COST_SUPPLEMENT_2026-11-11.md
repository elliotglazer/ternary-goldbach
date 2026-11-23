# Selected strict signs versus dense interpolation replay

2026-11-11. Bounded paper research only. No function, zero, transform or numerical experiment was evaluated; no build, new declaration or frozen-file modification was made. This supplements `REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md`, SHA256 `B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC`.

Selected-sign checking can remove most unused interpolation outputs from a proof circuit. It does not automatically remove their shared coarse seeds, character transforms or Turing data. The correct choice is a checked finite interpolation circuit for the requested signs, compared with a dense convolution circuit for the same source samples. Native searches and the accepted checker need not use the same schedule.

## 1. What a successful sign record actually requires

Fix one actual primitive character and a fixed real Hardy normalization. A candidate record gives k ordered open intervals with disjoint interiors, each with strictly opposite endpoint signs. Every interval contains at least one critical-line zero. Their endpoints are nonzeros, so adjacent intervals may share an endpoint without sharing a zero. No simplicity, spacing or prior knowledge of the zeros is needed for this lower-bound argument.

Make a graph whose vertices are distinct endpoints and whose edges are these intervals. Disjoint interiors force a disjoint union of paths. If it has C nonempty components, the exact number of distinct endpoint sign proofs is

    R_main = k+C,     1<=C<=k when k>0.                       (1)

Thus k+1<=R_main<=2k. For k=0 use R_main=0. This is the mandatory endpoint count for this particular interval record, before any independently certified non-sign multiplicity evidence. It is not a universal lower bound against every possible RH certificate.

The cheapest chain uses alternating strict signs. A native search may propose that chain, but it must still supply k valid intervals and pass the total-count saturation test. A chain can hide additional zeros between consecutive endpoints; that only weakens its lower count and prevents incorrect acceptance against a sound total upper bound. A producer cannot assume that every consecutive fine-grid sign change is one simple zero.

Apply(1) separately to every actual positive-ordinate channel. For a nonreal conjugate pair, both positive channels are needed to cover the negative ordinates of either character. For a real character, one positive channel supplies two ordinate signs in the count, without evaluating the positive samples twice. Exact central multiplicity, or a strict central nonzero proof, remains a separate obligation. Its cost is not included in R_main. A multiple noncentral critical zero is not counted with its multiplicity by ordinary sign brackets; finite RH alone does not guarantee this record can be completed.

Once a record is fixed, deduplicate equal endpoint requests by exact character, phase and rational height. Bit-stream compression or storing only the alternating pattern does not replace the numerical sign proofs. Endpoints can be evaluated by different sound backends; all must refer to the same actual function/normalization.

## 2. Dense candidate grid versus retained endpoints

Let a coarse source segment have J nodes, spacing Delta, and a refinement factor u. Its dense refined union has u(J-1)+1 nodes. Of these, (u-1)(J-1) are new. Partition all retained strict signs into reused coarse signs, interpolated signs R_I, and separately evaluated signs R_D. Charge only the distinct requests in each category.

If an actual successful channel contains k positive zeros counted by ordinary main brackets, its retained main endpoint count is between k+1 and2k. A leading-term screen for the expected positive zero count is

    M_c(H) = H/(2pi) [log(cH/(2pi))-1].

This is a screening expression, not an actual zero count or an acceptance premise. Replacing k by M_c(H), J by H/Delta and ignoring auxiliary/head effects gives the candidate retained fraction

    R_main / [u(J-1)+1]
       approximately between (Delta/u)*M_c(H)/H
                            and (2Delta/u)*M_c(H)/H.          (2)

The factor-of-two interval comes from the graph components, not from assuming equally spaced zeros. Actual endpoint counts, exact central data, guard samples and Turing work govern the certificate. Formula(2) may help select a circuit for testing, but cannot justify omitting any required signs. It also does not assert a checker saving of its reciprocal: each interpolation output can depend on many coarse samples.

The primary Platt calculation used ordinary upsampling before its exceptional repair stages. Its remaining-functions percentage is not the unresolved rate on the coarse seed grid. Neither that percentage nor a uniform sign margin is imported into the present cost model. [Platt, sections6–7](https://arxiv.org/pdf/1305.3087).

## 3. Direct interpolation and polyphase crossover

Retain the actual scaled completion Y_chi(n Delta), not merely the elementary sign proxy. With a fixed interpolation Gaussian width h_I, target t=(k+theta)Delta and theta=ell/u, the finite candidate is

    I_chi(t)=sum_(|d|<=m) Y_chi((k+d)Delta) K_(d,theta),
    K_(d,theta)=exp(-((d-theta)Delta)^2/(2h_I^2))
                sin(pi(d-theta))/(pi(d-theta)).               (3)

The removable sinc value, seed/input errors, kernel errors, finite arithmetic and both interpolation tails remain as in the frozen report. The source theorem's height and guard-domain hypotheses must hold. A sign of an elementary phase proxy cannot be used as a source value in(3) without an interpolation theorem for that proxy.

Let w=2m+1. Direct evaluation of R_I requested targets has R_I w product/accumulation terms. Kernel enclosures are shared at equal Delta,h_I,u and offsets; their production and proof remain charged. The input coefficients and kernel centers have different precision/magnitude requirements from the final sign margin.

For a contiguous data block of M coarse samples including guards, choose a power of two P_I>=M+2m. Let v_u be the number of distinct nonzero offsets actually computed, at most u-1. A polyphase convolution schedule has one forward transform of the data and v_u inverse transforms, plus v_u P_I point products. Its radix-two butterfly count is

    (1+v_u) F(P_I),       F(P_I)=(P_I/2)log2(P_I).             (4)

Kernel transforms are cached. Only interior outputs are used, so zero padding never substitutes for missing source samples. This computes exactly the same finite sums as(3), followed by the same analytic error bounds. It is not a new character FFT or new Hurwitz evaluation at every target height.

Let beta(p) be the checked cost of a butterfly at the actual operand sizes, mu(p) the product cost, and a(p) the accumulation/rounding cost. Ignoring common seed/kernel setup, direct interpolation is favored precisely by the corresponding inequality

    R_I w [mu(p)+a(p)]
      < (1+v_u)F(P_I) beta(p) + v_u P_I mu(p)
          + dense scaling/error/output checking.             (5)

Actual circuits can exploit real kernels and symmetries; use their actual costs on both sides. Treating a butterfly as one product is only a model choice, not a theorem. If the forward transform has already been checked for this same exact data, omit that one transform on reuse. If it exists only as untrusted search output, it is not free proof input.

Sparse point count alone is insufficient. A dense convolution may still win when w is long, when requested targets occupy most offset channels in a compact block, or when a previously checked transform is reusable. Conversely disconnected requests spread over a large block can favor direct sums. Partitioning into smaller guarded blocks introduces repeated samples/kernels; choose the minimum actual accepted circuit, not the minimum of cost formulas that hide different prerequisites.

All finite transform normalization and rounding are checked. A compact convolution receipt may reconstruct its gates instead of serializing every intermediate, but it pays their checking cost. Direct sums can avoid the dense output-array trace while still using the same shared coarse arithmetic evidence.

## 4. The coarse dependency union

For each character let C_chi be the union of coarse indices used by its retained interpolation requests, plus retained coarse signs. Its cardinality satisfies

    |C_chi| <= min(J, w R_I + R_coarse),                      (6)

with any extra guard/source values added explicitly. For a conductor define Q_c=union_chi C_chi. For cross-conductor Hurwitz sharing define Q_global=union_c Q_c on the common exact height grid.

The coarse checker still pays

    sum_(j in Q_global) C_lat(t_j)
      + sum_c sum_(j in Q_c) [actual residue construction
                               + selected character circuit at(c,j)]. (7)

If a full group transform is checked at(c,j), it supplies all its rows. Recomputing that source proof per character is unnecessary. If only a few rows are requested, a separately certified direct row contraction may be cheaper. Refining a row cannot remove the uncertainty in its shared residue inputs. These choices are the same source/error-sensitive crossover as in the frozen report.

The union Q_c can equal the whole coarse grid even when R_I is a small fraction of dense refined nodes. This can be checked deterministically from the requested integer neighborhoods. For example, if the coarse centers of successive requested targets have gaps at most w, and the first/last neighborhoods reach the block edges, their neighborhoods cover the block. No zero-spacing conjecture is involved. Across many characters the union can fill even when each individual union is sparse.

Therefore a selected-sign strategy must not multiply the entire spectral cost by the retained fine-node fraction. It may save mostly interpolation gates and output storage, while leaving lattice/character-transform work unchanged. Formula(7) exposes exactly when additional coarse savings really occur. It also keeps the cross-conductor lattice proof shared after pruning requests.

## 5. Turing overhead cannot be inferred from main zeros alone

For a conjugation orbit use a rational main top T>=H(c), T>50, and auxiliary width h>0. The accepted closed-count adapter gives

    C_chi(T) <= U = [A-W+2B]/h,
    A = integral_T^(T+h) 2theta_a(t)/pi dt.                  (8)

B is the single-channel Turing allowance; both chi and its inverse occur. W is the sum of certified auxiliary lower weights T+h-v_i from sign intervals(u_i,v_i) inside(T,T+h), with the prescribed real-character factor two. Main sign brackets and exact central evidence give a lower integer K. Acceptance requires U<K+1; it never assumes C_chi(T)=K before this test.

The current elementary paper route permits

    B=42+(693/100)log(c(T+h)/(2pi)).                          (9)

The canonical phase integral and(9) are shared for equal conductor, parity and endpoints. Auxiliary signs, interval weights and saturation are distinct character-orbit obligations. A sharper Turing theorem could reduce auxiliary work, but its analytic library is a separate cost and cannot be imported as an unproved numerical constant.

There is a precise way to expose the overhead. Write

    I_S = integral(S_chi+S_inverse),
    I_aux = integral [A_chi(T,t]+A_inverse(T,t]],
    D_aux = I_aux-W >=0.

The exact integrated identity is h C_chi(T)=A+I_S-I_aux. Hence

    U-C_chi(T) = [2B-I_S+D_aux]/h.                           (10)

Since |I_S|<=2B, a sufficient upper bound is(4B+D_aux)/h, not2B/h alone. If every auxiliary zero is represented once with its actual multiplicity and appropriate channel factor, D_aux is at most the weighted sum of bracket widths. Missing auxiliary zeros add their true positive weights; a narrow width for located zeros does not bound those missing contributions. A zero at T+h has zero integrated weight. The count at T is closed and retains any zero exactly there.

Thus h>4B is only one part of a sufficient planning condition. One still needs enough auxiliary weight, localization accuracy and valid main saturation. Actual acceptance computes(8) directly and can succeed under less conservative circumstances; it does not need a separate claimed bound on the unknown D_aux. This distinction prevents a cost model from assuming that increasing h guarantees success.

Let k_aux be the number of actual auxiliary sign brackets requested per positive channel, and C_aux their chain count. Their endpoint cost is k_aux+C_aux by the same graph argument. Add direct central checks, proof of any exact multiplicity and all phase/count arithmetic. Main and auxiliary neighborhoods can share coarse values when their domains overlap, but brackets cannot be counted twice. Work at T+h and guard extensions is extra to the frozen nominal H-grid inventory.

A leading-density screen suggests auxiliary signs scale with h/H relative to main signs, but h is set by the allowance and actual deficit, not by a fixed fraction of H. For high conductors the main heights are only hundreds, so an auxiliary interval need not be a negligible correction. No historical auxiliary percentage or guaranteed small deficit is assumed.

## 6. Whole-family checker and generation costs

For each character segment l, let S_l be its accepted requests, p_l their required precision, and m_l the interpolation cutoff. A correct symbolic checker objective is

    C_check = C_manifest + C_seed_union + C_root/phase
            + sum_l min(C_direct(S_l), C_polyphase(S_l),
                        C_sound_direct_function_repairs(S_l))
            + C_Turing + C_coverage + C_retained_IO.           (11)

The minimum in(11) means a chosen sound circuit whose full prerequisites are included. C_seed_union depends on those choices, so this is a joint DAG optimization, not a sum of independently minimized local formulas with a fixed seed bill. It is not permission to mix unmatched coarse functions, different root phases, or missing error allocations. A mixed circuit can be cheaper than any all-direct/all-dense choice; its dependencies form a shared DAG and are charged once. C_Turing includes auxiliary source work unless already in C_seed_union, as well as exact weight/count comparisons. Avoid double charging that same arithmetic.

In contrast, native generation pays every attempted lattice, transform, interpolation level, direct repair, phase refinement and failed count window. It can search using dense FFT interpolation, then emit a sparse accepted record. The verifier need not reproduce the search or prove every discarded approximate sign. It must independently justify each retained sign and all source dependencies, the actual character labels, bracket disjointness, closed coverage and count saturation.

The number of positive channels is not halved merely by pairing characters. Pairing shares negative-ordinate evidence and the final orbit count. Principal c=1 keeps its different count/pole formula and is excluded from this family supplement. Per-orbit constants and setup can be shared; per-character signs are not interchangeable.

No fixed precision follows from a count of requested endpoints. Strict signs require a margin larger than their complete error, and very close zeros can force finer locations or higher precision. Analytic tails must be refinable too. A fixed additive approximation floor cannot be overcome by increasing arithmetic precision. Ordinary sign saturation may fail on multiple critical zeros even when finite RH is true. The checker is conditionally sound, not guaranteed to finish for every true target.

## 7. Consequence for the next checker design

The receipt should carry the selected bracket graph, exact endpoint/function identifiers, auxiliary weights and a dependency map to coarse samples. It should permit either direct finite interpolation or a checked convolution block for any requested subset. A cost pass can then compute the actual neighborhood union and compare(5), retaining shared seed/character circuits. This is the minimum information needed to demonstrate a checking reduction rather than merely a smaller list of final signs.

The first useful future comparison is the same accepted small count packet checked in two ways: dense interpolation replay and selected-sign replay, with identical coarse inputs, actual arithmetic bit sizes, source errors, auxiliary data and completeness result. That would measure the interpolation share which can be removed. No such run is authorized or performed here. Until that share and the dependency union are known, the justified claim is a possible material reduction of interpolation/checking work, not a multiplicative reduction of the entire family cost.

## Pinned mathematical inputs

The source-function and error interfaces are the frozen reduced-family report cited above. The count derivation is `FAMILY_PRODUCTION_ENDPOINT_ADDENDUM_2026-11-11.md`, SHA256 `6759192EED071A69B064D793CA307FD563BCB436ACCFB28238C77C5AB74E87F4`, together with `FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `740840E7576E988AF4C8F8053030BE59EB4EA18DE8C7E0D6B391BF7C9B1C5DEF`. Their paper review is `../major-constants/REVIEW_FAMILY_PRODUCTION_COMPLETENESS_PLAN_2026-11-11.md`, SHA256 `3033D761A2FE3F1B140A750CD1261D640EF8D1E98FA81711A438EB899A8AFE58`.

Allowance(9) is the paper assembly in `../integration/ELEMENTARY_TURING_PAPER_ASSEMBLY_2026-11-11.md`, SHA256 `72275B5CBA95FDD4F933C2150399C214B2509D9EF91D08A494104466DC8D597C`. These remain analytic/checker formalization inputs, not newly discharged finite spectral certificates. This supplement uses their mathematical contracts, creates no new premise, and leaves all frozen artifacts unchanged.
