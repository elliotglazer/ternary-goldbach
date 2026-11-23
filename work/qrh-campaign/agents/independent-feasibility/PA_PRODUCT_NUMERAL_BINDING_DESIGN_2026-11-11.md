# Ordinary-PA numeral bindings for the product row schedule

2026-11-11. New paper design and static syntax metadata. No declarations, proof emission, builds, concrete digit enumeration or arithmetic instances were run. All predecessor files remain unchanged. This author packet requires independent review and does not assert a compiled PA multiplier.

The row binding gap has a linear-size solution. Use literal low-prefix terms for the row state, prove their three intermediate equalities by reflexivity, and bind the actual multiplier and product words with two passes of one fixed concatenation lemma. A padded inner base makes each outgoing carry the exact next row's byte word. The same final ordinary-PA equality is retained. No step proves that equality by computing the large product again.

For already bound byte words, the added caller schedule has `5n+m+4` theorem applications and `20n+3m+26` premise/expression-root requests in the reviewed connected-DAG model. A deliberately loose complete binding bound, including three binary-numeral conversions and a positive-input producer, is `4mn+1313m+1324n+668` requests including newly constructed term-child edges. This is an upper schedule, not a measured cost or an optimal adapter. Table/range proofs, the original arithmetic core and the fixed adapter-library proofs are separate. The stock file/heap admission limits still apply.

## 1. Inputs and the exact representation

The accepted row/base packet is prime-estimates/PA_RADIX256_PRODUCT_ROW_BASE_2026-11-11.md, `71D3F4BF6558618A84E652B1E041BBA26BA095679562ED951DFEA138DC9F5CAC`, with independent review `DFF5635A401C45F7C69910B779706F9EAF84843FC5CF3CCD86D1CB0DD64273A7`. Its conjunction is retained literally:

    I(x,Y,l,P,A) = (l+P*A=x*Y) AND
                  (A<x AND (l<P AND 0<P)).

Here beta is the existing natural term `b0(b0(...b0(d1)...))` with eight b0 heads. It is not a new trusted radix constructor. Set

    W([],T) = T,
    W([d0,...,d(r-1)],T) = beta*W([d1,...,d(r-1)],T)+d0.

This notation describes a finite literal AST. No list, evaluator or W definition is imported into PA. Every actual word consists only of the existing natural multiplication, addition, digit and tail terms. The low digit is the outermost digit. A word ending in zero may have leading zero digits.

Each byte digit is an actual ordinary natural expression. The selected source adapter below produces an eight-head b0/b1 expression ending in zero for each byte. The cell table and range proof must refer to that very expression, or use an explicit conversion. A canonical integer value, a hash, a native array index or a text spelling does not establish term equality. In particular an existing table on another representation cannot be reused merely because both representations denote the same byte.

The positive nonempty branch has m,n>=1. Internal operands are `x=W(xdigits,0)` and `Ytotal=W(ydigits,0)` of lengths m,n. The internal output is a word of length m+n. For a public binary-numeral goal `x_src*Y_src=Z_src`, ordinary equality proofs bind these three internal words to the three actual public terms. The source grammar in this packet is the existing b0/b1 constructors on zero or one, with sufficient declared lengths. An arbitrary unevaluated arithmetic term requires its own equality to this grammar; that is not supplied by this design.

## 2. Literal prefix states and one concatenation lemma

Define the following caller terms by actual term construction and retained references:

    P0=1, Y0=0, l0=0,
    P(i+1) = P_i*beta,
    Y(i+1) = Y_i+P_i*y_i,
    l(i+1) = l_i+P_i*d_i.

The last three right sides are the chosen ASTs for the next objects. For every intermediate row, the three required binding premises are therefore instances of `eqid` on those exact objects. This costs three 1-argument, 0-premise applications per intermediate row. It does not turn the premise into an unverified assignment. Multiplication by P is represented as syntax and is not evaluated here.

The reusable concatenation step has five natural arguments L,P,d,T,Z and one premise:

    L+P*(beta*T+d)=Z
    ----------------------------------------------
    (L+P*d)+(P*beta)*T=Z.                         (C)

Its proof is the fixed equality

    (L+P*d)+(P*beta)*T = L+P*(beta*T+d),

using associativity, commutativity and distributivity. It requires no ranges, quotient theorem, induction on a large numeral or multiplication instance. The two accompanying interfaces are

    0+1*Z=Z                                      (start: 1 argument, 0 premises),
    L+P*0=Z -> L=Z                               (finish: 3 arguments, 1 premise).

Apply start and C down the actual multiplier word. At step i the supplied tail is the literal `beta*T+d` subterm of that word. After n steps the result is `Y_n+P_n*0=Ytotal`; finish yields `Y_n=Ytotal`. Its left side is exactly `Y_(n-1)+P_(n-1)*y_(n-1)`, as needed by the original terminal row theorem.

Apply a second start/C pass to the actual product word, with the n low digits produced by the rows and its actual m-byte high tail B. This gives

    l_n+P_n*B=Z.

The left side is literally `(l_(n-1)+P_(n-1)*d_(n-1))+(P_(n-1)*beta)*B`. It is the terminal theorem's required output binding. The finite word identity

    W(lowdigits,W(highdigits,0)) = W(lowdigits++highdigits,0)

is syntactic under this construction. It is not a new PA list theorem: the same actual low-word heads and high-tail pointer are used on both sides. If a producer supplies a different high-tail representation, it must first prove and apply its equality.

These two passes may be constructed before the row arithmetic. They use the supplied digits as symbols and do not assert that the digits are correct multiplication witnesses. The table/cell proofs and row invariant establish that separate fact. Thus this arrangement cannot accept arbitrary result digits by a circular concatenation assumption.

## 3. A padded inner base closes the carry representation

The previous inner base returned the natural c itself. That creates a representation problem: after m cells, the outgoing row carry has m-1 low bytes followed by c as an unpadded top tail. The next row wants m literal byte heads ending in zero.

Replace only that base interface by the following equally elementary theorem, with the same two arguments y,c and no premises:

    ((0*y+0)+c)=beta*0+c.                         (PB)

Its proof uses the ordinary zero-product and zero-addition identities. No range is exported. The top tail result is now the literal one-byte word `beta*0+c_m`. The cell chain still proves from high to low. Its output after removing the row's low digit is

    B = W([d1,...,d(m-1),c_m],0),

which has exactly m byte heads. On the next row this exact B object is A. The primitive x word is also the same object in every row. The top X_m and A_m are literally zero, so PB applies without an unproved high-tail decomposition. This works for m=1 as well. The top carry c_m is retained, never discarded.

All digit and carry range premises remain. In particular c_m<beta must be supplied as a genuine range proof when it is used as a byte. The previous cell theorem's internally derived bound is not an exported proof. PB does not replace it. If a table has a differently encoded carry, its equality and range transport must be charged.

Initially use the m-byte zero word A0=W([0,...,0],0). Starting from `0=0`, apply

    T=0 -> beta*T+0=0                            (1 argument, 1 premise)

m times. The result proves A0=0. One state-transport theorem, with arguments x,A and premises `I(x,0,0,1,0)` and `A=0`, gives `I(x,0,0,1,A)`. The cell input and the invariant therefore agree exactly. This is a one-time O(m) operation. It avoids repeatedly constructing padded carry numerals by an O(m) congruence chain on every row.

The original initial state, n-1 intermediate updates and one terminal update are otherwise unchanged. PB replaces the original inner base once per row; it is not an extra arithmetic row. The arithmetic theorem-node count remains `5mn+2n+1`. The new PB header/fresh-conclusion sizes differ and must be priced. This packet does not replace the old frozen row theorem by an unchecked stronger one.

## 4. Binding public binary numerals without a large multiplication

Here is one explicit, conservative adapter. It is not claimed to be the cheapest source encoding.

For e=0 or e=1, the existing constructors satisfy `b_e(S)=2S+e`. The following are two fixed generic affine lifts, not an enumeration of byte values:

    S=P*T+D -> b_e(S)=b0(P)*T+b_e(D).            (4 arguments, 1 premise)

Start with `T=1*T+0`. Apply the appropriate lift to the eight actual bit heads of a source block, from its inner head to its outer head. The place term is then exactly beta, and the resulting equation is

    S=beta*T+d,

where d is the same eight bit heads applied to zero. No bit is evaluated. With a previously proved higher-tail binding T=U, one 4-argument, 2-premise byte-glue theorem gives `S=beta*U+d`. Recursing from high bytes to low bytes binds the full source term to the literal byte word. There are one affine start, eight lifts and one glue per full byte, and one initial `0=0` proof.

Short top blocks and leading-zero padding are explicit. First replace a terminal source one by b1(0), using b10 in the required orientation, and propagate that equality through the existing bit heads. Then prove `b0^k(0)=0` for the needed high padding and propagate its reverse equality through the existing r heads. The padded binary term has exactly 8L heads. This does not change the public source term; it proves equality to the padded term. Finally compose that equality with the byte conversion. The case of a source zero is handled by the same zero-padding construction.

For a source fitting L bytes, a conservative application bound is

    source-one conversion and congruences <= 8L+2,
    high-zero padding and congruences      <= 8L+2,
    full-byte conversion                  = 10L+1,
    final transitivity applications       <= 2,
    total                                 <= 26L+8.                (1)

The bound allows redundant steps and does not require a value computation to remove them. The binary numeral's actual grammar and length, and every instantiated constructor, are part of the proposed proof stream. The three uses have lengths m,n,m+n. A source longer than its declared length is outside this cost bound; a native claim that it fits cannot replace the conversion proof.

The byte tables can be generated for these same padded digit terms, with literal zero also allowed for the initial row's zero digits. This is a selected table interface, not a claim about an already emitted table. If an existing cache instead stores shortest binary digits or named definitions with those bodies, a proved padding/definition conversion must be retained and applied. In particular the separate named-digit successor is not automatically compatible with this representation. The schedule (1) binds the public operands; it does not silently cover an arbitrary extra cache representation. Ordinary bit-range lifts

    D<P -> b_e(D)<b0(P)                           (2 arguments, 1 premise)

starting at 0<1 prove each padded byte bound in eight steps. This is an available range producer if closed range facts are not already available. Its applications are separately counted, shared only for actually retained identical terms. Neither a digit equation nor a constructor name alone exports that bound.

In the positive branch, a b1 head gives a positive natural term and b0 preserves positivity. This supplies a proof of 0<x_src in at most 8m+1 fixed generic applications after locating a nonzero bit in the actual syntax. Leading b0 zeros have no such proof. A 2-argument, 2-premise positive transport consumes `x_src=x` and `0<x_src` and proves `0<x` for the initial state. An all-zero source uses the separate zero-product branch, not an assumed-positive row state.

After the terminal row theorem, use one final transport with six arguments and four premises:

    x_src=x, Y_src=Ytotal, Z=Z_src, x*Ytotal=Z
    ------------------------------------------------
    x_src*Y_src=Z_src.                             (2)

It uses only multiplication congruence and equality transitivity. The output decoder gives Z_src=Z; orienting that proof as needed is included in the deliberately conservative conversion allowance. The output equation (2) is the requested public product equality, not a new representation-specific conclusion.

## 5. Static signature and caller prices

All natural arguments are ordinary terms. I is expanded in the headers. The fixed beta term has nine unshared nodes, as in the accepted cell/row packet. The following counts follow the reviewed MMB model; no stream was emitted.

|Interface|Arguments / premises|Header commands|Cached call|Fresh-conclusion call|
|---|---:|---:|---:|---:|
|Reflexivity|1 / 0|4|3|5|
|Zero-word step|1 / 1|20|4|18|
|Initial carry transport|2 / 2|48|6|26|
|Concat start|1 / 0|8|3|9|
|Concat step C|5 / 1|42|8|28|
|Concat finish|3 / 1|12|6|8|
|Positive transport|2 / 2|12|6|8|
|Final transport|6 / 4|24|12|16|
|Padded inner base PB|2 / 0|22|4|24|
|Bit affine start|1 / 0|8|3|9|
|Each bit affine lift|4 / 1|19|7|16|
|Byte glue|4 / 2|36|8|22|
|Each bit congruence or range lift|2 / 1|10|5|9|

The original inner base had header 10 and fresh call 12. PB has header 22 and fresh call 24. Its cached call and a/h counts are unchanged. A cost calculation starting from the old fresh-conclusion schedule must add twelve constructor-child requests per row, or directly substitute the new PB conclusion. The following binding formulas use the arithmetic core with PB already substituted; they do not hide that difference.

Let V count new theorem nodes, H premise edges, R argument/conclusion-root requests, and C constructor-child requests. For a legal connected first-use DAG with one final root, the reviewed command identity is `H+R+C+2`, including its one END. Parameterized helpers contribute their full arguments and premises. They cannot be put in the unit-cost count of closed facts.

Outside the PB arithmetic core, take exactly:

    3(n-1) reflexive intermediate bindings;
    one reflexive zero base and m zero-word steps;
    one initial carry transport;
    two concat starts, 2n concat steps, one concat finish;
    one positive transport and one final transport.

This gives

    V = 5n+m+4,
    H = 2n+m+9,
    H+R = 20n+3m+26.                             (3)

Fresh construction of all these conclusion heads uses at most `46n+14m+36` child requests. Charge an additional `10n+4m+4n(m+1)` reserve for literal prefix/power terms, the zero word and all row carry-word heads even when parts are already constructed by the arithmetic or concat conclusions. This deliberate double allowance avoids assuming an implicit term-interning optimization. Thus the binding addition is bounded by

    H+R+C <= 4mn+21m+80n+62.                     (4)

It is added to the core's existing single-END formula, not given a second END.

Every binary-adapter node in (1) has a+h+1<=7 and at most 16 fresh conclusion-child requests. Reserving another 24L+16 requests for the source/padded/digit-word term construction gives

    H+R+C <= 23(26L+8)+24L+16 = 622L+200         (5)

for each source decoder. The positive-source producer costs at most `6(8m+1)=48m+6` requests in the same model. Applying (5) at m,n,m+n and adding (4) yields the stated conservative total

    4mn+1313m+1324n+668.                         (6)

This is a concrete upper schedule for the caller-side binding and positive-source tasks under the stated grammar. It is not a total multiplication cost. Add the actual cell/table/range proof schedule, its term constructors, the substituted PB core, library loading and the library's ordinary proofs. If comparing directly to the old unshared inner-base constructor schedule, add the explicit 12n PB increment as well. If byte words and their positivity are already the public interface, omit the relevant decoder/positive producers, but retain any necessary final/public transport.

Generic adapter proof bodies are fixed library work independent of m,n and digit values. They have not been emitted or measured. Header counts do not price those proof bodies. Once proved, they can be reused with the above application schedule. Building or checking those bodies remains a setup term rather than a silent zero cost. Source padding, public conversion and range/cache conversion are not interchangeable setup terms.

## 6. Term growth, storage and acceptance limits

The prefix/power representation contains five new binary arithmetic nodes per row. P_i is shared by the two prefix updates and the next power. The two concat passes retain these exact objects through explicit saved references. Rebuilding an unshared expression tree for every prefix would lose the linear bound and is not this schedule.

The row carry words use O(mn) constructor nodes over the full proof. Source/target byte and binary words use O(m+n), and the binding theorem/conclusion instances use O(m+n) additional nodes. Equation (6) also bounds their child requests. It follows that the representation layer has O(mn+m+n) stored term-DAG size under the stated allocation, rather than a repeated large arithmetic calculation. This is a full-proof bound, not a claim that the stock verifier reclaims individual rows.

Exact sharing requires actual saved expression objects. MMB's URef verifies pointer identity, while UTerm checks the constructor/arguments. A producer hash or an unrelated equal-valued numeral cannot satisfy these checks. The equality adapters provide the semantic links where syntactic identity is unavailable. A shared DAG can be represented by ordinary term/proof references; no hash axiom, native list axiom or new arithmetic instruction is needed.

The current stock verifier's bounded IDs, heap/stack and expression store remain implementation limits. Each proposed concrete proof must fit them or use a separately justified theorem-boundary/streaming implementation with its costs charged. This note does not infer that arbitrary m,n fit a stock file merely from asymptotic linearity. Saving a state as a separate theorem requires its genuine ordinary proof and subsequent instantiated use, not a checkpoint receipt treated as a theorem.

The public input and output themselves, all byte/table facts, the fixed beta definitions, and exact range facts need actual terms in scope. Definition unfolding is done by the proved source lemmas or explicitly charged conversion, never by equating different heads. Zero operands can use mul01/mul02 plus the same public bindings; the positive-state formula is not applied to x=0. The n=1/m=1 boundary retains a real terminal row and a real top carry. Leading zero words are allowed without deleting unpriced rows.

## 7. Source map and proof boundary

The pinned PA source is work/mm0-efficient/toolchain-sources/examples__peano.mm1, `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`.

- Line 901 gives eqid. Equality transitivity and congruence occur in the same equality development and at 2034-2050.
- Lines 2057-2153 give zero/one identities, associativity, commutativity and distributivity. In the current bytes, muladd is at 2131, addmul at 2140 and mulass at 2143. They prove C and the affine lifts by fixed algebra.
- Natural order and positive multiplication facts at 2191-2413 support the positive/range helpers and retain the row packet's range argument.
- Lines 3011-3018 define b0 and b1. Lines 3024-3037 contain b00, b10 and the b0/b1 multiplication interpretations. They justify the binary source adapter entirely in ordinary PA.

The peano_hex numeral normalization pattern is not a premise of this construction. No hex coercion axiom is imported. This is a source-faithful paper derivation from the named ordinary identities, not a transitive-axiom audit or a compiled theorem verdict.

The cell packet remains `3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E`. Its mandatory prime-estimates/CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md is `F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2`, and its accepted moebius review is `DDA93BA814D78B2339E37C2588BC3DF8D0747BC5AF660BD51BAA9327569452EA`. The proof-command model is moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md, `E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6`. Relevant verifier pins are recorded in the receipt. This design neither validates that whole toolchain nor changes the ordinary-rule acceptance boundary.

## 8. Immutable evidence and remaining work

Owned static script pa_product_representation_syntax_20261111.py has SHA256 `8793BCCB4D8988DCC986A41503D3343CF556A7FD3032097C2E7AC5D4D84C1719`. Its exclusive-write JSON is `B522D12703201099B8148D09643F860DA6AD6D74A62CB24BFA03D62C8D1185A3`. It passed 2,157 checks of formal-polynomial identities, signatures, literal endpoint/word shapes and length-count formulas, and recorded the source pins above. It does not enumerate bytes, import another writer, emit a proof or run a verifier. The length loops are abstract symbolic shapes, not multiplication examples.

The concrete improvement is an ordinary-PA representation plan with bounded caller work: syntactic next states plus two concatenation passes, padded carry reuse and a binary-source decoder. It replaces the previous unspecified Yn/ln/Pn/final bindings with explicit producer interfaces and a conservative schedule. The remaining implementation work is to prove the finite adapter library, instantiate it with real source terms and table/range facts, and validate complete proof files under the chosen ordinary verifier. Any tighter pricing must retain these bindings or prove an alternative schedule; the old arithmetic-only count is not the full certificate cost.
