"""Independent Python-integer validation of generated binary certificates."""
from pathlib import Path
import struct, math, json
ROOT=Path(__file__).resolve().parent

def check(data,cache=frozenset()):
    if len(data)<16 or len(data)>16000000 or data[:7]!=b'POCK000' or data[7] not in [49,50]:raise ValueError('header')
    inverse_mode=data[7]==50
    nn,nr=struct.unpack_from('<II',data,8)
    if nn>100000 or nr>100000:raise ValueError('count')
    offset=16;known=set();prev=0
    def read(fmt):
        nonlocal offset
        sz=struct.calcsize(fmt)
        if offset+sz>len(data):raise ValueError('truncated')
        x=struct.unpack_from(fmt,data,offset);offset+=sz;return x
    for _ in range(nn):
        n,a,r,k=read('<QQQB')
        if not 2<=n<=4000000000000000000 or n<=prev or k>64:raise ValueError('node')
        fs=[];F=1;qprev=0
        for _ in range(k):
            q,e=read('<QB')
            v=read('<Q')[0] if inverse_mode else None
            if not (qprev<q<n and q>=2 and 1<=e<=62 and (q in known or q in cache)):raise ValueError('factor')
            if inverse_mode and not 0<v<n:raise ValueError('inverse bounds')
            F*=q**e
            if F>n-1:raise ValueError('product')
            qprev=q;fs.append((q,e,v))
        if n==2:
            if k or a or r!=1:raise ValueError('base')
        else:
            if not (n%2 and 2<=a<n and r>=1 and F>=2 and r*F==n-1 and F*F>n):raise ValueError('arithmetic')
            if pow(a,n-1,n)!=1:raise ValueError('Fermat')
            if inverse_mode:
                if any((pow(a,(n-1)//q,n)-1)*v%n!=1 for q,e,v in fs):raise ValueError('inverse')
            elif any(math.gcd(pow(a,(n-1)//q,n)-1,n)!=1 for q,e,v in fs):raise ValueError('gcd')
        known.add(n);prev=n
    roots=[]
    for _ in range(nr):
        p,=read('<Q')
        if p not in known and p not in cache:raise ValueError('root')
        roots.append(p)
    if offset!=len(data):raise ValueError('trailing')
    return known,roots

cache,_=check((ROOT/'small_cache.bin').read_bytes())
results={}
for name in ['full_pratt','partial_pock','cached_pock','smooth_pock','cached_inverse','smooth_inverse']:
    known,roots=check((ROOT/(name+'.bin')).read_bytes(),cache if name.startswith(('cached_','smooth_')) else set())
    results[name]={'accepted_nodes':len(known),'roots':len(roots)}
rejected=[]
for path in sorted((ROOT/'negative').glob('*.bin')):
    try: check(path.read_bytes(),set() if path.stem=='bad_cache' else cache)
    except (ValueError,struct.error):rejected.append(path.name)
    else:raise RuntimeError(f'bad certificate accepted: {path}')
out={'positive_cases':results,'negative_rejected':rejected,'independent_integer_arithmetic':True}
(ROOT/'reference-results.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out,indent=2))
