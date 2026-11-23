Theory PanelFast
Ancestors PanelKernel
Libs short intReduce intLib
open meter;
val time0=cpu();
val ins=TextIO.openIn "../../../backend-costs-20261112/hol-platt/guard-repricing/strip-repair-packets-stress.tsv";
fun read acc=case TextIO.inputLine ins of NONE=>rev acc | SOME s=>read(String.tokens Char.isSpace s::acc);
val rows=read [];
val _=TextIO.closeIn ins;
val _=if length rows=270 then () else raise Fail "input count";
val _=print("READ "^Real.toString(cpu()-time0)^"\n");
val tm0=cpu();
val tm=short.matrix(map short.ints rows);
val def=short.named "panel_source" tm;
val _=print("TERMS "^Real.toString(cpu()-tm0)^"\n");
val f=``PanelKernel$panels``;
val _=print("CV_SCHEMA "^thm_to_string PanelKernelTheory.cv_panels_thm^"\n");
val _=print("SELECTED "^thm_to_string(cv_repLib.cv_rep_for [] (mk_comb(f,mk_var("arg",type_of tm))))^"\n");
val start=cpu();
val templ=PanelKernelTheory.cv_panels_thm;
val eq=INST[hd(free_vars(concl templ)) |-> tm]templ;
val numeric=computeLib.CBV_CONV(intReduce.add_int_compset(computeLib.copy(computeLib.the_compset())));
val enc=CONV_RULE(RAND_CONV(RAND_CONV numeric))eq;
val body=rhs(concl enc);
val _=print("CONVERT_SOURCE "^Real.toString(cpu()-start)^"\n");
val bad=find_terms(fn x=> is_comb x andalso is_const(rator x) andalso fst(dest_const(rator x))="COND")body;
val _=case bad of []=>()|h::_=>print("ENCODING_CONDITIONAL "^term_to_string(rand h)^"\n");
val beginCheck=cpu();
val reduction=cv_computeLib.cv_compute(cv_eqs_for(mk_comb(rator body,mk_var("x",type_of(rand body)))))body;
val raw=TRANS enc reduction;
val inv=cv_typeLib.from_to_thm_for ``:bool``;
val [_,decoder]= #2(strip_comb(concl inv));
val evalth=TRANS(SYM(SPEC(mk_comb(f,tm))(REWRITE_RULE[cv_typeTheory.from_to_def]inv)))
                (CONV_RULE(RAND_CONV EVAL)(AP_TERM decoder raw));
val _=print("PURE_KERNEL "^Real.toString(cpu()-beginCheck)^"\n");
val namedth=TRANS(AP_TERM f def)evalth;
val _=if closed namedth andalso aconv(rhs(concl namedth))boolSyntax.T then save_thm("all270",EQT_ELIM namedth) else raise Fail "panel";
