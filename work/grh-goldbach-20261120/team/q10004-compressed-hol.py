"""Generate matched compressed sign and raw-projection theories from the measured raw driver."""
from pathlib import Path
hol=Path(__file__).resolve().parent/'q10004-gaussian/hol'
raw=(hol/'Q10004AllScript.sml').read_text()
defs=r'''
Theory Q10004Compressed
Ancestors Q10004All integer list arithmetic
Libs meter encoding cv_transLib intLib
open meter;
Definition digits_def:
  (digits 0 (base:num) word = ([]:int list)) /\
  (digits (SUC n) base word = (&(word MOD base) - &(base DIV 2)) :: digits n base (word DIV base))
End
Definition words_def:
  (words b (n:num) ([]:num list) = ([]:int list)) /\
  (words b n (w::ws) = digits (MIN 8 n) b w ++ words b (n-8) ws)
End
Definition find_span_def:
  (find_span (j:num) ([]:num list list) = (0:num,[]:int list)) /\
  (find_span j (row::rs) = case row of a::ex::width::n::ws =>
     if a<=j /\ j+192<=a+n then
       let unit=2**ex in (unit,MAP (\v. v * &unit) (cut (j-a) 192 (words (2**width) n ws)))
     else find_span j rs
   | _ => (0,[]))
End
Definition normsum_def:
  (normsum ([]:int list)=0:int) /\ (normsum (x::xs)=ABS x + normsum xs)
End
Definition compact_jobs_def:
  (compact_jobs radi err tab ks runs ([]:num list list) <=> T) /\
  (compact_jobs radi err tab ks runs (row::rest) <=>
    (case row of [region;first;tick;off;word;b;i;c;k;d;m] =>
       let (unit,ys)=find_span first tab; ws=weights_for off ks;
           z=window first tick off (radi+ &unit) (err+5*2**256* &unit) word ys ws
       in region=0 /\ 0<unit /\ normsum ws <= 5*2**256 /\ z<>0 /\
          z=at_three runs (first+95) tick b i c k d m
     | _ => F) /\ compact_jobs radi err tab ks runs rest)
End
val _=cv_auto_trans compact_jobs_def;
'''
driver=raw[raw.index('fun line ins='):].replace('("all-"^label','("compressed-"^label').replace('val st=table spans','val st=listSyntax.mk_list(map nums spans,``:num list``)').replace('grid_spans_','compressed_spans_').replace('Q10004All$all_jobs','Q10004Compressed$compact_jobs').replace('all_interior_repair_bits_','compressed_repair_bits_')
(hol/'Q10004CompressedScript.sml').write_text(defs+driver)
proj=r'''
Theory Q10004Project
Ancestors Q10004Compressed
Libs meter encoding cv_transLib intLib
open meter;
Definition within_def:
  (within (u:int) ([]:int list) qs <=> qs=[]) /\
  (within u (x::xs) qs <=> case qs of []=>F | q::rest =>
     ABS(x-q*u)<=u /\ within u xs rest)
End
Definition projects_def:
  (projects ([]:(num#int list) list) compact <=> compact=[]) /\
  (projects ((a,xs)::rs) compact <=> case compact of [] => F | h::tail =>
    (case h of b::ex::width::n::ws =>
      a=b /\ LENGTH xs=n /\ within (&(2**ex)) xs (words (2**width) n ws) | _=>F)
     /\ projects rs tail)
End
val _=cv_auto_trans projects_def;
'''
proj+=raw[raw.index('fun encode label def='):raw.index('fun named label')]
proj+=r'''
fun check label =
 let val sf=encode ("original_"^label)(DB.fetch "Q10004All" ("grid_spans_"^label^"_def"))
     val cf=encode ("compact_"^label)(DB.fetch "Q10004Compressed" ("compressed_spans_"^label^"_def"))
     val f=``Q10004Project$projects``
     val args=map #1 [sf,cf]
     val th=encoding.produce ("project_"^label) f args (map #2 [sf,cf])
     val inv=cv_typeLib.from_to_thm_for ``:bool``
     val [_,decoder]= #2(strip_comb(concl inv))
     val decoded=TRANS(SYM(SPEC(list_mk_comb(f,args))(REWRITE_RULE[cv_typeTheory.from_to_def]inv)))
                    (CONV_RULE(RAND_CONV EVAL)(AP_TERM decoder th))
     val _=if closed decoded andalso aconv(rhs(concl decoded))boolSyntax.T then () else raise Fail label
     val _=save_thm("raw_projection_"^label,EQT_ELIM decoded)
 in print("PROJECTED "^label^"\n") end;
val _=app check ["6559","7707","5499","7659"];
'''
(hol/'Q10004ProjectScript.sml').write_text(proj)
for tag,theory in [('compressed','Q10004Compressed'),('project','Q10004Project')]:
    s=(hol/'all.sh').read_text().replace('all-*.txt all-input.json','compressed-*.txt compression.json').replace('Q10004All',theory).replace('all-inputs.sha256',tag+'-inputs.sha256').replace('all.time',tag+'.time').replace('all.log',tag+'.log').replace('all-export.sha256',tag+'-export.sha256')
    (hol/(tag+'.sh')).write_bytes(s.encode())
