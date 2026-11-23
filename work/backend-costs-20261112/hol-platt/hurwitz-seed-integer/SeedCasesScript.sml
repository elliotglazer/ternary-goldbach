Theory SeedCases
Ancestors SeedReplay
Libs cv_transLib seedbench

Definition rows_bad_def:
  rows_bad f c j keys ps bs es <=> ~SeedReplay$rows_ok f c j keys ps bs es
End
val _=cv_transLib.cv_auto_trans rows_bad_def;
structure replay=seedbench;
open seedbench;
val io=TextIO.openIn "cases.txt";
fun tok() = case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "missing case";
fun numenc s = let val n=nat s in EVAL(mk_comb(replay.enc_for(type_of n),n)) end;
fun enc name xs = replay.literal(replay.named name (listSyntax.mk_list(map nat xs,numSyntax.num)));
fun verify idx = let
  val st=cpu()
  val [id,f,c,j]=tok()
  val _=if Int.toString idx=id then () else raise Fail "unexpected case order"
  val keys=tok()
  val phases=tok()
  val bern=tok()
  val seeds=tok()
  val scalars=map numenc [f,c,j]
  val k=enc ("plan_"^id) keys
  val p=enc ("phase_"^id) phases
  val b=enc ("bernoulli_"^id) bern
  val e=enc ("expected_"^id) seeds
  val args=scalars@[k,p,b,e]
  val _=print("ADMISSION "^id^" "^Real.toString(cpu()-st)^"\n")
  fun run rep=let val t=cpu() val th=replay.joined ``SeedReplay$rows_ok`` args
      val _=if rep=1 then ignore(save_thm("all_seeds_"^id,th)) else ()
      in print("SEED_REPLAY "^id^" "^Int.toString rep^" "^Real.toString(cpu()-t)^"\n") end
  val _=List.app run [1,2,3]
  val _=if idx=1 then let
    val changed=IntInf.toString(valOf(IntInf.fromString(hd seeds)) + 2)
    val wrong=enc "altered_seed" (changed::tl seeds)
    val th=replay.joined ``rows_bad`` (scalars@[k,p,b,wrong])
    in ignore(save_thm("altered_seed_is_false",th)) end else ()
  in () end;
val _=List.app verify [1,2,3,4,5,6];
val _=TextIO.closeIn io;
val _=print "SEED_CASES_DONE\n";
