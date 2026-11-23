Theory PanelTables
Ancestors SparseHead JoinTables
Libs meter cv_transLib intLib
open meter;
val ins=TextIO.openIn "kernels.txt";
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
     val term=list_mk_comb(``KernelWeights$kernel_ok``,[nat r,nat o1,integer d,w])
     val _=note("CHECK "^k) 
     val t=cv_transLib.cv_eval term
     val cert=EQT_ELIM(TRANS(AP_TERM(rator term)kd)t)
     val _=note("BASIS "^k)
     val er=radius r e
     val _=note("KERNEL "^k)
     val args=map nat[r,o1,d,e]
 in (tuple(args@[lhs(concl kd)]),tuple(args@[w]),kd,cert,er) end;
val rows=List.tabulate(valOf(Int.fromString(hd(line()))),reading);
val _=TextIO.closeIn ins;
val ty=``:(num#num#num#num#int list)``;
val tab=listSyntax.mk_list(map #1 rows,ty);
val def=new_definition("tables_def",mk_eq(mk_var("tables",type_of tab),tab));
val _=note "BUILT";
val facts=List.concat(map(fn(_,_,_,t,r)=>[t,r]) rows);
val ok=prove(mk_comb(``SparseHead$panel_valid``,lhs(concl def)),
             PURE_REWRITE_TAC (def::SparseHeadTheory.panel_valid_def::AND_CLAUSES::facts));
val _=if closed ok then save_thm("tables_valid",ok) else raise Fail "validity tag";
val _=note "VALID";
val literal=CONV_RULE(RAND_CONV(PURE_REWRITE_CONV(map #3 rows))) def;
val _=if aconv(rhs(concl literal))(listSyntax.mk_list(map #2 rows,ty)) then () else raise Fail "kernels";
val [enc,_]= #2(strip_comb(concl(cv_typeLib.from_to_thm_for(type_of tab))));
val t=cpu();
val _=note "ENCODING";
val coded=TRANS(AP_TERM enc literal)(EVAL(mk_comb(enc,rhs(concl literal))));
fun check tm =
  if cvSyntax.is_cv_num tm andalso can numSyntax.dest_numeral(rand tm) then ()
  else if cvSyntax.is_cv_pair tm then List.app check (#2(strip_comb tm))
  else raise Fail ("coefficient encoding " ^ String.substring(term_to_string tm,0,Int.min(180,size(term_to_string tm))));
val _=check(rhs(concl coded));
val _=if closed coded then save_thm("tables_encoded",coded) else raise Fail "code";
val _=print("TABLE_SETUP "^Real.toString(cpu()-t)^"\n");
val _=print "JOIN_TABLES_DONE\n";



