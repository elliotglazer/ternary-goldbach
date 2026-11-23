"""Review recorded construction and reload results, not independent kernel replay."""
from pathlib import Path
import hashlib,json,re,sys
p=Path(__file__).resolve().parent
label=sys.argv[1] if len(sys.argv)>1 else 'exphorner02'
def read(path): return path.read_text(encoding='utf-8-sig')
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def manifest(name):
    lines=read(p/name).splitlines()
    for line in lines:
        expected,item=line.split('  ',1)
        path=Path('C:/'+item[len('/mnt/host/c/'):]) if item.startswith('/mnt/host/c/') else p/item
        assert digest(path)==expected,(name,item)
    return len(lines)
def cpu(path):
    text=read(path)
    u=re.search(r'User time \(seconds\): ([0-9.]+)',text)
    s=re.search(r'System time \(seconds\): ([0-9.]+)',text)
    assert u and s,path
    return float(u[1])+float(s[1])
receipt=json.loads(read(p/f'{label}_container_exit.json'))
assert receipt['exitCode']==0,receipt
phases={}
for phase in ('theory','build','audit'):
    assert read(p/f'{label}_{phase}.status').strip()=='0',phase
    assert 'Exit status: 0' in read(p/f'{label}_{phase}.time'),phase
    phases[phase]=cpu(p/f'{label}_{phase}.time')
counts={n:manifest(n) for n in ('source_expected.sha256',f'{label}_source.sha256',f'{label}_dependency.sha256',f'{label}_output.sha256')}
assert list(counts.values())==[17,6,49,3],counts
construction=read(p/f'{label}_theory.log')
assert 'Created theory "SourceExpHorner"' in construction
assert 'SOURCE_EXP_HORNER_PROOFS_DONE' in construction
old=read(p/'history/exphorner01/SourceExpHornerScript.sml')
new=read(p/'SourceExpHornerScript.sml')
pat=r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n'
assert re.findall(pat,old,re.S)==re.findall(pat,new,re.S)
assert re.findall(r'Definition .*?\nEnd',old,re.S)==re.findall(r'Definition .*?\nEnd',new,re.S)
assert len(re.findall(r'Definition .*?\nEnd',new,re.S))==3
assert (p/'exp_horner_audit.sml').read_bytes()==(p/'history/exphorner01/exp_horner_audit.sml').read_bytes()
names=[n for n,t in re.findall(pat,new,re.S)]
assert len(names)==12
audit=read(p/f'{label}_audit.log')
assert audit.count('SOURCE_EXP_HORNER_EXACT_AUDIT_DONE')==1
assert audit.count('SOURCE_EXP_HORNER_AXIOMS,')==1
assert re.findall(r'^SOURCE_EXP_HORNER_ROOT,([^,]+),',audit,re.M)==names
types=re.findall(r'^SOURCE_EXP_HORNER_TYPE,([^,]+),',audit,re.M)
assert types==['source_exp_horner','source_exp_step','seh_affine','seh_ideal','seh_bound']
state=p.parent/'source-state-error'
state_pins=re.findall(r'^- (.*): ([0-9a-f]{64})$',read(state/'RESULT_REVIEW.md'),re.M)
assert len(state_pins)==6
for name,h in state_pins: assert digest(state/name)==h,name
log=p.parent/'source-log-range'
for name,h in json.loads(read(log/'review_result.json'))['hashes'].items(): assert digest(log/name)==h,name
forecast=p.parents[1]/'forecast-audit-20261113/END_TO_END_MODEL.md'
assert digest(forecast)=='37d11ca50efd9259021c2b6422c662d476fe683c6c5e1aa3b97c19288aede3fa'
times=list(p.glob('exphorner[0-9]*_*.time'))+list(p.glob('expdiag*_run/time.txt'))
all_cpu=sum(cpu(t) for t in times)
outputs=('SourceExpHornerScript.sml','exp_horner_audit.sml','source_expected.sha256','.hol/objs/SourceExpHornerTheory.uo','.hol/objs/SourceExpHornerTheory.dat',f'{label}_audit.log')
result={'accepted_run':label,'scope':'Actual integer exponential Horner rounding against its defined ideal recurrence, for absolute phase at most two','exact_roots':names,'exact_program_types':types,'manifest_counts':counts,'phase_cpu_seconds':phases,'accepted_phase_cpu_seconds':sum(phases.values()),'container_elapsed_seconds':receipt['elapsedSeconds'],'all_recorded_experiment_phase_cpu_seconds':all_cpu,'recorded_time_files':[str(t.relative_to(p)) for t in sorted(times)],'hashes':{n:digest(p/n) for n in outputs},'forecast_unchanged':True}
(p/'review_result.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8',newline='\n')
hash_rows='\n'.join('| '+n+' | '+h+' |' for n,h in result['hashes'].items())
report=f'''# Actual exponential Horner rounding result review

Run {label} is accepted for the rounding error of the actual integer Horner
routine against its explicitly defined ideal complex recurrence. All twelve
original exact conclusions passed the recorded-result audit with empty
hypotheses, permitted import tags and standard HOL ancestry. Five exact program
types passed. Seventeen expected-source, six run-source, forty-nine dependency
and three output bindings match. The original twelve statements, three
definitions and fixed audit are unchanged. Accepted state-error and raw-log
bindings were rechecked. The run rebuilt the theory and executed the audit.

For d>0 and abs(real_of_int p / &d)<=2, the actual source_exp_horner program
differs from grid times seh_ideal by at most seh_bound k in Euclidean complex
modulus, for every term count n and starting index k. The bound is 9 at k=0,
4 at k=1 and 3 at k>=2. Each local rounding error is proved from the actual
round_scaled calls. The ideal terminal value and affine update are explicit
definitions, and their integer/cast connection is proved. No assumed local
rounding accuracy or externally supplied ideal-value equality is used.

This is an unscaled rounding theorem. It does not yet identify seh_ideal with
the exponential Taylor polynomial or bound the analytic remainder. The actual
raw phase range, output-grid normalization, final regrid and analytic phase
perturbation still require their joins. The EM producer has separate range,
period and precision requirements. No change to precision or update count is
made here.

Successful construction and audit phases consumed {sum(phases.values()):.2f}
CPU seconds and {receipt['elapsedSeconds']:.3f} container elapsed seconds.
All recorded experiment phases total {all_cpu:.2f} CPU seconds, including failed
and timed-out diagnostics, excluding untimed orchestration and file handling.
These are generic proof-development costs, not numerical production throughput.

This is recorded-result review/reload, not independent whole-kernel replay.
Complete source/sign/count blocks and the other campaign strata remain required.
The frozen forecast is unchanged; no aggregate speed credit is assigned and the
full research goal remains active. BUILD_NOTES.md records the failed attempts.
NEXT_ANALYTIC_CONNECTION.md records the next actual-phase obligations.

| Artifact | SHA256 |
|---|---|
{hash_rows}
'''
(p/'RESULT_REVIEW.md').write_text(report,encoding='utf-8',newline='\n')
print(json.dumps(result,indent=2))
