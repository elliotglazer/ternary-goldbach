# Direct base interpreter revision

The original `worker.py`, `run_screen.py` and `README.md` remain unchanged. Do not run that initial pair. Its proposed post-launch assignment did not rule out Windows virtual-environment redirection creating the actual interpreter before assignment. This was a source-review finding, not an observed numerical run or containment failure.

The replacement pair is `worker_v2.py` and `run_screen_v2.py`. Source preparation only; neither has been executed, imported or syntax-tested by the author.

The inspected `interval-env/pyvenv.cfg` names the base executable `C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe` and version 3.14.7. This is also the direct executable used by the existing pinned campaign supervisor. The replacement runner launches that exact executable with `-I -S -u`, checks its SHA256 and `python314.dll`, and never launches `interval-env/Scripts/python.exe` as the worker. The direct base interpreter executes standard-library startup and waits for a PID-bound GO line. After assignment and `IsProcessInJob`, the runner sends the original process PID. The worker checks this against `os.getpid()` and checks its executable, Python version, 64-bit ABI, cache tag and isolation flags.

Only after that handshake does the worker add the exact existing interval environment `Lib/site-packages` path to `sys.path`. It uses direct insertion, not `site.addsitedir`, so no `.pth` files or site hooks are processed. It checks the package-entry and three numerical-extension pins before importing FLINT, then verifies their loaded paths. The package's own DLL-directory setup remains active during its import. These selected hashes are not a claimed complete DLL trust closure. No package is installed or rebuilt.

The numerical plan and all eight tests are unchanged. The same job limits and output bounds apply. The parent records and checks that the first event's PID is the original assigned worker, in addition to the job's total-process check. A launch or package-path incompatibility is a stopped attempt, never a fallback to the virtual-environment redirector.

After review, the coordinator may use the direct base executable for the parent as well:

```powershell
& 'C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe' -I -S 'work/backend-costs-20261112/hol-platt/native-sign-screen/run_screen_v2.py' --run --label screen01
```

This command has not been run by the author. The initial sources have hashes `D2B3FF44B42DA82D4AE456344D0B2C4EED8DFB74484AC316AC6F4A1BFE2E8094` and `F82F19162C29C53F8434D800C87BF101715A6F57D78F3E1A8C55E8A42DD5E850`. The inspected virtual-environment configuration has SHA256 `20FB52AF58C4A971E746C1A50ABEF246405C68A7E5CEFDE7EB26DAEDFB79E2DF`. Executable and runtime pins are literal in the replacement runner.
