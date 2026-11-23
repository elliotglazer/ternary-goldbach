"""Prepared outer job supervisor. DO NOT RUN before separate root authorization.

Imports the pinned native binding class only after validating the frozen inputs.
An outer inherited job closes the inner supervisor's pre-assignment child gap.
"""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import sys
import time

HERE=Path(__file__).resolve().parent
MANIFEST=HERE/'coordinator_c8_capability_authorization_20261111_v4.json'
SUPERVISOR=HERE/'c8_supervisor_capability_preflight_20261111_v4.py'
SSHA='08A6AB509952DC830002433B53892ED1E4B717B139611C45E5BF16E6FF6777AB'
PREFIX='coordinator_c8_capability_20261111_v4'
CAP=4*1024*1024
STREAM_CAP=65536
RESERVE=65536


def require(ok,msg):
    if not ok: raise RuntimeError(msg)


def sha(raw): return hashlib.sha256(raw).hexdigest().upper()


def read(path,cap):
    with path.open('rb') as f: raw=f.read(cap+1)
    require(len(raw)<=cap,'input size: '+str(path))
    return raw


def keys(items):
    result={}
    for key,value in items:
        require(key not in result,'duplicate JSON key'); result[key]=value
    return result


def encode(obj): return (json.dumps(obj,sort_keys=True,separators=(',',':'))+'\n').encode()


def main():
    raw=read(MANIFEST,16384); MSHA=sha(raw)
    require(sha(read(SUPERVISOR,65536))==SSHA,'supervisor pin')
    # Module definitions and Win construction happen only in an authorized run.
    sys.dont_write_bytecode=True  # no uncounted __pycache__ output
    spec=importlib.util.spec_from_file_location('pinned_c8_supervisor_binding',SUPERVISOR)
    module=importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
    m,mhash,_=module.load_manifest(MANIFEST)
    require(mhash==MSHA,'manifest changed')
    require(m['outer_runner_sha256']==sha(Path(__file__).read_bytes()),'authorized outer runner pin')
    attempt=HERE/m['attempt_name']; require(not attempt.exists(),'attempt already exists')
    paths={key:HERE/(PREFIX+suffix) for key,suffix in [('marker','.started'),('stdout','.stdout'),('stderr','.stderr'),('record','.json')]}
    require(not any(p.exists() for p in paths.values()),'outer attempt already exists')
    with paths['marker'].open('xb') as f: f.write(encode(dict(manifest_sha256=MSHA,runner_sha256=sha(Path(__file__).read_bytes()))))
    with paths['record'].open('xb') as f: f.write(encode(dict(status='INCOMPLETE')))
    logs={name:paths[name].open('xb',buffering=0) for name in ('stdout','stderr')}
    result=dict(schema='coordinator-c8-capability-v4',status='INCOMPLETE',manifest_sha256=MSHA,
                supervisor_sha256=SSHA,runner_sha256=sha(Path(__file__).read_bytes()),
                stream_bytes_seen=dict(stdout=0,stderr=0),stream_bytes_retained=dict(stdout=0,stderr=0),
                termination_requested=False,supervisor_observed_exit=False,descendant_cleanup=[],accounting=[],predicates={})
    win=None; job=None; pi=None; attr=None; attr_initialized=False
    pipes={}; other_handles=[]; start=None; cleanup_seen=set()
    def inventory():
        files=[]
        if attempt.exists():
            for p in attempt.iterdir():
                require(p.is_file() and not p.is_symlink(),'unexpected attempt entry')
                files.append(p)
        return len(raw)+sum(p.stat().st_size for p in files)+sum(p.stat().st_size for p in paths.values() if p.exists())
    def within_budget():
        require(inventory()+2*RESERVE<=CAP,'aggregate output cap/reserve')
        if start is not None: require(time.monotonic_ns()-start<30_000_000_000,'outer deadline')
    def checkpoint():
        data=encode(result); require(len(data)<=RESERVE,'bounded outer diagnostic checkpoint')
        with paths['record'].open('wb') as f:
            f.write(data); f.flush(); os.fsync(f.fileno())
    def snapshot(stage):
        item=win.account_snapshot(job,'outer',stage)
        result['accounting'].append(item); checkpoint()
        require(item['success'],'outer accounting query failed: '+str(item['error_on_failure']))
        return item['decoded']
    try:
        win=module.Win(); c,w=win.c,win.w
        k=c.WinDLL('kernel32',use_last_error=True)
        def bind(name,args,restype=w.BOOL):
            fn=getattr(k,name); fn.argtypes=args; fn.restype=restype; return fn
        H,D,P=w.HANDLE,w.DWORD,c.c_void_p
        create_pipe=bind('CreatePipe',[c.POINTER(H),c.POINTER(H),P,D])
        set_info=bind('SetHandleInformation',[H,D,D])
        peek=bind('PeekNamedPipe',[H,P,D,P,c.POINTER(D),P])
        read_file=bind('ReadFile',[H,P,D,c.POINTER(D),P])
        create_file=bind('CreateFileW',[w.LPCWSTR,D,D,P,D,D,H],H)
        init_attr=bind('InitializeProcThreadAttributeList',[P,D,D,c.POINTER(c.c_size_t)])
        update_attr=bind('UpdateProcThreadAttribute',[P,D,c.c_size_t,P,c.c_size_t,P,P])
        delete_attr=bind('DeleteProcThreadAttributeList',[P],None)
        terminate_job=bind('TerminateJobObject',[H,w.UINT])
        open_process=bind('OpenProcess',[D,w.BOOL,D],H)
        class SA(c.Structure):
            _fields_=[('nLength',D),('lpSecurityDescriptor',P),('bInheritHandle',w.BOOL)]
        class EX(c.Structure):
            _fields_=[('StartupInfo',win.START),('lpAttributeList',P)]
        class IDS(c.Structure):
            _fields_=[('NumberOfAssignedProcesses',D),('NumberOfProcessIdsInList',D),('ProcessIdList',c.c_size_t*8)]
        require(c.sizeof(SA)==24 and c.sizeof(EX)==112,'extended ABI')
        sa=SA(c.sizeof(SA),None,True)
        job=win.CreateJobObjectW(None,None); win.ok(job,'outer CreateJobObject')
        limit=win.LIMIT(); limit.BasicLimitInformation.LimitFlags=0x2008; limit.BasicLimitInformation.ActiveProcessLimit=2
        win.ok(win.SetInformationJobObject(job,9,c.byref(limit),c.sizeof(limit)),'outer job limits')
        actual=win.LIMIT(); win.ok(win.QueryInformationJobObject(job,9,c.byref(actual),c.sizeof(actual),None),'outer limits readback')
        require(actual.BasicLimitInformation.LimitFlags==0x2008 and actual.BasicLimitInformation.ActiveProcessLimit==2,'outer limits mismatch')
        result['job_handle']=hex(int(job)); snapshot('fresh_job_preassignment')
        for name in logs:
            rh,wh=H(),H(); win.ok(create_pipe(c.byref(rh),c.byref(wh),c.byref(sa),4096),'CreatePipe')
            pipes[name]=dict(read=rh.value,write=wh.value,closed=False)
            win.ok(set_info(rh,1,0),'noninherited pipe reader')
        null=create_file('NUL',0x80000000,3,c.byref(sa),3,0,None)
        require(null not in (None,c.c_void_p(-1).value),'NUL input'); other_handles.append(null)
        size=c.c_size_t()
        require(not init_attr(None,1,0,c.byref(size)) and 0<size.value<=65536,'attribute sizing')
        storage=c.create_string_buffer(size.value); attr=c.cast(storage,P)
        win.ok(init_attr(attr,1,0,c.byref(size)),'attribute list')
        attr_initialized=True
        handles=(H*3)(null,pipes['stdout']['write'],pipes['stderr']['write'])
        win.ok(update_attr(attr,0,0x20002,c.cast(handles,P),c.sizeof(handles),None,None),'explicit handle allowlist')
        sx=EX(); sx.StartupInfo.cb=c.sizeof(EX); sx.StartupInfo.dwFlags=0x100
        sx.StartupInfo.hStdInput=null; sx.StartupInfo.hStdOutput=pipes['stdout']['write']; sx.StartupInfo.hStdError=pipes['stderr']['write']; sx.lpAttributeList=attr
        import subprocess  # quoting helper only, never Popen/communicate
        command=c.create_unicode_buffer(subprocess.list2cmdline([str(module.EXE),'-I','-S',str(SUPERVISOR),'--manifest',str(MANIFEST)]))
        pi=win.PI(); within_budget(); start=time.monotonic_ns()
        win.ok(win.CreateProcessW(str(module.EXE),command,None,None,True,0x08080004,None,str(HERE),c.cast(c.byref(sx),c.POINTER(win.START)),c.byref(pi)),'outer suspended CreateProcess')
        result['pid']=pi.dwProcessId; result['start_monotonic_ns']=start
        result['original_supervisor_identity']=win.identity(pi.hProcess);checkpoint()
        require(result['original_supervisor_identity']['valid'] and result['original_supervisor_identity']['pid']==pi.dwProcessId,'original supervisor identity incomplete')
        win.ok(win.AssignProcessToJobObject(job,pi.hProcess),'outer assign before resume')
        member=w.BOOL(); win.ok(win.IsProcessInJob(pi.hProcess,job,c.byref(member)),'outer membership'); require(member.value,'not in outer job')
        result['process_handle']=hex(int(pi.hProcess)); result['membership_after_assignment']=bool(member.value)
        snapshot('postassignment_before_resume')
        within_budget()  # do not resume after late creation or job assignment
        for item in pipes.values(): win.CloseHandle(item['write']); item['write']=None
        win.CloseHandle(null); other_handles.remove(null)
        require(win.ResumeThread(pi.hThread)==1,'outer single resume')
        def drain():
            for name,item in pipes.items():
                if item['closed']: continue
                available=D()
                if not peek(item['read'],None,0,None,c.byref(available),None):
                    require(c.get_last_error()==109,'pipe peek failed'); item['closed']=True; continue
                # A fixed amount per poll avoids starvation under malformed output.
                take=min(available.value,4096)
                if not take: continue
                buf=c.create_string_buffer(take); got=D()
                win.ok(read_file(item['read'],buf,take,c.byref(got),None),'pipe read')
                data=buf.raw[:got.value]; result['stream_bytes_seen'][name]+=len(data)
                remaining=STREAM_CAP-result['stream_bytes_retained'][name]
                keep=data[:remaining]
                if keep: logs[name].write(keep); result['stream_bytes_retained'][name]+=len(keep)
                require(len(keep)==len(data),'bounded stream overflow')
        while True:
            within_budget(); drain()
            state=win.WaitForSingleObject(pi.hProcess,20); require(state in (0,258),'outer wait')
            if state==0:
                result['supervisor_observed_exit']=True; result['observed_exit_monotonic_ns']=time.monotonic_ns(); break
        within_budget()
        # With supervisor exit, inherited writers must also close. A leftover
        # writer/descendant cannot produce a complete normal result.
        for _ in range(64):
            within_budget(); drain()
            if all(p['closed'] for p in pipes.values()): break
            win.WaitForSingleObject(pi.hProcess,1)
        require(all(p['closed'] for p in pipes.values()),'unclosed inherited output writer')
        code=D(); win.ok(win.GetExitCodeProcess(pi.hProcess,c.byref(code)),'outer exit code'); result['returncode']=code.value
        checkpoint()
        account=snapshot('postexit_before_exitcode_rejection')
        result['outer_total_processes']=account['TotalProcesses']; result['outer_limit_terminated']=account['TotalTerminatedProcesses']
        result['predicates'].update(supervisor_exit_zero=code.value==0,total_processes_equals_three=account['TotalProcesses']==3,limit_terminations_equals_zero=account['TotalTerminatedProcesses']==0)
        checkpoint()
        # Capture this comparison even when the inner fixture failed its counts.
        try:
            preview_raw=read(attempt/'completion.json',65536)
            preview=json.loads(preview_raw,object_pairs_hook=keys)
            startup=preview.get('startup',{})
            same=bool(startup.get('token')==m['token'] and startup.get('source_sha256')==SSHA and module.identity_match(startup.get('identity',{}),result['original_supervisor_identity']))
            result['supervisor_startup_binding']=dict(matched=same,startup=startup,completion_sha256=sha(preview_raw))
        except BaseException as exc:
            result['supervisor_startup_binding']=dict(matched=False,inconclusive=True,error=type(exc).__name__+': '+str(exc)[:1000])
        checkpoint()
        require(result['predicates']['supervisor_exit_zero'],'supervisor nonzero exit')
        require(result['supervisor_startup_binding']['matched'],'supervisor startup identity mismatch/incomplete')
        require(result['predicates']['total_processes_equals_three'],'outer total_processes_equals_three')
        require(result['predicates']['limit_terminations_equals_zero'],'outer limit_terminations_equals_zero')
        stdout=read(paths['stdout'],STREAM_CAP); stderr=read(paths['stderr'],STREAM_CAP)
        require(not stderr and len(stdout.splitlines())==1,'stdout/stderr contract')
        console=json.loads(stdout,object_pairs_hook=keys)
        completion_raw=read(attempt/'completion.json',65536); completion=json.loads(completion_raw,object_pairs_hook=keys)
        require(console['status']==completion['status']=='PASS','fixture status')
        require(console['receipt_sha256']==sha(completion_raw),'completion hash')
        require(console['manifest_sha256']==completion['manifest_sha256']==MSHA,'completion manifest')
        require(completion['pins']==m['pins'],'completion source pins')
        for key in ('supervisor','child'): require(console[key+'_sha256']==m['pins'][key],'console source pin')
        require([t['case'] for t in completion['tests']]==['normal','timeout'],'case coverage')
        require(console['elapsed_ns']<30_000_000_000,'inner total time')
        peaks=console['conservative_peak_sums']; own=console['final_observer_memory']
        require(len(peaks)==2 and own['success'] and own['peak']>0,'aggregate telemetry')
        require(peaks==[own['peak']+t['postexit']['peak'] for t in completion['tests']] and all(0<n<=268435456 for n in peaks),'aggregate peak sums')
        known=len(raw)+sum(p.stat().st_size for p in attempt.iterdir())
        require(known==console['aggregate_disk_bytes'],'inner byte count')
        result.update(status='PASS',console=console,completion_sha256=sha(completion_raw))
    except BaseException as exc:
        result.update(status='FAIL',error=type(exc).__name__+': '+str(exc)[:2000])
        result.setdefault('first_error',result['error'])
        try: checkpoint()
        except BaseException as later: result['checkpoint_error']=type(later).__name__+': '+str(later)[:1000]
    finally:
        if win is not None:
            # Even a failed inner assignment leaves the child in the inherited
            # outer job. TerminateJobObject covers that otherwise orphaned gap.
            if job and result['status']!='PASS':
                result['termination_requested']=True
                result['terminate_job_success']=bool(terminate_job(job,0xC8F2))
            if pi is not None and pi.hProcess:
                if not result['supervisor_observed_exit']:
                    if win.WaitForSingleObject(pi.hProcess,2000)==0:
                        result['supervisor_observed_exit']=True
                    else: result.update(status='FAIL',cleanup_error='INCOMPLETE_SUPERVISOR_TERMINATION')
                # If assignment itself failed, the suspended process is not in
                # our job. Explicitly kill it on its original handle as well.
                if win.WaitForSingleObject(pi.hProcess,0)!=0:
                    win.TerminateProcess(pi.hProcess,0xC8F2)
                    if win.WaitForSingleObject(pi.hProcess,2000)!=0:
                        result.update(status='FAIL',cleanup_error='INCOMPLETE_UNASSIGNED_TERMINATION')
                    else: result['supervisor_observed_exit']=True
            if job and pi is not None and pi.hProcess:
                try:
                    cleanup_deadline=time.monotonic_ns()+2_000_000_000
                    while True:
                        ids=IDS(); win.ok(win.QueryInformationJobObject(job,3,c.byref(ids),c.sizeof(ids),None),'cleanup job PID list')
                        require(ids.NumberOfAssignedProcesses==ids.NumberOfProcessIdsInList and ids.NumberOfProcessIdsInList<=8,'job PID completeness/capacity')
                        listed=[int(ids.ProcessIdList[j]) for j in range(ids.NumberOfProcessIdsInList)]
                        require(len(set(listed))==len(listed) and all(p>0 for p in listed),'job PID validity')
                        others=[int(ids.ProcessIdList[j]) for j in range(ids.NumberOfProcessIdsInList) if ids.ProcessIdList[j]!=pi.dwProcessId]
                        if not others: break
                        require(time.monotonic_ns()<cleanup_deadline,'INCOMPLETE_DESCENDANT_TERMINATION')
                        for pid in others:
                            ph=open_process(0x101000,False,pid)
                            require(ph,'INCOMPLETE_DESCENDANT_HANDLE')
                            try:
                                belongs=w.BOOL(); win.ok(win.IsProcessInJob(ph,job,c.byref(belongs)),'cleanup membership')
                                require(belongs.value,'ambiguous cleanup PID identity')
                                state=win.WaitForSingleObject(ph,20)
                                if state==0 and pid not in cleanup_seen:
                                    require(len(cleanup_seen)<8,'bounded cleanup identity count')
                                    cleanup_seen.add(pid)
                                    result['descendant_cleanup'].append(dict(pid=pid,observed_exit=True))
                                else: require(state in (0,258),'descendant wait failed')
                            finally: win.CloseHandle(ph)
                    result['remaining_associated_descendants']=[]
                except BaseException as exc:
                    result.update(status='FAIL',cleanup_error=type(exc).__name__+': '+str(exc)[:1000])
                    result['cleanup_terminate_job_success']=bool(terminate_job(job,0xC8F2))
            for item in pipes.values():
                for handle in (item['read'],item['write']):
                    if handle: win.CloseHandle(handle)
            for handle in other_handles: win.CloseHandle(handle)
            if attr_initialized: delete_attr(attr)
            if pi is not None:
                if pi.hThread: win.CloseHandle(pi.hThread)
                if pi.hProcess: win.CloseHandle(pi.hProcess)
            if job: win.CloseHandle(job)
        for log in logs.values(): log.close()
    result['elapsed_to_finalization_ns']=None if start is None else time.monotonic_ns()-start
    for name in ('stdout','stderr'):
        data=read(paths[name],STREAM_CAP); result[name+'_sha256']=sha(data); result[name+'_bytes']=len(data)
    try:
        result['retained_bytes_before_final_record']=inventory()
    except BaseException as exc:
        result.update(status='FAIL',inventory_error=type(exc).__name__+': '+str(exc)[:1000])
    encoded=encode(result); require(len(encoded)<=RESERVE,'bounded coordinator record')
    if result.get('retained_bytes_before_final_record',CAP)+len(encoded)+RESERVE>CAP:
        result.update(status='FAIL',output_cap_exceeded=True)
    if start is not None and time.monotonic_ns()-start>=30_000_000_000:
        result.update(status='FAIL',outer_deadline_exceeded=True)
    encoded=encode(result)
    require(len(encoded)<=RESERVE,'bounded final coordinator record')
    with paths['record'].open('wb') as f: f.write(encoded); f.flush()
    summary=dict(status=result['status'],record_sha256=sha(encoded),record=str(paths['record']),
                 runner_sha256=result['runner_sha256'],manifest_sha256=MSHA)
    print(json.dumps(summary,sort_keys=True),flush=True)
    return 0 if result['status']=='PASS' else 1


if __name__=='__main__':
    raise SystemExit(main())
