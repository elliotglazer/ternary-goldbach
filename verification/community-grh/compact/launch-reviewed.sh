#!/usr/bin/env bash
set -euo pipefail

base=https://raw.githubusercontent.com/elliotglazer/ternary-goldbach/2ff9b487467ea864461bf9485c25a1549d96eb86/verification/community-grh/compact
commit=e0722a0e5d3ebac13fba180599f4dd4551e98921
tree=64fdf655501018bce8a241aa653a385d217017ee
mkdir -p "$HOME/tg-community-run"
run_dir=$(mktemp -d "$HOME/tg-community-run/compact-e0722a0e.XXXXXX")
cd "$run_dir"
curl -fsSL "$base/compact-joint-435.tar.gz" -o compact-joint-435.tar.gz
printf '%s  %s\n' '0a3e20cf47eebb1c9b66ee0e96fac468e26795235be6d2b0b0a674e94c026e8f' compact-joint-435.tar.gz | sha256sum -c -
tar -xzf compact-joint-435.tar.gz
sha256sum -c SHA256SUMS
curl -fsSL "$base/compact_collect.py" -o compact_collect.py
python3 compact_joint_stack.py --commit "$commit" --tree "$tree" --profile palomar-32x64
printf 'To retrieve the receipt when the worker stops, run\n  cd %q && python3 compact_collect.py --commit %s --tree %s\n' "$run_dir" "$commit" "$tree"
