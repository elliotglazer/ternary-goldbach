from fractions import Fraction as F
from pathlib import Path
import json
checks={}
def ck(k,b):
    assert b,k
    checks[k]=bool(b)
M=F('.640208')*F('13.59756')
nu=F(720000000000)
t=F('.0034'); u=F('1e-6')
J=(1+u)*((1+t)*M+(1+1/t)*F('1e-4')+F('1.23'))+(1+1/u)*nu*F('1e-30')
ck('J_upper',J<10)
ck('principal_main_lower',F('.6392')*F('13.597558')>F('2.94')**2)
ck('J_lower',(F('2.94')-F('.00020001')-F('1e-9'))**2>F('8.6296'))
ck('star_error_norm',nu*F('2e-12')**2<F('2e-6')**2)
ck('star_total_integral',(100+F('2e-6'))**2<10001)
a=F('1.01'); bp=F('3.03e-23'); bs=F('3.03e-17')
Af=a*F('5e-7')+F('381.22')*F('2.85')*bp
Qf=a*a*F('9.5e-7')+F('.640208')*F('2.85')*bs+a*bp*10001+a*bs*F('1.2301')+bp*bs*F('3.6e11')
Acap=F('5.050000000000330e-7');Qcap=F('9.817952468e-7')
ck('plus_old_cap_preserved',Af<Acap)
ck('star_cross_old_cap_preserved',Qf<Qcap)
ck('stronger_new_star_cross_diagnostic',Qf<F('9.691e-7'))
B=20+2*M
ck('B_value',B==F('37.41053338496'))
ck('plus_sqrt_cap',B*Acap<F('.0043466')**2)
ck('star_sqrt_cap',20*Qcap<F('.0044313')**2)
ck('dynamic_cap',F('.0043466')+F('.0044313')<F('.008778'))
main=F('1.314')*F('.800689');fixed=49*F('2.03e-5')*F('2.85')
ck('main_identity',main==F('1.052105346'))
ck('fixed_identity',fixed==F('.002834895'))
ck('major',main-fixed-F('.008778')==F('1.040492451')>F('1.0404'))
ck('nonprime',F('1.589e8')*F('4.0804')*49/F('2.64')**31<F('.00271'))
ck('final_reserve',F('1.0404')-F('1.0376')-F('.00271')==F('.00009'))
res={'scope':'scalar-only exact audit; all analytic and spectral inputs retain their proof status','checks':checks,'count':len(checks),'exact':{'J_upper':str(J),'Afull_upper':str(Af),'Qfull_upper':str(Qf),'main':str(main),'fixed_loss':str(fixed)}}
Path(__file__).with_suffix('.json').write_text(json.dumps(res,indent=2)+'\n',encoding='utf-8')
print(len(checks),'checks passed')
