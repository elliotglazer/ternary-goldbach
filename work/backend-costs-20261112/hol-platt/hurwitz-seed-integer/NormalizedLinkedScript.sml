Theory NormalizedLinked
Ancestors NormalizedSeed SeedLinked
Libs cv_transLib seedbench

Definition normalized_link_def:
  normalized_link f c j (r:num) p keys roots bs e1 e2 <=>
    r=64 /\ p<384 /\ j+1 < 2**17 /\ EVEN (LENGTH roots) /\
    let ks=specifications keys; rs=raw_pairs roots; coeff=ipairs bs in
    LENGTH keys=3*LENGTH ks /\ bounds_ok (LENGTH rs) ks /\ bern_ok coeff /\
    EVERY (\(n,l,k). l <= LENGTH coeff) ks /\
    LENGTH e1=2*LENGTH ks /\ LENGTH e2=2*LENGTH ks /\
    case make_pool f (f+c) j rs of NONE=>F | SOME pool =>
      let quantum = (2:int)**(384-p) in
      normalized_rows (&r) quantum (&f) (&(f+c)) (&j) coeff 0 (grid,0)
        (MAP FST pool) ks = ipairs e1 /\
      normalized_rows (&r) quantum (&f) (&(f+c)) (&(j+1)) coeff 0 (grid,0)
        (MAP SND pool) ks = ipairs e2
End
val _=cv_auto_trans normalized_link_def;
open seedbench;
val io=TextIO.openIn "normalized-linked.txt";
fun fields()=case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "missing normalized pair";
fun scalar s=let val n=nat s in EVAL(mk_comb(enc_for(type_of n),n)) end;
fun vector name=literal(named name(listSyntax.mk_list(map nat(fields()),numSyntax.num)));
fun verify expected=let
  val t=cpu()
  val id::args=fields()
  val _=if id=expected andalso length args=5 then () else raise Fail "wrong group"
  val keys=vector("keys_"^id)
  val roots=vector("roots_"^id)
  val bs=vector("bernoulli_"^id)
  val first=vector("first_"^id)
  val second=vector("second_"^id)
  val ready=cpu()
  val th=joined ``normalized_link`` (map scalar args@[keys,roots,bs,first,second])
  val _=save_thm("normalized_pair_"^id,th)
  in print("LINKED "^id^" "^Real.toString(ready-t)^" "^Real.toString(cpu()-ready)^"\n") end;
val _=List.app verify ["1","6"];
val _=TextIO.closeIn io;
val _=print "NORMALIZED_LINK_DONE\n";
