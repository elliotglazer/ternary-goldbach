# Complete independent short-gap recount review — 2026-11-11

Verdict: PASS. A fresh independent external segmented sieve matches EVERY window count, source-sized subcount and original per-window hash across (10^9,5*10^9]. The parent explicitly expanded the earlier bounded assignment to this full recount after the producer completed. No Lean build, canonical source edit, producer-data edit or frozen104-chapter package edit occurred.

This supersedes the limited recount scope of RESUME_PSI_FULL_PROTOCOL_REVIEW_2026-11-11.md only. That earlier review's protocol limitations and complete arithmetic-chain checks remain applicable. The producer report's statement that a full independent recount was not requested describes its earlier freeze, not the evidence now available.

## Complete matched quantities

| Item | Independent result |
|---|---:|
|Integer positions in (10^9,5*10^9]|4,000,000,000|
|Grid windows|6,439|
|Source-sized subcounts|125,271|
|Primes in the interval|184,106,689|
|New raw classification hashes matched|5,901|
|Earlier ASCII prime-list hashes matched|538|
|Complete base primes through70710|7,004|
|Fixed global sieve segments|477|
|Saved independent checkpoint files|101|

Every subcount was recomputed from the independent classification, not inferred from parent-count agreement. Every parent count matched exactly. Every original per-window hash matched in its specified format. No count or hash mismatch occurred, and the process exited0.

## Algorithm and source-data independence

The independent implementation imports no producer code. It reads only frozen candidate data for comparison. It independently constructs all primes through70710 by incremental trial division, and compares that complete list with the saved base only after construction. The generated list, not the supplied list, drives the new sieve.

The producer used two representations on each checkpoint-sized interval. This implementation instead uses fixed global segments of 8,388,608 integers starting from the origin10^9. Those boundaries are independent of checkpoint and32768-sized subcell boundaries. Each segment stores only odd candidates. If its first odd integer is f, then for each odd prime p the first zero-based divisible index is

    j = (-f*((p+1)//2)) mod p.

Indeed 2*((p+1)//2)=p+1, so this solves f+2j=0 modulo p. It then marks j,j+p,j+2p,... within the compressed odd array. This is a different index calculation from the producer's full-integer first-multiple and odd-multiple calculations.

All tested integers exceed every base prime, so marking a multiple cannot remove that prime itself. For every segment upper bound b, the independent code uses precisely primes with p^2<=b. Every composite in that segment has such a factor. The bound70710^2<=5e9<70711^2 makes the independently enumerated base complete for the entire interval. Even integers are composite throughout the domain and remain zero.

Segment classifications are copied into canonical per-window byte arrays only on their exact intersections. Unfinished windows retain their preceding segment contributions. The last global segment and last grid window are clipped at5e9. The saved recount checkpoints cover contiguous indices1..6439 and the original rows cover exactly the contiguous integer interval after10^9. The reconstructed full byte array is then used to count every recorded subwindow and parent window.

This is an independent Python implementation and segmentation/indexing check. It is not a formally verified program, independently implemented arithmetic runtime, or machine-code proof.

## Hash formats verified

For new windows539..6439, the compared hash is SHA256 of W raw bytes, each literally0x00 or0x01, with position i representing a+1+i. All5901 match. It is not a hash of text digit characters.

For old windows1..538, the independent code reconstructs the sorted survivor list as newline-terminated ASCII integers and matches the original prime-list SHA256. All538 match. It additionally stores the raw classification hash for every window, including these older windows. Thus there is no comparison between incompatible hash formats and no unverified old-format exception in this full recount.

## Retained records and execution evidence

Independent script: `audit/resume_psi_independent_full_recount_20261111.py`.

Results: `audit/psi_independent_full_recount_20261111/`, containing metadata with all input-file pins,101 chained recount files, COMPLETE.json and a separate resource record. Each recount file is published by same-directory replacement after a complete batch of at most64 windows; the final batch contains39. Saved checkpoints retain indices, endpoints, recomputed counts, numbers of checked subcounts and raw hashes. For the older windows they also retain the checked ASCII hash.

After completion, a separate readback verified all101 checkpoint hashes/links, all6439 contiguous indices, the125271 checked-subcount total, the184106689 prime total and the final COMPLETE link. The actual run started with zero saved checkpoints and completed without resuming, so all reported classifications were recomputed in this process. The resume support is not being cited as evidence of a crash-recovery test.

Measured internal wall time was17.625697100000252 seconds and process CPU time17.484375 seconds. These measure this external Python recount on the supplied host; they predict neither Lean checking time nor proof-term size. No memory peak measurement is claimed.

## Relation to the exact theta and E argument

The earlier independent stress/repair audit rechecked the538 old logarithm and theta chains from stg2813. The full protocol audit rechecked all5901 new chains, all93 producer receipts and final summary, including every source rational logarithm certificate and relaxed checkpoint margin. Together with this full recount, all6439 externally supplied count values now have complete independent count confirmation, while their exact arithmetic use has already been independently replayed.

The complete theta+/-a/10000 condition is externally supported on the unchanged a/4000 grid. Its reviewed interpolation with P6 preserves the original finite E target. The original tighter theta+/-a/24000 enclosure failure at window538 remains a failed sufficient test, not a proved violation of the true theta bound; this recount does not change that classification.

This remains external evidence. Lean must still prove the complete base and generalized count specifications, check concrete counts and logarithm certificates, connect the exact recurrence to theta, and formalize the interpolation/P6 step. There are zero new Lean count proofs. The additional low-zeta strip/weighted-moment certificate for the analytic tail from5e9, the selected full-family finite spectrum, global-provider validation and analytic bridges remain unproved. Completing the count dataset does not establish the entire E input or Goldbach.

## Pins

| Artifact | SHA256 |
|---|---|
| independent full-recount script | 91E562890951E8DE351D4AB57591BD9768E93B3A27BE36C9466E27E8B66A2D4F |
| independent metadata.json | 95F6002859D1D8206795C6032F59099E9C3BBDBB9F5EA39C50D6BBAA37B7BB32 |
| independent COMPLETE.json | 0A6536BAE4B8D4AE23D6C4B579B0B87DB7EBB161B17645BA0E3C62D112CCDB14 |
| independent resources.json | 542840B93F8E583E86902E50526EBAEBE475264E3113BC7E7DF6AE165CF19CC6 |
| last independent checkpoint | 9C01EE4E42F43FC8B36EE3E5BA435459E5DF4FDC2089C479D5679F84F98004C9 |
| producer full-candidate report | 466ABA0CBBBE9ED52C9FFB805336CBF7208AEF25DAD57C45FCA03CD9E8EACDDE |
| producer COMPLETE.json | 92770E969395E4817210366B3ECBDFF218768D800C923CA6E7944CF71DD73763 |
| earlier independent protocol review | 0BB7635946109CD6C6270FB8C33AF78C3B05D3B795A33153349F6CF9DF25B7F0 |

Read the producer full-candidate report in full after the recount. Its numerical and status claims agree with this review; its historical lack of a full independent recount is superseded here. The producer's original files and report were preserved.
