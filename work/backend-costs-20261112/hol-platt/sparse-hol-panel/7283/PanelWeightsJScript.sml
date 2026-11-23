Theory PanelWeightsJ
Ancestors SparseHead
Libs replay meter cv_transLib intLib
open meter;
val ins=TextIO.openIn "PanelWeightsJ.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun tuple [v]=v | tuple(v::vs)=pairSyntax.mk_pair(v,tuple vs) | tuple []=raise Fail "tuple";
fun note s=(print(s^"\n");TextIO.flushOut TextIO.stdOut);
val radii=ref ([]:((string*string)*thm)list);
fun radius r e=case List.find(fn ((s,f),_)=>s=r andalso e=f)(!radii) of SOME(_,t)=>t | NONE=>let val term=list_mk_comb(``SparseHead$panel_radius``,[nat r,nat e]) val t=EQT_ELIM(cv_transLib.cv_eval term) in radii:=((r,e),t)::(!radii); t end;
fun reading i =
 let val [k,r,o1,d,e]=line()
     val _=note("START "^k)
     val w=listSyntax.mk_list(map integer(line()),``:int``)
     val kd=new_definition("w_"^k^"_def",mk_eq(mk_var("w_"^k,type_of w),w))
     fun enc x=EVAL(mk_comb(replay.enc_for(type_of x),x))
     val _=note("ENCODING "^k)
     val we=replay.literal kd
     val _=note("CHECK "^k)
     val cert=replay.joined (KernelWeightsTheory.kernel_ok_def |> concl |> strip_forall |> #2 |> lhs |> strip_comb |> #1)
                [enc(nat r),enc(nat o1),enc(integer d),we]
     val _=note("BASIS "^k)
     val er=radius r e
     val _=note("KERNEL "^k)
     val _=save_thm("basis_"^k,cert)
     val _=save_thm("radius_"^k,er)
 in () end;
val _=List.tabulate(valOf(Int.fromString(hd(line()))),reading);
val _=TextIO.closeIn ins;
