"""Bind the stock-Lean block experiment to the exact HOL/GMP fixture."""
from pathlib import Path
import hashlib
import json

home=Path(__file__).resolve().parent
source=home.parent/'hol4-setup/dependent_fixture.json'
data=json.loads(source.read_text())

def ints(x):
    return f'({x})' if int(x)<0 else str(x)

def vector(xs):
    return '[\n'+',\n'.join('  ('+ints(r)+','+ints(i)+')' for r,i in xs)+'\n]'

changed=[xy[:] for xy in data['inputs']]
changed[0][0]+=1
changed_ws=[xy[:] for xy in data['coefficients']]
changed_ws[1][0]+=int(data['scale'])//8
fixture=['import DependentBlock','open DependentBlock','namespace DependentFixture',
         'def scale : Int := '+data['scale'],
         'def inputs : List ComplexInt := '+vector(data['inputs']),
         'def coefficients : List ComplexInt := '+vector(data['coefficients']),
         'def changedInputs : List ComplexInt := '+vector(changed),
         'def changedCoefficients : List ComplexInt := '+vector(changed_ws)]
for case in data['cases']:
    d=case['depth']
    fixture += [f'def bound{d} : Int := '+case['bound'],
                f'def expected{d} : Int := '+ints(case['checksum'])]
fixture += ['end DependentFixture']
(home/'DependentFixture.lean').write_text('\n\n'.join(fixture)+'\n',encoding='utf-8')

for case in data['cases']:
    d=case['depth'];n=case['butterflies'];module=f'BlockP343N{n}'
    proof=f'''import DependentFixture
open DependentBlock DependentFixture
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace {module}
theorem accepted : accept scale coefficients {d} inputs bound{d} expected{d} = true := by
  decide +kernel
theorem certified : ∃ ys, ys.length = inputs.length ∧
    blockContract scale coefficients {d} inputs ys ∧
    boundSpec bound{d} ys ∧ checksum ys = expected{d} :=
  accept_sound scale coefficients {d} inputs bound{d} expected{d} accepted
end {module}
'''
    (home/(module+'.lean')).write_text(proof,encoding='utf-8')
    replay=f'''import {module}
import Replay
set_option maxRecDepth 65536
set_option maxHeartbeats 0
#replay_stage "Block" 343 {n} 1 [{module}.accepted, {module}.certified]
'''
    (home/('Replay'+module+'.lean')).write_text(replay,encoding='utf-8')

controls=['import DependentFixture','import Replay','open DependentBlock DependentFixture',
          'set_option maxRecDepth 65536','set_option maxHeartbeats 0',
          'namespace DependentControls',
          'def good : Prop := accept scale coefficients 8 inputs bound8 expected8 = true',
          '#kernel_control DependentControls.good accept']
tests=[('checksum','8','inputs','coefficients','bound8','(expected8+1)'),
       ('bound','8','inputs','coefficients','0','expected8'),
       ('depth','7','inputs','coefficients','bound8','expected8'),
       ('input','8','changedInputs','coefficients','bound8','expected8'),
       ('coefficient','8','inputs','changedCoefficients','bound8','expected8')]
for label,d,x,w,b,e in tests:
    call=f'accept scale {w} {d} {x} {b} {e}'
    controls += [f'def {label}Claim : Prop := {call} = true',
                 f'#kernel_control DependentControls.{label}Claim reject',
                 f'theorem rejected_{label} : {call} = false := by decide +kernel']
controls += ['end DependentControls']
(home/'DependentControls.lean').write_text('\n'.join(controls)+'\n',encoding='utf-8')

audits=[f'import BlockP343N{c["butterflies"]}' for c in data['cases']]
audits += ['import DependentControls', '#print axioms DependentBlock.accept_sound']
audits += [f'#print axioms BlockP343N{c["butterflies"]}.certified' for c in data['cases']]
audits += [f'#print axioms DependentControls.rejected_{label}' for label,*_ in tests]
(home/'AxiomAudit.lean').write_text('\n'.join(audits)+'\n',encoding='utf-8')
(home/'fixture_pin.json').write_text(json.dumps({
    'fixture_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
    'upstream_fixture_sha256':data['fixture_sha256'],
    'scope':'Exact integer network and five controls, matching HOL4 and native GMP.'},indent=2)+'\n')
print('Generated exact Lean input definitions, four proofs, fresh-kernel replays and controls.')
