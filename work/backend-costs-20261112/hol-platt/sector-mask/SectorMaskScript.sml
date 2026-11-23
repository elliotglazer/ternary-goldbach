Theory SectorMask
Ancestors Sector

Definition selected_def:
  selected pq f ri = if one pq f ri = 0 then score pq f ri else one pq f ri
End
Definition code_rows_def:
  (code_rows [] f g a b = []) /\
  (code_rows ((p,q,r,i,s,j)::xs) f g a b =
     (selected (p,q) f (r,i),selected (p,q) a (s,j))::
       code_rows xs g f b a)
End
Definition unpack_def:
  (unpack 0 m = []) /\
  (unpack (SUC n) m = (1+m MOD 2)::unpack n (m DIV 2))
End
Definition changes_def:
  (changes [] = 0:num) /\
  (changes ((x:num,y:num)::xs) = (if x=y then 0 else 1)+changes xs)
End

Theorem selected_range:
  !p q f g e r i. selected (p,q) (f,g,e) (r,i) = 0 \/
    selected (p,q) (f,g,e) (r,i) = 1 \/ selected (p,q) (f,g,e) (r,i) = 2
Proof
  rpt gen_tac >> simp[selected_def,one_def,LargeTerminalTheory.score_def,LET_THM] >> rpt IF_CASES_TAC >> fs[]
QED

Theorem decode_cons:
  !k m n. (k=1 \/ k=2) ==>
     unpack (SUC n) (2*m+(k-1)) = k::unpack n m
Proof
  rpt strip_tac >> simp[unpack_def, arithmeticTheory.ADD_DIV_ADD_DIV,
     arithmeticTheory.MOD_TIMES, arithmeticTheory.ADD_MODULUS]
QED

Theorem packet_masks:
  !xs f g a b m n c u v.
    sector_packet xs f g a b = SOME(m,n,c,u,v) ==>
    unpack (LENGTH xs) m = MAP FST (code_rows xs f g a b) /\
    unpack (LENGTH xs) n = MAP SND (code_rows xs f g a b) /\
    c = changes (code_rows xs f g a b)
Proof
  Induct >- simp[sector_packet_def,code_rows_def,unpack_def,changes_def] >> rpt gen_tac >>
  PairCases_on `h` >> rpt gen_tac >>
  simp[sector_packet_def,LET_THM,GSYM selected_def,code_rows_def] >>
  Cases_on `sector_packet xs g f b a` >> simp[] >>
  PairCases_on `x` >> simp[] >>
  PairCases_on `f` >> PairCases_on `a` >>
  mp_tac (Q.SPECL [`h0`,`h1`,`f0`,`f1`,`f2`,`h2`,`h3`] selected_range) >>
  mp_tac (Q.SPECL [`h0`,`h1`,`a0`,`a1`,`a2`,`h4`,`h5`] selected_range) >>
  rpt strip_tac >> gvs[changes_def,unpack_def,arithmeticTheory.ADD_DIV_ADD_DIV,arithmeticTheory.MOD_TIMES,arithmeticTheory.ADD_MODULUS] >> metis_tac[arithmeticTheory.ADD_COMM]
QED
