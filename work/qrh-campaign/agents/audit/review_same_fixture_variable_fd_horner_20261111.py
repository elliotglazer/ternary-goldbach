"""Independent same-fixture rational widths and typed operation schedules."""
from pathlib import Path
from fractions import Fraction as Q
from math import comb, factorial
from functools import lru_cache
import hashlib, json, importlib.util, sys

BASE=Path(__file__).resolve().parents[1]
PINS={
'major-constants/SAME_FIXTURE_VARIABLE_FD_HORNER_COSTS_2026-11-11.md':'96BB58D501F2D0F0402F1E723B8EED32F1AF0F0345ABF06A399B1DB687305D28',
'major-constants/same_fixture_variable_fd_horner_20261111.py':'B754421B15373C754D961C722A944BA2D15AF743750CA972D83589BB69320269',
'major-constants/same_fixture_variable_fd_horner_20261111.json':'CE69E0E4840011EEA1043BE1511E4CECF2FB72DF0CA5DA60A3AF6E4B7032E962'}
HELPER_HASH='E4ABFBDC2FEE600D3F407F8B080C1C57CFB4C67A9BEDBC2F304151CCBEDB0E00'
def digest(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()

def main():
    checks=0
    def ck(v):
        nonlocal checks
        assert v,checks
        checks+=1
    ck(len(PINS)==3)
    for p,h in PINS.items():ck(digest(BASE/p)==h)
    # Reuse only our prior reviewed event container/width functions. The module
    # has no top-level evaluator or artifact writes, and no author code is loaded.
    helper=Path(__file__).with_name('review_length_guarded_fd_schedule_20261111.py')
    ck(digest(helper)==HELPER_HASH)
    sys.dont_write_bytecode=True
    spec=importlib.util.spec_from_file_location('owned_review_helpers',helper)
    H=importlib.util.module_from_spec(spec);spec.loader.exec_module(H)
    width,v2,Ledger=H.width,H.v2,H.Ledger
    def read(p):return json.loads((BASE/p).read_text())
    saved=read('major-constants/same_fixture_variable_fd_horner_20261111.json')
    for p,h in saved['pins'].items():ck(digest(BASE/p)==h)
    old=read('major-constants/length_guard_fd_costs_20261111.json')
    fd=read('major-constants/variable_degree_rounded_fd_20261111.json')
    hor=read('moebius/joint_horner_length_precision_20261111.json')
    oldhor=read('moebius/fixed_horner_degree_envelope_costs_20261111.json')
    source=read('prime-estimates/stored_hurwitz_degree_bounds_20261111.json')
    U=Q(1,2**100);W=4*U+330*Q(1,2**110);flat=2**27*(U/4+330*Q(1,2**110));R=Q(1,2**116)
    Z={
        'first_four':[Q(5170)+R+W]+[6*Q(5,4)**k/factorial(k)+min(4**k*W,flat) for k in range(1,20)],
        'final':[Q(4507)+Q(9,2)+R+U]+[Q(15,2)*Q(7,8)**k/factorial(k)+U for k in range(1,20)]}
    for cl,zs in Z.items():ck(zs==[Q(r['stored_center_norm_bound']) for r in source['cohorts'][cl]])
    def wire(L):
        d=dict(core=0,products={},adders={},shifts={},signed_bridges=0)
        for typ,a,b in L.events:
            if typ=='mul':
                key=f'{max(1,a)},{max(1,b)}';x,y=(max(1,a)+7)//8,(max(1,b)+7)//8
                d['core']+=5*x*y+2*min(x,y)+1;d['signed_bridges']+=1;kind='products'
            elif typ=='add':
                key=str(max(1,a));d['core']+=2*((max(1,a)+7)//8)+1
                d['signed_bridges']+=int(b);kind='adders'
            else:key=f'{max(1,a)},{b}';kind='shifts'
            d[kind][key]=d[kind].get(key,0)+1
        return d
    def total(*ll):
        L=Ledger()
        for item in ll:L.events.extend(item.events)
        return wire(L)
    @lru_cache(None)
    def kernel(ell,j,sigma):
        return sum((-1)**(j-a)*comb(j,a)*(Q(1,4)+a*sigma)**ell for a in range(j+1))
    @lru_cache(None)
    def env(cl,K,b,mode):
        cs=[z+Q(3,4)/2**b for z in Z[cl][:K]];E=[]
        for i in range(K):
            E.append([sum(cs[K-1-i+ell]*(Q(2)**j/4**ell if mode=='all_cell' else kernel(ell,j,Q(1,40 if mode=='guard20' else 20))) for ell in range(j,i+1)) for j in range(i+1)])
        return cs,E
    def descriptors(row):
        ss=row['horner']['uniform100']['shift_terms'];p=0;ans=[];v=2*row['c']
        stages=oldhor['results'][row['cohort']]['uniform100']['stages']
        for unit in range(row['U']):
            candidates=[]
            for tp in range(v2(v)+1):
                q=p;den=v//2**tp;db=den.bit_length();r_bits=None;valid=True
                for st in stages:
                    for coord in range(2):
                        prefix=[]
                        if v2(den):prefix.append([st['rounded_product_magnitude_bits']+(den//2**v2(den)).bit_length(),v2(den)])
                        prefix.extend([[db+1,1],[db,1]])
                        if ss[q:q+len(prefix)]!=prefix:valid=False;break
                        q+=len(prefix)
                        if q>=len(ss) or ss[q][1]!=0:valid=False;break
                        rb=ss[q][0]-st['input_magnitude_bits'];q+=1
                        if rb<1 or (r_bits is not None and rb!=r_bits):valid=False;break
                        r_bits=rb
                    if not valid:break
                if valid:candidates.append((q,dict(den=den,r_bits=r_bits,tp=tp)))
            ck(len(candidates)==1);p,entry=candidates[0];ans.append(entry)
        ck(p==len(ss));return ans
    def fd_schedule(r,a,dd):
        K,b,d=a['K'],a['b'],a['d'];n=K-1;L=r['L'];m=min(K,L);mode=r['domain']
        cs,E=env(r['cohort'],K,b,mode);v=2*r['c'];F=r['F'];r0=F*r['lo']-r['k']*r['c']
        # Maximal common power, tested without any unit enumeration.
        t=0
        while F%2**(t+1)==v%2**(t+1)==r0%2**(t+1)==0:t+=1
        vp,Fp,rp=v//2**t,F//2**t,r0//2**t
        lam=[v2(Fp**j*factorial(j)) for j in range(K)]
        S=sum(comb(L-1,j) for j in range(m));p=b+S.bit_length()+d
        beta=Q(3*S,4*2**p);eb=Q(3,4*2**b);ep=Q(3,4*2**p)
        def w(i,j,x):return width(x*2**b*vp**i/Q(2)**lam[j])
        names=('cold_powers','initialization','initial_rounds','rounded_advances','dyadic_finals','grid100_exports','exact_advances','exact_finals')
        ls={name:Ledger() for name in names};init=ls['initialization']
        for i in range(1,K):
            ls['cold_powers'].mul((vp**(i-1)).bit_length(),vp.bit_length())
            for coord in range(2):init.mul(width(cs[n-i]*2**b),(vp**i).bit_length())
            for j in range(min(i,m)):
                if j==0:raw=E[i-1][0]/4+cs[n-i]
                elif mode=='all_cell':raw=E[i-1][j]/4+E[i-1][j-1]/2
                else:
                    step=Q(1,40 if mode=='guard20' else 20)
                    raw=(Q(1,4)+j*step)*E[i-1][j]+j*step*E[i-1][j-1]
                for coord in range(2):
                    init.mul(w(i-1,j,E[i-1][j]),max(1,abs(rp+j*Fp).bit_length()));init.add(w(i,j,raw)+1)
            for j in range(1,min(i,m-1)+1):
                scale=j//2**v2(j);sec=E[i-1][j-1]*(Q(1,2) if mode=='all_cell' else Q(j,40 if mode=='guard20' else 20))
                for coord in range(2):
                    for bit in range(scale.bit_length()):
                        if scale&(1<<bit):init.shift(w(i-1,j-1,E[i-1][j-1]),bit)
                    for unused in range(scale.bit_count()-1):init.add(w(i,j,sec)+1)
        for pos in range(L-1):
            for j in range(min(n,L-1-pos)):
                for coord in range(2):
                    ls['rounded_advances'].add(width((E[n][j]+E[n][j+1]+2*beta)*2**p)+1)
                    ls['exact_advances'].shift(w(n,j+1,E[n][j+1]),lam[j+1]-lam[j])
                    ls['exact_advances'].add(w(n,j,E[n][j]+E[n][j+1])+1)
        for j in range(m):
            D=vp**n;exponent=p-b+lam[j];cut=min(exponent,v2(D));D//=2**cut
            qb=width((E[n][j]+ep)*2**p);xb=width(E[n][j]*2**p*D)
            for coord in range(2):ls['initial_rounds'].nearest(qb,D,max(xb,qb+D.bit_length())+2,(w(n,j,E[n][j]),exponent-cut))
        qb=width((E[n][0]+beta+eb)*2**b);xb=width((E[n][0]+beta)*2**p)
        for unit in dd:
            for coord in range(2):
                ls['dyadic_finals'].nearest(qb,2**(p-b),max(xb,qb+p-b)+2,dyadic=True)
                D=unit['den']**n
                ls['exact_finals'].nearest(qb,D,qb+D.bit_length()+2)
                if unit['tp']>t:ls['exact_finals'].shift(w(n,0,E[n][0]),n*(unit['tp']-t))
                ls['grid100_exports'].shift(qb,100-b)
        return dict(K=K,b=b,d=d,p=p,beta=str(beta),alpha_ratio=a['alpha_ratio'],t=t,n=n,m=m,
            coefficient_conversions=K,prescales=n,initial_rounds=m,components={name:wire(Ld) for name,Ld in ls.items()},
            total=total(*(ls[name] for name in names[:6])),
            exact_FD_diagnostic=total(ls['cold_powers'],init,ls['exact_advances'],ls['exact_finals'],ls['grid100_exports']),
            live_max_signed_bits=max(width((E[n][j]+beta)*2**p)+1 for j in range(m)),
            output_signed_bits=qb+1,grid100_output_signed_bits=qb+101-b)
    def hor_schedule(r,profile,a,dd):
        K=a['K'];gr=a['grids'];cs=[z+Q(3,4*2**b) for z,b in zip(Z[r['cohort']][:K],gr)]
        states=[Q(0)]*K;prod_bounds=[Q(0)]*(K-1);states[-1]=cs[-1]
        for j in range(K-2,-1,-1):prod_bounds[j]=states[j+1]/4+Q(3,4*2**gr[j]);states[j]=prod_bounds[j]+cs[j]
        h,out=Ledger(),Ledger()
        for unit in dd:
            for j in range(K-2,-1,-1):
                ib=width(states[j+1]*2**gr[j+1]);qb=width(prod_bounds[j]*2**gr[j]);rb=unit['r_bits']
                align=gr[j]-gr[j+1];cut=min(align,v2(unit['den']));D=unit['den']//2**cut;left=align-cut
                w=max(ib+rb+left,qb+D.bit_length())+2
                for coord in range(2):
                    h.mul(ib,rb);h.nearest(qb,D,w,(ib+rb,left));h.add(width(states[j]*2**gr[j])+1)
            for coord in range(2):out.shift(width(states[0]*2**gr[0]),100-gr[0])
        return dict(profile=profile,K=K,b=gr[0],grids=gr,alpha_ratio=a['alpha_ratio'],coefficient_conversions=K,
                    evaluation=wire(h),grid100_exports=wire(out),total=total(h,out))
    ck(len(saved['rows'])==len(old['rows'])==12);summaries=[];nf=nh=0
    for r,row in zip(old['rows'],saved['rows']):
        ck(row['geometry']=={k:r[k] for k in ('c','F','k','lo','hi','L','U','domain','cohort')})
        case={1024:'band1',4096:'band3',8192:'band4',16384:'band5_declared'}[r['F']];ck(case==row['case'])
        dd=descriptors(r);ck(dd==row['unit_descriptors'])
        f_inputs=[a for a in fd['candidates'] if a['case']==case and a['admitted']]
        h_inputs=[(pr,a) for pr,data in hor['results'][case]['profiles'].items() for a in data['candidates'] if a['admitted']]
        ck(len(f_inputs)==len(row['fd_candidates']));ck(len(h_inputs)==len(row['horner_candidates']))
        for a,got in zip(f_inputs,row['fd_candidates']):ck(fd_schedule(r,a,dd)==got);nf+=1
        for (profile,a),got in zip(h_inputs,row['horner_candidates']):ck(hor_schedule(r,profile,a,dd)==got);nh+=1
        bf=min(row['fd_candidates'],key=lambda x:(x['total']['core'],x['K'],x['b'],x['d']))
        bh=min(row['horner_candidates'],key=lambda x:(x['total']['core'],x['K'],x['b'],x['profile']))
        expected=dict(fd=[bf['K'],bf['b'],bf['d'],bf['p'],bf['total']['core']],horner=[bh['profile'],bh['K'],bh['b'],bh['total']['core']],projected_horner_minus_fd=bh['total']['core']-bf['total']['core'])
        ck(expected==row['minimum_core']);ck(row['old_core']==dict(rounded_FD=r['rounded_FD_core'],fixed_Horner=r['horner']['fixed_15442']['core']))
        summaries.append(dict(c=r['c'],F=r['F'],L=r['L'],U=r['U'],**expected))
    result=dict(status='PASS_SAME_FIXTURE_EXACT_METADATA_REVIEW',checks=checks,pins=PINS,input_pins=saved['pins'],owned_helper_sha256=HELPER_HASH,
        fd_candidates=nf,horner_candidates=nh,rows=summaries,scope='No new cell or unit enumeration, no author imports or coefficient values; template projections only.')
    dest=Path(__file__).with_suffix('.json')
    with dest.open('x',encoding='utf8',newline='\n') as f:json.dump(result,f,indent=2);f.write('\n')
    print(json.dumps(dict(checks=checks,fd_candidates=nf,horner_candidates=nh,receipt_sha256=digest(dest))))

if __name__=='__main__':main()
