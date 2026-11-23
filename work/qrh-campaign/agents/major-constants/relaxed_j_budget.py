"""Exact rational comparisons for relaxed-J budgets. Analytic bounds are separate."""
from fractions import Fraction as F
import json
b=F('.011670451'); M=F('.640208')*F('13.59756'); a=F('1.01');bp=F('3.03e-23');bs=F('3.03e-17')
rows=[]
for J,sa,sv,ca,cax in [('9','9.61574237407e-7','3.78331740398e-6','9.49e-7','1.83e-6'),('10','9.10167633416e-7','3.40498566358e-6','9e-7','1.65e-6')]:
    J,sa,sv,ca,cax=map(F,[J,sa,sv,ca,cax])
    Acap=b*b/(4*(2*J+2*M));Vcap=b*b/(4*J)
    assert sa<Acap and sv<Vcap
    assert 3*(J+M+F('7.2e11')*F('1e-30'))<57
    mixed=a*bp*F('4.15e14')+a*bs*57+bp*bs*F('3.6e11')
    af=a*ca+49*F('7.78')*F('2.85')*bp
    axf=a*a*cax+F('.640208')*F('2.85')*bs+mixed
    assert af<sa and axf<sv/2
    rows.append({'J':str(J),'safe_A':str(sa),'safe_V':str(sv),'safe_Astar_Cross':str(sv/2),
      'coprime_A_input':str(ca),'coprime_Astar_Cross_input':str(cax),
      'full_A_exact':str(af),'full_A_decimal':float(af),'full_Astar_Cross_exact':str(axf),'full_Astar_Cross_decimal':float(axf)})
print(json.dumps({'status':'Every displayed safe budget and transfer comparison verified with exact Fraction arithmetic. This does not prove the analytic premises.','rows':rows},indent=2))
