#!/bin/sh
set -eu
out=$(cd "$(dirname "$0")" && pwd)
export PATH=/verification/lean-4.33.1-linux/bin:/usr/bin:/bin
exporter=/tmp/goldbach-lean4export-15f6055e/.lake/build/bin/lean4export
dir=$(mktemp -d /tmp/goldbach-export-controls.XXXXXXXX)
cd "$dir"
export LEAN_PATH="$dir"
cat > Provider.lean <<'LEAN'
namespace GoldbachLinkControl
theorem given : 3 + 3 = 6 := rfl
theorem unrelated : True := True.intro
end GoldbachLinkControl
LEAN
cat > Consumer.lean <<'LEAN'
namespace GoldbachLinkControl
theorem use (h : 3 + 3 = 6) : Nat.succ (3 + 3) = Nat.succ 6 := congrArg Nat.succ h
end GoldbachLinkControl
LEAN
lean -o Provider.olean Provider.lean
lean -o Consumer.olean Consumer.lean
"$exporter" Provider -- GoldbachLinkControl.given GoldbachLinkControl.unrelated > "$out/control-provider.ndjson"
"$exporter" Consumer -- GoldbachLinkControl.use > "$out/control-consumer.ndjson"
wc -c "$out"/control-*.ndjson
