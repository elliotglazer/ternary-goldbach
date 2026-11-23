from pathlib import Path
import json,subprocess,sys,time
d=Path(__file__).resolve().parent
p=d.parent
sys.path.insert(0,str(p.parent/'aws-pilot/wide'))
from run_wide import windows_stats
start=time.monotonic()
pr=subprocess.Popen([sys.executable,str(p/'generate.py'),'8','--width','98304','--halo','2048','--out',str(d)],stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
log,_=pr.communicate()
(d/'producer.log').write_bytes(log)
stats=dict(exit=pr.returncode,wall_seconds=time.monotonic()-start,**windows_stats(pr))
(d/'producer.json').write_text(json.dumps(stats,indent=2))
assert pr.returncode==0,log
(d/'Audit.lean').write_text('import Power8\nexample : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^8 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := SmallGoldbach.Power8.binaryGoldbachUpTo\n#print axioms SmallGoldbach.Power8.binaryGoldbachUpTo\n',encoding='utf8')
subprocess.run([sys.executable,str(p/'check.py'),'--scope',str(d),'Power8','Audit'],check=True)
