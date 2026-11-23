"""Independent saved-bound composition only; no analytic bounds regenerated."""
from fractions import Fraction as F
from pathlib import Path
from math import isqrt
import json,re,hashlib
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
A=HERE.parent
SRC=ROOT/'work/ternary-goldbach/TernaryGoldbach'
pins={
 A/'prime-estimates/EXACT_SOURCE_MASS_CUTOFF_2026-11-11.md':'429562CD92AF356BD84EED1C253D0A9E95D434262DF08CCCAC8EAF3D15CE234D',
 A/'prime-estimates/source_mass_joint_cutoff_20261111.py':'F243DD01285D8FA78F72A38AFFF1F2842436D4110F1E7B616B2111DB6712488A',
 A/'prime-estimates/source_mass_joint_cutoff_20261111.json':'67F6C3BAE93EDE7BD93C49A4EC8B442671A921D9E71B5AEC4925031261984FC9',
 SRC/'Prelim/SmallMuPhi.lean':'7ECE1D48D9679ECF529A5566C79D06FADB3CA70CCAF057ADAA020D6AA390BADF',
 SRC/'MajorArcs/SumMuPhi.lean':'7AC4662598355DDA40720B43956223BD3C5456D503B206A77D48E4569ADE18A4',
 A/'integration/EXACT_MASS_TAIL_SOURCE_JOIN_2026-11-11.md':'7BCBA7142E2B069ABEFB3F1FD6490DE00F3BFCEC0E4D6FAC1140DB88F048DE8E'}
for p,h in pins.items():assert hashlib.sha256(p.read_bytes()).hexdigest().upper()==h
d=json.loads((A/'prime-estimates/source_mass_joint_cutoff_20261111.json').read_text(encoding='utf-8'))
f=lambda x:F(int(x['num']),int(x['den']))
checkpoints=dict((int(k),int(v)) for k,v in re.findall(r'^theorem c_\d+ : Lt (\d+) = (\d+) :=', (SRC/'Prelim/SmallMuPhi.lean').read_text(encoding='utf-8'),re.M))
assert checkpoints[132000]==6734875660393277758
assert d['checkpoints_used']=={str(k):str(checkpoints[k]) for k in [132000,133000,134000,135000]}
text=(SRC/'MinorArcs/NumericsCells.lean').read_text(encoding='utf-8')
assert hashlib.sha256((SRC/'MinorArcs/NumericsCells.lean').read_bytes()).hexdigest().upper()==d['source_cells_sha256']
expected_Y=[10**25,3*10**25,10**26,10**27,10**28,10**30,10**34,10**42,10**58]
parsed=[]
for i in range(9):
    start=text.index('theorem cell'+str(i)+' ')
    end=text.find('\ntheorem ',start+1)
    block=text[start:len(text) if end<0 else end]
    ys=re.findall(r'cell_bound \(Y := ([0-9.e]+)\)',block)
    assert len(ys)==1 and F(ys[0])==expected_Y[i]
    vals=re.findall(r'\(fun i => \(\[([^]]+)\] : List ℝ\)',block)
    assert len(vals)==2
    gs,logs=([F(v.strip()) for v in part.split(',')] for part in vals)
    assert len(gs)==len(logs)
    param=lambda name:F(re.search(r'\('+re.escape(name)+r' := ([0-9.]+)\)',block)[1])
    item=(param('cl0'),param("sD'"),sum((g*l for g,l in zip(gs,logs)),F(0)),param('Gt')*param("τ'"))
    s=d['parsed_cells'][i]
    assert item==(f(s['cl']),f(s['sd']),f(s['chain']),f(s['tail'])) and s['Y']==expected_Y[i]
    parsed.append(item)
base=(HERE/'original_rh_joint_cutoff_20261111.py').read_text(encoding='utf-8')
author=(A/'prime-estimates/source_mass_joint_cutoff_20261111.py').read_text(encoding='utf-8')
base_region=base.split('def unitlog',1)[1].split('\ncoarse=[]\n')[0].strip()
author_region=author.split('def unitlog',1)[1].split('# Scalar engine above')[0].strip()
assert author_region==base_region.replace("mass=F('13.597558')-F(15015,5760)*hi(logb(F(150000,R))[1])",'mass=F(2*checkpoint_Lt[(R//1000)*1000],10**18)')
E=(F('3.67e-6')+F(49,9)*F('8.85e-7'))*F('8.79')+(F(9,2)*F('8.85e-7')*F('7.78')+49*F('2.03e-5'))*F('2.85')+F(49,9)*F('8.85e-7')*F('.640208')*F('13.59756')
np=49*F('2.02')**2*6700000*27*F('2.303')/isqrt(989*10**24)
assert np==F(20618162523,7784250095800)==f(d['nonprime_allowance']) and E==f(d['major_error'])
results=[]
assert [row['R'] for row in d['rows']]==[135000,134000,133000,132000,132900]
for row in d['rows']:
    R=row['R'];assert R%2==0 and 100000<=R<=150000
    mass=F(checkpoints[R//1000*1000],5*10**17)
    jf=F('.638108')*mass-F('.00108')
    j=(jf-F(100001)*F('8e-11'))/F('1.00001')
    sing=2*(F('.6606')*F(198,199)-F('22.1')/R)
    maj=F('.800689')*sing-E
    gap=F('1.016')*49**2*F('5.53')/(8*R)+548*(F('1.4874e-6')+F('2e-9'))+F('2e-9')
    for name,val in [('mass_lower',mass),('J_lower',jf),('I_lower',j),('singular_lower',sing),('major_lower',maj),('basegap_upper',gap)]:assert f(row[name])==val
    minors=[]
    for i,(cl,sd,chain,tail) in enumerate(parsed):
        c=row['cells'][i];assert c['cell']==i and c['Y']==expected_Y[i]
        G=f(c['G']);assert G>=0 and G.denominator<=10**7
        U=G*(cl*sd-j)+sd*chain+tail
        minor=F('1.0005')*U+F(2001)*F('22.75')*F('8e-11')
        assert f(c['Mexpr_upper'])==U and f(c['minor_upper'])==minor and f(c['margin'])==maj-minor-np
        minors.append(minor)
    U=f(row['cells'][8]['G'])*(F('14.61155')*F('1.2947')-j)+F('1.2947')*(F('.165282706731081808')+F('.00084')+F('1.398e-10'))+F('.00022')
    ma=F('1.0005')*U+2001*F('22.75')*F('8e-11')
    assert f(row['asymptotic_minor'])==ma and f(row['asymptotic_margin'])==maj-ma-np
    margin=maj-max(minors+[ma])-np
    assert f(row['joint_margin'])==margin and f(row['minor_target_reserve'])==F('1.0376')-max(minors+[ma])
    assert f(row['major_target_reserve'])==maj-F('1.049')
    checks=dict(positive_major=maj>0,joint_finite=all(m<maj-np for m in minors),joint_asymptotic=ma<maj-np,basegap=gap<F('.014'),positive_mass=mass>0,positive_J=jf>0,positive_I=j>0,positive_singular=sing>0,base_coefficients=all(cl*sd>j for cl,sd,_,_ in parsed),asymptotic_base=F('14.61155')*F('1.2947')>j)
    assert checks==row['checks'] and row['passes']==all(checks.values())
    assert max(minors+[ma])==minors[0]
    results.append(dict(R=R,passes=row['passes'],margin_num=str(margin.numerator),margin_den=str(margin.denominator)))
assert results[-1]['passes'] and not results[-2]['passes']
last=f(d['rows'][-1]['joint_margin'])
assert F('.0013565')<last<F('.0013566')
assert last==F(17454234627055702473150105611895106422794893597,12867056213564954145112500000000000000000000000000)
assert F(2*checkpoints[132000],10**18)==F(3367437830196638879,250000000000000000)
assert 8550*193==1650150 and F(8550,2**64)<F(1,2**50)
out=dict(status='PASS_SAVED_RATIONAL_BOUND_COMPOSITION',pins={str(p.relative_to(ROOT)).replace('\\','/'):h for p,h in pins.items()},source_cells=9,finite_compositions=45,asymptotic_compositions=5,guard_comparisons=50,results=results,scope='Saved G bounds used unchanged; source recipe identity checked, no analytic-value regeneration, factor evaluation, or Lean build.')
dest=Path(__file__).with_suffix('.json')
with dest.open('x',encoding='utf-8',newline='\n') as file:json.dump(out,file,indent=2);file.write('\n')
print(json.dumps({k:v for k,v in out.items() if k!='pins'},indent=2))
print('SHA256',hashlib.sha256(dest.read_bytes()).hexdigest().upper())
