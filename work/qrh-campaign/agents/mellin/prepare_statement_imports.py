from pathlib import Path
import hashlib,json
here=Path(__file__).resolve().parent
context={'__file__':str(here/'prepare_eisenstein_imports.py')}
exec((here/'prepare_eisenstein_imports.py').read_text().split('public_closures =')[0],context)
closure=context['closure']
root='Mathlib.NumberTheory.LSeries.DirichletContinuation'
providers=['Mathlib.Data.Nat.Prime.Defs','Mathlib.Algebra.Ring.Parity','Mathlib.NumberTheory.DirichletCharacter.Basic']
public=closure([root],True)
source=here.parents[3]/'work/ternary-goldbach/TernaryGoldbach/Statement.lean'
b=source.read_bytes(); offset=b.index(b'/-!'); body=b[offset:]
candidate=here/'Statement.lean'; candidate.write_bytes(('import '+root+'\n\n').encode()+body)
consumer=['Mathlib.Analysis.SpecialFunctions.Integrals.Basic','Mathlib.MeasureTheory.Integral.DominatedConvergence','Mathlib.Analysis.Normed.Group.FunctionSeries','Mathlib.Analysis.Real.Sqrt','Mathlib.Tactic.FunProp','Mathlib.Tactic.Ring','Mathlib.Tactic.Positivity','Mathlib.Tactic.Linarith','Mathlib.Tactic.FieldSimp','Mathlib.Tactic.Push','Mathlib.Tactic.SplitIfs']
m={'source':str(source),'candidate':str(candidate),'imports':[root],'providers_publicly_reachable':{p:p in public for p in providers},'body_includes_module_docstring':True,'body_bytes_equal':candidate.read_bytes().split(b'/-!',1)[1]==b.split(b'/-!',1)[1],'source_sha256':hashlib.sha256(b).hexdigest(),'candidate_sha256':hashlib.sha256(candidate.read_bytes()).hexdigest(),'body_sha256':hashlib.sha256(body).hexdigest(),'candidate_all_import_closure_count':len(closure([root],False)),'circle_method_review_providers_reachable':{p:p in public for p in consumer},'circle_method_core_tactic_provider':'Lean.Elab.Tactic.NormCast; this scanner does not recursively inspect core Lean modules','compiled':False,'performance_measured':False}
(here/'statement-import-manifest.json').write_text(json.dumps(m,indent=2)+'\n')
print(json.dumps(m,indent=2))
