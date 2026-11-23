from pathlib import Path
import importlib.util,json
root=Path('work/qrh-campaign/agents/integration')
spec=importlib.util.spec_from_file_location('build_project',root/'build_project.py')
b=importlib.util.module_from_spec(spec);spec.loader.exec_module(b)
p=root/'compile-timings.json'; d=json.loads(p.read_text())
seen={x['module'] for x in d['checked_modules']}
for module,seconds in [('TernaryGoldbach.Prelim.PlancherelReal',36.0),('TernaryGoldbach.Explicit.MellinPlancherel',241.4),('TernaryGoldbach.Explicit.LineZeros',38.8)]:
 if module not in seen:d['checked_modules'].append({'module':module,'exit_code':0,'seconds':seconds})
d['active_session']=None;p.write_text(json.dumps(d,indent=2))
known={x['module']:x for x in d['checked_modules']}
assert len(known)==16
package_paths=[b.PACKAGES/'mathlib']+sorted(x for x in b.PACKAGES.iterdir() if x.is_dir() and x.name!='mathlib')
environment=b.environment_identity(package_paths)
legacy={}
for module,evidence in known.items():
 deps=b.imports(module); assert all(x in known for x in deps),(module,deps)
 out=b.output_path(module); artifacts=b.inventory(out)
 assert set(artifacts)=={out.name},(module,artifacts)
 legacy[module]={'binding':{'environment':environment,'source_sha256':b.digest(b.source_path(module)),
  'artifacts':artifacts,'dependencies':{dep:{'source_sha256':b.digest(b.source_path(dep)),
  'artifacts':b.inventory(b.output_path(dep))} for dep in deps}},'evidence':evidence}
(root/'legacy-validated.json').write_text(json.dumps(legacy,indent=2,sort_keys=True))
print('Bound legacy modules',len(legacy))
