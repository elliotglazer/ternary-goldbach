let zlt_pair = prove
 (`Zholds (Zlt (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) <=>
   (&a - &b:int) < &c - &d`,
  REWRITE_TAC [zlt;cexp_fst_def;cexp_snd_def;cexp_add_def;cexp_less_def;
               GSYM INT_OF_NUM_LT;GSYM INT_OF_NUM_ADD] THEN
  COND_CASES_TAC THEN ASM_REWRITE_TAC [zholds_num;NOT_SUC] THEN ASM_INT_ARITH_TAC);;
check_axioms ();;
print_string "ENCODING_SOUND_DONE\n";;
