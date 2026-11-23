"""Prepare a relocated Alpine Rocq installation and exact matching fixtures."""
from pathlib import Path
import hashlib
import json
import shutil

home = Path(__file__).resolve().parent
linux = '/mnt/host/c/' + home.as_posix()[3:]
runtime = linux + '/sysroot'
ocaml = runtime + '/usr/lib/ocaml'
bindir = home / 'bin'
bindir.mkdir(exist_ok=True)
# Native compilation invokes a C compiler through OCaml. Use the already
# configured workspace compiler, including its libc development headers.
hol = linux.rsplit('/', 1)[0] + '/hol4-setup'
for name in ['gcc', 'cc']:
    (bindir / name).write_text(
        f'#!/bin/sh\nexec "{hol}/bin/gcc" "$@"\n', newline='\n')
(bindir / 'bash').write_text(
    '#!/bin/sh\n' +
    f'export LD_LIBRARY_PATH="{hol}/sysroot/usr/lib:{hol}/sysroot/lib:$LD_LIBRARY_PATH"\n' +
    f'exec "{hol}/sysroot/bin/bash" "$@"\n', newline='\n')
conf = (home / 'sysroot/etc/findlib.conf').read_text()
(home / 'ld.conf').write_text(
    (home / 'sysroot/usr/lib/ocaml/ld.conf').read_text().replace(
        '/usr/lib/ocaml', ocaml), newline='\n')
(home / 'findlib.conf').write_text(
    conf.replace('/usr/lib/ocaml', ocaml) +
    f'\nstdlib="{ocaml}"\nldconf="{linux}/ld.conf"\n', newline='\n')
(home / 'run.sh').write_text(
    '#!/bin/sh\n'
    f'export PATH="{linux}/bin:{runtime}/usr/bin:{runtime}/bin:$PATH"\n'
    f'export LD_LIBRARY_PATH="{runtime}/usr/lib:{runtime}/lib"\n'
    f'export OCAMLLIB="{ocaml}"\n'
    f'export OCAMLPATH="{ocaml}"\n'
    f'export OCAMLFIND_CONF="{linux}/findlib.conf"\n'
    f'export CAML_LD_LIBRARY_PATH="{ocaml}/stublibs"\n'
    f'export CPATH="{runtime}/usr/include"\n'
    f'export LIBRARY_PATH="{runtime}/usr/lib"\n'
    'exec "$@"\n', newline='\n')
sources = ['StageCheck.v', 'Controls.v']
for case in ['P100N64', 'P343N64', 'P415N64', 'P343N256']:
    sources += [variant + case + '.v' for variant in ['Data', 'Vm', 'Native']]
for name in sources:
    shutil.copyfile(home.parent / name, home / name)
(home / 'NativeControls.v').write_text(
    (home / 'Controls.v').read_text().replace('vm_compute', 'native_compute'))
paths = list(bindir.iterdir()) + [home / 'run.sh', home / 'findlib.conf', home / 'ld.conf',
    home / 'sysroot/lib/apk/db/installed'] + [home / n for n in sources]
manifest = {str(p.relative_to(home)): {'bytes': p.stat().st_size,
    'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths}
(home / 'setup_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print('Prepared relocated runtime and copied exact Rocq fixtures.')
