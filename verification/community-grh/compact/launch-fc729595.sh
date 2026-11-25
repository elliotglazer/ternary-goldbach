#!/usr/bin/env bash
set -euo pipefail

base=https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/691233c084e8943354d9b7b3ebeff66b397587eb/verification/community-grh/compact
commit=fc729595d20448d3689f706378879a30a323a762
tree=6601d6cb30d3841b5da240713778a8781a9aec04
mkdir -p "$HOME/tg-community-run"
run_dir=$(mktemp -d "$HOME/tg-community-run/compact-fc729595.XXXXXX")
cd "$run_dir"
curl -fsSL "$base/compact-joint-435.tar.gz" -o compact-joint-435.tar.gz
printf '%s  %s\n' '89dc03c83d90775464e060d4224d4cbf7aadd2a8ec8c08c39cd615fce006efee' compact-joint-435.tar.gz | sha256sum -c -
tar -xzf compact-joint-435.tar.gz
sha256sum -c SHA256SUMS
curl -fsSL "$base/compact_collect.py" -o compact_collect.py
python3 compact_joint_stack.py --commit "$commit" --tree "$tree" --profile palomar-32x64
printf 'To retrieve the receipt when the worker stops, run\n  cd %q && python3 compact_collect.py --commit %s --tree %s\n' "$run_dir" "$commit" "$tree"
