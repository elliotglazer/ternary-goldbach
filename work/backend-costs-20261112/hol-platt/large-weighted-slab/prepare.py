"""Make real band-1 coefficient blocks and independent packed output fixtures."""
import hashlib
import json
import sys
from fractions import Fraction as F
from math import gcd
from pathlib import Path

HERE=Path(__file__).resolve().parent
HOL=HERE.parent
sys.path.insert(0,str(HOL/"large-subcell-source"))
from grid import cap_at, GRIDS, rnd

Q=1<<112
BOUT=1<<120
BIN=Q*BOUT
sys.set_int_max_str_digits(0)


def pack(xs,base):
    n=0
    for x in reversed(xs):
        n=n*base+x
    return n


def case(data,begin,heights,c):
    rows=data["rows"][begin:begin+heights]
    k=1
    columns=[[value<<(94-g) for row in rows for value in row["mixed"][str(k)][j]]
             for j,g in enumerate(GRIDS)]
    while not any(columns[-1]):
        columns.pop()
    n=2*len(rows)
    assert n&(n-1)==0
    packs=[pack(col,BIN) for col in columns]
    bias=pack([BIN//2+Q//2]*n,BIN)
    g=gcd(1024,c)
    v=2*c//g
    rs=[(1024*a-c*k)//g for a in range((2*k-1)*c//2048+1,(2*k+1)*c//2048+1)
        if gcd(a,c)==1]
    weighted,prepacked,outputs=[],[],[]
    worst=F(0)
    changed=0
    for r in rs:
        assert 4*abs(r)<=v
        ws=[Q]
        for _ in columns[1:]:
            ws.append(rnd(ws[-1]*r,v))
        weighted.append(ws)
        z=F(r,v)
        lanes=[sum(x*w for x,w in zip(cs,ws,strict=True)) for cs in zip(*columns)]
        expected=[]
        for cs,num in zip(zip(*columns),lanes,strict=True):
            original=sum(x*z**j for j,x in enumerate(cs))
            worst=max(worst,abs(original-F(num,Q)))
            y=rnd(num,Q)
            changed+=y!=rnd(original.numerator,original.denominator)
            assert 0<=num + BIN//2+Q//2<BIN and -(BOUT//2)<=y<BOUT//2
            expected.append(y+BOUT//2)
        packed_num=sum(p*w for p,w in zip(packs,ws,strict=True))+bias
        assert packed_num==pack([num+BIN//2+Q//2 for num in lanes],BIN)
        assert [((packed_num//BIN**i)%BIN)//Q for i in range(n)]==expected
        prepacked.append(packed_num)
        outputs.append(pack(expected,BOUT))
    return dict(name=f"c{c}h{rows[0]['h']}n{heights}",lanes=n,heights=heights,
                residues=len(rs),complex=heights*len(rs),degree=len(columns)-1,
                worst_grid94=float(worst),changed=changed), (v,bias,rs,packs,prepacked,outputs)


def resident_panel(low, edge):
    # These ordinary even conductors reach the top of band 1 in the main manifest.
    manifest=HOL.parents[1]/"qrh-campaign/agents/integration/transform_structural_manifest_20261111.json"
    actual={row[0]:row[4] for row in json.loads(manifest.read_bytes())["conductors"]}
    mod=(1<<61)-1
    out=[]
    with (HERE/"resident.txt").open("w",encoding="ascii",newline="\n") as f:
        for data in (low,edge):
            for heights in (8,32):
                rec,(_,bias,_,coeffs,_,_)=case(data,0,heights,131068)
                cs=[131068,131064,131060,131056,131052,131048,131044,131040]
                assert all(actual[c]>=6401 for c in cs)
                # A nontrivial control consumes every packed input even in the zero-group run.
                zz=lambda x: 2*abs(x)+int(x<0)
                seed=(sum(zz(x) for x in coeffs)+bias)%mod
                levels=rec["lanes"].bit_length()-1
                ns,acc=[0],[seed]
                groups=[]
                for c in cs:
                    r,(_,b,rs,co,_,expected)=case(data,0,heights,c)
                    assert co==coeffs and b==bias
                    v=2*c//gcd(1024,c)
                    groups.append((v,rs))
                    ns.append(ns[-1]+len(rs)*heights)
                    h=acc[-1]
                    for y in expected:
                        h=(17*h+y)%mod
                    acc.append(h)
                print(rec["name"],levels,bias,file=f)
                print(*coeffs,file=f)
                for v,rs in groups:
                    print(v,*rs,file=f)
                for n in (0,1,4,8):
                    print(n,ns[n],acc[n],file=f)
                out.append(dict(name=rec["name"],conductors=cs,complex=ns,checks=acc))
    return out


def main():
    sources=[HOL/"c10004-p20-slab/slab.json",HOL/"c10004-exact-horner/edge-slab.json"]
    low,edge=[json.loads(p.read_bytes()) for p in sources]
    assert low["grids"]==edge["grids"]==list(GRIDS)
    # The h=1 and h=6337 runs include eight or 32 distinct heights each.
    # c=131068 reaches h=8794 in the actual main height schedule.
    rows=[]
    with (HERE/"terms.txt").open("w",encoding="ascii",newline="\n") as f:
        for data in (low,edge):
            for heights in (8,32):
                rec,(v,bias,rs,coeffs,nums,outputs)=case(data,0,heights,131068)
                rows.append(rec)
                levels=rec["lanes"].bit_length()-1
                print(rec["name"],v,bias,levels,file=f)
                for xs in [rs,coeffs,nums,outputs]:
                    print(*xs,file=f)
                check=0
                for value in outputs:
                    check=(17*check+value) % ((1<<61)-1)
                print(check,file=f)
    mag=cap_at(6400)
    # The j=0 weight is exact. The geometric recurrence for later terms
    # gives <=2/3 units on grid Q in every coordinate power.
    err=sum(mag[1:])*F(2,3*Q)
    assert all(row["worst_grid94"]<=float(err) for row in rows)
    frontier=HOL.parents[1]/"qrh-campaign/agents/integration/guarded_residue_evaluation_frontier_20261111.json"
    baseline=json.loads(frontier.read_bytes())["selected_records"]["band1_K20_b94"]
    scale=F(633,1<<12)  # grid94 units, amplified and expressed in units of 2^-82
    converted=sum(F(3,4)*2**(94-b)*F(1,4)**j for j,b in enumerate(GRIDS))
    eval_old=sum(F(3,4)*(2 if j<19 else 1)*2**(94-b)*F(1,4)**j for j,b in enumerate(GRIDS))
    assert eval_old*scale == F(baseline["evaluation_ratio"])
    # sqrt(2) < 3/2. Coordinate-nearest terminal division costs <3/4 in norm.
    def ratio(pre):
        return F(baseline["alpha_ratio"])-scale*eval_old+scale*(converted+F(3,2)*pre+F(3,4))
    alpha=ratio(err)
    sub=ratio(F(1,64)+F(1,256))
    assert alpha<1 and sub<1
    panels=resident_panel(low,edge)
    result=dict(Q_bits=112,resident=panels,packed_output_lane_bits=120,weighted_uniform_prefinal_grid94=float(err),
                old_alpha_ratio=float(F(baseline["alpha_ratio"])),weighted_alpha_ratio=float(alpha),
                weighted_alpha_exact=str(alpha),subcell_alpha_ratio=float(sub),subcell_alpha_exact=str(sub),
                cases=rows,hashes={str(p.relative_to(HOL)) if p.is_relative_to(HOL) else p.name:
                                  hashlib.sha256(p.read_bytes()).hexdigest() for p in
                                  [*sources,frontier,HERE/"terms.txt",HERE/"resident.txt",Path(__file__),HOL/"large-subcell-source/grid.py"]})
    (HERE/"fixtures.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k not in ("hashes","weighted_alpha_exact","subcell_alpha_exact")},indent=2))


if __name__=="__main__":
    main()
