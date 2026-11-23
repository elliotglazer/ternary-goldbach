from fractions import Fraction as F
import json
a=F('1.01');bp=F('3.03e-23');bs=F('3.03e-17');J=F(10)
M=F('.640208')*F('13.59756');B=2*J+2*M
assert 3*(J+M+F('7.2e11')*F('1e-30'))<57
mixed=a*bp*F('4.15e14')+a*bs*57+bp*bs*F('3.6e11')
Af=a*F('5e-7')+49*F('7.78')*F('2.85')*bp
Qf=a*a*F('9.5e-7')+F('.640208')*F('2.85')*bs+mixed
Au=F('5.050000000000330e-7');Qu=F('9.817952468e-7')
assert Af<Au and Qf<Qu
assert B*Au<F('.0043466')**2 and 20*Qu<F('.0044313')**2
loss=F('.0043466')+F('.0044313'); assert loss<F('.008778')
np=F('1.589e8')*F('4.0804')*49/F('2.64')**31
assert F('2.64')**64<10**27 and np<F('.00271')
major=F('1.052105346')-F('.002834895')-F('.008778')
assert major>F('1.0404')
margin=F('1.0404')-F('1.0376')-F('.00271');assert margin==F('.00009')
print(json.dumps(dict(status='Exact rational implications only; analytic premises remain open',full_A=str(Af),full_Q=str(Qf),loss_upper=str(loss),nonprime_upper_source=float(np),major_lower=str(major),final_margin=str(margin)),indent=2))
