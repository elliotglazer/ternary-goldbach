Theory Enclosure
Ancestors Project GridSigns rich_list list integer arithmetic
Libs intLib

Definition lanes_def:
  (lanes 0 b x = []:num list) /\
  (lanes (SUC k) b x = x MOD b :: lanes k b (x DIV b))
End

Definition expanded_def:
  expanded count base words = TAKE count (FLAT (MAP (lanes 4 base) words))
End

Theorem length_lanes[simp]:
  !k b x. LENGTH (lanes k b x) = k
Proof
  Induct >> simp[lanes_def]
QED

Theorem take_lanes:
  !k n b x. TAKE n (lanes k b x) = lanes (MIN n k) b x
Proof
  Induct >> Cases_on `n` >> simp[lanes_def,MIN_SUC]
QED

Theorem expanded_nil[simp]:
  expanded n b [] = []
Proof
  simp[expanded_def]
QED

Theorem expanded_cons:
  expanded n b (x::xs) = lanes (MIN n 4) b x ++ expanded (n-4) b xs
Proof
  simp[expanded_def,rich_listTheory.TAKE_APPEND,take_lanes]
QED

Theorem fields_relation:
  !k b u a bias x h. fields k b u a bias x h ==>
    LIST_REL (\v z. v DIV u + bias = z + a) (lanes k (2**256) x) (lanes k b h)
Proof
  Induct >> simp_tac bool_ss [fields_def,lanes_def,LIST_REL_def] >>
  metis_tac[]
QED

Theorem verify_relation:
  !xs hs n b u a bias. verify_words n b u a bias xs hs ==>
    LIST_REL (\v z. v DIV u + bias = z + a)
      (expanded n (2**256) xs) (expanded n b hs)
Proof
  Induct >> Cases_on `hs` >>
  simp_tac list_ss [verify_words_def,expanded_nil,expanded_cons,LIST_REL_def] >>
  rpt strip_tac >> match_mp_tac LIST_REL_APPEND_suff >> conj_tac
  >- (qpat_x_assum `fields _ _ _ _ _ _ _` (mp_tac o MATCH_MP fields_relation) >>
      simp[]) >>
  first_x_assum (qspecl_then [`t`,`n-4`,`b`,`u`,`a`,`bias`] mp_tac) >> simp[]
QED

Theorem four_lanes:
  four b u x = MAP (\z. ((&z - &(b DIV 2)):int,u)) (lanes 4 b x)
Proof
  PURE_REWRITE_TAC[four_def,digit_def,LET_THM,
    prove(``4=SUC(SUC(SUC(SUC 0)))``,DECIDE_TAC),lanes_def,MAP] >> BETA_TAC >> REFL_TAC
QED

Theorem four_words:
  !xs b u. FLAT (MAP (four b u) xs) =
    MAP (\z. ((&z - &(b DIV 2)):int,u)) (FLAT (MAP (lanes 4 b) xs))
Proof
  Induct >> simp[four_lanes]
QED

Theorem grid_tile:
  grid [(w,e,n,hs)] =
  MAP (\z. ((&z - &((2**w) DIV 2)):int,2**e)) (expanded n (2**w) hs)
Proof
  simp[grid_def,expanded_def,four_words,MAP_TAKE]
QED

Theorem relation_to_bounds:
  0 < u ==>
  LIST_REL (\v z. v DIV u + bias = z+adj) xs hs ==>
  LIST_REL (\v z. ((&z - &bias):int) * &u <= &v - &(adj*u) /\
                     &v - &(adj*u) < ((&z - &bias):int) * &u + &u) xs hs
Proof
  strip_tac >> match_mp_tac LIST_REL_mono >> metis_tac[field_bounds]
QED

Theorem half_power:
  0<w ==> 2**w DIV 2 = 2**(w-1)
Proof
  Cases_on `w` >> simp[EXP,MULT_COMM]
QED

Definition encloses_def:
  encloses (raw:num) (q:int,u:num) <=>
    q * &u <= &raw - &(2**255) /\ &raw - &(2**255) < q * &u + &u
End

Theorem tile_enclosures:
  !w e n xs hs. project_ok w e n xs hs ==>
    LIST_REL encloses (expanded n (2**256) xs) (grid [(w,e,n,hs)])
Proof
  rpt gen_tac >> REWRITE_TAC[project_ok_def] >> strip_tac >>
  `(2**(255-e))*(2**e) = 2**255` by simp[GSYM EXP_ADD] >>
  `2**w DIV 2 = 2**(w-1)` by metis_tac[half_power] >>
  qpat_x_assum `verify_words _ _ _ _ _ _ _` (mp_tac o MATCH_MP verify_relation) >>
  strip_tac >>
  drule_at (Pos last) relation_to_bounds >>
  simp[grid_tile,LIST_REL_MAP2,encloses_def] >>
  simp[GSYM EXP_ADD]
QED


val _ = let val th = tile_enclosures val (os,axs)=Tag.dest_tag(tag th) in
  if null(hyp th) andalso null axs andalso List.all(fn s=>s="DISK_THM") os
  then print("ENCLOSURE_CHECKED " ^ thm_to_string th ^ "\n")
  else raise Fail "unexpected dependency tag or open hypothesis" end;


