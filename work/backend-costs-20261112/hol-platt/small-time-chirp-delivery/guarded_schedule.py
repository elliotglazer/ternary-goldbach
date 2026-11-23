from schedule import *
from collections import Counter
out={}
for sc in json.loads(SOURCE.read_bytes())['scenarios']:
 data=sc['small_sign_only_conditional_candidate'];ts=dict(data['conductor_theta'])
 K={};N={};Kker={};NK=Counter();per=0
 for c,m,n,_,_ in data['raw_metadata']:
    t=ts[c];J=(25*n+191)//192;L=2*J+1;B=2*F(40000000 if c%2 else 80000000,t)**2+1
    prec=bits(((7*B+12)*L+n)/F(35*n,2816*64*2**82*3**t))+1;k=n,prec
    K[k]=max(K.get(k,0),m);N[n]=max(N.get(n,0),m);Kker[k]=max(Kker.get(k,0),J+m)
    per+=(m+257)*primitive_count(c)
 def stats(v):
    return dict(keys=len(v),main=sum(m+1 for m in v.values()),full_packed_sites=sum(m+257 for m in v.values()),recurrence_sites=sum(m+129 for m in v.values()),packed_rows=sum((m+320)//64 for m in v.values()))
 val=dict(full=stats(K),retained128=stats(N),per_character_cells=per,kernel_indices=sum(m+1 for m in Kker.values()),largest_working_precision=max(b+76 for a,b in K),c10000_length=stats({k:m for k,m in K.items() if k[0]==524288}),class238=stats({k:m for k,m in K.items() if k[0]==262144}))
 assert all(m+128<=Kker[k] for k,m in K.items());out[sc['extra_nodes']]=val
(p/'guarded-atlas.json').write_text(json.dumps(out,indent=2));print(out[640])
