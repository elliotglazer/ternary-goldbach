"""Fail-closed collection of one complete run. No producer/checker is executed."""
from pathlib import Path
import hashlib,json,re,statistics,sys


def require(condition,message):
    if not condition:raise ValueError(message)


def logical_rejection(log,status):
    if status not in (1,255):return False
    if re.search(r'overflow|out of memory|allocation|killed|timeout|resource limit|cannot allocate|segmentation',log,re.I):return False
    return re.search(r'MM0_REJECT: (unify failure at (term|ref)|type mismatch|Refl unify failure)(?:\b)',log) is not None


def required_phases():
    phases={'tiny_format'}
    for n in (0,7,64):
        phases.update(f'{prefix}{n}' for prefix in ('spec','frontend_source','direct_source','frontend_compile'))
        for arm in ('direct','frontend'):
            phases.add(f'audit_{arm}{n}')
            for r in ((1,) if n==7 else range(1,6)):phases.add(f'check_{arm}{n}_{r}')
            if n!=7:phases.update((f'profile_{arm}{n}',f'highwater_{arm}{n}'))
    rejects={f'reject_{arm}_{bad}' for arm in ('direct','frontend') for bad in ('input','sign','result','proof','sign_conversion')}
    return phases,rejects


def main(label):
    p=Path(__file__).resolve().parent
    require(re.fullmatch('[A-Za-z0-9_]+',label) is not None,'bad label')
    require((p/f'{label}_RUN_COMPLETE').read_text()=='ALL_REQUIRED_PHASES_COMPLETED\n','missing terminal marker')
    required,rejects=required_phases();all_phases=required|rejects
    for suffix in ('.time','.exit','.argv'):
        actual={f.name[len(label)+1:-len(suffix)] for f in p.glob(f'{label}_*{suffix}')}
        require(actual==all_phases,f'incomplete or unexpected {suffix} inventory: {actual^all_phases}')
    for key in all_phases:require((p/f'{label}_{key}.log').is_file(),'missing log '+key)
    out={'scope':'Same64 canonical-pair signed products; no rounding, transform or analytic claim',
         'label':label,'arms':{},'processes':{},'artifacts':{},'manifests':{},
         'measurement':'Files remain on selected filesystem; no automatic tmpfs or cold-I/O claim',
         'checker':'Instrumented enlarged-capacity ordinary-rule checker, not stock-memory acceptance',
         'memory_cap':'10GiB virtual; separate from Lean/HOL4GiB experiment limits'}

    def manifest(stem,expected_names):
        path=p/(stem+'.sha256');lines=path.read_text().splitlines();seen={}
        for line in lines:
            m=re.fullmatch(r'([0-9a-fA-F]{64})  (.+)',line)
            require(m is not None,'bad hash line')
            digest,name=m.groups();resolved=(p/name).resolve()
            require(resolved not in seen,'duplicate manifest path')
            require(resolved.is_file(),'missing pinned artifact '+name)
            actual=hashlib.sha256(resolved.read_bytes()).hexdigest()
            require(actual==digest.lower(),'changed artifact '+name)
            seen[resolved]=digest.upper()
        require(set(seen)=={(p/n).resolve() for n in expected_names},'manifest membership mismatch '+stem)
        log=(p/(stem+'_unchanged.log')).read_text().splitlines()
        expected_log={line.split('  ',1)[1]+': OK' for line in lines}
        require(len(log)==len(lines) and set(log)==expected_log,'missing or failed final hash log '+stem)
        out['manifests'][stem]={str(k):v for k,v in seen.items()}

    inputs=['mmb.py','prepare.py','audit.py','unit_format.py','run.sh','summarize.py',
            '../mm0-pa/fourbit0.mmb','../mm0-pa/fourbit0.join.mm0',
            '../mm0-pa/arithmetic.mm1','../mm0-pa/arithmetic4.mm1','../mm0-pa/mm0-rs',
            '../../formal-goldbach-bench/mm0/mm0-timed',
            '../../formal-goldbach-bench/mm0/mm0-profile',
            '../../formal-goldbach-bench/mm0/mm0-highwater',
            '../../lean-pilots/batched-transform/P343N64.json']
    manifest(label+'_inputs',inputs)
    controls=[f'{arm}64_bad_{bad}.{ext}' for arm in ('direct','frontend')
              for bad,ext in [('input','mm0'),('sign','mm0'),('result','mm0'),('proof','mmb'),('sign_conversion','mmb')]]
    manifest(label+'_controls',controls)
    for n in (0,7,64):
        for arm in ('direct','frontend'):
            manifest(f'{label}_{arm}{n}_artifacts',
                     [f'{arm}{n}.mmb',f'signed{n}.mm0',f'signed{n}.mm1',
                      f'spec{n}.json',f'frontend{n}.json',f'direct{n}.json',f'{arm}{n}.audit.json'])
            audit=json.loads((p/f'{arm}{n}.audit.json').read_text())
            require(audit['kind']==arm and audit['count']==n,'audit identity')
            require(audit['sha256']==hashlib.sha256((p/f'{arm}{n}.mmb').read_bytes()).hexdigest().upper(),'audit binary mismatch')
            require(audit['exact_components'] and audit['exact_signed_conjunction'] and audit['no_sorry'],'audit not passed')
            require(len(audit['axioms'])==26,'unexpected axiom count')
            if n==64:
                expected_controls={f'{arm}64_bad_{bad}.{ext}' for bad,ext in
                    [('input','mm0'),('sign','mm0'),('result','mm0'),('proof','mmb'),('sign_conversion','mmb')]}
                require(set(audit['control_artifacts'])==expected_controls,'missing audited corruption')
                for name,meta in audit['control_artifacts'].items():
                    data=(p/name).read_bytes()
                    require(len(data)==meta['bytes'] and hashlib.sha256(data).hexdigest().upper()==meta['sha256'],'corruption changed after audit')
                require(audit['sign_conversion_corruption']['old_opcode']=='Sym' and
                        audit['sign_conversion_corruption']['new_opcode']=='Refl','wrong conversion control')
    pairs=[(0,3),(3,0),(0,0),(2,3),(-2,3),(2,-3),(-2,-3)]
    for mode in ('spec','frontend','direct'):
        receipt=json.loads((p/f'{mode}7.json').read_text())
        require([(int(r['x']),int(r['y'])) for r in receipt['cases']]==pairs,'missing explicit branch controls')
    out['separate_signed_branch_controls']=pairs
    for key in sorted(all_phases):
        text=(p/f'{label}_{key}.time').read_text();log=(p/f'{label}_{key}.log').read_text(errors='replace')
        status=int((p/f'{label}_{key}.exit').read_text())
        time_status=re.search(r'Exit status:\s+(\d+)\s*$',text)
        require(time_status is not None and int(time_status[1])==status,'missing/inconsistent process status '+key)
        if key in rejects:require(logical_rejection(log,status),'nonlogical rejection '+key)
        else:require(status==0,'failed required phase '+key)
        argv=(p/f'{label}_{key}.argv').read_text().splitlines();require(bool(argv),'empty argv')
        out['processes'][key]={'exit_status':status,'time_text':text,'argv':argv}
    for arm in ('direct','frontend'):
        for n in (0,7,64):
            values=[];internal=[]
            for r in ((1,) if n==7 else range(1,6)):
                key=f'check_{arm}{n}_{r}';log=(p/f'{label}_{key}.log').read_text()
                cpu=re.search(r'BENCH_CPU_SECONDS=([0-9.]+)',log);require(cpu is not None,'missing internal timer')
                internal.append(float(cpu[1]));text=out['processes'][key]['time_text']
                user=float(re.search(r'User time \(seconds\):\s*([0-9.]+)',text)[1])
                system=float(re.search(r'System time \(seconds\):\s*([0-9.]+)',text)[1]);values.append(user+system)
            name=f'{arm}{n}'
            out['arms'][name]={'whole_process_cpu_median':statistics.median(values),
                'whole_process_cpu_samples':values,'internal_checker_cpu_median':statistics.median(internal),
                'internal_checker_cpu_samples':internal,'binary_bytes':(p/f'{name}.mmb').stat().st_size,
                'scope':'separate branch controls only' if n==7 else 'setup control' if n==0 else 'measured64'}
            if n!=7:
                profile=(p/f'{label}_profile_{name}.log').read_text()
                counts=re.search(r'BENCH_COUNTS proof=(\d+) unify=(\d+)',profile);require(counts is not None,'missing profile')
                out['arms'][name].update(proof_commands=int(counts[1]),unify_commands=int(counts[2]),
                    highwater_log=(p/f'{label}_highwater_{name}.log').read_text())
    for f in p.iterdir():
        if f.is_file() and (f.name.startswith(label+'_') or f.suffix in ('.mmb','.mm0','.mm1','.py','.sh')):
            if f.name==f'{label}_collection.log':continue
            out['artifacts'][f.name]={'bytes':f.stat().st_size,'sha256':hashlib.sha256(f.read_bytes()).hexdigest().upper()}
    with (p/f'{label}_results.json').open('x') as f:json.dump(out,f,indent=2)
    print(json.dumps(out['arms'],indent=2))


if __name__=='__main__':
    require(len(sys.argv)==2,'usage: summarize.py label');main(sys.argv[1])
