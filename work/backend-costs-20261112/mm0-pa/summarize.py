"""Require complete audits and independent checks before reporting timings."""
import hashlib
import json
import re
import statistics
from pathlib import Path
from generate_arithmetic import BASE

NAMES=['products0','products1','products8','products16','products32',
       'fourbit0','fourbit8','fourbit32','fourbit64','fourbit64_all']

def timing(path):
    t=path.read_text()
    def val(k):
        return float(re.search(re.escape(k)+r':\s*([\d.]+)',t)[1])
    user=val('User time (seconds)');system=val('System time (seconds)')
    status=int(val('Exit status'))
    assert status==0,(path,status)
    elapsed=re.search(r'Elapsed \(wall clock\) time \(h:mm:ss or m:ss\): (.+)',t)[1]
    m=re.fullmatch(r'(?:(\d+)h )?(?:(\d+)m )?([\d.]+)s',elapsed)
    wall=int(m[1] or 0)*3600+int(m[2] or 0)*60+float(m[3])
    return dict(cpu_seconds=user+system,wall_seconds=wall,
                peak_rss_kib=int(val('Maximum resident set size (kbytes)')),exit_status=status)

def artifact(path):
    data=path.read_bytes()
    return dict(path=path.name,bytes=len(data),sha256=hashlib.sha256(data).hexdigest())

records=[]
for name in NAMES:
    meta=json.loads((BASE/f'{name}.json').read_text())
    audit=json.loads((BASE/f'{name}.audit.json').read_text())
    assert audit['exact_inputs_and_results'] and audit['axiom_inventory_unchanged'] and audit['no_sorry_opcode']
    assert artifact(BASE/f'{name}.mmb')['sha256']==audit['sha256']
    compile=timing(BASE/f'{name}.compile.time')
    assert 'error:' not in (BASE/f'{name}.compile.log').read_text()
    replays=[]
    for i in range(1,6):
        log=(BASE/f'{name}.replay{i}.log').read_text()
        assert 'MM0_REJECT' not in log
        samples=re.findall(r'BENCH_CPU_SECONDS=([\d.]+)',log)
        assert len(samples)==1
        replays.append(dict(verifier_cpu_seconds=float(samples[0]),**timing(BASE/f'{name}.replay{i}.time')))
    count=re.search(r'proof=(\d+) unify=(\d+)',(BASE/f'{name}.profile.log').read_text())
    assert count
    assert int(count[1])==audit['proof_commands']
    records.append(dict(name=name,products=meta['products'],
                        generation_seconds=meta['generation_seconds'], compile=compile,
                        copy_to_linux=timing(BASE/f'{name}.copy.time'),
                        replays=replays,
                        verifier_cpu_median=statistics.median(r['verifier_cpu_seconds'] for r in replays),
                        verifier_cpu_min=min(r['verifier_cpu_seconds'] for r in replays),
                        verifier_cpu_max=max(r['verifier_cpu_seconds'] for r in replays),
                        proof_commands=int(count[1]),unify_commands=int(count[2]),
                        audit=audit,certificate=artifact(BASE/f'{name}.mmb')))

by_name={r['name']:r for r in records}
for r in records:
    base=by_name['fourbit0' if r['name'].startswith('fourbit') else 'products0']
    r['verifier_cpu_minus_bootstrap']=r['verifier_cpu_median']-base['verifier_cpu_median']
controls=[]
for name in ['bad_input','bad_result','bad_conclusion','bad_proof']:
    status=int((BASE/f'{name}.exit').read_text())
    log=(BASE/f'{name}.check.log').read_text()
    assert status not in (0,124) and 'MM0_REJECT' in log
    controls.append(dict(name=name,status=status,diagnostic=log.strip()))

lean=json.loads((BASE.parent/'lean-dependent/PACKED_RESULTS.json').read_text())
assert lean['passed']
aggregate=by_name['fourbit64_all']
assert aggregate['audit']['closed_conjunction_checked']
output=dict(passed=True,scope='Exact nonnegative products from P343N64, ordinary PA certificates; no transform or Goldbach claim.',
            implementation='Schoolbook binary multiplication; baseline binary addition and optimized proved four-bit addition rules.',
            trust='Pinned ordinary peano.mm0, 26 named axioms unchanged. mm0-c parses the complete specification and verifies every proof. No compiler oracle or native arithmetic acceptance rule.',
            source_commit='0d414c0bfdaaeb7fea571895127abc1fa5a3d956',
            measurement='Five fresh mm0-c processes per case. CPU timer covers parser initialization and verification, excluding initial mmap and process launch. Warm Linux tmpfs input; transfer and whole-process timings separate.',
            cases=records,controls=controls,
            compiler_build=timing(BASE/'compiler_build02.time'),
            compiler_artifact=artifact(BASE/'mm0-rs'),
            compiler_profile='release, locked, no-default-features, release debug=0; Rust 1.100.0 x86_64-unknown-linux-musl',
            checker_artifact=artifact(BASE.parents[1]/'formal-goldbach-bench/mm0/mm0-timed'),
            largest_generation_and_assembly_cpu=by_name['fourbit64']['compile']['cpu_seconds']+aggregate['compile']['cpu_seconds'],
            optimization32=dict(verification_ratio=by_name['products32']['verifier_cpu_minus_bootstrap']/by_name['fourbit32']['verifier_cpu_minus_bootstrap'],
                                certificate_size_ratio=by_name['products32']['certificate']['bytes']/by_name['fourbit32']['certificate']['bytes'],
                                compiler_cpu_ratio=by_name['products32']['compile']['cpu_seconds']/by_name['fourbit32']['compile']['cpu_seconds']),
            limitations=['Not an optimized-MM0 lower bound. Larger digits, different multiplication algorithms, direct MMB emission and proof sharing remain possible.',
                         'No signed arithmetic, floor rounding, dependent network, source coefficients, analytic error bounds, zero counts or prime coverage.',
                         'Not accepted by stock Lean; PA foundations differ from Lean and HOL.',
                         'No full TG forecast follows from these timings.'])
(BASE/'RESULTS.json').write_text(json.dumps(output,indent=2)+'\n')
print(json.dumps(dict(passed=True,rows=[dict(name=r['name'],verify_ms=1000*r['verifier_cpu_median'],compile_cpu=r['compile']['cpu_seconds'],bytes=r['certificate']['bytes']) for r in records],optimization32=output['optimization32'],controls=len(controls)),indent=2))
