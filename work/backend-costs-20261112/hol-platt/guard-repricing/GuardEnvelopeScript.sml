Theory GuardEnvelope
Ancestors arithmetic
Libs cv_transLib

Definition rising_def:
  (rising h 0 = 1:num) /\
  (rising h (SUC k) = rising h k * (h+k))
End

Definition exp_sum_numerator_def:
  (exp_sum_numerator 0 = 0:num) /\
  (exp_sum_numerator (SUC k) = SUC k * exp_sum_numerator k + 2**(SUC k))
End

(* The tail and the grid error are compared after clearing their positive
   denominators. 'mult' is the reciprocal of the selected budget fraction. *)
Definition tail_num_def:
  tail_num h f = 2 * rising h 20 * (42*f)
End
Definition tail_den_def:
  tail_den h f = ((2*f)**20 * FACT 20) * (42*f-(h+20))
End
Definition grid_den_def:
  grid_den = 12 * 2**112 * 2**94
End
Definition grid_num_def:
  grid_num = 25 * 2**112 + 8 * (42*2**94+40)
End
Definition charge_def:
  charge mult = mult*633*2**82
End
Definition envelope_ok_def:
  envelope_ok h f mult <=>
    h+20 <= f /\ 0 < f /\ h+20 < 42*f /\ charge mult * grid_num < grid_den /\
    (charge mult * grid_den) * tail_num h f <
      tail_den h f * (grid_den - charge mult * grid_num)
End
val _=cv_auto_trans envelope_ok_def;
val _=cv_auto_trans exp_sum_numerator_def;

Theorem rising_mono:
  !d a b. a<=b ==> rising a d <= rising b d
Proof
  Induct >> simp[rising_def] >> rpt strip_tac >>
  irule LESS_MONO_MULT2 >> simp[]
QED

Theorem tail_num_mono:
  !a b f. a<=b ==> tail_num a f <= tail_num b f
Proof
  rewrite_tac[tail_num_def] >> rpt strip_tac >>
  metis_tac[LESS_MONO_MULT2,LESS_EQ_REFL,rising_mono]
QED

Theorem tail_den_antitone:
  !a b f. a<=b ==> tail_den b f <= tail_den a f
Proof
  rewrite_tac[tail_den_def] >> rpt strip_tac >>
  `42*f-(b+20) <= 42*f-(a+20)` by decide_tac >>
  metis_tac[LESS_MONO_MULT2,LESS_EQ_REFL]
QED

Theorem ordered_chain:
  !a b c d:num. a<=b /\ b<c /\ c<=d ==> a<d
Proof
  decide_tac
QED

Theorem envelope_weaken:
  !a b f m. a<=b /\ envelope_ok b f m ==> envelope_ok a f m
Proof
  rpt gen_tac >> rewrite_tac[envelope_ok_def] >> strip_tac >>
  `a+20<=f` by decide_tac >>
  `a+20<42*f` by decide_tac >>
  `tail_num a f <= tail_num b f` by (irule tail_num_mono >> first_assum ACCEPT_TAC) >>
  `tail_den b f <= tail_den a f` by (irule tail_den_antitone >> first_assum ACCEPT_TAC) >>
  rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >>
  match_mp_tac (SPECL [``(charge m * grid_den) * tail_num a f``,
    ``(charge m * grid_den) * tail_num b f``,
    ``tail_den b f * (grid_den - charge m * grid_num)``,
    ``tail_den a f * (grid_den - charge m * grid_num)``] ordered_chain) >>
  rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >>
  match_mp_tac LESS_MONO_MULT2 >> asm_rewrite_tac[LESS_EQ_REFL]
QED

val _=save_thm("exponential_sum_lt_seven",
  EQT_ELIM(cv_eval ``exp_sum_numerator 19 < 7 * FACT 19``));
val ceiling=save_thm("guard_ceiling_lt_one_third",
  EQT_ELIM(cv_eval ``envelope_ok 6633 16384 3``));
Theorem guard_heights:
  !h. h<=6633 ==> envelope_ok h 16384 3
Proof
  gen_tac >> strip_tac >>
  match_mp_tac (SPECL [``h:num``,``6633:num``,``16384:num``,``3:num``] envelope_weaken) >>
  asm_rewrite_tac[ceiling]
QED
Theorem guard_height_index:
  !j:num. j<=84880 ==> 5*j+63<64*6633
Proof
  decide_tac
QED
fun check_closed th expected = let
  val (oracles,axs) = Tag.dest_tag(tag th)
  in if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") oracles
    andalso aconv(concl th) expected then () else raise Fail "arithmetic audit" end;
val _=check_closed guard_heights ``!h. h<=6633 ==> envelope_ok h 16384 3``;
val _=check_closed guard_height_index ``!j:num. j<=84880 ==> 5*j+63<64*6633``;
val _=print "GUARD_ENVELOPE_DONE\n";
