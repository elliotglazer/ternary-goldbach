# Rocq native comparison setup

The P343N64 native benchmark and independent check are now complete. The earlier Windows Rocq 9.1.0 run
silently fell back to the VM. Alpine v3.22 also supplies its Rocq 9.0.0 package
with native_compiler = NativeOff. Installing that package alone does not provide
the desired comparison. Its OCaml 4.14.2, findlib, Zarith and Dune dependencies
are useful for a source build, all installed inside this directory's sysroot.

fetch_source.py downloads the official Rocq 9.0.0 source release and verifies
its SHA512 against the Alpine package recipe. source.json records it.
prepare.py relocates the runtime/findlib paths and copies the exact existing
Rocq arithmetic fixtures. The first configuration attempt failed on findlib's
absolute ld.conf path; configure_unrelocated_ld.log/.time preserve that attempt.
The corrected configuration succeeds with -native-compiler ondemand.

The source build completed after adding the declared Linux headers/findlib
development archive and correcting the relocated Bash and GMP search paths.
The failed setup logs remain. No prover source or inference rule was modified.
The final incremental build is build.log/.time, exit zero; its 9.86 CPU seconds
are NOT the full setup cost. prepare_native.py uses Dune's completed install
tree, with the packaged 9.0.0 logical libraries. native_manifest.json pins the
configuration and executable. native_config.log confirms NativeOndemand.

NativeSmoke.v then proved an axiom-free arithmetic fact with actual native
compilation/evaluation output. StageCheck.v and the exact P343N64 data compiled.
Three fresh processes per native/VM variant are preserved by run_measurements.sh.
The original inline WSL loop lost the suffix in its log filenames and overwrote
earlier samples; native_r/vm_r are exploratory final samples, excluded from the
repeat medians. All new sample logs and hashes are retained in RESULTS.json.

Native Qed parent CPU has median 0.381 s, versus 0.784 s for this build's VM.
That excludes compiler child CPU. Whole-file medians including children are
5.82 versus 4.79 CPU seconds, and 34.61 versus 19.32 elapsed seconds. Native's
reported evaluation phase has median 0.20153 elapsed seconds, compilation
6.84930 seconds. pretyping/nativenorm.ml uses Unix.gettimeofday for these phases.
The Windows-mounted filesystem adds substantial loading/linking latency.

All four rejection controls and the valid control pass with no axioms.
Independent rocqchk replay with all dependencies also succeeds, reporting no
axioms, type-in-type, unsafe fixpoints or assumed positivity: 25.88 CPU seconds,
67.86 elapsed seconds, 192228 KiB peak RSS. RESULTS.json's summarizer requires
these markers and zero exit status. No native-computation job remains active.

Further work includes whole-block amortization and other widths, not another
unnecessary repeat of this same completed pilot. This remains an integer
residual certificate, with no analytic root/source/zero-count interpretation.

Rocq 9.0's checker/coqchk_main.ml explicitly disables native compilation in
rocqchk. Thus a successful independent check will use a different conversion
path; its cost is separate from native acceptance by the ordinary Rocq kernel.
Do not silently price that optional independent replay at the native rate.
