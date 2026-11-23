# Correction of my draft height transcription and source attribution

2026-11-11. The accepted occupancy source is correct and requires no erratum. My preliminary message attributing an even-height typo to that source was a reading error. The factor-of-two error occurred only in my new, unadopted power-of-two normalization draft and its preliminary metadata. This note corrects my attribution. Accepted files and counts remain unchanged. No evaluator, selected-family scan or build was run.

`prime-estimates/LARGE_RESIDUE_BUCKET_OCCUPANCY_2026-11-11.md`, SHA256 `99B76FC9277CA0297C9CF7301DF97FF9667CDE05C1AD0BBD8C5D32DF88D118C1`, line27 already distinguishes the two conductor parities correctly:

    odd c: d=531600/c, u=96/5, floor term240;
    4|c:   d=1063200/c, u=191/10, floor term255;
    H(c)=ceil(200+max(floor term,(3927/1250)*u*d)).

The companion program uses the same correct parity-dependent numerator. At lines73–74 of `prime-estimates/large_residue_bucket_occupancy_20261111.py`, SHA256 `549EDC2159B6843527DB1A45014571AEF46926835BA60DEC5CC8C8E5150A06B9`, the height expression includes `(531600 if odd else 1063200)`. It also uses the correct96/5 versus191/10 multiplier and240 versus255 floor. Moving the integer200 and integer floor outside the displayed ceiling does not change the height.

The source formula is explicit in `major-constants/COMBINED_ODD_EVEN_HEIGHT_CONDITIONAL_COST_2026-11-11.md`, SHA256 `6143FA8444ED97084998D769E114DCAB3DC2C12DCAF9649C32CFA1989658487C`, lines11–12. Its even branch is `ceil(200+max(255,19.1*3.1416*1063200/c))`. The odd/even primary profile pins are C4EE2B2F674F6376D987C778FC7886A03A93BC81E61C0BC56D0B1C25E2E4A14D and D3408AA27763D7E3C475E7B27DB124FDE9C16EDC916CEE061563B31D9A2DD88B, respectively, as bound there. There is no contradiction between these frozen sources. Zero_sum and moebius independently checked the source line and unchanged hash after my false alert.

The occupancy script uses this correct height to form the closed final index and every band multiplicity at lines75–80. It then checks its aggregate residue, Horner-stage and conductor-height totals against the frozen selected ledger at lines113–115. The saved receipt `prime-estimates/large_residue_bucket_occupancy_20261111.json` has SHA256 `19E0AC3EB1F860A38151F46F792595DEDE7BA7D0180A244425C6C969EFBF58DB`. The reviewed producer therefore used1063200/c on the even branch. Neither its prose nor its saved counts need correction. The program was not rerun here.

My preliminary `residue_power_two_normalization_20261111.json`, SHA256 `33BBAA6CE73D91751B4CE7C27CC090094002810AFF9FB9ECF1137ECEB6319F81`, used531600 in both slopes. Its height-clipped even class counts are withdrawn. It must not be used for a cost or eligibility conclusion. A separately named final receipt and final report will bind the corrected slope. The polynomial identities and width derivations do not depend on that height coefficient, but the numerical class populations must still be recomputed correctly.

No accepted occupancy count or source file was changed. The earlier unissued clarification draft falsely describing a source typo was replaced before its pin was supplied as a frozen deliverable. This is the authoritative correction of that draft and message.
