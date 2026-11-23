from pathlib import Path
d=Path(__file__).resolve().parent
p=d/'even_full.py';s=p.read_text().replace("stats.append(dict(p=p,n=n,strict=", """ng=[k for k in range(1,n) if sign[k]==0]
 lmask=bin(int(next(row for row in arc['nodes'] if row['j']==5694)['reference_signs_hex'],16))[2:]
 rmask=bin(int(next(row for row in arc['nodes'] if row['j']==5696)['reference_signs_hex'],16))[2:]
 grey=[]
 for k in ng:
  l,m,r=lmask[k],ref[k],rmask[k]; c0=(l!=m)+(m!=r); c1=(l!=r)
  grey.append(dict(k=k,left=l,center=m,right=r,strict_count=c0,omit_count=int(c1),lost=c0-int(c1),delay=int(l!=m) if c1 else 0))
 (d/f'grey{p}.json').write_text(json.dumps(grey,indent=2))
 print('grey',p,len(grey),'bridge',sum(g['omit_count'] for g in grey),'lost',sum(g['lost'] for g in grey),'delay',sum(g['delay'] for g in grey),flush=True)
 stats.append(dict(p=p,n=n,strict=""")
p.write_bytes(s.encode())
