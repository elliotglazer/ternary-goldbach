from pathlib import Path
import subprocess,json,hashlib,statistics,struct

ROOT=Path(__file__).resolve().parent
BASE=ROOT.parents[1]/'formal-goldbach-bench/mm0'
CLANG=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/clang.exe')
SYS=BASE/'sysroot'
command=[str(CLANG),'--target=x86_64-linux-musl','-O3','-static','-nostdlib','-nostdinc',
 '-isystem',str(SYS/'usr/include'),'-isystem',str(CLANG.parent.parent/'include/clang'),
 '-fuse-ld=lld',str(SYS/'usr/lib/crt1.o'),str(SYS/'usr/lib/crti.o'),str(ROOT/'validate.c'),
 str(SYS/'usr/lib/libc.a'),str(SYS/'usr/lib/crtn.o'),'-o',str(ROOT/'validate')]
subprocess.run(command,check=True)
def linux(p):return '/mnt/host/c'+p.as_posix()[2:]
def run(file,reps=1,cache=None):
    args=['wsl','-d','docker-desktop','--',linux(ROOT/'validate'),linux(file),str(reps)]
    if cache:args.append(linux(cache))
    p=subprocess.run(args,text=True,capture_output=True)
    return p,args
meta=json.loads((ROOT/'cases.json').read_text())
records={}
for name in ['full_pratt','partial_pock','cached_pock','smooth_pock','cached_inverse','smooth_inverse']:
    cache=ROOT/'small_cache.bin' if name.startswith(('cached_','smooth_')) else None
    samples=[]
    for i in range(5):
        p,args=run(ROOT/(name+'.bin'),20,cache)
        if p.returncode:raise RuntimeError(p.stderr)
        samples.append(json.loads(p.stdout))
    med=statistics.median(s['cpu_seconds']/s['reps']/s['roots'] for s in samples)
    first=samples[0]
    records[name]={'samples':samples,'median_cpu_seconds_per_root':med,
      'conditional_core_years_for_238418579456_anchors':med*238418579456/31557600,
      'montgomery_multiplications_per_root':(first['squares']+first['products'])/first['roots'],
      'pow_checks_per_root':first['pow_checks']/first['roots'],
      'bytes_per_root':first['bytes']/first['roots']}
neg=ROOT/'negative';neg.mkdir(exist_ok=True)
original=(ROOT/'smooth_pock.bin').read_bytes(); o=meta['cases']['smooth_pock']['first_nontrivial_offset']
mutations={}
def change(name,offset,data):
    b=bytearray(original);b[offset:offset+len(data)]=data;mutations[name]=bytes(b)
change('bad_magic',0,b'X')
change('base_one',o+8,struct.pack('<Q',1))
change('zero_exponent',o+25+8,b'\0')
change('self_factor',o+25,original[o:o+8])
change('composite_factor',o+25,struct.pack('<Q',4))
change('bad_remainder',o+16,struct.pack('<Q',2**64-1))
change('too_many_factors',o+24,b'\x41')
change('too_many_nodes',8,struct.pack('<I',100001))
change('unknown_root',len(original)-8,struct.pack('<Q',0))
mutations['truncated']=original[:-1]
mutations['trailing']=original+b'X'
n,a=struct.unpack_from('<QQ',original,o)
mutations['insufficient_F']=b'POCK0001'+struct.pack('<IIQQQBQBQ',1,1,n,a,(n-1)//2,1,2,1,n)
bad_cache=bytearray((ROOT/'small_cache.bin').read_bytes())
struct.pack_into('<Q',bad_cache,meta['cases']['small_cache']['first_nontrivial_offset']+8,1)
(neg/'bad_cache.bin').write_bytes(bad_cache)
rejections=[]
for name,b in mutations.items():
    path=neg/(name+'.bin');path.write_bytes(b)
    p,args=run(path,1,ROOT/'small_cache.bin')
    assert p.returncode!=0 and 'REJECT' in p.stderr,(name,p.stdout,p.stderr)
    rejections.append({'case':name,'exit':p.returncode,'diagnostic':p.stderr.strip()})
p,args=run(ROOT/'smooth_pock.bin',1,neg/'bad_cache.bin')
assert p.returncode!=0 and 'REJECT cache' in p.stderr
rejections.append({'case':'invalid_cache','exit':p.returncode,'diagnostic':p.stderr.strip()})
inverse=bytearray((ROOT/'smooth_inverse.bin').read_bytes())
for name,value in [('inverse_zero',0),('inverse_wrong',1)]:
    struct.pack_into('<Q',inverse,16+25+9,value)
    path=neg/(name+'.bin');path.write_bytes(inverse)
    p,args=run(path,1,ROOT/'small_cache.bin')
    assert p.returncode!=0 and 'REJECT' in p.stderr
    rejections.append({'case':name,'exit':p.returncode,'diagnostic':p.stderr.strip()})
out={'kind':'Native Pocklington validator benchmark, not a formally verified MM0 extension',
 'command':command,'format':'Bounded little-endian binary; all certificate parsing is inside timed loops; file I/O excluded',
 'input_metadata':meta,'cases':records,'negative_controls':rejections,
 'hashes':{p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in [ROOT/'validate.c',ROOT/'validate',ROOT/'prepare.py',ROOT/'run.py']}}
(ROOT/'results.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:{x:y for x,y in v.items() if x!='samples'} for k,v in records.items()},indent=2))
print('negative_controls',len(rejections))
