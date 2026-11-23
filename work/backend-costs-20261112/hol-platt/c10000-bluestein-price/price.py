import json, statistics as st
from pathlib import Path
here=Path(__file__).resolve().parent
fold=json.loads((here/'fold.json').read_bytes())['scenarios']
model=json.loads((here.parent.parent/'forecast-audit-20261113/end_to_end_model.json').read_bytes())
a=model['assumptions']
rate=a['core_rate_seconds_per_butterfly']['HOL4']*a['geometry_factor'][1]*a['accepted_refinement_factor'][1]
weights={r['name']:r['butterfly_factors'][1] for r in model['semantic_rows']}
old=rate*(10240*weights['small_character_butterfly']+2024*weights['small_character_point_product'])
log=(here/'p01_replay.log').read_text()
def rows(tag):
    return [[float(s) for s in l.split(',')[1:]] for l in log.splitlines() if l.startswith(tag+',')]
parts=rows('RESIDENT_CPU')
template,shared,admit,conv=rows('ADMISSION_CPU')[0]
save,export=rows('EXPORT_CPU')[0]
ar=[p[1] for p in parts]
full=[sum(p[1:]) for p in parts]
def hours(count,sec):
    return count*sec/3600
report=[]
for s in fold:
    exact=s['char_by_p']['307']
    le=sum(v for k,v in s['char_by_p'].items() if int(k)<=307)
    report.append(dict(extra=s['extra_nodes'],exact=exact,le307=le,
       higher=sum(s['char_by_p'].values())-le,
       exact_old_character_butterfly_and_points=hours(exact,old),
       fresh_compute_hours=[hours(exact,v) for v in (.303648,.403917)],
       resident_compute_median_mean_hours=[hours(exact,v) for v in (st.median(ar),st.mean(ar))],
       resident_decoded_checked_mean_hours=hours(exact,st.mean(full)),
       separate_input_admission_and_checked_outputs_hours=hours(exact,admit+st.mean(full)),
       padding_le307_fresh_compute_hours=[hours(le,v) for v in (.303648,.403917)],
       gauss=sum(s['gauss_by_p'].values())))
print(json.dumps(dict(old_seconds_per_slice=old,resident_arith_cpu=ar,
    resident_core_mean=st.mean(ar),resident_core_median=st.median(ar),
    resident_with_decode_consumption_mean=st.mean(full),template=template,shared=shared,
    admission=admit,compile=conv,save=save,export=export,rows=report),indent=2))
