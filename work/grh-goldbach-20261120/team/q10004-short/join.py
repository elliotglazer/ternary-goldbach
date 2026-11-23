"""Generate conditional CompactSign specialization for exactly the first stress TSV row."""
from pathlib import Path
here=Path(__file__).resolve().parent
source=here.parents[2]/'backend-costs-20261112/hol-platt/guard-repricing/strip-repair-packets-stress.tsv'
row=list(map(int,source.read_text().splitlines()[0].split()))
q,label,tick,sub,ex,bits,r,sg=row[:8]
v,w=row[8:20],row[20:]
assert (q,label,tick,sg)==(10000,3,8010240,-1)
def integer(x): return ('- ' if x<0 else '')+str(abs(x))
xs=';'.join(f'({integer(k)}:int,{integer(a)}:int,f {i}:real,z {i}:real)' for i,(k,a) in enumerate(zip(w,v)))
scale=1<<bits
dot=sum(k*a for k,a in zip(w,v))
kn=sum(map(abs,w));vn=sum(map(abs,v))+12
script=f'''Theory ActualSign
Ancestors CompactSign PanelBatch real intreal
Libs intLib realLib
Definition actual_def:
 actual (f:num->real) (z:num->real) = [{xs}]
End
Theorem actual_metrics:
 !f z. idot (actual f z) = {integer(dot)} /\\
       knorm (actual f z) = {kn} /\\ vnorm (actual f z) = {vn}
Proof
 rpt gen_tac >> simp [actual_def,idot_def,knorm_def,vnorm_def,integerTheory.INT_ABS] >> EVAL_TAC
QED
Theorem actual_radius:
 margin {scale} ({r}/{scale}) (actual f z) = {r+kn+(vn+1)//2}
Proof
 simp [margin_def,actual_metrics] >> EVAL_TAC
QED
Theorem q10000_label3_tick8010240_negative:
 !f z y. admitted {scale} (actual f z) /\\
   abs (y - ideal (actual f z)) <= {r}/{scale} ==> y<0
Proof
 rpt gen_tac >> strip_tac >>
 mp_tac (Q.SPECL [`actual f z`,`{scale}:real`,`{r}/{scale}:real`,`y:real`] stencil_sign) >>
 simp [actual_metrics, actual_radius] >> metis_tac[]
QED
'''
(here/'ActualSignScript.sml').write_text(script)
