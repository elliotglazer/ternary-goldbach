Theory Q131071Node
Ancestors SpectralNode real integer intreal
Libs realLib intLib
val _=realLib.prefer_real();

Theorem q131071_full_gain_one:
 !amp gain. abs(4722366482869645213696*amp-(-3478637734366647488905)) <= 33764931757938834355 /\
  1<=gain /\ gain<=1 ==>
  abs(16777216*(amp*gain)-(-12358604)) <= (16882485233755714837/140737488355328)
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`(-3478637734366647488905):int`,`33764931757938834355:int`,`(1/281474976710656):real`,`(1/281474976710656):real`,
   `4722366482869645213696*amp:real`,`(1/281474976710656)*gain:real`] spectral_node) >>
 impl_tac >- (simp[real_of_int_num,real_of_int_neg] >> REAL_ASM_ARITH_TAC) >>
 `node_center (-3478637734366647488905) (1/281474976710656) (1/281474976710656) = (-12358604):int` by
  (simp_tac bool_ss [node_center_def,nearest_def,INT_FLOOR',raw_center_def,midpoint_def,
     real_of_int_num,real_of_int_neg] >> REAL_ARITH_TAC) >>
 asm_simp_tac bool_ss [node_radius_def,raw_radius_def,raw_center_def,midpoint_def,halfwidth_def,
   real_of_int_num,real_of_int_neg,abs] >> REAL_ASM_ARITH_TAC
QED

Theorem q131071_phase_gain:
 !amp gain. abs(4722366482869645213696*amp-(-7135107969590756821979)) <= 69245256825799628707 /\
  (32718097/67108864)<=gain /\ gain<=(16359049/33554432) ==>
  abs(16777216*(amp*gain)-(-12358590)) <= (2265583210430123741603579883/18889465931478580854784)
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`(-7135107969590756821979):int`,`69245256825799628707:int`,`(32718097/18889465931478580854784):real`,`(16359049/9444732965739290427392):real`,
   `4722366482869645213696*amp:real`,`(1/281474976710656)*gain:real`] spectral_node) >>
 impl_tac >- (simp[real_of_int_num,real_of_int_neg] >> REAL_ASM_ARITH_TAC) >>
 `node_center (-7135107969590756821979) (32718097/18889465931478580854784) (16359049/9444732965739290427392) = (-12358590):int` by
  (simp_tac bool_ss [node_center_def,nearest_def,INT_FLOOR',raw_center_def,midpoint_def,
     real_of_int_num,real_of_int_neg] >> REAL_ARITH_TAC) >>
 asm_simp_tac bool_ss [node_radius_def,raw_radius_def,raw_center_def,midpoint_def,halfwidth_def,
   real_of_int_num,real_of_int_neg,abs] >> REAL_ASM_ARITH_TAC
QED

Theorem q131071_compact_node:
 !xs scale key f amp gain. admitted_r scale xs /\ abs(scale*f-real_of_int key)<=1/2 /\
 abs(4722366482869645213696*amp-(-7135107969590756821979))<=69245256825799628707 /\ (32718097/67108864)<=gain /\ gain<=(16359049/33554432) ==>
 admitted_r scale ((key,(-12358590),f,16777216*(amp*gain),(2265583210430123741603579883/18889465931478580854784))::xs)
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`amp:real`,`gain:real`] q131071_phase_gain) >>
 impl_tac >- asm_rewrite_tac[] >>
 asm_simp_tac bool_ss [CompactRadiiTheory.admitted_r_def,real_of_int_num,real_of_int_neg] >>
 REAL_ARITH_TAC
QED

Theorem midpoint_11389_2_positive:
 !amp gain y x0 x1 x2 x3 x5 x6 x7 x8 x9.
  abs(x0-(-(196397239847217489580187/4722366482869645213696)))<=(45174141301278153677/4722366482869645213696) /\
  abs(x1-(-(85614611943649707694643/2361183241434822606848)))<=(1513184638828254357/147573952589676412928) /\
  abs(x2-(-(114011950835886458502413/4722366482869645213696)))<=(11843376734615606033/1180591620717411303424) /\
  abs(x3-(-(48273955003782912746765/4722366482869645213696)))<=(42262375041192650603/4722366482869645213696) /\
  abs(x5-(-(492020853814040747637/590295810358705651712)))<=(328618657782227733/36893488147419103232) /\
  abs(x6-(-(910427826636295875863/73786976294838206464)))<=(366278614360005877/36893488147419103232) /\
  abs(x7-(-(153466077846273321511521/4722366482869645213696)))<=(1498789115604174627/147573952589676412928) /\
  abs(x8-(-(64070261694294681245731/1180591620717411303424)))<=(2806139621215541261/295147905179352825856) /\
  abs(x9-(-(161103150457573134126429/2361183241434822606848)))<=(37775373063870280307/4722366482869645213696) /\
  abs(4722366482869645213696*amp-(-7135107969590756821979))<=69245256825799628707 /\
  (32718097/67108864)<=gain /\
  gain<=(16359049/33554432) /\
  abs(y-((35/65536)*x0+(-(405/65536))*x1+(567/16384)*x2+(-(2205/16384))*x3+(19845/32768)*(amp*gain)+(19845/32768)*x5+(-(2205/16384))*x6+(567/16384)*x7+(-(405/65536))*x8+(35/65536)*x9))<=1/4 ==> 0<y
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`amp:real`,`gain:real`] q131071_phase_gain) >>
 impl_tac >- asm_rewrite_tac[] >> PURE_REWRITE_TAC[ABS_BOUNDS] >> fs[ABS_BOUNDS] >> REAL_ASM_ARITH_TAC
QED
