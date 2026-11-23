Theory GridSigns
Ancestors FullCount KernelWeights sptree cv_std integer list arithmetic
Libs cv_transLib intLib

Definition digit_def:
  digit (base:num) unit word = ((&(word MOD base) - &(base DIV 2)):int,unit:num)
End
Definition four_def:
  four base unit word =
    let a=word DIV base; b=a DIV base; c=b DIV base in
      [digit base unit word; digit base unit a; digit base unit b; digit base unit c]
End
Definition grid_def:
  (grid ([]:(num#num#num#num list) list) = []) /\
  (grid ((width,ex,count,words)::rest) =
     TAKE count (FLAT (MAP (four (2**width) (2**ex)) words)) ++ grid rest)
End
Definition strict_code_def:
  strict_code (z:int) (rad:num) = if &rad<z then 2:num else if z < -&rad then 1 else 0
End
Definition coarse_def:
  coarse tab rad j = case sptree$lookup (128+j) tab of NONE => 0
    | SOME (q,u) => strict_code (q* &u) (rad+u)
End
Definition dot_window_def:
  (dot_window tab j ([]:int list) a cap = SOME (a:int,cap:num)) /\
  (dot_window tab j (w::ws) a cap = case sptree$lookup j tab of NONE => NONE
    | SOME (q,u) => dot_window tab (SUC j) ws (a + w*q* &u) (MAX cap u))
End
Definition at_repair_def:
  at_repair tab ks t k = case sptree$lookup k ks of NONE => 0:num
    | SOME (r,offset,den,err,ws) =>
        let start=129+t DIV 4096 in
        if 0<offset /\ offset=t MOD 4096 /\ r DIV 2 <= start /\ LENGTH ws=r
        then (case dot_window tab (start - r DIV 2) ws 0 0 of NONE => 0
               | SOME (z,cap) => strict_code z (den*(err+5*cap)))
        else 0
End
Definition repairs_def:
  (repairs tab ks [] acc = SOME acc) /\
  (repairs tab ks ((t,k)::js) acc =
    let v=at_repair tab ks t k in
    if v=0 \/ IS_SOME (sptree$lookup t acc) then NONE
    else repairs tab ks js (sptree$insert t v acc))
End
Definition sign_at_def:
  sign_at tab fixes rad t = if t MOD 4096=0 then coarse tab rad (t DIV 4096)
    else case sptree$lookup t fixes of NONE => 0 | SOME v => v
End
Definition match_word_def:
  (match_word tab fixes rad pos 0 word <=> word=0) /\
  (match_word tab fixes rad pos (SUC len) word <=>
     sign_at tab fixes rad pos = 1 + word MOD 2 /\
     match_word tab fixes rad (pos+4096) len (word DIV 2))
End
Definition match_runs_def:
  (match_runs tab fixes rad [] <=> T) /\
  (match_runs tab fixes rad ((pos,len,word)::rs) <=>
    match_word tab fixes rad pos len word /\ match_runs tab fixes rad rs)
End
Definition valid_kernels_def:
  (valid_kernels ([]:(num#num#num#num#int list)list) <=> T) /\
  (valid_kernels ((r,o1,d,e,ws)::ks) <=>
     KernelWeights$kernel_ok r o1 (&d) ws /\ KernelWeights$radius_ok r e /\ valid_kernels ks)
End
Definition coarse_radius_ok_def:
  coarse_radius_ok (rad:num) <=>
    2*(512*4*3**64*2**80) + 5*524288*2**220 <= rad*(512*4*3**64*2**80)
End
Definition channel_def:
  channel tiles kernels jobs rad main aux ea eb =
    let xs=grid tiles; tab=sptree$fromList xs; ks=sptree$fromList kernels;
        cut=84224*4096; last=84864*4096 in
    if LENGTH xs <> 85121 then F else
      case repairs tab ks jobs sptree$LN of NONE => F | SOME fixes =>
        coarse_radius_ok rad /\
        0<ea /\ ea<=2 /\ 0<eb /\ eb<=2 /\
        sign_at tab fixes rad 0=ea /\ sign_at tab fixes rad 1=ea /\
        sign_at tab fixes rad cut=eb /\ sign_at tab fixes rad (cut-1)=eb /\
        sign_at tab fixes rad last <> 0 /\
        match_runs tab fixes rad main /\ match_runs tab fixes rad aux
End
val _=cv_auto_trans channel_def;

Theorem code_margin:
  (!z r. strict_code z r = 2 <=> &r < z) /\
  (!z r. strict_code z r = 1 <=> z < -&r)
Proof
  rw[strict_code_def] >> intLib.ARITH_TAC
QED

Theorem coarse_interval_margin:
  !z x:int. !e r:num. ABS(x-z) <= &e ==>
    ((strict_code z (r+e) = 2 ==> &r < x) /\
     (strict_code z (r+e) = 1 ==> x < -&r))
Proof
  rpt gen_tac >> REWRITE_TAC[code_margin,INT_ADD,INT_ABS] >>
  COND_CASES_TAC >> intLib.ARITH_TAC
QED
