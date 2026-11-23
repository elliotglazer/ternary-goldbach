import csv,json,time,collections,statistics
from pathlib import Path
from flint import arb,ctx,dirichlet_char
p=Path(__file__).resolve().parent
summary=json.loads((p/'summary.json').read_text())
sites={int(r['tick_1024']):int(r['sign']) for r in csv.DictReader((p/'signs.tsv').open(),delimiter='\t')}
stages=list(csv.DictReader((p/'stages.csv').open()))
final=[r for r in stages if r['accepted']=='True']
endpoints=set();brackets=[]
for r in final:
    a,b,d=map(int,[r['left'],r['right'],r['denominator']]);stride=1024//d
    local=[(j,j+stride) for j in range(a*1024,b*1024,stride) if sites[j]*sites[j+stride]<0]
    assert len(local)==int(r['true_increment'])
    for pair in local:endpoints.update(pair)
    brackets+=local
assert all(q[1]<=r[0] for q,r in zip(brackets,brackets[1:]))
chi=dirichlet_char(1,1);ctx.threads=1;ctx.prec=112
start=time.perf_counter();cpu=time.process_time();least=None
with (p/'retained-signs.tsv').open('w',newline='') as f:
    w=csv.writer(f,delimiter='\t');w.writerow(['tick_1024','sign','enclosure'])
    for i in sorted(endpoints):
        z=chi.hardy_z(arb(i)/1024);assert z.imag.contains(0)
        sign=1 if z.real>0 else -1 if z.real<0 else 0
        assert sites[i]==sign and sign!=0
        mag=abs(z.real)
        if least is None or mag<least[1]:least=i,mag
        w.writerow([i,sign,str(z.real)])
timing=[time.perf_counter()-start,time.process_time()-cpu]
with (p/'retained-brackets.tsv').open('w',newline='') as f:
    w=csv.writer(f,delimiter='\t');w.writerow(['start_tick','end_tick']);w.writerows(brackets)
h=collections.Counter(int(r['denominator']) for r in final)
refinements={d:{'attempts':sum(int(r['denominator'])==d for r in stages),'incomplete':sum(int(r['denominator'])==d and r['accepted']!='True' for r in stages),'proposed_cells':sum(int(r['cells']) for r in stages if int(r['denominator'])==d),'new_sites':sum(int(r['new_sites']) for r in stages if int(r['denominator'])==d),'missed':sum(int(r['true_increment'])-int(r['changes']) for r in stages if int(r['denominator'])==d)} for d in sorted({int(r['denominator']) for r in stages})}
res=dict(brackets=len(brackets),distinct_endpoints=len(endpoints),validation_wall_cpu=timing,smallest_replayed_abs=[least[0],str(least[1])],final_resolutions=h,refinements=refinements,terminal_cells=sum(int(r['cells']) for r in final),ambiguous=sum(s==0 for s in sites.values()))
(p/'validation.json').write_text(json.dumps(res,indent=2)+'\n')
print(res)
