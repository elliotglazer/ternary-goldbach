"""Independent exact geometry/envelope/schedule review. No evaluator imports."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb, gcd, factorial
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
AGENTS=ROOT/'work/qrh-campaign/agents'

def geometry_checks(check):
    cases=0
    ties=0
    for c in range(2,130):
        for F in range(1,33):
            cells={}
            for a in range(1,c):
                k=(2*F*a+c-1)//(2*c)
                cells.setdefault(k,[]).append(a)
                check(2*k*c-c+1<=2*F*a<=2*k*c+c)
                if 2*F*a==(2*k+1)*c:
                    ties+=1
            for k in range(F+1):
                lo=max(1,((2*k-1)*c)//(2*F)+1)
                hi=min(c-1,((2*k+1)*c)//(2*F))
                check(cells.get(k,[])==list(range(lo,hi+1)))
                if lo>hi:
                    continue
                L=hi-lo+1
                check(2*F*(L-1)<=2*c-1)
                check(F*(L-1)<=c-1)
                if L>=11:check(c>10*F)
                if L>=21:check(c>20*F)
                m=min(20,L)
                for j in range(m):
                    check(-Q(1,4)<Q(F*(lo+j)-k*c,2*c)<=Q(1,4))
                cases+=1
    return {'nonempty_bounded_fixture_cells':cases,'exact_tie_inputs':ties}

PINS={
'major-constants/LENGTH_GUARDED_STAGEWISE_FD_COSTS_2026-11-11.md':'C41D1BA7E981F3317CECD08E0AAFB5B326E34368DFC7A567AE87A4CE32E0299A',
'major-constants/length_guard_fd_costs_20261111.py':'D1D3DC304F17B1FC9314BAF789FD6E2F16001F7DC893176CC271C9D107AA972A',
'major-constants/length_guard_fd_costs_20261111.json':'5388F1D02DBA2A7BD4F921DAAE55AA4BEEAFC3217E6DC0C7F65DFBECC8A2CA50',
'moebius/platt-reuse-sources/int-l-func5.11.cpp':'3D9B2B23B35129899048C23806AA42A4F2B08BE10304611AC9E1C913300FE852'}

def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def v2(n):
    assert n>0
    t=0
    while n%2==0:n//=2;t+=1
    return t
def width(x):
    # Strict magnitude bound x: smallest positive b for which x<=2^b.
    b=max(1,x.numerator.bit_length()-x.denominator.bit_length()-1)
    while Q(2)**b<x:b+=1
    return b

class Ledger:
    def __init__(self):self.events=[]
    def mul(self,a,b):self.events.append(('mul',a,b))
    def add(self,w,signed=True):self.events.append(('add',w,signed))
    def shift(self,w,s):self.events.append(('shift',max(1,w),s))
    def wire(self):
        d=dict(core=0,product_macros=0,adder_macros=0,shift_terms=[],signed_bridges=0)
        for kind,a,b in self.events:
            if kind=='shift':d['shift_terms'].append([a,b])
            elif kind=='add':
                d['core']+=2*((max(1,a)+7)//8)+1
                d['adder_macros']+=1;d['signed_bridges']+=int(b)
            else:
                x,y=(max(1,a)+7)//8,(max(1,b)+7)//8
                d['core']+=5*x*y+2*min(x,y)+1
                d['product_macros']+=1;d['signed_bridges']+=1
        return d
    def nearest(self,qbits,D,w,prepare=None,dyadic=False):
        t=v2(D);odd=D//2**t;db=D.bit_length()
        if dyadic:
            assert odd==1
            self.shift(qbits,t)
        else:
            self.mul(qbits,odd.bit_length())
            if t:self.shift(qbits+odd.bit_length(),t)
        # qD+R=X; 2R+D=W; W+g+1=2D.
        self.add(w);self.add(db+3);self.add(db+2,False)
        self.shift(db+1,1);self.shift(db,1)
        if prepare is not None:self.shift(*prepare)

def main():
    checks=0
    def ck(ok):
        nonlocal checks
        assert ok,checks
        checks+=1
    for path,h in PINS.items():ck(digest(AGENTS/path)==h)
    saved=json.loads((AGENTS/'major-constants/length_guard_fd_costs_20261111.json').read_text())
    for path,h in saved['pins'].items():ck(digest(AGENTS/path)==h)
    env=json.loads((AGENTS/'major-constants/stagewise_newton_widths_20261111.json').read_text())
    hor=json.loads((AGENTS/'moebius/fixed_horner_degree_envelope_costs_20261111.json').read_text())
    geo=geometry_checks(ck)
    u=Q(1,2**100)
    # Independently form each finite-difference kernel using alternating values,
    # not the author's Stirling recursion.
    kernels={}
    for sigma in (Q(1,20),Q(1,40)):
        for ell in range(20):
            for j in range(ell+1):
                kernels[sigma,ell,j]=sum((-1)**(j-a)*comb(j,a)*(Q(1,4)+a*sigma)**ell for a in range(j+1))
    summaries=[]
    for row in saved['rows']:
        c,F,k=row['c'],row['F'],row['k']
        # Enumerate only this bounded cell, independently testing membership.
        lo=max(1,((2*k-1)*c)//(2*F)+1)
        hi=min(c-1,((2*k+1)*c)//(2*F))
        aa=list(range(lo,hi+1));L=len(aa);units=[a for a in aa if gcd(a,c)==1]
        ck((lo,hi,L,len(units))==(row['lo'],row['hi'],row['L'],row['U']))
        ck(all(2*k*c-c<2*F*a<=2*k*c+c for a in aa))
        mode='guard20' if L>=21 else 'guard10' if L>=11 else 'all_cell'
        ck(mode==row['domain'])
        if mode!='all_cell':ck(c>(20 if mode=='guard20' else 10)*F)
        m=min(20,L);S=sum(comb(L-1,j) for j in range(m));p=102+S.bit_length()
        ck((m,p)==(row['m'],row['p']));ck(Q(S,2**p)<u/4)
        cohort=row['cohort'];cs=list(map(Q,env['rows'][cohort]['converted_coefficient_bounds']))
        E={}
        for i in range(20):
            for j in range(min(i,m-1)+1):
                if mode=='all_cell':e=2**j*sum(cs[19-i+ell]/4**ell for ell in range(j,i+1))
                else:
                    sigma=Q(1,40 if mode=='guard20' else 20)
                    e=sum(cs[19-i+ell]*kernels[sigma,ell,j] for ell in range(j,i+1))
                E[i,j]=e
                ck(e==Q(env['rows'][cohort]['domains'][mode][i]['states'][j]['norm_bound']))
        v=2*c;r=F*lo-k*c
        # GCD of the complete common-factor triple, not the parity shortcut.
        t=v2(gcd(gcd(F,abs(k*c)),v)) if mode!='all_cell' else 0
        vp=v//2**t;Fp=F//2**t;rp=r//2**t
        lam=[v2(Fp**j*factorial(j)) for j in range(20)] if mode!='all_cell' else [0]*20
        ck(t==row['t']);ck(r==rp*2**t)
        def w(i,j,e):return width(e*2**100*vp**i/Q(2)**lam[j])
        led={key:Ledger() for key in ('cold_power_setup','initialization','exact_advances','rounded_advances','initial_rounding','exact_unit_rounding','dyadic_unit_rounding')}
        init=led['initialization'];power=led['cold_power_setup']
        for i in range(1,20):
            power.mul((vp**(i-1)).bit_length(),vp.bit_length())
            for _ in range(2):init.mul(width(cs[19-i]*2**100),(vp**i).bit_length())
            for j in range(min(i-1,m-1)+1):
                if j==0:total=E[i-1,0]/4+cs[19-i]
                elif mode=='all_cell':total=E[i-1,j]/4+E[i-1,j-1]/2
                else:total=(Q(1,4)+j*sigma)*E[i-1,j]+j*sigma*E[i-1,j-1]
                for _ in range(2):
                    init.mul(w(i-1,j,E[i-1,j]),max(1,abs(rp+j*Fp).bit_length()))
                    init.add(w(i,j,total)+1)
            for j in range(1,min(i,m-1)+1):
                scale=j//2**v2(j) if mode!='all_cell' else j*F
                second=(j*sigma if mode!='all_cell' else Q(1,2))*E[i-1,j-1]
                for _ in range(2):
                    for bit in range(scale.bit_length()):
                        if scale&(1<<bit):init.shift(w(i-1,j-1,E[i-1,j-1]),bit)
                    for unused in range(scale.bit_count()-1):init.add(w(i,j,second)+1)
        expected_general=m*(39-m)//2
        ck(init.wire()['product_macros']==2*(19+expected_general))
        count=0
        for n in range(L-1):
            for j in range(min(19,L-1-n)):
                count+=1
                for _ in range(2):
                    if mode!='all_cell':led['exact_advances'].shift(w(19,j+1,E[19,j+1]),lam[j+1]-lam[j])
                    led['exact_advances'].add(w(19,j,E[19,j]+E[19,j+1])+1)
                    led['rounded_advances'].add(width((E[19,j]+E[19,j+1]+u/2)*2**p)+1)
        ck(count==sum(min(19,L-1-n) for n in range(L-1)))
        for j in range(m):
            a=p-100+lam[j];den=vp**19;cancel=min(a,v2(den));den//=2**cancel
            qb=width(E[19,j]*2**p+1)
            scratch=max(width(E[19,j]*2**p*den),qb+den.bit_length())+2
            for _ in range(2):led['initial_rounding'].nearest(qb,den,scratch,(w(19,j,E[19,j]),a-cancel))
        qb=width((E[19,0]+Q(5,4)*u)*2**100)
        for a in units:
            rr=F*a-k*c;tp=v2(gcd(abs(rr),v));D=(v//2**tp)**19
            for _ in range(2):
                led['exact_unit_rounding'].nearest(qb,D,qb+D.bit_length()+2)
                if tp>t:led['exact_unit_rounding'].shift(w(19,0,E[19,0]),19*(tp-t))
                led['dyadic_unit_rounding'].nearest(qb,2**(p-100),width((E[19,0]+u/4)*2**p)+2,dyadic=True)
        for name,Ld in led.items():ck(Ld.wire()==row[name])
        for profile,data in hor['results'][cohort].items():
            H=Ledger()
            for a in units:
                rr=F*a-k*c;tp=v2(gcd(abs(rr),v));rr//=2**tp;dd=v//2**tp
                for st in data['stages']:
                    align=st['output_grid']-st['input_grid'];cancel=min(align,v2(dd));D=dd//2**cancel
                    ib=st['input_magnitude_bits'];qb1=st['rounded_product_magnitude_bits'];rb=max(1,abs(rr).bit_length())
                    scratch=max(ib+rb+align-cancel,qb1+D.bit_length())+2
                    for _ in range(2):
                        H.mul(ib,rb);H.nearest(qb1,D,scratch,(ib+rb,align-cancel));H.add(st['output_add_and_state_signed_bits'])
            ck(H.wire()==row['horner'][profile])
        def total(names):return sum(led[n].wire()['core'] for n in names)
        ex=total(['cold_power_setup','initialization','exact_advances','exact_unit_rounding'])
        ro=total(['cold_power_setup','initialization','rounded_advances','initial_rounding','dyadic_unit_rounding'])
        ck(ex==row['exact_FD_core']);ck(ro==row['rounded_FD_core'])
        expectedH=200+max(255,(Q(191,10)*Q(3927,1250)*1063200/c).__ceil__())
        ck(expectedH==row['target_height']);ck(Q(5*row['source_height_example_index'],64)<expectedH)
        ck(c%4==0 and 10000<c<=265800)
        summaries.append(dict(c=c,F=F,k=k,L=L,U=len(units),m=m,p=p,domain=mode,exact_FD_core=ex,rounded_FD_core=ro))
    out=dict(status='PASS_EXACT_METADATA_AND_BOUNDED_SOURCE_REVIEW',checks=checks,pins=PINS,input_pins=saved['pins'],geometry=geo,rows=summaries,scope='No author imports, actual coefficient values, builds, family sweep or total-price winner.')
    dest=Path(__file__).with_suffix('.json')
    with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(out,f,indent=2);f.write('\n')
    print(json.dumps(dict(checks=checks,receipt_sha256=digest(dest))))

if __name__=='__main__':main()
