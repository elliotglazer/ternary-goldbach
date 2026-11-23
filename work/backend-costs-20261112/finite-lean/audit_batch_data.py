"""Independently parse the generated Lean literals and compare the source fixture."""
import functools
import hashlib
import json
import re
from pathlib import Path
H=Path(__file__).resolve().parent
text=(H/'BatchData1024.lean').read_text(encoding='utf-8')
fixture=json.loads((H/'fixture1024.json').read_text())
coverage=json.loads((H.parent/'finite-hol/cover_fixture.json').read_text())
trees=dict(re.findall(r'^def (\w+) : BatchPrime.Tree := (.+)$',text,re.M))
@functools.cache
def named(name):
    tokens=re.findall(r'BatchPrime\.Tree\.\w+|\w+|[()\[\],]',trees[name]);pos=0
    def read():
        nonlocal pos
        token=tokens[pos];pos+=1
        if token=='(':
            t=read();assert tokens[pos]==')';pos+=1;return t
        if token=='BatchPrime.Tree.empty':return None
        if token=='BatchPrime.Tree.node':
            left=read();p=int(tokens[pos]);a=int(tokens[pos+1]);pos+=2
            assert tokens[pos]=='[';pos+=1;fs=[]
            while tokens[pos]!=']':
                fs.append(int(tokens[pos]));pos+=1
                if tokens[pos]==',':pos+=1
            pos+=1;right=read()
            return left,p,a,fs,right
        assert token in trees,token
        return named(token)
    result=read();assert pos==len(tokens)
    return result
rows=[]
def flatten(t):
    if t is None:return
    l,p,a,fs,r=t;flatten(l);rows.append((p,a,fs));flatten(r)
flatten(named('certificates'))
expected=[(c['prime'],c['base'] or 0,[q for q,e in c['factors'] for _ in range(e)])
          for c in sorted(fixture['certificates'],key=lambda c:c['prime'])]
assert rows==expected and len(rows)==1537
lists=dict(re.findall(r'^def (\w+) : List (?:Nat|\(Nat × Nat\)) := (.+)$',text,re.M))
@functools.cache
def resolve_list(name):
    rhs=lists[name]
    if ' ++ ' in rhs:
        left,right=rhs.split(' ++ ');return resolve_list(left)+resolve_list(right)
    if not rhs.startswith('['):return resolve_list(rhs)
    if name.startswith('witnesses'):
        return [list(map(int,pair)) for pair in re.findall(r'\((\d+), (\d+)\)',rhs)]
    return list(map(int,re.findall(r'\d+',rhs)))
assert resolve_list('roots')==fixture['roots']
assert resolve_list('witnesses')==coverage['witnesses']
for name,value in [('target',fixture['target']),('endExclusive',fixture['end_exclusive'])]:
    assert int(re.search(rf'^def {name} : Nat := (\d+)$',text,re.M)[1])==value
result=dict(passed=True,certificate_nodes=1537,expanded_factors=sum(len(fs) for _,_,fs in rows),
            root_primes=len(fixture['roots']),witnesses=len(coverage['witnesses']),
            source_sha256=hashlib.sha256((H/'BatchData1024.lean').read_bytes()).hexdigest())
(H/'BATCH_DATA_AUDIT.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result))
