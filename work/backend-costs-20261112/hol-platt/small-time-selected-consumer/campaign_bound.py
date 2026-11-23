from pathlib import Path
import sys,json,hashlib
from math import ceil
from fractions import Fraction as F
from collections import Counter
p=Path(__file__).resolve().parent
sys.path.insert(0,str(p.parent/'c10000-kronecker-time-price'))
from price import SOURCE,bits,primitive_count
data=json.loads(SOURCE.read_bytes())['scenarios'][0]['small_sign_only_conditional_candidate']
theta=dict(data['conductor_theta']); counts=Counter(); chars=0; margin=100; worst=None
for c,m,n,_,_ in data['raw_metadata']:
    L=2*((25*n+191)//192)+1
    B=2*F(40000000 if c%2 else 80000000,theta[c])**2+1
    tol=F(35*n,2816*64*2**82*3**theta[c])
    prec=bits(((7*B+12)*L+n)/tol)+1
    X=ceil((B+1)*(1<<prec));Y=(1<<prec)+1
    G=4*L*X*Y; w=8*((G.bit_length()+8)//8)
    assert G < 1<<(w-1)
    # Product sets must be identical in A,B,C; each contributing complex term then has coordinate <= 2XY.
    C=2*L*X*Y
    assert C <= (1<<(w-1))-1 and 2*C < 1<<(w-1)
    gap=(w-1)-C.bit_length()
    if gap<margin:margin=gap;worst=[c,w,prec,L,C.bit_length()]
    counts[w]+=1;chars+=primitive_count(c)
out=dict(rows=sum(counts.values()),primitive_characters=chars,field_width_rows=counts,min_spare_whole_bits=margin,first_worst=worst,source_sha256=hashlib.sha256(SOURCE.read_bytes()).hexdigest())
print(out);(p/'campaign-recombine.json').write_text(json.dumps(out,indent=2))
