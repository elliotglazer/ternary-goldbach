"""Exact scalar research; never invokes Lean or the source generator's writer.

The safe source prefix ends BEFORE run/write and is used only for existing
read-only GH-table parsing and rational arithmetic functions. Proposed rho
bounds are hypotheses of this numerical implication, not verified prime facts.
"""
from pathlib import Path
from fractions import Fraction as F
import os, re, json, math, hashlib

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
SRC = ROOT / 'work/ternary-goldbach'

L=F('160.54'); kap=F(607927101855,10**12); tiny=F('1e-9')
cuts=list(map(F,['.18','.216','.2592','.311','.3732','.4479','.5375','.645','.774','.9288']))
def tail(nu,b,C,K0=F('.0059')):
    eta=lambda l:nu/l+b/l**2
    j=sum((C/(c*L-tiny)*(kap*((d-c)*L+2*tiny)+F('.588')) for c,d in zip(cuts,cuts[1:])),F(0))
    j+=C/(cuts[-1]*L-tiny)*(kap*(L-(cuts[-1]*L-tiny))+F('1.166'))
    A=nu*F('1.013')+K0
    lhs=tiny+A/L**2+F(19925014134314,10**12)*eta(L-F('14.5089'))+nu*F('.36')/F('.82')+F('.36')*b*L/(F('.82')*L-F('.6933'))**2+j+C*eta(F('.82')*L-F('.6933'))/(F('.18')*L-tiny)
    return nu*(1-1/L)-lhs
assert F('13.8155')*F('.82')>F('.36')*F('.6933')
assert tail(F('.033'),F('.0395'),F('.00985'))>0
assert tail(F('.045'),F('.052'),F('.014'))>0
assert F('.045')*F('1.013')+F('.0059')<F('.052')
def final_m(nu,b,sf):
    q=F('1e-60')
    return (nu+b/L)*(1+q/L)+nu*(1+q)*L/(L-2)+(nu+b)*F('1.013')*(1+q)/L+sf*F('160.55')+F('1e-30')
assert final_m(F('.045'),F('.052'),F('.0000362'))<F('.10')
aff0=tail(F('.045'),F('.052'),F(0))
slope=aff0-tail(F('.045'),F('.052'),F(1))
result={'tail':{'P2_only_K':'13.8155','old_margin':str(tail(F('.033'),F('.0395'),F('.00985'))),
 'relaxed_margin':str(tail(F('.045'),F('.052'),F('.014'))),'relaxed_C5_cap_diagnostic':float(aff0/slope),
 'relaxed_m_upper_diagnostic':float(final_m(F('.045'),F('.052'),F('.0000362')))},'cell_trials':[]}

# Read/execute ONLY the audited generator prefix, which has no writes or run().
prefix=(SRC/'scripts/gen_schoenfeld_cells.py').read_text(encoding='utf-8').split('def run():')[0]
prefix=prefix.replace('open("TernaryGoldbach/Prelim/WeightsMain.lean")', 'open("TernaryGoldbach/Prelim/WeightsMain.lean", encoding="utf-8")')
oldcwd=Path.cwd()
try:
    os.chdir(SRC)
    g={}
    exec(compile(prefix,'gen_schoenfeld_cells.py:read-only-prefix','exec'),g)
finally:
    os.chdir(oldcwd)
records=[]
for p in (SRC/'TernaryGoldbach/Prelim').glob('SchoenfeldCells*.lean'):
    for m in re.finditer(r'def d(\d+) : CellD :=\s*\{(.*?)\}',p.read_text(encoding='utf-8'),re.S):
        fields={k:int(re.search(r'\b'+k+r' := (\d+)',m[2])[1]) for k in ['A','B','Y']}
        records.append((int(m[1]),fields))
records.sort()
assert len(records)==213
assert records[0][1]['A']==100000001
inputs=[SRC/'scripts/gen_schoenfeld_cells.py',SRC/'TernaryGoldbach/Prelim/WeightsMain.lean']+sorted((SRC/'TernaryGoldbach/Prelim').glob('SchoenfeldCells[0-9]*.lean'))
result['input_sha256']={str(p.relative_to(SRC)):hashlib.sha256(p.read_bytes()).hexdigest() for p in inputs}
for C in map(F,['.01','.005','.002']):
    cs=[]; I=F(0); S=F(11519); worst=F(0); first=None
    def points(A):
        pts=[10**9]; l=math.log(10**9); la=math.log(A)
        while l+max(1,.1*l)<la-1e-9:
            l+=max(1,.1*l); pts.append(int(math.exp(l)))
        if pts[-1]<A:pts.append(A)
        return [(v,g['lo_cert'](v),g['up_cert'](v)) for v in pts]
    def Xnew(cs,d):
        A,B,Y,sA=d['A'],d['B'],d['Y'],d['sA']
        extra=F(0)
        if B>10**9:
            # Cutoffs align at 1e9; split the one original crossing cell first.
            assert A>=10**9
            pts=points(A)
            for j,(v,l,u) in enumerate(pts):
                end=g['up_cert'](B-1) if j+1==len(pts) else pts[j+1][2]
                extra+=C/l*(kap*(end-l)+(F('1.166') if j+1==len(pts) else F('.588')))
        return F(1,A)+g['kVal'](cs,A,B,sA,1,d['ks'])+g['jVal'](B,Y+1,d['r1'],sA,2,d['u1'])+extra+g['bVal'](cs,A,B,Y,sA,d['r1'])
    g['Xq']=Xnew
    pieces=[]
    for _,rec in records:
        A,B,Y=rec['A'],rec['B'],rec['Y']
        if A<10**9<B:pieces.extend([(A,10**9,Y),(10**9,B,Y)])
        else:pieces.append((A,B,Y))
    for idx,(A,B,Y) in enumerate(pieces,1):
        d=g['make_cell'](cs,I,A,B,Y)
        assert g['chkCell'](cs,I,d), (C,idx,'structural/numeric cell conditions')
        ub=g['up_cert'](B)
        c=ub+S-d['eta']*(A-1)
        bound=(2*d['eta']+max(c/A,c/B))*ub
        worst=max(worst,bound)
        if bound>F('.10') and first is None:first={'cell':idx,'A':A,'bound':float(bound)}
        S+=d['eta']*(B-A); I=d['I2']; cs.append((B,d['eta']))
    trial={'C':str(C),'cells_checked':len(pieces),'max_profile_diagnostic':float(worst),'first_failure':first,'terminal_S_over_T_diagnostic':float(S/pieces[-1][1]),'terminal_I_log2_over_T_diagnostic':float(I*g['up_cert'](pieces[-1][1])**2/pieces[-1][1])}
    if C==F('.01'):
        TT=pieces[-1][1]; nu=F('.037'); b=F('.060'); K0=F('.022'); Sf=F('.000135')
        assert worst<F('.10')
        assert S<=Sf*TT
        assert (626+I)*F('160.55')**2<=K0*TT
        etaMax=g['etaMax'](10**8+1,cs,10**57,TT-1)
        assert etaMax<=nu/F('160.55')
        assert nu*F('1.013')+K0<b
        assert tail(nu,b,C,K0)>0
        assert final_m(nu,b,Sf)<F('.10')
        trial['combined_tail']={'nu':str(nu),'b':str(b),'K0':str(K0),'Sf_over_T':str(Sf),
            'etaMax_diagnostic':float(etaMax),'tail_margin':str(tail(nu,b,C,K0)),
            'profile_upper_diagnostic':float(final_m(nu,b,Sf)),'all_exact_assertions':True}
    result['cell_trials'].append(trial)
print(json.dumps(result,indent=2))
(HERE/'resume_mobius_input_20261111.json').write_text(json.dumps(result,indent=2)+'\n')
