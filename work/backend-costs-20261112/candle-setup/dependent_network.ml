(* A dependent integer network, not an FFT or zero-count certificate. *)
(* The default simplifier's conditional depth is three. Validity of these
   nested expressions needs a larger search depth, with ordinary proofs. *)
let dasm_simp ths = ASM (fun thl -> CONV_TAC
  (GEN_SIMPLIFY_CONV TOP_DEPTH_SQCONV (basic_ss []) 24 thl)) ths;;
let dcomplex = new_definition
 `Dcomplex z <=> Zvalid (fstc z) /\ Zvalid (sndc z)`;;
let dbutterfly = new_definition
 `Dbutterfly s u v w =
   let ur = fstc u in let ui = sndc u in
   let vr = fstc v in let vi = sndc v in
   let wr = fstc w in let wi = sndc w in
   let t = Zmul wr (Zadd vr vi) in
   let a = Zmul vi (Zadd wr wi) in
   let b = Zmul vr (Zsub wi wr) in
   let qr = Dround s (Zsub t a) in
   let qi = Dround s (Zadd t b) in
   pairc (pairc (Dnorm (Zadd ur qr)) (Dnorm (Zadd ui qi)))
         (pairc (Dnorm (Zsub ur qr)) (Dnorm (Zsub ui qi)))`;;
let dbutterfly_valid = prove
 (`Dcomplex u /\ Dcomplex v /\ Dcomplex w ==>
   Dcomplex (fstc (Dbutterfly (numc n) u v w)) /\
   Dcomplex (sndc (Dbutterfly (numc n) u v w))`,
  REWRITE_TAC [dcomplex] THEN STRIP_TAC THEN
  dasm_simp [dbutterfly;LET_DEF;LET_END_DEF;cexp_fst_def;cexp_snd_def;
    dnorm_valid;zadd_valid;zsub_valid;zmul_valid;dround_valid]);;
let dwithin = new_definition `DIwithin (s:int) (x:int) <=> --s <= x /\ x <= s`;;
let dlocal = new_definition
 `Dlocal (s:int) u v w y <=>
  let ur = Zdecode (fstc u) in let ui = Zdecode (sndc u) in
  let vr = Zdecode (fstc v) in let vi = Zdecode (sndc v) in
  let wr = Zdecode (fstc w) in let wi = Zdecode (sndc w) in
  let pr = Zdecode (fstc (fstc y)) in
  let pi = Zdecode (sndc (fstc y)) in
  let mr = Zdecode (fstc (sndc y)) in
  let mi = Zdecode (sndc (sndc y)) in
  DIwithin s (&2*(ur*s+(vr*wr-vi*wi)-pr*s)) /\
  DIwithin s (&2*(ui*s+(vr*wi+vi*wr)-pi*s)) /\
  DIwithin s (&2*(ur*s-(vr*wr-vi*wi)-mr*s)) /\
  DIwithin s (&2*(ui*s-(vr*wi+vi*wr)-mi*s))`;;
let dnormalize = DEPTH_CONV (CHANGED_CONV (fun tm ->
  if type_of tm = `:int` then INT_POLY_CONV tm else failwith "not integer"));;
let dthree_real = prove
 (`(wr:int)*(vr+vi)-vi*(wr+wi) = vr*wr-vi*wi`,CONV_TAC INT_RING);;
let dthree_imag = prove
 (`(wr:int)*(vr+vi)+vr*(wi-wr) = vr*wi+vi*wr`,CONV_TAC INT_RING);;
let dbutterfly_residual = prove
 (`Dcomplex u /\ Dcomplex v /\ Dcomplex w /\ 0 < n ==>
   Dlocal (&n) u v w (Dbutterfly (numc n) u v w)`,
  REWRITE_TAC [dcomplex] THEN STRIP_TAC THEN
  dasm_simp [dlocal;dbutterfly;LET_DEF;LET_END_DEF;cexp_fst_def;cexp_snd_def;
    dnorm_valid;zadd_valid;zsub_valid;zmul_valid;dround_valid;
    dnorm_decode;zadd_decode;zsub_decode;zmul_decode;dround_decode;
    dthree_real;dthree_imag;dwithin] THEN
  MP_TAC (SPECL [`&n:int`;
    `Zdecode (fstc v)*Zdecode (fstc w)-Zdecode (sndc v)*Zdecode (sndc w):int`]
    dround_residual) THEN
  MP_TAC (SPECL [`&n:int`;
    `Zdecode (fstc v)*Zdecode (sndc w)+Zdecode (sndc v)*Zdecode (fstc w):int`]
    dround_residual) THEN
  ASM_REWRITE_TAC [INT_OF_NUM_LT] THEN REPEAT STRIP_TAC THEN
  RULE_ASSUM_TAC (CONV_RULE dnormalize) THEN CONV_TAC dnormalize THEN
  ASM_INT_ARITH_TAC);;

let dlength = new_recursive_definition cval_RECURSION
 `(Dlength (numc n) = 0) /\
  (Dlength (pairc x xs) = SUC (Dlength xs))`;;
let dsize_rec = new_recursive_definition cval_RECURSION
 `(Dsize (numc n) = numc 0) /\
  (Dsize (pairc x xs) = (numc 1) + Dsize xs)`;;
let dsize = prove
 (`Dsize xs = ifc (ispairc xs) ((numc 1) + Dsize (sndc xs)) (numc 0)`,
  STRUCT_CASES_TAC (SPEC `xs:cval` (cases "cval")) THEN
  REWRITE_TAC [dsize_rec;cexp_ispair_def;cexp_snd_def;cexp_if_def;ONE]);;
let dsize_exact = prove
 (`!xs. Dsize xs = numc (Dlength xs)`,
  MATCH_MP_TAC cval_INDUCT THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC [dsize_rec;dlength;cexp_add_def;ADD1;ADD_SYM]);;
let dwell = new_recursive_definition cval_RECURSION
 `(Dwell (numc n) <=> n = 0) /\
  (Dwell (pairc x xs) <=> Dcomplex x /\ Dwell xs)`;;

let dappend_rec = new_recursive_definition cval_RECURSION
 `(Dappend (numc n) ys = ys) /\
  (Dappend (pairc x xs) ys = pairc x (Dappend xs ys))`;;
let dappend = prove
 (`Dappend xs ys = ifc (ispairc xs)
    (pairc (fstc xs) (Dappend (sndc xs) ys)) ys`,
  STRUCT_CASES_TAC (SPEC `xs:cval` (cases "cval")) THEN
  REWRITE_TAC [dappend_rec;cexp_ispair_def;cexp_fst_def;cexp_snd_def;
    cexp_if_def;ONE]);;
let drotate = new_definition
 `Drotate xs = ifc (ispairc xs)
    (Dappend (sndc xs) (pairc (fstc xs) (numc 0))) (numc 0)`;;
let dlayer_rec = new_recursive_definition cval_RECURSION
 `(Dlayer (numc n) xs s = xs) /\
  (Dlayer (pairc w ws) xs s =
    ifc (ispairc xs)
      (ifc (ispairc (sndc xs))
        (let y = Dbutterfly s (fstc xs) (fstc (sndc xs)) w in
         pairc (fstc y) (pairc (sndc y)
           (Dlayer ws (sndc (sndc xs)) s))) xs) xs)`;;
let dlayer = prove
 (`Dlayer ws xs s = ifc (ispairc ws)
   (ifc (ispairc xs) (ifc (ispairc (sndc xs))
     (let y = Dbutterfly s (fstc xs) (fstc (sndc xs)) (fstc ws) in
      pairc (fstc y) (pairc (sndc y)
        (Dlayer (sndc ws) (sndc (sndc xs)) s))) xs) xs) xs`,
  STRUCT_CASES_TAC (SPEC `ws:cval` (cases "cval")) THEN
  REWRITE_TAC [dlayer_rec;cexp_ispair_def;cexp_fst_def;cexp_snd_def;
    cexp_if_def;ONE]);;
let drun_rec = new_recursive_definition cval_RECURSION
 `(Drun (numc n) xs ws s = xs) /\
  (Drun (pairc h clock) xs ws s =
    Drun clock (Drotate (Dlayer ws xs s)) ws s)`;;
let drun = prove
 (`Drun clock xs ws s = ifc (ispairc clock)
    (Drun (sndc clock) (Drotate (Dlayer ws xs s)) ws s) xs`,
  STRUCT_CASES_TAC (SPEC `clock:cval` (cases "cval")) THEN
  REWRITE_TAC [drun_rec;cexp_ispair_def;cexp_snd_def;cexp_if_def;ONE]);;
let dbound_rec = new_recursive_definition cval_RECURSION
 `(Dbound (numc n) b = numc 1) /\
  (Dbound (pairc z zs) b = Zand (Zwithin b (fstc z))
     (Zand (Zwithin b (sndc z)) (Dbound zs b)))`;;
let dbound = prove
 (`Dbound xs b = ifc (ispairc xs)
    (Zand (Zwithin b (fstc (fstc xs)))
      (Zand (Zwithin b (sndc (fstc xs))) (Dbound (sndc xs) b))) (numc 1)`,
  STRUCT_CASES_TAC (SPEC `xs:cval` (cases "cval")) THEN
  REWRITE_TAC [dbound_rec;cexp_ispair_def;cexp_fst_def;cexp_snd_def;
    cexp_if_def;ONE]);;
let dchecksum_rec = new_recursive_definition cval_RECURSION
 `(Dchecksum (numc n) = pairc (numc 0) (numc 0)) /\
  (Dchecksum (pairc z zs) = Dnorm
    (Zadd (fstc z) (Zadd (Zmul (pairc (numc 3) (numc 0)) (sndc z))
      (Zmul (pairc (numc 9) (numc 0)) (Dchecksum zs)))))`;;
let dchecksum = prove
 (`Dchecksum xs = ifc (ispairc xs)
    (Dnorm (Zadd (fstc (fstc xs))
      (Zadd (Zmul (pairc (numc 3) (numc 0)) (sndc (fstc xs)))
        (Zmul (pairc (numc 9) (numc 0)) (Dchecksum (sndc xs))))))
    (pairc (numc 0) (numc 0))`,
  STRUCT_CASES_TAC (SPEC `xs:cval` (cases "cval")) THEN
  REWRITE_TAC [dchecksum_rec;cexp_ispair_def;cexp_fst_def;cexp_snd_def;
    cexp_if_def;ONE]);;
let daccept = new_definition
 `Daccept s ws clock xs b expected =
   Zand ((numc 0) lessc s)
     (Zand ((Dsize xs) eqc ((numc 2) * Dsize ws))
       (let ys = Drun clock xs ws s in
        Zand (Dbound ys b) (Zeq (Dchecksum ys) expected)))`;;
let ddefs = map SPEC_ALL [dnorm;ddiv;dround;dbutterfly;dsize;dappend;
  drotate;dlayer;drun;dbound;dchecksum;daccept] @ zdefs;;
check_axioms ();;
print_string "DEPENDENT_NETWORK_DEFINITIONS_DONE\n";;
