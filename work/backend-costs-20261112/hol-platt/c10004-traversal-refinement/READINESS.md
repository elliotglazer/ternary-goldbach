# Complete traversal refinement candidate

Prepared but unbuilt. The intended final targets are the exact length-4800 tensor equality and unconditional checked-entry equality stated in the original candidate's requirements. All intermediate list and shape lemmas serve these targets. No target is assumed, and no performance or analytic claim is made.

The source consumes the accepted C10004Projection theory and the still-pending C10004TraversalBase theory. The latter must complete its exact-conclusion audit before this candidate is built. The public arithmetic, root guard, input guard, output guard and failure behavior remain the frozen reference definitions. The generic concatenation and transpose lemmas include zero-width and empty shapes rather than adding new production input assumptions.

Before running, prepare a pinned source/dependency manifest and a reload audit that compares both final conclusions exactly, checks empty hypotheses, and restricts ancestry/oracle tags. No runner or measured result exists in this directory yet.

A bounded runner and six-root exact-conclusion audit are now prepared, still unrun. The initial predecessor base pin is provisional: refresh it only after inspecting the eventual accepted base result. The runner requires both predecessor RESULT_REVIEW.md files in addition to matching every source and artifact pin.

Further source review qualified the actual LESS_MONO_MULT2 theorem, supplied a left-oriented flatten lookup lemma to avoid commutative matching, opened the two MAP proof binders before beta conversion, and instantiated concatenation width 59 explicitly rather than asking a rewrite to infer a variable absent from its left side. These are still unbuilt proof candidates, with unchanged final target statements.

Traversal11 is now accepted in the predecessor RESULT_REVIEW.md. The base source pin has been updated to fb4066b7f216b74cec2b56a183b6305efcbe1aaf2fd5011ea2ae8c6b5e23afe0, and all accepted traversal11 and projection07 output artifact pins were rechecked before the first refinement run. The initial refinement source is still unbuilt.
