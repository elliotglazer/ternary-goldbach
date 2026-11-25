# Community GRH source replay for Goldbach

This builds upstream commit `756a70250dcba9162b99d4ea35c186558434c17e` with Lean 4.37.0-rc1. The worker fetches pinned Mathlib objects, compiles the community proof from source, audits the five exports, and invokes Comparator. It stores the source checkout, compiled objects and evidence on the data volume for the subsequent Goldbach replay.

From this directory in AWS CloudShell, `python3 cloudshell.py render --autorun` prints the CloudFormation template without calling AWS. Running `python3 cloudshell.py launch --autorun` creates the stack in us-east-1 and starts the source replay during boot. It requires an internet-routed default VPC, CloudFormation, IAM, SSM, EventBridge Scheduler and 32 Standard On-Demand vCPUs.

The r7i.8xlarge has 32 vCPUs and 256 GiB of RAM. The instance has no inbound security-group rules. It stops after the driver exits, with a second stop scheduled after 12 hours. A 12-hour run costs about $26.30 at the regional list prices checked November 25, 2026, excluding transfer. The encrypted 600 GiB data volume is retained for the Goldbach link and costs about $48 per month until removed. The root volume also incurs storage charges until the stack is removed.

After the stack reaches CREATE_COMPLETE, use `python3 cloudshell.py status`, `python3 cloudshell.py console`, or `python3 cloudshell.py tail`. The driver receipt is `/work/replay/evidence/receipt.json`. Check step exit codes and the final status. Interrupted runs may have partial receipts. The pin, source tree, dependency hashes, object manifest, exports and execution measurements are written by the driver.
