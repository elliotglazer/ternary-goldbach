"""Cross-link the pinned upstream Candle compiler with the existing musl sysroot."""
from pathlib import Path
import shutil,subprocess,json,time,hashlib
H=Path(__file__).resolve().parent
repo=H/'candle-6a9acd58867610c78fee0f3dd9ed4c4c14087b18'
build=repo/'candle/build';build.mkdir(exist_ok=True)
for p in (H/'compiler/cake-x64-64').iterdir():
    if p.is_file():shutil.copyfile(p,build/p.name)
p=build/'cake.S';s=p.read_text()
assert '#define DATA_BUFFER_SIZE    65536' in s
assert '#define CODE_BUFFER_SIZE  5242880' in s
s=s.replace('#define DATA_BUFFER_SIZE    65536','#define DATA_BUFFER_SIZE  655360000')
s=s.replace('#define CODE_BUFFER_SIZE  5242880','#define CODE_BUFFER_SIZE  524288000')
p.write_text(s)
p=build/'basis_ffi.c';s=p.read_text()
old='  assert(0 <= alen);\n  assert(0 <= clen);'
patch=(repo/'candle/basis_ffi.c.patch').read_text()
new='\n'.join(line[1:] for line in patch.splitlines() if line.startswith('+') and not line.startswith('+++'))
assert s.count(old)==1
s=s.replace(old,new).replace('#include <unistd.h>','#include <unistd.h>\n#include <sys/wait.h>')
p.write_text(s)
with (build/'candle_boot.ml').open('a') as f:f.write((repo/'candle/chdir_to_root.ml').read_text())
clang=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/clang.exe')
sysroot=H.parents[1]/'formal-goldbach-bench/mm0/sysroot'
cmd=[str(clang),'--target=x86_64-linux-musl','-O2','-DEVAL','-static','-nostdlib','-nostdinc',
     '-isystem',str(sysroot/'usr/include'),'-isystem',str(clang.parent.parent/'include/clang'),'-fuse-ld=lld',
     str(sysroot/'usr/lib/crt1.o'),str(sysroot/'usr/lib/crti.o'),str(build/'cake.S'),str(build/'basis_ffi.c'),
     str(sysroot/'usr/lib/libc.a'),str(sysroot/'usr/lib/crtn.o'),'-o',str(build/'cake')]
start=time.perf_counter()
p=subprocess.run(cmd,capture_output=True,text=True)
(H/'build.log').write_text(p.stdout+p.stderr)
record=dict(command=cmd,exit_code=p.returncode,wall_seconds=time.perf_counter()-start)
if not p.returncode:record['binary_sha256']=hashlib.sha256((build/'cake').read_bytes()).hexdigest()
(H/'build.json').write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record));print(p.stderr[-4000:]);p.check_returncode()
