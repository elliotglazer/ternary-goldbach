from delivery import *
import collections
from math import ceil
sys.path.insert(0,str(p.parent/'c10000-kronecker-time-price'))
from price import SOURCE,bits,primitive_count
data=json.loads(SOURCE.read_bytes())['scenarios'][0]['small_sign_only_conditional_candidate']
theta=dict(data['conductor_theta']); keys={}; lens={}; per=0;records=0
for c,m,n,_,_ in data['raw_metadata']:
    t=theta[c]; L=2*((25*n+191)//192)+1
    B=2*F(40000000 if c%2 else 80000000,t)**2+1;tol=F(35*n,2816*64*2**82*3**t)
    prec=bits(((7*B+12)*L+n)/tol)+1
    key=(n,prec);keys[key]=max(m,keys.get(key,0));lens[n]=max(m,lens.get(n,0))
    records+=1;per+=m
def sums(g):
    return dict(keys=len(g),dense_manifest=sum(x+1 for x in g.values()),padded_if_all=sum(x+897 for x in g.values()),rows_manifest=sum((x+64)//64 for x in g.values()),rows_padded=sum((x+960)//64 for x in g.values()))
out=dict(pin=hashlib.sha256(SOURCE.read_bytes()).hexdigest(),rows=records,per_conductor=per+records,per_np=sums(keys),per_n=sums(lens),c10000_class=sums({k:v for k,v in keys.items() if k[0]==524288}),class_key=[(n,k,v) for (n,k),v in keys.items() if n==524288 and k==240])
print(out);(p/'schedule.json').write_text(json.dumps(out,indent=2))
