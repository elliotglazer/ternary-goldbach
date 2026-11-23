structure short = struct
open HolKernel Parse boolLib bossLib cv_transLib meter;
fun line ins=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun count s=valOf(Int.fromString s);
fun ints ss=listSyntax.mk_list(map integer ss,``:int``);
fun matrix xs=listSyntax.mk_list(xs,``:int list``);
fun named n x=new_definition(n^"_def",mk_eq(mk_var(n,type_of x),x));
fun encode n def=let
 val start=cpu()
 val [enc,_]= #2(strip_comb(concl(cv_typeLib.from_to_thm_for(type_of(lhs(concl def))))))
 val th=TRANS(AP_TERM enc def)(EVAL(mk_comb(enc,rhs(concl def))))
 val _=if closed th then () else raise Fail n
 val _=print("CONVERT "^n^" "^Real.toString(cpu()-start)^"\n")
 in (lhs(concl def),REWR_CONV th) end;
fun prove n f args defs=let
 val t=cpu()
 val lifted=List.foldl(fn(x,z)=>MK_COMB(z,x))(REFL f)defs
 val tm=rhs(concl lifted)
 val decoded=TRANS lifted (cv_transLib.cv_eval tm)
 val _=print("KERNEL_WITH_ENCODING "^n^" "^Real.toString(cpu()-t)^"\n")
 val _=if closed decoded andalso aconv(rhs(concl decoded))boolSyntax.T then () else raise Fail n
 in save_thm(n,EQT_ELIM decoded) end;
fun run batched=let
 val start=cpu()
 val ins=TextIO.openIn "short.txt"
 val [d,wd,nk,nr]=line ins
 val keys=List.tabulate(count nk,fn _=>line ins)
 val data=List.tabulate(count nr,fn _=>let val a=line ins in a@line ins end)
 val _=TextIO.closeIn ins
 val _=print("READ "^Real.toString(cpu()-start)^"\n")
 val t=cpu()
 val kt=matrix(map ints keys)
 val rts=map ints data
 val _=print("TERMS "^Real.toString(cpu()-t)^"\n")
 val kd=named "kernels" kt
 val (k,kc)=encode "kernels" kd
 val predicate=mk_comb(``ShortKernel$weights``,integer wd)
 val weightproof=TRANS(AP_TERM predicate kd)(cv_transLib.cv_eval(mk_comb(predicate,kt)))
 val _=print("WEIGHT_RESULT "^String.substring(term_to_string(rhs(concl weightproof)),0,Int.min(180,size(term_to_string(rhs(concl weightproof)))))^"\n")
 val _=if closed weightproof andalso aconv(rhs(concl weightproof))boolSyntax.T then save_thm("weights_exact",EQT_ELIM weightproof) else raise Fail "weights"
 fun check (i,rows)=let
   val n="source_"^Int.toString i
   val rd=named n (matrix rows)
   in prove ("checked_"^Int.toString i) ``ShortKernel$short_all`` [] [REFL(integer d),REFL(integer wd),kd,rd] end
 val _=if batched then [check(0,rts)] else ListPair.map(fn(i,row)=>check(i,[row]))(List.tabulate(length rts,fn i=>i),rts)
 in print("STRICT_ACTUAL_ROWS "^Int.toString(length rts)^"\n") end;
end;
