from pathlib import Path
d=Path(__file__).resolve().parent
s=(d/'AbsorbedPriceScript.sml').read_text().replace('Theory AbsorbedPrice','Theory EvenPrice').replace('Ancestors Absorbed JoinTables','Ancestors EvenTile JoinTables').replace('Absorbed$absrun','EvenTile$tile_top').replace('[sc,chk,mask]','[sc,chk,mask,bad]').replace('xs=il "xs"','xs=il "zs"').replace(' and taps=il "taps"','').replace('enc(integer chk),taps,enc(nat mask)','enc(integer chk),enc(replay.tuple[nat mask,nat bad])').replace('["fu24h1","fu24h2","fu28h1","fu28h2"]','["even24n64","even28n64","even24n256","even28n256","even24n1024","even28n1024"]')
s=s.replace('fun trial (n,m)= let','val size=if String.isSuffix "1024" t then 1024 else if String.isSuffix "256" t then 256 else 64\n     fun trial (q,m)= let val n=if q=1024 then 131072 div size else q')
(d/'EvenPriceScript.sml').write_bytes(s.encode())
p=d/'run.sh';p.write_bytes(p.read_bytes().replace(b'|PrimeSink|PrimePrice)',b'|PrimeSink|PrimePrice|EvenTile|EvenPrice)'))
