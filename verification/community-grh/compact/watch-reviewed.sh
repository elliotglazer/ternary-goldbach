#!/usr/bin/env bash
# Watch an existing compact replay until its receipt arrives.
set -euo pipefail
if [[ $# -ne 1 || ! $1 =~ ^[0-9a-f]{32}$ ]]; then
  echo 'Usage: bash watch-reviewed.sh ATTEMPT_ID' >&2
  exit 2
fi
attempt=$1
commit=e0722a0e5d3ebac13fba180599f4dd4551e98921
tree=64fdf655501018bce8a241aa653a385d217017ee
base=https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/d6b95b6093fc6aa065ffdc7d41135ff7febfa244/verification/community-grh/compact
mkdir -p "$HOME/tg-community-run"
work=$(mktemp -d "$HOME/tg-community-run/watch.XXXXXX")
cd "$work"
for f in compact_watch.py compact_collect.py; do
  curl -fsSL "$base/$f" -o "$f"
done
instance=$(aws --region us-east-1 --no-cli-pager cloudformation describe-stack-resource --stack-name tg-grh-source-replay --logical-resource-id Host --query StackResourceDetail.PhysicalResourceId --output text)
python3 compact_watch.py --instance "$instance" --attempt "$attempt" --commit "$commit" --tree "$tree" --watch
