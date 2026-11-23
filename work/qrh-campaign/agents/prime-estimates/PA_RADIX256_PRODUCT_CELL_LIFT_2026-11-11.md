# A PA product-cell lift for radix 256

2026-11-11. Paper algebra and static source/syntax inspection only. No MM0, MM1 or Lean declaration, generated proof, digit-value enumeration, product instance, compiler or checker run. All previous artifacts remain unchanged.

The proposed product cell has a concrete natural-number proof. One fused lift can consume the four arithmetic table equations and a higher-tail equation, provided four input byte bounds are also supplied. The resulting signature has 15 natural expression arguments and nine proof premises. Thus five arithmetic events per cell remain possible as a conditional macro count, not as five proof commands or a complete range-checked multiplication cost. This packet supplies the previously missing algebraic lift, with a source-backed proof DAG. It does not supply its formal proof, byte table, row/base adapters or a complete 202-event rectangular multiplier.

## 1. Exact proposed signature

Let beta be the fixed closed natural term obtained by eight applications of the existing `b0` definition to `d1`. Its mathematical value is 256. This uses only the PA natural definitions, not the hex digit sort or a coercion axiom. Proving its closed range and any conversion to another spelling is setup work.

The expression arguments, all natural numbers, are exactly

    X, x, y, A, a, c, u, v, e, w, f, d, z, k, B.

Uppercase X and A are higher numeral tails. Lowercase x and a are the current digits; y is the row multiplier digit; c is the incoming digit carry. The table outputs have deliberately separate names, including the possibly nonzero final overflow z.

The nine premises are the following five equations and four bounds. Parentheses fix the proposed term shapes.

    E1: x*y = beta*u+v
    E2: (v+a)+0 = beta*e+w
    E3: (w+c)+0 = beta*f+d
    E4: (u+e)+f = beta*z+k
    H:  (X*y+A)+k = B
    Rx: x<beta       Ry: y<beta
    Ra: a<beta       Rc: c<beta.

The conclusion is exactly

    (((beta*X+x)*y)+(beta*A+a))+c = beta*B+d.       (1)

This is a paper specification, not an added theorem. The fixed radix is not a sixteenth expression argument. The four bounds are genuine proof premises, not natural-sort checks. There are no hypotheses on X, A or B beyond being natural. The algebra does not require bounds on u, v, e, w, f, d or k as extra premises.

The explicit zero in E2/E3 matches a full-adder fact with carry input zero. Its removal is inside the proved lift using `add0`. E4 uses e as its second digit and f as its bit carry. The actual closed tables and their range facts must justify that these are valid indices. Nothing here permits an arbitrary numerical lookup to stand in for those proofs.

## 2. Algebraic proof, including the lost overflow

Put t=(x*y+a)+c as an abbreviation in this explanation, not an additional expression argument. Reassociation and substitution of E1 through E4 give the finite chain

    t = beta*u+((v+a)+c)
      = beta*u+((beta*e+w)+c)
      = beta*(u+e)+(w+c)
      = beta*(u+e)+(beta*f+d)
      = beta*((u+e)+f)+d
      = beta*(beta*z+k)+d
      = (beta*beta)*z+(beta*k+d).                 (2)

This uses associativity, commutativity where needed, distributivity, congruence, transitivity and the two zero-addition removals. It does not use subtraction, quotient evaluation or a numerical normalization oracle.

Here is a PA proof of the required upper bound without enumerating byte values. For a positive radix write beta=suc b. Each input bound gives x,y,a,c<=b. Multiplication monotonicity gives x*y<=b*b, and addition monotonicity gives t<=(b*b+b)+b. Successor multiplication and addition identities prove

    suc((b*b+b)+b) = (suc b)*(suc b).

Consequently t<beta*beta. The predecessor b is only a variable inside this generic bound proof. It is not a new per-cell argument or a supplied unchecked witness. For the fixed positive radix it may be beta-1, with the source's predecessor theorem and positivity proof; natural subtraction is used only in that justified predecessor lemma.

If z is nonzero, natural discreteness gives 1<=z, and monotonicity gives beta*beta<=(beta*beta)*z<=t by (2), a contradiction. Thus z=0, and (2) reduces to

    t=beta*k+d.                                   (3)

The same argument also proves k<beta: if beta<=k, then beta*beta<=beta*k<=t. This useful carry bound is mathematically derivable. The literal proposed conclusion (1) does not export it for free as a second proof result.

Finally expand the left side of (1), collect the higher terms, substitute (3), and use H:

    (((beta*X+x)*y)+(beta*A+a))+c
      = beta*(X*y+A)+t
      = beta*((X*y+A)+k)+d
      = beta*B+d.

All identities hold over naturals; no signed cancellation is involved. They handle zero digits and zero carries without a special algebraic branch.

The four ranges cannot simply be omitted from this signature. Symbolically take x=y=beta, a=c=0, u=beta, v=e=w=f=d=k=0, z=1 and X=A=B=0. E1 through E4 and H hold, while (1) would assert beta*beta=0. This is a symbolic counterexample to the range-free statement, not an enumerated byte test.

## 3. Source-backed proof DAG

The following nodes describe a finite proof DAG over existing PA facts. They are proposed reusable lemmas whose proof bodies still have to be written and checked. Their applications can be internal to one fused theorem body, rather than repeated as separate cell events.

1. **Raw equality.** Consume E1 through E4, remove the two explicit zeros, and establish (2) by the displayed chain. Each substitution is an `addeq`/`muleq` congruence followed by equality transitivity. Distributivity and associativity perform only the displayed fixed rewrites.
2. **Digit bound.** Consume Rx, Ry, Ra, Rc and the once-proved positive fixed-radix fact. Use the predecessor, multiplication/addition monotonicity and successor identity above to establish t<beta*beta.
3. **Overflow elimination.** Combine nodes 1 and 2, `le11`, multiplication monotonicity, additive lower bounds and irreflexivity to derive z=0. Substitution and the zero-product/addition lemmas give (3).
4. **Tail lift.** Expand the outer left side by `addmul`, `mulass` and addition reassociation, substitute (3), factor beta with `muladd` in reverse, then substitute H. This yields (1).

These are finite symbolic derivations. The raw equality and outer expansion are not appeals to an unproved ring-normalizer. The source map specifies the exact laws each step uses; a formal author must still choose the primitive proof applications, contexts and intermediate term sharing.

The pinned `examples__peano.mm1` supplies:

|Source lines|Existing interface|Use|
|---|---|---|
|874, 903–905, 920–922|`eqtr3`, `eqtr`, `eqtr4`, their premise-taking variants|Equality chains and reversed identities|
|2034–2050|`addeq`, `muleq`, `addeqd`, `muleqd`; generated one-sided congruences|Substitution into fixed contexts|
|2057–2095|`add02`, `add01`, `addS1`, `addS2`, `addcom`, `addass`, `addlass`, `addrass`, `add4`|Remove zeros and collect summands|
|2105–2153|`mul02`, `mul01`, `mulS1`, `mulS2`, `mulcom`, `mul12`, `mul11`, `muladd`, `addmul`, `mulass`|Successor square identity, distributivity and zero-overflow simplification|
|2175–2178, 2191–2208|`dfle`, `eqle`, `leaddid1/2`, `leadd1/2`, `lesuc`, `letr`|Natural order and additive lower bounds|
|2227–2245|`le11`, `sub1can`, `leaddd`, `leadd`, `lemul1a`, `lemul2a`, `lemuld`|Nonzero implies at least one, predecessor and monotonicity|
|2247–2292|`lt` definition, `lelttr`, `ltletr`, `leltsuc`, `ltirr`, `lt12`|Strict bound and contradiction|
|3011, 3018, 3026–3031|`b0`, `b1`, `b0mul21/22`, `b0ne0`|PA binary radix spelling and positivity|

The arithmetical signature starts in `examples__peano.mm0:168–228`, with natural zero/successor, congruence and PA induction. `b0` is a definition by natural addition. The hex-source coercion axioms are not used. The existing `eqdivmod` and related remainder theorems at mm1:2693–2743 may later connect a row equation to its quotient and low digit, but the cell proof neither invokes division nor assumes a row quotient result.

## 4. Exact arities and a concrete header stencil

The table below counts the specified syntax, leaving the fixed beta term as one atom temporarily. Every equality, addition, multiplication and strict-order head is binary; zero and variables are leaves.

|Expression|Unshared nodes with atomic beta|
|---|---:|
|Conclusion (1)|21|
|E1|9|
|E2|11|
|E3|11|
|E4|11|
|H|9|
|Each of the four range premises|3|

There are eleven beta occurrences in these trees. Keep the existing `b0` and `d1` definition heads in the statement representation: beta then has nine unshared nodes, eight unary b0 nodes and the nullary d1. This gives 172 expression-node visits in an unshared header stencil. Nine `UHyp` commands and one `END` give 182 header commands. These are a possible explicit header, not an emitted compiler result. Unfolding definitions or sharing header subterms changes the count and must be charged from the chosen representation.

The fused call has expression arity a_L=15 and premise arity h_L=9. With all arguments, all nine proofs and the whole conclusion already saved, the reviewed command model gives 9+15+1+1=26 proof-body commands. With all leaf operands including beta saved, but all ten binary constructors of conclusion (1) fresh and no subterm sharing within that conclusion, there are eleven leaf references and ten term constructions, so the call costs 9+15+11+10+1=46 commands. Neither subtotal includes making the premises or operands, proof END for the enclosing theorem, conversions, the 182 header operations, or theorem-body checking at library construction. The fresh conclusion allocates ten binary term nodes, conditionally 240 expression-store bytes under the inspected 16-byte node-header layout. No compiled ABI is asserted.

In the reviewed connected-DAG formula for a 13-by-3 product, substituting this cell signature fixes the previously unknown cell contribution 39*(a_L+h_L) to 936. Thus its symbolic body count becomes

    984+D+C+3*(a_1+h_1)+3*(a_2+h_2)+(a_B+h_B).

Here D must now count any newly applied bound proofs as well as newly applied arithmetic table facts. Cached bound proofs remain external premise leaves. The old D<=156 bound concerned four arithmetic table uses per cell only and is not a bound on this enlarged D. C still counts all expression constructor child requests. The row/base signatures and actual shared DAG remain unprovided. This substitution is not a numerical command count for the whole multiplier.

## 5. What five events do and do not cover

If the four closed equation proofs and four required byte-bound proofs are already available with exact matching natural terms, a cell can use one digit-product table fact, three full-adder facts and this single fused lift. The internal PA algebra is part of the reusable lift's checked body. That is exactly five arithmetic macro events under the baseline's convention. It is not five MMB instructions, and the nine consumed premise proofs are not free.

For the equality-only table format, range establishment is a separate cost. Input x, a and y ranges may be shared with numeral-decomposition proofs. The incoming c and outgoing carry k must be tied to the actual carry values, and the output digit d needs its own d<beta fact when the row is decoded. Although k<beta follows from the cell's inputs, this signature exports only (1). Obtaining that carry bound requires a separately proved theorem application, an additional output/bundle convention, or a retained closed-digit bound. The cost model must choose and charge one. The algebraic equations alone do not imply d<beta.

The first two full-adders also produce bit carries e and f. A complete table implementation must prove their bit ranges and the digit ranges needed for subsequent lookups. One alternative would bundle equality and range facts into each closed table theorem and modify the lift to consume those bundles. That may reduce separately passed premises while enlarging table statements, setup proofs and unification. It is a different signature and has not been counted here. The current explicit nine-premise form makes the boundary visible.

All closed byte facts must be established in PA, for example through recursively proved natural binary arithmetic and its bounded encodings. This packet performs no enumeration, assumes no byte table has already been checked, and does not treat the existing hex `@eval-check axiom` declarations as PA proofs. A conditional lift from equation premises is a proved mathematical implication; it is not closure of those premises for a concrete product.

## 6. Higher-tail direction and the remaining row boundary

At a fixed multiplication row define natural tails X_j and A_j, digit x_j and a_j, incoming carry c_j and output digit d_j. With supplied carries, the cell equation is

    X_j*y+A_j+c_j = beta*B_(j+1)+d_j,
    X_j=beta*X_(j+1)+x_j,
    A_j=beta*A_(j+1)+a_j,
    B_(j+1)=X_(j+1)*y+A_(j+1)+c_(j+1).

The last equality is H, with k=c_(j+1). The untrusted producer discovers carries from low digits to high digits. The acceptance proof can first establish the terminal higher-tail equation, then replay the supplied facts from the highest cell downward. At the terminal position X_m=A_m=0, the raw higher result is c_m. Zero-product/addition identities prove that base. No cyclic proof dependence is needed.

This cell fits the existing row computation A_i+x*y_i. It does not prove the global low/high invariant or the two-per-row count. Those still require the exact accumulated-low representation, A_i<x with x>0, y_i<beta, the resulting A_i+x*y_i<beta*x, a proved low-digit range and quotient adapter, unequal-width padding and the terminal product boundary. The zero operand case also remains part of the row/base specification. Consequently the 5mn+2n+1 template remains conditional as a whole, even though its algebraic cell can now be stated and justified without a new axiom.

## 7. Pins and bounded verdict

All paths below are workspace-relative.

|Artifact|SHA256|
|---|---|
|work/mm0-efficient/toolchain-sources/examples__peano.mm1|13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079|
|work/mm0-efficient/toolchain-sources/examples__peano.mm0|463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052|
|work/qrh-campaign/agents/moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md|E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6|
|work/qrh-campaign/agents/major-constants/REVIEW_MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md|70A5D74BF6D4A5D6FF38B85B3D85F528D7E33E8E49329AF114DD1B4CED0F493C|
|work/qrh-campaign/agents/integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md|3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227|

Owned `radix256_product_cell_syntax_20261111.py` has SHA256 `66FE9884D12E841E103FD4BC9388114DC61F20A91906D3A990508521883E5828`; its receipt has SHA256 `739294D73E02F394A616DE2B404DD07BF677BDE5B59953ED1C3B25BC4EBA0996`. It only constructs formal syntax trees, checks the displayed arities/counts and hashes the five inputs. It refuses to overwrite the receipt. It evaluates no digit-product or arithmetic certificate instance and emits no proof.

The new result is a source-backed paper derivation with a fixed, inspectable cell signature. It removes the unknown a_L,h_L pair for this proposed implementation. Formal construction and checking of that lift, ordinary PA tables/ranges, row/base proofs, the exact packed DAG and complete memory/translation boundaries remain open. No runtime or end-to-end proof-cost saving follows from the cell count alone.
