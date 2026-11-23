from pathlib import Path
import re,statistics,json,hashlib
from collections import defaultdict
d=Path(__file__).resolve().parent
out={}
for file in ['odd01PrimePrice.log','odd01BoundPrice.log','even01EvenPrice.log']:
 p=d/file
 if not p.exists():continue
 s=p.read_text();rows=defaultdict(list)
 for label,n,mode,v in re.findall(r'FUSED (\w+) (\d+) (true|false)[\s\S]*?JOIN_EVAL [\d.e+-]+ ([\d.e+-]+)',s):
  if label.startswith('prime'):size,repeat=257,256
  elif label.startswith('bound'):size,repeat=59,1024
  else:size=int(label.rsplit('n',1)[1]);repeat=131072//size
  if int(n)==repeat:rows[label,mode].append(float(v)*1e6/(repeat*size))
 for l in sorted({l for l,m in rows}):
  if len(rows[l,'true'])<3 or len(rows[l,'false'])<3:continue
  a=statistics.median(rows[l,'false']);b=statistics.median(rows[l,'true'])
  out[l]=dict(old_us=a,new_us=b,difference_us=b-a,old=rows[l,'false'],new=rows[l,'true'],file=file)
  print(l,round(a,4),round(b,4),round(b-a,4))
(d/'other-price.json').write_text(json.dumps(out,indent=2))
