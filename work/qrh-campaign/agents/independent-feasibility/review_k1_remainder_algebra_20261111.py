"""Independent exact K=1 defect/exponent/tail ledger. No special functions."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib,json

def c(a=0,b=0):return Q(a),Q(b)
def ca(a,b):return a[0]+b[0],a[1]+b[1]
def cm(a,b):return a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0]
def ck(k,a):return k*a[0],k*a[1]
def add(a,b):
    return [ca(a[i] if i<len(a) else c(),b[i] if i<len(b) else c()) for i in range(max(len(a),len(b)))]
def mul(a,b):
    r=[c()]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):r[i+j]=ca(r[i+j],cm(x,y))
    return r
def diff(a):return [ck(Q(i),a[i]) for i in range(1,len(a))]
def scale(k,a):return [ck(k,v) for v in a]
def clean(a):
    while a and a[-1]==c():a.pop()
    return a
checks={}
def check(k,b):
    assert b,k
    checks[k]=True
P1=[c(),c(0,-1),c(),c(Q(1,3))]
P2=[c(),c(),c(-Q(3,2)),c(),c(0,-Q(5,6)),c(),c(Q(1,18))]
check('P1_derivative',diff(P1)==[c(0,-1),c(),c(1)])
defect=add(mul([c(0,-1),c(),c(1)],P1),mul([c(),c(0,-2)],diff(P1)))
check('P2_defect_derivative',clean(defect)==diff(P2))
check('Gprime_tau_inverse_cancellation',ca(cm(c(0,Q(1,8)),c(0,2)),c(Q(1,4)))==c())
check('Gprime_linear_cancellation',ca(cm(c(Q(1,4)),c(0,2)),c(0,-Q(1,2)))==c())
check('Gprime_constant_tau',cm(c(-Q(1,2)),c(0,2))==c(0,-1))
check('Gprime_quadratic_tau',cm(c(0,-Q(1,2)),c(0,2))==c(1))
# Antiderivative and W derivative, both after clearing positive D=1+(x-1)^2.
D=[c(2),c(-2),c(1)]
antiderivative_num=add(mul([c(1),c(1)],D),[c(-2)])
check('f_antiderivative',antiderivative_num==[c(),c(),c(-1),c(1)])
Wnum=add(scale(Q(25),antiderivative_num),scale(Q(-28),mul([c(),c(1)],D)))
Wfact=scale(Q(-3),mul(mul([c(),c(1)],[c(-Q(7,3)),c(1)]),[c(-8),c(1)]))
check('W_derivative_factorization',Wnum==Wfact)
check('W8_strict_margin',Q(133,50)-Q(157,50)+Q(2,7)==-Q(34,175))
check('negative_small_exponent',Q(1,6)*Q(1,4)*Q(1,2)==Q(1,48))
check('middle_decay_dominates_w0',Q(1,2)-Q(1,48)>Q(17,36))
check('far_positive_decay',Q(1,2)-Q(7,25)==Q(11,50))
V=[Q(3)/2,Q(10,3)/4,Q(1,3)/6]
check('integrated_P2prime_bound',V==[Q(3,2),Q(5,6),Q(1,18)])
w=Q(17,36)
y2=Q(250,1099)*(Q(3,2)/w+Q(5,6)/w**2+Q(1,9)/w**3)
y3=Q(100,157)*(Q(3,2)+Q(5,3)+Q(4,9))
check('Y2_exact',y2==Q(9787500,5399387))
check('Y3_exact',y3==Q(3250,1413))
check('Y2_threshold',y2<Q(182,100));check('Y3_threshold',y3<Q(231,100))
T=Q(1500);theta=Q(1,4)
check('all_tail_Gamma_domains',theta**2*T/4>Q(7,2) and Q(11,50)*T>Q(7,2))
check('source_t_threshold',T>Q(7)/Q(44,100))
check('source_theta_threshold',theta**2>Q(14)/T)
check('theta_sqrtT_upper10',theta**2*T<100)
check('sqrtT_upper39',T<39**2)
check('discarded_sinh_arguments',2*Q(157,50)*T>80**2)
check('discarded_positive_prefactor',Q(44,100)**2*2*Q(157,50)>1)
check('positive_Taylor_e_gt_8over3',sum(Q(1,d) for d in (1,1,2,6,24))>Q(8,3))
check('negative_tail_exp',T/64>20 and Q(8,3)**20>300_000_000)
check('positive_tail_exp',Q(11,50)*T==330 and 330>40)
poly=lambda z:Q(9,4)+Q(25,12)*z+Q(7,36)*z*z
check('tail_poly1',poly(100)<2200);check('tail_poly4',poly(T)<450000)
y1=Q(22000,300_000_000);y4=Q(39*450000,2**40)
check('tail1_threshold',y1<Q(1,1000));check('tail4_threshold',y4<Q(1,1000))
check('final_rounded_bound',Q(1,1000)+Q(182,100)+Q(231,100)+Q(1,1000)==Q(1033,250)<Q(21,5))
check('final_exact_bound',y1+y2+y3+y4<Q(21,5))
out=dict(status='PASS_INDEPENDENT_K1_ALGEBRA_AND_CONSTANTS',checks=checks,check_count=len(checks),
    Y_upper=list(map(str,(y1,y2,y3,y4))),exact_sum=str(y1+y2+y3+y4),
    script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    scope='Polynomial identities and exact margins; contour identity, ODE/FTC, f-calculus and tail-integral inequalities are paper proofs, not proved by this script.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
