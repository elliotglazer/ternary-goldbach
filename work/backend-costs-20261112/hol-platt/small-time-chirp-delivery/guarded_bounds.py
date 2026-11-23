from delivery import *
import schedule
ss=json.loads(schedule.SOURCE.read_bytes())['scenarios'];sc=next(s for s in ss if s['extra_nodes']==640)['small_sign_only_conditional_candidate'];ts=dict(sc['conductor_theta'])
from math import ceil
from fractions import Fraction
mx=(0,None);phasebits=[]
for c,m,n,_,_ in sc['raw_metadata']:
 t=ts[c];L=2*((25*n+191)//192)+1;B=2*F(40000000 if c%2 else 80000000,t)**2+1;pc=schedule.bits(((7*B+12)*L+n)/F(35*n,2816*64*2**82*3**t))+1
 key=(n,pc)
 if key not in globals().setdefault('cache',{}):
    G=1<<(pc+76);h=seed(n,G);cache[key]=(mid(h[-1])[1],mid(h[-2])[1])
 E,D=cache[key];j=m+128;r=j*(1+2*E)+(2*D+1)*j*(j-1);assert r < (1<<(pc+76))
 x=F(r,1<<76)
 if x>mx[0]:mx=(x,(c,n,pc,j,r,E,D))
print(mx[1],float(mx[0]))
(p/'guarded-envelope.json').write_text(json.dumps(dict(worst_row=mx[1],max_radius_in_output_ulps=float(mx[0]),keys_checked=len(cache)),indent=2))
