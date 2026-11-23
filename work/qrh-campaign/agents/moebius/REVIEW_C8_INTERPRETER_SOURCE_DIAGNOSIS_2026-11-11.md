# Review: C8 interpreter identity and accounting limits

2026-11-11. **PASS for the stated static diagnosis; no capability acceptance.** No substantive correction is required. The retained evidence supports identifying the inspected base executable with the ordinary CPython console-frontend structure, rather than the upstream venv-redirector structure. It does not explain the additional job-accounting entries, establish the absence of helpers, or authorize weakening the single-worker checks.

## Bound artifacts

Paths are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| Author `integration/C8_INTERPRETER_SOURCE_DIAGNOSIS_2026-11-11.md` | `BFFBCC6136F99EBB953E8622FC65C7746AA86A1989C9590584D8C419A82B26E2` |
| Author `integration/c8_interpreter_pe_readonly_20261111.ps1` | `6442D862052438314E2B535CBF6A5195FC161F304FB7507C09BED37E8F76E596` |
| Author `integration/c8_interpreter_pe_readonly_20261111.json` | `F64BD3CF2EF090B42CAA334E2029FDC3F1BE6ED4A920C227AC58D319CFF21219` |
| Independent byte parser `moebius/review_c8_pe_bytes_20261111.ps1` | `B54C8554D19626B20BB92E2FA75EB9060FE94D629A4F0AEA9779C53C4A073294` |
| Independent byte receipt `moebius/review_c8_pe_bytes_20261111.json` | `59C52A92CFE7DC15FA4F561646253FD692EBFD496B7E9E90AB531DF4F117E27E` |

All three author hashes were rechecked. The independent parser read the three named files as bytes, compared their hashes with the receipt, and reconstructed their complete import directories. It did not execute or load an inspected image. Neither a process-query API nor the capability fixture was invoked. The PowerShell parser itself was run solely for file-byte analysis; this was not a run of Python or of the inspected binaries.

## PE evidence

The independent parser reproduced all imported DLLs and symbols, including ordering:

| Inspected file under `C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64` | Imported DLLs | Imported symbols |
| --- | ---: | ---: |
| `python.exe` | 8 | 44 |
| `python314.dll` | 19 | 404 |
| `DLLs/_hashlib.pyd` | 6 | 125 |

It separately checked the MZ/PE signatures, PE32+ header, AMD64 machine, subsystem, delay-import fields, complete zero-terminated import descriptors and thunk lists, and that every consumed RVA span has actual file backing. This follows the field meanings in Microsoft's [PE specification](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format). The author's parser uses a virtual/raw section-size maximum and bounded loops; those choices would need more validation for arbitrary malformed files. They do not invalidate this bounded result: the independent parse found all consumed spans file-backed and all relevant lists terminated within their declared structures.

The executable is 106,208 bytes, console subsystem 3, and imports precisely `Py_Main` from `python314.dll`. Its direct imports do not contain the listed process-launch/console-allocation routines or `GetProcAddress`; its delay-import directory is zero. The core DLL does contain `CreateProcessW`, `_wspawnv`, `_wspawnve`, `_wsystem` and `GetProcAddress`. The `_hashlib` image has no direct process-launch/console-allocation import in the checked lists. These are import-table facts, not executed-call facts or a transitive call-graph proof.

The local executable, core DLL and `_hashlib` hashes match the author table. FileVersionInfo independently returned 3.14.7 for file/product versions, `Python Console` for the internal name and `python.exe` for the original name. The adjacent header declares 3.14.7 final. The three named library-source hashes and the fixed child/supervisor hashes also match. Version/header metadata corroborates identification but does not establish a reproducible source-to-binary build.

## Primary-source interpretation

The version-tagged [ordinary entry source](https://github.com/python/cpython/blob/v3.14.7/Programs/python.c#L6-L9) sends Windows `wmain` to `Py_Main`. Its [project configuration](https://github.com/python/cpython/blob/v3.14.7/PCbuild/python.vcxproj#L93-L116) selects the console subsystem, compiles that source and references the core project. The [main runtime path](https://github.com/python/cpython/blob/v3.14.7/Modules/main.c#L805-L829) initializes and calls `Py_RunMain` in the same process. Conversely, the [venv launcher](https://github.com/python/cpython/blob/v3.14.7/PC/venvlauncher.c#L419-L429) explicitly creates another process and waits for its result. The observed import structure fits the first path and not that upstream redirector path.

This is a supported identification of structure, not a complete binary control-flow verification. A program can load code indirectly, and a direct-import list alone cannot exclude equivalent behavior implemented differently. The author already states this limitation and disclaims source-to-binary reproducibility; no stronger reading of “not the redirector” is accepted here. The separate `Scripts/python.exe` of a virtual environment was not the examined input.

The [preconfiguration handling of `-I`](https://github.com/python/cpython/blob/v3.14.7/Python/preconfig.c#L191-L232) and [isolated-mode settings](https://github.com/python/cpython/blob/v3.14.7/Python/initconfig.c#L3310-L3314) support the author's environment/user-site/safe-path claims. [`-S` disables `site_import`](https://github.com/python/cpython/blob/v3.14.7/Python/initconfig.c#L2830-L2832), and [normal site initialization is conditional on that field](https://github.com/python/cpython/blob/v3.14.7/Python/pylifecycle.c#L1221-L1226). “Python environment use” is the correct scope; this is not a claim that Windows environment state, loader behavior or native dependencies cease to matter. These flags are not a process sandbox.

The fixed child was read in full. Its explicit operations are the stated imports, file/JSON/hash work, allocations, garbage collection and bounded waiting. It contains no explicit process creation or FFI. The V3 supervisor source binds the explicit base application path, constructs `-I -S`, and passes `0x08000004`. Microsoft's [creation-flag documentation](https://learn.microsoft.com/en-us/windows/win32/procthread/process-creation-flags) identifies that combination as no-window plus suspended; the inspected call adds neither a new-console nor detached-process flag. The documentation does not promise that no OS-mediated process or accounting event can ever occur.

Finally, the source links for [`os.system`](https://github.com/python/cpython/blob/v3.14.7/Modules/posixmodule.c#L5689-L5703), [`os.spawnv`](https://github.com/python/cpython/blob/v3.14.7/Modules/posixmodule.c#L7277-L7301) and [`_winapi.CreateProcess`](https://github.com/python/cpython/blob/v3.14.7/Modules/_winapi.c#L1304-L1326) do explain why a general-purpose core DLL may import process APIs. They do not show that this child invoked them. Their presence and the frontend's absence of such direct imports must not be used as opposite proofs of runtime behavior.

## Accounting conclusion retained

The reported inner counts 0→1→2 and outer counts 0→1→4 are not independently reproduced or reinterpreted by this review. No identity, executable path, creation stack, parent relation or lifetime for an extra entry has been established. In particular, neither `conhost.exe` nor a hidden venv helper is identified by this evidence.

The strict capability gate therefore stays unresolved. The useful new conclusion is limited: the specific base executable has ordinary CPython-frontend structure; an intentional launch was not found in the inspected startup/child paths; the accounting anomaly still needs separately authorized runtime evidence. No counters, caps, zero-helper requirement, fixture predicate or production gate are changed by this PASS.
