#!/bin/sh
set -eu
cd "$(dirname "$0")"
exec python3 isolated_dependencies.py preflight "$@"
