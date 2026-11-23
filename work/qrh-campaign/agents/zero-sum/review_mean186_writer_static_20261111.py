"""Static source inspection only. Does not import or execute either writer."""
import ast
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
FILES={
 'major-constants/mean186_exact_tensor_assignment_20261111.py':'0E50324BFB8E2C823479D4D585F547774CF0FBD9C7535B2E66D961CE23814A5C',
 'major-constants/mean186_exact_tensor_assignment_20261111_v2.py':'CCDAA894518AD2FFFA73F8B1504C09B6DDE9F422F92831D5BD19C10F1D7D057D',
 'major-constants/MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'D804D1A6CEBBDB812A35132CC05A79B9FA8A6B3D510CCF49A9ACCFCC588F1A64',
 'zero-sum/REVIEW_MEAN186_EXACT_TENSOR_ASSIGNMENT_PREFLIGHT_2026-11-11.md':'4BCA651C7D6914243BF3F8D6BA21172B0C0E7FA8C5C750D7FB25F703A9DAAD25',
}
checks=[]
def ck(name,condition):
 if not condition:raise AssertionError(name)
 checks.append(name)
texts={};pins=[]
for name,pin in FILES.items():
 with (AGENTS/name).open('rb') as stream:data=stream.read(128*1024+1)
 ck('bounded source '+name,len(data)<=128*1024)
 digest=hashlib.sha256(data).hexdigest().upper()
 ck('pin '+name,digest==pin)
 texts[name]=data.decode('utf-8-sig')
 pins.append({'path':name,'bytes':len(data),'sha256':digest})
old=ast.parse(texts[list(FILES)[0]])
new=ast.parse(texts[list(FILES)[1]])
ck('both writer sources parse as AST',isinstance(old,ast.Module) and isinstance(new,ast.Module))
def assignments(tree):
 return {x.targets[0].id:x.value for x in tree.body if isinstance(x,ast.Assign) and len(x.targets)==1 and isinstance(x.targets[0],ast.Name)}
a=assignments(old);b=assignments(new)
for key in ('PINS','SUPPORT','OLD_CONTRACT','NAMES','INPUT_OLD_HASH','KERNEL_OLD_HASH','CG'):
 ck('unchanged literal '+key,ast.dump(a[key])==ast.dump(b[key]))
pins_literal=ast.literal_eval(b['PINS'])
ck('seven JSON inputs',len(pins_literal)==7 and all(k.endswith('.json') for k in pins_literal))
ck('literal byte total',sum(v[0] for v in pins_literal.values())==39456593)
ck('literal byte caps',max(v[0] for v in pins_literal.values())<32*2**20 and sum(v[0] for v in pins_literal.values())<64*2**20)
ck('four exclusive destination stems',ast.literal_eval(b['NAMES'])==[
 ('mean186_exact_tensor_rows_20261111.json',3),('mean186_exact_tensor_node_masks_20261111.json',3),
 ('mean186_exact_tensor_kernel_masks_20261111.json',2),('mean186_exact_tensor_summary_20261111.json',1)])
old_funcs={x.name:x for x in old.body if isinstance(x,ast.FunctionDef)}
new_funcs={x.name:x for x in new.body if isinstance(x,ast.FunctionDef)}
ck('same top-level function set',old_funcs.keys()==new_funcs.keys())
for name in old_funcs:
 if name!='main':ck('unchanged helper '+name,ast.dump(old_funcs[name])==ast.dump(new_funcs[name]))
main=new_funcs['main']
read_indices=[]
for node in ast.walk(main):
 if isinstance(node,ast.Call) and isinstance(node.func,ast.Name) and node.func.id=='read':
  arg=node.args[0]
  ck('read is fixed PINS index',isinstance(arg,ast.Subscript) and ast.unparse(arg.value)=='list(PINS)' and isinstance(arg.slice,ast.Constant))
  read_indices.append(arg.slice.value)
ck('each index once',sorted(read_indices)==list(range(7)))
for forbidden in ('exec','eval','compile','__import__'):
 ck('no direct '+forbidden,not any(isinstance(n,ast.Call) and isinstance(n.func,ast.Name) and n.func.id==forbidden for n in ast.walk(new)))
text=texts[list(FILES)[1]]
for expression in ('range(50,po-4)','rho*gap+186*St*T','c*CG**2*gap**2-phi**2*W**2*2**(2*(108-p))',
 'chosen<=po-5<=100','masks[n]>>51==0','count<=51 and tests<=6395400',
 "with (HERE/name).open('xb') as f:","WRITTEN.append(name)"):
 ck('selected static expression '+expression,expression in text)
for key in ('CURRENT_ARTIFACT','CURRENT_CAP','CURRENT_ENCODED_BYTES','CURRENT_SERIALIZATION_STAGE','CURRENT_STAGE_CAP'):
 ck('context initialized '+key,isinstance(b[key],ast.Constant) and b[key].value is None)
for keyword in ('current_artifact','current_artifact_cap_bytes','current_encoded_bytes','encoded_bytes_scope','current_stage_cap_bytes'):
 ck('failure output includes '+keyword,any(isinstance(n,ast.keyword) and n.arg==keyword for n in ast.walk(new)))
ck('unknown bytes reset before serialization',text.count('CURRENT_ENCODED_BYTES=None')==4)
ck('writer never executed here',True)
result={'scope':'AST/hash/text inspection of frozen writer source only','checks':len(checks),'check_names':checks,
 'pins':pins,'read_input_indices':read_indices,'inventory_json_read':False,'writer_imported_or_executed':False,
 'first_version_clearance':'withheld: serialization failure context incomplete',
 'successor_execution_authorized':False}
encoded=(json.dumps(result,indent=2)+'\n').encode()
assert len(encoded)<64*1024
with (HERE/'review_mean186_writer_static_20261111.json').open('xb') as stream:stream.write(encoded)
print(json.dumps({'checks':len(checks),'bytes':len(encoded),'sha256':hashlib.sha256(encoded).hexdigest().upper()}))
