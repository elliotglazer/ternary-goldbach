# Apply the tail theorem before rewriting successor notation

Tx03 reached the local emit-projection proof. ADD1 rewrote SUC n into n+1 before TL_GENLIST could match its successor-shaped length. The remaining goal is the intended one-step tail identity.

The successor applies TL_GENLIST with bool_ss first, then unfolds composition and normalizes successor arithmetic with arith_ss. This changes only the proof's rewrite order; the program and theorem statement are unchanged. The failed source and saved proof state are preserved under history/tx03_successor_rewrite.

Successor source SHA256: `e49bd5beafd0e1c3d2aa6b0400aea056e16547424df7b13ae6db32ad5532cc43`.
