open HolKernel Parse boolLib bossLib cv_transLib RSKernelTheory RSBatchTheory;
fun measure label tm =
 let val wall=Time.now() val clk=Timer.startCPUTimer() val th=cv_eval tm
     val {usr,sys}=Timer.checkCPUTimer clk val (o1,axs)=Tag.dest_tag(tag th)
     val _=if null(hyp th) andalso null axs andalso List.all(fn x=>x="DISK_THM") o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail label
 in print(label ^ " cpu=" ^ Time.toString(Time.+(usr,sys)) ^ " wall=" ^ Time.toString(Time.-(Time.now(),wall)) ^ "\n");TextIO.flushOut TextIO.stdOut end;
val _=let val th=RSKernelTheory.rs_negative_sign val (ors,axs)=Tag.dest_tag(tag th)
 in if null(hyp th) andalso null axs andalso List.all(fn x=>x="DISK_THM") ors then print "SIGN_IMPLICATION_OK\n" else raise Fail "sign trust" end;

fun integer s=intSyntax.term_of_int (Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));
fun tup [a,b,c]=pairSyntax.mk_pair(integer a,pairSyntax.mk_pair(integer b,integer c))
 | tup _=raise Fail "triple";
val start=Timer.startCPUTimer();
val inp=TextIO.openIn "compact-input.tsv";
val raw=TextIO.inputAll inp;
val _=TextIO.closeIn inp;
val rows=map (tup o String.tokens Char.isSpace) (String.tokens(fn c=>c= #"\n")raw);
val fields=map integer ["102396199792","542960015631654208417176930328195143666602637171424","2189370540165051899616625404235511364199712","128"];
fun term rs=list_mk_comb(``mesh_run``,fields@[listSyntax.mk_list(rs,type_of(hd rs))]);
val t512=term rows;
val _=print("CONSTRUCT_CPU="^Time.toString(#usr(Timer.checkCPUTimer start))^"\n");
val _=measure "mesh512" t512;
val bad=List.take(rows,511)@[tup ["542960384717431828546174174876439050285959564747897","2279286491913432027028357231357138904","-170269170513414093735383124703676628856"]];
val _=measure "wrong512" (boolSyntax.mk_neg(term bad));
val _=print "RS_DONE\n";
