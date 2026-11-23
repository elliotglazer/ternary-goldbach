Theory NormalizedTranslate
Ancestors list arithmetic cv_std
Libs cv_transLib
Definition poly_def:
 (poly modulus cap r scale a ([]:num list)=a) /\
 (poly modulus cap r scale a (c::cs)=poly modulus cap r (64*scale)
   ((a*r+c*scale+modulus-cap*scale) MOD modulus) cs)
End
Definition digs_def:
 (digs 0 base den adjust x y=(y=0)) /\
 (digs (SUC n) base den adjust x y=
   (((x MOD base) DIV den + 2**127 = y MOD (2**128) +adjust) /\
    digs n base den adjust (x DIV base) (y DIV (2**128))))
End
Definition coord_def:
 coord base modulus cap den bias adj r xs e=
  digs 20 base den adj ((poly modulus cap r 1 0 xs +bias) MOD modulus) e
End
Definition cells_def:
 (cells 0 b m c den bias adj r xs ys es fs=T) /\
 (cells (SUC n) b m c den bias adj r xs ys [] fs=F) /\
 (cells (SUC n) b m c den bias adj r xs ys (e::es) []=F) /\
 (cells (SUC n) b m c den bias adj r xs ys (e::es) (f::fs)=
  (coord b m c den bias adj r xs e /\ coord b m c den bias adj r ys f /\
   cells n b m c den bias adj (SUC r) xs ys es fs))
End
Definition batch_def:
 batch n degree width prec xs ys es fs=
 let b=2**width; m=2**(width*20); cap=2**(prec+64); den=2**(prec-94+6*degree) in
 let adj=b DIV (2*den); bias=(b DIV 2+den DIV 2)*((m-1) DIV (b-1)) in
  cells n b m cap den bias adj (2*b-64) xs ys es fs
End
val _=cv_auto_trans batch_def;
Definition reject_def:
 reject degree width prec xs ys es fs= ~batch 129 degree width prec xs ys es fs
End
val _=cv_auto_trans reject_def;
