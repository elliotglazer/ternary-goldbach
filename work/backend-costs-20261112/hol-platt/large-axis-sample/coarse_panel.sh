#!/bin/sh
# Give large shapes separate HOL heaps. Each child isolates its own bind mounts.
set -eu
cd "$(dirname "$0")"
prefix=$1
case "$prefix" in *[!a-zA-Z0-9_]*|'') exit 2;; esac
for group in small medium long; do
  case "$group" in small) count=23;; medium|long) count=12;; esac
  test "$(wc -l < "p24_$group.txt")" -eq "$count"
  unshare -m sh ./run.sh "${prefix}_$group" "p24_$group" 1 "$count"
done
test "$(wc -l < p24_tail.txt)" -eq 8
for index in 1 2 3 4 5 6 7 8; do
  unshare -m sh ./run.sh "${prefix}_tail_$index" p24_tail "$index" "$index"
done
