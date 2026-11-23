#!/bin/sh
set -eu
here=$(cd "$(dirname "$0")" && pwd)
prefix=$1
case "$prefix" in *[!A-Za-z0-9_]*|'') exit 2;; esac
for group in small medium long tail; do
  unshare -m sh "$here/run.sh" "${prefix}_${group}" "$group" 1 1000
done
