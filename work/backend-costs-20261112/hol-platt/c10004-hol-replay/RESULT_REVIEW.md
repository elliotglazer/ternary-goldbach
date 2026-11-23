# Conductor 10004 actual integer transform replay

HOL4 exported two closed equalities for `ft_checked roots xs = SOME ys`. The roots contain the nine supplied positive-exponent p81 rows. Each input contains the 4,800 rounded complex integers from the corresponding source TSV in flattened input order. The native reference spectrum and the HOL output agree exactly in both coordinates for all 2,301 primitive channels at each height, ordered with k61 varying fastest. The heights are 5/64 and 10/64.

| Height | Encoding and conversion setup, CPU s | CV execution, CPU s | HOL decoding, CPU s | Premise discharge, CPU s |
|---|---:|---:|---:|---:|
| 5/64 | 5.762261 | 0.660461 | 2.673576 | 0.000805 |
| 10/64 | 4.506782 | 0.650317 | 2.776179 | 0.000220 |

The first row used a fresh HOL process. The second ran in that process with its loaded libraries and caches. Both theorems explicitly contain their own literal inputs and outputs. The isolated single-worker process took 46.06 s wall and 37.94 s CPU, including loading, term construction, both evaluations, output serialization and theory export. Peak RSS was 1,611,960 KiB. The preceding Holmake dependency scan and audit module build took 22.31 s wall. Previously built generic theories were loaded from disk.

The successful evaluator instantiated the generic CV representation with literal arguments, proved their encodings by EVAL, used stock CV computation to execute the integer transform, decoded each result by EVAL and discharged the rounding premises. Both output theorems have empty hypotheses, only DISK_THM oracle tags, and no explicit axiom tags. The exported ancestor axiom inventory comprised the four standard HOL axioms listed in the replay log.

The initial direct CV translation of the 4,800-element source term was stopped after 258.37 s wall and 2,101,596 KiB peak RSS. The successful run used the same data and computed the same requested term. The inputs, positive-exponent root values, source-row ordering and their relation to the analytic target are separate obligations. This timing covers the concrete integer transform.

## Evidence

* `a02_replay.log`, `a02_replay.time`, `a02_build.time`, `a02_compare.json`
* `.hol/objs/C10004ActualReplayInstTheory.dat` stores both closed equalities.
* `a02_h1.tsv` and `a02_h2.tsv` contain HOL output pairs. Their integers carry the HOL printer's trailing i. The comparison checks the complete token syntax and both coordinates.
* `prepare.py` imports the inputs. `replay_inst.sml` and `run_inst.sh` perform the kernel replay. `compare.py a02` compares the results to the native spectra.
* `a02_artifacts.sha256` binds the sources, inputs, existing generic theory objects and outputs.
