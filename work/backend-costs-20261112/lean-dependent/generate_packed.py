"""Diagonal product packing. Kernel certifies the large integer identity.

The generic connection to pointwise products is deliberately not claimed as
proved. This probe measures whether that future bridge has useful headroom.
"""
from pathlib import Path
import hashlib
import json

home=Path(__file__).resolve().parent
source=home.parents[1]/'lean-pilots/batched-transform/P343N64.json'
rows=json.loads(source.read_text())['rows']
cases=[]
for n in [8,16,32,64]:
    a=[abs(row['input'][2]) for row in rows[:n]]
    b=[abs(row['input'][4]) for row in rows[:n]]
    width=max(x.bit_length() for x in a)+max(x.bit_length() for x in b)+1
    assert max(a)*max(b)<2**width
    pa=sum(x<<(width*n*i) for i,x in enumerate(a))
    pb=sum(x<<(width*i) for i,x in enumerate(b))
    mask=sum(((1<<width)-1)<<(width*(n+1)*i) for i in range(n))
    expected=sum((x*y)<<(width*(n+1)*i) for i,(x,y) in enumerate(zip(a,b)))
    assert (pa*pb)&mask==expected
    assert ((pa*pb)&mask)!=(expected^1)
    mod=f'PackedDataN{n}'
    lines=['import PackedProbe','set_option maxRecDepth 65536',f'namespace {mod}']
    for key,val in [('left',pa),('right',pb),('mask',mask),('expected',expected)]:
        lines.append(f'def {key} : Nat := 0x{val:x}')
    lines += ['def rows : List (Nat × Nat × Nat) := [\n'+',\n'.join(
        f'  ({x},{y},{x*y})' for x,y in zip(a,b))+'\n]',f'end {mod}']
    (home/(mod+'.lean')).write_text('\n'.join(lines)+'\n',encoding='utf-8')
    for variant,claim,sound in [
        ('Packed','packedCheck left right mask expected',
         'packedCheck_sound left right mask expected checked'),
        ('NatScalar','scalarCheck rows','scalarCheck_sound rows checked')]:
        name=f'{variant}P343N{n}'
        target='Nat.land (left*right) mask = expected' if variant=='Packed' else 'scalarSpec rows'
        text=f'''import {mod}
open PackedProbe {mod}
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace {name}
theorem checked : {claim} = true := by decide +kernel
theorem certified : {target} := {sound}
end {name}
'''
        (home/(name+'.lean')).write_text(text,encoding='utf-8')
        replay=f'''import {name}
import Replay
set_option maxRecDepth 65536
set_option maxHeartbeats 0
#replay_stage "{variant}" 343 {n} 1 [{name}.checked, {name}.certified]
'''
        (home/('Replay'+name+'.lean')).write_text(replay,encoding='utf-8')
    cases.append({'n':n,'digit_width':width,'left_bits':pa.bit_length(),
                  'right_bits':pb.bit_length(),'mask_bits':mask.bit_length(),
                  'packed_expected_bits':expected.bit_length()})
audit=[f'import {v}P343N{n}' for n in [8,16,32,64] for v in ['Packed','NatScalar']]
audit+=['import Replay','open PackedProbe PackedDataN64',
        'set_option maxRecDepth 65536','set_option maxHeartbeats 0',
        'def packedBad : Prop := packedCheck left right mask (Nat.xor expected 1) = true',
        '#kernel_control packedBad reject']
audit += [f'#print axioms {v}P343N{n}.certified' for n in [8,16,32,64] for v in ['Packed','NatScalar']]
(home/'PackedAudit.lean').write_text('\n'.join(audit)+'\n',encoding='utf-8')
(home/'packed_fixture_pin.json').write_text(json.dumps({
    'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'cases':cases,
    'unproved_bridge':'Generic positional-digit/pointwise-product theorem and input/width invariants.'},indent=2)+'\n')
print(json.dumps(cases,indent=2))
