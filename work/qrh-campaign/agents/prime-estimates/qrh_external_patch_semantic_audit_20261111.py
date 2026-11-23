"""Read-only selected-closure patch reconstruction and source-header inventory.

This is not a Lean parser, elaborator, or proof checker. It writes only new
adjacent audit evidence. All upstream bytes are read from pinned Git objects.
"""
from pathlib import Path
from collections import deque
from hashlib import sha256
import subprocess,json,re,difflib

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[2]
DEP=ROOT/'qrh-dependencies'
MAN=DEP/'patched-module-closure.json'
H=lambda b:sha256(b).hexdigest().upper()
def git(p,*args):return subprocess.check_output(['git','-C',str(p),*args])

def clean(s):
    out=[];i=0;depth=0;string=False
    while i<len(s):
        if depth:
            if s.startswith('/-',i):depth+=1;out.extend('  ');i+=2
            elif s.startswith('-/',i):depth-=1;out.extend('  ');i+=2
            else:out.append('\n' if s[i]=='\n' else ' ');i+=1
        elif string:
            if s[i]=='\\':out.extend('  ');i+=2
            elif s[i]=='"':string=False;out.append(' ');i+=1
            else:out.append('\n' if s[i]=='\n' else ' ');i+=1
        elif s.startswith('/-',i):depth=1;out.extend('  ');i+=2
        elif s.startswith('--',i):
            j=s.find('\n',i);j=len(s) if j<0 else j
            out.extend(' '*(j-i));i=j
        elif s[i]=='"':string=True;out.append(' ');i+=1
        else:out.append(s[i]);i+=1
    assert not depth and not string
    return ''.join(out)

def declarations(s):
    s=clean(s);out=[]
    pat=r'(?m)^(?:@\[[^\n]*\]\s*)?(?:(?:private|protected|noncomputable|local)\s+)*(theorem|lemma|def|abbrev|structure|class|instance|inductive)\s+([^\s:({\[]*)'
    for m in re.finditer(pat,s):
        e=m.end();depth=0
        while e<len(s):
            if depth==0 and (s.startswith(':=',e) or re.match(r'where\b',s[e:e+8])):break
            if s[e] in '({[':depth+=1
            elif s[e] in ')}]':depth-=1
            e+=1
        out.append({'kind':m[1],'name':m[2] or '<anonymous>','line':s.count('\n',0,m.start())+1,
                    'header':' '.join(s[m.start():e].split())})
    return out

def reconstruct(old,part):
    lines=old.decode().splitlines();output=[];cursor=0
    pl=part.splitlines();i=0;hunks=0
    while i<len(pl):
        match=re.match(r'@@ -(\d+)(?:,(\d+))? \+(\d+)(?:,(\d+))? @@',pl[i])
        if not match:i+=1;continue
        start=int(match[1])-1;start=max(start,0)
        assert cursor<=start
        output.extend(lines[cursor:start]);cursor=start;i+=1;hunks+=1
        while i<len(pl) and not pl[i].startswith('@@'):
            l=pl[i]
            if l.startswith('diff --git'):break
            if l.startswith('\\ No newline'):i+=1;continue
            if not l or l[0] not in ' +-':break
            if l[0] in ' -':assert lines[cursor]==l[1:],(cursor,l);cursor+=1
            if l[0] in ' +':output.append(l[1:])
            i+=1
    output.extend(lines[cursor:])
    return '\n'.join(output)+'\n',hunks

def main():
    manifest=json.loads(MAN.read_text());rows=[];diffs=[];projects=[]
    for prov in manifest['provenance']:
        p=DEP/prov['name'];commit=prov['commit'];patch=DEP/(prov['name']+'-lean4341.patch')
        pb=patch.read_bytes();assert H(pb)==prov['patch_sha256'].upper()
        provider_path='lean/patches/'+patch.name
        provider_pin='4eaee87548250b2682affda7d05d947c05554bae'
        provider_bytes=git(ROOT/'openai-math','cat-file','blob',provider_pin+':'+provider_path)
        assert provider_bytes==pb
        assert git(p,'rev-parse','HEAD').decode().strip()==commit
        parts=re.split(r'(?m)(?=^diff --git )',pb.decode())
        lookup={re.search(r'^diff --git a/(.*?) b/(.*?)$',part,re.M)[2]:part for part in parts if part.startswith('diff --git')}
        projects.append({**prov,'patch_bytes':len(pb),'total_patch_file_sections':len(lookup),
                         'provider_commit':provider_pin,'provider_patch_path':provider_path,
                         'stored_patch_equals_provider_blob':True})
        for module,path in manifest['modules'].items():
            actual=Path(path)
            if not actual.is_relative_to(p):continue
            rel=actual.relative_to(p).as_posix();old=git(p,'cat-file','blob',commit+':'+rel);new=actual.read_bytes()
            reconstructed,nh=reconstruct(old,lookup[rel])
            ns=new.decode().replace('\r\n','\n');os=old.decode().replace('\r\n','\n')
            assert reconstructed==ns,rel
            od=declarations(os);nd=declarations(ns)
            om={x['name']:x for x in od if x['name']!='<anonymous>'};nm={x['name']:x for x in nd if x['name']!='<anonymous>'}
            changed=[{'name':n,'before':om[n],'after':nm[n]} for n in sorted(om.keys()&nm.keys()) if om[n]['header']!=nm[n]['header']]
            rows.append({'module':module,'relative_path':rel,'actual_path':str(actual),'commit':commit,
                         'pristine_sha256':H(old),'prepared_sha256':H(new),'prepared_lf_sha256':H(ns.encode()),
                         'patch_section_sha256':H(lookup[rel].encode()),'hunks':nh,'reconstructs_exact_lf':True,
                         'before_declarations':od,'after_declarations':nd,'changed_named_headers':changed,
                         'removed_named':[om[n] for n in sorted(om.keys()-nm.keys())],
                         'added_named':[nm[n] for n in sorted(nm.keys()-om.keys())],
                         'before_imports':re.findall(r'(?m)^import (.+)$',clean(os)),
                         'after_imports':re.findall(r'(?m)^import (.+)$',clean(ns))})
            diffs.extend(difflib.unified_diff(os.splitlines(True),ns.splitlines(True),fromfile=commit+':'+rel,tofile=str(actual)))
    assert len(rows)==19
    static_path=HERE.parent/'moebius/qrh_provider_static_audit_20261111.json'
    static=json.loads(static_path.read_text(encoding='utf-8'))
    sm=static['modules']
    for row in rows:assert row['prepared_sha256'].lower()==sm[row['module']]['sha256'].lower()
    targets={'OAI.NumberTheory.DirichletL.'+x for x in
             ('IdealMangoldt','PrimeCounting.Progressions','CubicSieve.RadialWindows','CubicSieve.ReopenedFibers')}
    queue=deque([['OAI.NumberTheory.DirichletL.Nonvanishing']]);seen=set(queue[0]);paths=[]
    while queue:
        path=queue.popleft();name=path[-1]
        if name in targets:
            for n in path:assert H(Path(sm[n]['path']).read_bytes()).lower()==sm[n]['sha256'].lower()
            paths.append(path)
        for n in sm[name]['imports']:
            if n not in seen and n in sm:seen.add(n);queue.append(path+[n])
    assert len(paths)==4
    result={'scope':'Textual patch reconstruction and heuristic header inventory, not Lean semantics',
            'header_inventory_caveat':'Headers stop at first unbracketed assignment; let-expressions and implicit section binders require manual reading.',
            'manifest_sha256':H(MAN.read_bytes()),'projects':projects,'modules':rows,
            'static_inventory_sha256':H(static_path.read_bytes()),'verified_import_paths':paths,
            'path_note':'Import reachability only, not elaborated proof-term dependency.'}
    (HERE/'qrh_external_patch_semantic_audit_20261111.json').write_text(json.dumps(result,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
    (HERE/'qrh_external_selected_diff_20261111.txt').write_text(''.join(diffs),encoding='utf-8')
    print(json.dumps({'modules':len(rows),'hunks':sum(x['hunks'] for x in rows),'projects':projects}))
    for row in rows:
        print(row['module'], 'changed_headers',len(row['changed_named_headers']),'removed',len(row['removed_named']),'added',len(row['added_named']))

if __name__=='__main__':main()
