Theory C10004Linked
Ancestors C10004FullInteger C10004Shared C10004Packed C10004TraversalBase integer list arithmetic
Libs cv_transLib

Definition linked_r122_def:
  linked_r122 (x:int) = (x + 2658455991569831745807614120560689152) / 5316911983139663491615228241121378304
End
Definition linked_r140_def:
  linked_r140 (x:int) = (x + 696898287454081973172991196020261297061888) / 1393796574908163946345982392040522594123776
End
Definition linked_state_def:
  linked_state (x:num) (z:num) =
    let m = z MOD 633825300114114700748351602688;
        step = full_pair 21267647932558653966460912964485513216 (z DIV 633825300114114700748351602688);
        t = FST step; u = SND step;
        a = linked_r122 (&m * 4194304 * t);
        b = linked_r122 (&m * 4194304 * u);
        c = linked_r122 (a*t-b*u);
        d = linked_r122 (a*u+b*t)
    in if m*m*x <= 100433627766186892221372630771322662657637687111424552206336 /\ 100433627766186892221372630771322662657637687111424552206336 < (m+1)*(m+1)*x then SOME ((a,b),(c,d)) else NONE
End
Definition linked_raw_def:
  linked_raw (u:int,v:int) (x:int,y:int) =
    (linked_r140 (10004*(u*x+v*y)),linked_r140 (10004*(u*y-v*x)))
End
Definition linked_unroll_def:
  (linked_unroll 0 (z:num) = []) /\
  (linked_unroll (SUC n) z = (z MOD 286687326998758938951352611912760867599570623646035140467198604923365359511060601008752319138765710819328)::linked_unroll n (z DIV 286687326998758938951352611912760867599570623646035140467198604923365359511060601008752319138765710819328))
End
Definition linked_blocks_def:
  (linked_blocks [] = []) /\
  (linked_blocks (z::zs) = linked_unroll 4 z ++ linked_blocks zs)
End
Definition linked_walk_def:
  (linked_walk q idx [] = SOME ([],[])) /\
  (linked_walk q idx (z::zs) =
    case linked_state (full_residue idx) z of NONE => NONE
    | SOME ab =>
      case linked_walk q (SUC idx) zs of NONE => NONE
      | SOME hs => SOME (linked_raw (FST q) (FST ab)::FST hs,
                         linked_raw (SND q) (SND ab)::SND hs))
End
Definition linked_heads_def:
  linked_heads q blocks = if LENGTH blocks = 1200 then
    case linked_state 10004 q of NONE => NONE
    | SOME qs => linked_walk qs 0 (linked_blocks blocks)
    else NONE
End
Definition linked_coeff2_def:
  linked_coeff2 z = (full_pair 2 z, full_stages [(2,1);(2,1);(2,1);(2,256);(2,1);(2,1);(2,4);(2,64);(2,1);(2,1);(1024,4);(33554432,64);(17179869184,1);(8796093022208,1);(36028797018963968,4);(147573952589676412928,8);(75557863725914323419136,1);(154742504910672534362390528,1);(158456325028528675187087900672,1)] (z DIV 4))
End

Definition linked_both_def:
  linked_both roots c1 c2 q blocks phases p1 p2 <=>
    LENGTH c1 = 1025 /\ LENGTH c2 = 1025 /\
    case linked_heads q blocks of NONE => F
    | SOME hs =>
       shared_checked roots (full_rows (MAP full_coeff c1) 0 (FST hs)) phases p1 /\
       shared_checked roots (full_rows (MAP linked_coeff2 c2) 0 (SND hs)) phases p2
End
Definition linked_identity_def:
  linked_identity roots coeff q blocks h2 targetxs targetys <=>
    LENGTH coeff = 1025 /\
    case linked_heads q blocks of NONE => F
    | SOME hs =>
       let got = if h2 then full_rows (MAP linked_coeff2 coeff) 0 (SND hs)
                      else full_rows (MAP full_coeff coeff) 0 (FST hs)
       in got = packed_input 16 targetxs /\
          ft_checked roots got = SOME (TAKE 2301 (packed_input 16 targetys))
End
val r122pre = cv_trans_pre "linked_r122pre" linked_r122_def;
Theorem linked_r122pre_ok[cv_pre]:
  !x. linked_r122pre x
Proof
  simp[r122pre]
QED
val r140pre = cv_trans_pre "linked_r140pre" linked_r140_def;
Theorem linked_r140pre_ok[cv_pre]:
  !x. linked_r140pre x
Proof
  simp[r140pre]
QED
val _ = cv_auto_trans linked_state_def;
val _ = cv_auto_trans linked_raw_def;
val _ = cv_auto_trans linked_unroll_def;
val _ = cv_auto_trans linked_blocks_def;
val _ = cv_auto_trans linked_walk_def;
val _ = cv_auto_trans linked_heads_def;
val _ = cv_auto_trans linked_coeff2_def;
val _ = cv_auto_trans linked_both_def;
val _ = cv_auto_trans linked_identity_def;
