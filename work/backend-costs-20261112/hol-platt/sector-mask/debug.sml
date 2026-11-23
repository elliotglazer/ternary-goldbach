e(rpt gen_tac >> strip_tac >>
  drule packet_masks >> strip_tac >>
  mp_tac (Q.SPECL [`EL lane (unpack (LENGTH (xs:(int#int#int#int#int#int) list)) m)`,
     `EL lane (unpack (LENGTH (xs:(int#int#int#int#int#int) list)) n)`,`lower`,`p`,`q`,`upper`] two_codes_scan) >>
  impl_tac >- metis_tac[unpack_el] >>
  simp[LET_THM,listTheory.EL_MAP]);
