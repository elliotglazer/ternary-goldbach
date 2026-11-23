"""Isolate the specified kernel output channel; leave prover assembly unchanged."""
from pathlib import Path
import hashlib
import json
import subprocess
import time

home = Path(__file__).resolve().parent
base = json.loads((home / 'build_timed.json').read_text())
command = base['command'].copy()
source = next(Path(x) for x in command if x.endswith('basis_ffi_timed.c'))
text = source.read_text()
old = '''void ffikernel_ffi (unsigned char *c, long clen, unsigned char *a, long alen) {
    for (long i = 0; i < clen; i++) {
        putc(c[i], stdout);
    }
}'''
new = '''void ffikernel_ffi (unsigned char *c, long clen, unsigned char *a, long alen) {
    static FILE *kernel_output = NULL;
    if (kernel_output == NULL) {
        const char *path = getenv("CANDLE_KERNEL_OUTPUT");
        if (path == NULL || (kernel_output = fopen(path, "wb")) == NULL) {
            fprintf(stderr, "Cannot open dedicated kernel output.\\n");
            exit(10);
        }
    }
    if (clen < 0 || fwrite(c, 1, (size_t)clen, kernel_output) != (size_t)clen
                 || fflush(kernel_output) != 0) {
        fprintf(stderr, "Incomplete kernel output.\\n");
        exit(11);
    }
}'''
assert text.count(old) == 1
target = source.with_name('basis_ffi_export.c')
target.write_text(text.replace(old, new))
command[command.index(str(source))] = str(target)
command[-1] = str(source.parent / 'cake-export')
start = time.perf_counter()
process = subprocess.run(command, capture_output=True, text=True)
(home / 'build_export.log').write_text(process.stdout + process.stderr)
record = dict(command=command, exit_code=process.returncode,
              wall_seconds=time.perf_counter() - start,
              change='Kernel FFI bytes are written to a separate file; timestamp instrumentation retained; prover assembly unchanged')
if process.returncode == 0:
    with Path(command[-1]).open('rb') as stream:
        record['binary_sha256'] = hashlib.file_digest(stream, 'sha256').hexdigest()
(home / 'build_export.json').write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps(record))
process.check_returncode()
