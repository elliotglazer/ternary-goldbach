"""Deterministic, untrusted stage data and matched scalar/batch proof sources.

The Lean theorem concerns the supplied exact dyadic coefficients. Decimal trig
only chooses representative coefficients: it is NOT a root enclosure proof.
"""
from pathlib import Path
from decimal import Decimal, localcontext
import hashlib, json, sys, time

HERE = Path(__file__).resolve().parent

def atan(x):
    total = term = x
    n = 1
    while True:
        term *= -x*x
        new = total + term / (2*n+1)
        if new == total:
            return total
        total = new
        n += 1

def trig(x, cosine):
    term = Decimal(1) if cosine else x
    total = term
    k = 0 if cosine else 1
    while True:
        term *= -x*x / ((k+1)*(k+2))
        new = total+term
        if new == total:
            return total
        total = new
        k += 2

def integer(seed, cap):
    return int.from_bytes(hashlib.shake_256(seed.encode()).digest(128), 'little') % (2*cap+1)-cap

def lit(v):
    return '('+str(v)+')' if v < 0 else str(v)

def generate(p, n):
    start = time.perf_counter()
    s = 1 << p
    b = 1024*s
    rows = []
    with localcontext() as ctx:
        ctx.prec = 180
        pi = 16*atan(Decimal(1)/5)-4*atan(Decimal(1)/239)
        for k in range(n):
            angle = -pi*k/n
            c = int((trig(angle, True)*s).to_integral_value())
            d = int((trig(angle, False)*s).to_integral_value())
            # The first root is exact, avoiding a decimal zero artifact.
            if k == 0:
                c,d = s,0
            if 2*k == n:
                c,d = 0,-s
            ur,ui,a,z = [integer(f'{p}:{n}:{k}:{j}', b) for j in range(4)]
            rr,ii = a*c-z*d,a*d+z*c
            qr,qi = (rr+s//2)//s,(ii+s//2)//s
            output = [ur+qr,ui+qi,ur-qr,ui-qi]
            assert all(-4*b <= v <= 4*b for v in output)
            assert -s <= 2*(rr-qr*s) < s and -s <= 2*(ii-qi*s) < s
            rows.append(dict(input=[ur,ui,a,z,c,d], output=output))
    name = f'P{p}N{n}'
    data = ['import StageCheck', 'open BatchedTransform', f'namespace Data{name}',
            f'def scale : Int := {s}', f'def bound : Int := {b}']
    for k,row in enumerate(rows):
        data += [f'def x{k} : Input := ⟨'+', '.join(map(lit,row['input']))+'⟩',
                 f'def y{k} : Output := ⟨'+', '.join(map(lit,row['output']))+'⟩']
    data += ['def inputs : List Input := ['+', '.join(f'x{k}' for k in range(n))+']',
             'def outputs : List Output := ['+', '.join(f'y{k}' for k in range(n))+']',
             f'end Data{name}']
    (HERE/f'Data{name}.lean').write_text('\n'.join(data)+'\n',encoding='utf-8')
    for variant in ['Scalar','Batch']:
        header = [f'import Data{name}', 'open BatchedTransform', f'open Data{name}',f'namespace {variant}{name}']
        proof = []
        names = []
        if variant == 'Scalar':
            for k in range(n):
                proof += [f'theorem row_{k} : checkOne scale bound x{k} y{k} = true := by decide +kernel']
                names.append(f'{variant}{name}.row_{k}')
            term = 'rfl'
            for k in reversed(range(n)):
                term = f'(checkStage_cons scale bound x{k} y{k} _ _ row_{k} {term})'
            proof += [f'theorem checked : checkStage scale bound inputs outputs = true := {term}']
        else:
            proof += ['theorem checked : checkStage scale bound inputs outputs = true := by decide +kernel']
        proof += ['theorem certified : stage_spec scale bound inputs outputs :=',
                  '  checkStage_sound scale bound inputs outputs checked']
        names += [f'{variant}{name}.checked', f'{variant}{name}.certified']
        (HERE/f'{variant}{name}.lean').write_text('\n'.join(header+proof+[f'end {variant}{name}'])+'\n',encoding='utf-8')
        replay = [f'import {variant}{name}', 'import Replay',
                  '#replay_stage '+json.dumps(variant)+' '+str(p)+' '+str(n)+' 10 '+
                  '['+', '.join(names)+']']
        (HERE/f'Replay{variant}{name}.lean').write_text('\n'.join(replay)+'\n',encoding='utf-8')
    receipt = dict(precision=p,butterflies=n,complex_outputs=2*n,
                   input_coordinate_bound='1024',output_coordinate_bound='4096',
                   rounding_error_per_output_coordinate=f'1/2^{p+1}',
                   certified_object='exact dyadic weighted butterfly stage',
                   root_of_unity_identification_certified=False,
                   generator_seconds=time.perf_counter()-start,rows=rows)
    (HERE/f'{name}.json').write_text(json.dumps(receipt,indent=2)+'\n')
    print(name, 'generated',round(receipt['generator_seconds'],3),'seconds')

if __name__ == '__main__':
    generate(int(sys.argv[1]),int(sys.argv[2]))
