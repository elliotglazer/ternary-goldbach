"""AST and file hashes only. Never import or execute either evaluator."""
from pathlib import Path
import ast, hashlib, json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
FILES={
 'integration/small_em_batch_candidate_20261111.py':'23D358590279AA810EAE764D3FEEA0756C51DF8CF0EA6F05B457A192BB82822C',
 'integration/SMALL_EM_BATCH_CODE_PREPARATION_2026-11-11.md':'65379869F849BB27BE9DF4974F73984269FECF1C408C442D2C772BFF37E53500',
 'integration/small_em_batch_preparation_check_20261111.json':'43B8EC0D5481770B258F42463BD579AE4470103DBC2AAB667EB3432BC9F5D13B',
 'independent-feasibility/review_small_em_batch_prepared_20261111.py':'A6F6A8C78B4DC70F657564D19398ADF2E9F8922B005969B7ABAAA62BFBBC5A9A',
 'independent-feasibility/SMALL_EM_BATCH_INDEPENDENT_CODE_PREPARATION_2026-11-11.md':'2619FCF789FA8CF3592B26CFBB5612A2E3C7D3D54086A3FA142238F443A848DF',
 'independent-feasibility/review_small_em_batch_prepared_syntax_20261111.json':'044F499982B25A36D40AE8F8CA3B34F2D4C97C5158240D7804420A204AA08D33'}
def sha(p):return hashlib.sha256(p.read_bytes()).hexdigest().upper()
def require(x,msg):
    if not x:raise ValueError(msg)
def literal(tree,name):
    node=next(n for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id==name for t in n.targets))
    return ast.literal_eval(node.value)

def main():
    inputs=[];trees={};pins_by_file={};analyses=[]
    for name,pin in FILES.items():
        p=AGENTS/name;actual=sha(p);require(actual==pin,'artifact changed: '+name)
        inputs.append({'path':name,'sha256':actual})
        if p.suffix!='.py':continue
        tree=ast.parse(p.read_text(encoding='utf8'),filename=str(p));trees[name]=tree
        # Compilation creates an unexecuted code object; no module globals run.
        compile(tree,str(p),'exec')
        pins=literal(tree,'PINS');pins_by_file[name]=pins
        for rel,h in pins.items(): require(sha(AGENTS/rel)==h,'source pin: '+rel)
        imports=[]
        for n in ast.walk(tree):
            if isinstance(n,ast.Import):imports += [(a.name,n.lineno) for a in n.names]
            elif isinstance(n,ast.ImportFrom):imports.append((n.module,n.lineno))
        forbidden={'subprocess','multiprocessing','threading','concurrent','importlib'}
        require(not any((m or '').split('.')[0] in forbidden for m,_ in imports),'unexpected delegation/dynamic import')
        calls=[n for n in ast.walk(tree) if isinstance(n,ast.Call)]
        bad={'zeta','hurwitz_zeta','gamma','theta','riemann_siegel','find_zeros'}
        require(not any(isinstance(n.func,ast.Attribute) and n.func.attr in bad for n in calls),'forbidden numerical oracle')
        require(not any(isinstance(n.func,ast.Name) and n.func.id in ('eval','exec','__import__') for n in calls),'dynamic execution')
        top_imports=[n for n in tree.body if isinstance(n,(ast.Import,ast.ImportFrom))]
        require(not any(isinstance(n,ast.Import) and any(a.name=='flint' for a in n.names) or
                        isinstance(n,ast.ImportFrom) and n.module=='flint' for n in top_imports),'eager FLINT import')
        analyses.append({'path':name,'syntax':'PASS','source_pin_count':len(pins),
                         'imports':[{'module':m,'line':line} for m,line in imports],
                         'evaluator_imported':False,'evaluator_executed':False})
    prod='integration/small_em_batch_candidate_20261111.py'
    independent='independent-feasibility/review_small_em_batch_prepared_20261111.py'
    required=literal(trees[independent],'PRODUCER_PIN_KEYS')
    require({k:pins_by_file[independent][k] for k in required}==pins_by_file[prod],'complete producer pin schema')
    result={'status':'PASS_STATIC_SYNTAX_HASH_AND_IMPORT_CHECKS_ONLY','inputs':inputs,
            'analyses':analyses,'producer_pin_dictionary_matches_independent':True,
            'numerical_evaluations':False,'behavioral_or_runtime_tests':False,
            'review_script_sha256':sha(Path(__file__))}
    output=HERE/'check_small_em_batch_static_20261111.json'
    output.write_text(json.dumps(result,indent=2)+'\n',encoding='utf8',newline='\n')
    print(json.dumps({'status':result['status'],'source_pin_counts':[a['source_pin_count'] for a in analyses],
                      'receipt_sha256':sha(output)}))
if __name__=='__main__':main()
