#!/usr/bin/env bash
# Launch the reviewed source once per CloudShell workspace, then follow the receipt.
set -euo pipefail

commit=6a37b1dd9ddec522cafebbdb99daa93acde5fc76
tree=d49b7d88ef17668bb6378c16eaf46cc90f9b4c71
runner_rev=7ffe2f67d36f6fcb1d7b306c1e89b8a6a1ccea8f
archive_sha=f8e71a0ecd1d65f6f3299c082de9381a49c317fffb4ed2382e6061b3e01a6461
base=https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/$runner_rev/verification/community-grh/compact

dir="$HOME/tg-community-run/replay-$commit-$runner_rev"
mkdir -p "$dir"
cd "$dir"
umask 077
exec 9>launch.lock
flock -x 9
curl -fsSL "$base/compact-joint-435.tar.gz" -o bundle.download
printf '%s  %s\n' "$archive_sha" bundle.download | sha256sum -c -
tar -xzf bundle.download
sha256sum -c SHA256SUMS
submission_id() {
  awk '$1=="Submitted" && $2=="compact" && $3=="joint" && $4=="verification," && $5=="attempt" && $7=="profile" && $8=="palomar-32x64"{print $6}' launch.log | tail -1
}
attempt=
if [[ -s launch.log ]]; then
  attempt=$(submission_id)
fi
if [[ ! $attempt =~ ^[0-9a-f]{32}$ ]]; then
  python3 compact_joint_stack.py --commit "$commit" --tree "$tree" --profile palomar-32x64 | tee -a launch.log
  attempt=$(submission_id)
fi
if [[ ! $attempt =~ ^[0-9a-f]{32}$ ]]; then
  printf '%s\n' "The launcher did not record a submitted attempt. Its output is in $dir/launch.log." >&2
  exit 1
fi
flock -u 9
instance=$(aws --region us-east-1 --no-cli-pager cloudformation describe-stack-resource --stack-name tg-grh-source-replay --logical-resource-id Host --query StackResourceDetail.PhysicalResourceId --output text)
printf 'Following attempt %s. Its receipts will be saved in %s.\n' "$attempt" "$dir"
python3 compact_watch.py --instance "$instance" --commit "$commit" --tree "$tree" --attempt "$attempt" --watch
