from pathlib import Path
from math import prod,factorial
p=Path(__file__).resolve().parent
lines=iter((p.parent/"full-height-count/stencils.txt").read_text().splitlines())
n=int(next(lines))
pairs=[]
for i in range(n):
    idx,r,f,den,err=map(int,next(lines).split())
    ws=list(map(int,next(lines).split()))
    assert idx==i and len(ws)==r and r%2==0 and 0<f<4096
    h=r//2
    a=prod(abs(f-4096*(1-h+j)) for j in range(r))
    assert a<=4096**r*factorial(h)**2
    pairs.append((r,f))
s=r"""Theory StencilGeometry
Ancestors arithmetic integer list cv_std
Libs intLib cv_transLib
Definition distance_product_def:
  (distance_product 0 (first:int) (f:num) = 1:int) /\
  (distance_product (SUC n) first f =
    ABS (&f - 4096 * first) * distance_product n (first+1) f)
End
Definition spacing_ok_def:
  spacing_ok (r:num) f <=>
  EVEN r /\ 0<r /\ 0<f /\ f<4096 /\
  distance_product r (1- &(r DIV 2)) f <=
   &(4096 ** r * (FACT (r DIV 2)) ** 2)
End
Definition checked_nodes_def:
  checked_nodes = [NODES] : (num # num) list
End
Definition all_nodes_def:
  all_nodes <=> EVERY (UNCURRY spacing_ok) checked_nodes
End
val _ = cv_auto_trans spacing_ok_def;
Theorem all_55_nodes:
  EVERY (UNCURRY spacing_ok) checked_nodes
Proof
  REWRITE_TAC [checked_nodes_def,listTheory.EVERY_DEF,pairTheory.UNCURRY_DEF] >>
  rpt conj_tac >> CONV_TAC cv_eval
QED
"""
(p/"StencilGeometryScript.sml").write_text(s.replace("NODES",";".join(f"({r},{f})" for r,f in pairs)))
