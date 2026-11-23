import csv,json,math,statistics
from collections import defaultdict
from pathlib import Path
p=Path(__file__).resolve().parent
stages=defaultdict(list)
for r in csv.DictReader((p/'stages.csv').open()):stages[int(r['left'])].append(r)
ss=json.loads((p/'summary.json').read_text());zs=ss['zero_increment']
def q(x,p):return sorted(x)[int((len(x)-1)*p)]
rows=[]
for left,rec in stages.items():
    wall=sum(float(x['wall']) for x in rec);z=int(rec[-1]['true_increment'])
    rows.append([left,z,int(rec[-1]['denominator']),sum(int(x['new_sites']) for x in rec),wall,wall/z])
bins=[]
for grp in range(16):
    block=rows[32*grp:32*(grp+1)];n=sum(x[1] for x in block)
    bins.append(dict(lo=block[0][0],zeros=n,wall_s_per_zero=sum(x[4] for x in block)/n,sites_per_zero=sum(x[3] for x in block)/n))
rates=[x['wall_s_per_zero'] for x in bins]
out=dict(per_256unit_blocks=bins,block_rate_min_med_max=[min(rates),statistics.median(rates),max(rates)],expensive_windows=sorted(rows,key=lambda x:-x[2])[:12],
    proposed_total=sum(int(x['cells']) for rec in stages.values() for x in rec),sites_per_zero=ss['sign_sites']/zs,proposer_cpu_s_per_zero=ss['sign_cpu']/zs,proposer_full_count_at_high_rate_h=ss['sign_cpu']/zs*248008025/3600,rs_terms_at_ceiling=math.floor(math.sqrt(10**8/(2*math.pi))))
(p/'sensitivity.json').write_text(json.dumps(out,indent=2)+'\n')
print({k:v for k,v in out.items() if k!='per_256unit_blocks'})
