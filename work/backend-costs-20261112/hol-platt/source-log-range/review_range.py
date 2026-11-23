"""Review recorded construction/audit results; not independent whole-kernel replay."""
from pathlib import Path
import hashlib, json, re, sys
p=Path(__file__).resolve().parent
label=sys.argv[1] if len(sys.argv)>1 else 'range03'
def read(path): return path.read_text(encoding='utf-8-sig')
def digest(path): return hashlib.sha256(path.read_bytes()).hexdigest()
def manifest(name):
    lines=read(p/name).splitlines()
    for line in lines:
        expected,item=line.split('  ',1)
        target=Path('C:/'+item[len('/mnt/host/c/'):]) if item.startswith('/mnt/host/c/') else p/item
        assert digest(target)==expected,(name,item)
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
assert list(counts.values())==[21,6,51,3],counts
construction=read(p/f'{label}_theory.log')
assert 'Created theory "SourceLogRange"' in construction
assert 'SOURCE_LOG_RANGE_PROOFS_DONE' in construction
old=read(p/'history/range01/SourceLogRangeScript.sml')
new=read(p/'SourceLogRangeScript.sml')
pat=r'Theorem\s+(\w+):\s*\n(.*?)\nProof\n'
assert re.findall(pat,old,re.S)==re.findall(pat,new,re.S)
assert re.findall(r'Definition .*?\nEnd',old,re.S)==re.findall(r'Definition .*?\nEnd',new,re.S)
assert (p/'range_audit.sml').read_bytes()==(p/'history/range01/range_audit.sml').read_bytes()
names=[n for n,t in re.findall(pat,new,re.S)]
assert len(names)==11
audit=read(p/f'{label}_audit.log')
assert audit.count('SOURCE_LOG_RANGE_EXACT_AUDIT_DONE')==1
assert audit.count('SOURCE_LOG_RANGE_AXIOMS,')==1
assert re.findall(r'^SOURCE_LOG_RANGE_ROOT,([^,]+),',audit,re.M)==names
types=re.findall(r'^SOURCE_LOG_RANGE_TYPE,([^,]+),',audit,re.M)
assert types==['source_raw_log129','source_log_from_two','slr_numerator','slr_error_bound']
parent=p.parent/'source-log-horner'
parent_review=json.loads(read(parent/'review_result.json'))
for name,h in parent_review['hashes'].items(): assert digest(parent/name)==h,name
forecast=p.parents[1]/'forecast-audit-20261113/END_TO_END_MODEL.md'
assert digest(forecast)=='37d11ca50efd9259021c2b6422c662d476fe683c6c5e1aa3b97c19288aede3fa'
times=list(p.glob('range[0-9]*_*.time'))+list(p.glob('rangediag*_run/time.txt'))
all_cpu=sum(cpu(t) for t in times)
outputs=('SourceLogRangeScript.sml','range_audit.sml','source_expected.sha256','.hol/objs/SourceLogRangeTheory.uo','.hol/objs/SourceLogRangeTheory.dat',f'{label}_audit.log')
result={'accepted_run':label,'scope':'Actual range-reduced and finally rounded source_raw_log129 accuracy','exact_roots':names,'exact_program_types':types,'manifest_counts':counts,'phase_cpu_seconds':phases,'accepted_phase_cpu_seconds':sum(phases.values()),'container_elapsed_seconds':receipt['elapsedSeconds'],'all_recorded_experiment_phase_cpu_seconds':all_cpu,'recorded_time_files':[str(t.relative_to(p)) for t in sorted(times)],'hashes':{n:digest(p/n) for n in outputs},'forecast_unchanged':True}
(p/'review_result.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8',newline='\n')
hash_rows='\n'.join('| '+n+' | '+h+' |' for n,h in result['hashes'].items())
report=f'''# Actual raw logarithm result review

Run {label} is accepted for the actual range-reduced and finally rounded raw
logarithm. All eleven original exact conclusions passed the recorded-result
audit, with empty hypotheses, permitted import tags and standard HOL ancestry.
Four exact program types passed. All twenty-one expected-source, six run-source,
fifty-one dependency and three output bindings match. The original eleven
statements, two definitions and fixed audit are unchanged. The parent Horner
review hashes also match. The run rebuilt the theory and executed the audit.

The final theorem proves

    source_log_domain x 1 k /\\ k <= 18 ==>
      abs (real_of_int (source_raw_log129 k x) / 2 pow 129 - ln (&x))
        <= 1 / 2 pow 128.

It uses the actual computed ln(2) center, actual reduced-input center and actual
final integer rounding. No approximate logarithm, numerator equality or rounding
accuracy is assumed. The source-domain gate and exponent limit remain explicit
requirements for every later concrete source input.

The generic numerator error is at most (k+1)*(7/(4*grid)+2^-135). Final
rounding adds at most 2^-130 on the output grid. The exact budget for k<=18
is proved strictly below 2^-128. Fixed precision and term count are unchanged.

Successful construction and audit phases consumed {sum(phases.values()):.2f}
CPU seconds and {receipt['elapsedSeconds']:.3f} container elapsed seconds.
All recorded experiment phases consumed {all_cpu:.2f} CPU seconds, including
failed diagnostics and construction, excluding untimed orchestration and file
handling. These are generic proof-development timings, not numerical throughput.

This is recorded-result review/reload, not independent whole-kernel replay.
Exponential phase production, analytic target joins, complete source/sign/count
blocks and the other required campaign strata remain open. No aggregate speed
credit is assigned. The frozen forecast is unchanged and the full goal remains
active. BUILD_NOTES.md records the failed attempts and proof-only repairs.

| Artifact | SHA256 |
|---|---|
{hash_rows}
'''
(p/'RESULT_REVIEW.md').write_text(report,encoding='utf-8',newline='\n')
print(json.dumps(result,indent=2))
