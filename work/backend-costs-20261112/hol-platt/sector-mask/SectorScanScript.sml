Theory SectorScan
Ancestors SectorMask FullCount

Theorem unpack_codes:
  !n m. EVERY (\k. k=1 \/ k=2) (unpack n m)
Proof
  Induct >> simp[unpack_def] >> gen_tac >>
  `m MOD 2 < 2` by simp[] >> decide_tac
QED

Theorem two_codes_scan:
  !l h lower p q upper.
    (l=1 \/ l=2) /\ (h=1 \/ h=2) /\ lower<p /\ p<q /\ q<upper ==>
    scan_between lower upper [(p,1,l-1);(q,1,h-1)] =
      SOME(if l=h then 0 else 1,if l=h then 0 else upper-q)
Proof
  rpt strip_tac >> gvs[scan_between_def,scan_def,LET_THM,
     SIMP_RULE (srw_ss()) [CONJUNCT1 steps_def,LET_THM] (Q.INST [`len` |-> `0`] (SPEC_ALL (CONJUNCT2 steps_def)))]
QED

Theorem unpack_length[simp]:
  !n m. LENGTH (unpack n m) = n
Proof
  Induct >> simp[unpack_def]
QED

Theorem code_rows_length[simp]:
  !ls f g a b. LENGTH (code_rows ls f g a b) = LENGTH ls
Proof
  Induct >> simp[code_rows_def] >> rpt gen_tac >> PairCases_on `h` >>
  simp[code_rows_def]
QED

Theorem unpack_el:
  !n m i. i<n ==> EL i (unpack n m)=1 \/ EL i (unpack n m)=2
Proof
  rpt gen_tac >> mp_tac (Q.SPECL [`n`,`m`] unpack_codes) >>
  simp[listTheory.EVERY_EL] >> metis_tac[]
QED
Theorem sector_lane_scan:
  !xs f g a b m n c u v lane lower p q upper.
    sector_packet xs f g a b = SOME(m,n,c,u,v) /\ lane < LENGTH xs /\
    lower < p /\ p < q /\ q < upper ==>
    let l = EL lane (unpack (LENGTH xs) m);
        h = EL lane (unpack (LENGTH xs) n);
        signs = EL lane (code_rows xs f g a b)
    in scan_between lower upper [(p,1,l-1);(q,1,h-1)] =
       SOME(if FST signs = SND signs then 0 else 1,
            if FST signs = SND signs then 0 else upper-q)
Proof
  rpt gen_tac >> strip_tac >>
  drule packet_masks >> strip_tac >>
  mp_tac (Q.SPECL [`EL lane (unpack (LENGTH (xs:(int#int#int#int#int#int) list)) m)`,
     `EL lane (unpack (LENGTH (xs:(int#int#int#int#int#int) list)) n)`,`lower`,`p`,`q`,`upper`] two_codes_scan) >>
  impl_tac >- metis_tac[unpack_el] >>
  simp[LET_THM,listTheory.EL_MAP]
QED
