"""Independent rational reconstruction; no producer imports or analytic values."""
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[3]
AUTHOR = ROOT / 'work/qrh-campaign/agents/major-constants'
def sha(p):
    return hashlib.sha256(p.read_bytes()).hexdigest().upper()

saved = json.loads((AUTHOR/'plus_star_budget_reallocation_20261111.json').read_text())
tests = {}
def ck(k, v):
    assert v, k
    tests[k] = True

ck('author note pin', sha(AUTHOR/'PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md') == '7A5B81DA0290BE52D8E64A521702D0299114FF9DE2923E1897AE608E5241ECAD')
for path, expected in saved['input_sha256'].items():
    ck('input '+path, sha(ROOT/path) == expected)
ck('nine inputs', len(saved['input_sha256']) == 9)
ck('independent coefficient review', sha(ROOT/'work/qrh-campaign/agents/prime-estimates/REVIEW_ETA_U_PRIME_COEFFICIENT_ENERGY_2026-11-11.md') == '91057A3117C6E469E633F532206E783FBC4BCAC1620384E09756AB4E3C7AB6E4')
ck('corrected B predecessor', sha(HERE/'DIRECT_STAR_B_SOURCE_OBSTRUCTION_V2_2026-11-11.md') == '65B892756EA24A086C673082D3CA551AF99EECA5DDA63CB3523EE3F5514A88A9')

r = Q(512,10**9)
p = Q(283,10**9)
ep = Q(425,10**9)**2
rem = Q(516,10**15)
ck('orthogonal plus energy', ep == Q('1.80625e-13') and r > rem and (r-rem)**2 > ep+p*p)
ck('totient radius', 265800 < 516**2)
j = Q(879,100)
a = Q(640208,10**6)*Q(1359756,10**5)
v = Q(778,100)*Q(285,100)
C = 49*(j+a)/9+9*v/2
ck('positive AMGM envelope', C > 0 and C*C-98*v*(j+a) == (49*(j+a)/9-9*v/2)**2)
old = j*Q(367,10**8)+Q(885,10**9)*C
u = Q(1194,10**8)
cap = (old-r*C)/j
reserve = old-j*u-r*C
ck('strict old allowance and grid maximality', reserve > 0 and u < cap < u+Q(1,10**8))
ck('integrated plus', 16*150000*19*r*r < Q(6,1000)**2)
ck('total moment', a < Q(2951,1000)**2 and Q(2957,1000)**2 < j)
ck('weighted principal', Q(640208,10**6)*Q(32,13) < Q(1256,1000)**2)
pbar = Q(1902,10**9)
ck('integrated principal and total norm', Q(1502,10**9)*Q(1262,1000)+Q(2,10**9)*3 < pbar and j < 9)
ell = Q(2964,1000)
ck('lower root witness', ell*ell < j)
rows=[]
for t,b in [(0,4200),(1,4000),(2,3750),(3,3500),(10,2000),(20,650)]:
    root=Q(t,10**6)
    margin=ell*u-pbar-root
    ck('positive frontier '+str(b), margin>0)
    ck('frontier squared '+str(b), margin*margin>r*r*b)
    rows.append({'A':str(root*root),'B':b,'squared_reserve':str(margin*margin-r*r*b)})
ck('all saved rows', rows == saved['rows'])

ck('uniform log lower', 3**50 < 10**25)
# Independently build the first six coefficients of exp(1).
term=Q(1); partial=term
for k in range(1,6):
    term /= k
    partial += term
ck('uniform log upper', partial > Q(27,10) and Q(27,10)**13 > 2*132900)
ct = 30*Q(1254,1000)*(Q(1000468,10**6)+Q(502756,10**6)/50)+Q(3,5)*Q(2,10**60)
ck('coefficient sieve upper', ct<39<Q(25,4)**2)
ck('small energy root', Q(21,10**10)<Q(46,10**6)**2)
broot=7*(Q(25,4)+Q(46,10**6))+Q(10632,10**7)
ck('uniform B budget', broot*broot<1915<2000)
ck('sieve domains', 132900 >= 10**5 and 16*(20000*132900)**2 < 49*10**25 and (2*132900)**10 < Q(49*10**25,4)**3)
recomputed={'rho':r,'C':C,'old_error':old,'u_max_linear':cap,'selected_u':u,'cubic_reserve':reserve,'conditional_sieve_product_upper':ct,'conditional_B_upper':broot*broot}
for k,value in recomputed.items():
    ck('saved scalar '+k, str(value)==saved[k])
ck('reported boolean count only', len(saved['checks'])==34 and all(v is True for v in saved['checks'].values()))
paths=[AUTHOR/'PLUS_STAR_CUBIC_BUDGET_REALLOCATION_2026-11-11.md',AUTHOR/'plus_star_budget_reallocation_20261111.py',AUTHOR/'plus_star_budget_reallocation_20261111.json']
out={'scope':'independent exact scalar reconstruction and saved pins only; no analytic evaluation', 'checks':tests,'check_count':len(tests),'recomputed':{k:str(v) for k,v in recomputed.items()},'rows':rows,'author_sha256':{str(p.relative_to(ROOT)):sha(p) for p in paths},'input_sha256':saved['input_sha256']}
dest=HERE/'review_plus_star_reallocation_20261111.json'
with dest.open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2);f.write('\n')
print(f'{len(tests)} independent exact checks PASS; {sha(dest)}')
