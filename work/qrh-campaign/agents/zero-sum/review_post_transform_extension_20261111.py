"""Independent exact metadata/majorant checks. No analytic function values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
from hashlib import sha256
import json

here=Path(__file__).resolve().parent
agents=here.parent
repo=agents.parents[2]
author=agents/'integration/post_transform_certificate_metadata_20261111.json'
d=json.loads(author.read_text())
checks={}
def check(k,v):
    assert v,k
    checks[k]=True
for p,h in d['input_pins'].items():
    path=repo/p if p.startswith('work/') else agents/p
    check('pin:'+p,sha256(path.read_bytes()).hexdigest().upper()==h)
n=4333246843; C=125400; Q=66172730256514; SJ=2735223455
for key,v in {'large_conductors':C,'primitive_labels':n,'coarse_outputs':Q,'sum_J':SJ,
              'parity_global_phase_upper':255978,'conductor_phase_updates':SJ-C,
              'parity_conductor_time_products_upper':2*SJ,
              'dense_refined8_outputs':Q+7*(Q-n),'new_interpolation_outputs':7*(Q-n),
              'h1000_dense_extra_outputs':12800*n}.items():
    check(key,d[key]==v)
counts=[2607460638032558-1849018578634950,5400371016768720-3808420069398260,
        4*99513098256768,2068094728192,14350428160]
for (k,r),v in zip(d['savings'].items(),counts):
    check('saving:'+k,r['count']==v and F(r['per_nominal_output'])==F(v,Q))
for row in d['conditional_guard_rows']:
    h=row['h']; deficit=F(row['future_measured_D_upper']); b=F(row['b_upper'])
    check('log:'+str(h),8**18*6*64>3**18*(128160000*64+265800*5+265800*h*64))
    check('surplus:'+str(h),F(row['surplus'])==2-deficit-2*b/h>0)
    check('dense:'+str(h),row['dense_extra_outputs']==n*h*64//5)
V=10200; N=3454; D=8192; J=130548; b=N+2; P=32
check('exact_endpoint',F(J*5,64)==F(d['h200_candidate_extension']['last_t'])<V)
check('N_cutoff',3*(N-1)<V+160<=3*N)
check('E_factor_and_remainder',V+160<3*(N+1))
check('scaled_rising',F(V+32,D)<F(5,4))
rem=F(216*b,255*2**128)
check('EM_remainder',rem<F(1,2**116))
delta=F(1,2**118); u=F(1,2**122); eta=F(1,2**100)
# Reconstruct the head and endpoint allocation separately, rather than
# assuming the author's collapsed coefficient 291*N+433.
head=5*N*delta+(5*N*P+3*N+1)*u
endpoint=(2*b+1)*delta+(16*b+255)*u
err=head+endpoint+u+F(1,2**116)
check('coefficient_error',err/eta==F(291*N+433,2**22)<F(1,4))
check('stored_magnitude',4*(3*N+5)+1<2**16)
target=F(1266)*F(5,16)**20/factorial(20)
shift=F(1266)*F(15,16)**27/factorial(27)
check('shift_ratio',F(3*(V+27),4*D)<F(15,16))
check('complete_alpha',target+shift+2532*eta+633*(20*27-210)*F(1,2**110)+1688*eta<F(1,2**82))
check('log_range',b<4096 and F(8,3)**9>b)
check('log_phase',F(V,2**17)<F(1,8) and 9*V+1<100000)
check('recurrence_geometric',F(J,2**140)<F(1,2))
rec=F(1,2)+4*J*F(1,2**22)+F(1,16)
check('recurrence_total',rec==F(d['h200_candidate_extension']['recurrence_error_over_delta_upper'])<F(11,16))
check('state_width_unchanged',1+delta<2 and 1+F(1,2**140)<2)
check('h250_outside',F((127988+3200)*5,64)>10208)
out={'status':'PASS_EXACT_EXTENSION_AND_METADATA','checks':checks,
     'author_receipt_sha256':sha256(author.read_bytes()).hexdigest().upper(),
     'extra_domain_counts':{'global_argument_union':(N+1)*D+1,
                           'new_arguments_over_old':(N-3387)*D,
                           'maximum_extra_height_steps':2560},
     'scope':'No values, margins, interpolation guards or d=2 theorem established.'}
here.joinpath('review_post_transform_extension_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(out['status'],len(checks))
