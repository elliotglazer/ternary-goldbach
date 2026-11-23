"""Require completed proofs, controls, exact axioms and all fresh kernel replays."""
from pathlib import Path
import hashlib
import json
import re
import statistics

home=Path(__file__).resolve().parent
pin=json.loads((home/'fixture_pin.json').read_text())
source=home.parent/'hol4-setup/dependent_fixture.json'
assert pin['fixture_sha256']==hashlib.sha256(source.read_bytes()).hexdigest()
data=json.loads(source.read_text())
hol=json.loads((home.parent/'hol4-setup/DEPENDENT_RESULTS.json').read_text())
assert hol['passed']
artifacts=set(['DependentBlock.lean','DependentBlock.olean','DependentFixture.lean',
               'DependentFixture.olean','generate.py','run_lean.py','run_suite.py',
               'summarize.py','fixture_pin.json','DependentControls.lean','DependentControls.olean',
               'AxiomAudit.lean'])

def read(label):
    rec=json.loads((home/(label+'.json')).read_text())
    assert rec['exit_code']==0 and rec['stop'] is None
    assert not rec['dependency_builds'] and rec['no_native_decide']
    log=(home/(label+'.log')).read_text(encoding='utf-8')
    assert not re.search(r'error:|declaration uses .sorry.|failed',log)
    for a in rec['artifacts']:
        p=home/a['path']
        # Source and log hashes are stable. Replays overwrite identical .olean
        # paths in later processes; final hashes are recorded separately below.
        if p.suffix!='.olean':
            assert a['sha256'].lower()==hashlib.sha256(p.read_bytes()).hexdigest()
    artifacts.update([label+'.json',label+'.log'])
    return rec,log

theory,_=read('theory_dev01')
fixture,_=read('fixture_build')
controls,control_log=read('controls_build')
audit,audit_log=read('axiom_audit')
expected_axioms={'propext','Classical.choice','Quot.sound'}
axiom_rows=re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]",audit_log)
assert len(axiom_rows)==5
assert all(set(a.split(', '))==expected_axioms for _,a in axiom_rows)
for c in data['cases']:
    assert any(n==f'BlockP343N{c["butterflies"]}.certified' for n,_ in axiom_rows)
assert 'CONTROL,DependentControls.good,accepted=true,expected=true' in control_log
for label in data['controls']:
    assert f'CONTROL,DependentControls.{label}Claim,accepted=false,expected=false' in control_log
    assert f"'DependentControls.rejected_{label}' does not depend on any axioms" in audit_log

cases=[]
builds=[]
replays=[]
for c in data['cases']:
    n=c['butterflies'];module=f'BlockP343N{n}'
    build,_=read(f'build_block_{n}')
    builds.append(build)
    samples=[]
    for sample in range(3):
        rec,log=read(f'replay_block_{n}_sample{sample}')
        assert 'LIMITS,trust=0,heartbeats=0,recdepth=65536' in log
        assert len(rec['rows'])==1
        row=rec['rows'][0]
        assert row['precision']==343 and row['butterflies']==n
        assert row['variant']=='Block' and row['repetitions']==1 and row['declarations']==3
        samples.append(row['kernel_wall_ns']/1e9)
        replays.append(rec)
    h=next(h for h in hol['cases'] if h['butterflies']==n)
    med=statistics.median(samples)
    cases.append({'depth':c['depth'],'butterflies':n,'maximum_coordinate_bits':c['maximum_coordinate_bits'],
                  'lean_kernel_wall_samples_seconds':samples,'lean_kernel_wall_median_seconds':med,
                  'lean_kernel_wall_us_per_butterfly':med/n*1e6,
                  'lean_build_cpu_seconds':build['cpu_seconds'],
                  'lean_build_wall_seconds':build['wall_seconds'],
                  'hol_acceptance_cpu_median_seconds':h['hol_cpu_median'],
                  'native_gmp_cpu_median_seconds':h['native_cpu_median'],
                  'approximate_lean_hol_ratio_mixed_clocks':med/h['hol_cpu_median'],
                  'approximate_lean_native_ratio_mixed_clocks':med/h['native_cpu_median']})
    artifacts.update([module+'.lean',module+'.olean','Replay'+module+'.lean','Replay'+module+'.olean'])

result={'passed':True,'toolchain':'Lean 4.35.0, Windows, one thread, trust level zero',
        'axiom_audit':axiom_rows,'fixture_sha256':pin['fixture_sha256'],
        'cases':cases,'theory_build':theory,'fixture_build':fixture,
        'controls_build':controls,'audit_process':audit,'proof_builds':builds,'replay_processes':replays,
        'artifacts':{name:{'bytes':(home/name).stat().st_size,
                           'sha256':hashlib.sha256((home/name).read_bytes()).hexdigest()}
                     for name in sorted(artifacts)},
        'shared_dependencies':{},
        'limitations':['Integer network only; no root interpretation, global error bound or zero count.',
                       'Lean kernel loop is elapsed time; HOL/GMP figures are CPU time.',
                       'Windows Lean and WSL HOL/GMP have different process and I/O environments.',
                       'Three fresh-process Lean samples, each with one warmup and one timed replay.',
                       'Input/coefficients are reused named literals; fixture file also includes corrupted copies.',
                       'Generic theory and input definitions are imported in the kernel-loop rate.',
                       'No cross-system theorem interpretation is implemented.']}
for name in ['StageCheck','Replay']:
    base=home.parents[1]/'lean-pilots/batched-transform'
    for suffix in ['.lean','.olean']:
        p=base/(name+suffix)
        result['shared_dependencies'][str(p)]={'bytes':p.stat().st_size,
            'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}
(home/'RESULTS.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps({'passed':True,'cases':cases,'axioms':axiom_rows},indent=2))
