from pathlib import Path
from hashlib import sha256
p=Path(__file__).resolve().parent
for l in [3,6667,11,9091]:
 f=p/f'heads-{l}.txt';rows=f.read_text().splitlines();f.write_bytes(('\n'.join(rows)+'\n').encode())
 assert f.read_bytes()==(p.parent/'sparse-head'/f.name).read_bytes()
