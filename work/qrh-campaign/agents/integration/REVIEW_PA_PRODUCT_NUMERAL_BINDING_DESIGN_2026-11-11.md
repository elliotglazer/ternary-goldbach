# Independent review: PA product numeral bindings

2026-11-11. **PASS at the stated paper/source and static-metadata scope; no correction requested.** The proposed caller interfaces bind the row proof to the actual public numeral equality, including padding and the surviving high carry. The stated conservative binding bounds are consistent with the specified shared-term schedule. This is not a compiled multiplier, an emitted MMB proof, a full axiom audit, or a runtime estimate.

Reviewed author: `independent-feasibility/PA_PRODUCT_NUMERAL_BINDING_DESIGN_2026-11-11.md`, SHA256 `67631F57A93B6AE32303A148377AA1D4227FC5E34A4D25F265EA2561C42D6A59`. The bound author script is `8793BCCB4D8988DCC986A41503D3343CF556A7FD3032097C2E7AC5D4D84C1719`; its receipt is `B522D12703201099B8148D09643F860DA6AD6D74A62CB24BFA03D62C8D1185A3`.

I read the entire packet and companion, the actual row/base consumer, the relevant ordinary-PA algebra/order/binary-constructor bodies, and the MMB theorem/unification rules. My separate script imports no author module and executes no writer, proof generator or verifier. It reconstructs all **22** signatures through an independent expression parser, checks formal polynomial identities and abstract word shapes, and verifies length-count formulas. It passes **4059** assertions. These are symbolic syntax/algebra/count checks, not concrete byte or multiplication examples.

## 1. Public conclusion and absence of circular binding

The consumer invariant remains literally

    (l+P*A=x*Y) AND (A<x AND (l<P AND 0<P)).

The internal x, multiplier and output are finite arithmetic ASTs with low byte outermost, using only beta, multiplication, addition and actual natural digit terms. The beta term is the existing eight b0 heads on d1; no hex constructor or coercion axiom is used.

The three next-state terms are deliberately constructed as P*beta, Y+P*y and l+P*d. Their intermediate bindings are real reflexivity applications on the same saved objects. The exact associations match the row theorem's three premises. A separate equal-valued numeral would not satisfy those premises by pointer identity.

The concat step

    L+P*(beta*T+d)=Z
      -> (L+P*d)+(P*beta)*T=Z

is the fixed distributive/associative/commutative equality displayed by the author. A start at 0+1*Z=Z and n successive steps down the actual multiplier word produce Y_n+P_n*0=Ytotal. The finish theorem removes only the zero tail. The left side Y_n is exactly the last row's Y+P*y expression, so this supplies the terminal multiplier premise.

The second pass stops after the n low product digits with its actual m-byte high tail B. It gives l_n+P_n*B=Z, with exactly the terminal row's association. The concat pass is true for any supplied digit symbols and does not assert they multiply correctly. The cell chain and row invariant must prove that the same B and low digits satisfy the product recurrence. A different supplied high word cannot be substituted without a proved equality. This separates representation from arithmetic without making the arithmetic premise circular.

The final six-argument/four-premise transport explicitly consumes x_src=x, Y_src=Ytotal, Z=Z_src and x*Ytotal=Z, and returns x_src*Y_src=Z_src. The output decoder's reverse orientation needs equality symmetry; the conservative conversion allowance includes it. No public argument is replaced by an unbound alias or hash.

## 2. Padded base and row boundaries

The padded inner base proves

    ((0*y+0)+c)=beta*0+c.

This is ordinary zero algebra. It changes the top result expression but not the general cell theorem's higher-tail interface. Propagating m cells downward yields an (m+1)-byte row output. Removing its low output digit leaves exactly m heads, with the last carry as the top byte, ending in zero. That is the next row's literal A object. For m=1 the carry is the one-byte word beta*0+c_top; it is not discarded or mistaken for bare c_top.

Initially A is the m-byte zero word. Its equality to zero is proved by one reflexive base and m zero-word steps. A two-argument/two-premise transport changes only the carry argument of the already proved initial state. This aligns the cell word and invariant without relying on an unverified decoder.

The positive branch still requires m,n>=1 and a proved 0<x. There are n-1 intermediate updates and one genuine terminal update, including n=1. Unequal lengths and leading zeros preserve m cells per row and the complete final tail. Zero operands use their separate zero-product branch and actual public bindings; they do not enter an invariant with the impossible condition A<x when A=x=0. Empty-loop optimization is outside the stated formula.

No range is exported by the padded base. In particular c_top<beta, all cell byte/carry bounds, and table-output digit bounds remain separate proof inputs. An internal cell derivation of a carry bound is not a cached range theorem. The packet explicitly charges closed range facts or parameterized range producers and any differing cache representation.

## 3. Binary-source conversion is sufficient within its declared grammar

The generic affine identities follow from b0(S)=2S and b1(S)=2S+1:

    S=P*T+D -> b_e(S)=b0(P)*T+b_e(D), e=0,1.

Eight applications, from inner head to outer head, leave the place term syntactically b0^8(1)=beta and the digit equal to those same eight heads applied to zero. They neither evaluate the byte nor assume a table index means that digit. The byte-glue theorem then consumes the already proved higher-tail equality. Recursing over bytes produces the full source-to-word equality.

Terminal one requires b10 in reverse orientation and propagation through the source heads. A short top block requires proved high-zero padding, its orientation and propagation. Those are necessary parts of the advertised adapter, not free preprocessing. The count applies to the stated source grammar and declared bit-length bound. It does not apply merely because a longer expression happens semantically to fit L bytes. Arbitrary arithmetic expressions, alternative named digit bodies and shortest-versus-padded table spellings require additional proved conversions.

The range helper is also sound for both bit choices: from natural D<P, one obtains 2D+1<2P, and therefore b_e(D)<b0(P). Starting at 0<1 and applying it eight times proves the padded digit range. Such parameterized calls have their actual arguments, premises and constructors; they are not unit-cost closed facts. A b1 head, or the terminal one, supplies positivity; b0 preserves it. A genuinely all-zero source does not acquire positivity from its byte length.

The conservative source-conversion schedule includes at most 26L+8 applications. The separate reserve for source/padded/digit terms is explicit. Some fresh-conclusion maxima are deliberately loose; for example the decoder's 16-child allowance need only be an upper bound. No equality of that allowance with an observed maximum is required.

## 4. MMB signatures and counts

The independently reconstructed header and call rows agree with the author's receipt, including:

|Interface|Arguments/premises|Unshared header|Cached/fresh call|
|---|---:|---:|---:|
|Concat step|5/1|42|8/28|
|Concat finish|3/1|12|6/8|
|Initial carry transport|2/2|48|6/26|
|Padded inner base|2/0|22|4/24|
|Each affine bit lift|4/1|19|7/16|
|Byte glue|4/2|36|8/22|
|Final public transport|6/4|24|12/16|

The ordinary row core has the same theorem-node count after replacing the inner base. Its PB conclusion adds twelve unshared constructor-child requests per row relative to the previous fresh-base schedule. This cost is either substituted directly or added as 12n; it must not disappear or be counted twice.

For the binding schedule outside that substituted core I obtain

    V=5n+m+4,
    H=2n+m+9,
    H+R=20n+3m+26,
    fresh conclusion-child requests=46n+14m+36.

Adding the author's explicit 10n+4m+4n(m+1) term-construction reserve gives

    H+R+C <= 4mn+21m+80n+62.

The three decoder lengths are m,n,m+n. With 622L+200 requests per decoder and 48m+6 for positive-source production, the combined upper expression is exactly

    4mn+1313m+1324n+668.

This addition is made to the core's existing single-END schedule; it is not a second proof root or an END per adapter. The source-grammar, shared-object and connected first-use DAG hypotheses are material. Rebuilding expanded prefix trees at each call would invalidate this schedule. Fixed library proof bodies, range/table facts and alternate cache conversions are not contained in this caller bound.

The actual verifier supports the cited interpretation. `verifier.c:479–515` pops an explicit conclusion and all natural arguments, checks sorts/dependencies and invokes the theorem's unifier. Premises are separately consumed by UHyp. `verifier.c:243–274` compares URef pointers and decomposes UTerm constructors; it does not equate unrelated same-valued numeral objects. `mmb.md:226–226` explicitly warns that separately constructed equal-looking expressions are distinct. The paper therefore correctly requires retained references or a proved conversion. An abstract theorem application count is not a count of machine instructions, bytes or executed header commands.

## 5. Source basis and limits of acceptance

The ordinary-PA source pin is `examples__peano.mm1` SHA `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`. I inspected equality/congruence and the algebra at 2034–2153, the relevant natural order/positivity development at 2191–2413, and b0/b1 definitions and interpretation at 3011–3037. The concat, padded-base and affine proofs use those fixed identities. No peano_hex coercion or native arithmetic oracle is needed by the proposed statements.

The accepted row/base producer and its review remain separate prerequisites; this review checks its concrete consumption, not a new implementation of that arithmetic core. The mandatory closed-fact clarification remains in force: parameterized decoder, range and transport calls cannot be hidden in D as if they were zero-argument/zero-premise table facts.

The packet supplies a viable paper design for the formerly unspecified bindings. It does not supply implemented generic adapters, emitted byte/range libraries, proof streams, a transitive foundational audit, or proof that a chosen file fits the stock verifier's ID, heap, stack and expression-store limits. A widened or streaming implementation using the same ordinary rules remains a separate implementation/validation and pricing task. No universal size admission or Lean/MM0 runtime comparison follows here.

## 6. Independent evidence

|Owned artifact|SHA256|
|---|---|
|`check_pa_product_numeral_binding_review_20261111.py`|`C2A1495A2E68BCBCE2E18123F7B09CF483C72243F26C3FA47F93FA97D6456E1C`|
|`pa_product_numeral_binding_review_20261111.json`|`C3CBD49E18CA6C1D1A88F72A141E57D5AB8137FB6C831DC8220FF4188FE01488`|

All twelve source/author/review pins in the receipt match. The static reconstruction checks signatures, symbolic polynomial identities, exact concat/carry AST endpoints at abstract lengths, the two boundary lengths, and every displayed count formula. It emits only this review metadata. No digit/table enumeration, proof or declaration emission, compiler/checker invocation, mathematical value evaluation or frozen predecessor edit occurred. The task stops at this scoped verdict.
