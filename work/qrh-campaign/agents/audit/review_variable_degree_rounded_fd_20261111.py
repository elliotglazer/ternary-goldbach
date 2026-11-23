"""Independent rational/finite-combinatorial review, no evaluator imports."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb, factorial
import hashlib
import json

BASE=Path(__file__).resolve().parents[1]
PINS={
'major-constants/VARIABLE_DEGREE_GRID_ROUNDED_DIFFERENCES_2026-11-11.md':'79F8EA3F6F8BE2AA0EC61E335BB068EA2690A3AA84CBB4BBF39D6878FC4F1B55',
'major-constants/variable_degree_rounded_fd_20261111.py':'E967C5E2FF96D907239A24C8A8D6A4205F1A89FA462A00B54E406C16B666457F',
'major-constants/variable_degree_rounded_fd_20261111.json':'82C2BDAC4E313A18A90799957DDA04E2BB96FBB9FE2B62208D4714E9FED1B143'}

def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()

def main():
    count=0
    def ck(b):
        nonlocal count
        assert b,count
        count+=1
    assert len(PINS)==3
    for f,h in PINS.items():ck(sha(BASE/f)==h)
    data=json.loads((BASE/'major-constants/variable_degree_rounded_fd_20261111.json').read_text())
    for f,h in data['pins'].items():ck(sha(BASE/f)==h)
    lengths={};worst={};expected_candidates=[]
    ck(Q(1,2)<Q(3,4)**2)  # Two coordinate half-ulps give norm <3/4 ulp.
    for K in (18,19,20):
        n=K-1;ratios=[]
        for L in range(1,261):
            m=min(K,L)
            # Pascal rows built iteratively; no call to the author's recipe.
            pascal=[1]
            for t in range(1,L):pascal=[1]+[pascal[r-1]+pascal[r] for r in range(1,t)]+[1]
            S=sum(pascal[:m]);ell=S.bit_length()
            ck(S==sum(comb(L-1,j) for j in range(m)))
            for j in range(m):
                tmax=L-1-j
                # Bound every possible live time by its terminal time, then S.
                row_sum=sum(comb(tmax,r) for r in range(min(n-j,tmax)+1))
                ck(row_sum<=S)
                for r in range(min(n-j,tmax)+1):ck(comb(tmax,r)<=comb(L-1,r))
            products=adds=shifts=0
            for i in range(1,K):
                for j in range(min(i,m)):
                    products+=1;adds+=1
                for j in range(1,min(i,m-1)+1):
                    binary=[bit for bit in range(j.bit_length()) if j&(1<<bit)]
                    shifts+=len(binary);adds+=len(binary)-1
            advances=sum(1 for t in range(L-1) for j in range(min(n,L-1-t)))
            expected=dict(K=K,L=L,m=m,S=S,bitlength=ell,p_by_b_d='b+bitlength+d',prescales=n,
                general_complex_products=products,initial_complex_additions=adds,
                initial_shifted_operands=shifts,advance_complex_additions=advances,
                initial_complex_rounds=m,final_complex_rounds='U',export_coordinate_shifts='2U')
            lengths[K,L]=expected;ratios.append((Q(S,2**ell),L))
            ck(products==m*(2*n-m+1)//2)
            ck(advances==(L*(L-1)//2 if L<=K else n*L-n*(n+1)//2))
        worst[K]=max(ratios)
        ck(worst[K]==(Q(2**K-1,2**K),K+1))
        ck(data['worst_ratio_by_K'][str(K)]==dict(ratio=str(worst[K][0]),length=worst[K][1]))
    ck(len(data['length_rows'])==780)
    for row in data['length_rows']:ck(row==lengths[row['K'],row['L']])
    cases=[('band1',Q(500),512,False),('band2',Q(1000),1024,False),('band3',Q(2000),2048,False),
           ('band4',Q(5000),4096,False),('band5_declared',Q(7000),8192,True),('band5_actual',Q(424195,64),8192,True)]
    eta=Q(1,2**100)
    for K in (18,19,20):
        conversion=Q(3,4)*sum(Q(1,4)**j for j in range(K))
        ck(conversion==1-Q(1,4)**K)
        for b in range(93,101):
            for d in range(3):
                ev=conversion+Q(3,4)+Q(3,4)*worst[K][0]/2**d
                ck(ev<Q(5,2))
                for name,V,D,final in cases:
                    # Genuine length-K Taylor remainder, independent of old P20 truncation.
                    target=2*((V+K)/D)**K*Q(1,4)**K/factorial(K)*633
                    if final:
                        bias=2*(7028*Q(5,8*4096))**28/factorial(28)*633
                        numerical=Q(4,3)*eta*633
                    else:
                        bias=2*Q(15,16)**27/factorial(27)*633
                        numerical=(4*eta+330*Q(1,2**110))*633
                    alpha=target+bias+numerical+633*ev/2**b
                    expected_candidates.append(dict(case=name,V=str(V),D=D,K=K,b=b,d=d,worst_length=worst[K][1],
                        evaluation_in_ulps=str(ev),alpha_ratio=str(alpha*2**82),admitted=alpha<Q(1,2**82),
                        maximum_p=b+lengths[K,260]['bitlength']+d,output_grid100_shift=100-b))
                    for M in (-3,-1,0,1,3):ck(Q(M,2**b)==Q(M*2**(100-b),2**100))
    ck(len(expected_candidates)==432)
    ck(expected_candidates==data['candidates'])
    table=[('band1',19,93,2,187,944694),('band1',20,93,0,188,884695),
           ('band2',19,93,1,186,932496),('band3',19,93,1,186,905299),
           ('band4',20,93,1,189,899465),('band5_declared',19,93,0,185,927744),
           ('band5_actual',18,94,0,182,854224)]
    for name,K,b,d,p,upper in table:
        rows=[r for r in expected_candidates if (r['case'],r['K'],r['b'],r['d'])==(name,K,b,d)]
        ck(len(rows)==1)
        ck(rows[0]['admitted'] and rows[0]['maximum_p']==p)
        ck(Q(rows[0]['alpha_ratio'])<Q(upper,10**6)<1)
    summaries=[]
    for name,V,D,final in cases:
        for K in (18,19,20):
            for d in range(3):
                bs=[r['b'] for r in expected_candidates if r['case']==name and r['K']==K and r['d']==d and r['admitted']]
                summaries.append(dict(case=name,K=K,d=d,least_b=min(bs,default=None)))
    ck(summaries==data['summaries'])
    out=dict(status='PASS_BOUNDED_RATIONAL_AND_SOURCE_REVIEW',checks=count,pins=PINS,input_pins=data['pins'],
             length_rows=len(lengths),candidate_rows=len(expected_candidates),summaries=summaries,
             scope='No actual values, author imports, builds, cost ranking or old internal-error transfer.')
    dest=Path(__file__).with_suffix('.json')
    with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps(dict(checks=count,receipt_sha256=sha(dest))))

if __name__=='__main__':main()
