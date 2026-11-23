"""Independent bottom-up arithmetic-template audit, no operand evaluations."""
from pathlib import Path
import hashlib
import json

ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-campaign/agents/prime-estimates'
PINS={
 'EFFICIENCY_COMPLEX_KARATSUBA_2026-11-11.md':'86D8A9435A9962CFF95194642E590D65C76B334E5AD24377959006E7AB17BEFF',
 'complex_karatsuba_sizes_20261111.py':'3F9B491D6750A5CF178C65B5A25AA8FDD938B52D12189512B59DCE4C098CF213',
 'complex_karatsuba_sizes_20261111.json':'30A7BDD7FC7AE93533329A8F4AB5253F692948F4E1F5E41D3C6EEDB75B334AC8',
 'EFFICIENCY_COMPLEX_THREE_PRODUCT_2026-11-11.md':'83D8C2953A4AEE557786904C09CED8433972876AA0B6698EBA8BF2C3B5F39EF4',
 'ERRATUM_COMPLEX_ADD_WIDTHS_2026-11-11.md':'AD8DC7692F68A44BF0D10BB6E348DD0D8A3368FF76FC5A94BBF07BFD76030362',
 'EFFICIENCY_MM0_SQUARE_KARATSUBA_2026-11-11.md':'4ADB3C676ABA3A82128A8F27CBB91221B414689F94CDC5D60BA0FA75A8421FFA',
}
for name,digest in PINS.items():
    assert hashlib.sha256((BASE/name).read_bytes()).hexdigest().upper()==digest
data=json.loads((BASE/'complex_karatsuba_sizes_20261111.json').read_text())

def ceildiv(n,d): return -(-n//d)
def add(n): return 2*n+1
def school(a,b): return 5*a*b+2*min(a,b)+1
def overhead(n):
    h=ceildiv(n,2)
    return 2*add(h+1)+2*add(2*h+2)+2*add(2*n)+3
general={}
for n in range(1,260):
    general[n]=school(n,n)
    if n>=4:
        h=ceildiv(n,2)
        assert h+1<n
        general[n]=min(general[n],general[h]+general[n-h]+general[h+1]+overhead(n))

rect={}
for a in range(1,260):
    for b in range(1,a+1):
        choices={'schoolbook':school(a,b),'pad':general[a],
                 'chunks':ceildiv(a,b)*(general[b]+add(2*b))}
        h=ceildiv(a,2)
        if a>=4 and b>h:
            choices['unequal_split']=rect[h,h][0]+rect[a-h,b-h][0]+rect[h+1,h+1][0]+overhead(a)
        selected=min(choices,key=choices.get)
        rect[a,b]=[choices[selected],selected,choices]
def R(a,b): return rect[max(a,b),min(a,b)]

assert len(data['rows'])==25
assert {(r['radix_bits'],r['p']) for r in data['rows']}=={(b,p) for b in [4,8,10,12,16] for p in [128,192,256,512,1024]}
schemes=0; used_chunks=[]; byte=[]
for row in data['rows']:
    b,p=row['radix_bits'],row['p']
    n=ceildiv(p,b); ng=ceildiv(p+1,b)
    o4=ceildiv(2*p+1,b); of=ceildiv(2*p+2,b); og=ceildiv(2*p+3,b)
    assert [row[k] for k in ['n','grown_n','output_n_four','output_n_fixed','output_n_gauss']]==[n,ng,o4,of,og]
    for label,args in [('equal_product',(n,n)),('unequal_product',(n,ng)),('grown_product',(ng,ng))]:
        assert row[label]==R(*args)
        if R(*args)[1]=='chunks': used_chunks.append([b,p,label])
    for name,saved in row['schedules'].items():
        multiply=(school if name=='schoolbook' else (lambda a,b:general[max(a,b)]) if name=='padded' else (lambda a,b:R(a,b)[0]))
        fp=4*multiply(n,n); xp=3*multiply(n,ng); gp=2*multiply(n,n)+multiply(ng,ng)
        four=fp+2*add(o4); fixed=xp+add(ng)+2*add(of); gauss=gp+2*add(ng)+add(o4)+2*add(og)
        setup=2*add(ng); delta=four-fixed; dg=gauss-fixed
        check=dict(four_products=fp,fixed_products=xp,gauss_products=gp,four=four,fixed_runtime=fixed,gauss=gauss,
                   fixed_setup=setup,fixed_once=fixed+setup,fixed_saved_per_use=delta,
                   strict_break_even_uses=setup//delta+1 if delta>0 else None,
                   fixed_saved_vs_gauss_per_use=dg,strict_break_even_vs_gauss=setup//dg+1 if dg>0 else None)
        assert all(saved[k]==v for k,v in check.items())
        assert fixed+setup<four and gauss<four
        schemes+=1
    if b==8:
        s=row['schedules']['rectangular']
        byte.append([p,s['four'],s['fixed_runtime'],s['fixed_once'],s['gauss'],row['unequal_product'][1]])
assert not used_chunks
sanity=0
for n in range(1,260):
    for m in [n,max(1,n-1)]:
        assert R(n,m)[0]<=school(n,m) and R(n,m)[0]<=general[n]
        sanity+=1
assert sanity==data['recurrence_sanity_checks']==518

# Reconstruct which recursive descendants each displayed selected product actually uses.
def descendants(a,b):
    a,b=max(a,b),min(a,b)
    if R(a,b)[1]=='chunks': return [(a,b)]
    if R(a,b)[1]!='unequal_split': return []
    h=ceildiv(a,2)
    return descendants(h,h)+descendants(a-h,b-h)+descendants(h+1,h+1)
assert all(not descendants(a,b) for row in data['rows'] for a,b in [(row['n'],row['n']),(row['n'],row['grown_n']),(row['grown_n'],row['grown_n'])])
out=dict(status='PASS_INTEGER_SUBTOTAL_REPLAY',scope='Unsigned skeleton only; chunk proof-bridge costs excluded and not used by displayed paths',
         pins=PINS,rows=25,schedules=schemes,sanity_checks=sanity,displayed_or_descendant_chunk_choices=used_chunks,byte_rows=byte)
with Path(__file__).with_suffix('.json').open('x',encoding='utf-8',newline='\n') as f:
    json.dump(out,f,indent=2); f.write('\n')
print('PASS: 25 rows, 75 schedules, 518 inequalities; no selected or descendant chunk branch in displayed paths.')
