from pathlib import Path
d=Path(__file__).resolve().parent
s=(d/'even_full.py').read_text().replace('def save(f,rows):f.write_text','def save(f,rows):return; f.write_text').replace("f'grey{p}.json'","f'grey-cap{p}.json'").replace("'even-full.json'","'even-cap-full.json'")
s=s.replace(' out=[];cfg=[];',""" cap=(1 << max(abs(z) for x in xs for z in x).bit_length())
 assert all(max(abs(t),abs(b))<=2*cap+1 for t,b in aa)
 er=n*((2*S+2)*(3+(2*cap+2+S-1)//S)+4*cap+2)
 print('cap units',cap//S,'native maximum per component',max(abs(z) for x in xs for z in x)/S)
 out=[];cfg=[];""")
exec(s)
