# Archived h=1 raw heads

HOL4 proved that all 4,800 archived grid100 heads equal the output of `raw_head 10004` on the deterministic grid120 states at height index 1. For every index below 4,800, `h1_archive_analytic` transfers the strict Euclidean error bound 2^-85 to that archived row. Its comparison value is

    exp ((-1/2 - i*5/64) * log (full_residue(index)/10004)).

The index restriction is the only premise. The proof also establishes positivity of every residue it uses. It applies to the raw heads at this height.

`H1RawCvScript.sml` proves the source-state equality for candidate floor logarithms and inverse-square-root integers satisfying their defining inequalities. It discharges the nonzero denominators in the logarithm, exponential, state update, and terminal rounding. The concrete finite evaluation checks those inequalities for every actual residue, uses the original signed-block decoder and checks every output pair. HOL4's CV evaluation took 3.116 CPU seconds. The generic export took 21.80 core-seconds and the finite export took 34.36 on top of the already compiled libraries. Peak resident memory for the finite export was 1,009,452 KiB.

In a separate process, `match_audit.sml` checked the two exported conclusions, empty hypotheses, and theorem tags against the standard HOL axioms. It located the packed head term in both original consumer theorems, compared it with the literal in the new theory, and independently reconstructed all 300 packed numbers from the 4,800 TSV rows. The fresh audit execution took 20.64 CPU seconds after 5.27 core-seconds to compile the audit module. The successful logs are `match02.log`, `matchdata04.log`, and `matchaudit02.log`.

| Original source | SHA-256 |
|---|---|
| h1-rawhead.tsv | `68814315485e92cfeee9b962f72c85d9ac63221eceefe472bf2cc79ae2c3444d` |
| heads.txt | `aaf3aa2b863b5919c907ae2712574ae481df63435adb15e7791f1f02992a4130` |
| C10004FullAdmissionTheory.dat | `b447b20c59a4e057cd4b832899fee54a6086a6dedefbef69aab172b7bc0d0240` |
| C10004FullIdentityTheory.dat | `9b303df90926adf82c397035c4768c0f2b55268526cece834cb800b9f24266a8` |

`matchaudit02.sha256` records the proof sources and additional inputs. `matchaudit02_output.sha256` records the exported HOL objects.
