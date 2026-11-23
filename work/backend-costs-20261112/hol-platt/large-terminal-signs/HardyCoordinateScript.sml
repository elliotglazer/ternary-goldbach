Theory HardyCoordinate
Ancestors real
Libs realLib

Definition oriented_def:
  oriented (positive:bool) (x:real) = if positive then x else -x
End

Theorem rotation_components:
  !a b x y:real. a*y+b*x=0 ==>
    a*(a*x-b*y)=(a*a+b*b)*x /\
    (-b)*(a*x-b*y)=(a*a+b*b)*y
Proof
  rpt gen_tac >> strip_tac >>
  `a*(a*x-b*y)=(a*a+b*b)*x-b*(a*y+b*x)` by REAL_ARITH_TAC >>
  `(-b)*(a*x-b*y)=(a*a+b*b)*y-a*(a*y+b*x)` by REAL_ARITH_TAC >>
  fs[]
QED

Theorem orient_product:
  !p q x y. oriented (p=q) (x*y) = oriented p x * oriented q y
Proof
  Cases >> Cases >> simp[oriented_def] >> REAL_ARITH_TAC
QED

Theorem oriented_cancel:
  !p q k h. oriented p k * oriented (p=q) h = oriented q (k*h)
Proof
  Cases >> Cases >> simp[oriented_def] >> REAL_ARITH_TAC
QED

Theorem oriented_scale:
  !q s x. oriented q (s*x) = s * oriented q x
Proof
  Cases >> simp[oriented_def] >> REAL_ARITH_TAC
QED

fun sign_stage lab g = (print ("SIGN_STAGE " ^ lab ^ "\n"); ALL_TAC g);

Theorem coordinate_sign:
  !p q s k x h. 0<s /\ k*h=s*x /\ 0<oriented p k /\ 0<oriented q x ==>
                0<oriented (p=q) h
Proof
  rpt gen_tac >> strip_tac >>
  `0 < s * oriented q x` by metis_tac[REAL_LT_MUL] >> sign_stage "positive" >>
  `oriented q (k*h) = s * oriented q x` by metis_tac[oriented_scale] >> sign_stage "scale" >>
  `0 < oriented p k * oriented (p=q) h` by metis_tac[oriented_cancel] >> sign_stage "multiply" >>
  metis_tac[REAL_LT_LMUL_0]
QED

Theorem hardy_coordinate_sign:
  !chooseX p q a b x y.
     0<a*a+b*b /\ a*y+b*x=0 /\
     0<oriented p (if chooseX then a else -b) /\
     0<oriented q (if chooseX then x else y) ==>
     0<oriented (p=q) (a*x-b*y)
Proof
  rpt gen_tac >> strip_tac >>
  `a*(a*x-b*y)=(a*a+b*b)*x /\ (-b)*(a*x-b*y)=(a*a+b*b)*y` by
    (irule rotation_components >> asm_rewrite_tac[]) >>
  `(if chooseX then a else -b)*(a*x-b*y) =
    (a*a+b*b)*(if chooseX then x else y)` by
    (Cases_on `chooseX` >> asm_rewrite_tac[]) >>
  mp_tac (Q.SPECL [`p`,`q`,`a*a+b*b`,`if chooseX then a else -b`,
                    `if chooseX then x else y`,`a*x-b*y`] coordinate_sign) >>
  asm_rewrite_tac[]
QED

Theorem enclosed_coordinate:
  !p center radius trueval. 0<=radius /\ abs(trueval-center)<=radius /\
    radius < oriented p center ==> 0<oriented p trueval
Proof
  Cases >> simp[oriented_def,abs] >> rpt gen_tac >> rw[] >> REAL_ASM_ARITH_TAC
QED
