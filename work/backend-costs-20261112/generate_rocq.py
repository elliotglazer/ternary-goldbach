"""Copy exact integer fixtures from the Lean stage benchmark to Rocq."""
from pathlib import Path
import json,hashlib
H=Path(__file__).resolve().parent
OLD=H.parent/'lean-pilots/batched-transform'
pins=[]
for p,n in [(100,64),(343,64),(415,64),(343,256)]:
    case=f'P{p}N{n}'
    source=OLD/(case+'.json')
    rows=json.loads(source.read_text())['rows']
    assert len(rows)==n
    text=['From Stdlib Require Import ZArith List.', 'Require Import StageCheck.',
          'Import ListNotations.', 'Open Scope Z_scope.',
          f'Definition scale : Z := {2**p}.',f'Definition bound : Z := {1024*2**p}.']
    for k,row in enumerate(rows):
        xs=' '.join(f'({v})' for v in row['input'])
        ys=' '.join(f'({v})' for v in row['output'])
        text += [f'Definition x{k} := Inp {xs}.', f'Definition y{k} := Out {ys}.']
    text += ['Definition inputs := ['+';'.join(f'x{k}' for k in range(n))+'].',
             'Definition outputs := ['+';'.join(f'y{k}' for k in range(n))+'].']
    (H/f'Data{case}.v').write_text('\n'.join(text)+'\n')
    for variant,tactic in [('Vm','vm_compute'),('Native','native_compute')]:
        text=['From Stdlib Require Import ZArith.',f'Require Import StageCheck Data{case}.']
        if variant=='Native': text+=['Set NativeCompute Timing.']
        text += ['Lemma checked : check_stage scale bound inputs outputs = true.',
                 f'Proof. Time {tactic}. reflexivity. Time Qed.',
                 'Lemma certified : stage_spec scale bound inputs outputs.',
                 'Proof. exact (check_stage_sound scale bound inputs outputs checked). Qed.',
                 'Print Assumptions certified.']
        (H/f'{variant}{case}.v').write_text('\n'.join(text)+'\n')
    pins.append(dict(case=case,source=str(source),sha256=hashlib.sha256(source.read_bytes()).hexdigest()))
(H/'fixture_pins.json').write_text(json.dumps(pins,indent=2)+'\n')
