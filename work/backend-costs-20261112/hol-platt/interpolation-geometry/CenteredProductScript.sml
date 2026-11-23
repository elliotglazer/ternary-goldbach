Theory CenteredProduct
Ancestors arithmetic real
Libs realLib
Definition node_product_def:
  (node_product 0 (a:real) (x:real) = 1) /\
  (node_product (SUC n) a x =
    abs(x-a) * node_product n (a+1) x)
End
Theorem product_nonneg:
  !n a x. 0 <= node_product n a x
Proof
  Induct_on `n` >> simp [node_product_def,REAL_LE_MUL,ABS_POS]
QED
Theorem product_snoc:
  !n a x. node_product (SUC n) a x =
    node_product n a x * abs (x-(a+ &n))
Proof
  Induct_on `n`
  >- simp [node_product_def]
  >> rpt gen_tac >> PURE_ONCE_REWRITE_TAC [node_product_def] >>
  first_x_assum (qspecl_then [`a+1:real`,`x:real`] SUBST1_TAC) >>
  PURE_REWRITE_TAC [node_product_def,GSYM REAL_OF_NUM_SUC] >>
  `a+1+ &n = a+(&n+1):real` by realLib.REAL_ARITH_TAC >>
  simp [REAL_MUL_ASSOC]
QED
fun mark s g=(print (s^" "^Parse.term_to_string (#2 g)^"\n");ALL_TAC g);
Theorem centered_step:
  !h x. node_product (2*SUC h) (1 - &(SUC h)) x =
    abs(x+ &h) * (node_product (2*h) (1 - &h) x * abs(x- &(SUC h)))
Proof
  rpt gen_tac >>
  `2*SUC h = SUC(SUC(2*h))` by DECIDE_TAC >>
  `1- &(SUC h)+1 = 1- &h:real` by
    (PURE_REWRITE_TAC [GSYM REAL_OF_NUM_SUC] >> realLib.REAL_ARITH_TAC) >>
  `x-(1- &(SUC h))=x+ &h:real` by
    (PURE_REWRITE_TAC [GSYM REAL_OF_NUM_SUC] >> realLib.REAL_ARITH_TAC) >>
  `1- &h + &(2*h)= &(SUC h):real` by
    (PURE_REWRITE_TAC [GSYM REAL_OF_NUM_SUC,GSYM REAL_OF_NUM_MUL] >> realLib.REAL_ARITH_TAC) >>
  mark "identities" >>
  ASM_REWRITE_TAC [] >> PURE_ONCE_REWRITE_TAC [node_product_def] >>
  ASM_REWRITE_TAC [] >> PURE_ONCE_REWRITE_TAC [product_snoc] >> ASM_REWRITE_TAC []
QED
Theorem centered_product_bound:
  !h x. 0<=x /\ x<=1 ==>
    node_product (2*h) (1- &h) x <= &(FACT h) pow 2
Proof
  Induct_on `h`
  >- simp [node_product_def,FACT]
  >> rpt gen_tac >> strip_tac >> mark "ind" >>
  `0 <= (&h:real)` by simp [] >>
  `node_product (2*h) (1- &h) x <= &(FACT h) pow 2` by metis_tac [] >> mark "ih" >>
  `abs(x+ &h) <= &(SUC h)` by
    (PURE_REWRITE_TAC [ABS_BOUNDS,GSYM REAL_OF_NUM_SUC] >> realLib.REAL_ASM_ARITH_TAC) >> mark "left" >>
  `abs(x- &(SUC h)) <= &(SUC h)` by
    (PURE_REWRITE_TAC [ABS_BOUNDS,GSYM REAL_OF_NUM_SUC] >> realLib.REAL_ASM_ARITH_TAC) >> mark "right" >>
  `node_product (2*h) (1- &h) x * abs(x - &(SUC h)) <=
     &(FACT h) pow 2 * &(SUC h)` by
    (irule REAL_LE_MUL2 >> simp [product_nonneg,ABS_POS]) >> mark "inner" >>
  `abs(x + &h) * (node_product (2*h) (1- &h) x * abs(x- &(SUC h))) <=
     &(SUC h) * (&(FACT h) pow 2 * &(SUC h))` by
    (irule REAL_LE_MUL2 >> simp [product_nonneg,ABS_POS,REAL_LE_MUL]) >> mark "outer" >>
  `&(FACT(SUC h)) pow 2 = &(SUC h) * (&(FACT h) pow 2 * &(SUC h))` by
    (PURE_REWRITE_TAC [FACT,GSYM REAL_OF_NUM_MUL,POW_2] >>
     CONV_TAC (AC_CONV (REAL_MUL_ASSOC,REAL_MUL_COMM))) >>
  ASM_REWRITE_TAC [centered_step]
QED
