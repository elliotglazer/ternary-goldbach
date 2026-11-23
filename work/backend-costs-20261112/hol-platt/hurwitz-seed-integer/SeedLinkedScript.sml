Theory SeedLinked
Ancestors SeedPhases
Libs cv_transLib seedbench

Definition bounds_ok_def:
  (bounds_ok avail ([]:(num#num#num) list) <=> T) /\
  (bounds_ok avail ((n,l,cap)::rs) <=>
    n+(if l=0 then 0 else 1)<=avail /\ cap<=avail /\ bounds_ok cap rs)
End
Definition raw_pairs_def:
  (raw_pairs []=[]:(num#num) list) /\ (raw_pairs [x]=[]) /\
  (raw_pairs (x::y::xs)=(x,y)::raw_pairs xs)
End
Definition scaled_coefficients_def:
  (scaled_coefficients D ([]:(int#int) list) = SOME ([]:int list)) /\
  (scaled_coefficients D ((a,b)::rest) =
    let w=nearq (D*a) b in
    if b<=0 \/ w*b <> D*a then NONE else
    case scaled_coefficients D rest of NONE=>NONE | SOME xs=>SOME (w::0::xs))
End
Definition weighted_coefficients_def:
  (weighted_coefficients 0 (xs:int list)=case xs of []=>0 | a::rest=>a) /\
  (weighted_coefficients (SUC n) xs = case xs of []=>0 | a::rest=>
    a+ &(n+2)*weighted_coefficients n rest)
End
Definition inverse_identities_def:
  (inverse_identities 0 (xs:int list) <=> T) /\
  (inverse_identities (SUC n) xs <=>
    weighted_coefficients (SUC n) xs=0 /\ inverse_identities n xs)
End
Definition bern_ok_def:
  bern_ok bs <=>
    let n=2*LENGTH bs; half=(&(FACT (n+1)):int)**2; D=2*half in
    case scaled_coefficients D bs of NONE=>F | SOME zs=>
      inverse_identities n (D::(-half)::zs)
End
Definition make_pool_def:
  (make_pool f a j [] = SOME ([]:((int#int)#(int#int)) list)) /\
  (make_pool f a j ((k,mag)::rest) =
    if ~root_ok f a k mag then NONE else
    case make_pool f (a+f) j rest of NONE => NONE | SOME tail =>
      let (sx,sy)=base_step f a k;
          w=powstep 17 j (&mag,0) (sx,sy)
      in SOME ((w,em_scale w sx sy grid)::tail))
End
Definition linked_ok_def:
  linked_ok f c j keys roots bs e1 e2 <=>
    j+1 < 2**17 /\ EVEN (LENGTH roots) /\
    let ks=specifications keys; rs=raw_pairs roots; coeff=ipairs bs in
    LENGTH keys=3*LENGTH ks /\ bounds_ok (LENGTH rs) ks /\ bern_ok coeff /\
    EVERY (\(n,l,k). l <= LENGTH coeff) ks /\
    LENGTH e1=2*LENGTH ks /\ LENGTH e2=2*LENGTH ks /\
    case make_pool f (f+c) j rs of NONE=>F | SOME pool =>
       output_rows (&f) (&(f+c)) (&j) coeff 0 (grid,0) (MAP FST pool) ks = ipairs e1 /\
       output_rows (&f) (&(f+c)) (&(j+1)) coeff 0 (grid,0) (MAP SND pool) ks = ipairs e2
End
val _=cv_transLib.cv_auto_trans linked_ok_def;
open seedbench;
val io=TextIO.openIn "linked.txt";
fun tok()=case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "missing linked case";
fun num s=let val n=nat s in EVAL(mk_comb(enc_for(type_of n),n)) end;
fun argument name=literal(named name (listSyntax.mk_list(map nat (tok()),numSyntax.num)));
fun verify expected=let
  val t=cpu()
  val [id,f,c,j]=tok()
  val _=if id=expected then () else raise Fail "linked order"
  val keys=argument ("keys_"^id)
  val roots=argument ("roots_"^id)
  val bs=argument ("weights_"^id)
  val e1=argument ("first_"^id)
  val e2=argument ("second_"^id)
  val args=map num [f,c,j]@[keys,roots,bs,e1,e2]
  val ready=cpu()
  val th=joined ``linked_ok`` args
  val _=save_thm("linked_pair_"^id,th)
  in print("LINKED "^id^" "^Real.toString(ready-t)^" "^Real.toString(cpu()-ready)^"\n") end;
val _=List.app verify ["1","6"];
val _=TextIO.closeIn io;
val _=print "SEED_LINKED_DONE\n";
