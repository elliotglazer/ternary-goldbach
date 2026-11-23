# Reusable binary cover theorems and their arithmetic obstruction

2026-11-11. Source and finite combinatorial research only. No prime candidates, sieve, source-prime bitmap, analytic functions or production range were evaluated. No Lean declarations or builds were added. Existing frozen reports are unchanged.

There is a valid additional compression beyond the existing sparse-anchor and packed-convolution proposals: **prove a source-offset cover once, with the outer block number universally quantified**, then instantiate that theorem for every block whose corresponding anchors are certified prime. An exact hitting-clause variant can share more than identical offset lists. This can remove repeated coverage arithmetic in ordinary Lean or MM0 proofs, not merely compress a native checker's input. Its usefulness depends on actual reuse or clause compression, neither established here.

A fixed dictionary cannot be assumed to work. Small-prime congruences already make many proposed templates unusable for every large block. A CRT argument shows that every fixed finite offset palette has infinitely many completely blocked outer blocks. That does not disprove coverage of a particular finite B, but it rules out an unconditional universal-success claim for this compression. Existing complete residual/witness checking must remain available.

## 1. Existing work and exact target

The prior BINARY_SOURCE_BITMAP_COST_DESIGN gives a certified source-prime table and its recursive complete-divisor sieve. EFFICIENCY_BINARY_COVERAGE already gives residual trees, exact subset accounting, span-normalized packed convolution and explicit exceptional representations. BINARY_BLOCK_SCALING separates the source length L from the binary cutoff B. Those are retained components, not new claims of this note.

The actual target is Statement.lean:26, BinaryGoldbachUpTo B: every even integer n with4<=n<=B is a sum of two primes. Statement.lean:64 fixes the old BinaryGoldbachInput at4*10^18, and Helfgott/SmallCases.lean:21–40 consumes that fixed input with its ladder. A new smaller-B proof needs the separately proposed generalized ternary reduction; proving a smaller prefix does not prove the old fixed input. No analytic or ternary threshold is changed here.

Let B be even, E=B/2, and choose L,D with E>=L>=D+2. Let P be a fixed bit string of length J=L+D with the proved interpretation

    P[j]=1 implies Prime(2j+1),   0<=j<J.             (1)

No completeness of this top-level table is needed. Soundness of all its set bits is needed. Its recursive sieve still needs complete base-prime lists, as the prior source-table report explains. In particular P[0]=0. The prime2 is handled separately.

The outer blocks have r=1,...,R=floor(E/L), width w_r=min(L,E-rL+1), target n=2(rL+t),0<=t<w_r. An offset s in[0,D] specifies

    q(r,s)=2rL-(2s+1),
    2(rL+t)=q(r,s)+(2(t+s)+1).                       (2)

Here q(r,s)>=3 follows from L>=D+2 and r>=1. Also t+s<L+D. Natural subtraction in (2) must be justified by this bound, not treated as integer subtraction without proof.

The initial range4<=n<2L remains separate and may use recursive blocks or explicit certified sums. The exact number of targets is

    (L-2)+(R-1)L+(E-RL+1)=E-1.

If L divides E, the last width is1. This endpoint and the initial range remain obligations under every compression below.

## 2. A universally reusable full-cover template

A template is a finite nonempty set S of distinct offsets in[0,D] such that

    for every 0<=t<L, some s in S has P[t+s]=1.       (3)

Verify (3) once by the existing exact tiled OR or packed-convolution checker. Bind its proof to the exact P,L,D and offsets, including all tiles and source halos. The new reusable theorem has the precise statement

    for every r>=1, if every s in S has Prime(q(r,s)),
    then for every t<L, 2(rL+t) is a sum of two primes. (4)

Proof: choose the s from (3). Equation(1) proves primality of the source summand and the premise of(4) proves primality of its anchor. Equation(2) proves the sum. This argument does not evaluate P again and does not inspect t separately at each r. Restricting(4) to w_r<=L handles the final partial block.

A dictionary contains finitely many such checked templates. For each outer block, its certificate selects a dictionary identifier and supplies actual primality proofs for that template's q(r,s). No claim that all candidate anchors are prime is accepted. A hash, probable-prime flag or template identifier cannot replace those proofs. An invalid identifier or a failed anchor rejects this branch. Another dictionary template or the existing complete residual/witness branch may still prove the block.

The theorem(4), not just the mask bytes, must be reused. In Lean it can be a shared opaque theorem applied to r and its prime proofs. In ordinary MM0 it can be an earlier universally quantified theorem with ordinary specialization and modus-ponens derivations. The defining mathematical source table is fixed in that theorem; it must not be replaced by an unchecked equal hash. No custom arithmetic acceptance instruction is required in principle. Concrete source/cover arithmetic still needs proof terms or supported kernel reduction once.

This sharing is across outer blocks. It differs from the prior residual tree's sharing of a prefix among subtiles of one block. It also differs from NTT reuse: the complete finite coverage conclusion is already proved, rather than recomputing a convolution for a new anchor polynomial.

The anchor proofs generally do not share by value. Because D<L, q(r,s)=q(r',s') with r!=r' would imply |r-r'|L=|s-s'|<=D, a contradiction. Thus distinct outer blocks require distinct anchor-prime facts in this format. Their primality certificate arithmetic, generation and checking remain in the cost.

## 3. Sharing a hitting formula instead of identical templates

Fix a finite distinct palette S={s_0,...,s_(M-1)} in[0,D]. Its source row at target t is

    H_t={i<M : P[t+s_i]=1}.

For block r let A_r be a set of palette indices for which the certificate supplies Prime(q(r,s_i)). Other indices may be absent without any proof that their anchors are composite. Direct coverage is exactly the finite Boolean condition

    for all t<L, A_r intersects H_t.                 (5)

Duplicates among the H_t can be removed. If H_u is a subset of H_t, meeting H_u already implies meeting H_t. Therefore it suffices, and is equivalent, to meet every inclusion-minimal distinct row. Proof: in the finite collection below each H_t choose a minimal member; meeting it meets H_t. The reverse implication is immediate because each minimal row is an actual row. An empty row makes(5) impossible for this palette and must not be discarded.

A more flexible certificate supplies nonempty clauses C_1,...,C_K, not necessarily actual rows, with the one-time domination proof

    for all t<L, some j<=K satisfies C_j subset H_t.  (6)

For each later block it checks A_r intersects C_j for every j. Choose j using(6), then i in A_r intersect C_j. This gives both prime summands in(2). This sufficient form permits convenient smaller clauses even when exact minimal-row extraction is expensive. Smaller clauses strengthen the later block condition; they do not make it automatically easier to satisfy.

One concrete ordinary-proof implementation of(6) uses masks

    I_j[t]=AND_(i in C_j) P[t+s_i],
    OR_(j=1)^K I_j = all L target bits.              (7)

Prove the tiled identity(7), source extraction and clause membership once. Empty clauses can be rejected in the format; otherwise their later intersection test would always fail and they provide no usable certificate. Truncation and halos are exactly those of the old source checker.

Later blocks need only K intersection/nonempty checks on M-bit masks. Alternatively, supply one palette index i_j in A_r intersect C_j per clause, with checked membership and a reference to its actual prime proof. This avoids a mandatory dense M-bit mask but costs K references and membership proofs. Repeated references to one certified prime are allowed. The primality facts are established once per block and reused across clauses.

This is a precise candidate for removing target-length work from each block. It is not a claim that K is small. For unrelated source rows the minimal antichain can have L members; in general an M-element ground set even permits binomial(M,floor(M/2)) incomparable subsets. Extracting or searching for a better clause collection is producer work, and a large collection may be worse than the existing residual checker. The complete fallback must not disappear from a cost estimate.

## 4. Congruence screening and a limitation of repeated templates

The following obstruction uses no prime search. Let ell be an odd prime not dividing L and suppose all candidate anchors exceed ell. The condition ell divides q(r,s) is

    r = (2s+1)*(2L)^(-1) mod ell.                   (8)

A full template S that contains every residue class modulo ell is unusable at every such r: whichever r is chosen, at least one required anchor is a proper multiple of ell. In particular, for power-of-two L, a template containing all three offset classes modulo3 cannot be used once its anchors exceed3. Source coverage alone does not detect this defect.

More generally let d_ell be the number of distinct offset residues modulo ell in S. Exactly ell-d_ell residue classes of r avoid this particular divisibility obstruction. For a wheel of distinct such primes, CRT gives exactly product(ell-d_ell) allowed classes modulo their product. This is a count of classes surviving a necessary local test, not a count of blocks with prime anchors. Small cases where q equals the blocking prime must be handled separately; for L=2^32,D=2^19 even the minimum anchor2L-2D-1 exceeds the usual fixed small wheel primes.

Thus dictionary generation should first reject locally impossible templates and can index surviving templates by allowable r classes. It still needs actual prime certificates for each assigned block. A wheel is not a primality proof or a successful-template theorem.

There is also an unconditional eventual obstruction to any fixed finite palette S, even with arbitrarily many templates or hitting clauses over that palette. Choose distinct primes ell_s, one for each s in S, none dividing2L. For each s solve(8). CRT gives an infinite arithmetic progression of r satisfying all these congruences simultaneously. Choose r sufficiently large that every q(r,s)>ell_s. Then every anchor in the entire palette is composite. No template or hitting test restricted to it can succeed.

This proof uses only existence of infinitely many primes and finite CRT. It says nothing about whether one of these r lies below a particular R=floor(B/(2L)); their modulus may be much larger. It disproves a blanket all-r guarantee, not the finite Goldbach theorem and not a future successful finite dictionary. Expanding offsets, switching palettes or explicit certified residual sums can still succeed. Their costs must be retained.

A simpler redundant-cover fallback also has a quantitative limitation. If every target is hit by at least d+1 offsets in a template of size m, then any set of at most d failed anchors can be discarded. But necessarily

    (d+1)L <= sum_(s in S) count{t<L:P[t+s]=1}.       (9)

This follows by counting the same source incidences by target and by offset. The certificate cannot claim tolerance for more failures than(9) allows. No assumption that a large fraction of proposed anchors are prime is available here.

## 5. Exact operation and storage model

Let W be the chosen proof tile width, Q=ceil(L/W), and retain system-specific costs rather than treating a wide operation as constant time. Let X_S(W) price certified source extraction, O_S(W) a tiled union/intersection, T_S(W) its terminal equality and width proof, P_S(q) complete prime-certificate verification, and I_S the actual theorem-specialization and lookup work in prover S.

For template j of size m_j, one-time cover checking costs at most

    Cover_S(j)=Q*[m_j*(X_S(W)+O_S(W))+T_S(W)]

with the final tile width reduced as needed. Packed checking may replace this expression by its separately proved arithmetic cost. If R_j blocks select j, ordinary repeated checking pays R_j Cover_S(j), whereas theorem reuse pays

    Cover_S(j)+sum_(r assigned j)[sum_(s in S_j)P_S(q(r,s))
                                     +I_S(r,j,m_j)]. (10)

The primality term also appears in the old checker and is not removed. Relative to that same checker, the saving condition is precisely that sum_j(R_j-1)Cover_S(j) exceeds new dictionary construction, storage/access, specialization, and any added selection/fallback costs. If every template is used once, no coverage arithmetic is saved. Nothing here proves R_j>1 for a usable template.

The offset portion of the dictionary uses sum_j m_j*ceil(log2(D+1)) bits before framing, rather than repeating those offsets at each block. Assignments need R*ceil(log2 K) bits for K templates, subject to a fixed-ID format, plus all prime proofs and block indices. A zero-bit K=1 identifier still needs a valid format and full block schedule. Repeated prime handles inside a clause table may be shared; distinct-block prime values cannot be identified by(2).

For hitting clauses, write Csum=sum_j |C_j|. A simple one-time proof of(7) costs at most Q*[(Csum+K)O_S(W)+Csum X_S(W)+T_S(W)]. Subsequent block tests use at most K operations on M-bit masks plus nonempty checks, with M-bit availability construction, or K index/membership checks in the sparse format. All variants still pay for their distinct positive anchor-prime facts. These are separate costs from source sieve construction and the initial binary interval.

For storage, a streaming template check needs the source tile and D-wide halo plus O(W) accumulator bits; keeping every template accumulator simultaneously costs K times that amount. An already checked source theorem may be shared while its data are reread, but ordinary proof environments must actually retain or import the proof. Rechecking the entire source per block destroys the intended amortization. Persistent dictionary theorems need offsets/clauses and proof references; storing all intermediate masks is optional. Compiler or proof-expander duplication can erase the gain, so (10) assumes references to previously checked theorems, not textual inlining of their concrete arithmetic derivations.

For unchanged Lean, source and mask arithmetic must be proved using its actual kernel-supported operations or ordinary lemmas. The inspected KernelBench.lean:13–32 creates synthetic arithmetic equalities, and SourceProofs.lean:4 and following prove concrete mask equalities. Neither file supplies the generic prime interpretation(1), theorem(4), or a full-range result. Their old timings are not adopted. For unchanged MM0, every numerical premise still needs an ordinary derivation; a compact native checker plus an abstract correctness theorem is not an ordinary MMB proof of the result. Reusing(4) or(6) is compatible with ordinary proof rules but needs a concrete checked implementation and explicit proof references.

At L=2^32,D=2^19,W=2^18, a full template has16384 coverage tiles. The companion exact metadata gives:

| Binary B | Outer blocks R | Last width | Outer tiles without template reuse |
|---|---:|---:|---:|
|10^15|116415|1382236161|1907332249|
|10^16|1164153|937459713|19073469945|
|4*10^18|465661287|1321730049|7629394514867|

Every row additionally has4294967294 initial-range targets. A repeated template can replace its blocks' repeated coverage tiles by one16384-tile proof. This is a conditional identity, not a forecast that one template can serve the listed blocks. The hitting-clause alternative replaces repeated tile arithmetic only if a sufficiently compact usable clause certificate is found.

## 6. Result and next evidence needed

The new mathematical object is a reusable block theorem with independent source and anchor inputs. Its full-template and hitting-clause forms are proved above. They allow ordinary proof reuse across distinct block numbers while preserving every endpoint, prime fact and source index. The congruence and CRT arguments show why assuming broad template reuse without data would be unsound.

The most informative bounded next experiment, if separately authorized, would inspect an existing certified source fixture and already certified block anchors for: actual template reuse counts R_j; minimum-row or sufficient-clause size K; wheel compatibility; and complete ordinary-proof cost of one reused theorem instance versus one old coverage check. It should not start with a new production prime scan. A poor reuse/antichain result is a useful rejection of this compression, not a reason to claim generic near-linear proof cost.

The global B optimization should retain source certification, initial interval, anchor generation/checking, all exceptional blocks, dictionary generation/checking and theorem specialization in its binary cost function. No new lower bound for arbitrary Goldbach proof methods or end-to-end speed claim follows. The CRT limitation applies specifically to fixed finite palettes in this sparse-anchor architecture.

## Evidence

The new binary_cover_dictionary_metadata_20261111.py/json use only integer layouts and exhaustive abstract Boolean masks with L=4,D=2. Their1020 checks verify minimal-row equivalence, full-template monotonicity and the three exact endpoint layouts. No abstract mask is asserted to be a prime table. The receipt records exact SHA256 pins for the four prior coverage/cost notes, including the source-bitmap design, the architecture report, two inspected arithmetic-fixture files, and the actual Statement/SmallCases sources. General CRT and finite-set proofs above are paper arguments, not consequences of this tiny enumeration.

The script SHA256 is9E97CDAF5C8C5837FF08B25A37AA54D34D8B991526A707FF5E034251F3882976. The receipt SHA256 is C81B37DA6AFA850FA07A5449BBF3D734A564B3CE01E2A426D2AD146601ED46DE. In that receipt, the exact target Statement.lean has SHA2563F61837D2C3A0DDE3A1997F05AF21C20C7FE6EE13E29891125495F6947596BF8 and SmallCases.lean has SHA25661B94AFA308E82B7C8D9DA927CE5EB18F8847F9D58554589E4A28F5A2B7BF359. This note's hash is supplied separately in the handoff.
