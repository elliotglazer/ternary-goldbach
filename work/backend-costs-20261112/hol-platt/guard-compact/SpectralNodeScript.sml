Theory SpectralNode
Ancestors CompactRadii FallbackScore real intreal integer
Libs realLib RealField
val _=realLib.prefer_real();

(* lo and hi bound the effective positive gain in output units per input unit. *)
Definition midpoint_def:
 midpoint (lo:real) hi = (lo+hi)/2
End
Definition halfwidth_def:
 halfwidth (lo:real) hi = (hi-lo)/2
End
Definition nearest_def:
 nearest (x:real) = INT_FLOOR(x+1/2)
End
Definition raw_center_def:
 raw_center (v:int) lo hi = real_of_int v * midpoint lo hi
End
Definition raw_radius_def:
 raw_radius (v:int) (d:int) lo hi =
   abs(real_of_int v)*halfwidth lo hi + real_of_int d*hi
End
Definition node_center_def:
 node_center (v:int) lo hi = nearest(raw_center v lo hi)
End
Definition node_radius_def:
 node_radius (v:int) (d:int) lo hi = raw_radius v d lo hi +
   abs(raw_center v lo hi-real_of_int(node_center v lo hi))
End
Theorem nearest_error:
 !x. abs(x-real_of_int(nearest x))<=1/2
Proof
 gen_tac >> mp_tac (Q.SPEC `x+1/2` INT_FLOOR_BOUNDS') >>
 simp_tac bool_ss [nearest_def,ABS_BOUNDS] >> REAL_ARITH_TAC
QED
Theorem midpoint_error:
 !lo hi gain. 0<=lo /\ lo<=gain /\ gain<=hi ==>
   abs(gain-midpoint lo hi)<=halfwidth lo hi /\
   abs(midpoint lo hi)+halfwidth lo hi = hi
Proof
 rpt gen_tac >> strip_tac >>
 `0<=midpoint lo hi` by (simp[midpoint_def] >> REAL_ASM_ARITH_TAC) >>
 simp[ABS_BOUNDS,midpoint_def,halfwidth_def,abs] >> REAL_ASM_ARITH_TAC
QED
Theorem spectral_raw:
 !v d lo hi x gain. abs(x-real_of_int v)<=real_of_int d /\
  0<=lo /\ lo<=gain /\ gain<=hi ==>
  abs(x*gain-raw_center v lo hi)<=raw_radius v d lo hi
Proof
 rpt gen_tac >> strip_tac >>
 `abs(gain-midpoint lo hi)<=halfwidth lo hi /\ abs(midpoint lo hi)+halfwidth lo hi=hi`
 by metis_tac[midpoint_error] >>
 mp_tac (Q.SPECL [`real_of_int v`,`midpoint lo hi`,`x:real`,`gain:real`,`real_of_int d`,`halfwidth lo hi`] product_radius) >>
 asm_simp_tac bool_ss [raw_center_def,raw_radius_def]
QED
Theorem spectral_node:
 !v d lo hi x gain. abs(x-real_of_int v)<=real_of_int d /\
  0<=lo /\ lo<=gain /\ gain<=hi ==>
  0<=node_radius v d lo hi /\
  abs(x*gain-real_of_int(node_center v lo hi))<=node_radius v d lo hi /\
  node_radius v d lo hi <= raw_radius v d lo hi+1/2
Proof
 rpt gen_tac >> strip_tac >>
 `abs(x*gain-raw_center v lo hi)<=raw_radius v d lo hi` by metis_tac[spectral_raw] >>
 `0<=raw_radius v d lo hi` by metis_tac[ABS_POS,REAL_LE_TRANS] >>
 mp_tac (Q.SPECL [`x*gain-raw_center v lo hi`,`raw_center v lo hi-real_of_int(node_center v lo hi)`] ABS_TRIANGLE) >>
 mp_tac (Q.SPEC `raw_center v lo hi` nearest_error) >>
 `(x*gain-raw_center v lo hi)+(raw_center v lo hi-real_of_int(node_center v lo hi)) =
  x*gain-real_of_int(node_center v lo hi)` by REAL_ARITH_TAC >>
 asm_simp_tac bool_ss [node_radius_def,GSYM node_center_def] >>
 mp_tac (Q.SPEC `raw_center v lo hi-real_of_int(node_center v lo hi)` ABS_POS) >>
 REAL_ASM_ARITH_TAC
QED
Theorem spectral_admit_cons:
 !xs w k f v d lo hi x gain. admitted_r w xs /\
  abs(w*f-real_of_int k)<=1/2 /\ abs(x-real_of_int v)<=real_of_int d /\
  0<=lo /\ lo<=gain /\ gain<=hi ==>
  admitted_r w ((k,node_center v lo hi,f,x*gain,node_radius v d lo hi)::xs)
Proof
  rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`v:int`,`d:int`,`lo:real`,`hi:real`,`x:real`,`gain:real`] spectral_node) >>
 asm_simp_tac bool_ss [admitted_r_def] >> metis_tac[]
QED
Theorem unit_transfer:
 !inunit outunit amp gamma:real. 0<inunit ==>
   (inunit*amp)*(outunit*gamma/inunit)=outunit*(amp*gamma)
Proof
 rpt strip_tac >> `inunit <> 0` by REAL_ASM_ARITH_TAC >> RealField.REAL_ASM_FIELD_TAC
QED

Theorem nearest_tie:
 !z:int. nearest(real_of_int z+1/2)=z+1
Proof
 gen_tac >> simp_tac bool_ss [nearest_def,INT_FLOOR',real_of_int_add,real_of_int_num] >>
 REAL_ARITH_TAC
QED
Theorem scaled_table_cons:
 !xs w k f v d lower upper den input_unit output_unit amp gamma.
   0<input_unit /\ 0<output_unit /\ 0<den /\
   0<=real_of_int lower / den /\
   real_of_int lower / den <= output_unit*gamma/input_unit /\
   output_unit*gamma/input_unit <= real_of_int upper / den /\
   abs(input_unit*amp-real_of_int v)<=real_of_int d /\
   admitted_r w xs /\ abs(w*f-real_of_int k)<=1/2 ==>
   let lo=real_of_int lower/den; hi=real_of_int upper/den in
   admitted_r w ((k,node_center v lo hi,f,output_unit*(amp*gamma),node_radius v d lo hi)::xs)
Proof
 rpt gen_tac >> strip_tac >> simp_tac bool_ss [LET_THM] >>
 mp_tac (Q.SPECL [`xs:(int#int#real#real#real) list`,`w:real`,`k:int`,`f:real`,`v:int`,`d:int`,
   `real_of_int lower/den`,`real_of_int upper/den`,`input_unit*amp`,`output_unit*gamma/input_unit`] spectral_admit_cons) >>
 asm_simp_tac bool_ss [unit_transfer]
QED
