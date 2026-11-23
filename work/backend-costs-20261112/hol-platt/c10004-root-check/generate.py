import json
from pathlib import Path

here = Path(__file__).resolve().parent
cs = [int(x) for x in json.loads((here.parent / "c10004-roots/table.json").read_text())["positive_cosines"]]
D = 2**82
def u59(a):
    x, y = 1, 2*a
    for k in range(2,60):
        x,y = y,2*a*y-D*D*x
    return y
def check(cs):
    return (len(cs)==29 and 2*cs[0]+1<D and 2*cs[-1]-1>0
            and all(x>y+1 for x,y in zip(cs,cs[1:]))
            and all(u59(2*x-1)*u59(2*x+1)<0 for x in cs))
assert check(cs)
assert not check(cs[::-1])
assert not check([cs[0]+2]+cs[1:])
src = """open HolKernel Parse boolLib bossLib integerTheory intLib listTheory cv_transLib;
val _ = new_theory "RootBins";
Definition run_def:
  (run 0 (a:int) x (y:int) = y) /\\
  (run (SUC n) a x y = run n a y (2*a*y - (&D * &D)*x))
End
Definition signok_def:
  signok (c:int) <=>
    let l = 2*c-1; h = 2*c+1 in
    0 < l /\\ h < &D /\\
    run 58 l 1 (2*l) * run 58 h 1 (2*h) < 0
End
Definition bins_def:
  (bins ([]:int list) <=> T) /\\
  (bins (c::cs) <=> signok c /\\ (case cs of [] => T | h::t => h + 1 < c) /\\ bins cs)
End
Definition centers_def:
  centers = [CENTERS]:int list
End
val _ = cv_auto_trans bins_def;
val _ = cv_auto_trans centers_def;
Theorem checked_centers:
  LENGTH centers = 29 /\\ bins centers
Proof
  CONV_TAC cv_eval
QED
Theorem bad_controls:
  ~bins (REVERSE centers) /\\ ~bins (CORRUPT:int list)
Proof
  CONV_TAC cv_eval
QED
val _ = export_theory();
"""
(here/"RootBinsScript.sml").write_text(src.replace("&D","&"+str(D)).replace("CENTERS",";".join(map(str,cs))).replace("CORRUPT","["+";".join(map(str,[cs[0]+2]+cs[1:]))+"]"))




# Pin all table entries and check each against the quarter-wave indexing formula.
table = json.loads((here.parent/"c10004-roots/table.json").read_text())
def integer(k):
    return ("~" if k < 0 else "") + str(abs(k))
rows = []
for n, samples in table["rows"].items():
    pairs = ";".join("("+integer(a)+","+integer(b)+")" for a,b in samples)
    rows.append("("+n+",["+pairs+"])")
extra = """
Definition quadrant_def:
  quadrant = [SCALE] ++ centers ++ [0:int]
End
Definition pick_def:
  (pick (n:num) ([]:int list) = 0) /\\
  (pick n (x::xs) = if n = 0 then x else pick (n-1) xs)
End
Definition wave_def:
  wave (j:num) =
    let i = j MOD 120 in
    if i <= 30 then pick i quadrant else if i <= 60 then -pick (60-i) quadrant
    else if i <= 90 then -pick (i-60) quadrant else pick (120-i) quadrant
End
Definition rows_def:
  rows = [ROWS] : (num # (int # int) list) list
End
Definition expected_def:
  expected n k =
    let j = k * (120 DIV n) in (wave j,wave (j+90))
End
Definition rowok_def:
  rowok (n,r) <=> r = GENLIST (expected n) n
End
Theorem checked_rows:
  MAP FST rows = [LENGTHS] /\\ EVERY rowok rows
Proof
  CONV_TAC cv_eval
QED
""".replace("ROWS",";".join(rows)).replace("SCALE",str(2**81)).replace("LENGTHS",";".join(table["rows"]))
extra = extra.replace("Theorem checked_rows:", "val _ = cv_auto_trans rows_def;\nval _ = cv_auto_trans rowok_def;\nTheorem checked_rows:")
# Keep separate so the interval theorem can be audited independently.
(here/"RootRowsScript.sml").write_text("Theory RootRows\nAncestors RootBins\nLibs intLib cv_transLib\n"+extra)

import re
for name in ("RootBins","RootRows"):
    path = here/(name+"Script.sml")
    def wrap(m):
        n,p=m.groups()
        return f"Definition p_{n}_def:\n  p_{n} <=> {p}\nEnd\nval _ = cv_auto_trans p_{n}_def;\nTheorem {n}:\n  {p}\nProof\n  REWRITE_TAC [GSYM p_{n}_def] >> CONV_TAC cv_eval\nQED"
    path.write_text(re.sub(r"Theorem (\w+):\n  (.+)\nProof\n  CONV_TAC cv_eval\nQED",wrap,path.read_text()))
path=here/"RootRowsScript.sml"
s=path.read_text()
s=re.sub(r"(p_checked_rows <=> )MAP FST rows = \[[^\]]+\] /\\ ",r"\1",s)
s=s.replace("REWRITE_TAC [GSYM p_checked_rows_def]","conj_tac >- EVAL_TAC >> REWRITE_TAC [GSYM p_checked_rows_def]")
path.write_text(s)
