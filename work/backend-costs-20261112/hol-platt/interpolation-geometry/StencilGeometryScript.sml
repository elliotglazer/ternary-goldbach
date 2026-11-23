Theory StencilGeometry
Ancestors arithmetic integer list cv_std
Libs intLib cv_transLib
Definition distance_product_def:
  (distance_product 0 (first:int) (f:num) = 1:int) /\
  (distance_product (SUC n) first f =
    ABS (&f - 4096 * first) * distance_product n (first+1) f)
End
Definition spacing_ok_def:
  spacing_ok (r:num) f <=>
  EVEN r /\ 0<r /\ 0<f /\ f<4096 /\
  distance_product r (1- &(r DIV 2)) f <=
   &(4096 ** r * (FACT (r DIV 2)) ** 2)
End
Definition checked_nodes_def:
  checked_nodes = [(48,1);(48,2560);(64,1792);(64,1024);(64,1408);(64,2176);(64,2560);(80,2176);(96,2048);(96,1920);(96,1792);(96,2304);(96,2176);(112,2432);(112,1792);(112,2048);(112,1664);(112,1920);(128,2176);(128,2304);(112,4095);(112,1);(128,4095);(64,1664);(80,2688);(80,1920);(80,2432);(80,1536);(96,2688);(96,3200);(96,3072);(96,2816);(96,2432);(112,2688);(112,640);(128,2688);(128,2048);(48,2176);(64,2688);(64,3072);(64,1152);(64,2048);(80,2304);(96,1664);(112,2944);(112,2176);(64,1920);(80,2048);(80,1152);(80,1408);(80,2944);(96,3328);(96,1408);(112,2560);(112,1024)] : (num # num) list
End
Definition all_nodes_def:
  all_nodes <=> EVERY (UNCURRY spacing_ok) checked_nodes
End
val _ = cv_auto_trans spacing_ok_def;
Theorem all_55_nodes:
  EVERY (UNCURRY spacing_ok) checked_nodes
Proof
  REWRITE_TAC [checked_nodes_def,listTheory.EVERY_DEF,pairTheory.UNCURRY_DEF] >>
  rpt conj_tac >> CONV_TAC cv_eval
QED
