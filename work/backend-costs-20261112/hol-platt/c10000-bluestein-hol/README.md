# Stock HOL4 replay for conductor 10000, length 500

The exported equality blue_actual_500 evaluates blue_run on four literal vectors (512 FFT roots, 500 chirps, 1024 normalized kernel entries, 500 Gauss-axis inputs) to all 500 complex output pairs from ../c10000-bluestein/outputs.tsv. The replay requires an empty hypothesis list, admits only DISK_THM oracle tags and requires empty explicit axiom tags before saving. Both runs execute the circuit and check the full right side against the native integers.

BlueScript.sml defines the rounded three-product multiplication, even/odd splitting, two ten-level radix-two FFTs, chirping and normalized-kernel multiplication. It uses exact integer addition/subtraction and coordinate grid 2^-307. The forward FFT uses positive roots. The backward FFT uses their conjugates. The division by 1024 has already been absorbed into the supplied kernel. The recursive FFT interleaves decimation by even/odd input indices and combines two half-length transforms in increasing output-frequency order. The theorem computes the public circuit from those literal vectors. For a reusable analytic theorem one still needs its DFT specification, the chirp and unit-root interpretation, a proof that the rounded kernel represents the correct normalized convolution, binding of the actual Gauss source, and a forward error argument. The companion native check compares all 500 outputs to independently evaluated exact-source ball dot products and reports a maximum error of 704 grid units.

| HOL conversion phase | Cold CPU s | Warm CPU s |
|---|---:|---:|
| Data encoding and conversion setup | 6.754403 | 5.743586 |
| Integer CV execution | 0.403917 | 0.303648 |
| HOL output decoding | 0.500166 | 0.481487 |

The cold row starts in a freshly loaded HOL process with the compiled generic theory available. The warm row reuses the process with the same inputs. The conversion timers exclude discharge, equality checking, theorem export and process startup. The full replay process took 33.80 seconds wall and 28.09 CPU seconds and peaked at 1,636,940 KiB RSS. The earlier generic theory build took 41.61 wall seconds and peaked at 396,068 KiB. The export .hol/objs/BlueActualTheory.dat is 3,627,335 bytes. The single worker used the production HOL pin and a 4 GiB process memory limit.

prepare.py regenerates the TSV fixtures from the companion native program and outputs. BlueScript.sml and replay.sml are the authoritative final theory and replay sources. make_replay.py is a historical generator draft. run.sh uses the read-only workspace mount with a writable experiment directory. The successful logs are b02_theory.log and b04_replay.log with their time/status files. Earlier logs retain the required rounding precondition and two replay setup fixes. artifacts.sha256 identifies the inputs, final source, export, and successful receipts.
