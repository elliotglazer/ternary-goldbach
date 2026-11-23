from pathlib import Path
d=Path(__file__).resolve().parent
for name,length in [('low',32),('high',16)]:
 data=[list(map(int,line.split())) for line in (d/(name+'count.txt')).read_text().splitlines()]
 blocks=[]
 for start in range(0,2301,64):
  rows=data[start:start+64]
  words=[sum(((x>>j)&1)<<c for c,(x,k,w) in enumerate(rows)) for j in range(length)]
  assert all(sum(((words[j]>>c)&1)<<j for j in range(length))==x for c,(x,k,w) in enumerate(rows))
  blocks.append(words)
 (d/(name+'blocks.txt')).write_text(''.join(' '.join(map(str,b))+'\n' for b in blocks))
p=d/'run.sh';p.write_bytes(p.read_bytes().replace(b'|PrimeSink|PrimePrice)',b'|PrimeSink|PrimePrice|TransposeScan|TransposePrice)'))
