Theory LaneReciprocal
Ancestors arithmetic

fun mark s g = (print ("MARK "^s^"\n"); ALL_TAC g);
Theorem lane_reciprocal:
  !n m v h e:num. 0 < v /\ 0 < h /\ v*m = h+e /\ n*e < h ==>
  (n*m) DIV h = n DIV v
Proof
  rpt strip_tac >>
  `(n*m*v) DIV v = n*m` by simp [MULT_DIV] >> mark "a" >>
  `n*m*v = n*h+n*e` by
    (SUBST1_TAC (GSYM (Q.SPECL [`n:num`,`v:num`,`m:num`] MULT_ASSOC_COMM)) >>
     ASM_REWRITE_TAC [LEFT_ADD_DISTRIB,RIGHT_ADD_DISTRIB]) >> mark "b" >>
  `(n*m*v) DIV h = n` by (qpat_x_assum `n*m*v = _` SUBST1_TAC >> irule DIV_MULT >> simp []) >> mark "c" >>
  `((n*m*v) DIV v) DIV h = ((n*m*v) DIV h) DIV v` by
    simp [DIV_DIV_DIV_MULT, MULT_COMM] >>
  metis_tac []
QED




Theorem lane_ceil_reciprocal:
  !n b h v:num. n < b /\ 0 < v /\ b*v <= h ==>
  (n*((h+v-1) DIV v)) DIV h = n DIV v
Proof
  rpt strip_tac >>
  qabbrev_tac `m = (h+v-1) DIV v` >>
  qabbrev_tac `r = (h+v-1) MOD v` >>
  `h+v-1 = m*v+r /\ r<v` by
    (unabbrev_all_tac >> metis_tac [DIVISION]) >>
  `m*v = h+(v-1-r)` by DECIDE_TAC >>
  `v*m = h+(v-1-r)` by metis_tac [MULT_COMM] >>
  `n*(v-1-r) <= n*v` by simp [LE_MULT_LCANCEL] >>
  `n*v < b*v` by simp [LT_MULT_RCANCEL] >>
  `n*(v-1-r)<h /\ 0<h` by DECIDE_TAC >>
  metis_tac [lane_reciprocal]
QED
