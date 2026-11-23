from pathlib import Path
from fractions import Fraction as F
import subprocess,sys,json,hashlib
root=Path.cwd(); a=root/'work/qrh-campaign/agents/audit'; p=a.parent/'prime-estimates'
s=p/'resume_psi_log_recurrence_integer_audit_20261111.py'
r=subprocess.run([sys.executable,str(s)],capture_output=True,check=True)
out=json.loads(r.stdout); expected=json.loads(s.with_suffix('.json').read_text())
assert out==expected
(a/'resume_psi_log_recurrence_replay_20261111.json').write_bytes(r.stdout)
w=F(3162,1000)
coeff=[F(4262,10000)*w**3-F(103883,100000)*w-F(939643,100000),3*F(4262,10000)*w*w-F(103883,100000),3*F(4262,10000)*w,F(4262,10000)]
assert all(x>0 for x in coeff)
assert w**12<10**6 and F(2647,100)**2<701 and F(3883,100000)*F(2647,100)>1
assert F(73576,10000)*F(27182818283,10**10)>20
h,e,k=F(1,4000),F(1,10000),F(17,360000)
assert h+e==F(7,20000)<F(1,2300)
assert h+(e+k)*(1+h)==F(572053,1440000000)<F(1,2300)
paths=[p/'RESUME_PSI_LOG_RECURRENCE_LEDGER_2026-11-11.md',s,s.with_suffix('.json'),a/'resume_psi_log_recurrence_replay_20261111.json']
base=root/'work/ternary-goldbach/TernaryGoldbach'
paths += [base/x for x in ['Prelim/SmallPsi.lean','Prelim/SmallMertens.lean','Prelim/PsiSieve.lean','Prelim/PsiSieve3.lean','Prelim/PsiSieveMain.lean','Prelim/SmallPsiTableMain.lean','Prelim/SmallPsi700.lean','Prelim/PsiTwoSided.lean','Prelim/LambdaMu.lean','Prelim/ThetaExplicit.lean','Explicit/PsiSandwich.lean']]
result={'status':'PASS external arithmetic; no sieve or Lean run','author_replay_matches_saved_json':True,'windows':out['windows'],'log_inequalities':out['log_inequalities'],'subcells':out['subcells'],'polynomial_shift_coefficients':list(map(str,coeff)),'hashes':{str(x.relative_to(root)):hashlib.sha256(x.read_bytes()).hexdigest() for x in paths}}
(a/'resume_psi_log_recurrence_review_20261111.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
