from pathlib import Path
import json, hashlib, re

ROOT=Path(__file__).resolve().parent
ANCHORS=238418579456
YEAR=31557600

def successful_log(source, marker=None):
    for path in sorted(ROOT.glob('run-*.log'), reverse=True):
        text=path.read_text(encoding='utf-8')
        try: record=json.loads(text.splitlines()[-1])
        except (ValueError,IndexError): continue
        if record.get('exit')==0 and source in record.get('args',[]) and (marker is None or marker in text):
            return path,text,record
    raise RuntimeError(f'No successful log for {source}')

def stages(text, roots):
    out=[]
    for line in text.splitlines():
        if not line.startswith('label='): continue
        row={}
        for item in line.split(','):
            k,v=item.split('=',1)
            row[k]=int(v) if v.isdecimal() else v=='true' if v in ('true','false') else v
        divisor=row['reps']*roots if row['label'].startswith(('roots_','full_')) else row['reps']
        row['per_anchor_kernel_wall_ms']=row['kernel_ns']/divisor/1e6
        if 'process_cpu_ns' in row:
            row['per_anchor_process_cpu_ms']=row['process_cpu_ns']/divisor/1e6
            row['conditional_anchor_total_cpu_core_years']=row['process_cpu_ns']/divisor/1e9*ANCHORS/YEAR
        row['interpretation'] = ('Incomplete cost: omits lifted computational proofs; do not use as prime-check forecast'
            if 'named_bod' in row['label'] or 'named_body' in row['label'] else
            'Incremental root cost with local auxiliaries; assumes supporting factor-prime proofs already checked'
            if 'with_' in row['label'] else
            'All sampled prime-node bodies and local auxiliaries checked once per shared closure; fixed library support excluded')
        out.append(row)
    return out

p32,t32,r32=successful_log('PrimeBench32.lean')
p3,t3,r3=successful_log('PrimeBench.lean','environment_trust_level=0')
pa,ta,ra=successful_log('PrimeSamples32.lean')
pm,tm,rm=successful_log('ModPowBench.lean')
axioms=re.findall(r"'prime_(\d+)' depends on axioms: \[([^\]]+)\]",ta)
assert len(axioms)==32
assert all(a=='propext, Classical.choice, Quot.sound' for _,a in axioms)
assert 'environment_trust_level=0' in t32
manifest=json.loads((ROOT/'PrimeSamples32.manifest.json').read_text())
rows=stages(t32,32)
assert all(r['bad_rejected'] and r['accepted']==r['nodes']*r['reps'] for r in rows)
assert all(r['process_cpu_ns'] > r['kernel_ns']/10 for r in rows), 'Reject wrong-process CPU samples'
files=[ROOT/n for n in ['PrimeSupport.lean','PrimeSupport.olean','PrimeSamples.lean','PrimeSamples.olean',
    'PrimeSamples32.lean','PrimeSamples32.olean','PrimeBench.lean','PrimeBench32.lean','ModPowBench.lean',
    'generate_primes.py','run_lean.py','sample_parent_cpu.py','PrimeSamples32.manifest.json']]
files += [p32,p3,pa,pm,ROOT.parent/'native/pratt_certificates.json']
out={'kind':'Measured Lean kernel replay of genuine Lucas-Pratt prime certificates',
 'lean_version':'4.35.0','mathlib_commit':'56a005855ea17e0b0958f73ec801ae140b0a1679',
 'processor':'AMD Ryzen 9 8945HS with Radeon 780M; 8 cores / 16 logical processors',
 'command_arguments':r32['args'],'environment_trust_level':0,
 'cpu_sampling':'Windows GetProcessTimes for explicit IO.Process.getPID, sampled around each replay batch',
 'axioms':['propext','Classical.choice','Quot.sound'],
 'cohort32':{'selection':'First four roots from each of eight 512-root producer pools',
    'root_count':32,'roots':manifest['roots'],'named_pratt_node_count':len(manifest['nodes']),
    'stages':rows,'whole_process':r32,'proof_construction_process':ra},
 'cohort3':{'root_count':3,'named_pratt_node_count':40,'stages':stages(t3,3),
            'whole_process':r3,'timing_kind':'Kernel wall time only; no process CPU sampler in this earlier run'},
 'modpow_control':{'whole_process':rm,'raw_output':tm},
 'forecast_anchor_count':ANCHORS,
 'limitations':['Imported Mathlib and fixed lucasNat soundness proof treated as previously checked dependencies.',
 'Each replay checks the actual stored theorem body, not a constant reference to the theorem.',
 'Kernel timing includes all selected local _proof auxiliaries. Named bodies alone omit modular computation.',
 'Parent-process CPU samples include a small launch/return overhead around the timed region; wall timer excludes sampler calls.',
 'One earlier CPU-sampler experiment queried the Python launcher rather than Lean; its invalid region counters are excluded.',
 'Single AMD laptop sample; cohort-local sharing differs from sharing across all 4096 producer roots or the full forecast.',
 'No partial-factor Pocklington optimization or alternative modular-exponentiation certificate was implemented.',
 'Extrapolations price prime-certificate checking only, not Goldbach coverage, production, imports, I/O, or final assembly.'],
 'sha256':{str(p.relative_to(ROOT)) if p.is_relative_to(ROOT) else str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in files}}
(ROOT/'results.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'stages32':rows,'axiom_checks':len(axioms)},indent=2))
