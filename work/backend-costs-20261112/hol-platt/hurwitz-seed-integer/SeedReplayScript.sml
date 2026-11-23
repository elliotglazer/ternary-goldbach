Theory SeedReplay
Ancestors list arithmetic integer cv_std
Libs cv_transLib intLib

Definition ndecode_def:
  ndecode (z:num) = if EVEN z then (&(z DIV 2):int) else -(&(z DIV 2))
End

Definition ipairs_def:
  (ipairs [] = []:(int#int) list) /\
  (ipairs [x] = []) /\
  (ipairs (x::y::rest) = (ndecode x, ndecode y)::ipairs rest)
End

Definition specifications_def:
  (specifications [] = []:(num#num#num) list) /\
  (specifications [x] = []) /\ (specifications [x;y] = []) /\
  (specifications (n::l::c::xs) = (n,l,c)::specifications xs)
End

Definition nearq_def:
  nearq (a:int) d = if d=0 then 0 else (a+d/2)/d
End
val nearq_pre_def=cv_trans_pre "nearq_pre" nearq_def;
Theorem division_pre[cv_pre]:
  !a d. nearq_pre a d
Proof
  simp[nearq_pre_def]
QED

Definition em_scale_def:
  em_scale (x:int,y:int) u v d = (nearq (x*u-y*v) d,nearq (x*v+y*u) d)
End

Definition em_add_def:
  em_add (x:int,y:int) (u:int,v:int) = (x+u,y+v)
End

Definition powers_def:
  (powers f a k ([]:(int#int) list) = []) /\
  (powers f a k ((x,y)::xs) = if k=0:num then [] else
     (nearq (f*x) a,nearq (f*y) a)::powers f (a+f) (k-1) xs)
End

Definition accumulate_def:
  (accumulate n ([]:(int#int) list) acc = (acc,(0:int,0:int))) /\
  (accumulate n (w::ws) acc = if n=0:num then (acc,w)
    else accumulate (n-1) ws (em_add acc w))
End

Definition correct_def:
  (correct f a v u ([]:(int#int) list) w acc = acc) /\
  (correct f a v u ((b,d)::bs) w acc =
    let next=em_add acc (em_scale w b 0 d) in
    if NULL bs then next else
    let s1=em_scale w (f*(u+64)) (f*v) (64*a);
        s2=em_scale s1 (f*(u+128)) (f*v) (64*a)
    in correct f a v (u+128) bs s2 next)
End

Definition grid_def:
  grid = ((2:int)**384)
End

Definition first_weights_def:
  (first_weights k ([]:(int#int) list)=[]) /\
  (first_weights k (x::xs)=if k=0:num then [] else x::first_weights (k-1) xs)
End

Definition ending_def:
  ending f a m v l bs =
    let u=64*m-32;
        d=f*(u*u+v*v);
        top=(grid/2+nearq (64*grid*a*u) d,nearq (-64*grid*a*v) d);
        z=u+64;
        w=em_scale (grid,0) (f*z) (f*v) (64*a)
    in correct f a v z (first_weights l bs) w top
End
val ending_pre_def=cv_auto_trans_pre "ending_pre" ending_def;
val _=print_thm ending_pre_def;
Theorem ending_pre_total[cv_pre]:
  !f a m v l bs. ending_pre f a m v l bs
Proof
  simp[ending_pre_def,division_pre]
QED

Definition output_rows_def:
  (output_rows f a j bs m fac rows ([]:(num#num#num) list) = []:(int#int) list) /\
  (output_rows f a j bs m fac rows ((n,l,cap)::rest) =
    let (head,boundary)=accumulate n rows (0,0);
        v=5*j;
        (tx,ty)=if l=0 then (0,0) else ending f (a+f* &n) m v l bs;
        (hx,hy)=if l=0 then head else em_add head (em_scale boundary tx ty grid);
        (cx,cy)=em_scale fac hx hy grid;
        out=(nearq cx ((2:int)**64),nearq cy ((2:int)**64));
        nf=em_scale fac (-2*(64*m+32)) (-2*v) (64*f*(m+1))
    in out::output_rows f a j bs (m+1) nf (powers f a cap rows) rest)
End
val output_rows_pre_def = cv_auto_trans_pre "output_rows_pre" output_rows_def;
val _ = print_thm output_rows_pre_def;
Theorem output_rows_pre_total[cv_pre]:
  !xs f a j bs m fac rows. output_rows_pre f a j bs m fac rows xs
Proof
  Induct >> simp[Once output_rows_pre_def, pairTheory.FORALL_PROD,
                 ending_pre_total, division_pre]
QED

Definition rows_ok_def:
  rows_ok (f:num) c j keys ps bs es <=>
    LENGTH keys = 3*(LENGTH es DIV 2) /\ EVEN (LENGTH es) /\
    output_rows (&f) (&(f+c)) (&j) (ipairs bs) 0 (grid,0)
      (ipairs ps) (specifications keys) = ipairs es
End
val _=cv_auto_trans rows_ok_def;
