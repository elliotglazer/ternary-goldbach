# Stable local execution after Docker idle shutdown

13 November 2026. Map08, map09 and map10 ended without complete construction receipts while the proof runner was invoked directly inside the docker-desktop Linux distribution. No surviving proof process was found. Map08 and map10 have empty time receipts; map09 stopped before a complete dependency manifest.

The Docker backend log records idle-mode activation and engine shutdown at 10:00:07 UTC, termination of the main distribution at 10:00:08, and a stopped VM at 10:00:09. This matches map08's interruption during setup. Docker's next ordinary container request restarted its engine at 10:04:31, reaching the running state at 10:04:38. Direct distribution processes did not keep the managed engine active. The exact interruption point of map09 and map10 is not independently attributed to an individual backend action.

The next runs execute the actual proof workload inside an existing local container image. No Docker setting, kernel, installed HOL dependency or image is modified. The image is pinned to `sha256:b1934ee5f1c509618f2508e6eb47ee0d3520686341fec936f3b79331f9315667`, the already installed rhysd/actionlint 1.7.12 image, with its entrypoint replaced by `/bin/sh`. A preliminary check confirmed the expected musl loader and time utility exist. The HOL executable, theory dependencies and sysroot still come from the pinned local workspace.

The first container attempt, map11, exited with a complete failure receipt: the image's default `guest` user could not update an existing `.hol/make-deps` file. No mathematical check was reached. The successor explicitly runs as container UID/GID 0, matching the existing build artifacts. It retains no Linux capabilities and has no network. The workspace is mounted read-only except for the selected experiment directory; the container root is read-only with a bounded temporary directory.

`run_local_container.ps1` records the complete argument array, exact image identity, start time, terminal exit code and outer elapsed time under a fresh label. It limits the container to one CPU, four GiB of memory without additional swap, and 64 processes. The existing experiment script still imposes its phase deadlines and source/dependency checks. Completed containers are removed; workspace receipts remain.

Container scheduling and environment differ from earlier direct-distribution runs. These construction runs are not campaign throughput measurements, and their timings cannot supply a speedup factor against earlier measurements without a matched comparison.
