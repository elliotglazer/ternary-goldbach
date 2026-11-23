from pathlib import Path
import json,re,hashlib,statistics
H=Path(__file__).resolve().parent
text=(H/'reproduce_sound.log').read_text();timing=(H/'reproduce_sound.time').read_text()
errors=re.findall(r'^(?:ERROR:|EXCEPTION:).*$',text,re.M)
exit_match=re.search(r'Exit status:\s*(\d+)',timing)
exit_status=int(exit_match.group(1)) if exit_match else None
resource_fields={}
for name in ['User time (seconds)','System time (seconds)',
             'Elapsed (wall clock) time (h:mm:ss or m:ss)',
             'Maximum resident set size (kbytes)']:
    match=re.search(r'^\s*'+re.escape(name)+r':\s*(.+)$',timing,re.M)
    if match: resource_fields[name]=match.group(1)
required=['ENCODING_SOUND_DONE','ROW_EXACT_DONE','RESIDUAL_SOUND_DONE',
 'STAGE_EXACT_DONE','BOOTSTRAP_SOUND_DONE','INTEGER_EXPORT_DONE',
 'REJECTED_rounding','REJECTED_missing','REJECTED_reordered','REJECTED_coefficient',
 'CONTROLS_DONE','CACHED_COMPARE_DONE','SOUND_REPRODUCTION_DONE']
required += ['DISTINCT_'+c+'_DONE' for c in ['P100N64','P343N64','P415N64','P343N256']]
markers={k:k in text for k in required}
events={label:(float(cpu),float(wall)) for label,cpu,wall in
 re.findall(r'CANDLE_TIME,([^,\r\n]+),([0-9.]+),([0-9.]+)',timing)}
rows=[]
for label,a in events.items():
    if not label.endswith('_start'):continue
    prefix=label[:-6]
    if prefix+'_end' not in events:continue
    b=events[prefix+'_end']
    reps=100 if prefix in ['repeat100','cached1','cached2','cached3',
                          'constant_prepared','constant_wrapper'] else 1
    rows.append(dict(label=prefix,repetitions=reps,cpu_seconds=b[0]-a[0],
     wall_seconds=b[1]-a[1],cpu_ms_per_call=1000*(b[0]-a[0])/reps,
     wall_ms_per_call=1000*(b[1]-a[1])/reps))
medians={}
for c in ['P100N64','P343N64','P415N64','P343N256']:
    rs=[r for r in rows if r['label'].startswith('distinct_'+c+'_')]
    if len(rs)==3:
        medians[c]=dict(cpu_ms=statistics.median(r['cpu_ms_per_call'] for r in rs),
                       wall_ms=statistics.median(r['wall_ms_per_call'] for r in rs))
files=['checker.ml','arithmetic_sound.ml','encoding_sound.ml','row_sound.ml',
 'residual_sound.ml','stage_sound.ml','export_integer.ml','bootstrap_sound.ml',
 'reproduce_sound.ml','fixture.ml','controls.ml','cached_compare.ml',
 'reproduce_sound.log','reproduce_sound.time']
files+=['distinct_'+c+'.ml' for c in ['P100N64','P343N64','P415N64','P343N256']]
result=dict(markers=markers,errors=errors,exit_status=exit_status,
 resources=resource_fields,timings=rows,distinct_stage_medians=medians,
 integer_soundness='generic stage theorem and closed literal residual theorem',
 real_coordinate_interpretation=False,root_certification=False,spectral_inputs=False,
 artifacts={p:dict(bytes=(H/p).stat().st_size,sha256=hashlib.sha256((H/p).read_bytes()).hexdigest()) for p in files})
(H/'SOUND_RESULTS.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k!='artifacts'},indent=2))
if errors or not all(markers.values()) or exit_status != 0:raise SystemExit(1)
