from pathlib import Path
import re,statistics,json,hashlib
d=Path(__file__).resolve().parent
result={}
for mode in ['AbsorbedPrice','FusedPrice']:
 logs=sorted(d.glob('f*'+mode+'.log'))
 if not logs: continue
 log=logs[-1];s=log.read_text(); groups={}
 for label,rep,kind,c,cpu,dec in re.findall(r'FUSED (fu\d+h\d+) (\d+) (true|false)[\s\S]*?JOIN_EVAL ([\d.e+-]+) ([\d.e+-]+) ([\d.e+-]+)',s):
  groups.setdefault((label,int(rep),kind),[]).append(float(cpu))
 rows=[]
 rep=1024 if mode=='AbsorbedPrice' else 256
 for l in sorted({k[0] for k in groups}):
  if not all((l,rep,m) in groups for m in ('true','false')):continue
  trial={m:[t*1e6/(rep*59) for t in groups[l,rep,m]] for m in ['true','false']}
  net=statistics.median(trial['true'])-statistics.median(trial['false'])
  rows.append(dict(label=l,old_us=trial['false'],new_us=trial['true'],median_difference_us=net,full_family_sensitivity_hours=net*39241839619586/3600e6))
 result[mode]=dict(log=log.name,sha256=hashlib.sha256(log.read_bytes()).hexdigest(),rows=rows)
(d/'fused-price.json').write_text(json.dumps(result,indent=2))
for m,record in result.items():
 for row in record['rows']:print(m,row['label'],row['median_difference_us'],row['full_family_sensitivity_hours'])
