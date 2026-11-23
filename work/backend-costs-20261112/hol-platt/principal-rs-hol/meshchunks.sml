open HolKernel Parse boolLib bossLib cv_transLib RSKernelTheory RSBatchTheory;
open HolKernel Parse boolLib bossLib cv_transLib RSKernelTheory;
fun measure label tm =
 let val wall=Time.now() val clk=Timer.startCPUTimer() val th=cv_eval tm
     val {usr,sys}=Timer.checkCPUTimer clk val (o1,axs)=Tag.dest_tag(tag th)
     val _=if null(hyp th) andalso null axs andalso List.all(fn x=>x="DISK_THM") o1 andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) boolSyntax.T then () else raise Fail label
 in print(label ^ " cpu=" ^ Time.toString(Time.+(usr,sys)) ^ " wall=" ^ Time.toString(Time.-(Time.now(),wall)) ^ "\n");TextIO.flushOut TextIO.stdOut end;
val _=let val th=RSKernelTheory.rs_negative_sign val (ors,axs)=Tag.dest_tag(tag th)
 in if null(hyp th) andalso null axs andalso List.all(fn x=>x="DISK_THM") ors then print "SIGN_IMPLICATION_OK\n" else raise Fail "sign trust" end;

fun integer s=intSyntax.term_of_int(Arbint.fromString(String.translate(fn #"-"=>"~"|x=>String.str x)s));
fun tup[a,b,c]=pairSyntax.mk_pair(integer a,pairSyntax.mk_pair(integer b,integer c))|tup _=raise Fail "triple";
fun chunk name fields = let val io=TextIO.openIn(name^".tsv") val raw=TextIO.inputAll io val _=TextIO.closeIn io val rows=map(tup o String.tokens Char.isSpace)(String.tokens(fn c=>c= #"\n")raw) val tm=list_mk_comb(``mesh_run``,map integer fields@[listSyntax.mk_list(rows,type_of(hd rows))]) in measure name tm end;
val _=chunk "chunk0" ["102396199792","542960015631654208417176930328195143666602637171424","2189370540165051899616625404235511364199712","128"];
val _=chunk "chunk1" ["102396216176","542960108083667620141464848417169516278533338692221","2189370540165051899616625404235511364199712","128"];
val _=chunk "chunk2" ["102396232560","542960200535681923928523681583466966001962237442727","2189370540165051899616625404235511364199712","128"];
val _=chunk "chunk3" ["102396248944","542960292987697119778210694532308862830684849481167","2189370540165051899616625404235511364199712","128"];
val _=print "RS_DONE\n";
