"""Independent finite integer cost-row audit; no analytic values or author imports."""
from pathlib import Path
import hashlib, json
HERE=Path(__file__).resolve().parent
A=HERE.parent
root=A/'independent-feasibility'
names={'FINAL_SEED_CONDITIONAL_COST_CHOICE_2026-11-11.md':'DEB728C9991A4B906B49D65651CD8E6C994CF814C0091809A3CB7138A157D1B2',
'final_seed_cost_choice_20261111.py':'A5A5C7E2F4B88CB2C5A939B1D168B0559874C93E3AB0E417622CDB8AA97947E8',
'final_seed_cost_choice_20261111.json':'7E8ABFDC0F2A212B975738DE94D17448F8A6C9EA597D3203A01933A4FB8882E9'}
checks=0
def ck(x):
    global checks
    assert x
    checks+=1
for name,h in names.items(): ck(hashlib.sha256((root/name).read_bytes()).hexdigest().upper()==h)
old=json.loads((root/'final_seed_cost_choice_20261111.json').read_text())
for p,h in old['pins'].items(): ck(hashlib.sha256(Path(p).read_bytes()).hexdigest().upper()==h)
rows={}
for key,D,P,N,m in [('B',8192,27,2387,64),('Q',4096,28,2387,64),('C',8192,27,1500,256)]:
    # Count each actual anchor's retained orders, including the distinct last endpoint.
    orders=[P]*D+[P if key=='Q' else 20]
    slots=sum(orders)
    shifts=3*D*sum(min(20,j+1) for j in range(P-1)) if key=='Q' else D*sum(min(20,j+1) for j in range(P-1))
    row=dict(head_scales=N*sum(k-1 for k in orders),head_adds=N*slots,
      gamma_scales=m*slots,gamma_adds=m*slots,E_stages=sum(k+2*m-2 for k in orders),
      source_slots=slots,coarse_anchors=len(orders),R_stages=P-1,shift_updates=shifts,
      normalization_scales=20*(4*D+1) if key=='Q' else 0,
      normalization_rounds=20*(4*D+1) if key=='Q' else 0,argument_pairs=(N+1)*D+1)
    for k,v in row.items(): ck(v==old['per_height'][key][k])
    rows[key]=row
previous=1721*4096+1
# Closed-grid intersections, counted without allocating millions of points.
intersection={'B':previous,'Q':previous,'C':1501*4096+1}
setup=old['setup']; H=20839
for key,row in rows.items():
    X=row['argument_pairs']; I=X-intersection[key]
    ck(I==setup[key]['introduced'])
    ck(previous+I==setup[key]['union'])
    ck(H*X-I==old['totals'][key]['fine_state_updates'])
    ck(H*X-I==(H-1)*X+intersection[key])
    for k,v in row.items(): ck(H*v==old['totals'][key][k])
ck(H+64001==84840 and 5*(84840-1)==424195 and 424195<7000*64)
# Coefficients of cost(old)-cost(new), including the initialization replacement.
diffs={}
for i,j in [('B','Q'),('B','C'),('C','Q')]:
    d={k:rows[i][k]-rows[j][k] for k in rows[i]}
    g=old['gains'][i+'-to-'+j]
    for k,v in d.items(): ck(v==g['per_height'][k])
    fd={k:setup[i][k]-setup[j][k] for k in setup[i]}
    for k,v in fd.items(): ck(v==g['fixed'][k])
    # Basis price vectors verify sign and division by H without floating point.
    for s,c,Si,Sj in [(1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1),(7,11,13,17)]:
        lhs=Si-Sj+(H*rows[i]['argument_pairs']-setup[i]['introduced'])*s-(H*rows[j]['argument_pairs']-setup[j]['introduced'])*s+H*d['argument_pairs']*c
        F=Si-Sj-fd['introduced']*s
        ck(lhs==H*d['argument_pairs']*(s+c)+F)
    ck(fd['union']==fd['introduced'])
    diffs[i+j]=dict(per_height=d,setup_difference=fd)
out=dict(scope='Independent integer row/lifetime/sign audit only',checks=checks,author_pins=names,rows=rows,differences=diffs)
dest=HERE/'review_final_seed_cost_choice_20261111.json'
with dest.open('x',encoding='utf-8') as f: json.dump(out,f,indent=2);f.write('\n')
print(json.dumps({'checks':checks,'status':'PASS'}))
