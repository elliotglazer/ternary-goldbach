from pathlib import Path
import sys,csv,json,math,time
from flint import fmpz,arb,acb,ctx
d=Path(__file__).resolve().parent;b=d.parent/'large-sector-second';sys.path.insert(0,str(d.parent/'c10000-kronecker'))
from kronecker import Cyclic,quantize,pairmul
ctx.prec=128;ctx.threads=1;n=131070
def load(name):return [tuple(map(int,r)) for r in list(csv.reader((b/name).open(),delimiter='\t'))[1:]]
raw=load('input28.tsv');root=load('roots28.tsv')
parts=json.loads((b/'cohort.json').read_text())['phase_parts_grid28']
arc=json.loads((d.parent/'large-coarse-sign/prime-131071.json').read_text())
node=next(k for k in arc['nodes'] if k['j']==5695)
ref=bin(int(node['reference_signs_hex'],16))[2:]
assert len(ref)==n and len(root)==n-1 and len(raw)==n
def save(f,rows):f.write_text(''.join(' '.join(map(str,r))+'\n' for r in rows))
def rd(x,D):return (x+D//2)//D
stats=[]
for p in [24,28]:
 start=time.process_time();D=2**(28-p);S=2**p
 xs=[(rd(r,D),rd(i,D)) for _,a,r,i in raw]; ws=[]
 for k in range(n):
  t=k*k%(2*n);theta=math.pi*t/n;u=round(S*math.cos(theta));v=round(S*math.sin(theta))
  w=acb(0,arb.pi()*t/n).exp();assert abs(w.real*S-u)<1 and abs(w.imag*S-v)<1;ws.append((u,v))
 aa=[quantize(pairmul(x,w),S) for x,w in zip(xs,ws)]
 ring=Cyclic(n,max(abs(z) for x in aa for z in x),S)
 a=ring.complex_pack(aa);c=ring.complex_pack([(x,-y) for x,y in ws])
 r,i=ring.product(a,c,fmpz);rv=ring.unpack(r);iv=ring.unpack(i)
 # Scalar cross-check original full-axis arithmetic at disjoint indices.
 for k in [0,1,257,n//2,n-1]:
  rr=ii=0
  for j,(x,y) in enumerate(aa):
   u,v=ws[(k-j)%n];rr+=x*u+y*v;ii+=y*u-x*v
  assert (rr,ii)==(rv[k],iv[k])
 er=sum((2*S+2)*(3+(abs(x)+abs(y)+2+S-1)//S)+abs(t)+abs(b) for (x,y),(t,b) in zip(xs,aa))
 out=[];cfg=[];sign=[0];fallback=[0];qorder=[]
 for k in range(n):
  u,v=ws[k];R,I=rv[k],iv[k];r,i=quantize(pairmul((R,I),(u,v)),S*S);out.append((r,i))
  if k==0:cfg.append(None);continue
  ix,P,Q=root[k-1];assert ix==k;P,Q=rd(P,D),rd(Q,D);F,G=[rd(x,D) for x in parts[k%2]]
  A,B=quantize(pairmul((P,Q),(u,v)),S);ep=(abs(P)+abs(Q)+abs(u)+abs(v)+2+S-1)//S+1
  e=(2*S*er+abs(R)+abs(I)+2*er+S*S-1)//(S*S)+1;cfg.append([P,Q,F,G,e,er])
  pf=(A>0)==(F>0);qg=(B>0)==(G>0);val,ori=(R,pf) if pf!=qg else (I,(A>0)!=(G>0))
  if min(abs(A),abs(B))>ep and min(abs(F),abs(G))>1 and abs(val)>er:
   s=2 if ((val>0)==ori) else 1;fallback.append(0)
  else:
   a,b=pairmul((P,Q),(F,G));score=a*r-b*i
   err=(abs(a)+abs(b))*e+(abs(P)+abs(Q)+abs(F)+abs(G)+2)*(abs(r)+abs(i)+2*e)
   s=2 if score>err else 1 if score< -err else 0;fallback.append(1)
  assert not s or (s==2)==(ref[k]=='1');sign.append(s)
 cases=[]
 for start0,num in [(1,64),(n//2-128,256),(n-1024,1024)]:
  sl=slice(start0,start0+num);bits=sum((x==2)<<j for j,x in enumerate(sign[sl]));bad=sum((x==0)<<j for j,x in enumerate(sign[sl]));name='even'+str(p)+'n'+str(num)
  for suffix,rr in [('zs',zip(rv[sl],iv[sl])),('ws',ws[sl]),('abs',cfg[sl]),('cfg',[[S,sum(x+3*y for x,y in out[sl])%65537,bits,bad]])]:save(d/(name+suffix+'.txt'),rr)
  cases.append(dict(start=start0,n=num,fallback=sum(fallback[sl]),unknown=bad.bit_count()))
 ng=[k for k in range(1,n) if sign[k]==0]
 lmask=bin(int(next(row for row in arc['nodes'] if row['j']==5694)['reference_signs_hex'],16))[2:]
 rmask=bin(int(next(row for row in arc['nodes'] if row['j']==5696)['reference_signs_hex'],16))[2:]
 grey=[]
 for k in ng:
  l,m,r=lmask[k],ref[k],rmask[k]; c0=(l!=m)+(m!=r); c1=(l!=r)
  grey.append(dict(k=k,left=l,center=m,right=r,strict_count=c0,omit_count=int(c1),lost=c0-int(c1),delay=int(l!=m) if c1 else 0))
 (d/f'grey{p}.json').write_text(json.dumps(grey,indent=2))
 print('grey',p,len(grey),'bridge',sum(g['omit_count'] for g in grey),'lost',sum(g['lost'] for g in grey),'delay',sum(g['delay'] for g in grey),flush=True)
 stats.append(dict(p=p,n=n,strict=sum(x>0 for x in sign),fallback=sum(fallback),undecided=sign[1:].count(0),width_bytes=ring.width,cpu=time.process_time()-start,cases=cases))
 print(stats[-1],flush=True)
 (d/'even-full.json').write_text(json.dumps(stats,indent=2))
