"""Record final benchmark file provenance; no benchmark is run here."""
import hashlib,json,datetime
from pathlib import Path
P=Path(__file__).resolve().parent
names=['bulk_check.c','bulk_check.exe','bulk_scalar.exe','bulk_check.s','bulk_scalar.s',
 'make_bulk_fixtures.py','make_large_fixtures.py','make_wide_fixtures.py',
 'bulk_actual.bin','bulk_actual.json','bulk_large.bin','bulk_large.json','bulk_wide.bin','bulk_wide.json',
 'bulk_wide_native.json','bulk_wide_scalar.json','bulk_large_run_1.json','summary.json','REPORT.md',
 'summarize.py','hash_manifest.py']
files=[]
for name in names:
    p=P/name
    if not p.exists() or not p.stat().st_size:raise RuntimeError('Missing final file: '+name)
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(1<<20),b''):h.update(b)
    files.append(dict(path=name,bytes=p.stat().st_size,sha256=h.hexdigest()))
out=dict(created_utc=datetime.datetime.now(datetime.timezone.utc).isoformat(),
 native_flags='-O3 -march=native',scalar_flags='-O3 -march=x86-64 -fno-vectorize -fno-slp-vectorize',
 compiler='C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/leanc.exe',
 note='Final wide raw files match these ten-strategy binaries. bulk_large_run_1.json predates the final two tiled modes; its original executable was overwritten, so its exact executable hash is unavailable.',
 files=files)
(P/'SHA256_MANIFEST.json').write_text(json.dumps(out,indent=2))
print('Hashed',len(files),'files')
