Theory EmittedDigits
Ancestors TwoHead SelectedBias PackedLoad list integer arithmetic
Libs intLib
Definition signed_stream_def:
 (signed_stream 0 w e m a b x y = []:int list) /\
 (signed_stream (SUC n) w e m a b x y =
  if m=0 then [] else
  let j=tz 64 m; sa=2**(544*j); sr=2**(243*j);d=nd m (2**j);
     (a0,an)=dq (nd a sa) (2**544);(b0,bn)=dq (nd b sa) (2**544);
     (x0,xn)=dq (nd x sr) (2**243);(y0,yn)=dq (nd y sr) (2**243)
  in twoval w e (&a0- &(2**543)) (&b0- &(2**543))
     (&x0- &(2**242)) (&y0- &(2**242)) ::
       signed_stream n w e (d DIV 2) an bn xn yn)
End
Definition sintword_def:
 (sintword (B:int) []=0) /\ (sintword B (h::ds)=h+B*sintword B ds)
End
Theorem twosweep_stream:
 !n w e m a b x y.
 twosweep n w e m a b x y =
 (sintword (&(2**w)) (signed_stream n w e m a b x y),
  &((2**w)**LENGTH(signed_stream n w e m a b x y)))
Proof
 Induct >> rpt gen_tac >> Cases_on `m=0` >>
 simp[signed_stream_def,twosweep_def,sintword_def,LET_THM,pairTheory.UNCURRY,EXP,INT_MUL]
QED
Theorem sintword_nat:
 !ds B. EVERY (\v:int. 0<=v) ds ==> sintword (&B) ds = &(word B (MAP Num ds))
Proof
 Induct >> simp[sintword_def,word_def,INT_ADD,INT_MUL] >> rpt strip_tac >>
 `&(Num h):int=h` by ASM_SIMP_TAC int_ss[] >> asm_simp_tac bool_ss [GSYM INT_ADD, GSYM INT_MUL]
QED
Theorem twosweep_packed_word:
 !n w e m a b x y ds.
 signed_stream n w e m a b x y=ds /\ EVERY (\v:int. 0<=v /\ v< &(2**w)) ds ==>
 twosweep n w e m a b x y =
 (&(word (2**w) (MAP Num ds)), &((2**w)** LENGTH (MAP Num ds)))
Proof
 rpt strip_tac >> simp[twosweep_stream] >>
 irule sintword_nat >> fs[EVERY_MEM] >> metis_tac[]
QED
