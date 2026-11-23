from pathlib import Path
H=Path(__file__).resolve().parent
def field(x,i):return '(fstc '+('(sndc '*i)+x+(')'*i)+')'
xf=[field('x',i) for i in range(6)];yf=[field('y',i) for i in range(4)]
text=r'''let iwithin = new_definition `Iwithin (b:int) x <=> --b <= x /\ x <= b`;;
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
'''
text+='let input_well = new_definition `InputWell x <=> '+' /\\ '.join('Zvalid '+f for f in xf)+'`;;\n'
text+='let output_well = new_definition `OutputWell y <=> '+' /\\ '.join('Zvalid '+f for f in yf)+'`;;\n'
text+='''let zdecode_pair = prove
 (`Zdecode (pairc (numc a) (numc b)) = (&a - &b:int)`,
  REWRITE_TAC decode_rules);;
let encoding_rules = [zand_holds;zwithin_decode;zeq_decode;zlt_decode;zle_decode;
  zadd_decode;zsub_decode;zmul_decode;zneg_decode;
  zadd_valid;zsub_valid;zmul_valid;zneg_valid;zvalid_pair;zdecode_pair;INT_SUB_RZERO];;
'''
text+='let zcheck_exact = prove\n (`Zvalid s /\\ Zvalid b /\\ InputWell x /\\ OutputWell y ==>\n'
text+='  (Zholds (Zcheck s b x y) <=> Icheck (Zdecode s) (Zdecode b)\n   '
text+=' '.join('(Zdecode '+f+')' for f in xf+yf)+')`,\n'
text+='''  REWRITE_TAC [input_well;output_well] THEN STRIP_TAC THEN
  ASM (fun ths -> CONV_TAC
    (GEN_SIMPLIFY_CONV TOP_DEPTH_SQCONV (basic_ss []) 12 ths))
    ([zcheck;icheck;iwithin;LET_DEF;LET_END_DEF] @ encoding_rules) THEN
  REWRITE_TAC [INT_MUL_ASSOC]);;
check_axioms ();;
print_string "ROW_EXACT_DONE\\n";;
'''
(H/'row_sound.ml').write_text(text)
