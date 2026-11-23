"""Reproduce the two library compatibility fixes; no compiled kernel edits."""
from pathlib import Path
import hashlib,json
H=Path(__file__).resolve().parent
R=H/'candle-6a9acd58867610c78fee0f3dd9ed4c4c14087b18'
edits=[('candle/ocaml.ml','let five = Cake.Word64.fromInt 5 in','let five = 5 in'),
 ('candle/compute.ml','(Cexp_if (Cexp_pair p2 q2) p1 q1 = p1)',
                     '(Cexp_if (Cexp_pair p2 q2) p1 q1 = q1)')]
for name,old,new in edits:
    p=R/name;s=p.read_text()
    if old in s:s=s.replace(old,new)
    else:assert new in s
    p.write_text(s)
p=R/'candle/compute.ml';s=p.read_text()
start=s.index('let cexp_if = prove (');end=s.index('let cval_size_def',start)
s=s[:start]+'''let cexp_if = prove (
  `Cexp_if (numc n) p q = if n = 0 then q else p`,
  STRUCT_CASES_TAC (SPEC `n:num` num_CASES) THEN
  REWRITE_TAC [cexp_if_def; NOT_SUC]);;

'''+s[end:]
p.write_text(s)
files=['candle/ocaml.ml','candle/compute.ml']
(H/'library_patches.json').write_text(json.dumps({name:hashlib.sha256((R/name).read_bytes()).hexdigest() for name in files},indent=2)+'\n')
