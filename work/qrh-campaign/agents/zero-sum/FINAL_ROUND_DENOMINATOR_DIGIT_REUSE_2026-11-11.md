# Fixed-denominator proof reuse for residue output rounding

2026-11-11. Conditional paper arithmetic design and synthetic integer controls only. No actual coefficients, polynomial outputs, analytic values, primes, transforms or builds were produced. Frozen predecessors are unchanged. The optional b100 coefficient adapter is an explicit input, with its mixed-evaluator clarification; its separate review is not supplied by this note.

The general fixed-multiplier digit-table construction already exists in the reviewed `P27_FIXED_STEP_PROOF_REUSE` packet. The new specialization is its application to a conductor's final-round denominator, shared across both coordinates, all cells and all heights during a checked cache lifetime. It changes the proof of one exact integer product per coordinate. It does not change the numerical round, eliminate quotient discovery, or establish a faster backend.

## 1. Actual denominator and exact signed rounding

Under the b100/g100 adapter, an exact residue coordinate before final rounding is `I/(2^100 Q)`, where `Q=(2c)^19>0`. The output is `m/2^100`. Therefore nearest rounding with ties toward positive infinity is precisely

    m=floor(I/Q+1/2).

Prove one signed product p=mQ and one signed residual R=I-p. Acceptance is

    -Q <= 2R < Q.                                      (1)

Indeed (1) is equivalent to `m-1/2<=I/Q<m+1/2`, using Q>0. It proves the required coordinate radius2^-101. Both coordinate rounds give complex error below2^-100. At a negative or positive exact half tie, the included lower endpoint and excluded upper endpoint select the same ties-up rule. Zero needs its ordinary exact sign/decomposition case.

There is no need to prove `(2m-1)Q` and `(2m+1)Q` as two further general products. Once mQ is known, (1) uses subtraction, doubling and order. Q is even since c is a positive integer, so a separately proved Q=2q permits `-q<=R<q` instead. Neither version uses a modular congruence alone: congruence plus a claimed quotient without the signed range test does not certify rounding.

Q must be tied to the actual conductor by an ordinary power equality. The degree19, b=g100 cancellation, positive denominator and exact input numerator I must also be bound. The geometry-power cache from initialization may already contain this proof; it is common work only if that identity is actually reused. Otherwise construct and check it, for example with six exponent-chain products. A wrong c, power, grid or numerator cannot be accepted by a matching external hash.

The coefficient requantization is not free. Its source/error/grid certificate and20 complex rounds per distinct converted shared array remain. All-adapter evaluation has the1477u_H allowance; a mixed schedule with original-center Horner fallbacks retains the old1688u_H bound through subset weights. The digit table changes neither statement. A b122 variant has an additional exact power-of-two factor in its final divisor; it needs its own cancellation/shift adapter and widths rather than relabeling it b100.

## 2. Reuse the existing ordinary table lemma

Set beta=256. For one fixed positive Q, construct closed natural facts

    T[0]=0,  T[d+1]=T[d]+Q,  T[d]=Q*d,  0<=d<256.

There are255 checked wide additions. The product identity follows inductively from distributivity/successor arithmetic. These are actual closed numeral equalities in the chosen foundation. A table of unevaluated expressions `Q*d`, an unchecked machine array or a digest is not the required table of certified concrete results.

Let u=|m| and prove its radix-256 decomposition into digits d_(n-1),...,d_0, each below256. Start with the most significant digit's checked table value. For each remaining digit maintain prefix p and product V=Qp; a checked addition and the fixed prefix lemma give

    V_next=256V+T[d]=Q(256p+d).

This proves Q|m|. The ordinary signed-magnitude bridge then proves mQ, including m=0. All table references bind this exact Q, the exact next digit and the actual result term. The decomposition and final prefix must equal |m|; checking products for unrelated digits proves nothing about m. A radix shift is an interpreted digit constructor with an ordinary correctness lemma, not an unproved integer operation.

This is the previously reviewed P27 proof schema, specialized rather than re-invented. Only its fixed coefficient and cache ownership change. Product orientation may use the common commutativity lemma; its application belongs to the binding/sign overhead unless built into the chosen product interface.

## 3. Widths at the output, not at the largest difference state

The coefficient-grid adapter supplies a quantified margin preserving `|z'_j|<2^16`. At consumed |h|<=1/4, the quantized polynomial has magnitude below `(4/3)2^16`. Final coordinate rounding therefore gives

    |m|/2^100 <(4/3)2^16+2^-101 <2^17,
    |m|<2^117.

This uses the new coefficient theorem, not an unjustified assumption that rounding preserves a sharp old upper bound. Thus15 radix-256 digits suffice for |m|, including zero padding. Q has at most362 bits for c<=265800, so it needs46 digits. Table values satisfy `T[d]<2^370` and need47 digits. The final product and every processed prefix product are below2^479 and fit60 digits. The shift before the next addition is also bounded by the next prefix product, since all unsigned digits are nonnegative. No extra multiplication-width bound is obtained by assuming cancellations.

These60 digits use the proved bit bounds362+117; a generic46-by15-digit product without those sharper range hypotheses may need61 digits. The stronger bound must accompany the representation. Residual formation may use a wider signed temporary; cancellation in a small final R does not license a small subtraction operand. Digit decomposition, sign, final output and residual certificates remain charged at their actual widths.

Known powers of two in Q may be stripped before multiplying and restored by an exact shift. That optimization is available to both the direct and table methods. This note keeps the full-Q comparator for a matched simple schedule; it makes no claim against an optimized factored constant multiplier. Actual smaller conductors or shorter outputs likewise require their own matched sizes.

## 4. A limited ordinary-PA event comparison

Reuse the existing explicit macro-event skeleton `A(l)=2l+1` for a digit adder and `M(m,n)=5mn+2n+1` for a rectangular schoolbook product with n rows of m cells. Events are table uses or fixed algebraic lemma applications, not equal-time instructions or fully expanded MM0 commands. The ordinary byte digit library is a shared prerequisite with its own proof/setup charge.

For padded15-digit |m|, charge15 fixed-Q table lookups,14 additions of60 digits and14 prefix-fusion applications:

    T=15+14*A(60)+14=1723.

The matched full-Q rectangular schoolbook product costs

    M(46,15)=3481.

A conservative one-table setup is255 additions of47 digits,255 successor-product applications,255 saves and four base/final events:

    S=255*(A(47)+2)+4=24739.

The unsigned product subtotal saves1758 events per scalar use after setup. Its first strict crossover is15 scalar products, or8 complex outputs if both coordinate products are charged: `14*1758<=24739<15*1758`. This is only this declared skeleton. Leading-zero, zero-product or factored-Q shortcuts on either side change the comparator and must be counted explicitly.

This subtotal excludes terms/numerals, digit ranges and decomposition, argument unification, signs, residual and order proofs, input/output binding, table transport, storage and cache lifetime management. Some costs can be common, but that must be demonstrated. It is not valid to call every lookup constant-time, or to equate a theorem reference with an addition event in elapsed time. No ordinary proof implementation has been built here.

## 5. Full per-lifetime and end-to-end comparison

For objective t (native generation, proof production, proof checking, or a specified sum), let M_t(Q,m) price the complete direct product method and T_t(Q,m) the table product method with all its decomposition, shift, lookup and binding differences. Let S_t(Q) be full table setup and let E_t be additional terms, transport, storage and schedule costs. For a checked lifetime with scalar outputs m_i, the table route wins only if

    sum_i [M_t(Q,m_i)-T_t(Q,m_i)] > S_t(Q)+E_t.           (2)

Use actual charged schedules, or a new-cost upper bound against an old-cost lower bound for a robust conclusion. Unrelated upper bounds do not prove a speedup. The same residual/rounding work can cancel in (2) only because both methods establish the identical exact p=mQ and use the same residual certificate. Native determination of m by division is still required unless supplied by some other sound producer; table replay does not perform that discovery for free.

One table serves both coordinate products and all admitted cell/height outputs of the same conductor. It is independent of coefficients, F, anchor and height, unlike the coefficient-prescale and difference caches. Its key contains the exact conductor, power, Q, radix, signed/numeral interpretation and theorem identity. If a table is rebuilt r_c times, charge r_c complete setups. Data order may improve that reuse but adds any transpose, buffering or retained-source costs. There is no per-height setup in the mathematical identity and no assumption that an implementation achieves one global lifetime.

The prior MM0 source review establishes local saved-proof reuse and its reset at theorem boundaries. A local table disappearing at a reset must be rebuilt or reintroduced through checked global theorems. Persistent checked facts or closed table declarations exchange rebuilding for statement storage, import and instantiation; they are not free. Each independent shard/checker needs checked provenance for the facts it consumes. An unchecked checkpoint hash does not provide it. The 256 stored results alone have a conservative12032-byte raw digit payload, but proof objects, numeral tails, references and output state can be much larger. That payload does not prove a complete pack fits any stock limit.

Ordinary Lean kernel arithmetic already supports optimized numeral operations; direct integer multiplication and residual checking may beat explicit tables. A proved reflected checker or explicit table theorem is an alternative, not an automatic improvement. Native generation may also prefer a direct bignum multiply while producing table proofs for a different verifier. Evaluate generation, proof construction, checking, bytes and live memory separately. No additional axiom, native arithmetic oracle or trusted table rule is proposed.

To insert this into the residue break-even framework, replace only the final-round product subcomponent by its lifetime-amortized table price; retain the signed residual, comparisons, grid conversion, initialization, nonunit advances and all source-function obligations. Do not credit1758 as an end-to-end saving per output: it is a padded unsigned product subtotal per coordinate under one proof-template convention.

## Evidence and source boundary

This report read and reuses:

- `moebius/P27_FIXED_STEP_PROOF_REUSE_2026-11-11.md`, SHA `F578D50723A09A1580D6ACFBA4F6AEB93371AF81B7929121A9F402E0ED5A38D0`, and its independent review `F9E0EDCE65255FD912176E321606CA17E2854E3D23E78EBA36B6A4006858D4CC`.
- `prime-estimates/EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md`, SHA `DAA7F4625A1CCF8D9307AF59D1FA0C74416CCF38F9B87BBC8547C0F0D74836F3`, and the rectangular-template source `integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md`, SHA `3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227`.
- `integration/RESIDUE_COEFFICIENT_GRID_CLOSURE_2026-11-11.md`, SHA `9C2DA6DA76D44AF80C83AC34FD713A57054EEBA7344D6E0274EA548920A530C4`, with mandatory mixed-evaluator clarification `B620E1C26D8F4D1B9F0434CEBB7C121127EA2AD34F6807969CA21A724F468815`. Its b100 source interface remains conditional on that packet's separate acceptance.

Owned script `final_round_denominator_digit_reuse_20261111.py`, SHA `C0ADE08ECDFBDCFF23467DA2690B7C1F6F9AF4B2B9A606A0E8D75DDEB6AB4350`, and receipt `3E3147A9D7FABFC68361C8764450D5EB548C167BCC44A46D54B746FF8DA999A0` pass67725 exact checks. They include3102 synthetic signed products and16544 signed round cases, zero and half ties, all prefix identities and width/template arithmetic. Synthetic tables are not actual residue data or ordinary PA proofs. The general argument is the invariant and rounding equivalence above, not finite testing. No actual spectral obligation or runtime conclusion follows.
