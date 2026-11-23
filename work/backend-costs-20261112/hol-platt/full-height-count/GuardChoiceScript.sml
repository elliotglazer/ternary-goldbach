Theory GuardChoice
Ancestors FullCount arithmetic list

(* n and k are fixed across all widths. credit is the lower auxiliary
   bracket integral after clearing denominators. cap is the phase and
   allowance upper numerator in the same units. *)
Theorem some_width_exact_count:
  !ws n k d credit cap.
    k <= n /\
    (!w. MEM w ws ==> d w * n + credit w <= cap w) /\
    (?w. MEM w ws /\ 0 < d w /\
         (cap w < d w * (k+1) + credit w \/
          ((EVEN n <=> EVEN k) /\ cap w < d w * (k+2) + credit w))) ==>
    n = k
Proof
  rpt gen_tac >> strip_tac >>
  `d w * n + credit w <= cap w` by metis_tac[] >>
  Cases_on `n = k` >> simp[] >>
  `k+1 <= n` by decide_tac >>
  `d w * (k+1) <= d w * n` by simp[LE_MULT_LCANCEL] >>
  TRY decide_tac >>
  `k+2 <= n` by metis_tac[FullCountTheory.exact_count_of_parity,NOT_LESS] >>
  `d w * (k+2) <= d w * n` by simp[LE_MULT_LCANCEL] >> decide_tac
QED
