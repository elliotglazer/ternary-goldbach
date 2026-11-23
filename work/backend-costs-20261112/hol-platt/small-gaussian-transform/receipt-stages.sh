#!/bin/sh
set -eu
cd "$(dirname "$0")"
unshare -m sh ./run.sh direct01 direct
unshare -m sh ./run.sh read01 readback
unshare -m sh ./run.sh consume01 consume
unshare -m sh ./run.sh matched02 matched
