"""Read-only selected-file inventory; lexical aid, not a Lean parser."""
from pathlib import Path
import subprocess,json,re,hashlib,difflib
ROOT=Path(__file__).resolve().parents[4]
BASE=ROOT/'work/qrh-dependencies'
HERE=Path(__file__).resolve().parent

def clean(s):
    out=[];i=0;depth=0;string=False
    while i<len(s):
        if depth:
            if s.startswith('/-',i):depth+=1;i+=2
            elif s.startswith('-/',i):depth-=1;i+=2
            else:
                if s[i]=='\n':out.append('\n')
                i+=1
        elif string:
            out.append(s[i])
            if s[i]=='\\' and i+1<len(s):out.append(s[i+1]);i+=2;continue
            if s[i]=='"':string=False
            i+=1
        elif s.startswith('/-',i):depth=1;i+=2
        elif s.startswith('--',i):
            p=s.find('\n',i);i=len(s) if p<0 else p
        else:
            if s[i]=='"':string=True
            out.append(s[i]);i+=1
    return ''.join(out)

def splitter(s):
    depth=0;string=False;i=0
    while i<len(s):
        c=s[i]
        if c=='"':string=not string
        if not string:
            if c in '([{⟨':depth+=1
            elif c in ')]}⟩':depth-=1
            if depth==0 and s.startswith(':=',i):return s[:i],s[i+2:]
            if depth==0 and s.startswith('where',i) and (i==0 or s[i-1].isspace()):return s[:i],s[i:]
        i+=1
    return s,''

def norm(s):
    s=re.sub(r'\blemma\b','theorem',s)
    return re.sub(r'\s+','',s)

def decls(s):
    s=clean(s);pat=re.compile(r'(?m)^[ \t]*(?:@\[[^\]\n]*\]\s*)*(?:(?:private|noncomputable|protected|local)\s+)*(def|abbrev|structure|class|instance|theorem|lemma)\s+([^\s(:{\[]*)')
    ms=list(pat.finditer(s));out={}
    for i,m in enumerate(ms):
        text=s[m.start():ms[i+1].start() if i+1<len(ms) else len(s)]
        head,body=splitter(text);name=m.group(2) or f'@anonymous:{i}'
        out[name]={'kind':m.group(1),'header':head.strip(),'body':body.strip(),'line':s[:m.start()].count('\n')+1}
    return out

def main():
    manifest=json.loads((BASE/'patched-module-closure.json').read_text(encoding='utf-8'));rows=[]
    assert hashlib.sha256((BASE/'patched-module-closure.json').read_bytes()).hexdigest().upper()=='387D6B1CDA595A0811BB9C8C23CBAEECA44D0EDA82602C54FCCC0B734645945D'
    for prov in manifest['provenance']:
        repo=BASE/prov['name']
        assert subprocess.check_output(['git','rev-parse','HEAD'],cwd=repo).decode().strip()==prov['commit']
        assert hashlib.sha256((BASE/(prov['name']+'-lean4341.patch')).read_bytes()).hexdigest()==prov['patch_sha256']
    for mod,pp in manifest['modules'].items():
        p=Path(pp);repo=BASE/('PrimeNumberTheoremAnd' if mod.startswith('Prime') else 'rellich-kondrachov');rel=p.relative_to(repo).as_posix()
        original=subprocess.check_output(['git','show','HEAD:'+rel],cwd=repo).decode('utf-8')
        patched=p.read_text(encoding='utf-8');a,b=decls(original),decls(patched)
        changed=[]
        for name in sorted(a.keys()|b.keys()):
            old=a.get(name);new=b.get(name)
            if old is None:changed.append({'name':name,'change':'added','new':new})
            elif new is None:changed.append({'name':name,'change':'removed','old':old})
            elif norm(old['header'])!=norm(new['header']):changed.append({'name':name,'change':'header','old':old,'new':new})
            elif new['kind'] in ('def','abbrev','structure','class','instance') and norm(old['body'])!=norm(new['body']):changed.append({'name':name,'change':'data_body','old':old,'new':new})
        oldimports=re.findall(r'^import (.+)$',clean(original),re.M)
        newimports=re.findall(r'^import (.+)$',clean(patched),re.M)
        markers=re.findall(r'\b(?:axiom|sorry|admit|unsafe|opaque|syntax|macro|elab|run_cmd|initialize|implemented_by|native_decide)\b',clean(patched))
        assert not markers
        rows.append({'module':mod,'path':str(p),'pristine_sha256':hashlib.sha256(original.encode()).hexdigest(),'patched_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),
                     'old_imports':oldimports,'new_imports':newimports,'selected_marker_hits':markers,
                     'original_declarations':len(a),'patched_declarations':len(b),'changes':changed})
    byname={r['module']:r for r in rows};seen=set()
    def visit(name):
        if name.startswith('Mathlib.'):return
        assert name in byname,name
        if name in seen:return
        seen.add(name)
        for dep in byname[name]['new_imports']:visit(dep)
    visit('PrimeNumberTheoremAnd.Wiener')
    visit('RellichKondrachov.Analysis.FunctionalSpaces.Sobolev.Euclidean.Rellich')
    assert seen==set(byname) and len(seen)==19
    out=HERE/'review_external_patch_inventory_20261111.json';out.write_text(json.dumps(rows,indent=2,ensure_ascii=False)+'\n',encoding='utf-8')
    for row in rows:
        print(row['module'],row['original_declarations'],row['patched_declarations'])
        for c in row['changes']:
            print(' ',c['change'],c['name'])
    print('Lexical aid only; manually inspect context, instances, attributes, imports and command boundaries.')

if __name__=='__main__':main()
