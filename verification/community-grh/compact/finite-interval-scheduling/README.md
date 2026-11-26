# Finite interval scheduling

Stock Linux Lean 4.35 built all 103 changed `ProductRangeInterval` files in the complete finite Goldbach proof. These files contain 6,248 applications of the interval checker. The median file took 34 seconds. Lake reported between 5.1 and 65 seconds per file. The 103 durations sum to 55.01 minutes and overlap when Lake builds multiple files. The complete warm `CompletedFiniteRows` job finished in 22 minutes 39 seconds with 525 reused and 207 freshly built modules. That job includes the binary theorem through 564,386,325,504. [Individual Linux timings](linux-production-intervals.json)  [Complete finite job](../finite-terminal-22f442fa/)

The source change adds `set_option Elab.async false` to each selected file. Lean elaborates that file's declarations in sequence. The source manifest identifies the original and edited blob for every file. Removing the inserted line reproduces each original byte, including every proof and integer coefficient. The three-axiom check for the named Windows sample appears in its compiler receipt. [Source change](https://github.com/elliotglazer/ternary-goldbach/commit/dafa3e64289998b784aca99ec8fb491ddaac5362)  [Integrated source](https://github.com/elliotglazer/ternary-goldbach/commit/cb1dffe10fd5a86ab53fb71a4812eb73786ed530)  [Source manifest](source-manifest.json)

| Production file | Checker applications | Rows | Linux Lake elapsed | Windows elapsed | Windows CPU | Windows peak working set |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| `ProductRange145559905282Interval` | 40 | 320 | 22 s | 43.197 s | 41.625 s | 1.70 GiB |
| `ProductRange141264937986Interval` | 64 | 512 | 34 s | | | |

The Windows run emitted Lean objects, the language-server index and C output with the stock frontend, `LEAN_NUM_THREADS=4` and no `-j` flag. Peak committed memory was 3.87 GiB. On the same machine the original 320-row source took 41.547 CPU seconds under `-j1` with Lean-object output. The public Lean object, compiler IR and IR signature matched byte for byte. The private and server Lean objects differed. A speedup ratio for default asynchronous compilation under comparable Linux load would require a matched baseline. [Windows receipt](full-production-result.json)  [Output comparison](full-leaf-before-after.json)

A separate Linux test recorded the starts and finishes of twelve independent theorem proofs. Each proof spent 350 milliseconds doing CPU work. With `LEAN_NUM_THREADS=4` and no frontend flag, all twelve overlapped. The source option reduced the observed maximum to one. An explicit frontend `-j4` yielded four, and `-j1` yielded one. These figures measure concurrent proof tasks within a compiler process. [CPU test](cpu/Concurrency.lean)  [Raw Linux measurements](cpu/receipt.json)

## Reproduce the checks

Use a checkout of the proof repository that contains the source-change commit and its parent. Run from this evidence directory.

```sh
python3 verify.py --repo /path/to/proof-repository
python3 verify.py --repo /path/to/proof-repository --warm-log /path/to/original/warm-main.log
```

The second command requires the exact terminal log identified in the Linux timing record. To repeat the independent scheduling experiment, copy the `cpu` or `sleep` directory to scratch space and run its `probe.py` with the absolute path to stock Linux Lean 4.35. The script writes a new local receipt. [Measurement summary](measurement-summary.json)
