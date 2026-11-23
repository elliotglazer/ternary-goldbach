import csv,json,time
from pathlib import Path
from flint import arb,ctx,dirichlet_char
P=Path(__file__).resolve().parent
lo,hi=10**8-4096,10**8
step=8; res=[4,8,16,32,64,128,256,512,1024];ctx.prec=80;ctx.threads=1
chi=dirichlet_char(1,1)
plan=dict(lo=lo,hi=hi,step=step,res=res,bits=ctx.prec,threads=1,policy="stop each window on exact local saturation; retain all failed stages")
(P/'plan.json').write_text(json.dumps(plan,indent=2))
def now():return time.perf_counter(),time.process_time()
def delta(t):return time.perf_counter()-t[0],time.process_time()-t[1]
def count(t):
    out=arb(t).zeta_nzeros().unique_fmpz();assert out is not None
    return int(out)
start=now()
counts={lo:count(lo),hi:count(hi)}
global_cost=delta(start)
start=now()
for t in range(lo+step,hi,step): counts[t]=count(t)
interior_cost=delta(start)
(P/'counts.json').write_text(json.dumps(dict(global_time=global_cost,interior_time=interior_cost,counts=counts)))
sign_cpu=0;sign_wall=0;unique=0;repairs=0;complete=0;unresolved=[]
with (P/'signs.tsv').open('w',newline='') as sf,(P/'stages.csv').open('w',newline='') as wf:
    v=csv.writer(sf,delimiter='\t');w=csv.writer(wf)
    v.writerow(['tick_1024','bits','sign','enclosure'])
    w.writerow(['left','right','true_increment','denominator','cells','new_sites','changes','ambiguous','accepted','wall','cpu'])
    cache={}
    for left in range(lo,hi,step):
        right=left+step;n=counts[right]-counts[left]
        for den in res:
            t0=now();stride=1024//den
            new=0;arr=[]
            for tick in range(left*1024,right*1024+1,stride):
                if tick not in cache:
                    z=chi.hardy_z(arb(tick)/1024);assert z.imag.contains(0)
                    s=1 if z.real>0 else -1 if z.real<0 else 0
                    cache[tick]=s;v.writerow([tick,ctx.prec,s,str(z.real)]);new+=1
                arr.append(cache[tick])
            m=sum(a*b<0 for a,b in zip(arr,arr[1:]))
            assert m<=n
            accepted=(m==n and arr[0]!=0 and arr[-1]!=0)
            wall,cpu=delta(t0);sign_wall+=wall;sign_cpu+=cpu;unique+=new
            w.writerow([left,right,n,den,len(arr)-1,new,m,arr.count(0),accepted,wall,cpu])
            if accepted:
                complete+=1
                if den>res[0]:repairs+=1
                break
        else:unresolved.append([left,right,n,m])
        cache={right*1024:cache[right*1024]}
        if complete%32==0: wf.flush();sf.flush()
report=dict(zero_increment=counts[hi]-counts[lo],windows=512,accepted=complete,unresolved=unresolved,refined=repairs,sign_sites=unique,sign_cpu=sign_cpu,sign_wall=sign_wall,global_count_wall_cpu=global_cost,interior_diagnostic_wall_cpu=interior_cost,possible_vector_apis=[x for x in dir(chi) if 'hardy' in x or 'vector' in x])
(P/'summary.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
