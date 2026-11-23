"""Measure native template production and checking, including real mask resets."""
import hashlib,json,re,statistics,struct,subprocess
from pathlib import Path
from run import shell,ROOT,WIN,TMP

def checked(command):
    p=shell(command)
    if p.returncode:raise RuntimeError(command+'\n'+p.stdout+p.stderr)
    return p

source=ROOT.parent/'prime-cover/actual_trace.json'
trace=json.loads(source.read_text())
records=[]
for word in trace['words']:
    acc=0
    for j,u in enumerate(word['updates']):
        m=int(u['mask_hex'],16);lo=int(u['source_lo_hex'],16);hi=int(u['source_hi_hex'],16);s=u['shift']
        assert m==((lo>>s)|(hi<<(64-s) if s else 0))&((1<<64)-1)
        assert int(u['acc_before_hex'],16)==acc
        acc|=m;assert int(u['acc_after_hex'],16)==acc
        records.append((m,j==0))
    assert acc==(1<<64)-1
(ROOT/'actual-masks.bin').write_bytes(b''.join(struct.pack('<QQ',*r) for r in records))
checked(f'mkdir -p {TMP} && cp {WIN}/mm0-timed {WIN}/mm0-profile {WIN}/mm0-emit {WIN}/actual-masks.bin {WIN}/reset-slice-prefix.prefix {WIN}/reset-slice-prefix.mm0 {WIN}/reset-or-prefix.prefix {WIN}/reset-or-prefix.mm0 {TMP}/')

def case(name,op,n,actual=False):
    prefix='reset-or-prefix' if op=='or' else 'reset-slice-prefix'
    meta=json.loads((ROOT/(prefix+'.json')).read_text())
    offset=meta['proof_decl_offset'];log=[]
    def emit(n,bad=False):
        c=f'cd {TMP} && ./mm0-emit {prefix}.prefix {name}.mmb {n} {offset} {op} 16 3 '+('bad' if bad else 'good')+(' actual-masks.bin' if actual else '')
        p=checked(c);log.append(c+'\n'+p.stdout+p.stderr)
        return json.loads(p.stdout)
    def verify(prof=False):
        c=f'cd {TMP} && ./mm0-'+('profile' if prof else 'timed')+f' {name}.mmb < {prefix}.mm0'
        p=checked(c);log.append(c+'\n'+p.stdout+p.stderr)
        if prof:
            m=re.search(r'proof=(\d+) unify=(\d+)',p.stderr)
            return dict(proof=int(m[1]),unify=int(m[2]))
        return float(re.search(r'BENCH_CPU_SECONDS=([\d.]+)',p.stderr)[1])
    # Smoke test before the long run.
    emit(64);verify()
    emit(64,True)
    bad=shell(f'cd {TMP} && ./mm0-timed {name}.mmb < {prefix}.mm0')
    assert bad.returncode!=0 and 'MM0_REJECT' in bad.stderr
    log.append('CORRUPTED\n'+bad.stdout+bad.stderr)
    measurements=[]
    for count in [0,n]:
        producers=[emit(count) for _ in range(5)]
        checkers=[verify() for _ in range(7)]
        profile=verify(True)
        measurements.append(dict(updates=count,producer=producers,checker_cpu=checkers,profile=profile))
    b,v=measurements
    result=dict(name=name,op=op,updates=n,reset='actual word boundaries' if actual else 16,sparse_level=None if actual else 3,
        actual_trace_sha256=hashlib.sha256(source.read_bytes()).hexdigest() if actual else None,
        actual_trace_unique_updates=len(records) if actual else None,
        repetitions=n//len(records) if actual else None,
        measurements=measurements,
        checker_cpu_seconds_per_update=(statistics.median(v['checker_cpu'])-statistics.median(b['checker_cpu']))/n,
        emitter_cpu_seconds_per_update=(statistics.median([x['cpu_seconds'] for x in v['producer']])-statistics.median([x['cpu_seconds'] for x in b['producer']]))/n,
        bytes_per_update=v['producer'][-1]['update_bytes']/n,
        proof_commands_per_update=(v['profile']['proof']-b['profile']['proof'])/n,
        unifier_commands_per_update=(v['profile']['unify']-b['profile']['unify'])/n,
        valid_accepted=True,corruption_rejected=True,corruption_exit=bad.returncode,corruption_diagnostic=bad.stderr.strip(),
        final_sha256=checked(f'cd {TMP} && sha256sum {name}.mmb').stdout.split()[0])
    (ROOT/(name+'.native-result.json')).write_text(json.dumps(result,indent=2)+'\n')
    (ROOT/(name+'.native.log')).write_text('\n'.join(log))
    print(json.dumps({k:v for k,v in result.items() if k!='measurements'}),flush=True)
    return result

if __name__=='__main__':
    results=[case('sparse-reset-slice-or','slice-or',500000),case('sparse-reset-or','or',500000),case('actual-reset-or','or',len(records)*160,True)]
    (ROOT/'native-results.json').write_text(json.dumps(results,indent=2)+'\n')
