Theory Blue
Ancestors integer list cv_std
Libs cv_transLib
val _ = numLib.prefer_num ();
Definition blue_mul_def:
  blue_mul (a:int,b:int) (x:int,y:int) =
    let t=a*(x+y) in
    ((t-y*(a+b)+130370302485407109521180524058200202307293977194619920040712988758680403184853549195737432064) / 260740604970814219042361048116400404614587954389239840081425977517360806369707098391474864128, (t+x*(b-a)+130370302485407109521180524058200202307293977194619920040712988758680403184853549195737432064) / 260740604970814219042361048116400404614587954389239840081425977517360806369707098391474864128)
End
Definition blue_add_def:
  blue_add (a:int,b:int) (x:int,y:int) = (a+x,b+y)
End
Definition blue_sub_def:
  blue_sub (a:int,b:int) (x:int,y:int) = (a-x,b-y)
End
Definition blue_conj_def:
  blue_conj (a:int,b:int) = (a,-b)
End
Definition blue_even_def:
  (blue_even [] = []) /\
  (blue_even [x] = [x]) /\
  (blue_even (x::y::xs) = x::blue_even xs)
End
Definition blue_odd_def:
  (blue_odd [] = []) /\
  (blue_odd [x] = []) /\
  (blue_odd (x::y::xs) = y::blue_odd xs)
End
Definition blue_zip_mul_def:
  (blue_zip_mul [] ys = []) /\
  (blue_zip_mul (x::xs) ys = case ys of [] => [] | y::rest => blue_mul x y::blue_zip_mul xs rest)
End
Definition blue_zip_add_def:
  (blue_zip_add [] ys = []) /\
  (blue_zip_add (x::xs) ys = case ys of [] => [] | y::rest => blue_add x y::blue_zip_add xs rest)
End
Definition blue_zip_sub_def:
  (blue_zip_sub [] ys = []) /\
  (blue_zip_sub (x::xs) ys = case ys of [] => [] | y::rest => blue_sub x y::blue_zip_sub xs rest)
End
Definition blue_fft_def:
  (blue_fft 0 roots xs = xs) /\
  (blue_fft (SUC n) roots xs =
    let r = blue_even roots;
        a = blue_fft n r (blue_even xs);
        b = blue_zip_mul roots (blue_fft n r (blue_odd xs))
    in blue_zip_add a b ++ blue_zip_sub a b)
End
Definition blue_conjs_def:
  (blue_conjs [] = []) /\
  (blue_conjs (x::xs) = blue_conj x::blue_conjs xs)
End
Definition blue_run_def:
  blue_run roots chirps kernel xs =
    let pre = blue_zip_mul chirps xs ++ REPLICATE 524 (0,0);
        fwd = blue_fft 10 roots pre;
        prod = blue_zip_mul kernel fwd;
        inv = blue_fft 10 (blue_conjs roots) prod
    in blue_zip_mul chirps inv
End
val blue_pre_def = cv_trans_pre "blue_mul_pre" blue_mul_def;
Theorem blue_mul_pre_ok[cv_pre]:
   !w z. blue_mul_pre w z
Proof
   rpt gen_tac >> PairCases_on `w` >> PairCases_on `z` >> simp [blue_pre_def]
QED
val _ = cv_auto_trans blue_run_def;

