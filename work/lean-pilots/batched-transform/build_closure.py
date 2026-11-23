"""Measure one complete own-source build of the four exported real bounds."""
from pathlib import Path
import subprocess,sys,json,time
H=Path(__file__).resolve().parent
label=sys.argv[1]
assert label.isidentifier()
modules=['StageCheck','StageFast','StageReal',
         'DataP100N64','ScalarP100N64',
         'DataP343N64','FastScalarP343N64',
         'DataP415N64','ScalarP415N64',
         'DataP343N256','TreeDataP343N256','TreeChunk16P343N256','TreeBinding','CertifiedReal']
start=time.perf_counter()
rows=[]
for name in modules:
    item=f'{label}_{name}'
    subprocess.run([sys.executable,str(H/'run_lean.py'),name+'.lean',item],check=True)
    receipt=json.loads((H/(item+'.json')).read_text())
    assert receipt['exit_code']==0
    rows.append(dict(module=name,receipt=item+'.json',cpu_seconds=receipt['cpu_seconds'],
                     wall_seconds=receipt['wall_seconds'],
                     peak_working_set_bytes=receipt['peak_working_set_bytes']))
result=dict(modules=rows,cpu_seconds=sum(x['cpu_seconds'] for x in rows),
            summed_lean_wall_seconds=sum(x['wall_seconds'] for x in rows),
            driver_wall_seconds=time.perf_counter()-start,
            dependency_builds=False,own_source_modules=len(rows),
            peak_single_process_working_set=max(x['peak_working_set_bytes'] for x in rows))
(H/(label+'_closure.json')).write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result))
