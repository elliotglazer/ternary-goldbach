from pathlib import Path
d=Path(__file__).resolve().parent
s=(d/'EvenPriceScript.sml').read_text().replace('Theory EvenPrice','Theory MassPrice').replace('Ancestors EvenTile JoinTables','Ancestors MassSink JoinTables').replace('EvenTile$tile_top','MassSink$massloop').replace('[sc,chk,mask,bad]','[sc,mass,chk]').replace('il "zs"','il "xs"').replace(' and cs=il "abs"','').replace('xs,ws,cs,enc(integer chk),enc(replay.tuple[nat mask,nat bad])','xs,ws,enc(integer mass),enc(integer chk)').replace('"even','"mass')
(d/'MassPriceScript.sml').write_bytes(s.encode())
p=d/'run.sh';p.write_bytes(p.read_bytes().replace(b'|GreyStream)',b'|GreyStream|MassSink|MassPrice)'))
