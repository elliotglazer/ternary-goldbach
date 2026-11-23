let drotate_preserve = prove
 (`!xs. Dwell xs ==> Dwell (Drotate xs) /\
   Dlength (Drotate xs) = Dlength xs`,
  GEN_TAC THEN dcase `xs:cval` `k:num` `u:cval` `ys:cval` THEN
  REWRITE_TAC (drotate::dwell::dlength::dcval_rules) THEN
  STRIP_TAC THEN ASM_SIMP_TAC [dappend_preserve;dwell;dlength;ADD1;ADD_SYM] THEN
  ARITH_TAC);;
let dlayer_preserve = prove
 (`!ws xs. Dwell ws /\ Dwell xs ==>
   Dwell (Dlayer ws xs (numc n)) /\
   Dlength (Dlayer ws xs (numc n)) = Dlength xs`,
  MATCH_MP_TAC cval_INDUCT THEN CONJ_TAC THENL
  [REPEAT GEN_TAC THEN SIMP_TAC [dlayer_rec];
   MAP_EVERY X_GEN_TAC [`w:cval`;`ws:cval`] THEN STRIP_TAC THEN
   X_GEN_TAC `xs:cval` THEN
   dcase `xs:cval` `k:num` `u:cval` `tail:cval` THENL
   [REWRITE_TAC (dlayer_rec::dcval_rules) THEN SIMP_TAC [];
    dcase `tail:cval` `k:num` `v:cval` `zs:cval` THEN
    REWRITE_TAC (dlayer_rec::dwell::dlength::LET_DEF::LET_END_DEF::dcval_rules) THEN
    STRIP_TAC THEN dasm_simp [dwell;dlength;dbutterfly_valid]]]);;

let dlayer_contract = new_recursive_definition cval_RECURSION
 `(DlayerContract (numc k) xs n <=> T) /\
  (DlayerContract (pairc w ws) xs n <=>
    2 <= Dlength xs /\
    Dlocal (&n) (fstc xs) (fstc (sndc xs)) w
      (Dbutterfly (numc n) (fstc xs) (fstc (sndc xs)) w) /\
    DlayerContract ws (sndc (sndc xs)) n)`;;
let dlayer_sound = prove
 (`!ws xs. Dwell ws /\ Dwell xs /\
   Dlength xs = 2 * Dlength ws /\ 0 < n ==>
   DlayerContract ws xs n`,
  MATCH_MP_TAC cval_INDUCT THEN CONJ_TAC THENL
  [REPEAT GEN_TAC THEN REWRITE_TAC [dlayer_contract];
   MAP_EVERY X_GEN_TAC [`w:cval`;`ws:cval`] THEN STRIP_TAC THEN
   X_GEN_TAC `xs:cval` THEN
   dcase `xs:cval` `k:num` `u:cval` `tail:cval` THENL
   [REWRITE_TAC [dlength] THEN ARITH_TAC;
    dcase `tail:cval` `k:num` `v:cval` `zs:cval` THENL
    [REWRITE_TAC [dlength] THEN ARITH_TAC;
     REWRITE_TAC (dlayer_contract::dwell::dlength::dcval_rules) THEN
     STRIP_TAC THEN
     SUBGOAL_THEN `Dlength zs = 2 * Dlength ws` ASSUME_TAC THENL
       [ASM_ARITH_TAC; dasm_simp [dbutterfly_residual;ARITH_RULE `2 <= SUC (SUC k)`]]]]]);;
let dblock_contract = new_recursive_definition cval_RECURSION
 `(DblockContract (numc k) xs ws ys n <=> xs = ys) /\
  (DblockContract (pairc h clock) xs ws ys n <=>
    DlayerContract ws xs n /\
    DblockContract clock (Drotate (Dlayer ws xs (numc n))) ws ys n)`;;
let drun_sound = prove
 (`!clock xs ws. Dwell ws /\ Dwell xs /\
   Dlength xs = 2 * Dlength ws /\ 0 < n ==>
   Dwell (Drun clock xs ws (numc n)) /\
   Dlength (Drun clock xs ws (numc n)) = Dlength xs /\
   DblockContract clock xs ws (Drun clock xs ws (numc n)) n`,
  MATCH_MP_TAC cval_INDUCT THEN CONJ_TAC THENL
  [REPEAT GEN_TAC THEN SIMP_TAC [drun_rec;dblock_contract];
   MAP_EVERY X_GEN_TAC [`h:cval`;`clock:cval`] THEN STRIP_TAC THEN
   REPEAT GEN_TAC THEN STRIP_TAC THEN
   REWRITE_TAC [drun_rec;dblock_contract] THEN
   dasm_simp [dlayer_preserve;drotate_preserve;dlayer_sound]]);;

let dbound_spec = new_recursive_definition cval_RECURSION
 `(DboundSpec (numc k) b <=> T) /\
  (DboundSpec (pairc z zs) b <=>
    DIwithin b (Zdecode (fstc z)) /\
    DIwithin b (Zdecode (sndc z)) /\ DboundSpec zs b)`;;
let dbound_sound = prove
 (`!xs. Dwell xs /\ Zvalid b ==>
   (Zholds (Dbound xs b) <=> DboundSpec xs (Zdecode b))`,
  MATCH_MP_TAC cval_INDUCT THEN
  REWRITE_TAC [dbound_rec;dbound_spec;dwell;dcomplex;zand_holds;zholds_num;ARITH] THEN
  REPEAT STRIP_TAC THEN dasm_simp [zwithin_decode;dwithin]);;
let dchecksum_spec = new_recursive_definition cval_RECURSION
 `(DchecksumSpec (numc k) = (&0:int)) /\
  (DchecksumSpec (pairc z zs) =
    Zdecode (fstc z) + &3 * Zdecode (sndc z) + &9 * DchecksumSpec zs)`;;
let dchecksum_sound = prove
 (`!xs. Dwell xs ==> Zvalid (Dchecksum xs) /\
   Zdecode (Dchecksum xs) = DchecksumSpec xs`,
  MATCH_MP_TAC cval_INDUCT THEN
  REWRITE_TAC [dchecksum_rec;dchecksum_spec;dwell;dcomplex] THEN
  REPEAT STRIP_TAC THEN
  dasm_simp [dnorm_valid;dnorm_decode;zadd_valid;zadd_decode;zmul_valid;
    zmul_decode;zvalid_pair] THEN
  REWRITE_TAC decode_rules THEN CONV_TAC INT_RING);;
let daccept_sound = prove
 (`Dwell ws /\ Dwell xs /\ Zvalid b /\ Zvalid expected /\
   Daccept (numc n) ws clock xs b expected = numc 1 ==>
   ?ys. Dwell ys /\ Dlength ys = Dlength xs /\
     DblockContract clock xs ws ys n /\
     DboundSpec ys (Zdecode b) /\ DchecksumSpec ys = Zdecode expected`,
  STRIP_TAC THEN
  SUBGOAL_THEN `Zholds (Daccept (numc n) ws clock xs b expected)` MP_TAC THENL
  [ASM_REWRITE_TAC [zholds_num;ARITH];ALL_TAC] THEN
  REWRITE_TAC [daccept;zand_holds;dsize_exact;cexp_mul_def;
    cexp_less_def;cexp_eq_def;injectivity "cval";LET_DEF;LET_END_DEF] THEN
  REWRITE_TAC [zholds_num] THEN
  REPEAT COND_CASES_TAC THEN ASM_REWRITE_TAC [ARITH] THEN
  STRIP_TAC THEN
  EXISTS_TAC `Drun clock xs ws (numc n)` THEN
  dasm_simp [drun_sound;dbound_sound;dchecksum_sound;zeq_decode] THEN
  ASM_MESON_TAC [drun_sound;dbound_sound;dchecksum_sound;zeq_decode]);;
check_axioms ();;
print_string "DEPENDENT_NETWORK_SOUND_DONE\n";;

