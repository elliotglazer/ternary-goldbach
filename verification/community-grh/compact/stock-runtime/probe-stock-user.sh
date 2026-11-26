#!/usr/bin/env bash
# Called as the unprivileged grhreplay user using stock-user-session.sh.
set -euo pipefail
[[ $(id -u) -ne 0 && $# == 2 ]] || { echo 'Usage as grhreplay: probe-stock-user.sh POLICY_DIR WORK_DIR' >&2; exit 2; }
policy=$(realpath -e -- "$1"); work=$(realpath -e -- "$2")
[[ -d $work && -w $work ]]
[[ $(git -C "$policy" rev-parse HEAD) == 14aa8d6b3c2f14a8540605e37144560b9a00e7e7 ]]
[[ -z $(git -C "$policy" status --porcelain --untracked-files=normal) ]]
readonly prefix=/opt/palomar-verifier-14aa8d6b
"$prefix/bwrap-bin/bwrap" --unshare-user --ro-bind / / -- /usr/bin/true
"$prefix/venv/bin/python" -I - "$policy" "$work" <<'PY'
import json, os, pathlib, sys, yaml
assert sys.version_info[:3] == (3, 11, 10) and yaml.__version__ == "6.0.3"
sys.dont_write_bytecode = True
sys.path.insert(0, sys.argv[1])
from scripts.verify_submission import supervisor_bootstrap
command = supervisor_bootstrap(pathlib.Path(sys.argv[2]))
assert "--user" in command and "--property=Delegate=yes" in command
print(json.dumps({"uid": os.getuid(), "bootstrap": command, "placement_checked": True}))
PY
