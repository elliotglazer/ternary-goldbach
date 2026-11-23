# Review of residue state normalization

2026-11-11. PASS at conditional exact-arithmetic and metadata scope, with no correction required to the final packet. This review binds independent-feasibility/RESIDUE_POWER_TWO_STATE_NORMALIZATION_2026-11-11.md, SHA256 `EFB31BE5B3A556CE88A29B1E566ACB86E026F7C9E3E778F67F5B81453914F004`, its script `4AFA4EC5A7FEE7751EFAA491C57604DA7B21C07CF0A8D3D120FD118D990B01D8`, and final receipt `0AE9F335B08532673C20230B71B2D9868A770A641782302B202DC7104E48D682`.

I read the full final note, script and relevant predecessor proofs. I independently reconstructed the state identities, raw bounds and height-clipped classes. The author program was not executed or imported. No actual polynomial coefficients, analytic functions, character values, prime or zero data, transforms, or builds were evaluated. The result permits the proposed exact representation; it does not select a runtime winner, an occupancy replacement set, or a new spectral certificate.

## Exact object and cancellation

The domain retains degree19, the delivered grid F=2Dout, the original ties-down cells, c>10F, and an explicitly bound common dyadic coefficient grid. In particular final source D4096 does not replace delivered Dout8192. The optional b100 adapter remains necessary when that grid is selected. A bound on coefficient error alone does not prove grid membership.

For c=2^s w with w odd, the largest common power of two of 2c, F and kc is 2^t, where t=min(f,s+1,s+nu2(k)). The even-anchor formula handles k=0 without taking a finite valuation of zero. Direct reduction of q=Fa-kc, v=2c and F gives integral q',v',F'. Each homogeneous degree19 term has the factor 2^(19t), so numerator, denominator and every completed difference have that factor. This is independent of coefficient signs and cancellation.

The partial Newton polynomial of degree i has only the factor 2^(it). The report correctly generates reduced prescales n_j v'^(19-j); it does not divide every old prescale by 2^(19t). Cells and all numerator advances are preserved, including nonunits.

For unit outputs, the additional power occurs exactly at s=f with odd k. Then q'=a-kw and v'=2w are even, but the all-numerator step F'=1 prevents this from being a common state factor. A separate output-only adapter can remove the resulting factor 2^19. It cannot justify skipping intervening numerators. Horner has the same target fraction reduction, so its comparison must use the reduced factors and denominator too.

## Integral scaled states and raw arithmetic

The substantive identity behind both recurrences is

    Delta^j[(q0'+F'n)P(n)]
      =(q0'+F'n+jF')Delta^jP(n)+jF'Delta^(j-1)P(n).

It follows by the finite-difference product rule, or by the binomial basis. With lambda_j=j*delta+nu2(j!), division of the second coefficient by 2^(lambda_j-lambda_(j-1)) leaves oddpart(j). Thus the stated top-first, descending Newton updates construct integral normalized states directly. Their invariant is Delta^j J_i(0)/2^lambda_j at every partial degree. Ascending traversal then uses 2^(delta+nu2(j+1)) times the old next state. Its order is essential: initialization and traversal cannot use the same in-place direction.

Replacing 2^lambda_j by F'^j j! gives the second integral recurrence, with a copy at the new top and coefficient1 on the lower state. Its traversal coefficient is (j+1)F'. Neither circuit requires a concrete division by a factorial at every step. This does not remove the obligation to prove the invariant and each actual integer operation in the intended ordinary proof system.

I checked the bounds against the accepted c>10F extension. Supporting polynomial arguments can leave the cell, but satisfy |h|<6/5 through the required19 offsets. The finite degree19 geometric sum gives the 256C bound; the old c>20F bound4C is not used here. The actual analytic approximation remains needed only at original in-cell unit targets.

Dividing the difference bound by the order factor gives 256C*2^(j-lambda_j)Q'. The two unadded interior Newton products sum to at most

    256C*2^b*v'^i*(1/4+3j/40)*2^(j-lambda_j).

The top and zero-order insertion satisfy their separate bounds. For traversal the shifted higher-order operand is bounded in the lower-order scale, giving twice the lower-state bound; the raw sum has factor3. Therefore the smaller stored width is not silently reused for a wider shifted operand.

The reported exponents above Q' check: power-only stored/Newton/traversal are28/29/30 for delta0 and24/24/26 for delta>=1; full-factorial gives25/24/27 and24/24/26. These follow from finite maxima, including j-nu2(j!)=popcount(j), not from a cancellation after an oversized product. Signed capacity b+bitlength(v'^19)+e+1 is sufficient. Partial degrees and prescales fit these capacities; input decoding or coefficient conversion can still require wider operands and is separately charged.

The full-factorial addition comparison is deliberately narrow. Its initializer saves167 specified binary-scale additions, while each advance adds21 of them. Thus L<=8 and L>=9 give the stated opposite preferences only under equal addition prices. Copies, shifted operands, setup, different widths and proof transport prevent that comparison from deciding the actual cost.

## Final output and fair checking costs

Order zero has no extra order normalization. For output grid g100 and b>=100, the denominator in the one-product signed residual is D=2^(b-100)v'^19. The inequality -D<=2(I'-mD)<D is the correct nearest rule with ties toward positive infinity, including negative ties. Exact state arithmetic introduces no new numerical error. It preserves the underlying polynomial and the inherited final-round error bound, without asserting equality with the old rounded Horner centers.

The factorization D=2^r w^19 allows a product proof for m*w^19 followed by a proved shift. It does not allow dividing I', dropping low bits, or narrowing the full residual without evidence. This optimization applies equally to direct multiplication and a digit-table checker. A table for the odd core can share only with exact core, radix and theorem binding. Full-denominator tables have different keys. Import, lifetime, eviction, storage and proof costs remain explicit; the old full-Q table subtotal is not transferred automatically.

The complete comparator therefore remains reduced Horner's19 rounded stages per consumed unit against reduced initialization, all required advances, final rounds and bindings. The inequalities must compare charged schedules at their actual widths, separately for generation, proof construction and checking. No runtime or proof-size saving follows solely from these bit and addition counts.

## Corrected height metadata and independent evidence

The final packet correctly uses the combined-height source6143FA84: the odd slope has531600/c and the even slope1063200/c, with height floors440 and455. The further ceiling to the5/64 grid is retained. Inverting the ceiling gives the strict conductor cutoff ceil(A/(required_height-201))-1 when the required height exceeds its floor.

My independent enumeration over the structural conductor family reproduced every valuation class, endpoint, width entry and summary. Counts for bands1/2/3 are respectively125220/91246/9696 at main,125220/96464/10051 at+167,125220/100938/10546 at+320, and125220/115221/11922 at+640. Bands4 and5 have none satisfying this guard and height intersection. These are conductor-band eligibility counts, not weighted work, units, occupied cells, primitive labels or savings. Both anchor-parity bounds are conditional cases; the class counts do not establish their actual frequency or price.

The earlier draft's even slope was wrong. It was corrected before this final acceptance. The preserved preliminary receipt33BBAA6C is explicitly withdrawn. Frozen occupancy99B76FC was already correct and requires no erratum; the author's clarification33B70DAB records this distinction. My review does not treat the preliminary receipt as evidence.

Owned checker `review_residue_power_two_normalization_20261111.py`, SHA256 `EC1644E9FC90D372CDD3542DBB57D1BA225B15BD255B64690235C6116CFE72CB`, and receipt `review_residue_power_two_normalization_20261111.json`, SHA256 `A0E0D66F8D0CC48254046157F5FC19ADB42BC37430016DABA56948898AE0C090`, pass280021 exact checks. They verify all eight input pins,6270 formal state comparisons against the closed Stirling expansion, raw factors, gcd/output-only valuation controls, and the independently enumerated classes. Coefficient numerators remain indeterminates throughout the polynomial checks. The script accepts the three reviewed author paths as arguments and records their exact hashes in the receipt.

The accepted outcome is a source-bound exact state representation with proved smaller sufficient capacities and two explicit traversal choices. Concrete source-grid certificates, selected occupancy schedules, ordinary arithmetic proofs, cache implementation and full width-sensitive prices remain open.
