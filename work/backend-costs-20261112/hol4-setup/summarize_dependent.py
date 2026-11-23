"""Fail-closed extraction of complete dependent-block evidence."""
from pathlib import Path
import hashlib
import json
import re
import statistics

home=Path(__file__).resolve().parent
fixture=json.loads((home/'dependent_fixture.json').read_text())
log=(home/'dependent_run.log').read_text()
timer=(home/'dependent_run.time').read_text()
assert 'HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE' in log
assert re.search(r'Exit status:\s+0\s*$',timer)
assert not re.search(r'Uncaught exception|Exception-|error in |FAIL<',log+timer)
axioms=re.search(r'HOL4_CONTEXT_AXIOMS,(.*)',log)[1].split(';')
assert set(axioms)=={'bool.ETA_AX','bool.SELECT_AX','bool.INFINITY_AX','bool.BOOL_CASES_AX'}
times={label:{'cpu_seconds':float(cpu),'wall_seconds':float(wall)}
       for label,cpu,wall in re.findall(r'HOL4_TIME,([^,\n]+),([0-9.]+),([0-9.]+)',log)}
tags=re.findall(r'HOL4_TAG,([^,\n]+),oracles=([^,\n]*),axioms=([^\n]*)',log)
assert len(tags)==len(fixture['cases'])+len(fixture['controls'])
assert all(oracles=='DISK_THM' and not ax for _,oracles,ax in tags)
for control in fixture['controls']:
    assert f'HOL4_REJECTED_{control}' in log
    assert f'control_{control}' in times
for c in fixture['cases']:
    assert f'Saved theorem _______ "certified_depth{c["depth"]}"' in log
hol_times=[times]
hol_process_texts=[timer]
for sample in [2,3]:
    hlog=(home/f'dependent_replay_sample_{sample}.log').read_text()
    htime=(home/f'dependent_replay_sample_{sample}.time').read_text()
    assert 'HOL4_DEPENDENT_BLOCK_BENCHMARK_DONE' in hlog
    assert re.search(r'Exit status:\s+0\s*$',htime)
    assert not re.search(r'Uncaught exception|Exception-|error in |FAIL<|HOL4_UNCLOSED_RESULT',hlog)
    assert set(re.search(r'HOL4_CONTEXT_AXIOMS,(.*)',hlog)[1].split(';'))==set(axioms)
    htags=re.findall(r'HOL4_TAG,([^,\n]+),oracles=([^,\n]*),axioms=([^\n]*)',hlog)
    assert htags==tags
    for c in fixture['cases']:
        assert f'Saved theorem _______ "certified_depth{c["depth"]}"' in hlog
    for control in fixture['controls']:
        assert f'HOL4_REJECTED_{control}' in hlog
    hol_times.append({label:{'cpu_seconds':float(cpu),'wall_seconds':float(wall)}
       for label,cpu,wall in re.findall(r'HOL4_TIME,([^,\n]+),([0-9.]+),([0-9.]+)',hlog)})
    hol_process_texts.append(htime)
exports=[hashlib.sha256((home/f'dependent_sample_{sample}.dat').read_bytes()).hexdigest()
         for sample in range(1,4)]
assert len(set(exports))==1
assert exports[0]==hashlib.sha256((home/'.hol/objs/DependentBlockResultsTheory.dat').read_bytes()).hexdigest()
assert fixture['fixture_sha256']==hashlib.sha256(
    (home.parents[1]/'lean-pilots/batched-transform/P343N64.json').read_bytes()).hexdigest()
native_pin=json.loads((home/'dependent_native_fixture_pin.json').read_text())
assert native_pin['fixture_sha256']==hashlib.sha256((home/'dependent_fixture.json').read_bytes()).hexdigest()
assert native_pin['header_sha256']==hashlib.sha256((home/'dependent_data.hpp').read_bytes()).hexdigest()
native=[]
for sample in range(1,4):
    nlog=(home/f'dependent_native_sample_{sample}.log').read_text()
    ntime=(home/f'dependent_native_sample_{sample}.time').read_text()
    assert 'NATIVE_BLOCK_ALL_COORDINATES_AND_CONTROLS_PASS' in nlog
    assert re.search(r'Exit status:\s+0\s*$',ntime)
    rows=re.findall(r'NATIVE_BLOCK_TIME,(\d+),(\d+),([0-9.]+),(\d+)',nlog)
    assert len(rows)==12
    assert {(int(d),int(rep)) for d,rep,_,_ in rows}=={
        (c['depth'],rep) for c in fixture['cases'] for rep in range(3)}
    native.extend({'process':sample,'depth':int(d),'repeat':int(rep),
                   'cpu_per_block':float(cpu)/int(count),'iterations':int(count)}
                  for d,rep,cpu,count in rows)

def process(time_text):
    def number(label):
        return float(re.search(re.escape(label)+r':\s+([0-9.]+)',time_text)[1])
    return {'cpu_seconds':number('User time (seconds)')+number('System time (seconds)'),
            'elapsed_as_reported':re.search(r'Elapsed \(wall clock\) time .*:\s+(.+)',time_text)[1],
            'peak_rss_kib':number('Maximum resident set size (kbytes)')}

cases=[]
for c in fixture['cases']:
    depth=c['depth']
    hs=[ts[f'depth{depth}_r{rep}']['cpu_seconds'] for ts in hol_times for rep in range(3)]
    hol=statistics.median(hs)
    nat=statistics.median(r['cpu_per_block'] for r in native if r['depth']==depth)
    cases.append({'depth':depth,'butterflies':c['butterflies'],
                  'maximum_coordinate_bits':c['maximum_coordinate_bits'],
                  'hol_cpu_median':hol,'native_cpu_median':nat,
                  'hol_cpu_range':[min(hs),max(hs)],
                  'hol_cpu_process_medians':[statistics.median(
                      ts[f'depth{depth}_r{rep}']['cpu_seconds'] for rep in range(3))
                      for ts in hol_times],
                  'hol_us_per_butterfly':hol/c['butterflies']*1e6,
                  'native_us_per_butterfly':nat/c['butterflies']*1e6,
                  'runtime_ratio':hol/nat})
files=['DependentBlockScript.sml','BlockRoundScript.sml','StageCheckScript.sml',
       'dependent.sml','generate_dependent.py','dependent_fixture.json','source.json',
       'dependent_run.log','dependent_run.time','dependent_native.cpp','dependent_data.hpp',
       'dependent_native','build_dependent_native.sh','generate_dependent_native.py',
       'run_dependent_native_samples.sh','summarize_dependent.py']
files += ['run_dependent_hol_samples.sh','dependent_native_fixture_pin.json',
          'build_dependent_v5.log','build_dependent_v5.time']
files += [f'dependent_replay_sample_{sample}{suffix}' for sample in [2,3]
          for suffix in ['.log','.time']]
files += [f'dependent_sample_{sample}.dat' for sample in range(1,4)]
files += [f'dependent_native_sample_{sample}{suffix}' for sample in range(1,4)
          for suffix in ['.log','.time']]
files += [f'.hol/objs/{theory}Theory{suffix}' for theory in ['DependentBlock','DependentBlockResults']
          for suffix in ['.dat','.sml','.sig']]
result={'passed':True,'contract':fixture['contract'],'context_axioms':axioms,
        'timings':times,'cases':cases,'native_samples':native,'tag_checks':tags,
        'whole_hol_process':process(timer),
        'hol_processes':[process(t) for t in hol_process_texts],
        'all_hol_timings':hol_times,
        'exports_identical':True,
        'shared_literal_translation_cpu_median':statistics.median(
            ts['translate_block_inputs']['cpu_seconds']+
            ts['translate_block_coefficients']['cpu_seconds'] for ts in hol_times),
        'conclusion_characters':dict(re.findall(r'HOL4_BLOCK_CONCLUSION,([^,\n]+),(\d+)',log)),
        'native_processes':[process((home/f'dependent_native_sample_{sample}.time').read_text())
                            for sample in range(1,4)],
        'artifacts':{name:{'bytes':(home/name).stat().st_size,
                           'sha256':hashlib.sha256((home/name).read_bytes()).hexdigest()} for name in files},
        'limitations':['HOL4 four standard bool axioms, not a stock-Lean proof.',
                       'No independent replay of an inference trace; .dat uses ordinary HOL4 loading trust.',
                       'Repeated calls reuse the same coefficient/input constants.',
                       'Nine HOL calls per case in three fresh processes; nine native batches in three processes.',
                       'Different algorithm from the earlier 19-condition scalar certificate checker.',
                       'Neither roots nor analytic source enclosures or propagated errors are certified.',
                       'Coordinate bit lengths increase with network depth; not a fixed-width throughput law.']}
(home/'DEPENDENT_RESULTS.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({key:result[key] for key in ['passed','cases','whole_hol_process','conclusion_characters']},indent=2))
