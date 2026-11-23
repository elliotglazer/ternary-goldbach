Theory NormalizedSeed
Ancestors SeedReplay
Libs cv_transLib seedbench

Definition normalized_rows_def:
  (normalized_rows radius quantum f a j bs m fac rows ([]:(num#num#num) list) =
     []:(int#int) list) /\
  (normalized_rows radius quantum f a j bs m fac rows ((n,l,cap)::rest) =
    let (head,boundary)=accumulate n rows (0,0);
        v=5*j;
        (tx,ty)=if l=0 then (0,0) else ending f (a+f* &n) m v l bs;
        (hx,hy)=if l=0 then head else em_add head (em_scale boundary tx ty grid);
        (cx,cy)=em_scale fac hx hy grid;
        out=(nearq cx quantum,nearq cy quantum);
        nf=em_scale fac (-radius*(64*m+32)) (-radius*v) (64*f*(m+1))
    in out::normalized_rows radius quantum f a j bs (m+1) nf (powers f a cap rows) rest)
End
val normalized_rows_pre_def=cv_auto_trans_pre "normalized_rows_pre" normalized_rows_def;
Theorem normalized_rows_pre_total[cv_pre]:
  !xs radius quantum f a j bs m fac rows.
     normalized_rows_pre radius quantum f a j bs m fac rows xs
Proof
  Induct >> simp[Once normalized_rows_pre_def,pairTheory.FORALL_PROD,ending_pre_total,division_pre]
QED

Definition normalized_ok_def:
  normalized_ok (f:num) c j (r:num) p keys ps bs es <=>
    r=64 /\ p < 384 /\ LENGTH keys = 3*(LENGTH es DIV 2) /\ EVEN (LENGTH es) /\
    normalized_rows (&r) ((2:int)**(384-p)) (&f) (&(f+c)) (&j) (ipairs bs) 0 (grid,0)
      (ipairs ps) (specifications keys) = ipairs es
End
Definition normalized_bad_def:
  normalized_bad f c j r p keys ps bs es <=> ~normalized_ok f c j r p keys ps bs es
End
val _=cv_auto_trans normalized_bad_def;

open seedbench;
val io=TextIO.openIn "normalized-cases.txt";
fun fields()=case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "missing normalized seed fixture";
fun scalar s=let val n=nat s in EVAL(mk_comb(enc_for(type_of n),n)) end;
fun vector name xs=literal(named name (listSyntax.mk_list(map nat xs,numSyntax.num)));
fun check band=let
  val start=cpu()
  val id::params=fields()
  val _=if id=Int.toString band andalso length params=5 then () else raise Fail "unexpected group"
  val k=vector ("plan_"^id) (fields())
  val ps=vector ("phases_"^id) (fields())
  val bs=vector ("weights_"^id) (fields())
  val es=fields()
  val expected=vector ("expected_"^id) es
  val common=map scalar params@[k,ps,bs]
  val _=print("ADMISSION "^id^" "^Real.toString(cpu()-start)^"\n")
  fun run rep=let val t=cpu() val th=joined ``normalized_ok`` (common@[expected])
      val _=if rep=1 then ignore(save_thm("all_normalized_"^id,th)) else ()
      in print("SEED_REPLAY "^id^" "^Int.toString rep^" "^Real.toString(cpu()-t)^"\n") end
  val _=List.app run [1,2,3]
  val _=if band=1 then let
    val changed=IntInf.toString(valOf(IntInf.fromString(hd es))+2)
    val wrong=vector "altered" (changed::tl es)
    in ignore(save_thm("altered_normalized_rejected",joined ``normalized_bad`` (common@[wrong]))) end else ()
  in () end;
val _=List.app check [1,2,3,4,5,6];
val _=TextIO.closeIn io;
val _=print "NORMALIZED_SEEDS_DONE\n";
