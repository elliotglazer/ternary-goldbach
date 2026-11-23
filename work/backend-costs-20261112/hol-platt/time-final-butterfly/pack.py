from pathlib import Path
here=Path(__file__).resolve().parent
rows=[]
for line in (here/'butterflies.txt').read_text().splitlines():
    *values,e,q,s=map(int,line.split())
    assert all(-(1<<279)<=v<(1<<279) for v in values)
    assert -(1<<31)<=q<(1<<31)
    rows.append(' '.join(format(k,'x') for k in [*(v+(1<<279) for v in values),e,q+(1<<31),s]))
(here/'packed.hex').write_bytes(('\n'.join(rows)+'\n').encode())
