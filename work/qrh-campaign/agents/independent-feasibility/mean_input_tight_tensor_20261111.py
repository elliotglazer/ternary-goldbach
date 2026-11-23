"""Fixed scalar/source checks for tight mean-input composition; no inventory or values."""
from pathlib import Path
from fractions import Fraction as F
from math import prod
import hashlib
import json

HERE=Path(__file__).resolve().parent
ROOT=HERE.parent
PINS={
 'independent-feasibility/MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md':'160E25353C24850DCA6D167AA5D85D54579FED642BAB3A1E55CC6AD0358C2AF6',
 'integration/REVIEW_MEAN_INPUT_TRANSFORM_ERROR_RESEARCH_2026-11-11.md':'0B9AED8611C449C11E0A8758F364008032B6B887D45A6BCEF1BFC38CE0BD2EF7',
 'prime-estimates/TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'5E3B9FCDC374998149ABBF3262BF925E0D02C6BFBF399462D1C34ABB68218F6F',
 'major-constants/REVIEW_TIGHTER_NORMALIZED_CHIRP_CONSTANT_2026-11-11.md':'E7482930B1A6B57FD6C186AD4612E655379D0978DD6C5EDA9C4D4D6D247920F5',
 'integration/TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md':'DB2E3B9FF269E551901622B844AF579D7FCE12045F71B66D947CA392FD1A928C',
 'zero-sum/REVIEW_TIGHT_TENSOR_PRODUCT_TRANSFORM_PRECISION_RULE_2026-11-11.md':'EC2FD8569DF2D74B758F6FDD9DC58153BD0FF6B662919ECE43B014C0E064BC26',
 'zero-sum/FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md':'F0B7399E638A7EBD43FE37F9EAAD8DCFB0583FEA785F7425D9DAFF096D464DE6',
 'integration/REVIEW_FUTURE_P50_EXACT_TENSOR_SELECTOR_2026-11-11.md':'372F685F72449A11C970ADD855EB5CB64D52E4512B669DB1AD2FC6102FB6DD37',
 'audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904',
 'prime-estimates/REVIEW_SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md':'1E9D3CDE80AB9BD78FD250E9404BF9936AA782F92CD9D2BDCC799D6558869328',
 'audit/LARGE_CHARACTER_COMPLETE_ERROR_CONTRACT_2026-11-11.md':'96063365898AE39625876AD5FF47D604F83A8C66BF1587F47763489C9F0A1C3D',
 'audit/LARGE_BRANCH_UNIFORM_STABILITY_ALLOCATION_2026-11-11.md':'6F856467F0EC3B1BD4EDA6817FC71BCA3DC6DA71F32BF96F3AE85E8D034032BA',
 'independent-feasibility/BLUESTEIN_NORMALIZATION_CONTEXT_INTERFACE_2026-11-11.md':'412A96766A6DF164F1332D09BD8CBF41959DB6C0BF9388C3EFD87C94ECBC0ED7',
}
checks=0
def ck(b):
 global checks
 checks+=1
 if not b: raise AssertionError(checks)
for name,h in PINS.items():
 ck(hashlib.sha256((ROOT/name).read_bytes()).hexdigest().upper()==h)

rows=[]
for n in (2,3,13,257):
 P=1<<(2*n-2).bit_length()
 k=P.bit_length()-1
 R=2*k+4; A=1+3*R
 Q=3*n*P*A+1; D=max(1,2*k,P*A,Q)
 old=6*P*A+2*R*(2*n+1)+8
 sharp=F(9*P*A+3*P,2)+3*R*n+12*R+14
 E=P*(3*n*A+n+2)+R*(n*(2*n-1)+2*P)
 X=F(E,n); tight=(E+n-1)//n+2
 u=F(1,max(D,2*old))
 ck(2*n*(sharp-(F(3,2)*X+F(n+1,n)))==R*(27*n-6*P)+26*n-6*P-2)
 ck(X<sharp<old)
 ck(u*X<=F(1,2))
 ck(X+u*X+F(n+1,n)<=tight<=sharp)
 ck(max(D,2*old)>=D)
 rows.append({'n':n,'old':old,'sharp':int(sharp),'tight':tight,'D_t':max(D,2*old)})
ck(F(601,1024)<=1 and F(2*688,1024)>1)

# Scalar identities behind the induction, on fixed arbitrary nonnegative tuples.
f=lambda a,b:a+b*(2*a+1)
for a,b,x,y in ((0,0,0,0),(2,3,5,7),(11,19,0,1)):
 ck(f(a+x,b+y)-f(a,b)==x*(1+2*b)+y*(2*a+1)+2*x*y)
for t,a in ((F(0),F(0)),(F(1,4),F(1,8)),(F(2,5),F(1,3))):
 ck(1-t-(1+a)*(1-t-a)==a*t+a*a)
 ck((1+a)/(1-t)<=1/(1-t-a))
for cs in ((0,), (2,3,7), (11,0,19)):
 T=2**50; S=sum(cs)
 e=F(0)
 for c in cs:e=e+F(c,T)*(1+e)
 ck(e==prod(1+F(c,T) for c in cs)-1)
 ck(e<=F(S,T-S))

Sg=202305920; Cg=4196258524692480
ck(Sg<2**28<2**50)
ck(Cg==1266*Sg*16384)
ck(29961461170177<2**45<2**50)
ck(849412408<2**30<2**50)
reserve=F(1032,2**63)+F(1,2**50)
ck(reserve<F(1,2**52)+F(1,2**50)<1)
ck(175+F(1001,96)<186)
ck(173+516+F(1032,2**63)+1+F(1,2**50)<692)

# Formal denominator clearing checked at four abstract scalar fixtures, not rows.
for S,T,rho in ((0,2**50,1),(0,2**108,0),(7,2**50,1),(Sg,2**108,0)):
 W=rho*(T-S)+186*S*T
 e=F(rho,T)+F(186*S,T-S)
 ck(e==F(W,T*(T-S)))
 ck(e*e*T*T*(T-S)**2==W*W)
 ck(F(rho,2*T)+F(186*S,2*T-S)<=e)
ck(633*F(186*Sg,2**108-Sg)<=F(Cg,2**108))

Rfixed=F(927193523,10**9*2**46)+135*(F(1,2**82)+F(4,2**63))+F(10,2**54)+F(93,2**55)+F(1,2**51)
ratio=(Rfixed+135*F(Cg,2**108))*2**45
ck(ratio==F(2804840254168152529,4294967296000000000))

data={'scope':'fixed scalars and hashes only; no assignment, metadata fold or values',
 'checks':checks,'pins':PINS,'synthetic_leaf_fixtures':rows,
 'V_mean':186,'V_width':692,'complete_radius_ratio':str(ratio)}
out=HERE/'mean_input_tight_tensor_20261111.json'
with out.open('x',encoding='utf-8',newline='\n') as g:
 json.dump(data,g,indent=2);g.write('\n')
print(json.dumps({'checks':checks,'receipt_bytes':out.stat().st_size,'sha256':hashlib.sha256(out.read_bytes()).hexdigest().upper()}))
