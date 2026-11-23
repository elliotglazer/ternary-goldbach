from pathlib import Path
d=Path(__file__).resolve().parent
s=(d/'even_full.py').read_text().replace('def save(f,rows):f.write_text','def save(f,rows):return; f.write_text').replace("f'grey{p}.json'","f'grey-mass{p}.json'").replace("'even-full.json'","'even-mass-full.json'")
s=s.replace(' out=[];cfg=[];',""" mass=sum(abs(x)+abs(y) for x,y in xs)
 er=(2*S+2)*(4*n+(mass+2*n+S-1)//S)+2*mass+2*n
 print('mass units mean',mass/(n*S))
 for start0,size in [(1,64),(n//2-128,256),(n-1024,1024)]:
  sl=slice(start0,start0+size);label='mass'+str(p)+'n'+str(size)
  for nm,rows in [('xs',xs[sl]),('ws',ws[sl]),('cfg',[[S,sum(abs(x)+abs(y) for x,y in xs[sl]),sum(x+3*y for x,y in aa[sl])%65537]])]:
   (d/(label+nm+'.txt')).write_text(''.join(' '.join(map(str,row))+'\\n' for row in rows))
 out=[];cfg=[];""")
exec(s)
