from pathlib import Path
import sys
out=Path(__file__).resolve().parent/sys.argv[1]
s=(out.parent/"diagnostic.sml").read_text()
data=(out/"kernels.txt").read_text().splitlines()
N=int(data[0])
chunk=5
names=[]
for start in range(0,N,chunk):
    name="PanelWeights"+chr(65+start//chunk)
    names.append(name)
    rows=data[1+2*start:1+2*min(start+chunk,N)]
    (out/(name+".txt")).write_text(str(len(rows)//2)+"\n"+"\n".join(rows)+"\n")
    t=s[:s.index("val rows=")].replace("Theory PanelTables","Theory "+name).replace("SparseHead JoinTables","SparseHead").replace("kernels.txt",name+".txt")
    t=t.replace('val args=map nat[r,o1,d,e]','val _=save_thm("basis_"^k,cert)\n     val _=save_thm("radius_"^k,er)')
    t=t.replace("in (tuple(args@[lhs(concl kd)]),tuple(args@[w]),kd,cert,er) end;","in () end;")
    t+="val _=List.tabulate(valOf(Int.fromString(hd(line()))),reading);\nval _=TextIO.closeIn ins;\n"
    (out/(name+"Script.sml")).write_text(t)
head=s[:s.index("fun note")].replace("SparseHead JoinTables","SparseHead "+" ".join(names))
head+='''
fun reading i =
 let val [k,r,o1,d,e]=line() val _=line()
     val name=List.nth(NAMES,i div CHUNK)
     val kd=DB.fetch name ("w_"^k^"_def")
     val cert=DB.fetch name ("basis_"^k)
     val er=DB.fetch name ("radius_"^k)
     val args=map nat[r,o1,d,e]
 in (tuple(args@[lhs(concl kd)]),tuple(args@[rhs(concl kd)]),kd,cert,er) end;
'''.replace("NAMES","["+",".join('"'+n+'"' for n in names)+"]").replace("CHUNK",str(chunk))
head+=s[s.index("val rows="):].replace('val _=note "BUILT";','').replace('val _=note "VALID";','').replace('val _=note "ENCODING";','')
(out/"PanelTablesScript.sml").write_text(head)
(out/"targets.txt").write_text("\n".join(names+["PanelTables","HeadPairEven","HeadPairOdd"])+"\n")
sh=(out/"run.sh").read_text().replace("PanelTables|SparseHead|","PanelWeights[A-Z]|PanelTables|SparseHead|")
(out/"run.sh").write_bytes(sh.encode())
