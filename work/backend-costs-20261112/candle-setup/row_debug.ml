g `Zvalid s /\ Zvalid b /\ InputWell x /\ OutputWell y ==>
  (Zholds (Zcheck s b x y) <=> Icheck (Zdecode s) (Zdecode b)
   (Zdecode (fstc x)) (Zdecode (fstc (sndc x))) (Zdecode (fstc (sndc (sndc x)))) (Zdecode (fstc (sndc (sndc (sndc x))))) (Zdecode (fstc (sndc (sndc (sndc (sndc x)))))) (Zdecode (fstc (sndc (sndc (sndc (sndc (sndc x))))))) (Zdecode (fstc y)) (Zdecode (fstc (sndc y))) (Zdecode (fstc (sndc (sndc y)))) (Zdecode (fstc (sndc (sndc (sndc y))))))`;;
e (REWRITE_TAC [input_well;output_well] THEN STRIP_TAC THEN ASM_SIMP_TAC ([zcheck;icheck;iwithin;LET_DEF;LET_END_DEF] @ encoding_rules));;
