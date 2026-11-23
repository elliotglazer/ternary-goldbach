# Fixed-step proof reuse for the reduced P27 schedule

2026-11-11. Research proposal with exact integer metadata. No arithmetic table, elementary value, seed, transform or proof stream was generated. No build or timing experiment ran. This preserves the selected P27 arithmetic and its error allocation, including four real products per complex height update. It does not repeat or claim the previously reviewed three-product improvement.

One concrete ordinary-rule optimization is available: reuse checked small-digit multiples of each fixed height-step coordinate across a bounded tile of updates. This removes repeated digit multiplications from those updates. It adds table construction, additions and proof references. A specified unsigned proof-template count improves after14 updates per tile; complete proof work and wall time still require the representation and data-order costs below. This is a candidate for MM0's explicit arithmetic proofs, not an established improvement over Lean's kernel multiplication.

## 1. Exact repeated operands

The selected recurrence is B(x,t+h)=z(x)B(x,t), h=5/64, with one certified complex step z(x) per rational argument x. The step has error at most2^-140, the update has the same rounding allowance, and the lower-precision EM copy has error at most2^-122. The high-precision state, rather than that copy, feeds the next update. These requirements are unchanged.

The existing dense representation uses state coordinates with140 fractional bits and step coordinates with142 fractional bits, magnitudes below2. Their signed integer mantissas fit144 bits. Thus their absolute values fit n=18 radix256 digits. With z=(a+ib)/2^142 and a state (u+iv)/2^140, each update checks the four exact integer products au,bv,av,bu, the two signed sums, and the prescribed final rounding. The same integers a,b occur at every height for this x. This proposal changes only the proofs of those products. Exact products and rounding witnesses give exactly the same rounded state as the original schedule.

For the reduced main prefix the reviewed count is U=1351497402624 complex updates over27754497 arguments. The corresponding EM head and correction work is separate and remains. In particular the35130458950228 head reciprocal scales are not accelerated by this proposal. The main-plus640 prefix is a different workload; the metadata here uses only the main prefix.

## 2. An ordinary arithmetic table and multiplication proof

For c=abs(a) or abs(b), define beta=256. Prove all256 closed identities T_d=c*d for0<=d<beta, with T_0=0 and T_(d+1)=T_d+c. Generate each next equality with a checked addition and the ordinary distributive/successor lemma. These identities are statements about the actual numeral c. No table lookup axiom, unproved executable result or random check is used. The products fit n+1 digits.

For an n-digit nonnegative input u, process its digits from most significant to least. Maintain v=c*p for the processed input prefix p. Given the checked next-digit identity T_d=c*d and a checked addition w=beta*v+T_d, the fixed algebraic lemma proves w=c*(beta*p+d). The shift beta*v is a radix constructor with a proved interpretation, not a multiplication oracle. Induction proves the exact product c*u. The final product fits2n digits, since both operands are below beta^n. Intermediate prefixes give the same width bound. Digit ranges, the full input decomposition, signs, carries and output interpretation must be checked.

A wrong chosen table index does not match the required equality for the actual digit. In MM0, sharing the exact digit, coefficient and table-result terms makes this an ordinary theorem or saved-proof application. Equality of hashes or of external integer encodings is not an acceptable replacement for that binding. Zero and sign cases use the same proved signed-magnitude bridge as the baseline; a negative mantissa never indexes an unsigned table directly.

This table proves products for arbitrary changing states. It does not infer that the states, phase steps or spectral values are correct. The existing recurrence theorem still consumes the certified step, initialization, each exact rounded update and the complete consecutive height range.

## 3. A concrete template comparison

Use the existing ordinary-PA skeleton A(k)=2k+1 for addition and M(n,n)=5n^2+2n+1 for schoolbook multiplication. These are macro events, not MM0 opcodes or equal-duration instructions. Charge a table lookup and a prefix-fusion lemma separately. The proposed Horner product has

    T(n)=(n-1)A(2n)+n+(n-1)=4n^2-n-2

events. The n lookups may be direct applications or local Ref uses; their actual command prices differ. A conservative two-table setup charges255 additions of n+1 digits,255 successor-identity applications and255 saves per table, plus4 base/final events per table:

    S(n)=2[255(2n+5)+4].

For n=18 this gives M=1657, T=1276, S=20918. Four products save1524 template events per complex update before setup. Hence a tile with h updates has a strict template improvement when1524h>20918, first at h=14. These formulas charge the same full-product widths even when particular mantissas or leading digits are smaller. They do not claim optimality against Karatsuba, an already specialized constant multiplier, or a smaller realized-width baseline.

The comparison excludes numeral construction, digit decomposition and bounds, the signed bridge, output rounding, proof-binding instructions, table transport and local-state management. Common costs cancel only after an implementation demonstrates they are actually common. The table method additionally creates255 n+1-digit values per coefficient. Its required shifts and prefix terms must appear in the term ledger. A fused macro is still an ordinary theorem application with checked arguments and hypotheses.

The exact band calculation uses (D,N,H) equal to (512,220,6401), (1024,387,6400), (2048,720,12800), (4096,1720,38400), (8192,3387,38144). Put X=(N+1)D+1. At each band, old arguments have H updates and newly introduced arguments have H-1, because their first value is initialized. For tile length h, rebuild the two tables in every tile and at every band boundary. The number of table pairs is

    sum_b [X_previous*ceil(H_b/h)
           +(X_b-X_previous)*ceil((H_b-1)/h)].

This deliberately pays for short final tiles too. A future implementation can use the baseline method on a short tail, but that saving is not counted here.

| Tile updates | Rebuilt table pairs | Product-plus-setup template events |
|---:|---:|---:|
|16|84470315248|8664992797350560|
|32|42235157624|7781517770171728|
|64|21117578812|7339780256582312|
|128|10558789406|7118911499787604|
|256|5279394703|7008477121390250|

The same unsigned schoolbook subtotal is8957724784591872. At h=64 the template reduction is1617944528009560 events. This is a reduction of this product subtotal only, not of the entire spectral calculation. Even this tile schedule constructs10812200351744 local table entries across the run. Rebuilding has not been treated as free.

For actual compiled costs replace every macro family by its measured or proved command count. A sufficient per-tile decision is

    h * [4 C_school - 4 C_table_product]
       > C_two_tables + Delta_terms + Delta_binding
                         + Delta_storage + Delta_seed_order.

Generation and checking have separate versions of this inequality. The optimum tile length depends on the actual live-state limit and downstream order, not just the arithmetic subtotal.

## 4. Stock MM0, same-rule extensions and new inference

The pinned verifier already permits the bounded local method. `verifier.c:382-395` retrieves a saved proof; `479-517` applies an earlier checked theorem and validates its arguments; `241-249` compares shared URef terms by arena identity. `619-632` saves local proof objects. At a complete theorem boundary, `770-788` checks the final conclusion and resets the local expression store for the next proof. A finite update-tile theorem can therefore check tables once, reuse them locally, and export its actual checked output facts through an ordinary statement.

The stock heap is65536 entries and expression store64MiB. The512 table facts alone fit the heap count, but that is not proof that a complete h=64 tile fits: table numeral terms, input/output states, arithmetic proofs and pending obligations must also be counted. Local Ref facts do not survive a theorem boundary. The metadata explicitly rebuilds them. A closed global theorem can preserve table identities, but global statement storage and local re-instantiation then replace the rebuild cost; neither is free.

The displayed main schedule has more than2^32 update tiles even at h=256. Therefore one global theorem declaration per tile is incompatible with the stock u32 theorem-count format. This does not prove that every possible stock organization fails; several tiles could be proved inside one larger theorem if its actual scratch limits permit it. No such packing has been implemented here. The whole-file table and parser limits remain too. The local optimization is stock-rule compatible, but this table is not a demonstrated stock-format end-to-end encoding.

A same-rule implementation may retain an exact checked library and a bounded current pack, recycle completed theorem metadata, stream proof bodies and preserve selected table facts in a checked persistent arena. It must preserve statement identity, hypotheses, dependency masks, unfinished conversion obligations and failure state. This can reduce table rebuilds and global storage. It is an implementation change requiring its own validation, not an available stock feature. An independent checker still needs the ordinary proofs or its own uninterrupted checked provenance; an external cache digest does not suffice.

A native big-integer multiplication opcode accepted without an ordinary derivation, a trusted table hash, or a probabilistic multiplication test would change the inference/trust boundary. None is used or credited here. Compression that decodes to the same ordinary proof can save transport bytes, but does not by itself remove arithmetic checking.

## 5. Seed order, outputs and live dependencies

To exploit a local table, process consecutive heights for one argument inside a height tile. The selected EM calculation must still see every argument at every required height, all27 coarse coefficients, the20 endpoint coefficients, all64 corrections and all retained midpoint outputs. A useful arrangement is height tile, coarse anchor, head argument: each argument's h states feed the h by27 head accumulators for that anchor immediately. Its endpoint contribution is handled at the exact shared argument. The fine state remains distinct from each EM-grid copy.

This changes data order. Across anchors and bands, identical rational arguments need exact ownership and index maps; endpoint sharing cannot be approximated or silently duplicated in counts. Store the outgoing high-precision state for the next tile, or pay to regenerate it. The existing dense state/step arrays cost1998323784 raw bytes at the final band before proof objects. Alternatively an argument-major schedule can keep fewer states, but must retain or transpose the height-indexed coefficient contributions and shared per-height R factors. Recomputing those factors must be charged. No choice makes both all state and all downstream accumulation disappear.

An exported tile theorem must bind the incoming state, exact step, consecutive height indices, all consumed EM copies or their exact contributions, and the outgoing state. An endpoint-only theorem is insufficient when internal heights feed seeds. A small prefix theorem can hide past witnesses after proving a quantified completed-range property, but if later character contractions need the concrete seed values their term/data bindings must remain available or be reconstructed by proofs. Storage reclamation cannot erase their meaning.

## 6. Lean comparison and complete cost boundary

Lean's ordinary kernel already reduces natural literal multiplication, division and bit operations. A Lean checker may verify the four exact integer products and rounding identities directly; explicit digit tables may cost it more. A proof-producing Lean implementation could use the same table lemma, while kernel reflection could use a direct Boolean arithmetic checker with a proved soundness theorem. Both require the actual evaluation/proof connecting the concrete data to acceptance. `native_decide` is outside the stipulated ordinary-axiom comparison.

Thus the useful future comparison is one actual fixed-step tile, with the same step, input states, product identities, rounded outputs and complete emitted seed-copy claims. Compare ordinary MM0 schoolbook versus table proofs, and Lean kernel/reflection versus its best proof-producing route. Separately record generation, numeral/term construction, table setup, exact arithmetic, bound/rounding proofs, output binding, serialized bytes, scratch and joins. Use different states across the tile; replaying an identical operation would test memoization instead. The h=16/64/256 cases distinguish the setup crossover from capacity failure. No such test is run or authorized by this note.

The full cost remains analytic foundations and translation, elementary and Bernoulli setup, these shared seeds, residue/character transforms, interpolation, signs and zero completeness including auxiliary heights, principal/small-conductor work, binary and ladder certification, and final assembly. Ordinary PA arithmetic proofs are only one component. Neither this optimization nor streaming provides the missing MM0 complex-analysis library, translator correctness, closed spectral data or finite Goldbach coverage. The reviewed elementary and EM arguments remain paper inputs until implemented with the allowed rules.

## Evidence

`p27_fixed_step_table_metadata_20261111.py` and its same-stem JSON contain only the displayed integer counts and nine source/report SHA256 pins. They do not construct table entries or evaluate phases. The source pins include the reduced-prefix P27 report, selected order, height recurrence, proof-volume/streaming/digit-table reports, Lean/MM0 comparison and the actual MM0 verifier/store source. The analytic foundation boundary is also preserved from this directory's `MM0_ANALYTIC_FOUNDATION_IMPLEMENTATION_PLAN_2026-11-11.md` and its independently accepted review. This proposal itself still needs independent review and a concrete ordinary-proof implementation before any total-cost claim.
