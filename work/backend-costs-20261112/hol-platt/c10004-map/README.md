# Concrete modulus-10004 finite coordinate map

Status: unbuilt source. Neither Python proposal nor HOL finite checks have been run by the author. Candidate roots are 6 modulo41 and 2 modulo61. They are not accepted merely because this document names them. The HOL checker must verify their complete nonzero residue permutations and endpoint powers before acceptance.

## Exact map

Input index i in0..4799 is decoded as a=i DIV2400, b=(i DIV60) MOD40, c=i MOD60. Flattening is ((a*40)+b)*60+c: axis61 is fastest. Map to

    (2501*(if a=0 then1 else3) +4880*(6^b mod41)+2624*(2^c mod61)) mod10004.

The three CRT coefficients have respectively residue1 in their selected modulus4,41,61 and residue0 in the other two. The finite checker checks every output coordinate congruence, not just these constants. The complete map is the algorithmic HOL constant unit_map=GENLIST residue4800, not a trusted external literal list.

Sorted equality to FILTER(gcd r10004=1)(GENLIST I10004), plus the generic sorting permutation theorem, yields exact unit coverage without checking every unit against every list member. Distinctness follows from the filtered distinct index list and permutation. This is why the source does not perform a quadratic ALL_DISTINCT test on the 4800-entry map. Only the short local40/60 lists use that test. Existing sorting/gcd libraries are required; no dependency build is authorized.

Output labels are (1,1+i DIV59,1+i MOD59), i in0..2300. The checker verifies every label's bounds and round-trip index, and inverse index2300-i. Hence there are2301 distinct retained index labels, both members of every pair, with the central index1150 fixed. The input inverse sends(a,b,c) to(a,-b mod40,-c mod60); both the index involution and product-of-residues=1mod10004 are checked. These are finite arithmetic identities, not an assertion that the labels already denote actual Dirichlet characters.

The later tensor transform must use this exact flattening. Within each CT split n=r*m, preserve j=a+r*b and k=v+m*u, with jk/n=bv/m+au/r+av/n modulo an integer. Global tensor flattening and local CT digit order are different maps and may require explicit permutations. This packet does not assert a whole transform is flat-index4800 DFT.

## Files and root-only commands

`C10004MapScript.sml` computes the acceptance proposition through stock cv_auto_trans/cv_eval, demands an exact closed true result, derives the generic permutation/distinctness/coverage consequences, and exports the theory. `map_audit.sml` checks closed hypotheses, allowed imported theorem tags and the four standard HOL bool axioms. Both are unbuilt and may need ordinary source repairs; no hidden premise or admitted result is allowed to repair a failed finite check.

`propose_map.py` independently computes all4800rows and2301labels with native integers, checks the same finite identities, and writes immutable map_proposal.json. This is an untrusted source proposal for later native/data consumers. HOL does not import it as a proof or read its success bit.

Root may run the proposal with the known Python3.14 executable, then launch from the Linux host mount:

    sh work/backend-costs-20261112/hol-platt/c10004-map/run_map.sh map01

The runner uses the pinned setup/HOL4, 4GiB and600-second phase caps, no_prereqs and fresh-label logs. No source values or tests were run in preparation. Hash matching, successful compilation, complete theorem types and audit log remain acceptance gates. A resource failure is not rejection evidence.

## Remaining bridge

Need independently proved actual cyclic unit-group interpretation of these generators, character definitions using positive-exponent roots, multiplicativity/periodicity, tensor evaluation equality, conductor/primitivity characterization, exact inverse/conjugate phase convention, and CT/pruning normalization. Enumeration verifies the finite map and proposed restricted coordinate set; it does not by itself prove those analytic/algebraic statements. The full actual source-to-sign block, p81 source/error contract, two positive heights and all4602channel occurrences remain unchanged obligations.

This implements one missing finite ingredient from C10004_PARAMETER_PACKET and ANALYTIC_BLOCK_PLAN. No source/smoothing/Hurwitz computation, root-of-unity evaluation, L-value, sign or completeness claim is made.

## Source pins

`C10004MapScript.sml` SHA256 `0773AC5249A66AF85814F7694063D53759AEF19C41D6172BE06DA906FD60AC6E`.

`map_audit.sml` SHA256 `03F3A64E5541EC00B09AB11E91E0351614C2A19E1FC51B4F837DE750762B158F`.

`propose_map.py` SHA256 `46944174CE5CF122768E1DA56946EB97AE025C2721171A220C3320A252648CAF`.

`run_map.sh` SHA256 `2FD416739DB268E177098243ED2746BC70E3546BEE21AE1251062FECCF89DA53`.

`Holmakefile` SHA256 `6E346FB294CF04A3E4915487015607B28B06BA43B9514BB343327EDEAC48629B`.

`C10004_PARAMETER_PACKET.md` SHA256 `2B8102E8134B8BC9DA5BD93DD2105673EE6614B2D3D721B7E701F3A38C09F8EF`.

`ANALYTIC_BLOCK_PLAN.md` SHA256 `55E63C1849DC9D9007DD8085D0FD4EEE2CD98CEBDA57E14554A5DB23A9F3AD1C`.

