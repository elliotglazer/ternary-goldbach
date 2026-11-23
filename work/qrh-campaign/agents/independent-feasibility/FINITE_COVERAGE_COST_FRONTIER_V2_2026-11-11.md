# Finite coverage costs with size bands and joint cutoff selection

2026-11-11. Source, paper, and exact integer metadata only. No prime search, modular residue, analytic value, build, or new Lean declaration was evaluated. Earlier reports are unchanged.

The new decision rule has two parts. Before a prime pool exists, a reverse coverage bound prices the mandatory high-width rungs separately from cheaper early rungs. After a pool exists, a Pareto recurrence selects the cutoff and path together, including distinct proof-production and verification prices. Neither requires a prime-density assumption. They sharpen the previous equal-rung comparison without selecting an unsupported numerical optimum.

The target is N0=989*10^24 and T=N0-1. A complete implementation still needs the accepted analytic branch at N0, a binary proof through the chosen even B, and the finite coverage proof described below. This note does not supply those numerical certificates or establish final axiom closure.

## 1. Exact coverage and what changes in the source

`Statement.lean:28` defines binary coverage of every even integer in [4,B]. `Helfgott/SmallCases.lean:21` uses prime 3 for its initial range and an odd prime p in [n-B,n-4] thereafter. Its current literals are B=4*10^18 and upper target 10^27. The source argument permits the following paper replacement, which is not yet a new implemented theorem:

    B is even, B>=4;
    3=p0<p1<...<pK<=T-4, every pi is a certified odd prime;
    pi-p(i-1)<=B-2 and pK+B>=T.

Prime pi covers the odd targets [pi+4,pi+B]. The next interval starts at most two beyond the previous endpoint, so no odd target is lost. Prime 3 starts at 7. The binary remainder is even and lies in [4,B]. Hence the chain covers every odd 7<=n<=T. Smaller B does not establish the unchanged `BinaryGoldbachInput` through 4*10^18; it requires replacing that finite-reduction input and its consumer together.

Write D=B-2 and restrict this comparison to 4<=B<T-3. Every such chain has at least

    Kmin(B)=ceil((T-B-3)/D)=ceil((T-5)/D)-1

new primes after p0. These are necessary counts, not prime-existence guarantees. All proposed B from 10^15 through 4*10^18 satisfy the restriction.

## 2. Complete costs, kept separate by purpose

For a fixed system and representation, maintain a cost vector rather than one unexplained operation total:

    C = (native search/generation, ordinary proof construction,
         ordinary verification, serialized bytes, peak live state).

Time components can be given explicit planning weights later. Bytes and peak state may instead be constraints. Native arithmetic, Lean kernel arithmetic, and ordinary-rule MM0 proof applications are not interchangeable units. No component here uses a new arithmetic oracle or a hash as a proof.

For each additive work component, price

    Binary(B,L) = source certification and factor cache
                + initial binary interval
                + all successful/failed anchor generation
                + chosen anchor certificates
                + complete residual/OR/convolution coverage checks
                + exceptions, decoding, binding and range assembly;

    Ladder(path,format) = pool search and failed candidates/bases
                       + root/factor witness production and conversion
                       + selected primality proofs
                       + product trees/CRT if used
                       + exact path, boundary and terminal checks
                       + parsing, proof construction and I/O.

Shared setup is charged once, only when the same certified object is reused. Library development and the source-to-final-theorem assembly remain separate fixed costs. If source or factor caches are reused by both components, use their actual union and lifetime, not two full charges or a free second copy.

The existing block model is retained exactly. E=B/2, R=floor(E/L), and source indices run through L+Dsrc-1, where Dsrc=2^19 is unrelated to the ladder gap D. For r=1,...,R an anchor is 2rL-(2s+1), 0<=s<=Dsrc. Source index t+s supplies the other prime. The initial interval has L-2 even targets. Full outer blocks have L targets; the last has E-RL+1, including one target when L divides E. Their sum is E-1. Every positive source bit must be prime; the source bitmap itself need not contain every prime. A survivor-based sieve proof does require the complete recursively certified base-prime list through the square root of its bound.

For L=2^32,2^34,2^36 the raw odd-source bitmap capacities are respectively 536936448, 2147549184, and 8590000128 bytes. These exclude certificates, caches, residual masks and arithmetic temporaries. Tiles with a Dsrc halo can stream, but all required source uses must be discharged before disposal; repeated re-sieving is a real cost. A coverage proof must account for omitted zero residual words, every nonzero residue exception, and the enlarged initial interval when L increases. The earlier source and residual-tree reports remain the implementation contracts; this note does not assume an unproved common anchor template.

## 3. Nonuniform primality prices

For an eligible supplied-root candidate p, let

    w(p)=bitlength(p),
    e(p)=min{m>=0 : p<(2^(m+1)+1)^2}.

The size-band report and its review prove the parameterized version of `Ladder/Spec.lean:38`: an odd p>1 satisfying that strict size bound and p | y^(2^m)+1 is prime. It has e(p)<=44 here. A producer already testing a 44-square root can retain the appropriate intermediate state; the checker needs only the shorter suffix. It does not check the omitted prefix. Converting an old root file or changing an opaque producer can cost extra work.

The direct verification price is therefore

    cV(p)=e(p)*SV(w(p))+OV(p),

where SV includes the modular square, its reduction/range evidence, and the relevant proof handling. OV includes root decoding, equality and candidate/path binding, apart from any separately charged global band header. The proof-construction price cP has its own SP and OP. Native generation cG includes the original search and tests; it is not reduced to e(p) squares just because the final proof is shorter. Root capacity is w(p) bits before byte packing, but proof terms and quotient/remainder witnesses can be much larger.

For a product batch J, use mJ=max e(p), and bJ=bitlength(product p). Its square subtotal is mJ*SV(bJ). Add product binding, tree construction, CRT production, exact array coverage and actual-size framing. Do not substitute the average leaf width for bJ. Cutting batches at the at most 44 order boundaries adds at most 44 batches, but those extra trees and partial batches are not free. Grouping by actual width may add more boundaries. Direct checks avoid CRT and keep operands narrow. Product checks reduce the number of chains, not necessarily total work under a superlinear arithmetic price.

Smooth-F, general Pocklington and exceptional primes can coexist, with their actual certified formats and costs. The numerical lower-bound rows below deliberately concern the all-supplied-power-of-two-root architecture. They are not lower bounds for every possible primality proof or every formalization.

## 4. A reverse, width-aware coverage lower bound

The terminal condition gives pK>=T-B. Working backwards across gaps at most D yields

    p(K-j)>=T-B-jD  for 0<=j<Kmin.

There are enough indices because K>=Kmin. Each right-hand side is an odd integer at least 5. For any nonnegative nondecreasing per-record price c,

    sum(i=1..K) c(pi) >= LBc(B)
      := sum(j=0..Kmin-1) c(T-B-jD).                    (1)

This uses only geometry. The right-hand labels are not claimed prime. If c=e*SV(w)+OV(w), it is nondecreasing whenever the supplied price schedules SV and OV are nonnegative and nondecreasing. A measured or proved nonmonotone price schedule must first be replaced by a valid nondecreasing lower envelope; do not assume monotonicity merely from an implementation's name.

Equation (1) is computable without enumerating Kmin labels. Split at powers of two, where w changes, and A_j=(2^j+1)^2, where e changes. For any threshold z, the number of reverse labels at least z is exactly

    n_z = min(Kmin, max(0, floor((T-B-z)/D)+1)).          (2)

Subtract adjacent n_z values to obtain every band population. At most 134 width/order changes are relevant below N0. Multiplying these populations by a price vector yields a conditional lower bound for each ordinary-proof architecture.

The exact companion gives these examples. The last column is a sensitivity basis with SV(w)=w^2 and OV=0, not a machine-operation count or a proved complexity law.

| B | Kmin | Mandatory square-call lower bound sum e | Sum e*w^2 on reverse labels |
|---:|---:|---:|---:|
|10^15|989000000000|43103353320226|339761324983656960|
|2*10^15|494500000000|21551676660105|169880662491749854|
|10^16|98900000000|4310335332008|33976132498202696|
|2*10^16|49450000000|2155167665996|16988066249012824|
|10^17|9890000000|431033533185|3397613249639632|
|2*10^17|4945000000|215516766581|1698806624708106|
|4*10^18|247250000|10775838307|84940331029993|

This complements the earlier forward bound on saved squares. It limits how cheaply one can move all mandatory work into low-width bands. A small extra prime cannot remove the forced terminal suffix.

For mixed formats, (1) remains valid if c is a proved common lower price for every admitted format at that size. The supplied-root rows cannot serve as that common lower price without a separate argument. Search cost has no corresponding monotonic lower schedule here, other than trivial nonnegativity.

## 5. Excluding cutoffs and locating a conditional interior choice

Suppose an actual complete feasible construction has a cost upper bound Cinc in one selected scalar objective. Suppose BinaryLB(B,L), fixed setup Smin, and c in (1) are sound lower prices for every candidate in the restricted comparison. Then reject B whenever

    inf_L BinaryLB(B,L) + Smin + LBc(B) > Cinc.         (3)

This is a genuine decision test once those bounds exist. It uses the width/order populations and does not require knowing future prime locations. It cannot reject a different certificate architecture whose lower price was never included.

There is also a useful continuous interpretation with a controlled rounding error. Extend a monotone step price c(t) by zero below 5. Put Y=T-B and

    J(B)=integral from 5 to Y of c(t) dt.

The reverse labels are right endpoints of adjacent intervals of length D, starting below 5. The right-Riemann upper/lower comparison telescopes and gives

    J(B)/D <= LBc(B) <= J(B)/D + c(Y).                 (4)

Thus the smooth approximation misses this mandatory suffix price by at most one top-price record, not Kmin times a guessed error. The integral of this step function is a finite rational sum when the prices are rational.

For the specified explicit 64-bit word schedule, binary target words number ceil(D/128). This is not a universal proof-size lower bound; a different coverage proof may have different units. In the ideal comparator a*ceil(D/128)+LBc(B), the corresponding smooth expression differs by at most a+c(Y). If the top endpoint remains in one price band, define

    Jstar=integral from 5 to T-2 of c(t) dt.

Then J(B)=Jstar-c_top*D, and the smooth expression is

    a*D/128 + Jstar/D - c_top.

Its interior stationary gap is D*=sqrt(128*Jstar/a). This replaces an equal-rung price times T by the actual width/order-weighted integral. It is a model balance, not an existence theorem for a prime chain with those costs. Multiplying all ladder prices by lambda changes D* by sqrt(lambda); changing binary prices changes it inversely. Proof construction and verification generally give different Jstar/a and hence different choices of B. Search-dominated total work need not have this form at all.

In the equal-price specialization c(t)=c for t>=5, a feasible-incumbent screen can be written without square roots. With A=T-5, the old ideal expression is

    C0=S+a*ceil(D/128)+c*(ceil(A/D)-1),
    L0=S-c+a*D/128+c*A/D,  0<=C0-L0<a+c.

For a>0 let Q=(Cinc-Smin+c)/a and r=c/a. A necessary condition to beat the incumbent within that lower-cost model is

    D^2-128*Q*D+128*r*A <= 0.                          (5)

All terms can be compared exactly. For the new nonuniform model, use (2)-(3), or the finite-step integral (4), instead of substituting a 90-bit maximum cost as a lower cost for every rung.

Without bounded complete category prices, a feasible incumbent, and an admitted family of certificates, these formulas do not bound the true optimum. No interior optimum follows from counting squares alone. Even a promising interior B can have unexpectedly expensive failed windows, source coverage exceptions, or proof handling.

## 6. Exact joint cutoff/path selection after certification

Let a finite pool 3=q0<...<qM<=T-4 consist of genuinely certified primes. Available certificate variants at each vertex carry additive price vectors, for example (proof construction, verification, bytes). Pool generation already performed is a shared sunk cost when comparing paths through this same pool. It must still appear in the end-to-end ledger; selecting fewer vertices does not refund unsuccessful searches or discarded certificates.

A prefix ending at qj has label (b,w), with b the maximum of 4 and its edge gaps plus two, and w its accumulated additive price vector. Start at q0 with (4,0). From qi to qj, i<j, propagate

    (b,w) -> (max(b,qj-qi+2), w+price(qj)).

At the same vertex, discard a label if another has no larger b and no larger value in any cost coordinate. Every common suffix preserves this ordering. At termination replace b by max(b,T-qj). The exact path works precisely for even B at least that terminal label. For any nondecreasing complete binary price Binary(B,L), evaluate its least admitted B and add w. This yields the best path and cutoff in the fixed pool for the specified additive objective. A cost model can enforce this by allowing restriction of available larger binary proofs and charging a common bound for that restriction. Mere logical restrictability does not make an implementation's measured cost monotone. If its quoted cost is nonmonotone, the least admitted B need not minimize it. Use inf{Binary(B'): B'>=b} plus a uniform charged restriction bound, or search the allowed larger cutoffs and retain their costs explicitly. Path-threshold breakpoints alone do not then locate every cost minimum.

All possible minimal cutoffs lie in

    {4} union {T-qj} union {qj-qi+2 : i<j}.

These numbers are even. This is an exact staircase, including mixed-F transitions. It avoids the invalid inference that unchanged individual lattice cells preserve a chain with changing F. The previously frozen pruning erratum remains in force.

The rule is an optimization aid, not a new proof premise. A final checker needs only the selected primes, valid certificates, all edges, and the terminal condition; it need not trust or formalize the optimizer. Exhaustive optimal selection can be expensive: there may be quadratically many breakpoints and many Pareto labels. No full-scale graph algorithm is promised. A bounded pool or macroblock implementation can exploit this rule, with exact boundary states. Branch pruning using (3) can precede such search.

Nonadditive product batches, factor-cache setup, and reuse between records require additional state. A direct-root baseline is genuinely additive after explicit shared setup. A batch-aware optimizer must remember enough pending factors/format/context to price the next batch and final partial batch. Treating each member as one nth of an average full batch invalidates the recurrence. Peak memory combines by maximum of live state, not summation; omitted lifetime state can invalidate dominance. Additive file bytes likewise exclude shared library bytes until those are accounted for separately.

The companion exhaustively checks this Pareto rule on a tiny pool of odd integer labels against all its subsequences, with separate generation-like and verification-like weights. Some labels are composite. This tests only the finite optimization identity, not primality or prime availability.

## 7. Implementation decision

Use direct size-band root proofs as one clear narrow-arithmetic baseline, then compare actual product batches and alternative prime certificates with all added production and bytes. Price the complete binary block at each L, including source/base-list certification and residual exceptions. Keep the construction and verification tables separate for Lean and ordinary-rule MM0.

For already certified data, use the exact joint cutoff/path rule or a bounded stateful version; avoid choosing B from an average-rung assumption. For not-yet-produced data, use the reverse width histogram to exclude candidates only after a justified price bound and feasible incumbent are available. The highest-value next information is a matched complete-category price interval for source/coverage and modular proof work, plus actual exception/search statistics under a declared producer. Those are future measurements, not results of this note.

Streaming bounds resident values only if the implementation releases them. A source tile/halo, a bounded ladder batch and its trees can be live at once; proof-local reclamation and imported theorem context need their own accounting. Stock MM0 file/index limits and any proposed bounded-state verifier engineering remain constraints. Lean sharing/elaboration and ordinary-MM0 term generation cannot be inferred from raw integer payload size. No runtime hours, prime existence, or end-to-end dominance is claimed.

## 8. Evidence and pins

Owned `finite_coverage_cost_frontier_v2_20261111.py`, SHA256 `DA3FBF545ED5AC5DC34529DC87AA09C39CFABE003CD09094EDA827CBAB6F99FF`, ran 3832 exact checks. The receipt `finite_coverage_cost_frontier_v2_20261111.json`, SHA256 `4026FD4C556DCC475367AE7E1CEE5DCB2E654914E8568130FAA3140C54E2E39C`, retains all band populations and source hashes. Checks compare compressed counts with literal small integer geometries, exhaustive synthetic paths with the Pareto recurrence, and exact rounding inequalities. The script imports no producer or numerical evaluator and writes only its new receipt.

All paths below are relative to the repository root. Full file hashes, rather than reported totals alone, bind the inputs.

| Source/report | SHA256 |
|---|---|
| work/ternary-goldbach/TernaryGoldbach/Statement.lean | 3F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8 |
| work/ternary-goldbach/TernaryGoldbach/Helfgott/SmallCases.lean | 61B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359 |
| work/ternary-goldbach/TernaryGoldbach/Ladder/Spec.lean | 0009820117E19E6B41B92C6879145569ABA9D4FDE25BF7FFE926AC0B3602901F |
| work/qrh-blueprint/BINARY_BLOCK_SCALING_2026-11-11.md | 982115AD458F718039B391DAEA714E25C5E80823C49B537ED78FEC8F155480CD |
| work/qrh-campaign/agents/prime-estimates/FINITE_GOLDBACH_GLOBAL_COST_FRONTIER_2026-11-11.md | F950F36C3361A4BABB253B502168B613893DB5DCD002599A7BC261A950A16FC6 |
| work/qrh-campaign/agents/prime-estimates/FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md | 14F7E2E2E16342FC9D30CD6EEBA2E2FE968C1EF7B1AB21EE9625097FE1E50AA3 |
| work/qrh-campaign/agents/integration/REVIEW_FINITE_LADDER_SIZE_BAND_CERTIFICATES_2026-11-11.md | B68F2CF8C364430AB324860838B9387C1B37503FF61FB7FF1F885EB1635E6654 |
| work/qrh-campaign/agents/prime-estimates/SUPPLIED_ROOT_PRODUCTION_PAYLOAD_2026-11-11.md | EA13551BB8A8C572F983A26EC57E4F3FCD3E658F86DCE8252BABF70002814044 |
| work/qrh-campaign/agents/independent-feasibility/BINARY_SOURCE_BITMAP_COST_DESIGN_2026-11-11.md | 4B877FC2377CEB81C60CE139331ED5380AB0CB78011DE500D8768B2F837B99EA |
| work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_COVERAGE_2026-11-11.md | EEED5871CE2A7737F01D92CDBC0D362BA42307FF58D0A1192892989C4FBF8436 |
| work/qrh-campaign/agents/moebius/EFFICIENCY_BINARY_ADAPTIVE_JOINT_SELECTION_2026-11-11.md | FF655308043C2627F8E757AF238E0275F055B483A9C3F7BC4E01503ABC8089BC |
| work/qrh-campaign/agents/moebius/ERRATUM_BINARY_ADAPTIVE_PRUNING_2026-11-11.md | 98A6C32B43C63354AC044B5757BD30C92D84C18317AE9A0D38C5BF4A0D1F130B |
