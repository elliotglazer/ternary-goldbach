Theory RoundedHeight
Ancestors real arithmetic

Theorem rounded_index:
  !t:num. 64*t <= 5*((64*t+4) DIV 5) /\ 5*((64*t+4) DIV 5) <= 64*t+4
Proof
  gen_tac >> qspec_then `5` mp_tac DIVISION >>
  simp_tac bool_ss[numLib.REDUCE_CONV ``0 < (5:num)``] >>
  disch_then (qspec_then `64*t+4` mp_tac) >>
  qabbrev_tac `j = (64*t+4) DIV 5` >> qabbrev_tac `r = (64*t+4) MOD 5` >>
  decide_tac
QED

Theorem closed_height_restrict:
  !zero re im t. (!z. zero z /\ abs(im z) <= &(5*((64*t+4) DIV 5))/64 ==> re z = (1:real)/2) ==>
    !z. zero z /\ abs(im z) <= &t ==> re z = 1/2
Proof
  rpt strip_tac >> first_x_assum match_mp_tac >> simp[] >>
  irule REAL_LE_TRANS >> qexists_tac `&t` >> simp[REAL_LE_RDIV_EQ,REAL_OF_NUM_MUL,REAL_OF_NUM_LE] >>
  metis_tac[rounded_index,MULT_COMM]
QED
