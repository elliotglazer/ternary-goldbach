from pathlib import Path
from contextlib import redirect_stdout
from io import StringIO
import json
d=Path(__file__).resolve().parent
t=(d/'prepare_absorbed.py').read_text().split('exec(src)')[0]
exec(t)
src=src.replace('True,Counter())[19]','True,Counter())[column-1]').replace('[19*59:20*59]','[(column-1)*59:column*59]').replace("int(spec[0]['k41'])==20","int(spec[0]['k41'])==column").replace('j=19*59+k','j=(column-1)*59+k').replace('def save(p,rows):p.write_text','def save(p,rows):return; p.write_text')
results={}
for column in range(1,40):
 out=StringIO()
 with redirect_stdout(out):exec(src)
 for line in out.getvalue().splitlines():
  label,_,miss=line.split();results.setdefault(label,[]).append(int(miss))
(d/'absorbed-full-check.json').write_text(json.dumps(results))
print({l:(sum(v),len(v)*59) for l,v in results.items()})
