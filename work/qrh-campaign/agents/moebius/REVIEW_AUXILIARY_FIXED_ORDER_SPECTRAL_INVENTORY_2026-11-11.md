# Review of the auxiliary fixed-order inventory

2026-11-11. **PASS as conditional schedule metadata, with no correction requested.** Author artifact: `zero-sum/AUXILIARY_FIXED_ORDER_SPECTRAL_INVENTORY_2026-11-11.md`, SHA256 `80DB1F3EF97114F332D4A23A96DFE585E234ACA87D01FC50234B95C1B576F186`.

I read the report, script and receipt, the relevant parent circuit definitions, and the reviewed auxiliary seed extension. A separate checker passed251051 integer/rational/pin checks. It computes no character, root, special-function, transform, prime-certificate or zero values. No build or frozen producer change occurred. The six rows are alternatives; none establishes spectral success.

## Count reconstruction

The large-conductor filter is exactly odd10000<c<=132900 or4|c with10000<c<=265800. Recomputing phi and the primitive count from prime-power metadata gives125400 conductors,7133015232 residue coordinates and4333246843 primitive outputs per extra height. The omitted small branch and principal case remain separate.

I independently formed each exact required H(c), computed the ceiling node index and verified

    H(c)<=5*(J(c)-1)/64<H(c)+5/64.

The maximum last main index is127988. For each h in10,20,30,50,200,250, dJ=64h/5 is an integer; adding indices J through J+dJ-1 extends the top by exactly h without duplicating the old endpoint. This also explains why one must multiply per-step sums by dJ, not multiply the old height-weighted totals by a common ratio.

For the five operation categories I reaggregated the already-reviewed fixed-order circuit definitions over the complete conductor set. All per-step sums and old J-weighted totals match, as do every added row, main-plus-auxiliary total and rational ratio. This validates the new aggregation; it is not a new independent proof of every parent FFT/pruning circuit. All inverse labels and original axis order are retained. The same dimension-dependent root/chirp/kernel index sets suffice at unchanged precision; actual enclosures at a new precision would be new work.

At h50 the checked added counts are4565129748480 residue inputs,2773277979520 primitive outputs,78618367161600 general complex products and162868318750080 additions/subtractions. These categories cannot be converted to common-cost instructions, proof bytes or time by this receipt. Phase projection, interpolation, signs, Gamma integrals and Turing acceptance are not included in the transform subtotal.

## Shared seed extension

The report correctly identifies that every added schedule crosses the old10000 ceiling. Its replacement schedule preserves the existing main seeds and introduces all new bases at the first added global height. For each row I checked

    V=10000+h, N=ceil((V+160)/3), D=8192,
    union=(N+1)D+1,
    new=union-27754497,
    added pairs=dJ*union,
    recurrence updates=dJ*union-new.

The subtraction accounts for new bases' first-use initialization. Initial leaves and step certificates are additional objects, not a deletion of those obligations. Coefficient slots dJ*(27D+20) and midpoint-shift updates dJ*330D also match. None of these counts includes the complete N-dependent seed evaluation or elementary proof cost.

For h<=200 the displayed scaled, shift, collapsed-error, magnitude and recurrence inequalities all pass. I additionally checked the uniform EM remainder216(N+2)/(255*2^128)<2^-116 and the enlarged elementary argument/phase domains. The h200 source argument is the reviewed V10200,N3454 extension, not an invocation of the old V10000 theorem without modification. Its proof is described in `zero-sum/REVIEW_R132900_POST_TRANSFORM_CERTIFICATE_COST_2026-11-11.md`, pin8A69A2954AB6903557476003A21F967ECCDC93AA47AF5A63BFFEFC9B5C2253F6, sections on the independent extension. Smaller rows satisfy the corresponding bounds with their own N; this is a domain implication, not generated interval data.

For h50 specifically, N3404 gives27893761 arguments,139264 new arguments and17852007040 added height/base pairs. The last index is128628 and top10049.0625<V10050. For h250 the fixed D8192 scaled-rising and P27-shift premises fail, as does the stronger11delta/16 recurrence allowance. The weaker recurrence bound below delta does not repair the two other failures. Its seed row is correctly marked hypothetical; a larger grid or revised proof changes costs.

Interpolation halos and precision repairs remain excluded. A last grid node need not have a strict sign, nor a useful positive auxiliary weight. The unchanged operation count does not establish that old tolerances suffice at higher heights.

## h50 and the newly reviewed allowance

The finite-Blaschke paper theorem gives b<121/4 when Z=log(cH_aux/(2*pi))<18. This is the author `independent-feasibility/FINITE_BLASCHKE_TURING_REFINEMENT_2026-11-11.md`, pinD9B3A7F28CA6EE49F203ECF1092F61E1FFD0DE79B017F0499A205EF2AD4A45DC, with integration review3488D80262797EE2C9E58D105C5AF31131C28DAD4EF2456C942B04C54F545E46. This review consumes their paper result; it does not reprove that analytic theorem.

The grid top can exceed the required H(c). The exact check therefore includes this overshoot:

    c*(T(c)+h)<128160000+265800*(h+5/64),
    (8/3)^18>[128160000+265800*(h+5/64)]/6.

Together with pi>3 and exp1>8/3 this proves the required logarithmic cap for all six rows. Their starting heights exceed50. It does not extend the theorem to the excluded principal character.

For the separately proved nonprincipal finite-RH surplus rule, write the actual measured deficit Ddef=(Abar-W)/h-K. Using the conservative allowance b=121/4 and h=50, the sufficient strict test is

    Ddef+121/100<2, equivalently Ddef<79/100.

The hypothetical bound Ddef<=1/2 would leave29/100 surplus. There are no K, W or Abar certificates in this inventory, so no character is shown to pass. The true theorem's strict b bound can offer endpoint slack, but this review uses the simpler conservative strict test above. The surplus rule establishes finite RH only under its critical-only K and full closed-count hypotheses; it does not certify an exact zero list, simplicity or a reciprocal-zero moment. A smaller analytic allowance alone supplies none of those data.

## Reproduction pins and limits

- Independent checker `moebius/review_auxiliary_inventory_20261111.py`: `3AB30AF93C918D07FD118C6618723BCE11D305AD1BAC8E8261242EAE3A6D4874`.
- Independent receipt `moebius/review_auxiliary_inventory_20261111.json`: `911E4F893F69DB472E02B415A23EB871002C2F72DF951568866979FA5F102632`.
- Author script: `863913C5B5ABEAA7F84E758D5B20AD900E51F8EE784A97B24642690DD76A892E`; author receipt: `8BEAD899428DE523323FCA7D833ECE6F4C5443213D32D4F32B964B18B218F7F9`.

The checker executes only the pinned integer metadata definitions before the parent row loop, then independently aggregates and checks the new formulas. It does not import any numerical evaluator or run the author's output-writing inventory. Full circuit correctness is retained from the preceding review. Actual enclosures, signs, auxiliary weighted counts, Gamma/count normalization, small/principal branches and final strict acceptance remain unfulfilled by these metadata.
