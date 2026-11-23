# Compiled CV equation inspection

Source only; not built or run by the author. This driver imports the three
actual compiled definitions and their representation theorems from
`RoundSpecializationCV`, extracts each definition's left-hand-side head, and
calls stock `cv_transLib.cv_eqs_for` on that head. The traversal therefore uses
the saved translation database rather than guessed reachable function names.

Each imported and reachable equation is printed as human-readable theorem text
and an explicit constructor-level AST with qualified constant names and types.
The driver prints direct RHS counts of `cv$cv_div`, `cv$cv_mod`,
`cv_prim$cv_int_div`, and `cv_prim$cv_total_int_div`; it also prints counts summed
over the returned closure, with each returned equation counted once. These are
syntactic occurrences, not dynamic call frequencies. In particular, two DIV
occurrences in opposite branches do not mean two executed DIV operations.

Every `cv$cv_if` condition is printed with its path and the separate then/else
counts. This exposes the exact new helper's sign branch and the stock divider's
positive-denominator/negative-numerator branch without evaluating a fixture.
The stock `cv_prim.cv_int_div_def` and representation theorem provide a separate
contrast. The new closures fail closed if they contain a MOD or a stock signed
divider call. Root presence and hypothesis-free imported equations are checked;
oracle tags are restricted to the existing DISK_THM import tag. No theorem is
asserted by this inspection.

Prerequisite: root's successful round03 build, using core source SHA256
`37CB4079D95F48B1F1FF9974525C909DDA21F829FD39FB341027EB9CD5380DAF`
and CV source SHA256
`269681276C74C1EE027CD31A8C146EE38D896BC7CE1C4166DB24E90EB72CD336`.
Root should snapshot the actual cached object/data hashes along with those
receipts. This source does not infer object/source binding from file existence.

Build only this executable with `Holmake --no_prereqs inspect_cv.exe` after
source review, then run it under the normal serialized limits. The driver does
not call cv_eval, cv_compute, EVAL, a numeric root routine, or any benchmark. It
does not edit or export a theory, retain numeric results, or change the reviewed
benchmark sources. Successful output ends with `HOL4_ROUND_CV_INSPECTION_DONE`.
Read the emitted branch structures before making the runtime one-quotient
statement. This inspection supplies no speed measurement.
