# PA-only radix-256 adder lift and terminal base

2026-11-11. Paper signatures, source proof outlines and syntax/header counts only. No MM0/MM1/Lean declaration, proof stream, digit table or arithmetic instance was emitted. No byte enumeration, build or checker run was performed. All frozen predecessors remain unchanged.

This packet supplies a concrete adder behind the conditional macro count `A(l)=2l+1`: one full-adder equation and one higher-tail lift per position, plus one terminal base. The equality lift needs eight natural arguments and two premises. A range-checking version needs the same eight arguments and seven premises. Their ranges, numeral bindings and proof-command costs are explicit below. These are source-backed paper templates, not implemented PA lemmas or a complete accepted arithmetic backend.

## 1. Fixed natural radix and exact signatures

Use beta=`b0(b0(b0(b0(b0(b0(b0(b0(d1))))))))`, whose mathematical value is 256. `d1` and `d2` are the existing natural definitions of1 and2; `b0 n` is the existing definition n+n. No hex digit sort, coercion axiom or new radix primitive is used. Proving beta's positivity, its predecessor relation and any conversion to another numeral spelling is reusable setup work. The fixed closed beta term is not an expression argument.

The equality lift has these **eight natural expression arguments**, in this order:

    X, x, Y, y, c, k, d, Z.

Its **two proof premises** and conclusion have exactly these parentheses:

    E: (x+y)+c = beta*k+d.
    H: (X+Y)+k = Z.

    Conclusion: ((beta*X+x)+(beta*Y+y))+c = beta*Z+d.     (L)

X,Y are higher input tails, x,y the current input digits, c the incoming carry, k the outgoing carry, d the output digit and Z the higher output tail including k. The equality is valid for all natural arguments. It does not need range premises and exports no range conclusion. Unlike the product-cell lift, no overflow variable is silently discarded.

For a consumer that must check every local byte/carry bound in the same application, fix a **range-checking lift** with the same arguments, conclusion and first two premises, followed by these five proof premises:

    Rx: x<beta.    Ry: y<beta.    Rc: c<2.
    Rk: k<2.       Rd: d<beta.                           (R)

This signature is exactly a=8,h=7. Its arithmetic proof can use E,H only, but the actual theorem application must supply and check all five additional premises. Passing them does not create their proofs. The conclusion remains equality-only: no additional bound object is returned free. This variant makes the range acceptance boundary explicit without pretending that unused mathematical hypotheses disappear from checker work.

The **terminal base** has one natural expression argument c, no proof premises, and conclusion

    (0+0)+c = c.                                       (B)

There is no assumption c=0. This is essential: the last carry can be1. The base arithmetic identity also holds for arbitrary natural c; the encoded-adder contract checks c<2 separately or through the last range-checking lift. For l=0, an admissible incoming carry must be checked independently because there is no lift.

These are paper specifications, not new declarations. The same fixed-radix spelling agrees with prime-estimates' 15-argument/9-premise product-cell packet and its mandatory closed-fact counting clarification.

## 2. Algebra from the actual PA source

The entire lift follows by the fixed sequence

    ((beta*X+x)+(beta*Y+y))+c
      = ((beta*X+beta*Y)+(x+y))+c
      = beta*(X+Y)+((x+y)+c)
      = beta*(X+Y)+(beta*k+d)
      = (beta*(X+Y)+beta*k)+d
      = beta*((X+Y)+k)+d
      = beta*Z+d.

The first equality is `add4`; the next uses `addass` and `muladd` in reverse. E is substituted by addition congruence. Reassociation and reversed distributivity give the penultimate expression, and H is substituted by multiplication then addition congruence. Equality transitivity closes the chain. The base uses `add0` at0, congruence and `add01`. This is a finite derivation using named PA facts, not an appeal to an unspecified ring tactic or numerical normalization oracle.

The relevant pinned `examples__peano.mm1` bodies are:

|Lines|Source fact|Role|
|---|---|---|
|1804–1805|`d1`, `d2` definitions|Natural spellings of1 and2|
|901–922|`eqid`, `eqcom`, `eqtr`, premise-taking transitivity variants|Fixed equality chains|
|2032–2050|`addeq`, `muleq`, derived congruence interfaces|Substitution into the displayed contexts|
|2057–2095|`add02`, `add01`, `addass`, `addcom`, `add4`|Base, regrouping and swapping summands|
|2126–2148|`mul12`, `mul11`, `muladd`, `mulass`|Distributivity and optional numeral adapters|
|2172–2208|Natural `le`, additive lower bounds, transitivity|Range arguments below|
|2233–2245|`sub1can`, `leadd`, `lemul2a`|Positive-radix predecessor and monotonicity|
|2247–2292|`lt`, `leltsuc`, `lelttr`, `ltirr`, `d0lt2`, `d1lt2`|Byte/carry bounds and contradiction|
|2693–2712|`eqdivmod`, `divmod`, `modlt`|Optional existence/decoder route, not hidden lift premises|
|3011–3031|`b0`, `b0mul21/22`, `b00`, `b0ne0`|Radix spelling, shifts and zero padding|

The arithmetic axioms and induction are those of the pinned PA development. Its existing `b0` definition is used as a definition; the hex theory's `@eval-check axiom` coercions are not consumed. Formal proof bodies for these new composite signatures still need to be constructed and checked.

## 3. Carry bounds, digit bounds and table scope

A separate proposed **carry-bound helper** has five natural arguments `x,y,c,k,d`, four premises E,Rx,Ry,Rc, and conclusion `k<2`. No d<beta premise is needed for this conclusion. Its proof is short but not free:

1. Write the fixed positive beta as suc b. The input bounds give x,y<=b and c<=1 using `leltsuc`; hence `(x+y)+c<=b+b+1<beta+beta`.
2. If 2<=k, multiplication monotonicity and natural d>=0 give `beta+beta=beta*2<=beta*k<=beta*k+d`.
3. E contradicts the strict upper bound. Natural order therefore gives k<2.

The predecessor b is an internal fixed-radix proof device, not an extra per-cell argument or unchecked supplied value. The source's `sub1can` and the positive beta setup justify it. Zero digits and c=0 are included. For c=1 the strict upper endpoint is still valid.

The output digit bound **does not follow** from E and the three input bounds. Symbolically x=beta-1,y=1,c=0,k=0,d=beta satisfies those premises but violates d<beta. Thus Rd must come from a proved closed digit fact, checked decoder, or explicit table conclusion. The equation lift does not make arbitrary d into a byte.

A complete full-adder table would provide the natural equality E for x,y<beta and c in{0,1}, together with a separately chosen way to obtain k<2 and d<beta. Existence may be proved using the PA `divmod`/`modlt` theorems for `(x+y)+c` and nonzero beta, followed by the carry bound. That is an available proof route, not an already generated table. No table entry is evaluated here.

One format keeps equality-only closed table theorems and closed bound theorems for digit numerals. The same bound proof may be reused wherever its exact numeral term recurs in one live context. The existing source already proves `0<2` and `1<2`; ordinary digit<beta facts still require proofs or a proved range decoder. A different format bundles equation/range facts, but then table signatures, conjunction projections, setup and call arities change. No such bundle is counted in the present signatures.

There is no free internal export: obtaining k<2 through the parameterized five-argument/four-premise helper is an extra theorem application with its own premises, header and conclusion term. The range-checking lift can instead consume an already saved closed bound. Merely checking a host integer or a table ID is not a PA range proof.

## 4. Finite word assembly, zeros and final carry

Let l be the chosen number of input byte positions. Define the exact natural tails by

    A_i=beta*A_(i+1)+x_i,
    B_i=beta*B_(i+1)+y_i,
    T_i=beta*T_(i+1)+d_i,
    A_l=B_l=0, T_l=c_l.

For every position supply the table equation

    (x_i+y_i)+c_i = beta*c_(i+1)+d_i.

The base gives `(A_l+B_l)+c_l=T_l`. Starting with i=l-1 and descending, apply (L) with H being the already proved higher-tail equality. The result is `(A_0+B_0)+c_0=T_0`. Carries can be discovered by the untrusted producer from low to high; their acceptance proof runs from high to low. No proof depends circularly on the equality it is establishing.

For the fixed premise order E,H, a legal proof-stack schedule loads the lowest table proof E_0 first, then recursively prepares E_1,... and the terminal base, then applies the lifts downward. Shared table proofs can instead be referenced. The checker consumes premises in the declared reverse order. Stack/heap and shard limits remain explicit implementation constraints; no assumption of unlimited retained local facts is made.

Unequal input lengths use l=max(l_A,l_B) and literal zero digits beyond the shorter input. Leading zero bytes are allowed. Their natural equality to a canonical shorter representation uses zero multiplication/addition or existing binary-zero identities; those exact term conversions are separate from the core count. A byte formed as `beta*X+x` is not automatically the same checker pointer as an independently encoded eight-bit binary append. A reusable PA shift/decoder theorem may prove the equality, but its call, substitutions and term sharing must be charged.

The final carry is kept in T_l. If c_l=1 it produces the extra highest output byte without another full-adder cell. If c_l=0, dropping the leading zero needs the appropriate representation equality. Discarding c_l without a proof that it is zero would certify addition modulo beta^l instead of the requested natural addition. The l=0 case is the single base identity, with T_0=c_0.

For ordinary no-carry addition choose c_0=0. The literal root from the generic lift is `(A+B)+0=T`. A proposed **zero-carry removal adapter** has three natural arguments A,B,T, that one premise, and conclusion `A+B=T`; `add0` and transitivity prove it. It is a separate call unless the first lift is replaced by a separately specified specialized signature. No such specialization is silently included in `2l+1`.

All input/output tail and numeral bindings must match the actual requested operands. If the consumer additionally requires a fixed output width or canonical leading digit, it must check those bounds/decoder facts. The arithmetic equality is valid without that metadata, but a width-priced byte implementation cannot assume unchecked bounds.

## 5. Concrete MMB call and unshared-header stencils

Use the checked source command model in `MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md`. A theorem application takes the explicit expression arguments, the conclusion expression, and all premise proofs. The header checks the full statement. It is not one machine operation.

For this count preserve the existing `b0`, `d1`, `d2`, equality, arithmetic and order definition heads. An unshared beta occurrence expands into eight unary b0 nodes and one nullary d1 node. Do not replace beta by a new undeclared atom in the actual header. The atomic-beta syntax counts are conclusion L19, E11, H7 and base7. The lift contains four beta occurrences across its statement, so its fully expanded expression trees have69 nodes. Two UHyp commands and END give72 header commands. The five checked ranges add39 expression nodes and five UHyp commands, giving116. No proof or header stream is emitted here.

|Paper signature|Natural args|Proof premises|Cached conclusion call|Fresh conclusion call|Unshared header commands|
|---|---:|---:|---:|---:|---:|
|Equation lift|8|2|12|30|72|
|Range-checking lift|8|7|17|35|116|
|Terminal base|1|0|3|9|8|
|Carry-bound helper|5|4|11|13|52|
|Zero-carry removal|3|1|6|10|14|

The cached column assumes every argument, premise proof and whole conclusion expression is already saved with the exact matching pointer. The fresh column still assumes all leaf operands, including the whole beta term, are saved, but constructs each conclusion's binary nodes afresh without subterm sharing. For the lift this is ten leaf references plus nine term constructions, in addition to a argument references, h proof references and one theorem command. Source sort checks and the 72/116 header operations are additional work.

Under the stock local heap bound, references have at most three-byte encodings and term/theorem IDs at most five. The lift cached/fresh body-byte upper bounds are38/110; for the range-checking lift they are53/125. They exclude enclosing END, operand/premise construction, header storage and executions, conversions and global theorem construction. Nine fresh binary terms allocate conditionally216 bytes using the source's 16-byte node-header plus two 4-byte arguments; this is a source-layout calculation, not a measured ABI or total memory bound. The receipt gives the analogous base/helper counts.

Actual compiled headers may share subterms. That changes their command/byte costs and must be counted from the chosen format; the displayed stencils are explicit legal unshared trees. Exact numeral pointers, canonical zero/sign conventions and definition conversions are not supplied by a digest or equal-looking reconstructed syntax.

## 6. What `A(l)=2l+1` now means

The equality core has l closed full-adder-equation **uses**, l lifts and one terminal base. This is the intended two events per digit plus one base. It is not the total cost of ranges, numeral binding, arbitrary-width decoding or output conversion, and it is not a count of MMB commands.

For a connected proof DAG with those lifts/base, let D0 count only newly applied **closed, zero-expression-argument, zero-premise facts**; cached facts are premise leaves instead. Let C_terms be the total child-expression requests for all newly constructed terms in that DAG, as in the reviewed expansion formula. With equality-only lifts, D0 includes the newly applied table facts and the body command count including one END is

    11l + D0 + C_terms + 4.

Indeed H=2l, R=9l+2+D0 and the reviewed formula is H+R+C_terms+2. The l table uses are premise edges, not necessarily l new theorem applications. In the equality core D0<=l, but this does not bound D0 once additional closed bounds or binding facts are included.

With range-checking lifts and otherwise the same connected schedule, H=7l, giving

    16l + D0 + C_terms + 4.

Here D0 includes newly applied closed range facts too; reuse remains possible, but not free references or free header executions. A parameterized carry/decoder/binding proof is **not** one D0 fact. It contributes its actual a+1 expression-root requests and h premise edges, plus terms, to the full DAG formula. For example, adding a carry-bound-helper node contributes a+1=6 to R and h=4 to H, not merely1 to D0. Its repeated E/input-bound uses are actual proof edges.

If range results are checked as separate live roots rather than consumed in the lift or final decoder, the fragment is a proof forest; compose it with an actual theorem and charge that composition before using the single-root formula. Merely producing disconnected bound proofs does not fix the final statement or its command count. The source's per-theorem heap/store reset also prevents silently preserving all closed proof pointers across packs.

The new result fixes these particular adder arities and a possible stack/header scheme. It does not assert that the PA byte tables or any of the new generic templates have been implemented. It is compatible with the product packet's distinction between arithmetic macro counts and the complete checked backend. Ordinary same-rule widened or streaming implementations may change storage limits, but no native addition acceptance rule or hex coercion axiom is assumed.

## 7. Frozen evidence and open work

The syntax-only companion `integration/radix256_adder_syntax_20261111.py`, SHA256 `CA01670BC990B3C1955690FA65455D2CEE06533D32F4FC49C5623CBAD1176241`, and its JSON construct formal statement trees, check28 hash/syntax/count facts and evaluate no byte arithmetic instances. The receipt SHA256 is `6E79205E694422F0CC66AD4294246B6369FE8BBE71801943F64BBB16B77C21BC`. Exact upstream pins include:

|Input|SHA256|
|---|---|
|`work/mm0-efficient/toolchain-sources/examples__peano.mm1`|`13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`|
|`work/mm0-efficient/toolchain-sources/examples__peano.mm0`|`463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`|
|`moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md`|`E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6`|
|Its independent major-constants review|`70A5D74BF6D4A5D6FF38B85B3D85F528D7E33E8E49329AF114DD1B4CED0F493C`|
|`prime-estimates/PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md`|`3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E`|
|Mandatory product closed-fact clarification|`F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2`|

The receipt also pins the actual MMB verifier, command types and format source. The remaining work is explicit: write/check the generic PA proof bodies, produce the chosen closed table/range facts or decoder, fix numeral representation conversions and actual DAG sharing, and validate the implementation under real pack limits. This paper removes an unspecified signature from the cost model; it supplies neither an emitted proof nor a runtime saving.
