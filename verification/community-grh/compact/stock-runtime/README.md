# Stock Palomar tools for the existing AWS verifier host

The three scripts prepare and probe Ubuntu 24.04 amd64 for [Palomar verifier 14aa8d6b](https://github.com/PalomarRegistry/PalomarSubmission/tree/14aa8d6b3c2f14a8540605e37144560b9a00e7e7). Run them from a root-owned directory after matching their SHA-256 values to the review receipt. The proof itself runs as `grhreplay`.

```bash
sudo bash "$trusted_scripts/bootstrap-stock-tools.sh"
sudo bash "$trusted_scripts/stock-user-session.sh" \
  /bin/bash "$trusted_scripts/probe-stock-user.sh" "$policy_checkout" "$fresh_work"
```

The setup uses the official Python 3.11.10 binary in its version-specific tool-cache prefix and a root-owned virtual environment for the verifier’s hash-locked PyYAML. It builds bubblewrap 0.12.0 under `/opt/palomar-verifier-14aa8d6b/bwrap-bin` using Palomar’s original installer. The Ubuntu build prerequisites are unpacked under the same prefix. On hosts with AppArmor user namespace restrictions, the official installer loads a profile attached only to this versioned bubblewrap binary. Setup stops if the existing profile file differs or a previously loaded profile has no matching file. [Official installation script](https://github.com/PalomarRegistry/PalomarSubmission/blob/14aa8d6b3c2f14a8540605e37144560b9a00e7e7/scripts/install_bwrap.sh)

The session helper creates a dedicated transient service that runs as `grhreplay` and requires that UID’s systemd user manager while the command runs. It passes the correct runtime directory and session bus to the verifier. The probe must report `placement_checked: true` from the genuine `supervisor_bootstrap` implementation on EC2. A Python version line or a live D-Bus socket alone is insufficient.

For a timed cold reproduction, record the real epoch before bootstrap, run fresh source intake with the pinned Ruby/Bundler/Licensee toolchain, and keep its official work directory and report together. Protected execution also needs Elan 4.2.3 and the submitted Lean 4.35.0 installed for the dedicated user per the stock workflow. To forward the unchanged job clock through the transient service, invoke the reviewed wrapper as follows. Set `prepared_sha` from the fresh host’s own intake receipt, which includes a timestamp.

```bash
sudo bash "$trusted_scripts/stock-user-session.sh" \
  /usr/bin/env "PALOMAR_JOB_STARTED_AT=$job_started_at" \
  /opt/palomar-verifier-14aa8d6b/venv/bin/python "$trusted_scripts/run_stock_palomar.py" execute \
  --verifier "$policy_checkout" --work-dir "$fresh_work" \
  --prepared-report "$prepared_report" --report-sha256 "$prepared_sha" \
  --bwrap /opt/palomar-verifier-14aa8d6b/bwrap-bin/bwrap \
  --output "$fresh_output"
```

The default wrapper leaves the published 19,800-second budget intact. The official final fields are `pass` and `complete`. Local testing covered a fresh installation, repeat setup, an unprivileged bubblewrap run, package hashes, and offline parsing of the precise scoped AppArmor and service syntax. The local WSL kernel uses a different PID 1 and AppArmor configuration, so it cannot certify the EC2 kernel profile load or the actual systemd delegation. The EC2 probe is the cutover check. [Stock verification workflow](https://github.com/PalomarRegistry/PalomarSubmission/blob/14aa8d6b3c2f14a8540605e37144560b9a00e7e7/.github/workflows/submission.yml)
