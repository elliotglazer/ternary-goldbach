"""Normalize saved measurements without rerunning the benchmark."""
import hashlib,json,statistics
from pathlib import Path
R=Path(__file__).resolve().parent
cases=[]
for name in ['actual-reset-or','sparse-reset-or','sparse-reset-slice-or']:
    d=json.loads((R/(name+'.native-result.json')).read_text());b,v=d['measurements'];n=d['updates']
    out={k:x for k,x in d.items() if k!='measurements'}
    out.update(checker_bootstrap_cpu_seconds=statistics.median(b['checker_cpu']),
        checker_gross_cpu_seconds_per_update=statistics.median(v['checker_cpu'])/n,
        checker_cpu_seconds_per_update_range=[(min(v['checker_cpu'])-statistics.median(b['checker_cpu']))/n,(max(v['checker_cpu'])-statistics.median(b['checker_cpu']))/n],
        emitter_bootstrap_cpu_seconds=statistics.median(x['cpu_seconds'] for x in b['producer']),
        emitted_proof_bytes=v['producer'][-1]['bytes'],bootstrap_proof_bytes=b['producer'][-1]['bytes'],
        source_specification_bytes=(R/('reset-or-prefix.mm0' if d['op']=='or' else 'reset-slice-prefix.mm0')).stat().st_size,
        total_dispatches_per_update=d['proof_commands_per_update']+d['unifier_commands_per_update'],
        measured_equivalent_dispatches_per_second=(d['proof_commands_per_update']+d['unifier_commands_per_update'])/d['checker_cpu_seconds_per_update'],
        incremental_emitter_bytes_per_second=d['bytes_per_update']/d['emitter_cpu_seconds_per_update'])
    cases.append(out)
limitations=[
    'Finite digit truth tables, generic word lifting, reset, and finish are explicit axioms in a schematic specification, not derived from PA.',
    'The accepted theorem is the proposition ok, not Goldbach or a coverage theorem. The trace and current accumulator are linked by each checked lift; reset is checked but does not require the previous accumulator to be all ones.',
    'Actual-mask values and full-word coverage are checked independently in Python. The MM0 proof does not certify primality, source bitmap indices, source alignment, or final full coverage.',
    'The actual fixture has 256 distinct words and 2892 updates repeated160 times. It does not measure a globally distributed bitmap working set or unique large prime certificates.',
    'The slice benchmark uses a fixed three-bit alignment and synthetic sparse values. It is not a benchmark of arbitrary variable shifts or full slice index provenance.',
    'Cached byte values and proofs use canonical shared expressions. Full trace terms grow by two saved expressions per update plus one per reset, with pointer-shared prior trace. Global heap and store are reset at theorem boundaries.',
    'Checker timing includes parser and verifier CPU with inputs on Linux tmpfs and subtracts a matched zero-update bootstrap. It excludes process launch and initial mmap setup. Raw gross timings are also retained.',
    'Producer timing includes native computation, template encoding, buffered writes, and close to tmpfs. It excludes initial prefix/fixture loading, prime search, PA library generation, and source certificate generation.',
    'Serialized producer plus checker costs can be added for this pipeline only. A fused streaming implementation could avoid materialization and some duplicate work; it has not been benchmarked.',
    'Stock MMB statement offsets and individual proof lengths remain limited to4GiB. Raised heap/store capacities do not remove these format limits. Large deployment needs sound chunking/composition and repeated setup accounting.',
    'These measured template costs do not establish a complete MM0/PA proof cost or an in-principle lower bound for MM0. Wider digits, specialized libraries, or verified arithmetic accelerators remain unmeasured.'
]
summary=dict(schema_version=1,status='Measured schematic MM0 proof workload; not end-to-end PA or Goldbach proof',
    source=dict(repository='https://github.com/digama0/mm0',commit='0d414c0bfdaaeb7fea571895127abc1fa5a3d956',subdirectory='mm0-c'),
    machine=dict(cpu='AMD Ryzen9 8945HS w/Radeon780M Graphics',physical_cores=8,logical_processors=16,physical_memory_bytes=33593020416,reported_max_mhz=4001,
      execution='WSL docker-desktop, Linux6.18.58.1-microsoft-standard-WSL2, x86_64',compiler='Clang23.1.0, --target=x86_64-linux-musl -O3 -static',libc='Alpine v3.22 musl-dev1.2.5-r13',timing_clock='CLOCK_PROCESS_CPUTIME_ID',input_filesystem='/dev/shm tmpfs'),
    method=dict(checker_repeats=7,producer_repeats=5,estimator='difference of medians divided by update count',parser_enabled=True,profile_counters_measured_in_separate_binary=True,
      verifier_changes=['heap capacity2^22 entries','store capacity2^30 bytes','in-process timing','failure diagnostic replaced, rejection preserved'],
      event_definition='one run_proof or run_unify loop iteration, including terminators; excludes inner loops such as theorem argument processing'),
    cases=cases,limitations=limitations,
    artifacts={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in R.iterdir() if p.is_file() and (p.suffix in ['.py','.c'] or p.name in ['mm0-timed','mm0-profile','mm0-emit','actual-masks.bin'])})
if (R/'resources.json').exists():
    summary['separate_resource_runs']=json.loads((R/'resources.json').read_text())['runs']
source_manifest=dict(commit=summary['source']['commit'],files={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (R/'src').iterdir() if p.is_file()},musl_dev_apk_sha256=hashlib.sha256((R/'musl-dev.apk').read_bytes()).hexdigest())
(R/'source-manifest.json').write_text(json.dumps(source_manifest,indent=2)+'\n')
summary['source_manifest']=source_manifest
(R/'summary.json').write_text(json.dumps(summary,indent=2)+'\n')
for c in cases:
    print(c['name'],'checker_us',c['checker_cpu_seconds_per_update']*1e6,'range_us',[x*1e6 for x in c['checker_cpu_seconds_per_update_range']], 'gross_us',c['checker_gross_cpu_seconds_per_update']*1e6,'producer_us',c['emitter_cpu_seconds_per_update']*1e6,'bytes',c['bytes_per_update'])
