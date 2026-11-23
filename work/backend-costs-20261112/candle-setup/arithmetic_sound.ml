let znat = new_recursive_definition cval_RECURSION
 `(Znat (numc n) = n) /\ (Znat (pairc p q) = 0)`;;
let zdecode = new_definition `Zdecode x = &(Znat (fstc x)) - &(Znat (sndc x)):int`;;
let decode_rules = [zdecode;znat;cexp_fst_def;cexp_snd_def;cexp_add_def;
                    cexp_mul_def;GSYM INT_OF_NUM_ADD;GSYM INT_OF_NUM_MUL];;
let zadd_sound = prove
 (`Zdecode (Zadd (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) =
   (&a - &b) + (&c - &d)`,
  REWRITE_TAC (zadd::decode_rules) THEN INT_ARITH_TAC);;
let zsub_sound = prove
 (`Zdecode (Zsub (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) =
   (&a - &b) - (&c - &d)`,
  REWRITE_TAC (zsub::decode_rules) THEN INT_ARITH_TAC);;
let zmul_sound = prove
 (`Zdecode (Zmul (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) =
   (&a - &b) * (&c - &d)`,
  REWRITE_TAC (zmul::decode_rules) THEN CONV_TAC INT_RING);;
check_axioms ();;
print_string "ARITHMETIC_SOUND_DONE\n";;
