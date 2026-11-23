let icheck = new_definition
 `Icheck (s:int) (b:int) (ur:int) (ui:int) (vr:int) (vi:int) (wr:int) (wi:int)
         (pr:int) (pi:int) (mr:int) (mi:int) <=>
   let t = wr*(vr+vi) in let u = vi*(wr+wi) in let v = vr*(wi-wr) in
   let rr = t-u in let ii = t+v in
   Iwithin b ur /\ Iwithin b ui /\ Iwithin b vr /\ Iwithin b vi /\
   Iwithin s wr /\ Iwithin s wi /\
   Iwithin (&4*b) pr /\ Iwithin (&4*b) pi /\ Iwithin (&4*b) mr /\ Iwithin (&4*b) mi /\
   Iwithin (&4*b*s) t /\ Iwithin (&4*b*s) u /\ Iwithin (&4*b*s) v /\
   pr+mr = &2*ur /\ pi+mi = &2*ui /\
   --s <= &2*(rr-(pr-ur)*s) /\ &2*(rr-(pr-ur)*s) < s /\
   --s <= &2*(ii-(pi-ui)*s) /\ &2*(ii-(pi-ui)*s) < s`;;
let input_well = new_definition `InputWell x <=> Zvalid (fstc x) /\ Zvalid (fstc (sndc x)) /\ Zvalid (fstc (sndc (sndc x))) /\ Zvalid (fstc (sndc (sndc (sndc x)))) /\ Zvalid (fstc (sndc (sndc (sndc (sndc x))))) /\ Zvalid (fstc (sndc (sndc (sndc (sndc (sndc x))))))`;;
let output_well = new_definition `OutputWell y <=> Zvalid (fstc y) /\ Zvalid (fstc (sndc y)) /\ Zvalid (fstc (sndc (sndc y))) /\ Zvalid (fstc (sndc (sndc (sndc y))))`;;
let zdecode_pair = prove
 (`Zdecode (pairc (numc a) (numc b)) = (&a - &b:int)`,
  REWRITE_TAC decode_rules);;
let encoding_rules = [zand_holds;zwithin_decode;zeq_decode;zlt_decode;zle_decode;
  zadd_decode;zsub_decode;zmul_decode;zneg_decode;
  zadd_valid;zsub_valid;zmul_valid;zneg_valid;zvalid_pair;zdecode_pair;INT_SUB_RZERO];;
let zcheck_exact = prove
 (`Zvalid s /\ Zvalid b /\ InputWell x /\ OutputWell y ==>
  (Zholds (Zcheck s b x y) <=> Icheck (Zdecode s) (Zdecode b)
   (Zdecode (fstc x)) (Zdecode (fstc (sndc x))) (Zdecode (fstc (sndc (sndc x)))) (Zdecode (fstc (sndc (sndc (sndc x))))) (Zdecode (fstc (sndc (sndc (sndc (sndc x)))))) (Zdecode (fstc (sndc (sndc (sndc (sndc (sndc x))))))) (Zdecode (fstc y)) (Zdecode (fstc (sndc y))) (Zdecode (fstc (sndc (sndc y)))) (Zdecode (fstc (sndc (sndc (sndc y))))))`,
  REWRITE_TAC [input_well;output_well] THEN STRIP_TAC THEN
  ASM_SIMP_TAC ([zcheck;icheck;iwithin;LET_DEF;LET_END_DEF] @ encoding_rules));;
check_axioms ();;
print_string "ROW_EXACT_DONE\n";;
