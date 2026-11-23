from pathlib import Path
import hashlib
import json

home = Path(__file__).resolve().parent
linux = '/mnt/host/c/' + home.as_posix()[3:]
commit = json.loads((home / 'source.json').read_text())['commit']
source = home / f'HOL-{commit}'
bindir = home / 'bin'
bindir.mkdir(exist_ok=True)
runtime = linux + '/sysroot'
for name, actual in [('gcc', 'gcc'), ('g++', 'g++'), ('c++', 'g++')]:
    (bindir / name).write_text(
        f'#!/bin/sh\nexec "{runtime}/usr/bin/{actual}" '
        f'--sysroot="{runtime}" "$@"\n', newline='\n')
(bindir / 'poly').write_text(
    f'#!/bin/sh\nexec "{runtime}/usr/bin/poly" "$@"\n', newline='\n')
original = (home / 'sysroot/usr/bin/polyc').read_text()
assert original.count('prefix="/usr"') == 1
(bindir / 'polyc').write_text(
    original.replace('prefix="/usr"', f'prefix="{runtime}/usr"'), newline='\n')
(home / 'run.sh').write_text(
    '#!/bin/sh\n' + f'export PATH="{linux}/bin:{runtime}/usr/bin:{runtime}/bin:$PATH"\n' +
    f'export LD_LIBRARY_PATH="{runtime}/usr/lib:{runtime}/lib"\n' +
    'export HOL_NOCONFIG=1\nexec "$@"\n', newline='\n')
(source / 'tools-poly/poly-includes.ML').write_text(
    f'val poly = "{linux}/bin/poly";\n' +
    f'val polymllibdir = "{runtime}/usr/lib";\n' +
    'val MLTON = NONE;\nval DOT_PATH = NONE;\n', newline='\n')
files = list(bindir.iterdir()) + [home / 'run.sh',
    source / 'tools-poly/poly-includes.ML', home / 'sysroot/usr/bin/poly',
    home / 'sysroot/lib/apk/db/installed']
record = {str(p.relative_to(home)): {'bytes': p.stat().st_size,
    'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in files}
(home / 'setup_manifest.json').write_text(json.dumps(record, indent=2) + '\n')
print('Prepared workspace-only runtime wrappers and HOL4 configuration.')
