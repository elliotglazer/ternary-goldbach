# Ordinary-PA square proofs and nonnegative Karatsuba

2026-11-11. Proof-design research and exact recurrence arithmetic only. No arithmetic table, proof stream, modular value, candidate prime or benchmark was generated; no Lean/MM0 build ran. The proposed templates need actual PA proofs and an encoder before their event counts can be compared with executed checker work.

## Main result and scope

A triangular multiply-accumulate algorithm proves x^2 while evaluating each off-diagonal digit product once. It retains a one-digit carry bound and avoids a large column accumulator. Under the existing five-event cell convention, its square template is

    C_raw(n)=5*n*(n-1)/2+12n+3,
    C(n)=min(C_raw(n),5n^2+2n+1).

A modular square still needs the quotient-times-modulus product. With an unchanged schoolbook qM proof, the leading term falls from 10n^2 to 7.5n^2, not to 5n^2. At 90-bit operands in radix 256 the modular-square skeleton changes from 1565 to 1297 events. This is an arithmetic-template saving, not a timing result.

The second candidate uses positive-sum Karatsuba with a supplied nonnegative middle term. Its third child really has h+1 digits, because the operand sums may carry. A safe recursion threshold must be at least three digits. Adaptive fallback to the base proof is much better than forcing recursive decomposition down to that threshold. At 718 and 2871 bits the resulting byte-radix modular-square skeletons are 44049 and 422483, before the separately recorded split/numeral costs. The 90-bit case keeps the base proof.

All formulas concern ordinary PA equalities. There is no native multiplication axiom, signed-arithmetic shortcut, unproved subtraction or implicit carry truncation.

## 1. Baseline and source facts

Use beta=2^b and exact n-digit natural numerals with 0<=x<beta^n. The prior PA plan gives

    S(n)=5n^2+2n+1,
    A(l)=2l+1,
    Q(n)=2S(n)+A(2n)+A(n)+1=10n^2+10n+5.

S is a schoolbook multiplication template, A an addition template, and Q certifies xy=qM+r and r+d+1=M for already bounded residues. A digit multiplication equality, three full-adder facts and one fused algebra step account for each five-event cell. The table theorems must themselves have ordinary PA proofs. Closed natural numerals avoid the extra hex coercion axioms in the source example.

Source proof bodies are in examples__peano_hex.mm1:418--508 and 526--587. In examples__peano.mm1, addass/add4 at 2083/2094, addcan1/addcan2 at 2097/2102, muladd/addmul at 2131/2140 and mulass at 2143 prove the required rearrangements and cancellation. The modular witness implication is eqdivmod at 2693. These sources provide the algebraic basis, not the new fused triangular or Karatsuba proofs themselves.

An event here means a specified table or fixed-lemma application. Actual theorem parameters, proof references, unification, numeral construction and split/concatenation conversions are additional work. Packaging several algebraic steps into a reusable theorem reduces application count only after that theorem has been proved and its instantiation costs accounted for.

## 2. A triangular square with bounded carry

Write x=sum_(i=0)^(n-1) d_i beta^i, with 0<=d_i<beta. Define

    D=sum_i d_i^2 beta^(2i),
    U=sum_(0<=j<i<n) d_j d_i beta^(i+j).

Distributivity and commutativity prove x^2=D+2U. The task is to compute U without inserting the symmetric products a second time or paying an unbounded carry.

For row i=1,...,n-1 let p_i=sum_(j<i) d_j beta^j. Keep the exact invariant

    U_before = L_i + beta^i A_i,
    0<=L_i<beta^i,
    A_i<p_i, or A_i=p_i=0.

Initially L_1=A_1=0. At row i compute B_i=A_i+d_i*p_i using i ordinary bounded-carry MAC cells. If p_i>0, then

    B_i < p_i+(beta-1)p_i = beta*p_i.

If p_i=0 the invariant gives B_i=0, so the row can use the zero case. Write B_i=u_i+beta*A_(i+1), with u_i<beta, and set L_(i+1)=L_i+beta^i*u_i. This proves

    U_after=U_before+d_i*p_i*beta^i.

Moreover A_(i+1)<p_i<=p_(i+1) in the nonzero case; in the zero case the same disjunction holds for the next row. Thus the carry bound is preserved even though p_i grows. Every pair j<i is processed exactly once. The changing cut point moves one digit at each row, so an implementation can stream the low prefix rather than repeatedly perform random access to a PA numeral list.

Inside a cell the accumulator digit and carry are below beta. If the product digits are h,l, three full-adder equations establish the new low digit and high carry. The total cell value is at most

    (beta-1)^2+(beta-1)+(beta-1)=beta^2-1.

Hence the final high overflow is zero. This is a proved bound, not an assumption about machine overflow. The terminal high carry occupies at most n-1 digits, so U fits 2n digits; the polynomial identity further gives 2U<=x^2<beta^(2n).

D is especially cheap: each d_i^2 is a two-digit number, and the blocks occur at positions 2i and 2i+1. They do not overlap. Concatenating these blocks needs no carry propagation. Finally prove U+U and D+2U using two 2n-digit addition proofs. Their final carry is zero because D+2U=x^2<beta^(2n).

The explicit event convention is:

- triangular MAC: 5*n*(n-1)/2 cell events, two row events for each of n-1 rows, and one base event;
- diagonal blocks: n digit-square facts, n concatenation/diagonal-invariant steps, and one base event;
- U+U and D+2U: two A(2n) additions;
- one final algebraic bridge.

The sum is C_raw(n)=5*n*(n-1)/2+12n+3. For n=1,2,3 the generic S(n) is cheaper, so use C(n)=min(C_raw,S). The two row events and the diagonal concatenation step refer to new fixed lemmas to prove. Their representation and invariant-instantiation overhead is retained as D_tri, not assumed to disappear.

This algorithm genuinely prices doubled off-diagonal terms: it doubles the completed U once using an addition proof. It does not silently count each off-diagonal product at half cost while leaving its doubled carries unaccounted for.

## 3. Modular-square bill

For x<M<beta^n, supply q,r,d with

    x^2=qM+r,     r+d+1=M.

The true quotient q is below M and has at most n digits. A wrong q or r fails the checked equalities. The straightforward acceptance proof costs

    Q_sq(n)=C(n)+S(n)+A(2n)+A(n)+1
           =C(n)+S(n)+6n+3.

Only x*x has become a dedicated square. q*M is generally not a square and remains a multiplication. The same modulus across 44 iterations may permit table/reference reuse but does not make the varying q*M products identical or free.

| Radix bits | Operand bits | n | Generic modular Q | Triangular modular Q_sq |
|---:|---:|---:|---:|---:|
|4|90|23|5525|4377|
|4|718|180|325805|246157|
|4|2871|718|5162425|3879002|
|8|90|12|1565|1297|
|8|718|90|81905|62332|
|8|2871|359|1292405|972897|

For the 44-square Proth root test, multiply these skeletons by 44, then add product construction, initial/final residue checks, bounds, coverage and representation costs. At 90 bits in radix 256 this gives 68860 versus 57068 events for the modular-square portion only. Nothing here prices 44 wide product-modulus squares as 44 machine instructions.

## 4. Nonnegative positive-sum Karatsuba

Let h=ceil(n/2), g=floor(n/2), R=beta^h. Split

    x=a+R*b,     y=c+R*d,
    a,c<R,      b,d<beta^g<=R.

Prove the child products

    z0=a*c,     z2=b*d,     zs=(a+b)*(c+d).

Supply m>=0 and verify

    m+z0+z2=zs.

The generic PA distributive identity gives zs=z0+z2+ad+bc. Addition cancellation then gives m=ad+bc. There is no subtraction operation in the acceptance relation and no premise asserting that a producer's truncated subtraction was legitimate. Recombine using two checked additions:

    z=z0+R*m+R^2*z2.

Distributivity proves z=xy. Wrong child products, an omitted z2 in the middle equation, or a bad m are rejected by actual equality checks.

The child sums obey a+b,c+d<2R, so each needs h+1 digits. Charging their product as h-by-h would be unsound. zs<4R^2, the supplied correct middle m<2R^2, and all middle-relation additions fit 2h+2 digits. Final recombination fits 2n digits because its nonnegative terms sum to xy<beta^(2n). Shifts by R and R^2 are exact radix concatenations whose representation proofs are counted separately.

A conservative fixed node schedule uses two A(h+1) input additions, two A(2h+2) middle-relation additions, two A(2n) output additions, and three fixed algebra/bound bridges. Therefore

    H_G(n)=12h+8n+21,
    G_split(n)=G(h)+G(g)+G(h+1)+H_G(n).

The split/concat and numeral representation cost D_G(n) is additional. No padding to an overall power-of-two length is needed; odd n uses the actual g high part and the explicitly grown h+1 sum part.

## 5. Separate square recursion

For a square x=a+R*b, compute z0=a^2, z2=b^2 and zs=(a+b)^2. The same nonnegative middle check proves m=2ab, followed by z=z0+R*m+R^2*z2. Only one input-sum addition is needed, so

    H_C(n)=10h+8n+18,
    C_split(n)=C_rec(h)+C_rec(g)+C_rec(h+1)+H_C(n).

All three children are square proofs. The h+1 child is still mandatory. The base square proof is the minimum of generic schoolbook and the triangular square, not automatically S(n).

For n<=3, h+1 can equal n, so forcing this split can fail to decrease the problem. A safe fixed base threshold is any integer at least 3, with recursion only above it. For every n>=4, h+1<n. This is a termination argument independent of numerical success or runtime. The exact recurrence includes the carry-grown operands at every node.

One may choose the base proof whenever it is cheaper under the chosen cost model. That is a finite dynamic-programming choice of proof schedule, not a trusted inference: every chosen node still has its complete ordinary PA proof. The event-minimizing choice need not minimize bytes, unification work or wall time.

Peeling the single carry bit of a+b could replace a generic h+1 child by an h-digit product plus linear corrections. That requires another fully priced case proof. It is not credited here. Likewise the earlier difference-form Karatsuba avoids sum growth by paying sign/difference witnesses; it remains a separate candidate with its own costs.

## 6. Exact recurrence comparison and missing-cost budgets

The receipt evaluates safe thresholds 3,8,16,32, with either forced splitting above the threshold or adaptive fallback to the base. It separately evaluates general products and squares. The modular-square recurrence total is

    C_rec(n)+G_rec(n)+6n+3.

In byte radix the relevant results are:

| Bits | n | Triangular + schoolbook | Forced threshold 8 | Forced threshold 16 | Adaptive threshold 3 |
|---:|---:|---:|---:|---:|---:|
|90|12|1297|1576|1297|1297|
|718|90|62332|54378|45749|44049|
|2871|359|972897|515270|437907|422483|

The adaptive 90-bit row performs no Karatsuba split. Its general and square components cost 745 and 477 events. At 718 bits they cost 26453 and 17053, with 13 general and 4 square internal nodes. At 2871 bits they cost 253512 and 166814, with 121 general and 40 square internal nodes. These are different recursion trees, not an assumed common threshold for both operations.

Forced splitting to threshold 3 is particularly poor: the byte-radix modular-square costs are 3342,106830,994462. A smaller safe threshold is not automatically a faster schedule. The receipt also includes a deliberately invalid no-growth comparison: for the 359-digit square at threshold 8, replacing the h+1 child by h understates the square skeleton as 209775 instead of 231972. That value is a warning, not an admissible alternative.

The adaptive comparison gives a concrete budget for still-unpriced representation work. Relative to triangular-square plus schoolbook qM, the 718-bit row saves 18283 template events and its two recursion trees have 17 internal nodes with total node widths 660. The 2871-bit row saves 550414 and has 161 internal nodes with total widths 7773. If extra split/concat/representation work is bounded by delta times node width plus gamma per node, sufficient conditions for retaining the respective skeleton advantage are

    660*delta+17*gamma <18283,
    7773*delta+161*gamma <550414.

These inequalities are a future measurement/proof target. They do not establish values for delta or gamma, and they do not include every possible difference between a recursive and flat proof encoder. At 90 bits there is no adaptive Karatsuba saving to spend on extra conversions.

## 7. Representation and verification obligations

The triangular method requires shared/streamed numeral prefixes and suffixes. The low cut advances one digit per row; a generator that repeatedly reconstructs a whole PA list and proves random-access lookups can lose the saving. The diagonal concatenation is mathematically carry-free but still requires a proved representation bridge. Karatsuba similarly requires exact splits, padding of the shorter high part where used, and shifts/recombination of the actual data objects.

Ordinary MM0 Thm applications still process theorem targets and substitutions; local Ref reuse still occupies checked scratch. Table facts, numeral definitions, and generic lemmas need their own PA proofs. A 64-bit/reclaiming implementation of the same rules may change feasible pack sizes, but no changed rule or native multiply oracle is assumed here. Lean native big-integer reduction, ordinary MM0 arithmetic proof steps and a separately verified executable arithmetic extension remain different cost paths.

Before choosing a production method, produce matched complete modular-square certificates with the same operands and quotient/remainder witnesses. Include the generic qM proof and r<M certificate, not just x^2. Then compare direct 90-bit roots with actual product-width batches, table/setup proofs, generation, encoded bytes, statement metadata, scratch, checker time and failed controls. There were no such evaluations in this task.

Required negative controls for a future implementation include a corrupted off-diagonal product, missing factor 2, discarded carry, malformed diagonal concatenation, wrong middle m, omitted z2, h-digit truncation of a sum, bad quotient, and incorrect final remainder bound. The algebra above explains why the genuine checks reject them; it does not substitute for implementation tests.

## Pins and exact-only evidence

- mm0_square_karatsuba_sizes_20261111.py: 64C11ADCA0ABAB02A95F617AD326F051A3B871F97CF2D4458DFEF4825607039C.
- mm0_square_karatsuba_sizes_20261111.json: D2E5F35DB7D75C44F8DDD9405D60D78D475A123676CAC036D0CF0F6FFA47D073.
- integration/EFFICIENCY_MM0_LADDER_ARITHMETIC_2026-11-11.md: 3D8116AC2D53E33DA76DF0FE7AE42211AAB4D7B5C3D954746587D8DC9EF21227.
- EFFICIENCY_MM0_DIGIT_TABLES_2026-11-11.md: DAA7F4625A1CCF8D9307AF59D1FA0C74416CCF38F9B87BBC8547C0F0D74836F3; its independent integration review: 1D4C6FADEC317AF21A3442D7D748405D5CD827173BF298231F871853DF9AEE1B.
- examples__peano_hex.mm1: 76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94.
- examples__peano.mm1: 13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079.

The scalar recurrence script exited zero. It performs only bounded integer recursion and size/event arithmetic, with no tables, proof generation, modular values or timing claims.
