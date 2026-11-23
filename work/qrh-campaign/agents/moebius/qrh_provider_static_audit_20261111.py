"""Read-only source traversal/token inventory, NOT Lean elaboration or axiom closure.
Writes only this script's adjacent JSON. Resolves the prepared Lean4.35 source graph.
"""
from pathlib import Path
import re,json,hashlib,collections,subprocess
HERE=Path(__file__).resolve().parent; ROOT=HERE.parents[3]
PACK=Path('C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages')
CORE=Path('C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean')
CUSTOM={'OAI':ROOT/'work/openai-math/lean',
 'PrimeNumberTheoremAnd':ROOT/'work/qrh-dependencies/PrimeNumberTheoremAnd',
 'RellichKondrachov':ROOT/'work/qrh-dependencies/rellich-kondrachov'}
BASE=[p for p in PACK.iterdir() if p.is_dir()]+[CORE,CORE/'lake']
TARGET='OAI.NumberTheory.DirichletL.Nonvanishing'

def cleaned(src):
    # Preserve positions/line numbers. Nested Lean comments and escaped strings.
    out=list(src);i=0;depth=0;string=False
    while i<len(src):
        if depth:
            if src.startswith('/-',i):depth+=1;out[i:i+2]=[' ',' '];i+=2;continue
            if src.startswith('-/',i):depth-=1;out[i:i+2]=[' ',' '];i+=2;continue
            if src[i]!='\n':out[i]=' '
            i+=1;continue
        if string:
            if src[i]=='\\':
                out[i]=' ';i+=1
                if i<len(src) and src[i]!='\n':out[i]=' '
                i+=1;continue
            if src[i]=='"':string=False
            if src[i]!='\n':out[i]=' '
            i+=1;continue
        if src.startswith('/-',i):depth=1;out[i:i+2]=[' ',' '];i+=2;continue
        if src.startswith('--',i):
            end=src.find('\n',i)
            if end<0:end=len(src)
            out[i:end]=[' ']*(end-i);i=end;continue
        if src[i]=="'":
            char=re.match(r"'(?:\\(?:u[0-9a-fA-F]{4}|x[0-9a-fA-F]{2}|.)|[^'\\\n])'",src[i:])
            if char:
                end=i+len(char[0]);out[i:end]=[' ']*(end-i);i=end;continue
        if src[i]=='r':
            raw=re.match(r'r(#+)"',src[i:])
            if raw:
                end=src.find('"'+raw[1],i+len(raw[0]))
                if end>=0:
                    end+=1+len(raw[1])
                    out[i:end]=['\n' if c=='\n' else ' ' for c in src[i:end]]
                    i=end;continue
        if src[i]=='"':string=True;out[i]=' '
        i+=1
    return ''.join(out),{'unterminated_block_comment':depth!=0,'unterminated_string':string}

def resolve(module):
    rel=Path(*module.split('.')).with_suffix('.lean')
    prefix=module.split('.')[0]
    roots=[CUSTOM[prefix]] if prefix in CUSTOM else BASE
    matches=[(root/rel).resolve() for root in roots if (root/rel).is_file()]
    assert len(matches)<=1,(module,list(map(str,matches)))
    return matches[0] if matches else None

WATCH=['axiom','axioms','constant','opaque','sorry','admit','sorryAx','mkSorry','mkSyntheticSorry',
 'native_decide','ofReduceBool','ofReduceNat','unsafe','implemented_by','extern',
 'initialize','builtin_initialize','elab','elab_rules','macro','macro_rules',
 'run_tac','run_elab','addDecl','addAndCompile','trustLevel',
 'native','nativeEqTrue','bv_decide','axiomDecl','unsafeCast']
watch=re.compile(r'(?<![\w\u0080-\uffff])('+'|'.join(WATCH)+r')(?![\w\u0080-\uffff])')
imports_re=re.compile(r'^\s*(?:(?:public|private|meta)\s+)*import\s+(.*)$',re.M)
seen={};unresolved={};queue=[TARGET];scan_warnings=[];hits=[];parents={TARGET:None}
while queue:
    module=queue.pop()
    if module in seen or module in unresolved:continue
    path=resolve(module)
    if path is None:unresolved[module]=parents.get(module);continue
    data=path.read_bytes();src=data.decode('utf-8-sig');code,warnings=cleaned(src)
    if any(warnings.values()):scan_warnings.append({'module':module,**warnings})
    imports=[]
    for match in imports_re.finditer(code):
        names=match[1].split()
        for name in names:
            if name=='all':continue
            if not re.fullmatch(r'[\w\u0080-\uffff]+(?:\.[\w\u0080-\uffff]+)*',name):
                scan_warnings.append({'module':module,'unparsed_import_token':name})
            else:imports.append(name)
    implicit=not re.search(r'^\s*prelude\b',code,re.M)
    if implicit:imports.append('Init')
    seen[module]={'path':str(path),'sha256':hashlib.sha256(data).hexdigest(),
                  'bytes':len(data),'imports':sorted(set(imports)),'implicit_Init':implicit}
    if len(seen)%2000==0:print('Resolved source modules:',len(seen),flush=True)
    for dep in imports:
        parents.setdefault(dep,module);queue.append(dep)
    lines=src.splitlines()
    for match in watch.finditer(code):
        line=src.count('\n',0,match.start())+1
        hits.append({'module':module,'line':line,'token':match[1],
                     'source_line':lines[line-1].strip()[:500],
                     'custom_provider_or_patched_external':module.split('.')[0] in CUSTOM})
    for match in re.finditer(r'^\s*set_option\s+([^\s]+)\s+([^\n]+)',code,re.M):
        if module.split('.')[0] in CUSTOM:
            line=src.count('\n',0,match.start())+1
            hits.append({'module':module,'line':line,'token':'set_option',
              'source_line':lines[line-1].strip()[:500],'custom_provider_or_patched_external':True})

def git_read(root,*args):
    p=subprocess.run(['git','-c','safe.directory='+str(root),'-C',str(root),*args],
                     capture_output=True,text=True,encoding='utf-8')
    return {'exit':p.returncode,'stdout':p.stdout.strip(),'stderr':p.stderr.strip()}
counts=collections.Counter(m.split('.')[0] for m in seen)
custom_hits=[h for h in hits if h['custom_provider_or_patched_external']]
out={'scope':'Static prepared4.35 recursive source inventory, not original4.34 build or elaborated axiom closure',
 'target':TARGET,'roots':{**{k:str(v.resolve()) for k,v in CUSTOM.items()},'baseline_packages':str(PACK),'core':str(CORE)},
 'source_count':len(seen),'counts_by_prefix':dict(sorted(counts.items())),
 'custom_count':sum(counts[k] for k in CUSTOM),'unresolved_imports':unresolved,
 'lexical_warnings':scan_warnings,'token_counts':dict(collections.Counter(h['token'] for h in hits)),
 'custom_token_counts':dict(collections.Counter(h['token'] for h in custom_hits)),
 'custom_hits':custom_hits,'all_hits':hits,'modules':dict(sorted(seen.items())),
 'pins':{'OAI':git_read(ROOT/'work/openai-math','rev-parse','HEAD'),
         'OAI_status':git_read(ROOT/'work/openai-math','status','--short'),
         'Mathlib':git_read(PACK/'mathlib','rev-parse','HEAD')},
 'standard_axiom_allowlist_proved':False,'elaborated_export_axioms_checked':False,
 'caveats':['Lexer is not the Lean parser; metaprograms may create declarations.',
            'Import closure is not proof-term dependency closure.',
            'Core axioms, tactical sorry constructors and unsafe runtime code require context.',
            'No compiler, Lake, package mutation or original4.34 olean was used.']}
HERE.joinpath('qrh_provider_static_audit_20261111.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({k:out[k] for k in ['source_count','counts_by_prefix','custom_count','unresolved_imports','lexical_warnings','token_counts','custom_token_counts','pins']},indent=2))
