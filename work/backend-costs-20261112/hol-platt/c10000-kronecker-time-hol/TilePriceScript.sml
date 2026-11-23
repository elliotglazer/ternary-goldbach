Theory TilePrice
Ancestors integer cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;
Definition tp_mod_def:
  tp_mod (z:int) d = if d=0 then 0 else z % d
End
Definition tp_repeat_def:
  (tp_repeat 0 (x:int) (y:int) acc = acc) /\
  (tp_repeat (SUC n) x y acc =
    tp_repeat n x y (acc + tp_mod ((x + &n)*y) 65537))
End
Definition tp_div_def:
  tp_div (a:num) b = if b=0 then 0 else a DIV b
End
Definition tp_price_def:
  tp_price (bytes:num) reps =
    let scale = tp_div ((2 ** (8*bytes))-1) ((2**1024)-1);
        x = ~((&98753392035497957238045883833053298792998487978658062635963710982068997989265642649048293608650431277815057833534490802303948752726491699635874994738209466192083839744816271864122278169030599230943895978734130876461521055640642517351191592550473423985371239259322015207591812907044216022941477462837268061227) * &scale):int; y = (&129930262790426085256655451304790484301429114693978167402067830997720249255579402694009926307739324620870436999147589743551987226952776921240824006684186199649162300452153415514399668584975521387177543789654667759391055820655000325880032283957659118885996985191222856042316197481345194009477549169555773026033) * &scale:int
    in tp_repeat reps x y (tp_mod (x+y) 65537)
End
val _=cv_auto_trans tp_mod_def;
val _=cv_auto_trans tp_repeat_def;
val _=cv_auto_trans tp_div_def;
val _=cv_auto_trans tp_price_def;
fun cpu c=let val {usr,sys}=Timer.checkCPUTimer c in Time.toReal(Time.+(usr,sys)) end;
fun one(bytes,n,e)=
 let val clock=Timer.startCPUTimer()
     val wall=Timer.startRealTimer()
     fun num i=numSyntax.mk_numeral(Arbnum.fromInt i)
     val tm=list_mk_comb(``tp_price``,[num bytes,num n])
     val rep=cv_repLib.cv_rep_for [] tm
     val ft=cv_typeLib.from_to_thm_for(type_of tm)
     val ctx=UNDISCH_ALL(MATCH_MP(MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
     val cvtm=rand(rhs(concl ctx))
     val conv=cv_computeLib.cv_compute(cv_eqs_for cvtm)
     val t1=cpu clock
     val w1=Time.toReal(Timer.checkRealTimer wall)
     val raw=CONV_RULE(RAND_CONV(RAND_CONV conv)) ctx
     val t2=cpu clock
     val w2=Time.toReal(Timer.checkRealTimer wall)
     val dec=CONV_RULE(RAND_CONV EVAL) raw
     val th=List.foldl(fn(h,t)=>PROVE_HYP(prove(h,SIMP_TAC (srw_ss()) [])) t) dec (hyp dec)
     val expct=intSyntax.term_of_int(Arbint.fromInt e)
     val (oracles,axs)=Tag.dest_tag(tag th)
     val _=if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") oracles andalso aconv(lhs(concl th)) tm andalso aconv(rhs(concl th)) expct then () else raise Fail "result mismatch"
     val _=print("TILE " ^ Int.toString bytes ^ " " ^ Int.toString n ^ " " ^ Int.toString e ^ " " ^ String.concatWith " " (map Real.toString [t1,t2-t1,w2-w1,cpu clock-t2]) ^ "\n")
 in () end;


val rows = [(6144,0,56886),(6144,32,1128043),(6144,96,3242341),(65536,0,16951),(65536,32,1067660),(65536,96,3176080),(524288,0,4534),(524288,3,107789),(524288,8,278880),(2097152,0,18136),(2097152,3,125344),(2097152,8,387404),(4521984,0,55490),(4521984,3,170181),(4521984,8,314472),(5046272,0,60024),(5046272,3,149666),(5046272,8,251208),(5570560,0,64558),(5570560,3,165565),(5570560,8,285048),(6094848,0,3555),(6094848,3,21267),(6094848,8,88307)];
val _=List.app one rows;
val _=List.app one (rev rows);
