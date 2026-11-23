"""Use the workspace Bash for build-system test launchers."""
from pathlib import Path
import hashlib
import json

home = Path(__file__).resolve().parent
commit = json.loads((home / 'source.json').read_text())['commit']
source = home / f'HOL-{commit}'
records = []
for path in (source / 'tools/Holmake/tests').rglob('*.sh'):
    old = path.read_bytes()
    if old.startswith(b'#!/bin/bash\n'):
        new = old.replace(b'#!/bin/bash\n', b'#!/usr/bin/env bash\n', 1)
        path.write_bytes(new)
        records.append({'path': str(path.relative_to(source)),
                        'old_sha256': hashlib.sha256(old).hexdigest(),
                        'new_sha256': hashlib.sha256(new).hexdigest()})
(home / 'shell_patches.json').write_text(json.dumps(records, indent=2) + '\n')
print(f'Adjusted {len(records)} test launcher shebangs; test bodies unchanged.')
