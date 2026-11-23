from pathlib import Path
import json,ast,hashlib,tempfile,types
p=Path(__file__).resolve().parent;source=p.parent/'small-prefix/contiguous-extension/extend.py'
tree=ast.parse(source.read_text());verify=next(v for v in tree.body if isinstance(v,ast.FunctionDef) and v.name=='verify')
condition=next(n.test for n in ast.walk(verify) if isinstance(n,ast.If) and 'olean_sha256' in ast.unparse(n.test))
compiled=compile(ast.Expression(condition),str(source),'eval')
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
res={}
with tempfile.TemporaryDirectory(dir=p) as tmp:
    t=Path(tmp);mod='Probe';s=t/(mod+'.lean');o=t/(mod+'.olean');dep=t/'Common.olean'
    s.write_text('original source');o.write_text('original object');dep.write_text('first dependency')
    record=dict(exit=0,source_sha256=sha(s),olean_sha256=sha(o));scope=dict(HERE=t,mod=mod,receipt=record,check=types.SimpleNamespace(sha=sha))
    def probe(name):
        try:res[name]=eval(compiled,{'__builtins__':{}},scope)
        except FileNotFoundError:res[name]='FileNotFoundError'
    probe('complete');dep.write_text('changed dependency');probe('dependency_changed')
    s.write_text('altered source');probe('source_changed');s.write_text('original source')
    o.write_text('altered olean');probe('olean_changed');o.unlink();probe('olean_missing')
assert res==dict(complete=True,dependency_changed=True,source_changed=False,olean_changed=False,olean_missing='FileNotFoundError')
(p/'restart-controls.json').write_text(json.dumps(dict(producer_sha=sha(source),tested_predicate=ast.unparse(condition),results=res),indent=2))
print(res)
