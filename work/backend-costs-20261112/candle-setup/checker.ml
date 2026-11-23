(* Difference-of-naturals encoding. Decoding soundness is a separate obligation. *)
let zand = new_definition `Zand p q = ifc p q (numc 0)`;;
let zneg = new_definition `Zneg x = pairc (sndc x) (fstc x)`;;
let zadd = new_definition
 `Zadd x y = pairc (fstc x + fstc y) (sndc x + sndc y)`;;
let zsub = new_definition
 `Zsub x y = pairc (fstc x + sndc y) (sndc x + fstc y)`;;
let zmul = new_definition
 `Zmul x y = pairc (fstc x * fstc y + sndc x * sndc y)
                       (fstc x * sndc y + sndc x * fstc y)`;;
let zeq = new_definition
 `Zeq x y = (fstc x + sndc y) eqc (fstc y + sndc x)`;;
let zle = new_definition
 `Zle x y = ifc ((fstc y + sndc x) lessc (fstc x + sndc y)) (numc 0) (numc 1)`;;
let zlt = new_definition
 `Zlt x y = (fstc x + sndc y) lessc (fstc y + sndc x)`;;
let zwithin = new_definition `Zwithin b x = Zand (Zle (Zneg b) x) (Zle x b)`;;
let zcheck = new_definition
 `Zcheck s b x y =
   let ur = fstc x in let ui = fstc (sndc x) in
   let vr = fstc (sndc (sndc x)) in let vi = fstc (sndc (sndc (sndc x))) in
   let wr = fstc (sndc (sndc (sndc (sndc x)))) in
   let wi = fstc (sndc (sndc (sndc (sndc (sndc x))))) in
   let pr = fstc y in let pi = fstc (sndc y) in
   let mr = fstc (sndc (sndc y)) in let mi = fstc (sndc (sndc (sndc y))) in
   let two = pairc (numc 2) (numc 0) in
   let four = pairc (numc 4) (numc 0) in
   let t = Zmul wr (Zadd vr vi) in
   let u = Zmul vi (Zadd wr wi) in
   let v = Zmul vr (Zsub wi wr) in
   let rr = Zsub t u in let ii = Zadd t v in
   let ob = Zmul four b in let rb = Zmul ob s in
   let re = Zmul two (Zsub rr (Zmul (Zsub pr ur) s)) in
   let im = Zmul two (Zsub ii (Zmul (Zsub pi ui) s)) in
   Zand (Zwithin b ur) (Zand (Zwithin b ui)
   (Zand (Zwithin b vr) (Zand (Zwithin b vi)
   (Zand (Zwithin s wr) (Zand (Zwithin s wi)
   (Zand (Zwithin ob pr) (Zand (Zwithin ob pi)
   (Zand (Zwithin ob mr) (Zand (Zwithin ob mi)
   (Zand (Zwithin rb t) (Zand (Zwithin rb u) (Zand (Zwithin rb v)
   (Zand (Zeq (Zadd pr mr) (Zmul two ur))
   (Zand (Zeq (Zadd pi mi) (Zmul two ui))
   (Zand (Zle (Zneg s) re) (Zand (Zlt re s)
   (Zand (Zle (Zneg s) im) (Zlt im s))))))))))))))))))`;;

let zstage_rec = new_recursive_definition cval_RECURSION
 `(Zstage (numc n) ys s b = Zand ((numc n) eqc (numc 0)) (ys eqc (numc 0))) /\
  (Zstage (pairc x xs) ys s b = ifc (ispairc ys)
     (Zand (Zcheck s b x (fstc ys)) (Zstage xs (sndc ys) s b)) (numc 0))`;;
let zstage = prove
 (`Zstage xs ys s b = ifc (ispairc xs)
     (ifc (ispairc ys) (Zand (Zcheck s b (fstc xs) (fstc ys))
                           (Zstage (sndc xs) (sndc ys) s b)) (numc 0))
     (Zand (xs eqc (numc 0)) (ys eqc (numc 0)))`,
  STRUCT_CASES_TAC (SPEC `xs:cval` (cases "cval")) THEN
  REWRITE_TAC [zstage_rec; cexp_ispair_def; cexp_fst_def; cexp_snd_def;
               cexp_if_def; ONE]);;
let zdefs = map SPEC_ALL [zand;zneg;zadd;zsub;zmul;zeq;zle;zlt;zwithin;zcheck;zstage];;
let bench_mark label =
  let a = Bytes.create (String.length label + 1) in
  let _ = Bytes.blit_string label 0 a 0 (String.length label) in
  Cake.Runtime.customFFI "bench_time" a;;
let rec repeat_compute n tm =
  if n = 0 then () else
  let th = compute zdefs tm in
  let _ = if rand (concl th) = `numc 1` then () else failwith "checker rejected" in
  repeat_compute (n-1) tm;;
print_string "CHECKER_DEFINITIONS_DONE\n";;
