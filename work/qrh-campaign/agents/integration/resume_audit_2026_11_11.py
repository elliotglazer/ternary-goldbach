"""Read-only source/receipt audit. Never invokes Lean or Lake."""
from pathlib import Path
import hashlib,json,re
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[3]
SRC=ROOT/'work/ternary-goldbach'
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest()
receipts=[]
for p in sorted((HERE/'logs').glob('*.success.json')):
    d=json.loads(p.read_text());k=d['key'];m=k['module'];src=SRC.joinpath(*m.split('.')).with_suffix('.lean')
    checks={'source':sha(src)==k['source_sha256'],'manifest':sha(SRC/'lake-manifest.json')==k['environment']['project_manifest_sha256']}
    for dep,h in k['dependency_receipts'].items():checks['dependency:'+dep]=sha(HERE/'logs'/(dep+'.success.json'))==h
    out=HERE/'artifacts'/Path(*m.split('.')).parent
    for name,h in d['artifacts'].items():checks['artifact:'+name]=sha(out/name)==h
    receipts.append(dict(module=m,evidence=d['evidence'],checks=checks,passed=all(checks.values())))
files=[]
for p in sorted((SRC/'TernaryGoldbach').rglob('*.lean')):
    s=p.read_text(encoding='utf-8-sig');hits=[dict(line=i,text=l.strip()) for i,l in enumerate(s.splitlines(),1) if 'PlattGRH' in l or re.search(r'\b(?:platt_odd|platt_even|platt_grh|platt_verification|rh_upto_1e8|riemannHypothesisUpTo_of_platt)\b',l)]
    if hits:files.append(dict(path=p.relative_to(SRC).as_posix(),source_sha256=sha(p),hits=hits))
result=dict(receipts=receipts,receipt_count=len(receipts),all_receipts_match=all(x['passed'] for x in receipts),
    driver_sha256=sha(HERE/'build_project.py'),platt_lexical_files=files,
    warning='Lexical inventory includes comments and omit directives; not an elaborated transitive dependency graph. Existing theorem bindings still need Lean audit.',
    target_mathlib=[p for p in json.loads((SRC/'lake-manifest.json').read_text())['packages'] if p['name']=='mathlib'],
    provider_mathlib=[p for p in json.loads((ROOT/'work/openai-math/lean/lake-manifest.json').read_text())['packages'] if p['name']=='mathlib'])
(HERE/'RESUME_EVIDENCE_2026-11-11.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(dict(receipts=len(receipts),all_match=result['all_receipts_match'],lexical_files=len(files),driver=result['driver_sha256'])))
for group in ['Explicit','Prelim','MajorArcs','MinorArcs','Helfgott']:
    print(group+': '+', '.join(Path(x['path']).stem for x in files if '/'+group+'/' in x['path']))
