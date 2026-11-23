import csv,gzip,json
from collections import Counter
from time import process_time
from complete import here,comp,ct,phases,factors,arb,acb,Q,S
def run():
    start=process_time()
    labels,phase=phases()
    edges={}
    with gzip.open(here/'high-signs.tsv.gz','rt') as f:
        for r in csv.DictReader(f,delimiter='\t'):
            edges[int(r['j']),int(r['k41']),int(r['k61'])]=int(r['sign'])
    changes=missed=uncertain=0
    examples=[]
    nodes=[]
    with gzip.open(here/'high-midpoints.tsv.gz','wt',newline='') as f:
        w=csv.writer(f,delimiter='\t',lineterminator='\n')
        w.writerow(('left_j','k41','k61','direct_radius_grid_units','sign','scaled_value'))
        for j in range(84184,84199):
            h=2*j+1
            src=comp.read(here/f'mid{h}-source.tsv')
            ref=ct.tensor([(int(r['re']),int(r['im']),1) for r in src],ct.direct_balls)
            t=arb(5*h)/128
            fac=[z*acb(Q)**(-acb(arb(1)/2,t)) for z in factors(t)]
            count=Counter()
            for p,(a,b,e) in zip(labels,ref,strict=True):
                z=phase[p]*fac[comp.parity(*p)]*acb(arb(a,e),arb(b,e))/S
                assert z.imag.contains(0)
                v=z.real
                sig=1 if v>0 else -1 if v<0 else 0
                count[sig]+=1
                l=edges[(j,*p)];r=edges[(j+1,*p)]
                changes+=(l*sig<0)+(sig*r<0)
                if sig and l==r and l*sig<0:
                    missed+=1
                    examples.append((j,*p,l,sig,r))
                uncertain+=sig==0
                w.writerow((j,*p,e,sig,v.str(40)))
            nodes.append(dict(left=j,counts=count))
    res=dict(midpoint_nodes=nodes,twice_grid_changes=changes,hidden_pairs=missed,examples=examples,
             inconclusive=uncertain,cpu=process_time()-start)
    (here/'mid-receipt.json').write_text(json.dumps(res,indent=2))
run()
