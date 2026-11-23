"""Independent fixed rational review; no author import, inventory, or function values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
AG=HERE.parent
PINS={
 'independent-feasibility/FULL_P20_GRID60_MAGNITUDE_SCOPE_COMPANION_2026-11-11.md':'FE52146FBF51009631A9E232492A141053B9936AA90EB1B4017FE7A8D0021A5E',
 'independent-feasibility/full_p20_grid60_magnitude_20261111.py':'1F28B6C9577B0894069DC132DF72521B2A2B4FAD0515D213350D9CE99D27CA2D',
 'independent-feasibility/full_p20_grid60_magnitude_20261111.json':'4158B1FBF599616A15EBD7978AB7C36EEDCB2C596355D6EE295689C35EF222D2',
 'independent-feasibility/FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md':'718CFC0DDAA0594A2AB26ADDCEBA09E472E07C1ED21FD8058821957251EAC223',
 'zero-sum/REVIEW_FULL_P20_INPUT_MAGNITUDE_5691_2026-11-11.md':'42985BB1A88F4F70A3C9C37584725C34D04EDFE9DBEFF8BAE19E1F79E7B44E8C',
 'prime-estimates/STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'9B777E02CA50392D0BE0E6582807439E938970961A045B63758EB66A9EEE55D2',
 'major-constants/REVIEW_STORED_HURWITZ_DEGREE_MAGNITUDE_2026-11-11.md':'1028156181791D6F0CD4CB0555A2625999CBF091ADD72F3CD9841BFAAD55F3F6',
 'moebius/JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'AEAB2BDCF2D767546A7F410CC463D17DFB6C4639BFFC94D771574C134DA36E63',
 'independent-feasibility/REVIEW_JOINT_HORNER_LENGTH_PRECISION_TRADEOFF_2026-11-11.md':'84B062431F1A7C49C2191E8C4576A6CC6B870A431A5BB3E7BBDDF59150F437D7',
 'prime-estimates/SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'0EAED4F960DFC4F590564A9B8A86E9C22BB621FCE362CCAB7A13D2D3976A1D2A',
 'integration/REVIEW_SHORTER_HURWITZ_OUTPUT_ORDER_2026-11-11.md':'B15D0C3B15B8005A6B3DC3CFE1A1CDE157448B83904950487CD124F87647536E',
 'major-constants/REVIEW_SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md':'4D313FBFEC13EBC9D80490C5CC995228D67E71F211F865113A67969A60BB82E9',
}
CHECKS=0
def ck(x):
 global CHECKS
 assert x,CHECKS
 CHECKS+=1
for rel,pin in PINS.items():
 raw=(AG/rel).read_bytes();ck(len(raw)<1024**2);ck(hashlib.sha256(raw).hexdigest().upper()==pin)
bp=AG.parent.parent/'qrh-blueprint'/'SHORT_GUARD_HORNER_DOMAIN_ADMISSION_2026-11-11.md'
ck(hashlib.sha256(bp.read_bytes()).hexdigest().upper()=='6DF38245BECCD8A35B94F98787C4DEF64EEB9EFCF9FB07E54E1D9EC554C48DF2')
author=json.loads((AG/'independent-feasibility/full_p20_grid60_magnitude_20261111.json').read_bytes())
eta=F(1,2**100);ut=F(1,2**110);R=F(1,2**116);W=4*eta+330*ut;eflat=2**27*(eta/4+330*ut)
grids=[94]*4+[91]+[89]*3+[83]+[81]*3+[75]+[73]*3+[65]*4
ck(len(grids)==20 and min(grids)==65 and grids[0]==94)
e=[F(3,4*2**b) for b in grids];e60=F(3,4*2**60)
ck(F(1,2)<F(3,4)**2)
err=e[-1]
for j in range(18,-1,-1):
 err=err/4+2*e[j]
 ck(e[j]<=e60)
ck(err==F(5253,2048*2**94))
ck(100-grids[0]==6)
common_error=e60
for j in range(18,-1,-1):common_error=common_error/4+2*e60
ck(common_error<F(8,3)*e60==F(1,2**59))
H=lambda z:1+z+z*z/(2*(1-z/3))
for z in [F(5,16),F(7,32)]:
 ck(sum(z**j/factorial(j) for j in range(20))<H(z))
zfirst=[5170+R+W]+[6*F(5,4)**j/factorial(j)+min(4**j*W,eflat) for j in range(1,20)]
zfinal=[F(9023,2)+R+eta]+[F(15,2)*F(7,8)**j/factorial(j)+eta for j in range(1,20)]
upper_first=5170+R+20*W+6*(H(F(5,16))-1)+F(1,2**59)
upper_final=F(9023,2)+R+F(4,3)*eta+F(15,2)*(H(F(7,32))-1)+F(1,2**59)
for zs,bound,coarse in [(zfirst,F(10345,2),upper_first),(zfinal,F(9027,2),upper_final)]:
 acc=zs[-1]+e60
 for j in range(18,-1,-1):acc=zs[j]+2*e60+acc/4
 ck(acc==sum(z/F(4**j) for j,z in enumerate(zs))+common_error)
 ck(acc<coarse<bound)
ck(265800<516**2)
ck(F(10345,2)+517+1+F(1,2**80)<5691)
ck(F(9027,2)+517+1+F(1,2**80)<5032)
Sfirst=1266*F(15,16)**27/factorial(27)
Sfinal=1266*F(35140,32768)**28/factorial(28)
Nfirst=2532*eta+633*330*ut;Nfinal=844*eta
cases=[('band1',F(500),512,False),('band2',F(1000),1024,False),('band3',F(2000),2048,False),('band4',F(5000),4096,False),('final_declared',F(7000),8192,True),('final_guard',F(26525,4),8192,True)]
rows=[]
for (name,V,D,final),saved in zip(cases,author['full_p20_fixed94']):
 # Multiply the twenty target factors rather than importing an author scalar.
 target=F(1266)
 for j in range(1,21):target*=F(V+20,4*D*j)
 total=target+(Sfinal if final else Sfirst)+(Nfinal if final else Nfirst)+633*err
 ratio=total*2**82
 ck(ratio<1)
 ck(saved==dict(case=name,K=20,b0=94,min_grid=65,alpha_ratio=[ratio.numerator,ratio.denominator]))
 upper=(ratio.numerator*10**9)//ratio.denominator+1
 ck(ratio<F(upper,10**9))
 rows.append(dict(case=name,ratio=[ratio.numerator,ratio.denominator],strict_upper_numerator_over_1e9=upper))
ck(F(26525,4)<7000)
out=dict(scope='Independent fixed full-P20 magnitude/grid94/alpha review only',pins=PINS,checks=CHECKS,
 generic_min_grid=60,generic_grid60_accuracy_admitted=False,coefficient_count=20,selected_grids=grids,
 evaluation_error=[err.numerator,err.denominator],cases=rows,uniform_magnitude=5691,final_only_magnitude=5032)
raw=(json.dumps(out,indent=2)+'\n').encode();ck(len(raw)<65536)
with (HERE/'review_full_p20_grid60_scope_20261111.json').open('xb') as f:f.write(raw)
print(json.dumps(dict(checks=CHECKS,bytes=len(raw),sha256=hashlib.sha256(raw).hexdigest().upper(),cases=rows),indent=2))
