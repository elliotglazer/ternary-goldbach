import csv,json,time,statistics
from pathlib import Path
import flint
from flint import arb,dirichlet_char,ctx
ctx.prec=80;ctx.threads=1
out=Path(__file__).resolve().parent
chi=dirichlet_char(1,1)
ends=[100,1000,10000,100000,1000000,10000000,25000000,50000000,75000000,100000000]
manifest={'end_heights':ends,'width':8,'grid_denominators':[2,4,8,16,32,64,128],'precision':80,'threads':1}
(out/'shard-plan.json').write_text(json.dumps(manifest,indent=2))
with (out/'shards.csv').open('w',newline='') as sf,(out/'shard-signs.tsv').open('w',newline='') as vf:
    s=csv.writer(sf);v=csv.writer(vf,delimiter='\t')
    s.writerow(['end','lo_count','hi_count','denom','grid_sites','new_evals','strict_sites','inconclusive_sites','proposed_cells','verified_changes','missed_count','saturated','count_cpu','stage_cpu','cumulative_sign_cpu'])
    v.writerow(['end','numerator','denominator','stage','sign','enclosure'])
    for end in ends:
        lo=end-8; start=time.process_time()
        counts=[arb(t).zeta_nzeros().unique_fmpz() for t in (lo,end)]
        assert all(n is not None for n in counts);a,b=map(int,counts)
        countcpu=time.process_time()-start
        start=time.process_time();cache={}
        for den in manifest['grid_denominators']:
            tick=128//den; stage=time.process_time(); nnew=0
            for j in range(0,8*128+1,tick):
                if j in cache:continue
                z=chi.hardy_z(arb(lo*128+j)/128)
                assert z.imag.contains(0)
                sign=1 if z.real>0 else -1 if z.real<0 else 0
                v.writerow([end,lo*128+j,128,den,sign,str(z.real)])
                cache[j]=sign;nnew+=1
            signs=[cache[j] for j in range(0,1025,tick)]
            changed=sum(u*v<0 for u,v in zip(signs,signs[1:]))
            assert changed<=b-a
            ok=changed==b-a and signs[0]*signs[-1]!=0
            s.writerow([end,a,b,den,len(signs),nnew,sum(x!=0 for x in signs),signs.count(0),len(signs)-1,changed,b-a-changed,ok,countcpu,time.process_time()-stage,time.process_time()-start]);sf.flush();vf.flush()
            if ok:break
        print(end,b-a,den,changed,round(time.process_time()-start,4),flush=True)
