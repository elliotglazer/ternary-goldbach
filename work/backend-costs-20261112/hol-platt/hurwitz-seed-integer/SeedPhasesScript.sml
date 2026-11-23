Theory SeedPhases
Ancestors SeedReplay
Libs cv_transLib seedbench

Definition big_def:
  big = (2:int)**416
End
Definition logs_def:
  (logs 0 u v (c:int) = c) /\
  (logs (SUC k) u v c = logs k u v (nearq big (&(2*k+1))+nearq (c*u*u) (v*v)))
End
Definition log_mant_def:
  log_mant u v = nearq (2*u*logs 144 u v 0) v
End
Definition expon_def:
  (expon 0 t (w:int#int) = w) /\
  (expon (SUC k) t w = expon k t (em_add (big,0) (em_scale w 0 t (64*big * &(SUC k)))))
End
Definition base_step_def:
  base_step (f:num) (a:num) k =
    let v = &(f*2**k):int;
        lg = &k*log_mant 1 3 + log_mant (&a-v) (&a+v);
        (x,y) = expon 96 (-5*lg) (big,0)
    in (nearq x ((2:int)**32),nearq y ((2:int)**32))
End
Definition root_ok_def:
  root_ok (f:num) a k mag <=>
    0<f /\ f*2**k<=a /\ a<2*(f*2**k) /\
    a*mag**2 <= f*2**768 /\ f*2**768 < a*(mag+1)**2
End
Definition base_ok_def:
  base_ok f a k mag sx sy <=>
    root_ok f a k mag /\ base_step f a k=(ndecode sx,ndecode sy)
End
Definition powstep_def:
  (powstep 0 j z step = z:int#int) /\
  (powstep (SUC k) j z (x,y) = if j=0 then z else
    let nz = if ODD j then em_scale z x y grid else z
    in powstep k (j DIV 2) nz (em_scale (x,y) x y grid))
End
Definition start_ok_def:
  start_ok sx sy mag j zx zy <=>
    j<2**17 /\ powstep 17 j (&mag,0) (ndecode sx,ndecode sy)=(ndecode zx,ndecode zy)
End
Definition march_def:
  (march 0 x y w = w:int#int) /\
  (march (SUC k) x y w = march k x y (em_scale w x y grid))
End
Definition march_ok_def:
  march_ok sx sy zx zy k ex ey <=>
    march k (ndecode sx) (ndecode sy) (ndecode zx,ndecode zy) = (ndecode ex,ndecode ey)
End
Definition window_def:
  (window 0 x y w = []:(int#int) list) /\
  (window (SUC k) x y w = let next=em_scale w x y grid in next::window k x y next)
End
Definition window_ok_def:
  window_ok sx sy zx zy es <=>
    window 32 (ndecode sx) (ndecode sy) (ndecode zx,ndecode zy) = ipairs es
End
val _=List.app (fn t=>ignore(cv_transLib.cv_auto_trans t)) [base_ok_def,start_ok_def,march_ok_def,window_ok_def];
structure replay=seedbench;
open seedbench;
val io=TextIO.openIn "phase-cases.txt";
fun tok()=case TextIO.inputLine io of SOME s=>String.tokens Char.isSpace s | NONE=>raise Fail "missing fixture";
fun numenc s=let val n=nat s in EVAL(mk_comb(replay.enc_for(type_of n),n)) end;
fun run lab c args=let val start=cpu() val th=replay.joined c args
  val _=print("PHASE "^lab^" "^Real.toString(cpu()-start)^"\n") in th end;
fun one idx=let
  val [id,f,a,k,mag,sx,sy,j,zx,zy]=tok()
  val _=if id=Int.toString idx then () else raise Fail "order"
  val base=run ("base"^id) ``base_ok`` (map numenc [f,a,k,mag,sx,sy])
  val _=save_thm("step_"^id,base)
  val init=run ("start"^id) ``start_ok`` (map numenc [sx,sy,mag,j,zx,zy])
  val _=save_thm("start_"^id,init)
  fun bench()=let val [n,ex,ey]=tok()
      val args=map numenc [sx,sy,zx,zy,n,ex,ey]
      fun rep i=let val th=run ("march"^id^"_"^n^"_"^Int.toString i) ``march_ok`` args
        in if i=1 then ignore(save_thm("march_"^id^"_"^n,th)) else () end
      in List.app rep [1,2,3] end
  val _=List.app (fn _=>bench()) [1,2,3]
  val w=replay.literal(replay.named ("positions_"^id)(listSyntax.mk_list(map nat (tok()),numSyntax.num)))
  val th=run ("emitted"^id) ``window_ok`` (map numenc [sx,sy,zx,zy]@[w])
  in ignore(save_thm("window_"^id,th)) end;
val _=List.app one [1,2,3,4,5,6];
val _=TextIO.closeIn io;
val _=print "SEED_PHASES_DONE\n";
