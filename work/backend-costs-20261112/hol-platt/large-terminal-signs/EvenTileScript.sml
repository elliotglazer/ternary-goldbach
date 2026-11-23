Theory EvenTile
Ancestors Absorbed
Libs cv_transLib intLib
Definition tile_run_def:
 (tile_run 0 mode sc zs ws cs chk masks <=> T) /\
 (tile_run (SUC n) mode sc zs ws cs chk masks <=>
 (if mode then Absorbed$collect sc zs ws cs=masks
  else FastAxis$kr_mod(FastAxis$lp_sum (FastAxis$rotlist sc (FastAxis$kdiv sc 2) zs ws) 0) 65537=chk)
 /\ tile_run n mode sc zs ws cs chk masks)
End
Definition tile_top_def:
 tile_top n mode sc zs ws rows chk masks =
 tile_run n mode (sc*sc) zs ws (Absorbed$cache sc rows ws) chk masks
End
val _=cv_auto_trans tile_top_def;
