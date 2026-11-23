Theory FullCount
Ancestors arithmetic list
Libs cv_transLib Grobner

(* Codes 1 and 2 denote strict signs. Code 0 precedes the first sample. *)
Definition steps_def:
  (steps upper pos 0 bits prev n w = (prev,n,w)) /\
  (steps upper pos (SUC len) bits prev n w =
     let s = 1 + bits MOD 2;
         flip = ((prev <> 0) /\ (prev <> s)) in
       steps upper (pos+4096) len (bits DIV 2) s
         (if flip then n+1 else n) (if flip then w+(upper-pos) else w))
End
Definition scan_def:
  (scan upper prevpos s n w ([]:(num#num#num) list) = SOME (n,w)) /\
  (scan upper prevpos s n w ((pos,len,bits)::rest) =
     let lastpos = pos+4096*(len-1) in
       if 0 < len /\ len <= 60 /\ prevpos < pos /\ lastpos < upper /\ bits < 2**len
       then (case steps upper pos len bits s n w of (t,n1,w1) =>
               scan upper lastpos t n1 w1 rest)
       else NONE)
End
Definition scan_between_def:
  scan_between lower upper runs = scan upper lower 0 0 0 runs
End
Definition saturates_def:
  saturates h a b k w <=>
    262144*(a+2*b*4294967296) <
      4294967296 * (5*w + 20480*h*(k+1))
End
val _ = cv_auto_trans scan_between_def;
val _ = cv_auto_trans saturates_def;

(* Factor 262144 is 64*4096 ticks per five height units. The phase
   upper numerator a has denominator 2^32; h counts coarse grid steps. *)
Theorem strict_inequality:
  saturates h a b k w <=>
  262144*a + 2*262144*b*4294967296 <
    5*4294967296*w + 20480*4294967296*h*(k+1)
Proof
  PURE_REWRITE_TAC[saturates_def] >>
  MATCH_MP_TAC (METIS_PROVE [] ``!a b c d:num. (a=c /\ b=d) ==> ((a<b) <=> (c<d))``) >>
  CONJ_TAC >> W (fn (_,g) => let val th = Grobner.NUM_RING g in
    ACCEPT_TAC (if aconv (concl th) g then th else EQT_ELIM th) end)
QED

Definition endpoint_def:
  (endpoint s [] = (s:bool)) /\
  (endpoint s (m::ms) = endpoint (if EVEN m then s else ~s) ms)
End

Theorem endpoint_parity:
  !ms s. endpoint s ms = if EVEN (SUM ms) then s else ~s
Proof
  Induct >> simp[endpoint_def,EVEN_ADD] >>
  rpt gen_tac >> Cases_on `EVEN h` >> Cases_on `EVEN (SUM ms)` >> simp[]
QED

Theorem exact_count_of_parity:
  !n k:num. k <= n /\ n < k+2 /\ (EVEN n <=> EVEN k) ==> n=k
Proof
  rpt strip_tac >>
  `n=k \/ n=SUC k` by decide_tac >>
  metis_tac[EVEN]
QED
