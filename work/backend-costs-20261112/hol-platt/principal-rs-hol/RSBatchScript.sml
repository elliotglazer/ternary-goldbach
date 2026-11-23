Theory RSBatch
Ancestors RSKernel cv_std integer
Libs cv_transLib

Definition mesh_phase_def:
 mesh_phase p f =
 let q=rr p f; r=f-q*p; (x,y)=eh r 72 0;
     even=(q % 2 = 0)
 in ((if even then x else -x),(if even then y else -y),
    - &(2**140) <= r /\ r <= &(2**140) /\ -10000000000 <= q /\ q <= 10000000000)
End
val mpre=cv_trans_pre "mesh_phase_pre" mesh_phase_def;
val _=print(thm_to_string mpre ^ "\n");
Theorem mesh_phase_ok[cv_pre]:
 !p f. mesh_phase_pre p f
Proof
 simp[mpre]
QED

Definition mesh_add_def:
 (mesh_add (w:int) x y u v [] = ([]:(int#int) list)) /\
 (mesh_add w x y u v ((a,b)::xs) =
  (a+w*x,b+w*y)::mesh_add w (rr (&(2**64)) (x*u-y*v))
     (rr (&(2**64)) (x*v+y*u)) u v xs)
End
val _=cv_auto_trans mesh_add_def;

Definition mesh_rows_def:
 (mesh_rows t h p step [] acc=(T,acc)) /\
 (mesh_rows t h p step ((w,l,g)::xs) acc =
 let (x,y,b1)=mesh_phase p (h-t*l);
     (u,v,b2)=mesh_phase p (-step*l);
     a=mesh_add (2* &w) x y u v acc
 in if g /\ b1 /\ b2 then mesh_rows t h p step xs a else (F,[]))
End
val _=cv_auto_trans mesh_rows_def;

Definition mesh_check_def:
 (mesh_check p h [] inp <=> (inp=[])) /\
 (mesh_check p h ((x,y)::xs) inp <=>
  case inp of [] => F | ((hj,j,want)::is) =>
   let (u,v,ok)=mesh_phase p (hj-h) in
    ok /\ rr (&(2**64)) (x*u-y*v)+j=want /\ mesh_check p h xs is)
End
val cpre=cv_trans_pre "mesh_check_pre" mesh_check_def;
val _=print(thm_to_string cpre ^ "\n");
Theorem mesh_check_ok[cv_pre]:
 !v inp p h. mesh_check_pre p h v inp
Proof
 Induct >> rpt gen_tac >> ONCE_REWRITE_TAC[cpre] >> asm_simp_tac (srw_ss()) []
QED

Definition mesh_zeros_def:
 (mesh_zeros 0 = ([]:(int#int) list)) /\
 (mesh_zeros (SUC n) = (0,0)::mesh_zeros n)
End
val _=cv_auto_trans mesh_zeros_def;

Definition mesh_run_def:
 mesh_run t h p step inp =
 let c=cache 3989 11 (logc 1 3);
     (ok,states)=mesh_rows t h p step c (mesh_zeros (LENGTH inp))
 in ok /\ mesh_check p h states inp
End
val _=cv_auto_trans mesh_run_def;




