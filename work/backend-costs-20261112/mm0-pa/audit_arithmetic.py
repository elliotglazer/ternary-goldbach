"""Structural/provenance audit, separate from mm0-c's logical verification."""
import argparse
import hashlib
import json
import re
import struct
from pathlib import Path
from generate_arithmetic import BASE, FIXTURE, PA

def command(data, p):
    first = data[p]
    size = (0, 1, 2, 4)[first >> 6]
    end = p + 1 + size
    return first & 63, int.from_bytes(data[p+1:end], 'little'), end

def inspect_mmb(path):
    data = path.read_bytes()
    magic, version, ns, _, nt, nh, pt, ph, pp, _, pi = struct.unpack_from('<4sBBHIIIIIIQ', data)
    assert magic == b'MM0B' and version == 1
    names = {}
    for i in range(struct.unpack_from('<Q', data, pi)[0]):
        ident, _, at = struct.unpack_from('<4sIQ', data, pi+8+16*i)
        if ident == b'Name':
            for j in range(ns+nt+nh):
                proof, name = struct.unpack_from('<QQ', data, at+16*j)
                names[proof] = data[name:data.index(0, name)].decode()
    statements = []
    p = pp
    while True:
        start = p
        op, length, body = command(data, p)
        if op == 0:
            break
        assert op in (2,4,5,6,13,14) and length >= body-start
        p = start+length
        assert p <= len(data)
        statements.append(dict(start=start, end=p, body=body, op=op, name=names.get(start)))
    axioms = [d['name'] for d in statements if d['op'] == 2]
    proof_commands = 0
    for d in statements:
        if d['op'] == 4:
            continue
        p = d['body']
        while p < d['end']:
            op, _, p = command(data, p)
            assert op != 0x20, 'sorry opcode'
            proof_commands += 1
        assert p == d['end']
    return data, statements, dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest(),
                                 sorts=ns, terms=nt, theorems=nh, axioms=axioms,
                                 proof_commands=proof_commands, no_sorry_opcode=True)

def binary_value(body):
    tokens=re.findall(r'b[01]|0|\S',body)
    tokens=[t for t in tokens if t not in ('(',')')]
    assert tokens[-1] == '0' and all(t in ('b0','b1') for t in tokens[:-1])
    n=0
    for t in reversed(tokens[:-1]):
        n=2*n+int(t[-1])
    return n

def audit(name, controls=False):
    meta=json.loads((BASE/f'{name}.json').read_text())
    spec=(BASE/f'{name}.join.mm0').read_text()
    expected_axioms=re.findall(r'^axiom\s+(\w+)',(BASE/PA).read_text(),re.M)
    data, decls, info=inspect_mmb(BASE/f'{name}.mmb')
    assert info['axioms'] == expected_axioms
    assert re.findall(r'^axiom\s+(\w+)',spec,re.M) == expected_axioms
    defs={k:binary_value(v) for k,v in re.findall(r'^def ([ABC]\d+): nat = \$([^$]+)\$;',spec,re.M)}
    assert len(defs)==3*meta['products']
    rows=json.loads(FIXTURE.read_text())['rows']
    for i,pair in enumerate(meta['pairs']):
        a,b,c=map(int,(pair['a'],pair['b'],pair['product']))
        assert (defs[f'A{i}'],defs[f'B{i}'],defs[f'C{i}'])==(a,b,c)
        assert a*b==c
        assert a==abs(rows[i]['input'][2]) and b==abs(rows[i]['input'][4])
        assert f'theorem product{i}: $ A{i} * B{i} = C{i} $;' in spec
    info.update(name=name, products=meta['products'], exact_inputs_and_results=True,
                spec_sha256=hashlib.sha256(spec.encode()).hexdigest(), axiom_inventory_unchanged=True,
                qualification='Structural audit only; logical acceptance is by mm0-c.')
    if meta.get('closed_conjunction'):
        bodies=re.findall(r'theorem allProducts: \$([^$]+)\$;',spec)
        assert len(bodies)==1
        leaf=r'A(\d+) \* B(\d+) = C(\d+)'
        assert re.findall(leaf,bodies[0])==[(str(i),str(i),str(i)) for i in range(meta['products'])]
        rest=re.sub(leaf,'',bodies[0]).replace('/\\','')
        assert not rest.replace('(','').replace(')','').strip()
        info['closed_conjunction_checked']=True
    if controls:
        n=meta['products']-1
        assert n>=1
        for target,label in [(f'A{n}','bad_input'),(f'C{n}','bad_result')]:
            pattern=rf'(def {target}: nat = \$\s*\(?)(b[01])'
            changed,count=re.subn(pattern,lambda m:m[1]+('b1' if m[2]=='b0' else 'b0'),spec,count=1)
            assert count==1 and changed!=spec
            (BASE/f'{label}.mm0').write_text(changed,encoding='utf-8',newline='\n')
        changed=spec.replace(f'theorem product{n}: $ A{n} * B{n} = C{n} $;',
                             f'theorem product{n}: $ A{n} * B{n} = A{n} $;')
        assert changed!=spec and defs[f'C{n}']!=defs[f'A{n}']
        (BASE/'bad_conclusion.mm0').write_text(changed,encoding='utf-8',newline='\n')
        d=next(d for d in decls if d['name']==f'product{n}')
        p=d['body']; candidates=[]
        while p<d['end']:
            start=p;op,arg,p=command(data,p)
            if op in (0x14,0x15) and arg!=0:
                candidates.append((start,p,arg))
        start,end,old=candidates[-1]
        corrupt=bytearray(data)
        corrupt[start+1:end]=b'\0'*(end-start-1)
        assert corrupt!=data
        (BASE/'bad_proof.mmb').write_bytes(corrupt)
        info['corruption']=dict(theorem=d['name'], offset=start, original_theorem_id=old,
                                replacement_theorem_id=0, format_and_length_preserved=True)
    (BASE/f'{name}.audit.json').write_text(json.dumps(info,indent=2)+'\n')
    print(json.dumps({k: v for k,v in info.items() if k!='axioms'}),flush=True)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('names',nargs='+');p.add_argument('--controls',action='store_true')
    a=p.parse_args()
    for n in a.names:
        audit(n,a.controls)
