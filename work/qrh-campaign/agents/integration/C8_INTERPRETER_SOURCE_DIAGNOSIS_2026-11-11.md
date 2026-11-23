# C8 interpreter identity and process-accounting limits

2026-11-11. Read-only PE/source investigation. No inspected executable, Python evaluator, capability child or process fixture was launched. No process-query API was called. The companion PowerShell script reads bytes and version resources only.

## Finding

The pinned base `python.exe` has the structure of the ordinary CPython console interpreter frontend, not the CPython virtual-environment redirector. It directly imports `Py_Main` from `python314.dll`; its version resources and adjacent header identify 3.14.7. The matching upstream entry source calls `Py_Main` in the current process. The inspected startup path, `-I -S` handling, and fixed child's source do not contain an intentional helper-process or console-process launch.

This does **not** explain the observed job counters. It does not prove that no process was created by Windows, injected code, a native dependency or another uninspected runtime mechanism. It also does not establish byte-for-byte reproducibility of the installed binary from the upstream source. The source/PE evidence rejects an unsupported explanation that this specific base executable is simply the venv redirector, but does not replace the failed capability gate with a pass.

## Local evidence and pins

Inspected base directory:
`C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64`.

| File | SHA256 / observation |
|---|---|
| `python.exe` | `4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9`; 106,208 bytes; AMD64 PE32+; subsystem3, Windows console; FileVersion/ProductVersion3.14.7; OriginalFilename `python.exe`; InternalName `Python Console`. |
| `python314.dll` | `0F9857FFDFE010FE6B99328D58C2E3C7472CE75F336BF9C2AD9BD5BCA3BCE700`. |
| `DLLs/_hashlib.pyd` | `5933EF5EDA7C0BCA0B3874A6E2C5F13B91B8F2CFC29BC46160DF3212A1DBEE79`. |
| `Lib/hashlib.py` | `271B00A30D27C3CDD99B7F70962680F8455D3057B3C103F028E2DA31141B91EE`. |
| `Lib/json/__init__.py` | `27C55BB12498822E527294B61DB64BA44C79A18D4BAAD651B1660714A9785C4E`. |
| `Lib/pathlib/__init__.py` | `208546AA566CA8DF4B8E1259F30209C0F803C3F920E6D080AE1B10D53D05BD72`. |
| Fixed child `../audit/c8_supervisor_benign_child_20261111.py` | `4DC1257673F86240255F1B5331DA20BEAABE1B5DEFF85FF5E80D0A0EF58241BE`. |
| V3 supervisor `../audit/c8_supervisor_capability_preflight_20261111_v3.py` | `4488B65FB487CDF22E6B924410AA61032C20B423C88491C4E4984038337BA7C0`. |

The adjacent `include/patchlevel.h` defines major3, minor14, micro7, final release and version string3.14.7. The installation metadata `__install__.json` names `pythoncore-3.14-64` and the Python.org3.14.7 AMD64 distribution. This is supporting metadata, not the basis for identifying the executable's control path.

The executable import directory contains exactly these eight DLL dependencies: `python314.dll`, `VCRUNTIME140.dll`, `api-ms-win-crt-runtime-l1-1-0.dll`, `api-ms-win-crt-math-l1-1-0.dll`, `api-ms-win-crt-stdio-l1-1-0.dll`, `api-ms-win-crt-locale-l1-1-0.dll`, `api-ms-win-crt-heap-l1-1-0.dll`, and `KERNEL32.dll`. Its only imported Python symbol is `Py_Main`. The PE delay-import directory is zero. Its direct imports contain no `CreateProcess`, `WinExec`, `ShellExecute`, `AllocConsole`, `AttachConsole` or `GetProcAddress`. Ordinary CRT startup/exit functions and `GetModuleHandleW` are present.

The embedded debug path ends in `bin/amd64/python.pdb`, while the core DLL's ends in `python314.pdb`. These strings are recorded evidence, not a source-authenticity proof. The PE script does not execute or disassemble the complete binary, and absence of a direct import is not a general proof that a function can never be reached through another DLL.

## Matching upstream entry and redirector paths

The upstream3.14.7 [`Programs/python.c`, lines6–9](https://github.com/python/cpython/blob/v3.14.7/Programs/python.c#L6-L9) has the Windows `wmain` return `Py_Main(argc, argv)`. [`PCbuild/python.vcxproj`, lines93–116](https://github.com/python/cpython/blob/v3.14.7/PCbuild/python.vcxproj#L93-L116) selects the console subsystem, compiles that source and references `pythoncore.vcxproj`. Those facts agree with the local PE imports and subsystem.

By contrast, [`PC/venvlauncher.c`, lines1–6](https://github.com/python/cpython/blob/v3.14.7/PC/venvlauncher.c#L1-L6) identifies a venv redirector. Its [`CreateProcessW` path, lines419–429](https://github.com/python/cpython/blob/v3.14.7/PC/venvlauncher.c#L419-L429), launches another executable and waits for it. The local base executable's imported-symbol structure is not that path. The report does not make any claim about an environment's separate `Scripts/python.exe` wrapper; the input is the explicit base path above.

The matching [`Modules/main.c`, lines805–829](https://github.com/python/cpython/blob/v3.14.7/Modules/main.c#L805-L829) routes `Py_Main` through initialization and `Py_RunMain`. For a script filename, the [`same source`, lines370–429 and695–706](https://github.com/python/cpython/blob/v3.14.7/Modules/main.c#L370-L429) opens and executes the script through the Python runtime. It does not launch a replacement interpreter. These are source call-path findings, not an exhaustive audit of all native dependencies.

## `-I -S` and the fixed child

The V3 supervisor constructs an explicit application path and command line with `-I -S`, then calls `CreateProcessW` with flags `0x08000004`, namely `CREATE_NO_WINDOW | CREATE_SUSPENDED`. It assigns the returned process to the job and resumes its primary thread. No `CREATE_NEW_CONSOLE` or `DETACHED_PROCESS` flag appears in this call.

In CPython3.14.7, [`Python/preconfig.c`, lines191–193 and230–232](https://github.com/python/cpython/blob/v3.14.7/Python/preconfig.c#L191-L232) sets isolated mode and disables Python environment use. [`Python/initconfig.c`, lines3310–3314](https://github.com/python/cpython/blob/v3.14.7/Python/initconfig.c#L3310-L3314) also sets safe-path mode and disables the user site directory. [`Lines2830–2832`](https://github.com/python/cpython/blob/v3.14.7/Python/initconfig.c#L2830-L2832) set `site_import=0` for `-S`; [`Python/pylifecycle.c`, lines1221–1226](https://github.com/python/cpython/blob/v3.14.7/Python/pylifecycle.c#L1221-L1226) only performs normal site initialization when that field is true. Thus ordinary site/user-site initialization is not an explanation supported by this command line. These switches are not a sandbox and do not disable the ability of explicitly executed Python code or native DLLs to create processes.

The fixed child imports `gc`, `hashlib`, `json`, `pathlib`, `sys`, `time`, and locally `os` for `fsync`. Its actual work consists of file I/O, SHA256, JSON encoding, bounded sleeps, bytearray allocations and collection. There is no child-source use of subprocess, multiprocessing, spawn, shell execution, console allocation or native FFI. The local `hashlib.py` selects `_hashlib` or builtin hash constructors; `_hashlib.pyd` directly imports `libcrypto-3.dll` and the Python/CRT runtime, without a direct process-creation or console-allocation import. Local source checks of the named JSON/pathlib/glob helper files found no process-launch call. This is deliberately narrower than claiming that every transitive standard-library or native implementation has been verified.

The core DLL does import `CreateProcessW`, `_wspawnv`, `_wspawnve` and `_wsystem`. Their presence is expected in a runtime exposing process APIs. The matching source includes explicit [`os.system`, lines5689–5703](https://github.com/python/cpython/blob/v3.14.7/Modules/posixmodule.c#L5689-L5703), [`os.spawnv`, lines7277–7301](https://github.com/python/cpython/blob/v3.14.7/Modules/posixmodule.c#L7277-L7301), and [`_winapi.CreateProcess`, lines1304–1326](https://github.com/python/cpython/blob/v3.14.7/Modules/_winapi.c#L1304-L1326) implementations. No call from this fixed child's inspected path to these APIs was found. Import presence cannot be turned into evidence that they ran.

Microsoft documents [`CREATE_NO_WINDOW`](https://learn.microsoft.com/en-us/windows/win32/procthread/process-creation-flags) as running a console application without a console window and without setting its console handle. The documented exceptions are a nonconsole application or combination with `CREATE_NEW_CONSOLE`/`DETACHED_PROCESS`; neither describes the inspected call and PE subsystem. This does not document the complete implementation of Windows host processes. It is not a basis for asserting that the anomalous entry was `conhost.exe`, nor for asserting that no OS-mediated process can exist.

## What the anomaly still needs

The coordinator reports normal-case inner total-process counts0→1→2 and outer counts0→1→4, with zero reported job-limit terminations. This report did not reproduce, repair or reinterpret those observations. No process image/name, creation stack or parent identity for the extra accounting entries has been established here.

Therefore the strict single-worker capability result stays unresolved. A source-supported description is: ordinary CPython entry identified; intentional helper spawn not found on the inspected path; extra job-accounting entries unexplained. A future authorized diagnostic would need independent process-identity/lifetime evidence and a check of the accounting observation itself before attributing the anomaly or revising a resource contract. This task does not authorize such a run.

## Reproduction and scope

`c8_interpreter_pe_readonly_20261111.ps1`, SHA256 `6442D862052438314E2B535CBF6A5195FC161F304FB7507C09BED37E8F76E596`, parses the import and delay-import directories, section map, subsystem, version resources and debug strings from the three named files. Its output is `c8_interpreter_pe_readonly_20261111.json`, SHA256 `F64BD3CF2EF090B42CAA334E2029FDC3F1BE6ED4A920C227AC58D319CFF21219`. It completed using PowerShell/.NET file operations; it did not load the inspected DLLs or call a process-query API.

Upstream source was read through the web tool at the explicit `v3.14.7` tag. A shell attempt to cache those source files was blocked by socket permissions and produced no source copies; no escalation was needed because the web source reads succeeded. The upstream links are version references, not newly verified source-to-binary build hashes. No existing fixture, frozen receipt, implementation or package was edited.
