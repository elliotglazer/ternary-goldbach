#!/bin/sh
set -eu
here=$(cd "$(dirname "$0")" && pwd)
for part in 7 8 1 2 3 4 5 6; do
  unshare -m sh "$here/run.sh" "a03_tail_$part" tail "$part" "$part"
done
