"""Read one completed handoff run; no evaluation or extrapolation."""
from pathlib import Path
import hashlib,json,re,sys
HERE=Path(__file__).resolve().parent
label=sys.argv[1]
assert re.fullmatch(r'[A-Za-z0-9_]+',label)
phases=['generic','materialized_build','materialized','fused_build','fused',
        'compare_build','compare']
controls=['seed','step','interior','row_index','dropped_row','repeated_row',
          'final_entry','base_label','denominator']
result={'schema':'raw-state-handoff-result-v1','label':label,
        'scope':'Exact integer handoff only; no analytic source or forecast claim',
        'processes':{},'variants':{},'artifacts':{}}
launch=(HERE/f'{label}_launch.sha256').read_text().splitlines()
assert len(launch)==11
launch_pins={}
for line in launch:
    digest,name=line.split('  ',1)
    assert re.fullmatch('[0-9a-f]{64}',digest)
    assert hashlib.sha256((HERE/name).read_bytes()).hexdigest()==digest,name
    launch_pins[name]=digest.upper()
assert len(launch_pins)==11
assert (HERE/f'{label}_source_check.log').read_text().count(': OK\n')==11
result['launch_input_sha256']=launch_pins
result['build_scope']='Actual Holmake invocations; may be no-op/incremental. Before/after snapshots and logs determine construction work, not target names.'
result['support_scope']='Selected installed heap/BlockRound/Holmake pins only; not a complete transitive compiler/library manifest.'
before=(HERE/f'{label}_before.artifacts').read_text()
result['initial_artifact_snapshot_empty']=not before.strip()
for p in phases:
    log=(HERE/f'{label}_{p}.log').read_text(errors='replace')
    t=(HERE/f'{label}_{p}.time').read_text()
    assert re.search(r'Exit status:\s+0\s*$',t),p
    def number(s):return float(re.search(re.escape(s)+r':\s+([0-9.]+)',t)[1])
    result['processes'][p]={'exit_status':0,
                            'argv_lines':(HERE/f'{label}_{p}.argv').read_text().splitlines(),
                            'cpu_seconds':number('User time (seconds)')+
                            number('System time (seconds)'),
                            'peak_rss_kib':number('Maximum resident set size (kbytes)'),
                            'elapsed_reported':re.search(r'Elapsed \(wall clock\) time .*:\s+(.+)',t)[1]}
    if p in ['materialized','fused']:
        assert 'HANDOFF_DONE' in log and 'HANDOFF_PRIMARY_COMPLETE,516,8,129' in log
        for c in controls:assert f'HANDOFF_REJECTED,{c}\n' in log,(p,c)
        assert 'HANDOFF_TAG,final_integer_pipeline,' in log
        assert 'control_negative_ties' in log
        rows=re.findall(r'HANDOFF_PHASE,([^,\n]+),([0-9.]+),([0-9.]+)',log)
        assert len({a for a,b,c in rows})==len(rows)
        primary=log.split('HANDOFF_PRIMARY_COMPLETE,516,8,129')[0]
        primary_rows=re.findall(r'HANDOFF_PHASE,([^,\n]+),([0-9.]+),([0-9.]+)',primary)
        result['variants'][p]={'phases':{a:{'cpu_seconds':float(b),'elapsed_seconds':float(c)} for a,b,c in rows},
            'primary_instrumented_cpu_sum':sum(float(b) for a,b,c in primary_rows),
            'primary_scope':'Instrumented phases only: includes shared input setup and final binding; excludes uninstrumented setup/audit gaps, controls and later theory export; not full first acceptance',
            'export_scope':'Saved context and export timer include all controls; not pure primary proof bytes'}
assert 'HANDOFF_MATCHED_EXACT_FINAL_THEOREM,516' in (HERE/f'{label}_compare.log').read_text()
for p in [p for p in HERE.glob(f'{label}_*') if p.suffix in ['.log','.time','.dat','.sha256','.artifacts','.argv']]:
    result['artifacts'][p.name]={'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest().upper()}
for n in ['RawStateHandoffScript.sml','HandoffRuntime.sml','prepare_handoff.py',
          'run_handoff.sh','Holmakefile','fixture_binding.json','handoff_materialized.sml',
          'handoff_fused.sml','handoff_compare.sml']:
    p=HERE/n
    result['artifacts'][n]={'bytes':p.stat().st_size,'sha256':hashlib.sha256(p.read_bytes()).hexdigest().upper()}
with (HERE/f'{label}_results.json').open('x',encoding='utf-8') as f:
    json.dump(result,f,indent=2);f.write('\n')
print(json.dumps({'scope':result['scope'],'primary_phase_cpu':{k:v['primary_instrumented_cpu_sum'] for k,v in result['variants'].items()}},indent=2))
