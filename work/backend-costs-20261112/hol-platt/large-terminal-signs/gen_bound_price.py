from pathlib import Path
d=Path(__file__).resolve().parent
s=(d/'check_uniform.py').read_text().split('results={}')[0]
exec(s)
src=src.replace('def save(p,rows):return; p.write_text','def save(p,rows):p.write_text').replace("t=f'fu{p}h{h}'","t=f'bound{p}h{h}'").replace('arr_abs.append([a,bb,f,g,e,unc])','arr_abs.append([a,bb,f,g,post,unc])')
column=20;exec(src)
theory=(d/'AbsorbedPriceScript.sml').read_text().replace('Theory AbsorbedPrice','Theory BoundPrice').replace('"fu','"bound').replace('Absorbed$absrun','Absorbed$absrun')
(d/'BoundPriceScript.sml').write_bytes(theory.encode())
r=d/'run.sh';r.write_bytes(r.read_bytes().replace(b'|StreamCost|StreamPrice)',b'|StreamCost|StreamPrice|BoundPrice)'))
