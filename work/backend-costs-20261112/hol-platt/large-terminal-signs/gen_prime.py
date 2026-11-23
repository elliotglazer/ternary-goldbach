from pathlib import Path
from flint import arb,acb,ctx
import csv,math,json
d=Path(__file__).resolve().parent
ctx.prec=160
f=d.parent/'large-sector-second/axis257-grid28.tsv'
data=[{k:int(v) for k,v in r.items()} for r in csv.DictReader(f.open(),delimiter='\t')]
assert len(data)==257 and all(row['a']==j and row['k']==7+510*j for j,row in enumerate(data))
def save(f,rows):f.write_text(''.join(' '.join(map(str,r))+'\n' for r in rows))
for p in [24,28]:
 S=2**p;D=2**(28-p);rd=lambda x:(x+D//2)//D
 v=[(rd(r['pre_re']),rd(r['pre_im'])) for r in data]; ws=[]
 for j in range(257):
  theta=2*math.pi*((129*j*j)%257)/257;u=round(S*math.cos(theta));w=round(S*math.sin(theta))
  z=acb(0,2*arb.pi()*((129*j*j)%257)/257).exp()
  assert abs(S*z.real-u)<1 and abs(S*z.imag-w)<1;ws.append((u,w))
 def rot(z,w,s):
  x,y=z;u,v=w;return ((x*u-y*v+s//2)//s,(x*v+y*u+s//2)//s)
 aa=[rot(z,w,S) for z,w in zip(v,ws)]
 # preinput intervals are rounded at p28 within 1 unit; p24 rerounding gives <=1 at p24.
 E=sum((2*S+2)*(3+(abs(x)+abs(y)+2+S-1)//S)+abs(t)+abs(b) for (x,y),(t,b) in zip(v,aa))
 out=[]; cfg=[]; mask=0; miss=0;unc=0
 for k,(row,w) in enumerate(zip(data,ws)):
  R=I=0
  for j,(x,y) in enumerate(aa):
   u,b=ws[(k-j)%257];R+=x*u+y*b;I+=y*u-x*b
  r,i=rot((R,I),w,S*S);out.append((r,i))
  rawp,rawq,F,G=[rd(row[n]) for n in ['p','q','f','g']]
  a,b=rot((rawp,rawq),w,S);u,t=w
  ep=(abs(rawp)+abs(rawq)+abs(u)+abs(t)+2+S-1)//S+1
  pf=(a>0)==(F>0);qg=(b>0)==(G>0)
  val,ori=(R,pf) if pf!=qg else (I,(a>0)!=(G>0))
  ok=min(abs(a),abs(b))>ep and min(abs(F),abs(G))>1 and abs(val)>E
  e=(2*S*E+abs(R)+abs(I)+2*E+S*S-1)//(S*S)+1
  assert max(abs(r*D-row['ref_re']),abs(i*D-row['ref_im']))+1<=e*D
  if ok: pos=(val>0)==ori
  else:
   miss+=1
   A=rawp*F-rawq*G;B=rawp*G+rawq*F;score=A*r-B*i
   er=(abs(A)+abs(B))*e+(abs(rawp)+abs(rawq)+abs(F)+abs(G)+2)*(abs(r)+abs(i)+2*e)
   if abs(score)<=er:unc+=1
   pos=score>0
  assert pos==(row['sign']>0)
  mask+=int(pos)<<k; cfg.append([rawp,rawq,F,G,e,E])
 print(p,miss,unc)
 assert unc==0
 name='prime'+str(p)
 for suffix,arr in [('xs',v),('ws',ws),('abs',cfg),('taps',[out[j] for j in [0,1,128,256]]),('cfg',[[S,sum(r+3*i for r,i in out)%65537,mask]])]:save(d/(name+suffix+'.txt'),arr)
q=(d/'AbsorbedScript.sml').read_text();fused=(d/'FusedScript.sml').read_text()
raw=fused.split('Definition rawpairs_def:')[1].split('Definition coords_def:')[0].replace('rawpairs sc','primepairs sc').replace('kt_pack 6','kt_pack 9')
old=fused.split('Definition old_def:')[1].split('Definition passes_def:')[0].replace('old sc','primeold sc').replace('lp_pick 30','lp_pick 128').replace('lp_pick 59','lp_pick 256')
tail=q.split('Definition batch_def:')[1].replace('Fused$rawpairs','primepairs').replace('Fused$old','primeold').replace('collect (sc*sc) (DROP 1 zs) (DROP 1 ws)','Absorbed$collect (sc*sc) zs ws').replace('cache sc phases (DROP 1 ws)','Absorbed$cache sc phases ws').replace('batch','primebatch').replace('B**60','B**257').replace('kt_powers 6','kt_powers 9').replace('kt_pack 6','kt_pack 9').replace('absrun','primerun')
(d/'PrimeSinkScript.sml').write_bytes(('Theory PrimeSink\nAncestors Absorbed\nLibs cv_transLib intLib\nDefinition primepairs_def:'+raw+'Definition primeold_def:'+old+'Definition primebatch_def:'+tail).encode())
s=(d/'AbsorbedPriceScript.sml').read_text().replace('Theory AbsorbedPrice','Theory PrimePrice').replace('Ancestors Absorbed JoinTables','Ancestors PrimeSink JoinTables').replace('Absorbed$absrun','PrimeSink$primerun').replace('["fu24h1","fu24h2","fu28h1","fu28h2"]','["prime24","prime28"]').replace('1024,','256,')
(d/'PrimePriceScript.sml').write_bytes(s.encode())
r=d/'run.sh';r.write_bytes(r.read_bytes().replace(b'|BoundPrice)',b'|BoundPrice|PrimeSink|PrimePrice)'))
