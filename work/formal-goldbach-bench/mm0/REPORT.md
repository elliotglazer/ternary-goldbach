# Measured MM0 cached word-proof costs

Date: 2026-11-10. This is an actual `mm0-c` verification benchmark, including its specification parser. It measures a schematic cached arithmetic library. It is **not an end-to-end PA proof, a primality certificate benchmark, or a proof of Goldbach**.

The strongest representative result is the actual prime-cover OR trace: **0.822 microseconds of checker CPU and 0.400 microseconds of native producer CPU per 64-bit mask update**, with **150.01 encoded proof bytes per update**. These are differences of matched bootstrap and workload medians. Gross checker cost at the measured chunk size is 0.901 microseconds per update.

## Results

All three principal runs accepted the valid MMB against its MM0 specification. Each also rejected an intentionally incorrect cached-proof reference with `MM0_REJECT: unify failure at ref`, exit 255.

| Workload | Updates | Checker CPU/update, net | Native emission CPU/update, net | Encoded bytes/update | Checker net range across repeats |
|---|---:|---:|---:|---:|---:|
| Actual selected masks, OR, resets at word boundaries | 462,720 | 0.822 us | 0.400 us | 150.01 | 0.774–0.945 us |
| Sparse synthetic masks, OR, reset every 16 | 500,000 | 0.913 us | 0.431 us | 141.52 | 0.760–0.984 us |
| Sparse synthetic masks, fixed three-bit slice and OR, reset every 16 | 500,000 | 1.306 us | 0.575 us | 196.46 | 1.132–1.524 us |

The actual fixture has 256 distinct words and 2,892 selected mask updates, repeated 160 times. Every word starts at zero and reaches all ones in the independently checked fixture. The MM0 state records the previous accumulator as well as the trace, so each update must use the actual previous result. The synthetic sparse source bytes are the AND of three independent pseudorandom bytes, giving bit density 1/8 before slicing. Resets prevent the dense random OR chain from spending almost all its time at 255.

The native producer emits ordinary MMB proof operations, not a compressed custom proof format. It uses buffered C output to Linux tmpfs. The actual run writes 73,765,796 bytes including its 4,353,024-byte bootstrap. The specification is 2,766,579 bytes. The measured incremental emission rate is about 375 MB/s. The slice/OR run writes about 342 MB/s. No storage device throughput is inferred from these RAM-file results.

Seven checker CPU samples and five producer CPU samples are retained per bootstrap and workload. `summary.json` contains normalized results; `*.native-result.json` and `*.native.log` retain the raw samples and command evidence. Actual-run checker bootstrap median is 0.036340351 seconds, and workload median is 0.416702882 seconds. Their difference divided by 462,720 is 0.822014460 us. Producer bootstrap median is 0.001913473 seconds and workload median 0.186816353 seconds.

## What the checker does

The generated MM0 specification declares byte constants, fixed-width word constructors, a source constructor, a trace constructor, and `valid(trace,currentWord)`. It gives explicit closed byte OR facts and, for the slice variant, byte-pair slice facts. A generic lifting rule combines eight cached digit facts into the new 64-bit accumulator. Each update references the previous trace and current word, constructs the new result, and applies the lift. The reset rule consumes the current state and constructs a reset state with zero accumulator. Trace terms and word terms share their predecessors through heap references.

All truth-table facts, lift/reset rules, and the final rule are **axioms in this schematic specification**. The final theorem is `ok`. A complete PA implementation would need actual definitions, proofs of the table entries and generic rules, and a meaningful final coverage statement. This experiment measures the resulting proof application pattern, not those missing derivations. Reset currently does not require a proof that the preceding word is all ones. Python verifies that property for the actual fixture, but it is not certified by this MM0 theorem.

The full byte OR table has 65,536 facts; the slice variant has another 65,536 facts. Their proofs and the canonical byte values are cached once per theorem. In the actual run the per-update differences are 58.6196 proof interpreter commands and 94.5048 unifier commands, totaling 153.1244. The measured ratio is about 186 million such commands per CPU second. The slice/OR run averages 75.4375 proof commands plus 134.0625 unifier commands, about 160 million combined commands per CPU second.

These are actual interpreter-loop counts from a separately instrumented binary. They include loop terminators and exclude nested work such as theorem-argument iteration. They are not CPU instructions, mathematical inference counts, or interchangeable with an unspecified earlier 'event' estimate. Timing uses the uninstrumented verification path plus clock calls.

Saved-expression identities grow by two per update and one per reset. Separate `HIGHWATER` runs confirmed 1,032,193 heap entries and 77,404,708 store bytes for the actual trace, and 1,162,579 heap entries and 86,201,020 store bytes for the slice/OR trace. These are logical allocation counters, not process RSS. Pointer sharing avoids walking the full trace for every update. The verifier resets temporary storage and loads a new heap at theorem boundaries, so this cache cannot be assumed to persist across arbitrary independent proofs. `resources.py` reproduces these separately instrumented checks; their CPU times are not substituted into the timing results.

## Other measured variants

Earlier dense synthetic runs are retained as sensitivity checks, not the preferred forecast inputs.

| Variant | Net checker CPU/update | Bytes/update | Proof + unifier commands/update |
|---|---:|---:|---:|
| 4-bit digits,64-bit slice/OR | 1.349 us | 317.28 | 139+253 |
| 8-bit digits,64-bit slice/OR | 1.428 us | 241.10 | 75+133 |
| 8-bit digits,64-bit OR only | 0.754 us | 183.07 | 58+93 |
| 8-bit digits,256-bit slice/OR | 4.412 us | 841.38 | 267+493 |

The nibble table is much smaller but requires more operations. The256-bit variant is a different word width, not an optimized large-word result. A 16-bit OR table would contain 2^32 facts and would exceed stock MMB statement-table limits in this representation. Neither a larger-digit optimization nor a verified native arithmetic extension has been measured. These results cannot establish the best possible MM0 architecture.

## Environment and reproducibility

CPU: AMD Ryzen 9 8945HS, 8 physical cores, 16 logical processors, reported maximum 4001 MHz. Host RAM: 33,593,020,416 bytes. The benchmark is single-threaded. It runs under WSL `docker-desktop`, Linux 6.18.58.1-microsoft-standard-WSL2, x86_64.

MM0 source is pinned to [`digama0/mm0` commit 0d414c0bfdaaeb7fea571895127abc1fa5a3d956](https://github.com/digama0/mm0/tree/0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-c). The local `src` folder holds the source. Windows Clang 23.1.0 cross-compiles it with `--target=x86_64-linux-musl -O3 -static`, using Alpine v3.22 `musl-dev 1.2.5-r13` headers and static libc. `build-manifest.json` records full commands and binary hashes.

`build.py` raises heap capacity to 2^22 entries and store capacity to 2^30 bytes. It inserts `CLOCK_PROCESS_CPUTIME_ID` around parser initialization and verification. It replaces only the upstream interactive failure diagnostic with a bounded message and the same rejection exit. The instrumented variant additionally counts proof and unifier loop iterations. Verification rules are otherwise unchanged. `NO_PARSER` is not enabled.

Timing starts after the initial mmap setup and includes parser/verification work and subsequent page accesses. It excludes process launch and WSL startup. Inputs and binaries are copied to `/dev/shm/goldbach-mm0-bench`. An early smoke test took about 0.485 seconds on Windows-backed `/mnt/host/c` but about 0.000455 seconds on Linux storage. Those cross-filesystem results are excluded; they demonstrate why WSL process launch or DrvFS mmap time would be a poor verifier estimate.

From this directory, with the supplied source, sysroot and Clang path:

```powershell
python build.py
python generate.py --updates 0 --op slice-or --reset-every 16 --sparse-level 3 --name reset-slice-prefix
python generate.py --updates 0 --op or --reset-every 16 --sparse-level 3 --name reset-or-prefix
python native_run.py
python summarize.py
```

`native_run.py` reads `../prime-cover/actual_trace.json`, checks each mask against its two source words and shift, checks every accumulator transition and final all-ones result, then writes a compact mask/reset input for the native emitter. Trace SHA256 is `f073f27d03a88b84aa19825f7cf8bfc2e3028d4bf8f8843ce385b2a59ecfabc2`. Final actual MMB SHA256 is `daaf967ac508e8a231f1f035c8642d4137d67c93c2128fa1267158e43eb93286`. Full generated proofs remain reproducible from these files. Large native proofs are temporary RAM files and may disappear when WSL stops; source inputs, scripts, hashes, and measurement logs are saved in the workspace.

## Forecast boundaries

The actual-mask measurement is suitable for an optimistic prealigned-mask OR stage. It does not certify source bitmap membership, source indices, primality, or arbitrary alignment. The slice measurement adds a fixed arithmetic alignment pattern but still lacks those provenance proofs. The actual fixture is small and repeated; it does not expose the memory behavior of a huge source bitmap or billions of distinct certificates.

For the measured serialized pipeline, net actual OR production plus checking is 1.222 us/update, before those excluded duties. A fused template producer/checker could avoid intermediate storage and some duplicate work. Adding an independent mandatory bytes/second charge to such a fused design would double-count work unless measured separately. No fused implementation was benchmarked here.

Bootstrap must be charged per actual theorem/container, even though the normalized incremental numbers subtract it. At the measured actual chunk size it adds 0.0785 us/update to checking. Stock MMB still requires theorem statements in the first4 GiB and individual proofs below4 GiB. Raising heap capacity does not remove these format restrictions. Large-scale deployment needs sound chunking and composition; arbitrary files treated as trusted imports would change the theorem being checked.
