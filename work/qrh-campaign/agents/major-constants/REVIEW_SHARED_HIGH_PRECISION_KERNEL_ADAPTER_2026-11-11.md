# Independent review: shared high-precision Bluestein kernel

2026-11-11. **PASS for the conditional paper adapter; no correction required.** This review binds root's `work/qrh-blueprint/SHARED_HIGH_PRECISION_KERNEL_ADAPTER_2026-11-11.md`, SHA256 `6393BBAD96123F0AD7E1171CFE1BF2D50A1B27641E55C926BCD30D23155ABE42`. It does not adopt a new cache schedule, fold counts, construct values or certificates, or credit runtime savings.

I read the complete author and rechecked the consumed normalization and local-precision contracts. Five hashes, including the author and its four named sources, match. The bounded scalar receipt contains only fixed rational identities and an abstract rounding counterexample, not an inventory or analytic/kernel value test. No builds, declarations, proof emission or frozen-file edits occurred.

## 1. The exact low contract really is sufficient

For n>=2, the accepted normalization proof uses `m=2n-1`, dyadic `P>=m`, `R=2 log2(P)+4`, `A=1+3R`, `Q=3nPA+1`, and `D_old=max(1,2 log2(P),PA,Q)`. Its point-product proof consumes the exact kernel K with norm at most m and a grid-p scaled center B with

    norm(B-K/P)<=(A+1)u_p,  u_p=2^-p,
    u_p<=1/D_old.

Reviewing the actual subsequent inequalities shows they require this enclosure and the resulting strict center bound, rather than equality of B with one particular independently generated low FFT. They preserve the operand cross term, the unnormalized inverse factor P and the final chirp error. Thus a separately proved producer with the same numerical contract can feed the runtime proof.

This is a theorem/interface composition, not equality of producer objects. The earlier frozen cache contract specifies `Round_p(Khat_p/P)` with its own certified raw kernel. The new direct-high or normalized-high producer is a SUCCESSOR identity exposing the same low enclosure. Its high source, projection witnesses, exact coefficient identity, deterministic rounding, radius and lifetime must be bound explicitly. Existing low-cache identity or signs cannot simply be renamed.

## 2. Raw-high projection

Fix one exact full kernel identity and let H be the largest required precision. The high producer supplies `norm(Khat_H-K)<=PAu_H`. Division by exact P gives `norm(Khat_H/P-K/P)<=Au_H`. Coordinate-nearest rounding contributes at most `sqrt(2)u_p/2<u_p` in complex norm. Hence for every p<=H,

    B_p=Round_p(Khat_H/P),
    norm(B_p-K/P)<=(A+1)u_p.

Safety at p implies safety at H because u_H<=u_p. At p=H this is exactly the usual high normalization step; no exceptional loss or extra bit is needed. Input, runtime root/chirp and arithmetic error hypotheses remain at their own p. A high kernel certificate supplies none of those other certificates automatically.

The actual raw numerator starts on grid H and its exact division by P is on grid H+log2(P). A projection to p discards `H+log2(P)-p` bits and consumes that raw numerator, with its real width. The smaller final center bound cannot be used to pretend the unrounded operand already has p-bit capacity.

## 3. Normalized-high direct projection

The high normalized cache satisfies `norm(B_H-K/P)<=(A+1)u_H`. Retain B_H itself at p=H. For integer p<H, a single direct projection gives

    norm(Round_p(B_H)-K/P)
      <=(A+1)u_H+u_p
      <=((A+1)/2+1)u_p
      <=(A+1)u_p.

The final inequality is exactly `(A-1)/2>=0`; the actual A is stronger than the assumed A>=1. The strict inequality p<H is what supplies the factor1/2. The equal-precision branch is explicitly a copy, not another generic error charge.

Each low cache is projected directly from B_H. This review does not extend the claim to arbitrary chains through intervening grids. Nor does the conclusion identify these centers with direct raw-high projections. For an abstract scalar illustration with ties toward positive infinity, rounding3/8 directly to integer grid gives0, while rounding first to the half-integer grid then to integers gives1. This is only a rational rounding example, not a kernel example or a failure of the enclosure theorem.

The normalized high numerator has H magnitude bits under its proved strict norm bound; a low projection discards H-p bits. The high normalization still pays the raw H+log2(P) conversion. Equality of conversion occurrence counts between the two schedules does not mean equal operand widths or prices.

## 4. Strict norm, local widths and retained global composition

For either low producer,

    Q-P(A+1)=(3n-1)PA-P+1>0.

For n>=2 and A>=1 this is at least `5PA-P+1>=4P+1>0`. Therefore `Q u_p<=1` gives `(A+1)u_p<1/P`. Combining with the exact kernel norm proves

    norm(B)<=m/P+(A+1)u_p<2n/P<=1.

The final dyadic inequality uses P>=2n: P is an even power of two and at least the odd integer2n-1. Thus p magnitude bits for each coefficient coordinate remain justified, even though an arbitrary rounding of an arbitrary norm-below-one high center would not by itself prove this strict bound. The exact-kernel enclosure supplies the essential gap.

The old normalized C_old/D_old recurrence and its local context bounds remain available. The old peak/S safety is still required; it is not supplied by cache sharing. The conductor-local p selector, grid100 input embedding, input/source uncertainty and downstream complete-radius proof are unchanged under their original hypotheses. No optional sharper C_new inventory is adopted. Actual computed centers and subsequent sign tests remain new.

For the three-product identity, the two exact REAL sums C+D and D-C must be formed from each actual new complex coefficient. Projecting the old high sums is not generally equal to summing the separately projected coordinates. The author correctly leaves such reuse unclaimed.

## 5. Cache roles, costs and formal boundary

For one declared lifetime and exact full identities, let T_n be each nonempty precision set. Both schedules use one full certified raw kernel construction at H_n=max T_n. The direct-raw schedule performs `sum |T_n|P_n` complex raw scale/projections. The normalized-high schedule performs `sum P_n` high normalization conversions and `sum (|T_n|-1)P_n` lower projections. Both retain the same `sum |T_n|P_n` runtime coefficient entries and twice that many exact real cached sums when using three products.

These formulas are sound role counts. Their raw/normalized operand widths differ, and the high FFT need not cost the same as a discarded lower-precision FFT. The author's complete conditional comparison correctly includes construction, conversions and all remaining costs on both sides. No count or price was instantiated here. A sunk cache does not yield a construction refund; proof replay, imports, source bindings, storage, reloads and rebuilding follow the chosen lifetime rather than an assumed shared pointer.

In particular the approved first-pass cache manifest remains a conservative per-p PRODUCER schedule. This paper can later replace its construction strategy while retaining a low-entry set, but only through a new explicit adapter contract and new identity keys. It does not mutate that frozen manifest, prove center equality, or supply an ordinary-proof library implementation. The high certificate and every projection witness remain necessary standard-proof inputs.

## Frozen review evidence

Independent script `review_shared_high_precision_kernel_20261111.py`, SHA256 `AC061742101DBEFA7EFC676C0093BE13D32C6D3DF266ADFD431FE3D9F3C39A1C`; receipt `review_shared_high_precision_kernel_20261111.json`, SHA256 `F6ABB42F713A720F7A6AC1B032DAF612E0A54AAA66E1FB9BE409AE47CF134EC6`. Its14 fixed checks include the five pins, affine coefficient identities and abstract dyadic-rounding distinctions. The general inequalities above are the paper proof; the receipt is not evidence from numerical kernel samples.

Consumed source pins: normalization `FB29C85F85401EAB8512CC8AB0E58063380B159690C4E6B155F82A407C959BA9`; normalization review `09E6E7CF4E81F55A95E728D21DA0C19ADD6D62536042A5FD60160C1E27575CEA`; local-precision preflight `1F8A6AED9AF9F54263319EA126BC16AAE65D375F119252E30FACCCA11345B76A`; its review `15BA3154158D5FD272924CA2D6D4AD0A03203BC575FBE6B2EA04BFDBAF8DEDB2`. All full paths and hashes are recorded in the receipt.

The result is a valid conditional kernel-producer adapter. Actual values, arithmetic libraries, complete prices, strict signs and count closure remain open. No runtime or end-to-end saving is credited.
