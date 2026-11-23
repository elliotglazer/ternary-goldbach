"""Build original verification logic with capacity changes and CPU timing only."""
from pathlib import Path
import hashlib,json,shutil,subprocess,re
ROOT=Path(__file__).resolve().parent
CLANG=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/clang.exe')
INCLUDE=CLANG.parent.parent/'include/clang'
records=[]
for prof in (False,True):
    dst=ROOT/('profile-src' if prof else 'timed-src');dst.mkdir(exist_ok=True)
    for p in (ROOT/'src').glob('*.c'):shutil.copyfile(p,dst/p.name)
    p=dst/'verifier_types.c';s=p.read_text().replace('#define HEAP_SIZE 65536','#define HEAP_SIZE (1 << 22)').replace('#define STORE_SIZE (1 << 26)','#define STORE_SIZE (1 << 30)');p.write_text(s)
    # Index-free generated MMBs do not support the upstream verbose debugger.
    # Preserve rejection and its code, replace only the failure diagnostic path.
    p=dst/'verifier.c';s=p.read_text()
    s=re.sub(r'void fail\(char\* err, int e\) \{.*?\n\}',lambda _: 'void fail(char* err, int e) {\n  fprintf(stderr, "MM0_REJECT: %s near %.120s\\n", err, cursor);\n  exit(e);\n}',s,count=1,flags=re.S);p.write_text(s)
    p=dst/'main.c';s=p.read_text().replace('// #include <time.h>','#include <time.h>')
    s=s.replace('  init_parser();\n  verify(result, len);','  struct timespec bs, be;\n  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &bs);\n  init_parser();\n  verify(result, len);\n  clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &be);\n  fprintf(stderr, "BENCH_CPU_SECONDS=%.9f\\n", (be.tv_sec-bs.tv_sec)+(be.tv_nsec-bs.tv_nsec)*1e-9);')
    if prof:s=s.replace('  return 0;\n}', '  fprintf(stderr, "BENCH_COUNTS proof=%llu unify=%llu\\n", bench_proof, bench_unify);\n  return 0;\n}')
    p.write_text(s)
    if prof:
        p=dst/'verifier.c';s=p.read_text();s='unsigned long long bench_proof=0, bench_unify=0;\n'+s
        for signature,counter in [('void run_unify(unify_mode mode, u8* cmd, u32 tgt)', 'bench_unify'),('u8* run_proof(proof_mode mode, u8* cmd)','bench_proof')]:
            start=s.index(signature);pos=s.index('while (true) {',start)+len('while (true) {');s=s[:pos]+'\n    ++'+counter+';'+s[pos:]
        p.write_text(s)
    out=ROOT/('mm0-profile' if prof else 'mm0-timed')
    args=[str(CLANG),'--target=x86_64-linux-musl','-O3','-static','-nostdlib','-nostdinc','-isystem',str(ROOT/'sysroot/usr/include'),'-isystem',str(INCLUDE),'-fuse-ld=lld',str(ROOT/'sysroot/usr/lib/crt1.o'),str(ROOT/'sysroot/usr/lib/crti.o'),str(dst/'main.c'),str(ROOT/'sysroot/usr/lib/libc.a'),str(ROOT/'sysroot/usr/lib/crtn.o'),'-o',str(out)]
    subprocess.run(args,check=True)
    records.append(dict(command=args,binary=str(out),sha256=hashlib.sha256(out.read_bytes()).hexdigest(),profile=prof))
args=[str(CLANG),'--target=x86_64-linux-musl','-O3','-static','-nostdlib','-nostdinc','-isystem',str(ROOT/'sysroot/usr/include'),'-isystem',str(INCLUDE),'-fuse-ld=lld',str(ROOT/'sysroot/usr/lib/crt1.o'),str(ROOT/'sysroot/usr/lib/crti.o'),str(ROOT/'emit.c'),str(ROOT/'sysroot/usr/lib/libc.a'),str(ROOT/'sysroot/usr/lib/crtn.o'),'-o',str(ROOT/'mm0-emit')]
subprocess.run(args,check=True)
records.append(dict(command=args,binary=str(ROOT/'mm0-emit'),sha256=hashlib.sha256((ROOT/'mm0-emit').read_bytes()).hexdigest(),producer=True))
(ROOT/'build-manifest.json').write_text(json.dumps(records,indent=2)+'\n')
print('Built timed and separately instrumented verifiers.')
