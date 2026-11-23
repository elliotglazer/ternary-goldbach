"""Exact finite bookkeeping only; no Lean import or analytic evaluator."""
from fractions import Fraction as F
from pathlib import Path
import hashlib, json
ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/openai-math/lean/OAI/NumberTheory/DirichletL'

def run():
    unit_factor_counts=[2,2,2,5,2,1,1,1,1,1,1,4,4,2,4]
    row_factor_counts=[7,7,8,3,2,7,8,2,4]
    row_allowances=[8*2,8*3,8*3,65536,6*256,2*5,2*3,32768,1]
    assert len(unit_factor_counts)==15 and max(unit_factor_counts)<=8
    assert len(row_factor_counts)==9 and max(row_factor_counts)<=8
    assert sum(row_allowances)==99921<262144==2**18
    assert 4*8*8+3==259
    assert 259+1==260
    assert F(260,600)<1 and F(6,600)<1
    for alpha in [F(1,2),F(1),F(2)]:
        assert 2*(alpha-F(1,2))==2*alpha-1
        assert F(1,2)-(alpha-F(1,2))==1-alpha
        assert 1+(alpha-F(1,2))==alpha+F(1,2)
        assert alpha+F(1,2)<=3 and alpha-F(1,2)<=2
    # rho=t*K: exponent vectors for (M,X,q,B,C,P^eta).
    t=(1,-2,1,-1,0,0); K=(-1,2,0,0,1,1)
    assert tuple(x+y for x,y in zip(t,K))==(0,0,1,-1,1,1)
    # (B*P^2)^(-2)*P^4 = B^(-2).
    assert (-2,-4+4)==(-2,0)
    sources={}
    for rel in ['QuadraticSieve/PoissonConstants.lean','QuadraticSieve/GlobalBinLoss.lean',
                'QuadraticSieve/PoissonComparison.lean','CubicSieve/ArithmeticBins.lean']:
        sources[rel]=hashlib.sha256((BASE/rel).read_bytes()).hexdigest().upper()
    return dict(status='PASS_EXACT_BOOKKEEPING_ONLY',unit_factor_counts=unit_factor_counts,
        row_factor_counts=row_factor_counts,row_allowances=row_allowances,
        sum_row_allowances=sum(row_allowances),claimed_cap=262144,
        selected_loss=259,next_divisor_loss=260,sources=sources,
        limitations='Finite arithmetic and exponent identities only; not analytic inequalities, builds or provider validation.')

if __name__=='__main__':
    import sys
    payload=run()
    target=Path(sys.argv[1]) if len(sys.argv)>1 else Path(__file__).with_suffix('.json')
    with target.open('x',encoding='utf-8') as f: json.dump(payload,f,indent=2); f.write('\n')
    print(payload['status'])
