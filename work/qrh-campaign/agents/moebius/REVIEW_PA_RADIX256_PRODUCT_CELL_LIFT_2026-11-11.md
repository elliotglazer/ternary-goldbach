# Review of the PA radix-256 product-cell lift

2026-11-11. PASS for the paper implication and static count model, subject to the mandatory closed-fact clarification below. The fixed cell has a sound natural-number proof with fifteen expression arguments and nine premises. It does not establish a formally checked byte arithmetic library or the complete rectangular-product schedule.

No builds, declarations, proof emission, digit-value enumeration, arithmetic instances or function evaluations were performed. The independent companion checks formal polynomial coefficients, syntax trees, source snippets and hashes only. Author and earlier frozen files remain unchanged.

## 1. Reviewed artifacts and correction

Author paths are under `work/qrh-campaign/agents/prime-estimates/`.

|Artifact|SHA256|
|---|---|
|PA_RADIX256_PRODUCT_CELL_LIFT_2026-11-11.md|3670294B3CAE9C9459344571FEFAF80BB4D36FCD60EADE47AFEDB03E020EC74E|
|CLARIFICATION_PA_PRODUCT_CELL_CLOSED_FACT_COUNT_2026-11-11.md|F0705C64C524D9AC3051C51507DA9BCF0FD368796C0EE63A43518AB1C035F9D2|
|radix256_product_cell_syntax_20261111.py|66FE9884D12E841E103FD4BC9388114DC61F20A91906D3A990508521883E5828|
|radix256_product_cell_syntax_20261111.json|739294D73E02F394A616DE2B404DD07BF677BDE5B59953ED1C3B25BC4EBA0996|

The original section 4 said its term D could count "any newly applied bound proofs." That was too broad for a coefficient of one. The companion restricts D to newly applied closed facts with zero expression arguments and zero premises. A parameterized range/decomposition/carry lemma contributes its actual `a+1` expression requests, premise edges and new term-child requests through `H+R+C+2`. Cached facts remain external premise references. This repair is required for the count formula, and it does not alter the algebra or the 15/9 cell signature.

Own script `moebius/review_radix256_cell_20261111.py`, SHA256 `6034150C54644BEF14511D0ACF90ED79F1043ECB7643EE55972E3F64804A1756`, and receipt `review_radix256_cell_20261111.json`, SHA256 `C102DD3F044B94FCC7CCED6D5AACC3DBCE2DDCDBD38A7322AD6F58169714BEAC`, pass 30 checks. The receipt binds the original mathematical packet and source pins; the clarification was separately read and hashed for this review. The author syntax script was read, not imported or run.

## 2. Cell identity and necessity of the bounds

For the fixed positive natural beta=256, name the four table-equation residuals formally:

    e1 = xy - beta*u - v,
    e2 = v+a - beta*e - w,
    e3 = w+c - beta*f - d,
    e4 = u+e+f - beta*z - k.

This subtraction notation is used only in the review's formal polynomial dictionary. The actual natural proof is the author's equality chain and uses no unjustified natural subtraction. The exact polynomial identity is

    xy+a+c - beta^2*z - beta*k - d
       = e1+e2+e3+beta*e4.

The two explicit zero carry inputs in the source-shaped E2/E3 are removed by the natural zero-addition identity inside the proposed lift. Hence the four equations imply

    t = beta^2*z + beta*k+d,       t=xy+a+c.

The ranges x,y,a,c<beta are essential. Write beta=b+1, justified for a positive natural radix. Each range gives its input at most b. Multiplication and addition monotonicity give `t<=b^2+2b`, while the successor identity gives `b^2+2b+1=beta^2`. Thus `t<beta^2`. If z is nonzero, `1<=z` contradicts this bound; z=0. The same argument gives k<beta, although that fact is not an exported conclusion of the equality-only signature.

With the higher-tail equation `(X*y+A)+k=B`, expansion gives

    (((beta*X+x)*y)+(beta*A+a))+c
      = beta*(X*y+A)+t = beta*B+d.

The independent formal dictionary verifies both displayed polynomial identities and the successor-square identity without assigning any variable a digit value. Zero input digits and zero carry are covered by the same proof. No division, primality assumption, hidden signed order or hex-sort axiom enters this cell implication.

The author's symbolic counterexample without ranges is valid: x=y=beta, a=c=0, u=beta, z=1, all remaining small outputs zero, and X=A=B=0 satisfy the five equations but falsify the conclusion for positive beta. Thus four table equations plus a tail equation alone do not prove the proposed equality.

## 3. Source support and exact signature

The inspected `examples__peano.mm1` is pinned at `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`; `examples__peano.mm0` is pinned at `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052` under `work/mm0-efficient/toolchain-sources/`.

The source bodies supply the immediate laws needed by the paper proof: addition associativity and permutation at 2077–2095; zero/successor multiplication, distributivity and multiplication associativity at 2105–2153; natural additive lower bounds at 2191–2208; `le11`, `sub1can`, addition and multiplication monotonicity at 2227–2245; strict-order conversion and irreflexivity at 2247–2292. The relevant `b0` definition at 3011 is natural doubling, and `b0ne0` at 3031 supplies its nonzero preservation. Eight nested b0 applications to d1 give a PA natural spelling for the fixed radix. The positivity/value/alternative-spelling proofs are setup work, not additional per-cell arguments.

The author maps the fixed substitutions to congruence and transitivity rather than invoking a ring-normalization oracle. These are existing immediate source bodies. This review does not claim a new compiled proof or a complete newly checked axiom-closure extraction of the surrounding library.

The fifteen arguments are exactly `X,x,y,A,a,c,u,v,e,w,f,d,z,k,B`. There are five equation premises and four range premises. A natural sort check supplies none of the four bounds. The conclusion is only the prefix equality. It does not export k<beta or d<beta, and the equations do not imply the latter. Concrete carries and output digits must be tied to separately proved closed-digit bounds, or a changed/bundled signature with its actual proof costs must be used. The author explicitly retains those obligations.

## 4. Command accounting and remaining row work

The independently reconstructed abstract-beta tree sizes are

    [21,9,11,11,11,9,3,3,3,3].

Their sum is 84; eleven beta occurrences each expand by eight additional nodes when beta is represented by eight b0 heads and d1. Thus the unshared expression header has 172 nodes, and nine UHyp plus END give 182 header commands. This is an explicit possible header stencil, not compiler-output evidence.

With all arguments, nine premise proofs and the whole conclusion saved, the call uses 26 proof commands. With beta and all variable leaves saved but the conclusion's ten binary nodes fresh, it uses 46. The expression-store allocation is `10*(sizeof(store_term)+8)`, or 240 bytes under the declared 16-byte header layout. Setup, premise proofs, the unifier executions, enclosing END, signature checking and any conversions are separate. These conventions match the accepted MMB report E57FCF24 and its independent review 70A5D74B, whose full pins are retained by the author receipt.

In the conditional 13-by-3 product formula, the cell contribution is `39*(15+9)=936`, giving the displayed base constant 984 after adding the prior 48. With the mandatory clarification, D covers only closed zero-argument/premise facts. Arbitrary parameterized range proofs cannot be counted as one such fact. The actual term-child count C and row/base arities are still unknown.

The higher-tail proof direction is sound. Supplied carries satisfy a row relation `B_j=beta*B_(j+1)+d_j`; the terminal tails are zero and `B_m=c_m`. The producer may discover carries from low to high while the acceptance proof combines the already supplied equations from high to low. This introduces no cyclic proof premise. Every carried value and tail must nevertheless use the exact matching source term.

The cell does not discharge the whole multiplication invariant. The remaining row proof must establish the accumulated low part, `A_i<x` with x>0, the digit bound on y_i, `A_i+x*y_i<beta*x`, output digit ranges, quotient/remainder decoding, unequal-width padding, zero case and the terminal product. Two row events and one base event remain proposed counts until their precise signatures and dependencies are supplied. Likewise, E4's actual lookup needs e and f in its stated digit/bit domains; the algebra's conditional implication is not a proof that an arbitrary table lookup is admissible.

The result therefore fixes one missing reusable cell signature and its mathematical proof. Five arithmetic core events per cell remain a valid conditional convention with separately charged range/setup/reference work. It supplies no complete 202-event multiplier, ordinary arithmetic proof generator, runtime saving or full MM0 analytic foundation.
