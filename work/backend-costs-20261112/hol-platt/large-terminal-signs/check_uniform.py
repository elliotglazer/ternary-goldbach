from pathlib import Path
from contextlib import redirect_stdout
from io import StringIO
import json
d=Path(__file__).resolve().parent
t=(d/'prepare_absorbed.py').read_text().split('exec(src)')[0];exec(t)
src=src.replace('True,Counter())[19]','True,Counter())[column-1]').replace('[19*59:20*59]','[(column-1)*59:column*59]').replace("int(spec[0]['k41'])==20","int(spec[0]['k41'])==column").replace('j=19*59+k','j=(column-1)*59+k').replace('def save(p,rows):p.write_text','def save(p,rows):return; p.write_text')
# The direct middle-axis enclosure proves component errors <=1 low-grid unit on input.
src=src.replace('spec=list(','''middle_ref=[ref.direct_balls([(x,y,3) for x,y in sub[i:i+40]])[column-1] for i in range(0,2400,40)]
 spec=list(''').replace('ys=[]; unm=[]','''assert all(max(abs(a*D-r),abs(b*D-i))+e<=D for (a,b),(r,i,e) in zip(xs,middle_ref))
  Eraw=sum((2*S+2)*(3+(abs(x)+abs(y)+2+S-1)//S)+abs(tr)+abs(ti) for (x,y),(tr,ti) in zip(xs,aa))
  ys=[]; unm=[]''')
src=src.replace('   ap,aq=rot','''   unc=Eraw
   post=(2*S*Eraw+abs(R)+abs(I)+2*Eraw+S*S-1)//(S*S)+1
   assert abs(val)>(abs(m)+abs(n))*post+(abs(a)+abs(bb)+abs(f)+abs(g)+2)*(abs(r)+abs(i)+2*post)
   ap,aq=rot''')
results={}
for column in range(1,40):
 out=StringIO()
 with redirect_stdout(out):exec(src)
 for line in out.getvalue().splitlines():
  label,_,miss=line.split();results.setdefault(label,[]).append(int(miss))
(d/'absorbed-uniform-check.json').write_text(json.dumps(results))
print({l:(sum(v),len(v)*59) for l,v in results.items()})
