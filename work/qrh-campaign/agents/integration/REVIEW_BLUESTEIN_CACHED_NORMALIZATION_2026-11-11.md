# Independent review of cached Bluestein normalization

2026-11-11. **PASS at the stated paper/source and local arithmetic-model scope.** No correction is required to the frozen author packet or its context supplement. This review approves the conditional implication and representation distinctions, not a chosen production circuit, precision, aggregate saving or spectral result.

Reviewed inputs:

- `independent-feasibility/BLUESTEIN_CACHED_NORMALIZATION_RESEARCH_2026-11-11.md`, SHA256 `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9`.
- Author script `bluestein_cached_normalization_20261111.py`, `A0A26A3B03297871BE12B2DC4FC5F37006B071FED113CB325ACBDC6EFC0001F3`, and selected v2 receipt `E8403465E72AB99A94F7F210801CE6FE17CE6679E9AEF29EEFBC3492B642B793`.
- `independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md`, `412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7`.
- The actual mixed precision, intermediate-width and fixed-three-product proofs pinned in the independent receipt below. I read their error recurrences and cache premises, not merely their titles.

No author program was imported or executed. The independent companion performs formal polynomial identities, finite rational structural examples, dyadic rounding tests and local template calculations only. It creates no roots, transforms, character/source values, conductor inventory, unit list or new declaration and invokes no build.

## 1. Exact scaling and newly rounded scaling are different circuits

The exact convolution identity is valid for the unchanged positive/negative unnormalized transforms:

    D_minus(F*K)/P = D_minus(F*(K/P)).

It moves the convolution's internal factor only. It does not normalize the outer character transform or silently supply an extra factor1/n.

An old coefficient integer K_int on grid p represents its exact scaled value by the same integer on grid p+k, P=2^k. If point products and inverse operations also use p+k with corresponding nearest-round policies, every center is the old center divided by P. The integer numerator of the mixed-grid point product and the number of discarded fractional bits are unchanged; the same statement follows inductively for inverse root products and additions. The final conversion back to p is precisely the former division-round. Thus the bitwise-equivalence claim is conditional on those matching policies and final conversion. It is not a width saving. The independent tests explicitly compare rational round_grid operations under rescaling, including signed ties; they do not merely compare a quotient with itself.

Keeping an exact p+k cache but rounding runtime values to p is a new circuit. Rounding the scaled cache itself to p is another new circuit. In the latter, the old unscaled FFT cache remains a certified producer, and its error divided by P plus the new coordinate-round error gives `(A+1)u`. The new scaled center and its exact cached sums must be bound to that producer. Old cached sums, output boxes or sign successes cannot be relabeled.

## 2. Independent reconstruction of the error proof

Write n>=2, m=2n-1, P=nextPowerOfTwo(m), R=2log2(P)+4, A=1+3R, Q=3nPA+1, and V=M+1. The exact stored input bound M may be zero. The retained local safety gives PAu<=1, Qu<=1 and u<1/2. Since

    Q-P(A+1)=(3n-1)PA-P+1>0,

the scaled-cache error is strictly below1/P. Its stored center has norm strictly below `(m+1)/P=2n/P<=1`, including the boundary case P=2n. This is a coefficient-center magnitude bound; it is not a bound below1 on its norm plus one.

The point error compares the actual stored product against F*K/P. The independent decomposition is

    nM(A+1)u + (m/P)(PAuV) + (PAuV)(A+1)u + u.

The cross term is necessary. Bounding it with PAu<=1 gives exactly

    q*uV, q=n(A+1)+mA+(A+1)+1=3nA+n+2.

Also Q-q=3nA(P-1)-n-1>0. Hence q*u<=1, and the inverse input has augmented norm at most `Z_s V`, where `Z_s=nm/P+2`. This remains valid if a data or cache value is zero; no division by a computed value is used.

The negative inverse is unnormalized. It transports the point error with factor P, and its own radix error is `P R u Z_s V`. Thus

    e_I <= [Pq+R(nm+2P)]uV.

There is no final runtime division in this circuit. Omitting that factor P in the error would be incorrect. The final chirp contributes `(1+u)e_I+unM+u`. Dividing by n only for the local normalized error theorem gives the author's C_exact.

I checked the relaxation by clearing its denominator, obtaining the exact identity

    2n(C_new-C_exact)
      = R(27n-6P)+26n-6P-2.

Since P<4n and n>=2, both terms on the right are positive. After substituting A=1+3R, a separate formal expansion gives

    C_old-C_new=R(9P/2+n-10)-6>=74.

The last bound uses P>=4, n>=2, R>=8. Therefore the new circuit satisfies the old local C_old/D_old contract. The proof is general algebra; finite structural examples in either receipt are only checks, not a substitute for this proof.

CT composition can consume the unchanged old child pairs, including the ordered cross-term safety recurrence. The product-axis S bound also remains available without recomputing the schedule. Pruning retains the same full padded convolution and merely selects fewer final outputs. All character labels, permutations, chirp signs and exact normalization remain as before. Input uncertainty still passes through the exact linear operator separately; it is not absorbed into, or counted again as, the new intrinsic error.

The leaf n=1 is outside this proposal and remains the identity. The broader n>=2 proof covers mathematical small cases even when the selected circuit would use a direct or radix-two leaf instead. No occurrence of an illustrative n is inferred.

## 3. Width and context interface

The smaller peak theorem additionally requires `C_old*u<=1/2`, supplied by the inherited global `S_old*u<=1/2`. Local D_old alone is insufficient for that semantic output step. The final author and supplement explicitly retain this distinction.

For an occurrence with incoming augmented bound aV, the point output is bounded by Z_s*aV. At inverse stage j, indexed from0, the rigorous propagation is:

    input:        (2+u)^j Z_s*aV,
    root product: (1+u)(2+u)^j Z_s*aV,
    output:       (2+u)^(j+1) Z_s*aV.

The finite-binomial safety bound makes `2^(j+2)Z_s*aV` a common conservative allocation covering that stage's inputs, products and outputs. Keeping the exact j=0 input or separate input/output bounds is an optional refinement, not a premise of the displayed prices. The stored kernel coefficient has magnitude strictly below1 and therefore needs p magnitude bits on grid p. It is not a unit root with a newly invented root-error radius; its `(A+1)u` error remains in the point recurrence.

The unchanged forward/data and kernel-setup peaks fit `2PZ_s*aV`. For the final chirp, the local error formula gives inverse augmented norm at most `n(1+C_new*u)aV<=3naV/2`; multiplying by its approximate root and rounding gives at most2naV because u<1/3. Hence the sufficient new peak `K_new=2PZ_s=2nm+4P` covers all stored phases and unchanged kernel FFT setup. Root-enclosure generation is separately excluded, as in the original proof. Raw integer products, presums and witness additions still use their full pre-cancellation capacities.

This is a usable local interface for a successor structural fold. It is **not** a rule to subtract k from an old histogram exponent. The old inverse envelope `2n(n+1)+2`, the new `nm/P+2`, and rounded exponent keys are not invertibly related. A new fold must retain n, P, stage, exact outer norm multiplier, grid and coefficient type. The saved structural manifest/DAG/conductor rows can supply those contexts without new factor/axis generation. This review did not perform that fold or approve a new aggregate price.

## 4. Cost and setup obligations checked

Runtime forward transforms, point-product counts, inverse butterfly counts and final chirps are unchanged. Each selected runtime use removes P complex final dyadic divisions. Each new scaled cache adds P complex dyadic rounds per actual cache construction/lifetime. The old FFT cache is still built and certified. Two exact three-product coefficient sums must be rebuilt from the new rounded centers or proved equal to them; separately rounded old sums are not automatically interchangeable.

I independently reconstructed all twelve displayed local price examples from the stage formulas, both three-product rectangular multiplications and all center/round additions. I also checked the new scale setup and cold cached-sum differences. The examples use the same explicit conservative allocation rule on both sides, but their positive core differences do not dominate a tighter original implementation or measure runtime. The strongest reviewed original local-width comparator should be used for any later full comparison.

The decision inequality `U*(R_old-R_new)>S_extra` is correctly scoped to complete per-use and lifetime prices. It includes signed/range/binding proofs, numeral/shift work, cache enclosures, construction/loading/storage and rebuilds. Generation, proof production and checking require separate prices. Power-of-two rounding uses shifts and exact residual witnesses, not a generic quotient product; this does not make its proof or memory traffic free.

The conditional projection of 88576420247296 main runtime divisions and 337702368 existing cache entries is a reuse of the pinned original ledger, not a new inventory. It applies only if all relevant caches/uses are converted and precision/lifetime duplication is paid. None of the p112/134/152 examples is a selected full sign budget. Their intrinsic allowance is separate from input, conductor, phase and interpolation error.

## 5. Independent evidence and verdict limits

Own script `integration/check_bluestein_cached_normalization_review_20261111.py`, SHA256 `9FD28B94E91B3526BF0BFF336FE8A8BDD2008E03DAA31165C17C893338FBF5C3`; receipt `integration/bluestein_cached_normalization_review_20261111.json`, SHA256 `9046EE071C9C31DE147CA5D7C13696A5F0F6728D5ABF905D3768FAD5C5A6BFA0`. It passes1693 independent exact checks, including the two formal polynomial identities, all author scalar/example records and rational signed grid-rounding commutation. Exact source pins are recorded there; the additional context-supplement hash is bound explicitly above and was read in full.

The scoped verdict is PASS with no correction. Remaining implementation obligations are actual cache/root certificates, ordinary arithmetic and round proofs, a reviewed context reassociation before any global width pricing, complete error budgets and new sign/completeness evidence for changed centers. No spectral acceptance, aggregate saving, production precision or runtime winner follows from this review.
