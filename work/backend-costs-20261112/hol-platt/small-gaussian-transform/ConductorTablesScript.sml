Theory ConductorTables
Ancestors Matched
Libs intLib cv_transLib meter

open meter;
val _=intLib.ARITH_TAC;
val ins=TextIO.openIn "matched.txt";
val _=valOf(TextIO.inputLine ins);
fun named name count = let
  val xs=pairs(String.tokens Char.isSpace(valOf(TextIO.inputLine ins)))
  val value=vector xs
  val _=if length xs=count then () else raise Fail name
  val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of value),value))
  val from_to=cv_typeLib.from_to_thm_for(type_of value)
  val [enc,_]= #2(strip_comb(concl from_to))
  val start=cpu()
  val result=TRANS (AP_TERM enc def) (EVAL(mk_comb(enc,value)))
  val _=if closed result then () else raise Fail "root encoding"
  val _=save_thm(name^"_encoding",result)
in print("TABLE "^name^" "^Real.toString(cpu()-start)^"\n") end;
val _=named "c10000_roots" 512;
val _=named "c10000_chirps" 500;
val _=named "c10000_kernel" 1024;
val _=TextIO.closeIn ins;
val _=print "NAMED_TABLES_DONE\n";
