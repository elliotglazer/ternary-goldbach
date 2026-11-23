Theory H1FiniteHeads
Ancestors H1RawCv C10004FullInteger SourceRawHeadBounds SourceRawHeadBridge complex cv_std integer list arithmetic
Libs cv_transLib realLib

fun require ok message = if ok then () else raise Fail message;
val input = TextIO.openIn "../../c10004-full-integer/heads.txt";
fun read_blocks acc = case TextIO.inputLine input of
    NONE => rev acc
  | SOME line => (case String.tokens Char.isSpace line of
        [s] => read_blocks (numSyntax.mk_numeral (Arbnum.fromString s)::acc)
      | _ => raise Fail "invalid head block line");
val numbers = read_blocks [];
val _ = TextIO.closeIn input;
val _ = require (length numbers=300) "expected 300 signed-head blocks";
val nlist = ``:num list``;
val blocks = listSyntax.mk_list(numbers,numSyntax.num);
val h1_archive_blocks_def = new_definition("h1_archive_blocks_def",
  mk_eq(mk_var("h1_archive_blocks",nlist),blocks));

(* Instantiate the proof for a list of variables. Numerals already have the
   canonical natural-number CV representation and do not need to be unfolded. *)
fun encode_blocks tm =
 let val (encoder,source)=dest_comb tm
     val (zs,ty)=listSyntax.dest_list source
     val vs=List.tabulate(length zs,fn j => mk_var("v"^Int.toString j,ty))
     val pattern=EVAL(mk_comb(encoder,listSyntax.mk_list(vs,ty)))
     val th=INST(ListPair.map (fn (v,z) => v |-> z) (vs,zs)) pattern
     val _=require (aconv (lhs(concl th)) tm) "CV input encoder mismatch"
 in th end;

val v=mk_var("payload",nlist);
val rep=cv_repLib.cv_rep_for [] (mk_comb(``h1_table``,v));
val ft=cv_typeLib.from_to_thm_for bool;
val frame=UNDISCH_ALL(MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft);
val inst=INST [v |-> blocks] frame;
val encoded=CONV_RULE (RAND_CONV (RAND_CONV (RAND_CONV encode_blocks))) inst;
val cvtm=rand(rhs(concl encoded));
val (cvfn,cvarg)=dest_comb cvtm;
val rules=cv_eqs_for(mk_comb(cvfn,mk_var("cvarg",type_of cvarg)));
val timer=Timer.startCPUTimer();
val computed=CONV_RULE (RAND_CONV (RAND_CONV (cv_computeLib.cv_compute rules))) encoded;
val value=CONV_RULE (RAND_CONV EVAL) computed;
fun discharge (h,th) =
 let val _=print("HEAD_MATCH_SIDE,"^String.substring(term_to_string h,0,Int.min(800,size(term_to_string h)))^"\n")
     val eq=QCONV (SIMP_CONV (srw_ss()) [h1_log_positive,h1_raw_step_positive,h1_value_positive,
       h1_head_positive,h1_mul_positive,BlockRoundTheory.round_scaled_pre_ok]) h
     val _=require (aconv (rhs(concl eq)) boolSyntax.T) "unresolved CV arithmetic condition"
 in PROVE_HYP (EQT_ELIM eq) th end;
val decoded=List.foldl discharge value (hyp value);
val _=require (null(hyp decoded)) "unproved CV hypothesis";
val _=require (aconv (lhs(concl decoded)) (mk_comb(``h1_table``,blocks))
       andalso aconv (rhs(concl decoded)) boolSyntax.T) "the 4800 rows failed";
val {usr=usr,sys=sys}=Timer.checkCPUTimer timer;
val _=print("HEAD_MATCH_EVAL_CPU,"^Real.toString(Time.toReal(Time.+(usr,sys)))^"\n");
val pass=EQT_ELIM decoded;
val h1_archive_pass=save_thm("h1_archive_pass",
    EQ_MP (SYM(AP_TERM ``h1_table`` h1_archive_blocks_def)) pass);
val h1_archive_rows=save_thm("h1_archive_rows",MATCH_MP h1_table_sound h1_archive_pass);

Theorem h1_archive_analytic:
 !idx:num. idx<4800 ==>
   modu (source_pair_value (2**100) (EL idx (full_heads h1_archive_blocks)) -
     complex_exp ((~(1/2),~(5/64))*complex_of_real (ln ((&(full_residue idx):real)/10004)))) < 1/(2:real) pow 85
Proof
 rpt strip_tac >> mp_tac (Q.SPEC `idx:num` (CONJUNCT2 h1_archive_rows)) >>
 ASM_REWRITE_TAC [] >> strip_tac >>
 `full_residue idx < 10004` by simp [full_residue_def] >>
 `1<=full_residue idx /\ full_residue idx<=10004` by decide_tac >>
 mp_tac (Q.SPECL [`full_residue idx`,`1:num`] c10004_raw_head_error) >>
 asm_simp_tac (srw_ss()) []
QED
