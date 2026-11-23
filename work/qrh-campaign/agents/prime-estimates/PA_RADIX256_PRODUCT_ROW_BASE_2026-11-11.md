# PA row and base interfaces for the rectangular product

2026-11-11. Paper proof and static syntax/source checks only. No MM0/MM1/Lean declarations, proof emission, byte enumeration, arithmetic instances or builds. This note preserves the ordinary final statement x*Ytotal=Z and all frozen predecessors.

Two macros per row and one initial macro can cover the product's algebraic core. The two row roles must be explicit: an inner higher-tail base and an outer invariant update. On the last row, a terminal update replaces the ordinary update and concludes the actual product equality. The outgoing outer range is exported in a conjunction, so it is not silently recovered from an earlier theorem's internal proof.

This does not close the full 5mn+2n+1 acceptance cost. The stated macros consume exact numeral, prefix, power and final-output bindings and separately proved byte bounds. Their producers, expression conversions and source transport still need a concrete implementation and full cost. A row identity with unchecked bindings is not an arithmetic certificate.

## 1. Shared conventions and the exact state

Use the cell packet's fixed PA term beta, eight nested `b0` applications to `d1`, with mathematical value 256. Its positivity and numeral conversions are once-proved library work. No hex sort, coercion axiom or native multiplication is used.

The positive branch has x>0, an m-byte representation of x and an n-byte representation of the multiplier, with m,n>=1. At row i, P represents beta^i, Y is the already consumed multiplier prefix, l is the already produced low result, and A is the remaining product carry. The state proposition is the following fully expanded conjunction:

    I(x,Y,l,P,A) :=
      (l+P*A=x*Y) AND (A<x AND (l<P AND 0<P)).        (1)

I is an abbreviation in this paper, not a new declaration or a trusted predicate. The order and association of the three conjunction heads are fixed. The next row consumes the exact whole proposition returned by the previous row. Its internal projections and the next state's conjunction introduction are part of the generic row theorem's proof body.

The row digit is y<beta. The cell chain computes a natural B and low output digit d through the exact equation

    E: (x*y+A)+0 = beta*B+d.                         (2)

The digit d<beta is separately proved; the cell equality alone does not establish it. Equation (2) is the lower cell's output when its incoming carry is literally zero and its source-tail terms have been bound to the exact x and A expressions. The zero is retained in the signature so no uncounted caller-side zero-removal step is assumed.

## 2. Four proposed signatures

These are mathematical specifications of reusable PA theorems. None has been emitted or kernel-checked here.

**Inner tail base.** Natural arguments y,c; no premises; conclusion

    ((0*y+0)+c)=c.                                  (3)

It supplies the higher-tail equation for the most significant cell. Its proof uses zero multiplication and zero addition. A generic theorem is proved once, but its instantiated application and exact c expression still cost work on each row. No c range is returned by this theorem.

**Initial outer state.** Natural argument x; one premise 0<x; conclusion

    I(x,0,0,1,0).                                  (4)

Zero products and additions establish the equality; the other three components are the premise, 0<1 and 0<1. Their repeated occurrence in the conclusion is intentional. One may share subterms/proofs in an implementation, but the static unshared count below does not assume it.

**Intermediate row update.** Natural arguments

    x,Y,l,P,A,y,B,d,Yn,ln,Pn                        (11 arguments).

Seven proof premises are:

    I(x,Y,l,P,A), E,
    y<beta, d<beta,
    Yn=Y+P*y,
    ln=l+P*d,
    Pn=P*beta.                                      (5)

The conclusion is I(x,Yn,ln,Pn,B). The three binding equations are proofs, not native assignments, unverified pointer associations or arbitrary witnesses. This version uses independently saved whole expressions for the next state. Replacing them by literal compound terms would change the signature and the representation schedule; it does not automatically establish equality to the actual numeral objects.

**Terminal row update.** Natural arguments

    x,Y,l,P,A,y,B,d,Ytotal,Z                        (10 arguments).

Four proof premises are:

    I(x,Y,l,P,A), E,
    Y+P*y=Ytotal,
    (l+P*d)+(P*beta)*B=Z.                           (6)

The conclusion is the original target x*Ytotal=Z. The last two equations must bind the actual supplied multiplier and product numeral. This theorem does not assert a new state or need d/y bounds for its equality proof. Their required source-digit/cell-table validity is still part of producing E. Omitting unused final range premises is not permission to bypass those earlier checks.

For n>=1, run the intermediate theorem n-1 times and the terminal theorem once. There is no separate, uncounted terminal extraction macro. The terminal theorem consumes a stronger final-output binding instead, whose production remains explicitly charged.

## 3. Proof of the intermediate and terminal updates

Project the equality in I. Remove the explicit zero in E within the generic proof, commute x*y+A to A+x*y, multiply E by P, and use associativity/distributivity:

    (l+P*d)+(P*beta)*B
      = l+P*(beta*B+d)
      = l+P*(A+x*y)
      = (l+P*A)+P*(x*y)
      = x*Y+x*(P*y)
      = x*(Y+P*y).                                 (7)

The commutation of P and x in the fourth step is a multiplication identity, not a premise. Each line follows from the pinned PA equality/congruence, commutativity, associativity and distributivity lemmas listed below. Equation (7), together with the three equalities in (5), gives the new equality component. Together with (6), it gives the terminal product conclusion directly.

The intermediate update must also prove all three range/positivity components. From A<x and y<beta, natural discreteness gives y+1<=beta, hence

    A+x*y < x+x*y = x*(y+1) <= x*beta.

From E, beta*B<=A+x*y. Therefore beta*B<beta*x, and the positive-radix strict multiplication theorem gives B<x. This derivation uses no division and does not depend on an incoming theorem having internally proved a carry range.

Likewise l<P and d<beta give

    l+P*d < P+P*d = P*(d+1) <= P*beta.

Thus ln<Pn after substituting the bindings. Finally 0<P and 0<beta imply 0<Pn. Conjoin the equality, B<x, ln<Pn and positivity in exactly the association (1). This proves the full proposed conclusion.

The final theorem uses only (7) and its two bindings; it need not derive an unused final B<x or output-low range. Those facts may be useful elsewhere, but exporting them would require a changed conclusion or another theorem application, with its own cost.

## 4. Exact cell/row linkage and every range dependency

Within a row, write

    X_j=beta*X_(j+1)+x_j,
    A_j=beta*A_(j+1)+a_j,
    B_j=X_j*y+A_j+c_j.

The reviewed cell theorem turns the already proved higher equation for B_(j+1), with c_(j+1) as its k argument, into B_j=beta*B_(j+1)+d_j. At the top, X_m=A_m=0 and (3) supplies B_m=c_m. The producer may discover carries from low to high; acceptance proves the supplied chain from high to low. At j=0 the incoming carry is exactly zero, and the high-tail result B_1 is the B in (2). It includes the remaining digits and the last carry. No assumption that the last carry vanishes is made.

The cell theorem still consumes x_j<beta, y<beta, a_j<beta and c_j<beta at every cell. Its conclusion does not export c_(j+1)<beta. The chosen conditional interface obtains every concrete digit/carry bound from separately proved closed-byte range facts tied to the same exact natural expressions. Cache sharing can avoid repeated applications only when those proofs and expression objects are actually retained. If a parameterized digit-decoder or carry-bound theorem is used instead, its arguments, premises and applications replace this closed-fact model and must be counted.

The full-adder table outputs' bit ranges and digit ranges, including the row's d_0<beta, are also required. A table equation is not a range proof. They may come from the same separately proved range library or a deliberately bundled table interface with revised statement and command costs. Neither alternative is free. The outer A<x bound is different: it is exported explicitly by the intermediate row bundle and consumed in the next bundle, with no caller-side projection macro. A<x alone does not produce a concrete padded byte decomposition of A.

For unequal lengths, keep m cells in every row and n multiplier digits. Since A<x and x<beta^m, A fits m bytes, so a supplied correct representation may be padded with high zero digits. Existence of such a representation does not check the supplied one. Exact decomposition equalities, length, order, each zero padding and its digit bound must be proved or built into a conservatively defined numeral fold. The original x representation must bind to the same x on every row. No out-of-range or skipped digit is admitted by the algebraic state theorem.

The natural low-prefix view is source-faithful. Starting Y=0,P=1 and using the checked bindings Yn=Y+P*y and Pn=P*beta gives Y equal to the consumed low multiplier prefix and P=beta^i. The existing `pow0` and `powS2` support that induction if the implementation also stores explicit powers. To use y mod beta^i instead of the prefix equations requires its own proved division/remainder adapter. This packet uses the equations directly and never treats a native remainder as proof.

At the final row, Z is the concatenation of the n produced low digits with the surviving high carry. Equation (6) is its exact natural interpretation. Constructing it may require a numeral concatenation proof or a finite fold over the actual bytes. It is not supplied by the abstract cell theorem, and an arithmetic proof of it by recomputing a large product would have its own cost. Exact term sharing can help, but pointer identity cannot replace a missing semantic equality.

## 5. Zero cases and inclusive loop boundaries

For the nonzero branch, m,n>=1, cells are j=m-1 down through 0 in each proof replay, and rows are i=0 through n-1. The terminal specialization is used exactly on row n-1, including n=1. Leading zero multiplier digits are allowed if their represented input length and final Ytotal binding are checked. No optimization deleting those rows is credited.

If x=0, the source's `mul01` proves 0*Ytotal=0. Binding an arbitrary supplied x or Z to that zero term still requires their actual equalities. This branch does not use the positive outer state, whose A<x component would be false for A=x=0. For an empty multiplier representation with Ytotal=0, `mul02` gives x*0=0 with the same binding qualification. Alternatively a fixed nonempty representation of zero can follow the ordinary positive-x row path. The 2n+1 formula below is asserted only for its stated m,n>=1 positive-x path, not for an empty-loop encoding that omits the terminal theorem.

No accepted multiplication is inferred merely from the witness list lengths or a native product calculation. The final equality has the original x, Ytotal and Z objects, not aliases with unproved interpretations.

## 6. Source proof map and syntax prices

All named interfaces are in the pinned `work/mm0-efficient/toolchain-sources/examples__peano.mm1`.

|Lines|Existing facts|Role|
|---|---|---|
|488–496|`anl`, `anr`, `anli`, `anri`, `iand`, `iani`|State projections and conjunction construction inside the proved macros|
|874, 903–905, 920–922|Equality transitivity variants|The fixed chain (7) and binding substitutions|
|2034–2050|Natural addition/multiplication congruence and variants|Substitution in arithmetic contexts|
|2057–2153|Zero/one, addition and multiplication associativity/commutativity, `muladd`, `addmul`|All base and row identities|
|2191–2245, 2252–2283|Additive lower bounds, natural monotonicity, strict transitivity and successor order|Row range estimates|
|2380–2396|`ltmul1`, `ltmul2`, `lemul1`, `lemul2`|Cancel positive beta in the strict carry bound|
|2409–2413|`mulpos`|New-place positivity|
|2693–2743|`eqdivmod` and quotient/remainder lemmas|Optional downstream interpretation, not an assumed cell result|
|3011, 3026–3031|Natural `b0` and its multiplication/nonzero facts|Fixed radix interpretation|
|4999–5003|`pow0`, `powS`, `powS2`|Optional explicit power-position invariant|

The compound I expression is expanded in the proposed header counts, so no undeclared trusted state predicate shortens them. The static script counts existing binary arithmetic/logical heads, variables and constants. It preserves the b0 and d1 definition heads, making the fixed beta term nine unshared nodes as in the cell packet.

|Macro|Natural arguments|Proof premises|Unshared header commands|Cached-conclusion call|Fresh-conclusion call|
|---|---:|---:|---:|---:|---:|
|Inner base|2|0|10|4|12|
|Initial outer state|1|1|26|4|24|
|Intermediate update|11|7|120|20|40|
|Terminal update|10|4|80|16|20|

The header column includes UHyp per premise and one END, following the reviewed source stencil model. The cached call is a+h+2. The fresh call assumes all leaf terms and premises saved, creates the full conclusion without internal sharing, then applies the theorem. It is a+h+size(conclusion)+1. These counts exclude constructing premises, library bodies, conversions, binding producers, external expression storage and enclosing proof termination. They are possible command schedules, not emitted streams or timings.

## 7. What the two-per-row count now means

The conditional arithmetic-event core on the positive nonempty path is:

    4mn table uses + mn fused cell applications
      + n inner bases + (n-1) intermediate updates
      + 1 terminal update + 1 initial outer state
      = 5mn+2n+1.                                  (8)

This identifies the previously unspecified row/base roles. It does not establish that those are all operations in a valid certificate. In particular the following remain additional named costs:

- establishing all concrete byte/bit bounds, exact input decomposition, padding and carry bindings;
- proving the intermediate Yn/ln/Pn equations and the final Ytotal/Z equations in the chosen numeral representation;
- any optional power, quotient or remainder representation adapters;
- constructing and sharing the exact terms, statement headers, premise references and source-bound final theorem;
- global PA byte-table and generic-library proof generation/checking, local cache reset/reload, heap/store fitting and the full foundational translation.

The initial x>0 proof is also consumed, not assumed from an untrusted producer's branch label. At no point does a structural encoding make a required equation true without proof.

The now-specified core also sharpens the reviewed connected proof-DAG formula. Let D count only newly applied CLOSED zero-argument, zero-premise facts. Let C be the total constructor-child requests, including the actual new input/premise/conclusion expressions. With other proof producers external or separately added, the core has

    V=mn+2n+1+D,
    H=9mn+7n-2,
    R=16mn+15n+1+D,
    commands including END = H+R+C+2
                           = 25mn+22n+1+D+C.        (9)

For the earlier 13-by-3 example the last expression is 1042+D+C, not 202 commands. The terminal replacement lowers the general intermediate-row signature contribution; no standalone final extraction is charged twice. The formula assumes the legal connected first-use proof-DAG schedule of the reviewed MMB report, with every exact premise edge represented.

D does not absorb parameterized binding/decoder/range lemmas at unit cost. Such nodes contribute their actual a+1 expression-root requests and premise edges to R and H, plus their new terms to C. Closed ground binding theorems could be counted in D only after their own ordinary proofs have been generated and checked; moving work into library setup does not eliminate it. A compiler with different sharing, theorem boundaries or proof-stack order must recompute the schedule.

## 8. Immutable evidence and verdict

The cell input is `PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md`, SHA256 `3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E`, with mandatory clarification `F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2`. Its independent review is `moebius/REVIEW_PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md`, SHA256 `DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA`.

The source `examples__peano.mm1` hash is `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`; `examples__peano.mm0` is `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`. The reviewed command-model author `moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md` is `E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6`. Its PA-only boundary and full checker/source qualifications remain in force.

Owned `radix256_product_row_syntax_20261111.py` has SHA256 `776BAEB7AE70115601404BB86207D9499D64246E11EACCBABDC7981BE178A176`; its JSON is `3C3372F84D1AA46997E98DC7C101C75DE13F6BA9A2B0710ADAA6EA5C0BE8430B`. It constructs only formal trees, checks the four signature/count rows and hashes the six inputs. The writer refuses to overwrite its receipt. It runs no digit arithmetic or proof checker.

The bounded result is a complete paper algebra specification of the two row roles and initial base, with an explicit final-theorem variant and actual premise/argument counts. The claimed event formula is consistent for that conditional core. A complete ordinary-PA multiplier still needs the listed range/representation producers and a checked library/encoding implementation. The 202-event arithmetic example is not yet a complete accepted proof or a runtime prediction.
