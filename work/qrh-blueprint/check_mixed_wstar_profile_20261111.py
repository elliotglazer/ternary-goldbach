"""Exact scalar composition of a conditional finite Wstar profile."""
from fractions import Fraction as F
from pathlib import Path
import hashlib,json

root=Path(__file__).resolve().parent
source=root.parent/'qrh-campaign/agents/zero-sum/wstar_critical_baseline_metadata_20261111.json'
pin='A5CA555478A01B9785FB7F04D754AB547CCE280775862DB76863511CB29FAE18'
assert hashlib.sha256(source.read_bytes()).hexdigest().upper()==pin
row=json.loads(source.read_text())['profiles']['star_tail']
la,lb=F(row['Q_A_line_upper']),F(row['Q_B_line_upper'])
assert la < F(2335,10**22) and lb < F(5966,10**15)
assert F(12,5)**8>1000
assert 25*(2*F(203,400)-1)==F(3,8)
assert 25*(2*F(31,50)-1)==6
g=7000000
ta,tb=F(8,10**9),F(48,10**5)
qa,qb=F(12,5)*la,10**6*lb
assert g*qa < (F(2,10**6)-ta)**2
assert g*qb < F(647,100)**2
assert F(647,100)+tb < F(648,100)
assert F(648,100)**2 < 42 < 62
rho,pbar,u,j=F(885,10**9),F(1902,10**9),F(367,10**8),F(879,100)
assert F(2964,1000)**2<j
assert pbar+F(2,10**6)+rho*F(648,100)<u*F(2964,1000)
out=root/'mixed_wstar_profile_20261111.json'
assert not out.exists()
receipt={'status':'PASS_EXACT_CONDITIONAL_MIXED_WSTAR_PROFILE',
 'source_sha256':pin,'squarefree_beta_upper':'203/400','other_beta_upper':'31/50',
 'Q_A_upper':str(qa),'Q_B_upper':str(qb),'A_strict_upper':'1/250000000000',
 'B_strict_upper':42,'T_A_upper':str(ta),'T_B_upper':str(tb),
 'scope':'Requires complete finite carriers, proved full-strip tails and actual location evidence; no whole-proof saving'}
out.write_text(json.dumps(receipt,indent=2)+'\n',encoding='utf-8')
print(json.dumps(receipt,indent=2))
