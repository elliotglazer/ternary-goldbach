#!/bin/sh
set -eu
task_base=/mnt/host/c/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112
task_mm0="$task_base/mm0-pa"
export CARGO_HOME="$task_mm0/cargo-home"
export CARGO_TARGET_DIR=/tmp/goldbach-mm0-pa-target
export RUSTC="$task_mm0/rust/bin/rustc"
export CARGO_BUILD_JOBS=4
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_MUSL_LINKER=gcc
cd "$task_mm0/mm0-0d414c0bfdaaeb7fea571895127abc1fa5a3d956/mm0-rs"
"$task_base/hol4-setup/run.sh" "$RUSTC" --version
"$task_base/hol4-setup/run.sh" /usr/bin/time -v -o "$task_mm0/compiler_build.time" \
  timeout 600 "$task_mm0/rust/bin/cargo" build --release --locked --no-default-features \
  > "$task_mm0/compiler_build.log" 2>&1
cp "$CARGO_TARGET_DIR/release/mm0-rs" "$task_mm0/mm0-rs"
"$task_mm0/mm0-rs" --help
