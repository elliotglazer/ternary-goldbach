"""One fixed reuse test of 22 source rows. Rational certificates only."""
from pathlib import Path
from fractions import Fraction as Q
import ast, re, json, hashlib
ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/ternary-goldbach/TernaryGoldbach'
path=BASE/'Explicit/PsiRanges1e8.lean'
src=path.read_text(encoding='utf-8')
def arithmetic(s):
    s=s.replace(': ℝ','').replace(': ℚ','').strip()
    t=ast.parse(s,mode='eval')
    def go(n):
        if isinstance(n,ast.Constant) and type(n.value) in (int,float):
            return Q(ast.get_source_segment(s,n))
        if isinstance(n,ast.UnaryOp) and isinstance(n.op,ast.USub):return -go(n.operand)
        if isinstance(n,ast.BinOp):
            a,b=go(n.left),go(n.right)
            if isinstance(n.op,ast.Add):return a+b
            if isinstance(n.op,ast.Sub):return a-b
            if isinstance(n.op,ast.Mult):return a*b
            if isinstance(n.op,ast.Div):return a/b
        raise ValueError(ast.dump(n))
    return go(t.body)
def arg(block,key):
    matches=list(re.finditer(r'\('+re.escape(key)+r'\s*:=\s*',block))
    assert len(matches)==1,(key,len(matches))
    begin=matches[0].end(); pos=begin; level=1
    while level:
        if block[pos]=='(':level+=1
        if block[pos]==')':level-=1
        pos+=1
    return arithmetic(block[begin:pos-1])
def negexp_upper(x):
    y=min(Q(60),x)
    term=total=Q(1)
    for n in range(1,129):
        term*=y/n; total+=term
    return 1/total
def bounds(r,tau,mu):
    d,K,X,XX=r['δ'],r['K'],r['X'],r["X'"]
    E1,E8,Eh,q=r['E1'],r['E8'],r['Eh'],r['q']
    L=E8*(Eh+r['sY'])*(Q('.16385')*r['LU']**2-Q('.4271')*r['LU']+Q('7.2032')+Q('57.73')*d+mu)
    up=(E1/(1-q)-1)*r["rX'"]+L/(1-q)+tau*r["rX'"]/(1-q)+4*r['y0']*E1/r['rX']+Q('253.3')*E8/d/(1-q)*(1/X+r['sYX'])
    lo=(K*d+2*q)*r["rX'"]+2*r['y0']/r['rX']+L+tau*r["rX'"]+Q('253.3')*E8/d*(Eh/X+r['sYX'])
    return up,lo
def enc(x):return {'numerator':str(x.numerator),'denominator':str(x.denominator)}
def display(x):
    v=x*10**6
    return {'lo':str(v.numerator//v.denominator)+'/1000000',
            'hi':str(-(-v.numerator//v.denominator))+'/1000000'}
checks={}
def ck(name,v):assert v,name;checks[name]=True
starts=list(re.finditer(r'^theorem psi_range8_(\d+)\b',src,re.M))
ck('all_22_ordered_rows',[int(m[1]) for m in starts]==list(range(22)))
H=Q(88_000_000); Y=H/2-13
out=[]
keys=['δ','K','y0','X',"X'",'c','LU','E1','E8','Eh','q','sY','sYX','rX',"rX'",'H','Y₁','τ','μ']
for i,m in enumerate(starts):
    end=starts[i+1].start() if i+1<len(starts) else src.index('noncomputable def cW8',m.start())
    whole=src[m.start():end]
    block=whole[whole.index('have hup :='):whole.index('have hlo :=')]
    r={k:arg(block,k) for k in keys}
    ck(f'{i}_old_fixed_heights',r['H']==10**8 and r['Y₁']==49_000_000)
    ou,ol=bounds(r,r['τ'],r['μ'])
    ck(f'{i}_old_upper',ou<=r['c'])
    ck(f'{i}_old_lower',ol<=r['c'])
    ck(f'{i}_new_window_domain',Y>=Q(1,2) and Y+13<=H/2 and Q(3)/Y<=r['δ']<=Q(1,208))
    ck(f'{i}_q_range',0<=r['q']<1)
    ck(f'{i}_K_delta',r['δ']<=r['K'] and r['K']*r['δ']<=1)
    ck(f'{i}_cutoff',0<r['y0'] and r['y0']*r['E1']<=r['X'])
    ck(f'{i}_root_witnesses',r['rX']>0 and r['rX']**2<=r['X'] and r["rX'"]**2>=r["X'"] and r['sY']**2>=r['y0']/r['X'] and r['sYX']**2*r['y0']*r['X']>=1)
    d=r['δ']; t=Q('4.4')*d*d*H; rho=t/(1+t)
    factor=2*Q('2.7184')/H*(Q('421.2')/rho+Q('73.2')/H/rho**2)
    tau=factor*negexp_upper(d*d*H*H/2)
    mu=1142*negexp_upper(d*d*Y*Y/2)
    nu,nl=bounds(r,tau,mu)
    out.append({'index':i,'source_line':src[:m.start()].count('\n')+1,
        'inputs':{k:enc(v) for k,v in r.items()},'new_tau':enc(tau),'new_mu':enc(mu),
        'old_upper':enc(ou),'old_lower':enc(ol),'new_upper':enc(nu),'new_lower':enc(nl),
        'new_upper_display':display(nu),'new_lower_display':display(nl),
        'upper_pass':nu<=r['c'],'lower_pass':nl<=r['c'],
        'upper_margin':enc(r['c']-nu),'lower_margin':enc(r['c']-nl)})
ck('closed_interval_cover',out[0]['inputs']['X']==enc(Q(10**6)) and out[-1]['inputs']["X'"]==enc(Q(10**17)) and all(out[i]['inputs']["X'"]==out[i+1]['inputs']['X'] for i in range(21)))
names=['Explicit/PsiRanges1e8','Explicit/PsiRange','Explicit/PsiWeil','Explicit/WeilNumC','Explicit/WeilNumB','Explicit/WeilLineSum','Explicit/WeilWeights','Explicit/WeilWindow','Explicit/PsiPlateau','Explicit/ZetaZeroSums','Explicit/ZeroSumGen','Prelim/PsiTwoSided']
pins={str((BASE/(n+'.lean')).relative_to(ROOT)).replace('\\','/'):hashlib.sha256((BASE/(n+'.lean')).read_bytes()).hexdigest().upper() for n in names}
result={'scope':'fixed old rows, new H/Y1, degree128 negative-exp rational witnesses; no optimization or analytic values',
 'H':enc(H),'Y1':enc(Y),'checks':checks,'rows':out,'pins':pins}
p=Path(__file__).with_suffix('.json')
with p.open('x',encoding='utf-8') as f:json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'checks':len(checks),'passing':[r['index'] for r in out if r['upper_pass'] and r['lower_pass']],
                 'failed':[{'i':r['index'],'up':r['new_upper_display'],'lo':r['new_lower_display']} for r in out if not(r['upper_pass'] and r['lower_pass'])]}))
