"""Integer size accounting only: no candidates, modular powers, roots or CRT runs."""
from math import prod
from pathlib import Path
import json

N=10**27
P=prod([2,3,5,7,11,13,17,19,23,29,31])
Fs=[m*P for m in [160,162,165,168,175,180]]
primes=[2,3,5,7,11,13,17,19,23,29,31]
def ceildiv(a,b): return (a+b-1)//b
def width(r): return (N**r).bit_length()
batch=[]
for q in [1,8,16,32,64]:
    levels=[]
    s=2
    while s<=q:
        w=width(s//2); z=width(s)
        levels.append(dict(factors_per_node=s,nodes=q//s,child_bits=w,
            product_bits=z,raw_two_child_product_bits=2*w,
            signed_root_difference_bits=w+1,
            inverse_modulus_bits=w,crt_modmul_raw_bits=2*w,
            crt_lift_mul_raw_bits=2*w,
            remainder_parent_bits=z,remainder_divisor_bits=w))
        s*=2
    batch.append(dict(q=q,product_bits=width(q),product_bytes=ceildiv(width(q),8),
        root_bytes=ceildiv(width(q),8),smooth_inverse_bytes=ceildiv(width(q),8),
        product_tree_multiplications=q-1,crt_inverses=q-1,
        crt_per_coordinate_mod_products=q-1,crt_per_coordinate_lift_products=q-1,
        optional_remainder_tree_divisions=2*(q-1),levels=levels,
        proth_checker_squares=44,
        smooth_checker_squares=128,smooth_checker_other_products_min=56,
        smooth_checker_other_products_max=60))
    batch[-1]['all_product_tree_value_bits']=q*width(1)+sum(l['nodes']*l['product_bits'] for l in levels)
    batch[-1]['all_crt_inverse_value_bits']=sum(l['nodes']*l['inverse_modulus_bits'] for l in levels)
    batch[-1]['checker_square_raw_bits']=2*width(q)
rows=[]
for B in [10**15,2*10**15,5*10**15,10**16,2*10**16]:
    S=B//2; D=S-2; K=N//S
    assert K*S==N
    wp=(ceildiv(D,2**45)-1).bit_length()
    ws=(max(ceildiv(D,f) for f in Fs)-1).bit_length()
    sizes=[]
    for r in batch:
        q=r['q']; assert K%q==0
        groups=K//q
        ppos=ceildiv(K*wp,8); spos=ceildiv(K*ws,8); tags=ceildiv(3*K,8)
        roots=groups*r['root_bytes']
        sizes.append(dict(q=q,full_batches=groups,
            proth_positions_bytes=ppos,smooth_positions_bytes=spos,
            smooth_lane_tags_bytes=tags,roots_bytes=roots,
            smooth_inverses_bytes=roots,
            proth_root_total_bytes=ppos+roots,
            smooth_root_total_bytes=spos+tags+2*roots,
            factor_specific_total_bytes=spos+tags+12*roots,
            compact_one_base_bytes=ppos,
            compact_six_base_bytes=ppos+tags,
            historical_11bit_offsets_same_K_bytes=ceildiv(11*K,8)))
    rows.append(dict(B=B,K=K,D=D,proth_offset_bits=wp,smooth_offset_bits=ws,batches=sizes))
out=dict(scope='raw field capacities at maximum candidate size; no timings or successful data',
    N=N,batch_geometry=batch,campaign_geometry=rows)
factor_rows=[]
for F in Fs:
    rem=F; sq=0; mul=0; exps=[]
    for p in primes:
        e=0
        while rem%p==0: rem//=p; e+=1
        first=p**(e-1)
        sq+=first.bit_length()-1; mul+=first.bit_count()-1
        if p!=2: sq+=p.bit_length()-1; mul+=p.bit_count()-1
        exps.append(dict(prime=p,e=e,first_power=first,final_power=None if p==2 else p))
    assert rem==1
    factor_rows.append(dict(F=F,squares=sq,other_power_products=mul,
        unit_products=10,total_modular_products=sq+mul+10,exponents=exps))
out['factor_specific_schedules']=factor_rows
if __name__=='__main__':
    Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
    for r in batch: print('batch',r['q'],r['product_bits'],r['root_bytes'])
    for r in rows:
        t=next(t for t in r['batches'] if t['q']==32)
        print('B',r['B'],'offsetbits',r['proth_offset_bits'],r['smooth_offset_bits'],
              'q32 bytes',t['proth_root_total_bytes'],t['smooth_root_total_bytes'],t['compact_one_base_bytes'])
    for r in factor_rows: print('factor roots',r['F'],r['squares'],r['other_power_products'],r['total_modular_products'])
