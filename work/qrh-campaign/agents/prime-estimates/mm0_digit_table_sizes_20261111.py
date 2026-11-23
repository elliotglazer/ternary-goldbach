"""Exact symbolic sizes/event sensitivity; does not generate arithmetic tables/proofs."""
from pathlib import Path
import json
def ceildiv(a,b): return (a+b-1)//b
def S(n): return 5*n*n+2*n+1
def Q(n): return 10*n*n+10*n+5
def A(n): return 2*n+1
bs=[4,8,10,12,16]
widths=[90,718,1436,2871,5741]
tables=[]
for b in bs:
    beta=1<<b; sym=beta*(beta+1)//2
    k=ceildiv(b,4)
    E=A(ceildiv(b+1,4))+3*A(ceildiv(2*b+2,4))+5
    rows=[]
    for w in widths:
        n=ceildiv(w,b)
        rows.append(dict(bits=w,digits=n,digit_product_calls=n*n,
            square_distinct_digit_products=n*(n+1)//2,
            multiplication_template=S(n),modular_template=Q(n),
            symmetric_product_only_modular_template=Q(n)+2*n*n,
            symmetric_product_and_adder_modular_template=Q(n)+8*n*n+3*n,
            product_table_nibble_carry_template=2*(6*k+5)*n*n+4*n+6*n*k+5,
            square_table_nibble_carry_template=2*(E+6*k+4)*n*n+4*n+6*n*k+5))
    tables.append(dict(b=b,beta=beta,ordered_product_facts=beta*beta,
        symmetric_product_facts=sym,ordered_product_plus_two_adder_facts=3*beta*beta,
        symmetric_product_plus_two_adder_facts=3*sym,
        square_table_facts=2*beta-1,
        symmetric_product_header_bytes=8*sym,
        symmetric_product_bytes_sensitivity={str(k):k*sym for k in [32,64,128]},
        bootstrap_nibble_digits=ceildiv(b,4),
        bootstrap_multiplication_template=S(ceildiv(b,4)),
        square_identity_product_template=A(ceildiv(b+1,4))+3*A(ceildiv(2*b+2,4))+5,
        row_geometry=rows))
baseline=next(t for t in tables if t['b']==8)
breaks=[]
for t in tables:
    if t['b']<=8: continue
    delta_facts=t['ordered_product_plus_two_adder_facts']-baseline['ordered_product_plus_two_adder_facts']
    for row,old in zip(t['row_geometry'],baseline['row_geometry']):
        saved=old['modular_template']-row['modular_template']
        assert saved>0
        breaks.append(dict(b=t['b'],bits=row['bits'],extra_facts=delta_facts,saved_template_events=saved,
            amortization_modular_products={str(alpha):ceildiv(alpha*delta_facts,saved) for alpha in [10,100,1000]}))
out=dict(scope='proposed proof-template counts; not opcodes, runtimes or generated tables',
    table_models=tables,full_table_event_break_even=breaks)
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for t in tables: print(t['b'],t['ordered_product_facts'],t['symmetric_product_facts'],t['square_table_facts'],[r['modular_template'] for r in t['row_geometry']])
    for r in breaks:
        if r['bits']==90: print('alpha100 break-even',r['b'],r['amortization_modular_products']['100'])
