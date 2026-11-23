Theory Q10004All
Ancestors Q10004Window integer list arithmetic
Libs meter encoding cv_transLib intLib
open meter;
Definition cut_def:
  (cut (n:num) (m:num) ([]:int list) = []) /\
  (cut n m (x::xs) =
    if n<>0 then cut (n-1) m xs else if m=0 then [] else x::cut 0 (m-1) xs)
End
Definition slice_def:
  (slice j ([]:(num#int list) list) = []) /\
  (slice j ((a,xs)::rest) = if a<=j /\ j+192<=a+LENGTH xs then cut (j-a) 192 xs else slice j rest)
End
Definition weights_for_def:
  (weights_for k ([]:(num#int list) list) = []) /\
  (weights_for k ((a,xs)::rest) = if k=a then xs else weights_for k rest)
End
Definition all_jobs_def:
  (all_jobs radi err tab ks runs ([]:num list list) <=> T) /\
  (all_jobs radi err tab ks runs (row::rest) <=>
    (case row of [region;first;tick;off;word;b;i;c;k;d;m] =>
       let z=window first tick off radi err word (slice first tab) (weights_for off ks)
       in region=0 /\ z<>0 /\ z=at_three runs (first+95) tick b i c k d m
     | _ => F) /\ all_jobs radi err tab ks runs rest)
End
val _=cv_auto_trans all_jobs_def;
fun line ins=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun count s=valOf(Int.fromString s);
fun ints xs=listSyntax.mk_list(map integer xs,``:int``);
fun nums xs=listSyntax.mk_list(map nat xs,``:num``);
fun keyed (k::xs)=pairSyntax.mk_pair(nat k,ints xs) | keyed _=raise Fail "input";
fun table ls=listSyntax.mk_list(map keyed ls,``:num#int list``);
fun rows n ins=List.tabulate(n,fn _=>line ins);
fun endfile ins=if Option.isSome(TextIO.inputLine ins) then raise Fail "unread" else TextIO.closeIn ins;
fun encode label def=
 let val t=cpu()
     val [enc,_]= #2(strip_comb(concl(cv_typeLib.from_to_thm_for(type_of(lhs(concl def))))))
     val th=TRANS(AP_TERM enc def)(EVAL(mk_comb(enc,rhs(concl def))))
     val _=if closed th then () else raise Fail label
     val _=print("INPUT_CONVERT "^label^" "^Real.toString(cpu()-t)^"\n")
 in (lhs(concl def),REWR_CONV th) end;
fun named label x=encode label (new_definition(label^"_def",mk_eq(mk_var(label,type_of x),x)));
val kt=cpu();
val ki=TextIO.openIn "all-kernels.txt";
val keys=rows(count(hd(line ki)))ki;
val _=endfile ki;
val _=print("SOURCE_LOAD kernels "^Real.toString(cpu()-kt)^"\n");
val k0=cpu();
val kterm=table keys;
val _=print("INPUT_TERMS kernels "^Real.toString(cpu()-k0)^"\n");
val kernels=named "shared_kernels" kterm;
fun check (label,packet) =
 let val t=cpu()
     val ins=TextIO.openIn ("all-"^label^".txt")
     val [actual,r,e,spanCount,jobCount]=line ins
     val _=if actual=label then () else raise Fail "channel"
     val spans=rows(count spanCount)ins
     val jobs=rows(count jobCount)ins
     val _=endfile ins
     val _=print("SOURCE_LOAD "^label^" "^Real.toString(cpu()-t)^"\n")
     val t1=cpu()
     val st=table spans
     val jt=listSyntax.mk_list(map nums jobs,``:num list``)
     val _=print("INPUT_TERMS "^label^" "^Real.toString(cpu()-t1)^"\n")
     val sf=named ("grid_spans_"^label) st
     val jf=named ("probe_list_"^label) jt
     val pf=encode ("packet_"^label) (DB.fetch "Q10004Receipt" (packet^"_def"))
     val paired=[sf,kernels,pf,jf]
     val f=``Q10004All$all_jobs``
     val args=[integer r,integer e]@map #1 paired
     val th=encoding.produce ("all_"^label) f args ([EVAL,EVAL]@map #2 paired)
     val inv=cv_typeLib.from_to_thm_for ``:bool``
     val [_,decoder]= #2(strip_comb(concl inv))
     val decoded=TRANS(SYM(SPEC(list_mk_comb(f,args))(REWRITE_RULE[cv_typeTheory.from_to_def]inv)))
                    (CONV_RULE(RAND_CONV EVAL)(AP_TERM decoder th))
     val _=if closed decoded andalso aconv(rhs(concl decoded))boolSyntax.T then () else raise Fail label
     val _=save_thm("all_interior_repair_bits_"^label,EQT_ELIM decoded)
 in print("ACCEPTED_ALL "^label^" "^jobCount^"\n") end;
val _=app check [("6559","runs_100"),("7707","runs_110"),("5499","runs_300"),("7659","runs_310")];
