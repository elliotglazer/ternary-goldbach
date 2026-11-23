# Review of the fixed three-product transform refinement

2026-11-11. **PASS at paper implementation-refinement scope; no correction requested.** Exact signed-integer internals followed by one rounding of each output coordinate supply the existing absolute complex-gate contract. This supports the stated operation categories at the same fractional grid, with the specified wider temporary storage. It is not a numerical implementation, proof of old-box containment, or runtime comparison.

## Inputs and independent evidence

The author is `zero-sum/FIXED_THREE_PRODUCT_TRANSFORM_REFINEMENT_2026-11-11.md`, SHA256 `087A3DF1B2DD49C5C0BB38E00DA9CD9830E41807C6F07A8BBB34502CFF65355D`. Paths here are relative to `work/qrh-campaign/agents`, except the coordinator operation budget under `work/qrh-blueprint`.

I read the full author note and compared its contract with the full frozen precision supplement, intermediate-width proof and coordinator operation budget. I also checked the previous three-product review, including its output-addition-width correction. All nine author dependency pins match. The retained independent evidence is:

| Artifact | SHA256 |
|---|---|
| independent-feasibility/review_fixed_three_product_transform_20261111.py | BF6ACEBE4779D772D12B755A407F31C650623F2E4E0A61803BD258A8B9B0BF21 |
| independent-feasibility/review_fixed_three_product_transform_20261111.json | 33F930C3745B0EC94ED3984F1BDBA25EF53C77F3712CDDC96E0E883A917A7059 |

The script performs 21 checks: author/dependency hashes, formal polynomial identities, rational norm inequalities and operation arithmetic. It imports no producer code and assigns no numerical complex values. The receipt retains every dependency pin. The central reused proofs are precision supplement `4AD43D7D2163A185BC05DFD7C3AC22237B58979BC3F139E79A69D414675F30F4`, width proof `5327CD0645A36F4081155D786FCEB43586559C1520A5A67CBAB2E68FBC77619A`, its independent review `A1D0815D5B186F0E07CCCFDD4EE3035D5E74D780CC4364ED49866AC30B56EF2F`, and additive-width erratum `AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362`.

## Center equality and rounding

With T=C(A+B), U=B(C+D), V=A(D-C), formal expansion gives T-U=AC-BD and T+V=AD+BC. Thus the new circuit forms the exact product of the same two stored centers. It uses no unit-modulus, independence or analytic assumption.

For grid h=2^-p, the numerator condition 2|N-Q2^p|<=2^p gives coordinate error at most h/2 after multiplying by h squared. The complex norm error is at most sqrt(2)h/2<=3h/4<=u. This is one rounding per coordinate after all exact internal operations; separate rounded real products would require a different proof. Signed ties must follow the declared deterministic rule.

Identical exact products and identical final rounding imply bit equality with a reference having that same rounding policy. Circuit induction then preserves every retained output. A reference that rounds four real products internally is different: satisfying the same absolute error theorem does not prove identical centers or containment in its immutable boxes. The author preserves that distinction.

## Cache uncertainty and Bluestein

The cached integers C+D and D-C must be exact sums of the original stored coefficient coordinates. Their analytic uncertainty is not zero, but remains entirely in the original coefficient radius. Expanding through the exact center product gives |w0|ez+|z0|ew+ez*ew; adding arithmetic error u is sufficient. Introducing separate independent interval errors at each algebraically correlated term is unnecessary.

If the cached sums themselves are rounded, their additional coordinate residuals are -b*errorC and a*errorD. Bounds etaC,etaD<=u/(8 max(1,M)), with M covering both input coordinates on every use, give each final coordinate error at most 5u/8. The norm is below u. This fallback does not inherit the exact-cache width claim without its own precision/alignment bound. A rounded data presum adds a further coefficient-weighted error and is excluded from the selected circuit.

The runtime multipliers in the specified transform are fixed roots, chirps or cached kernel coefficients. A Bluestein kernel is fixed with respect to the data line, not exact or unit-sized. Its true transform has norm at most 2n-1; the accepted setup bound eK<=PAu and safety PAu<=1 give stored norm at most 2n. The pointwise error nM*eK+(2n-1)*eF+eF*eK+u is unchanged by the exact center identity. Kernel setup precedes cache-sum construction, so the argument is not circular. Setup is paid once per actual cache key while its uncertainty is paid on every use.

## Width and cost conclusions

For coordinate magnitude caps below 2^a and 2^b, presums need a+1 and b+1 magnitude bits. T,U,V are below 2^(a+b+1), and their uncancelled output sums are below 2^(a+b+2). Output additions therefore operate at product widths. A sign and representation overhead remain separate.

The inherited product-of-norms bound K(c)(B0+1) also covers the nonunit kernel and the inverse FFT before division. In this fixed identity each real product is bounded by twice that quantity, and each uncancelled output sum by four times it. Consequently the inherited conservative three-product allocation 2p+b0+q+5, with q=ceil(log2 K(c)), suffices. Stored operands and presums retain their separate allocations. This uses a bounded common grid; small mantissas with arbitrary exponent gaps are not covered. The same-order pruned circuit inherits its bound through its retained dependencies, not through an unproved comparison of reordered circuits.

For the declared G and A, the runtime subtotal is 5,547,055,735,904,850 real products and 13,163,895,874,701,370 real additions/subtractions. The latter includes one data presum and two wide output sums per product, plus two real operations per complex addition. Two setup sums per distinct coefficient cache entry, rounding proofs, signed arithmetic, cache storage and provenance remain additional. Real-times-complex Horner gates remain separate. The symbolic saving of G products is therefore not a net cost or time saving without width-aware implementation prices.

## Remaining work

The refinement is mathematically sufficient to instantiate the already accepted transform gate hypotheses. It still requires actual input and coefficient enclosures, exact cache binding, signed arithmetic and rounding checks, capacity enforcement, and any required immutable-output containment. Kernel and root generation, analytic seed error, signs and completeness are unaffected. No Lean/MM0 build, transform or analytic evaluation was run; no frozen input was changed.
