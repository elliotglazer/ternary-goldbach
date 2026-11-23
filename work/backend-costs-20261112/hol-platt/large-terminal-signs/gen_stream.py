from pathlib import Path
d=Path(__file__).resolve().parent
old=(d/'FusedPriceScript.sml').read_text().split('fun localrun')[0]
new=old.replace('Theory FusedPrice','Theory StreamPrice').replace('Ancestors Fused JoinTables','Ancestors StreamCost JoinTables')
new+="""
fun do_stream (name,bas,up,len)=
 let val rs=map replay.tuple(replay.lines(map nat)(name^"count.txt"))
     val data=replay.literal(replay.named(name^"_rows")(listSyntax.mk_list(rs,type_of(hd rs))))
     fun cv n=enc(nat(Int.toString n))
     fun run n=let val _=print("STREAM "^name^" "^Int.toString n^"\\n")
        val th=joined ``StreamCost$streamrun`` [cv n,cv (4096*bas),cv (4096*up),cv len,data]
       in if n=1 then ignore(save_thm(name^"_counts",th)) else () end
 in List.app run [1,0,8,8,0] end;
val _=List.app do_stream [("low",1,33,32),("high",84184,84200,16)];
"""
(d/'StreamPriceScript.sml').write_bytes(new.encode())
p=d/'run.sh';p.write_bytes(p.read_bytes().replace(b'Absorbed|AbsorbedPrice)',b'Absorbed|AbsorbedPrice|StreamCost|StreamPrice)'))
