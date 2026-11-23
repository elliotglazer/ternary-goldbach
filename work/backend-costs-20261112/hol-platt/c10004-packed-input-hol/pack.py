"""Pack pairs into little-endian blocks of signed 96-bit coordinates."""
from pathlib import Path
from time import perf_counter
import hashlib
import json

here = Path(__file__).resolve().parent
B = 1 << 96
out = []
for h in (1,2):
    src = here.parent/f'c10004-hol-replay/input{h}.tsv'
    xs = [tuple(map(int,row.split())) for row in src.read_text().splitlines()]
    assert len(xs)==4800 and all(len(pair)==2 for pair in xs)
    for n in (4,16):
        started = perf_counter()
        vals = []
        for k in range(0,len(xs),n):
            block = xs[k:k+n]
            assert len(block)==n
            z = 0
            for j,pair in enumerate(block):
                for offset,x in enumerate(pair):
                    assert -B//2 <= x < B//2
                    z |= (x % B) << (96*(2*j+offset))
            vals.append(z)
        path = here/f'h{h}-n{n}.txt'
        path.write_bytes(('\n'.join(map(str,vals))+'\n').encode())
        elapsed = perf_counter()-started
        back = []
        for z in vals:
            for _ in range(n):
                a,z = z%B,z//B
                b,z = z%B,z//B
                back.append((a if a<B//2 else a-B,b if b<B//2 else b-B))
            assert z==0
        assert back==xs
        out.append(dict(h=h,pairs=n,bytes=path.stat().st_size,blocks=len(vals),
                        seconds=elapsed,sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
print(json.dumps(out,indent=2))
