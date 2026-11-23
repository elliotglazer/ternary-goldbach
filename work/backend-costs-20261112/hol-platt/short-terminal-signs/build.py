from pathlib import Path
p=Path(__file__).resolve().parent
s=(p.parent/"short-axis/ShortBenchScript.sml").read_text()
stage=s[s.index("val encoded"):s.index("fun one id")].replace('ShortAxis$loop','ShortSink$ss_loop')
head=s[:s.index('fun readRow')].replace("Theory ShortBench","Theory SinkBench").replace("Ancestors ShortAxis","Ancestors ShortSink")
tail="""
val fIn=TextIO.openIn "factors.txt";
fun getf ()=vector(pairs(String.tokens Char.isSpace(valOf(TextIO.inputLine fIn))));
val fs=getf(); val gs=getf();
fun nat v=numSyntax.mk_numeral(Arbnum.fromString v);
fun br [x,y,p,q,a,e]=pairSyntax.list_mk_pair [integer x,integer y,integer p,integer q,nat a,integer e]
  | br _=raise Fail "row";
fun panel id=let val [n,q,m,good,bad]=line()
 val out=pairSyntax.mk_pair(nat good,nat bad)
 val rows=listSyntax.mk_list(List.tabulate(valOf(Int.fromString m),fn _=>br(line())),``:int # int # int # int # num # int``)
 val _=encoded:=[]
 val reps=if valOf(Int.fromString m)<12 then 128 else 32
 fun trial mode ans=stage id ("s"^Int.toString mode) [nu reps,nu mode,fs,gs,rows,ans] T
 val ctr=trial 0 out; val quick=trial 1 out; val full=trial 2 out
 val _=stage id "damage" [nu 1,nu 1,fs,gs,rows,pairSyntax.mk_pair(nat good,nat "1")] F 0
 in List.app(fn j=>if j mod 2=0 then (ctr j;quick j;full j) else (full j;quick j;ctr j)) [0,1,2,3,4] end;
val _=List.app panel (List.tabulate(13,fn j=>j));
val _=print "SINK_DONE\\n";
"""
for name,body in [("SinkBenchScript.sml",head+stage+tail),("Holmakefile",(p.parent/"short-axis/Holmakefile").read_text())]:
 (p/name).write_bytes(body.encode())
sh=(p.parent/"short-axis/run.sh").read_text().replace("ShortAxis|ShortBench","ShortSink|SinkBench").replace("ShortAxisScript","ShortSinkScript").replace("ShortBench","SinkBench").replace("plan.json","fixtures.json").replace("real.txt real-inputs.json","factors.txt").replace("SHORT_DONE","SINK_DONE")
(p/"run.sh").write_bytes(sh.encode())
