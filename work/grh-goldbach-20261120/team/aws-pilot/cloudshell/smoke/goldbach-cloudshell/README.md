# One-worker Goldbach pilot

In the **us-east-1** AWS console open CloudShell, choose **Actions → Upload file**, and upload `goldbach-cloudshell.zip`. Run the read-only preflight first.

```bash
unzip -q goldbach-cloudshell.zip && cd goldbach-cloudshell && python3 pilot.py check
```

The next command launches one on-demand worker, collects its last receipt and cleans up the pilot's resources. Keep CloudShell open if convenient. After a disconnect, return to the same region and directory and run the same command again. It uses the saved stack ID. Keep the single extracted directory until cleanup finishes.

```bash
python3 pilot.py run
```

Download `goldbach-cloudshell/pilot-receipt.json` via CloudShell **Actions → Download file**. A successful report contains both exact endpoint statements and their axiom lists, the toolchain version, per-module CPU, wall time, RSS, artifact sizes and hashes. The latest progress or final failure receipt survives a failed proof. The local JSON remains after cleanup. AWS retains only CloudFormation's deleted-stack metadata for its normal retention period, which may include already-expired object-specific transfer URLs.

The larger test checks 524,288 consecutive even integers ending at 4 × 10¹⁵. The smaller overlapping control checks the last 16,384. This measures the existing serial checker and dependency cache bootstrap on one 16-vCPU, 32-GiB c7a.4xlarge. The two workloads share targets. Add neither interval lengths nor idle worker vCPUs to the useful proof throughput. Proof objects stay on the encrypted temporary disk; the downloadable receipt contains their sizes and hashes.

## Cost and lifetime

At $0.82112 per worker-hour, six hours of compute cost $4.93. A 96-GiB gp3 root at $0.08/GiB-month for six hours adds about $0.064, and one public IPv4 address adds $0.03. Together this is $5.02 before tax and small S3 charges. The worker downloads dependencies over the public internet and sends at most one 1-MiB progress receipt every three minutes. The bucket uses a three-day expiration rule. AWS rounds expiration to UTC midnight and processes it asynchronously. The price is an estimate. The preflight uses the AWS Price List API and stops if the compute quote exceeds $1/hour. Credits and other account workloads affect the bill separately. [AWS Price List API](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/using-price-list-query-api.html) · [EBS](https://aws.amazon.com/ebs/pricing/) · [Public IPv4](https://aws.amazon.com/vpc/pricing/)

One EC2 Fleet requests exactly one on-demand instance. AWS terminates it upon expiry independently of CloudShell. The deadline is at most six hours after preflight and at least ten minutes before the current signing session expires. A guest timer backs this up; successful or failed jobs request early termination. An elevated quota does not change the one-worker limit. AWS service or termination failures can delay cleanup. [EC2 Fleet expiration](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateFleet.html)

## Permissions and recovery

The launcher checks for an existing default VPC and public subnet, Canonical Ubuntu 24.04 x86-64, the existing EC2 Fleet service-linked role, 16 unused Standard On-Demand vCPUs and at least 30 minutes of verifiable signing-session lifetime. This account must be allowed to describe these resources and prices, create and remove one CloudFormation stack, security group, launch template, fleet and instance, and manage one private S3 bucket. Use the permissions already granted to your CloudShell identity. Missing or restricted prerequisites appear as errors. The launcher creates no IAM role, SSH key, instance profile, NAT gateway or access key. A small default VPC has no additional NAT or endpoint charges for this route. [Fleet role](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-prerequisites.html)

The package stays private. The worker can download one S3 object and upload two named receipts through short-lived signed requests. The signed forms are temporary bearer credentials embedded in EC2 user data inside the private launch template. Do not share the template, user data or signed forms while active. Receipts exclude them. AWS credentials are neither requested from the user nor transmitted to the worker. [AWS presigned requests](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-presigned-url.html)

For a quick status check run `python3 pilot.py status`. To cancel an active job and remove this run's resources, run `python3 pilot.py cleanup`. Cleanup checks the run's account and ownership tag, saves any available receipt, removes the stack and S3 objects, and checks that its EBS disk and worker are gone. The same cleanup command can be retried after a disconnect or partial failure. Once the S3 objects expire, an uncollected receipt is lost. The launch is optional. The ZIP and offline tests can be examined without AWS credentials.
