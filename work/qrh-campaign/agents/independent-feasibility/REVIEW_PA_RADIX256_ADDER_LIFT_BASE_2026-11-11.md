# Review of the PA radix-256 adder lift and base

2026-11-11. PASS at source-backed paper-interface and syntax-model scope. No correction requested. The equality and range-checking variants have the stated arguments and premises, and the high-tail assembly proves natural addition with its final carry retained. This is not a compiled-theorem, emitted-proof or complete arithmetic-backend verdict.

The author is `integration/PA_RADIX256_ADDER_LIFT_BASE_2026-11-11.md`, SHA256 `B34EAE04F56C356894D87DF0FFD765D3403242A5E27257DF9078525D7A173C68`. Its syntax companion is `CA01670BC990B3C1955690FA65455D2CEE06533D32F4FC49C5623CBAD1176241`, and receipt `6E79205E694422F0CC66AD4294246B6369FE8BBE71801943F64BBB16B77C21BC`. Agent paths here are relative to `work/qrh-campaign/agents`.

## Independent evidence and source scope

I read the complete frozen note and syntax program, the reviewed MMB arithmetic-event expansion and the relevant actual PA and C verifier bodies. The independent companion `independent-feasibility/review_radix256_adder_syntax_20261111.py`, SHA256 `005B8D07CA32A0D79BE798383A4813502D9F57B720B51B770E9753F628C13FE9`, performs82 exact source-pin, formal-polynomial and syntax-count checks. Its receipt is `9D19FA76617B82D4D175423BE4B1F16127D31E2599A87395E02981FABA2B76E4` at the same stem with `.json`. It neither imports the author program nor enumerates byte arithmetic instances.

The pinned `work/mm0-efficient/toolchain-sources/examples__peano.mm1` has SHA256 `13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079`. I checked addition associativity/commutativity and `add4` around2077-2095, actual distributivity bodies around2131-2142, the order facts around2191-2333, and the `b0` definition and binary-zero identities around3011-3031. The source includes `ltorle`/`ltnle` at2322-2330, supplying the natural-order case split used in the carry proof. This is a useful explicit completion of that paper proof outline, not a new assumption.

The underlying `.mm0` arithmetic source is pinned at `463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052`. The generic algebra uses its natural addition/multiplication/equality interfaces and existing derived PA facts. It does not use the hex digit-coercion axioms. Constructing and checking the new composite proof bodies, and final foundational closure of the eventual development, remain future work.

For the command interpretation I read `work/formal-goldbach-bench/mm0/src/verifier.c`, SHA256 `71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5`, especially the unification code at243-274 and theorem application at479-515. The source pops the explicit conclusion and expression arguments, checks sorts/dependencies, and runs the theorem's header against premises. A saved pointer must match; independently constructed equal-looking terms are not interchangeable without the relevant proof/conversion. The command types and format sources are also pinned in the independent receipt.

## Exact lift and range boundary

Let beta be the fixed natural term `b0` applied eight times to `d1`. For arguments X,x,Y,y,c,k,d,Z, the two premises are

    E: (x+y)+c=beta*k+d,
    H: (X+Y)+k=Z.

The conclusion is `((beta*X+x)+(beta*Y+y))+c=beta*Z+d`. Formal polynomial reconstruction gives

    residual(conclusion) = beta*residual(H)+residual(E).

The actual PA proof outline realizes this identity by `add4`, associativity, reversed distributivity, congruence and transitivity. No ranges are needed for the equality itself. Thus the equality lift has eight expression arguments and two proof premises and exports only an equality.

The checked variant adds x<beta, y<beta, c<2, k<2 and d<beta. It has the same eight arguments and seven premises. Although the equality proof can ignore these five extra hypotheses mathematically, the application must still supply and check them. The equality conclusion does not export any separately usable range proof.

The carry-bound helper has five arguments and four premises E plus the input-digit and incoming-carry bounds. With beta=suc b, these bounds give `(x+y)+c<=b+b+1<beta+beta`. If2<=k, multiplication monotonicity and natural d>=0 contradict E. Natural order then gives k<2. This proof needs no bound on d. Conversely those premises do not force d<beta: the author's symbolic boundary example with x=beta-1,y=1,c=k=0,d=beta satisfies E and the input bounds. An output-digit proof must therefore come from an actual closed fact or decoder. There is no free inference from a table label or a host integer.

If the carry helper is used, its proof application and its reused premise edges are charged. A carry bound derived inside some other theorem is not an exported proof object. The author correctly separates this from consuming an already retained closed carry-bound proof.

## Assembly direction and endpoints

The terminal identity `(0+0)+c=c` has one natural argument and no premises. It does not require c=0. With A_l=B_l=0 and T_l=c_l, it initializes the high-tail equality. Descending through the digits, each low-digit equation combines with the already proved higher-tail equality to establish the next whole tail. This proves `(A_0+B_0)+c_0=T_0` without circularity.

Carry discovery by the untrusted producer can proceed upward from the low digit. Proof construction proceeds in the opposite direction. The stated stack schedule respects the fixed E,H premise order: leave the current E below the recursively produced H before applying the lift. Reused proof pointers, stack depth and pack limits still require an implementation schedule.

The final carry stays in T_l. A carry1 supplies the highest output byte; dropping it would change natural addition to truncated modular addition. If it is zero, erasing its leading zero is a separate representation equality. Unequal lengths use literal zero padding to the longer length, with any conversion to canonical numeral syntax explicitly charged. For l=0 the base is the whole equality, but an admissible carry bound must be checked independently.

For incoming carry0 the produced equality is `(A+B)+0=T`. The separate three-argument, one-premise zero-carry adapter removes that final `+0`; it is not silently included in the2l+1 macro count. Nor is a radix tail automatically pointer-identical to a separately encoded binary append. Exact numeral/operand binding and any required output-width proof remain mandatory.

## Header, call and DAG counts

I independently rebuilt all five statement trees. Treating the saved whole beta term as an atomic body operand, the equality lift conclusion has ten leaves and nine binary constructors. Expanding every beta occurrence into eight unary b0 nodes plus d1 gives69 header expression nodes; two UHyp commands and END give72. The five range formulas add39 expression nodes and five UHyp commands, giving116.

The verified call/header stencils are:

|Signature|Arguments/premises|Cached call commands|Fresh call commands|Unshared header commands|
|---|---:|---:|---:|---:|
|Equality lift|8/2|12|30|72|
|Range-checking lift|8/7|17|35|116|
|Terminal base|1/0|3|9|8|
|Carry helper|5/4|11|13|52|
|Zero-carry adapter|3/1|6|10|14|

These are legal source-format stencils, not counts extracted from a compiled artifact. The cached case presumes exact retained argument/premise/conclusion pointers. The fresh case still presumes saved leaf terms. Header execution, setup and definition conversions are additional. The38/110 and53/125 byte bounds for the two lift variants follow from the declared reference and term/theorem-ID limits; the216-byte fresh-expression figure is conditional on the source layout, not a measured memory total.

For the connected first-use proof DAG, H=2l and R=9l+2+D0 give11l+D0+C_terms+4 commands including one END. The checked version has H=7l and gives16l+D0+C_terms+4. This uses the reviewed H+R+C_terms+2 counting identity; summing isolated cached-call prices would double-charge first proof uses.

D0 is restricted to newly applied closed facts with zero expression arguments and zero premises. A parameterized carry helper instead adds six expression-root requests and four premise edges, plus its terms. Internal bounds cannot be counted as closed fact applications. Disconnected range roots form a forest and need a real consuming composition before the one-root formula applies. Definition/term construction, actual sharing, theorem boundaries, table generation, source binding and cache resets remain charged rather than hidden in2l+1.

## Verdict limits

The packet supplies coherent paper signatures, a source-supported proof route and reproducible syntax costs. No byte table, proof stream or new declaration was emitted, and no arithmetic instance, build or checker run was performed. Ordinary PA table/range proofs, the new generic lemma bodies, concrete numeral conversions and actual memory/command behavior remain unimplemented. This review approves the conditional interface for future costing, not a compiled theorem, backend completion or runtime saving.
