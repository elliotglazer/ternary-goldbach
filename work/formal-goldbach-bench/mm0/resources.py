"""Measure existing verifier HIGHWATER counters separately from timing."""
import hashlib,json,subprocess
from run import ROOT,WIN,TMP,shell
build=json.loads((ROOT/'build-manifest.json').read_text())[0]['command']
build=build[:];build[-1]=str(ROOT/'mm0-highwater');build.insert(1,'-DHIGHWATER')
subprocess.run(build,check=True)
p=shell(f'mkdir -p {TMP} && cp {WIN}/mm0-highwater {WIN}/mm0-emit {WIN}/actual-masks.bin {WIN}/reset-or-prefix.prefix {WIN}/reset-or-prefix.mm0 {WIN}/reset-slice-prefix.prefix {WIN}/reset-slice-prefix.mm0 {TMP}/');assert p.returncode==0,p.stderr
records=[]
for case,prefix in [('actual-reset-or','reset-or-prefix'),('sparse-reset-slice-or','reset-slice-prefix')]:
    meta=json.loads((ROOT/(prefix+'.json')).read_text())
    actual=case=='actual-reset-or';n=462720 if actual else 500000;op='or' if actual else 'slice-or'
    p=shell(f'cd {TMP} && ./mm0-emit {prefix}.prefix {case}.mmb {n} {meta["proof_decl_offset"]} {op} 16 3 good'+(' actual-masks.bin' if actual else ''))
    assert p.returncode==0,p.stderr
    p=shell(f'cd {TMP} && ./mm0-highwater {case}.mmb < {prefix}.mm0')
    assert p.returncode==0,p.stderr
    (ROOT/(case+'.resources.log')).write_text(p.stdout+p.stderr)
    records.append(dict(case=case,exit_code=p.returncode,output=p.stdout+p.stderr))
manifest=dict(command=build,sha256=hashlib.sha256((ROOT/'mm0-highwater').read_bytes()).hexdigest(),runs=records)
(ROOT/'resources.json').write_text(json.dumps(manifest,indent=2)+'\n')
print(json.dumps(records,indent=2))
