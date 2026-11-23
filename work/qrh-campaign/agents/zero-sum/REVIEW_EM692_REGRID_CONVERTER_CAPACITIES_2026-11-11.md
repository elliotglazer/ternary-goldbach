# Independent review of the EM692 converter capacities

2026-11-11. PASS at conditional paper and arithmetic-interface scope; no correction requested. This review binds `audit/EM692_REGRID_CONVERTER_CAPACITIES_2026-11-11.md`, SHA256 `99FC177B6F200502407802E7A8FF6E98196EBF51A932A2B68EC38B693A46EB35`.

The stronger actual-input magnitude supports the narrower capacities and the116 unsigned-adder core subtotal. This is separate from analytic admission of a transform precision, a complete checker price, or authorization of an inventory/price fold. No actual coefficient, source coordinate, transform, sign or other analytic value was evaluated.

I authored the predecessor converter-cost interface. Its independent acceptance is audit review `56B27935FF994E3F25F735825196076DF72C8DBC33D2A61D4787B61E3BBDD5F0`, which is consumed here. The new actual finite-EM magnitude comes from statement_audit's03680BE7 paper and prime_estimates' independent1E9D3CDE review. This review checks their new capacity composition without claiming to be an independent review of my own earlier component.

## Source and witness

The source must be the actual grid100 sum of the admitted full-P20 center and finite-head center. Their strict magnitudes below173 and517 give norm below690. Hence each actual coordinate numerator n obeys

    |n| < 690*2^100 < 2^110.

This uses a stored-center bound, not an error-radius inference or cancellation assumption. Actual source identity, grid export, head representation and the independently admitted alpha/head errors remain necessary. The magnitude theorem alone does not admit an arbitrary coefficient-grid profile.

For50<=p<100, set d=100-p. The supplied witness

    n+2^(d-1)=Q*2^d+t,  0<=t<2^d

gives n-Q*2^d=t-2^(d-1), so the residual interval is closed on the negative side and open on the positive side. It is exactly nearest rounding with half ties toward positive infinity. Negative inputs use the same rule; for example a source at a negative half unit rounds to zero with the negative residual endpoint. Canonical zero is a separate exact representation issue.

Each coordinate has error at most half a unit on grid p. The squared Euclidean error is at most one half of a squared unit, hence the complex error is strictly below2^-p. This is the existing single regrid charge. It is neither a new source/seed error nor an error to be multiplied by the intrinsic transform coefficient.

The floor/remainder construction proves mathematical existence. It does not provide a trusted floor instruction. An ordinary checker accepts a supplied integer Q and nonnegative t only through their proved ranges and equality.

## Completeness and raw capacities

For the correct nearest integer, the actual690 bound implies

    |Q| <= |n|/2^d+1/2 < 690*2^p+1/2 < 2^(p+10).

The final strict inequality follows already from the p50 endpoint and increases with p. Thus the declared strict destination range does not exclude a correct witness. The weaker |n|<2^110 alone would not prove that strict completeness claim near the boundary; the author correctly uses the stronger actual magnitude.

An arbitrary supplied Q cannot use this conclusion before acceptance. Its range must be checked independently, together with |n|<2^110 and0<=t<2^d. These independent facts imply

    |Q*2^d| < 2^110,
    |n+2^(d-1)| < 2^110+2^49 < 2^111,
    |Q*2^d+t| < 2^110+2^50 < 2^111.

Therefore the source needs110 magnitude bits plus a sign; Q needs p+10 magnitude bits plus a sign; and either raw addition result needs111 magnitude bits plus a sign. These are signed-magnitude proof capacities, not claims about a native two's-complement type. Raw112 signed bits fit fourteen bytes. On the rounding branch the largest destination is110 signed bits at p99.

The signed-add adapter also fits this allocation. Same-sign operands have the stated bounded sum. In an opposite-sign branch, the nonnegative difference plus the smaller magnitude equals the larger magnitude; the difference is bounded by the larger operand. The required numeral/range facts for arbitrary proposed result and difference witnesses still have to be checked before a bounded arithmetic template is used. The author retains these costs. A small residual after acceptance cannot justify narrowing earlier arithmetic.

The remainder has at most50 bits. Seven bytes alone do not establish that bound: at d50 the top byte must have only two significant bits. Powers, shifts, source-coordinate association and the equality of the two interpreted raw outputs remain proved objects. A correct numerical claim without that binding is insufficient.

## Matched arithmetic subtotal

The retained schedule has two signed additions per coordinate and four per complex input. The accepted signed bridge implements each by one unsigned magnitude-addition equality plus its sign/case and semantic adapters. With A(w)=2*ceil(w/8)+1,

    A(111)=A(112)=29,
    4*A(111)=116,
    4*A(116)=124.

The new matched unsigned core is therefore eight template units smaller. This comparison uses the same witness schedule and a stronger proved input bound. It does not assert minimality, a complete command count, or a runtime improvement.

The four signed roles are not four established theorem applications. Under the cited bridge they may require two existing wrapper applications per gate, or a separately proved composed adapter. Signed routing, canonical-zero policy, ranges, raw equality, source/grid/height/unit identity, exact shifts and powers, representation conversion, proof references, storage and producer work remain outside116. Multiplication by2^d needs no generic multiplication core, but is not a free memory operation. Reusable powers or per-p lemmas do not make the two actual shifted Q values reusable constants.

Optional odd-mantissa normalization starts from the current pair (Q,-p), and its exact exponent changes remain charged. The author correctly avoids using the old source exponent after rounding. Longer d may increase split and range costs, so the eight-unit core difference does not by itself prove that the whole converter is cheaper across different precisions.

## Exact branch and downstream limits

At p100, Q=n is an exact identity. At100<p<=108, Q=n*2^(p-100) is an exact shift by at most eight bits. Neither has a remainder witness or nearest-rounding error. In particular the half-power formula is not instantiated with d=0, and no mandatory four-adder charge is assigned to these branches.

The exact destination obeys |Q|<2^(p+10), so at p108 it can require119 signed bits. The fourteen-byte rounded-witness allocation must not be reused for this exact output representation. Shift/copy, destination validity, range, grid equality and source transport still require their own proof and accounting.

This capacity lemma changes neither internal transform peaks nor the precision selector. It does not admit new caches, source profiles or interpolation domains. Conversion counts belong to distinct assembled residue inputs and heights, not primitive-character output counts. Source20 production, head construction, exact assembly, guards, completion and count acceptance remain separate. No such counts or prices were folded here.

## Independent evidence

Owned checker `zero-sum/review_em692_regrid_capacities_20261111.py`, SHA256 `EB651258003A58AD62A630ABB0637CF72A369F5B1B0B2E8C8514E6024372C9C8`, passed48 fixed checks on its first execution. Its4172-byte receipt `zero-sum/review_em692_regrid_capacities_20261111.json` has SHA256 `A1142FF4AEC096171E00555C4C5D44B063EA48645829554D96AE5EAF86AB09D6`.

The checks bind the author and all seven cited paper pins, verify the capacity/cost endpoint arithmetic and check four fixed abstract signed witnesses. They do not enumerate precisions, digits, conductors or source values. No author program, inventory, fold, build, declaration or proof stream was executed or emitted. The full-range proof is the symbolic argument above; the fixed examples are only boundary checks.

The converter successor passes under its actual-source and ordinary-arithmetic premises. Analytic p50 admission and any future pricing remain distinct gates.
