from pathlib import Path
import json
import re

home=Path(__file__).resolve().parent
for n in [8,16,32,64]:
    source=(home/f'PackedDataN{n}.lean').read_text(encoding='utf-8')
    values=dict(re.findall(r'def (left|right|mask|expected) : Nat := 0x([0-9a-f]+)',source))
    assert len(values)==4
    data=f'packed_literals_{n}.json'
    (home/data).write_text(json.dumps(values)+'\n')
    mod=f'LoadedPackedDataN{n}'
    (home/(mod+'.lean')).write_text(f'''import PackedLoader
import PackedProbe
namespace {mod}
#load_packed_literals "{data}"
end {mod}
''',encoding='utf-8')
    name=f'PackedLoadedP343N{n}'
    (home/(name+'.lean')).write_text(f'''import {mod}
open PackedProbe {mod}
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace {name}
theorem checked : packedCheck left right mask expected = true := by decide +kernel
theorem certified : Nat.land (left*right) mask = expected :=
  packedCheck_sound left right mask expected checked
end {name}
''',encoding='utf-8')
    (home/('Replay'+name+'.lean')).write_text(f'''import {name}
import Replay
set_option maxRecDepth 65536
set_option maxHeartbeats 0
#replay_stage "PackedLoaded" 343 {n} 1 [{name}.checked, {name}.certified]
''',encoding='utf-8')
print('Generated a balanced hexadecimal loader and identical packed Nat payloads.')

rows_source=home.parents[1]/'lean-pilots/batched-transform/P343N64.json'
rows=json.loads(rows_source.read_text())['rows']
literal='[\n'+',\n'.join(f'({abs(r["input"][2])},{abs(r["input"][4])},'
                        f'{abs(r["input"][2])*abs(r["input"][4])})' for r in rows)+'\n]'
(home/'NatRowsDataN64.lean').write_text('import PackedProbe\nnamespace NatRowsDataN64\n'
    +'def rows : List (Nat × Nat × Nat) := '+literal+'\nend NatRowsDataN64\n',encoding='utf-8')
(home/'NatScalarP343N64.lean').write_text('''import NatRowsDataN64
open PackedProbe NatRowsDataN64
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace NatScalarP343N64
theorem checked : scalarCheck rows = true := by decide +kernel
theorem certified : scalarSpec rows := scalarCheck_sound rows checked
end NatScalarP343N64
''',encoding='utf-8')

audit=[f'import PackedLoadedP343N{n}' for n in [8,16,32,64]]
audit += [f'import NatScalarP343N{n}' for n in [8,16,32,64]]
audit += ['import Replay','set_option maxRecDepth 65536','set_option maxHeartbeats 0']
audit += [f'#audit_packed_literals LoadedPackedDataN{n} "packed_literals_{n}.json"'
          for n in [8,16,32,64]]
audit += ['open PackedProbe LoadedPackedDataN64',
          'def loadedPackedBad : Prop := packedCheck left right mask (Nat.xor expected 1) = true',
          '#kernel_control loadedPackedBad reject']
audit += [f'#print axioms {v}P343N{n}.certified' for n in [8,16,32,64]
          for v in ['PackedLoaded','NatScalar']]
(home/'LoadedPackedAudit.lean').write_text('\n'.join(audit)+'\n',encoding='utf-8')
