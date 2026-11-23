"""Independent symbolic Horner and signed witness review; no function values."""
from pathlib import Path
from fractions import Fraction as F
from math import factorial
import hashlib,json
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
AUTHOR=HERE.parent/'audit/b100_product_only_horner_20261111.json'
checks=0
def ck(x):
    global checks
    assert x
    checks+=1
def main():
    doc=json.loads(AUTHOR.read_text(encoding='utf-8'))
    for p,h in doc['pins'].items():
        ck(hashlib.sha256((ROOT/p).read_bytes()).hexdigest().upper()==h)
    u=F(1,2**100); C=2**16
    geometric=lambda n: F(4,3)*(1-F(1,4)**n)
    ck(F(doc['geometric_coefficient_factor'])==geometric(20))
    ck(F(doc['geometric_product_factor'])==geometric(19))
    ck(F(doc['combined_factor'])==geometric(20)+geometric(19)<F(8,3))
    ck(633*F(8,3)==doc['old_character_allowance']==1688)
    # Closed majorants for every stage, independent of actual coefficients.
    for k in range(20):
        err=u*geometric(k)
        bound=C*geometric(k+1)+err
        ck(bound<F(4,3)*(C+u)<2**17)
        if k:
            ck(err==u+u*geometric(k-1)/4)
            ck(bound==C+(C*geometric(k)+u*geometric(k-1))/4+u)
        ck(bound/4+u<2**15)
    ck(40665+u<C and 27043+u<C)
    acc=F(4,3)*(C+u)/u
    quotient=acc/4+1
    ck(acc<2**117)
    ck(quotient+1<2**115)
    ck(acc*132900<2**135)
    ck(quotient*531600<2**135)
    ck(quotient*531600+531599<2**136)
    ck(quotient+1+C/u<2**117)
    ck(2*531599<2**21)
    # Exhaust boundaries around every tie for both signs, avoiding polynomial samples.
    witnesses=0
    for v in [2,3,4,7,16,31,20002,265798,531600]:
        residues=sorted({0,1,v-1,max(0,v//2-1),v//2,min(v-1,v//2+1)})
        for q in [-2**114,-17,-1,0,1,17,2**114]:
            for s in residues:
                t=q*v+s
                m=(2*t+v)//(2*v)
                ck(m==q+int(2*s>=v))
                ck((2*m-1)*v<=2*t<(2*m+1)*v)
                ck(F(-1,2)<F(m)-F(t,v)<=F(1,2))
                witnesses+=1
    early=1266*(F(5,16)**20/factorial(20)+F(15,16)**27/factorial(27))
    early+=2532*u+633*330*F(1,2**110)+1688*u
    late=1266*(F(7020,32768)**20/factorial(20)+F(35140,32768)**28/factorial(28))+(844+1688)*u
    ck(early*2**82==F(doc['old_alpha_ratios']['first_four'])<F(1,3))
    ck(late*2**82==F(doc['old_alpha_ratios']['joint_final'])<F(4,25))
    ck(doc['signed_widths']==dict(coefficient=117,accumulator=118,displacement_numerator=19,
        raw_r_times_accumulator=136,floor_quotient=116,rounded_product=116,q_times_v=136,
        reconstruction_temporary=137,coefficient_sum=118))
    ck(doc['per_residue_complex']==dict(product_rounds=19,exact_additions=19,extra_final_rounds=0))
    ck(doc['per_residue_real_witnesses']==dict(r_times_accumulator=38,q_times_v=38,
        reconstruction_additions=38,rounding_decisions=38))
    out=dict(status='PASS_SYMBOLIC_ARITHMETIC_ONLY',checks=checks,synthetic_integer_witnesses=witnesses,
        author_receipt_sha256=hashlib.sha256(AUTHOR.read_bytes()).hexdigest().upper(),
        scope='All-stage closed bounds, signed tie witnesses, inherited alpha caps and widths; no actual coefficients or evaluator run.')
    with (HERE/'review_b100_product_horner_20261111.json').open('x',encoding='utf-8') as f:
        json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps(out))
if __name__=='__main__': main()
