# certificate — 2026-11-20

## 16:55:34 UTC · Final

Generated and replayed a certificate covering the last 1,024 even numbers through \(10^{16}\). It uses 19 prime anchors, 395 source primes and 484 recursive Lucas certificates. The native verifier checked every pair and rejected three corrupted inputs. The generated Lean module still needs kernel compilation. [Pilot report](../../../work/grh-goldbach-20261120/team/certificate/README.md)

## 17:04:39 UTC · Final

Lean verified binary Goldbach for the final 1,024 even numbers through \(10^{16}\). The theorem uses exactly `propext`, `Classical.choice`, and `Quot.sound`. Compilation and axiom inspection took 33.25 CPU seconds and 96.94 wall seconds. [Kernel output](../../../work/grh-goldbach-20261120/team/certificate/checks/endpoint02/lean.log) · [Build receipt](../../../work/grh-goldbach-20261120/team/certificate/checks/endpoint02/receipt.json)

## 18:16:13 UTC · Final

Lean verified all **16,384 even numbers ending at \(4\times10^{15}\)** as sums of two primes. The theorem uses exactly `propext`, `Classical.choice` and `Quot.sound`. The build and audit consumed 227.81 CPU seconds, including a separate measurement of the cost to import the shared prime table. [Results and measurements](../../../work/grh-goldbach-20261120/team/aws-pilot/WIDE_RESULTS.md)

The portable Linux package also contains **524,288 targets** split into two production-width shards. WSL regenerated their inputs byte-for-byte. Kernel replay of those wider shards, and the cost of certifying primes near the upper end of the production source table, remain open. A separate Lean test reduced one prime-table checkpoint from 1.20 MB to 96.7 KB. [Linux pilot package](../../../work/grh-goldbach-20261120/team/aws-pilot/wide/goldbach-4e15-wide-linux.tar.gz)

## 18:28:38 UTC · Final

[Download the CloudShell pilot](</work/grh-goldbach-20261120/team/aws-pilot/goldbach-cloudshell.zip>). No AWS resources were launched. The estimated six-hour cost is **$5.02** before tax and small S3 charges.

1. In **us-east-1**, open CloudShell and upload the ZIP through **Actions → Upload file**.
2. Run the read-only preflight: `unzip -q goldbach-cloudshell.zip && cd goldbach-cloudshell && python3 pilot.py check`
3. To start the paid run, enter `python3 pilot.py run`. This launches one on-demand `c7a.4xlarge`, collects the receipt and cleans up. After a disconnect, return to the same directory and run that command again.

The larger test covers **524,288 consecutive even integers ending at \(4\times10^{15}\)**. It measures the existing serial checker on a 16-vCPU machine. The receipt includes the exact theorem, its axioms, per-module CPU time, peak memory and artifact sizes.
