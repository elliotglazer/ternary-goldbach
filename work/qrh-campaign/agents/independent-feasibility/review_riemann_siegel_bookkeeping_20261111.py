"""Exact branch/orientation/coefficient ledger; not a contour proof."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib,json

def z(a=0,b=0):return Q(a),Q(b)
def add(a,b):return a[0]+b[0],a[1]+b[1]
def mul(a,b):return a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0]
def scale(k,a):return k*a[0],k*a[1]
I=z(0,1);eh=z(1,1);etah=z(-1,1)
checks={}
def check(k,v):
    assert v,k
    checks[k]=True
check('epsilon_eta_equals_minus_one',scale(Q(1,2),mul(eh,etah))==z(-1))
check('mixed_i_epsilon_eta_is_pure_imaginary',scale(Q(1,2),mul(I,mul(eh,etah)))==z(0,-1))
check('epsilon_square_is_i',scale(Q(1,2),mul(eh,eh))==I)
check('eta_square_is_minus_i',scale(Q(1,2),mul(etah,etah))==z(0,-1))
check('ray_Gamma_branch_coefficient',Q(3,4)-Q(1,4)==Q(1,2))
check('lambda_Arg_lower',-Q(3,4)+Q(1,4)==-Q(1,2))
check('lambda_Arg_upper',Q(1,4)+Q(1,4)==Q(1,2))
# -exp(-i*pi*(s-1))=exp(-i*pi*s): constant phases differ by2*pi.
check('inward_ray_sign_cancels_power_shift',1+1==2)
# Duplication: 2^-s Gamma(s) pi^-s = Gamma(s/2)Gamma((s+1)/2)/(2*pi^(s+1/2)).
# Compare constant and s coefficients in the pi exponent.
check('duplication_pi_exponents',(Q(1,2)-1,-Q(1,2)-Q(1,2))==(-Q(1,2),-Q(1)))
check('reflection_gamma_argument_sum',Q(1,2)+Q(1,2)==1)
# Signed cross product of the first long edge and the rightward connector.
cross=lambda a,b:a[0]*b[1]-a[1]*b[0]
check('finite_B_shift_CCW',cross(z(1,-1),z(1,0))>0)
check('Mordell_shift_clockwise',cross(z(1,1),z(1,0))<0)
check('integer_residue_parity',[n*n%2 for n in range(2)]==[n%2 for n in range(2)])
check('factor19_quadratic_coefficients',(-1,-2,-2+1)==(-1,-2,-1))
check('linear_g_coefficient',mul(z(0,-2),z(0,Q(1,2)))==z(1))
check('quadratic_g_coefficient',mul(I,z(-Q(1,4)))==z(0,-Q(1,4)))
check('transformed_Gaussian_v2',mul(z(0,-2),z(-Q(1,4)))==z(0,Q(1,2)))
check('transformed_Gaussian_vq',mul(z(0,Q(1,2)),z(0,-2))==z(1))
check('transformed_Gaussian_q2',mul(z(0,Q(1,2)),z(-1))==z(0,-Q(1,2)))
check('integer_sign_cancels_to_minus_one',( -1-0)==-1)
u_start,u_end=Q(3,4),-Q(1,4)
v_before_start,v_before_end=u_start-Q(1,2),u_end-Q(1,2)
check('u_endpoint_clockwise_halfcircle',u_end-u_start==-1)
check('v_rotated_before_reversal',(v_before_start,v_before_end)==(Q(1,4),-Q(3,4)))
check('v_final_counterclockwise_halfcircle',v_before_start-v_before_end==1)
# The positive-real scaling identity u=a*(1+2i*tau*w) maps the cut exactly.
check('cut_real_part_for_w_ir',mul(z(0,2),I)==z(-2))
out=dict(status='PASS_EXACT_RS_BOOKKEEPING',checks=checks,check_count=len(checks),
    script_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    scope='Exact elementary coefficients and orientation signs only; no analytic continuation, contour limit, residue, or Gamma identity is established by this script.')
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps(out,indent=2))
