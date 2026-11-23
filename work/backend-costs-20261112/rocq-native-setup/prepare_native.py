"""Use Dune's completed local install tree without copying it elsewhere."""
from pathlib import Path
import hashlib
import json

home = Path(__file__).resolve().parent
linux = '/mnt/host/c/' + home.as_posix()[3:]
native = linux + '/coq-9.0.0/_build/install/default'
text = (home / 'run.sh').read_text()
assert text.endswith('exec "$@"\n')
text = text.removesuffix('exec "$@"\n') + (
    f'export PATH="{native}/bin:$PATH"\n'
    f'export OCAMLPATH="{native}/lib:$OCAMLPATH"\n'
    f'export ROCQLIB="{linux}/sysroot/usr/lib/ocaml/coq"\n'
    f'export ROCQRUNTIMELIB="{native}/lib/rocq-runtime"\n'
    'exec "$@"\n')
(home / 'run-native.sh').write_text(text, newline='\n')
paths = [home / 'run-native.sh', home / 'coq-9.0.0/_build/default/config/coq_config.ml',
         home / 'coq-9.0.0/_build/default/topbin/rocqworker.exe']
manifest = {str(p.relative_to(home)): {'bytes': p.stat().st_size,
    'sha256': hashlib.sha256(p.read_bytes()).hexdigest()} for p in paths}
(home / 'native_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print('Prepared native runtime with the packaged 9.0.0 logical libraries.')
