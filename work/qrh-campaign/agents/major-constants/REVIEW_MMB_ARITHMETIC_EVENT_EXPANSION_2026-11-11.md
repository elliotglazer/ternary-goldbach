# Independent review of MMB arithmetic-event expansion

2026-11-11. PASS within the author's static source and counting scope. No correction required. This review does not validate a generated MMB, a PA-only radix-256 library, the C verifier's global soundness, a compiled ABI, or any runtime estimate.

Reviewed author: moebius/MMB_ARITHMETIC_EVENT_EXPANSION_2026-11-11.md, SHA256 E57FCF240BB386E783A653AD28162AFFCA2D4C5273BD1915C6C4E930ACF9CCB6. Its script2BDBDD0E6FE9778F30C665AA93E62AF43C3CFDFFA9BBDE850996C5F5DCB5048E and receipt022682B141671DC2C2F5FEC6F58715BE076735B45DE8CF8BB047E5FCA32146F8 were read, not executed or imported. All thirteen pinned source/receipt hashes match.

## 1. Arithmetic theory and missing signatures

I read the actual PA declarations at examples__peano.mm0:168–228 and proof bodies eqdivmod/divmod/modlt at examples__peano.mm1:2693–2712, plus powadd/powmul at5024–5032. The quotient theorem requires the conditional remainder bound and equality bQ+R=a. It establishes natural quotient/remainder facts; it does not prove the signed rational nearest-round relation by itself. Truncated natural subtraction cannot replace a signed residual.

I also read peano_hex.mm0:74–134 and peano_hex.mm1:115–145. The source explicitly introduces h2nlt, digit coercion axioms and character coercion axioms. The eval-check annotation on h2n0 remains attached to an AXIOM. Checking that an evaluator likes its value is not a PA derivation. The author's PA-only caveat is therefore necessary and correct. A conservative interpretation of the added sorts might be proved, but this review does not supply one or claim that the current generated source already supplies it.

The actual recursive radix-16 addition and multiplication bodies at peano_hex.mm1:457–508 and550–587 are substantive source proofs in that expanded theory. The multiplication generator has zero, one, low-zero-digit and recursive-addition branches. It is not the proposed rectangular radix-256 five-events-per-cell schedule. Closed byte digit facts, range/decoder facts, the fused cell, both row transitions, base cases, unequal widths, signed bridges and the nearest-round adapter still require actual proved statements and ordinary proof bodies before a numerical MMB-command expansion can be claimed.

## 2. Theorem arities, header stencils and call traffic

The source declaration and explicit generated call for add_xx0 at457/489 use six expression arguments a,b,c,d,e,f and two premises. For mul_x2x at556/573 they use seven arguments a,b,c,d,e,f,g and three premises. The prefix/digit objects must have the same identities as the corresponding subterms of the whole saved numeral operands.

I independently parsed the two source statements, inferred digit variables from the right operands of the declared hex definition and inserted the nat coercions. The unshared expression-node counts are:

|Lemma|Conclusion and premise node counts|UHyp count|Header including END|
|---|---|---:|---:|
|add_xx0|11,5,8|2|27|
|mul_x2x|9,5,8,5|3|31|

The definition hex is kept as its own declared term head, as permitted by the source at peano_hex.mm0:150–151 and mm1:237–238. This does not inline its defining arithmetic expression. These are legal explicit unshared header stencils, not a claim about which header a compiler would emit. Sharing or unfolding changes the actual representation and must be priced from that representation.

At verifier.c:479–515, Thm pops an explicit conclusion expression, then the declared number of expression arguments, checks their sort/dependency conditions, and runs the entire theorem unification stream. UHyp at300–315 consumes the premise proofs from the main stack. Thus premise references are not included in expression arity. With saved arguments, premises and whole operand expressions, a fresh op(A,B)=C conclusion needs h+a+3 references, two term constructions and one theorem application. This gives14 and16 commands, excluding the enclosing proof END. A cached whole conclusion gives10 and12. Neither count includes creating the inputs, proving premises or any conversion.

The command layouts at types.c:203–286 and mmb.md:25–30 agree with shortest lengths1,2,3,5 for ID0, positive byte, positive two-byte and remaining32-bit IDs. The stock65536-entry heap restricts valid local Ref IDs to at most three encoded bytes. Consequently the call byte upper bounds48/54 follow from eleven/thirteen references at at most three bytes and three term/theorem commands at at most five bytes. They exclude headers, setup, statement boundaries and END. They are not measured emitted sizes.

The fresh conclusion allocates two binary term objects. verifier.c:436–437 requests sizeof(store_term)+4*num_args bytes per node. The conditional48-byte expression-store count when sizeof(store_term)=16 is correct. No ABI measurement was performed, and no allocation count is promoted to complete memory traffic.

## 3. DAG accounting and exact identity constraints

I checked verifier.c:243–274: URef compares saved expression pointers exactly, whereas UTerm checks the head and decomposes children. The constructor at426–470 allocates a new term; it does not silently hash-cons equal-looking arithmetic expressions. Repeated numeral variables must therefore refer to the same expression object under this simple no-conversion schedule. Definitional conversions or arithmetic equalities can justify other presentations only through their actual checked commands/proofs, not through a producer hash.

The author's connected first-use postorder schedule is a sufficient scheduling restriction. Each non-root newly applied proof arrives directly on the stack at one of its premise uses. Every further use, including an external cached proof, needs a reference. This yields H-(V-1) proof references. Every expression request is either a first construction or a reference, giving R+C-T expression references. Summing theorem applications, term constructions, these references and one END gives exactly

    V + (H-V+1) + T + (R+C-T) + 1 = H+R+C+2.

The corresponding shortest-byte upper bound5(V+T)+3[(H-V+1)+(R+C-T)]+1 is valid in the stock heap domain. This is a count for the stipulated schedule, not an optimal encoding theorem. It excludes Hyp, conversion and unfolding operations. A forest, unused newly proved nodes, a different proof-stack schedule or independently closed proof packs require their own accounting. Shared theorem bodies do not remove per-instance argument checks or unification executions.

TermSave and ThmSave retain the result while leaving it on the stack, so saving at the first use does not add a separate Save command. Reused proof and expression entries are still distinct typed heap entries when both are needed. Their storage and all statement tables/stacks remain additional to the expression-node allocation formula.

The reset boundary is real: load_args at178–198 resets the local heap, and theorem processing at771–789 resets the expression store, checks the proof result and runs UThmEnd against the statement header. The next theorem cannot reuse old local numeral or proof pointers. The65536-entry heap cannot retain all196608 proposed byte arithmetic facts at once, even without their terms. This is a limit of the pinned implementation, not a lower bound on every sound verifier or every packing scheme.

## 4. The202- and508-event examples

The rectangular product decomposition is arithmetically exact:

    39 digit products +117 full adders +39 lifts +6 row steps +1 base =202.

The four closed-table uses per cell total156. Only distinct newly applied facts contribute to D; repeated retained proofs contribute consuming premise edges. Additional range/decoder facts are outside that156 bound. Under the explicitly missing template signatures, substituting V,H,R into the DAG formula gives the author's symbolic expression48+D+C+39(aL+hL)+3(a1+h1)+3(a2+h2)+(aB+hB). The adder formula follows by the same substitution. No numeric fused-cell theorem arity is assumed by this review.

For the signed nearest-round example, I checked the two frozen width receipts. The first-four uniform100 stage0 has input magnitude104 bits and rounded-product magnitude102 bits; the other factors have capacities18 and20. Both unsigned products therefore use a13-by3-byte template,202 events each. Residual/range/guard/coefficient capacities122,123,22,113 give33,33,7,31 adder events. The sum is508 per real coordinate,1016 per complex value.

The source acceptance equations prove the rounding rule, not merely the byte arithmetic. With S,C nonnegative and S+C+1=2v, one has0<=S<2v. Substituting S=2(P-Lv)+v gives -v<=2(P-Lv)<v. This accepts a lower half tie and rejects an upper half tie, exactly nearest rounding toward positive infinity, including negative inputs. The independent pre-acceptance caps S,C<2^21 imply the raw guard sum fits22 magnitude bits. They must not be deduced from an as-yet-unchecked equality.

The subtotal excludes two signed-product bridges, three signed-add bridges, the nearest implication, shifts, sign/range/zero conventions, exact source/grid binding and all expression/proof traffic. Opposite-sign addition needs an appropriate natural equality and sign cases. A natural truncated subtraction theorem is not a substitute. Combining six arithmetic DAGs also requires the shared expression objects and final sign/round implications; six separately closed proofs cannot simultaneously claim free local cache reuse.

## 5. Independent evidence and verdict boundary

Owned check script review_mmb_arithmetic_events_20261111.py SHA256 E4D463933F1B662C21C2482405DDFD951D00AD65B08F52373632EB9A8FAC65B1; receipt E0E1CF0E98A7AAF88E58FBFAEFD83599DA7AA00620F1F7AB11A9017A9E83DEEE. It performs1359 static hash, parsed-source-shape and integer-count assertions, including648 independent algebraic count tuples. It imports no author program and emits no MMB, arithmetic instance or proof certificate. These finite checks supplement the source reasoning above; they do not establish the general DAG argument by enumeration.

The receipt pins all thirteen author inputs. The core source pins are:

|Source|SHA256|
|---|---|
|examples__peano.mm0|463A7D6E4F4791313DEDCFD737053DCF2CC07B466371E263C38A994C6FB72052|
|examples__peano.mm1|13FD383AA02E434CBA1350E9A8F12C440B5114D22F26506FECE4AECDF1370079|
|examples__peano_hex.mm0|E2F5E461C568E0E3EF784B507E9111272B38956093DF98B943CCC4CD806E351B|
|examples__peano_hex.mm1|76FE94B569ECBF0AA051AF20AFE9C207BF8EC0B562C83C4F5D841118F2CC2D94|
|mmb.md|E93F3058650104B3F538FD8B2C583239C1E2FB076C7A75FA93B4FE93C16BC9A0|
|verifier.c|71428A117C96A37B81E183CE57EF34B71E99EFECBA019E65A47CE27DD4FAA4B5|
|verifier_types.c|87A0B9470DE5AE0BEFF5EDFA565952520957A39B250591B0067EBC4786B5490E|
|types.c|B3FC325B9269F50298B1D388C80B6544845A7185BC99DF0DD9970FF306A215D1|

The first four paths are under work/mm0-efficient/toolchain-sources; the last four under work/formal-goldbach-bench/mm0/src. The author's remaining arithmetic and signed-width source/review pins are matched in the receipt. Ordinary PA byte templates, their instantiated DAGs, stack/store feasibility, complete axiom/translation foundations, generated proof checking and full-work timing remain open. Template events have not been relabeled as verifier commands or runtime.
