from pathlib import Path
import json,re,hashlib
H=Path(__file__).resolve().parent
text=(H/'reproduce.log').read_text()
timing=(H/'reproduce.time').read_text()
errors=re.findall(r'^(?:ERROR:|EXCEPTION:).*$',text,re.M)
required=['CHECKER_DEFINITIONS_DONE','FIXTURE_ACCEPTED','FIXTURE_DONE',
          'ARITHMETIC_SOUND_DONE','REJECTED_rounding','REJECTED_missing',
          'REJECTED_reordered','REJECTED_coefficient','CONTROLS_DONE',
          'INSIDE_DONE','CANDLE_REPRODUCTION_DONE']
markers={k:k in text for k in required}
events={label:(float(cpu),float(wall)) for label,cpu,wall in
        re.findall(r'CANDLE_TIME,([^,\r\n]+),([0-9.]+),([0-9.]+)',timing)}
rows=[]
for prefix,n in [('repeat100',100)]+[(f'inside{n}',n) for n in [1,10,100,1000,10000]]:
    if prefix+'_start' in events and prefix+'_end' in events:
        a=events[prefix+'_start'];b=events[prefix+'_end']
        rows.append(dict(label=prefix,repetitions=n,cpu_seconds=b[0]-a[0],
                         wall_seconds=b[1]-a[1],cpu_ms_per_stage=1000*(b[0]-a[0])/n,
                         wall_ms_per_stage=1000*(b[1]-a[1])/n))
files=['checker.ml','fixture.ml','controls.ml','arithmetic_sound.ml','repeat_inside.ml',
       'reproduce.ml','reproduce.log','reproduce.time']
result=dict(markers=markers,errors=errors,timings=rows,
            complete_integer_spec_soundness=False,
            same_data_repetition_warning='inside timings repeat the SAME fixture; not independent-data throughput',
            artifacts={p:dict(bytes=(H/p).stat().st_size,sha256=hashlib.sha256((H/p).read_bytes()).hexdigest()) for p in files})
(H/'RESULTS.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({k:v for k,v in result.items() if k!='artifacts'},indent=2))
if errors or not all(markers.values()):raise SystemExit(1)
