"""Prepared numerical supervision entry. No execution is authorized by this source.

Roles R and S require a future reviewed runtime authorization. Neither publishes
combined PASS. An independent external host must close the post-R chain.
"""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import sys
import time

def pinned_imports(authorization):
    # No sibling/native code is imported before its exact source bytes are bound.
    if authorization.stat().st_size>65536: raise RuntimeError('authorization size')
    def unique(items):
        d={}
        for k,v in items:
            if k in d: raise RuntimeError('duplicate authorization key')
            d[k]=v
        return d
    with authorization.open('rb') as f: raw=f.read(65537)
    if len(raw)>65536: raise RuntimeError('authorization grew')
    m=json.loads(raw,object_pairs_hook=unique)
    here=Path(__file__).resolve().parent; prefix='rational_j7_supervision_20261111'
    names=[prefix+s for s in ('_common.py','_native.py','_managed.py','_run.py')]
    if set(m.get('sources',{}))!=set(names): raise RuntimeError('source set')
    for name in names:
        p=here/name
        if p.is_symlink() or p.stat().st_size>131072: raise RuntimeError('source path/size')
        if hashlib.sha256(p.read_bytes()).hexdigest().upper()!=m['sources'][name]: raise RuntimeError('source hash')
    sys.dont_write_bytecode=True
    for name in names[:-1]:
        spec=importlib.util.spec_from_file_location(name[:-3],here/name)
        module=importlib.util.module_from_spec(spec); sys.modules[name[:-3]]=module; spec.loader.exec_module(module)
    return sys.modules[prefix+'_common'],sys.modules[prefix+'_managed']

def main():
    entered=time.monotonic_ns()
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--role',choices=['R','S'],required=True)
    parser.add_argument('--authorization',type=Path,required=True)
    args=parser.parse_args()
    sys.set_int_max_str_digits(21000)
    C,N=pinned_imports(args.authorization)
    m=C.validate_authorization(args.authorization)
    entered=m['host_start_ns']
    owner=C.Ownership(m,args.authorization); seconds=600 if m['phase']=='producer' else 900
    auth_hash=C.sha(args.authorization)
    if args.role=='R':
        C.need(not owner.directory.exists() and not any(p.exists() for p in owner.worker),'one attempt/empty outputs')
        owner.directory.mkdir()
        owner.publish('r_attempt.json',dict(authorization_sha256=auth_hash,one_attempt=True))
    else:
        C.need(owner.directory.is_dir() and not any(p.exists() for p in owner.worker),'S one attempt')
        ticket=C.load(owner.directory/'r_ticket.json')
        C.need(ticket.get('authorization_sha256')==auth_hash and ticket.get('token')==m['token'],'R ticket')
        C.need(type(ticket.get('precreate_ns')) is int and ticket['precreate_ns']>0,'creator prelaunch clock')
        entered=ticket['precreate_ns']
        C.need(not (owner.directory/'s_attempt.json').exists(),'S replay refused')
        owner.publish('s_attempt.json',dict(authorization_sha256=auth_hash,one_attempt=True))
    child=None; win=None; success=False; own_peak=0; own_peak_query_ns=0; child_exit=None
    record=dict(schema='rational-j7-'+args.role.lower()+'-1',status='INCOMPLETE',phase=m['phase'],authorization_sha256=auth_hash)
    def guard():
        nonlocal own_peak,own_peak_query_ns
        owner.guard()
        cap=(128 if args.role=='R' else 256)*1024**2
        if win is not None:
            mem=N.memory(win,win.GetCurrentProcess(),cap,own_peak); own_peak=mem['peak']
            own_peak_query_ns=time.monotonic_ns()
        elapsed=time.monotonic_ns()-entered
        C.need(elapsed<(seconds+150 if args.role=='R' else seconds+90)*10**9,'observer overall deadline')
        if child is None or child.started is None: C.need(elapsed<30*10**9,'observer prelaunch budget')
        if child_exit is not None: C.need(time.monotonic_ns()-child_exit<(30 if args.role=='R' else 60)*10**9,'observer postexit budget')
    try:
        win=N.Win(); guard()
        startup=win.identity(win.GetCurrentProcess(),current=True)
        C.need(startup['valid'],'observer identity')
        record['startup']=startup
        if args.role=='R':
            owner.publish('r_ticket.json',dict(authorization_sha256=auth_hash,token=m['token'],startup=startup,precreate_ns=time.monotonic_ns()))
            child=N.Managed(win,owner,'s',2,2,seconds+90,256*1024**2,guard)
            child.start([Path(__file__).resolve(),'--role','S','--authorization',args.authorization.resolve()],C.HERE)
        else:
            owner.publish('s_startup.json',dict(authorization_sha256=auth_hash,identity=startup))
            manifest=C.worker_manifest(m,int(win.GetCurrentProcessId()))
            path=owner.publish('worker_manifest.json',manifest)
            worker=C.relative(C.PRODUCER if m['phase']=='producer' else C.INDEPENDENT)
            child=N.Managed(win,owner,'w',1,1,seconds,512*1024**2,guard)
            child.start([worker,'--manifest',path],worker.parent)
        child.wait(); child_exit=child.record['observed_exit_ns']; guard()
        # Recheck all immutable inputs after process exit, including exact capability receipts.
        C.need(C.sha(args.authorization)==auth_hash,'authorization changed')
        C.need(C.exact(C.validate_authorization(args.authorization),m),'immutable input change')
        if args.role=='S':
            candidate=C.output_summary(m)
            if m['phase']=='producer':
                completion=C.load(owner.worker[0].with_suffix('.completion.json'))
                console=C.load(owner.directory/'w.stdout',16384)
                C.need(C.exact(completion,console),'producer stdout completion mismatch')
            C.need((owner.directory/'w.stderr').stat().st_size==0,'unexpected worker stderr')
            record.update(status='S_PROVISIONAL',candidate=candidate,worker=child.record,
                          worker_manifest_sha256=C.sha(owner.directory/'worker_manifest.json'))
        else:
            sub=C.load(owner.directory/'s_seal.json')
            C.need(sub.get('status')=='S_PROVISIONAL' and sub.get('authorization_sha256')==auth_hash,'S seal')
            C.need(N.identity_match(sub.get('startup',{}),child.record['identity']),'actual S identity binding')
            candidate=C.output_summary(m)
            C.need(candidate==sub.get('candidate'),'S candidate changed')
            C.need((owner.directory/'s.stderr').stat().st_size==0 and (owner.directory/'s.stdout').stat().st_size==0,'unexpected S console')
            record.update(status='R_PROVISIONAL',candidate=candidate,s_record=child.record,
                          s_exit_code=child.record['exit_code'],s_seal_sha256=C.sha(owner.directory/'s_seal.json'),
                          outer_total=child.record['final_accounting']['TotalProcesses'],
                          outer_terminated=child.record['final_accounting']['TotalTerminatedProcesses'])
        record['observed_self_peak_bytes']=own_peak
        record['observed_self_peak_query_completed_ns']=own_peak_query_ns
        record['self_peak_scope']='sample_before_inventory_hash_and_seal; later_unsaved_cap_checks; not_postexit'
        record['inventory_before_seal']=owner.guard()
        record['sealed_files']=[dict(item,sha256=C.sha(C.relative(item['path']))) for item in record['inventory_before_seal']]
        record['elapsed_before_seal_ns']=time.monotonic_ns()-entered
        owner.publish(args.role.lower()+'_seal.json',record)
        guard()  # A late failure leaves only provisional bytes and exits nonzero.
        success=True
    except BaseException as exc:
        record.update(status='INCOMPLETE',error=type(exc).__name__+': '+str(exc)[:2000])
        if child is not None: record['managed']=child.record
    finally:
        if child is not None:
            try:
                if not child.close(success):
                    success=False; record.update(status='INCOMPLETE',error='native handle close failed')
            except BaseException as exc:
                success=False; record.update(status='INCOMPLETE',error='cleanup: '+str(exc)[:2000])
    if success:
        try: guard()
        except BaseException as exc:
            success=False; record.update(status='INCOMPLETE',error='final guard: '+str(exc)[:2000])
    if not success:
        try: owner.publish(args.role.lower()+'_failure.json',record)
        except BaseException: pass  # Missing failure bytes never turn an incomplete attempt into success.
        return 1
    return 0

if __name__=='__main__':
    raise SystemExit(main())
