"""PREPARATION ONLY. Separately authorized benign H/R/S/W containment test.
No scientific imports or numerical work. Native APIs are bound only after the
complete manifest has been checked. Do not run without a new coordinator gate.
"""
import time
BOOT=time.monotonic_ns()
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import sys

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
NATIVE=HERE/'rational_j7_supervision_20261111_native.py'
NATIVE_SHA='CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13'
EXE=Path('C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe')
EXE_SHA='4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9'
SPEC=HERE/'RATIONAL_J7_CONTAINMENT_PREFLIGHT_2026-11-11.md'
CAPS=dict(total_seconds=45,case_seconds=12,cleanup_seconds=3,process_peak_bytes=128*1024**2,
          aggregate_peak_bytes=512*1024**2,output_bytes=2*1024**2)
KILL=0xC8F6
CASES=['normal','gap_s','gap_w']
RAW_ACCOUNTING=[]
RAW_EVENTS=[]

def event(value):
    need(len(RAW_EVENTS)<256,'bounded raw event log');RAW_EVENTS.append(value);return value

def cleanup_process(win,handle,label,timeout_ms=3000):
    """Record attempted cleanup without pretending handle release proves exit."""
    observation=dict(kind='cleanup_process',label=label,handle=int(handle),identity=win.identity(handle))
    observation['terminate_success']=bool(win.TerminateProcess(handle,KILL))
    observation['terminate_error']=win.c.get_last_error() if not observation['terminate_success'] else None
    state=int(win.WaitForSingleObject(handle,timeout_ms));observation['wait_status']=state
    observation['exit_observed']=state==0
    if state==0:
        code=win.w.DWORD();observation['exit_query_success']=bool(win.GetExitCodeProcess(handle,win.c.byref(code)))
        observation['exit_code']=int(code.value)
    return event(observation)

def cleanup_job(win,handle,label):
    ok=bool(win.TerminateJobObject(handle,KILL))
    return event(dict(kind='cleanup_job',label=label,handle=int(handle),success=ok,
                      error=win.c.get_last_error() if not ok else None))

def failure_file(root,directory,name,error,mp):
    """Best-effort bounded persistence, including after a deadline failure."""
    payload=dict(status='INCOMPLETE',error=type(error).__name__+': '+str(error)[:2000],
                 raw_accounting=RAW_ACCOUNTING,raw_events=RAW_EVENTS)
    raw=encode(payload)
    if len(raw)>524288:
        raw=encode(dict(status='INCOMPLETE',error=payload['error'],diagnostic_truncation=True,
                        raw_accounting=RAW_ACCOUNTING[-8:],raw_events=RAW_EVENTS[-16:]))
    files=list(root.rglob('*'))
    need(len(files)<=128 and len(raw)<=524288,'bounded failure serialization')
    need(sum(p.stat().st_size for p in files if p.is_file())+mp.stat().st_size+len(raw)<=CAPS['output_bytes'],'failure output cap')
    with (directory/name).open('xb') as out:out.write(raw);out.flush();os.fsync(out.fileno())

def need(ok,why):
    if not ok: raise RuntimeError(why)

def sha(p):
    h=hashlib.sha256()
    with p.open('rb') as f:
        for b in iter(lambda:f.read(65536),b''): h.update(b)
    return h.hexdigest().upper()

def unique(items):
    d={}
    for k,v in items:
        need(k not in d,'duplicate JSON key');d[k]=v
    return d

def encode(v): return (json.dumps(v,sort_keys=True,separators=(',',':'),allow_nan=False)+'\n').encode('ascii')

def load(p,cap=65536):
    need(p.stat().st_size<=cap,'input size')
    with p.open('rb') as f: raw=f.read(cap+1)
    need(len(raw)<=cap,'growing input')
    return json.loads(raw,object_pairs_hook=unique,parse_constant=lambda x: (_ for _ in ()).throw(RuntimeError('nonfinite JSON')))

def clean(p):
    p=Path(p).absolute();need(p==p.resolve(),'canonical path')
    for x in (p,*p.parents):
        if x.exists(): need(not x.is_symlink() and not x.lstat().st_file_attributes&0x400,'reparse path')
    return p

def manifest(p):
    p=clean(p);m=load(p)
    need(set(m)=={'schema','authorize','token','pins','static_review','caps'},'manifest keys')
    need(m['schema']=='rational-j7-containment-preflight-1' and m['authorize']=='RUN_ONE_BENIGN_CONTAINMENT_ATTEMPT','authorization')
    need(type(m['token']) is str and re.fullmatch('[a-f0-9]{32}',m['token']),'token')
    need(m['caps']==CAPS and all(type(m['caps'][k]) is int for k in CAPS),'caps')
    expected=dict(source=sha(Path(__file__)),specification=sha(SPEC),native=NATIVE_SHA,executable=EXE_SHA,
       host_contract='37A792EC451CB94D61EED6F7565F6E8160158861657681501A2FABCE7A0EF9E3')
    need(m['pins']==expected and sha(NATIVE)==NATIVE_SHA and sha(EXE)==EXE_SHA,'source/interpreter pins')
    need(sha(AGENTS/'audit/RATIONAL_J7_HOST_PREPARATION_2026-11-11.md')==expected['host_contract'],'host contract pin')
    r=m['static_review'];need(type(r) is dict and set(r)=={'path','sha256'},'review reference')
    rp=clean(AGENTS/r['path']);need(rp.is_relative_to(AGENTS) and rp.suffix=='.md' and sha(rp)==r['sha256'],'static review')
    return m,p

def native():
    sys.dont_write_bytecode=True
    spec=importlib.util.spec_from_file_location('j7_containment_pinned_native',NATIVE)
    module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
    win=module.Win();c,w=win.c,win.w;k=c.WinDLL('kernel32',use_last_error=True)
    def bind(name,args,result=w.BOOL):
        f=getattr(k,name);f.argtypes=args;f.restype=result;setattr(win,name,f)
    H,D,P=w.HANDLE,w.DWORD,c.c_void_p
    bind('DuplicateHandle',[H,H,H,c.POINTER(H),D,w.BOOL,D])
    bind('TerminateJobObject',[H,w.UINT])
    bind('CreateFileW',[w.LPCWSTR,D,D,P,D,D,H],H)
    bind('InitializeProcThreadAttributeList',[P,D,D,c.POINTER(c.c_size_t)])
    bind('UpdateProcThreadAttribute',[P,D,c.c_size_t,P,c.c_size_t,P,P])
    bind('DeleteProcThreadAttributeList',[P],None)
    return win,module.identity_match

class Context:
    def __init__(self,win,root,deadline,manifest_path):
        self.win=win;self.root=root;self.deadline=deadline;self.manifest_path=manifest_path;self.peak=0
    def guard(self):
        need(time.monotonic_ns()<self.deadline,'deadline')
        m=self.win.memory(self.win.GetCurrentProcess())
        need(m['success'] and 0<m['peak']<=CAPS['process_peak_bytes'] and m['peak']>=max(self.peak,m['working_set']),'own peak')
        self.peak=m['peak']
        files=list(self.root.rglob('*'))
        need(len(files)<=128 and all(not p.is_symlink() for p in files),'owned inventory')
        need(sum(p.stat().st_size for p in files if p.is_file())+self.manifest_path.stat().st_size< CAPs_output_reserve(),'output cap/reserve')
    def write(self,p,value):
        self.guard();raw=encode(value);need(len(raw)<=131072,'record size')
        tmp=p.with_suffix(p.suffix+'.pending');need(not p.exists() and not tmp.exists(),'exclusive record')
        with tmp.open('xb') as f:f.write(raw);f.flush();os.fsync(f.fileno())
        need(not p.exists(),'record appeared');os.rename(tmp,p);self.guard()
    def wait_file(self,p):
        while not p.exists():self.guard();time.sleep(.01)
        self.guard();return load(p,131072)

def CAPs_output_reserve(): return CAPS['output_bytes']-131072

def member(win,process,job):
    b=win.w.BOOL();ok=bool(win.IsProcessInJob(process,job,win.c.byref(b)))
    event(dict(kind='membership',process_handle=int(process),job_handle=int(job),success=ok,member=bool(b.value),error=win.c.get_last_error() if not ok else None))
    need(ok,'membership query');return bool(b.value)

def account(win,job,stage,expected):
    c,w=win.c,win.w;r=win.account_snapshot(job,'benign',stage)
    class IDS(c.Structure):_fields_=[('assigned',w.DWORD),('listed',w.DWORD),('pids',c.c_size_t*8)]
    ids=IDS();n=w.DWORD();ok=bool(win.QueryInformationJobObject(job,3,c.byref(ids),c.sizeof(ids),c.byref(n)))
    r['pid_list']=dict(success=ok,assigned=int(ids.assigned),listed=int(ids.listed),returned_length=int(n.value),
                      raw_hex=c.string_at(c.byref(ids),c.sizeof(ids)).hex(),pids=[int(ids.pids[i]) for i in range(min(ids.listed,8))])
    need(len(RAW_ACCOUNTING)<64,'bounded raw accounting');RAW_ACCOUNTING.append(r)
    need(r['success'] and r['returned_length']==48 and ok and ids.assigned==ids.listed<=8,'account/PID completeness')
    need(8+8*ids.listed<=n.value<=c.sizeof(ids),'PID returned size')
    pids=r['pid_list']['pids'];need(all(p>0 for p in pids) and len(set(pids))==len(pids),'positive unique PIDs')
    need(r['decoded']['TotalProcesses']==expected and r['decoded']['TotalTerminatedProcesses']==0,'exact lifetime counts')
    return r

def job(win,limit):
    c=win.c;j=win.CreateJobObjectW(None,None);win.ok(j,'create job')
    try:
        v=win.LIMIT();v.BasicLimitInformation.LimitFlags=0x2008;v.BasicLimitInformation.ActiveProcessLimit=limit
        win.ok(win.SetInformationJobObject(j,9,c.byref(v),c.sizeof(v)),'job limits')
        got=win.LIMIT();win.ok(win.QueryInformationJobObject(j,9,c.byref(got),c.sizeof(got),None),'limits readback')
        need(got.BasicLimitInformation.LimitFlags==0x2008 and got.BasicLimitInformation.ActiveProcessLimit==limit,'exact limit readback')
        return j
    except BaseException:win.CloseHandle(j);raise

def create(ctx,role,case,directory):
    import subprocess  # quoting only, never Popen
    win=ctx.win;c,w=win.c,win.w
    class SA(c.Structure):_fields_=[('n',w.DWORD),('sd',c.c_void_p),('inherit',w.BOOL)]
    class EX(c.Structure):_fields_=[('start',win.START),('attributes',c.c_void_p)]
    need(c.sizeof(SA)==24 and c.sizeof(EX)==112,'extended ABI')
    sa=SA(c.sizeof(SA),None,True);null=None;attr=None;ready=False;pi=win.PI();created=False
    try:
        null=win.CreateFileW('NUL',0xC0000000,3,c.byref(sa),3,0,None);need(null not in (None,c.c_void_p(-1).value),'NUL')
        size=c.c_size_t();need(not win.InitializeProcThreadAttributeList(None,1,0,c.byref(size)) and 0<size.value<=65536,'attribute sizing')
        storage=c.create_string_buffer(size.value);attr=c.cast(storage,c.c_void_p)
        win.ok(win.InitializeProcThreadAttributeList(attr,1,0,c.byref(size)),'attributes');ready=True
        handles=(w.HANDLE*1)(null);win.ok(win.UpdateProcThreadAttribute(attr,0,0x20002,c.cast(handles,c.c_void_p),c.sizeof(handles),None,None),'NUL-only inheritance')
        ex=EX();ex.start.cb=c.sizeof(ex);ex.start.dwFlags=0x100
        ex.start.hStdInput=null;ex.start.hStdOutput=null;ex.start.hStdError=null;ex.attributes=attr
        argv=[str(EXE),'-I','-S','-B',str(Path(__file__).resolve()),'--manifest',str(ctx.manifest_path),'--role',role,'--case',case]
        command=c.create_unicode_buffer(subprocess.list2cmdline(argv));ctx.guard();started=time.monotonic_ns()
        win.ok(win.CreateProcessW(str(EXE),command,None,None,True,0x8000C,None,str(directory),c.cast(c.byref(ex),c.POINTER(win.START)),c.byref(pi)),'detached suspended create');created=True
        identity=win.identity(pi.hProcess);need(identity['valid'] and identity['pid']==pi.dwProcessId,'original child identity')
        return pi,dict(identity=identity,started_ns=started,argv=argv,flags=0x8000C)
    except BaseException:
        if created:cleanup_process(win,pi.hProcess,'create exception')
        for h in (pi.hThread,pi.hProcess):
            if h:win.CloseHandle(h)
        created=False
        raise
    finally:
        if ready:win.DeleteProcThreadAttributeList(attr)
        if null and not win.CloseHandle(null):
            if created:
                cleanup_process(win,pi.hProcess,'failed parent NUL close')
                win.CloseHandle(pi.hThread);win.CloseHandle(pi.hProcess)
            raise RuntimeError('close parent NUL')

def assign_resume(ctx,pi,j):
    w=ctx.win;w.ok(w.AssignProcessToJobObject(j,pi.hProcess),'assign before resume')
    need(member(w,pi.hProcess,j),'explicit assignment')
    snapshot=account(w,j,'assigned_before_resume',1)
    need(snapshot['pid_list']['pids']==[pi.dwProcessId],'assigned original PID singleton')
    ctx.guard();need(w.ResumeThread(pi.hThread)==1,'single resume')
    return snapshot

def wait_exit(ctx,handle,expected):
    win=ctx.win
    while True:
        ctx.guard();state=win.WaitForSingleObject(handle,10);ctx.guard();need(state in (0,258),'wait status')
        if state==0:break
    code=win.w.DWORD();ok=bool(win.GetExitCodeProcess(handle,win.c.byref(code)))
    m=win.memory(handle)
    result=event(dict(kind='observed_exit',handle=int(handle),exit_query_success=ok,exit_code=int(code.value),
                 observed_ns=time.monotonic_ns(),postexit_memory=m,identity=win.identity(handle)))
    need(ok and code.value==expected,'expected exit code')
    need(m['success'] and 0<m['peak']<=CAPS['process_peak_bytes'] and m['peak']>=m['working_set'],'postexit peak')
    return result

def transfer(ctx,handle,host):
    win=ctx.win;hp=win.OpenProcess(0x101040,False,host['pid']);win.ok(hp,'open validated H process')
    try:
        now=win.identity(hp);need(now['valid'] and now['pid']==host['pid'] and now['creation_filetime']==host['creation_filetime'],'H process continuity')
        out=win.w.HANDLE();win.ok(win.DuplicateHandle(win.GetCurrentProcess(),handle,hp,win.c.byref(out),0,False,2),'duplicate original object into H')
        return int(out.value)
    finally:win.ok(win.CloseHandle(hp),'close H transfer handle')

def subordinate(m,mp,role,case,root):
    win,same=native();directory=root/case;header=load(directory/'header.json');ctx=Context(win,root,header['deadline_ns'],mp)
    startup=win.identity(win.GetCurrentProcess(),current=True);need(startup['valid'],'self identity')
    ctx.write(directory/(role+'.startup.json'),dict(identity=startup,source_sha256=sha(Path(__file__)),token=m['token']))
    if role=='W':ctx.wait_file(directory/'release.json');return 0
    j=None;pi=None;complete=False
    try:
        j=job(win,2 if role=='R' else 1);empty=account(win,j,'empty',0)
        child='S' if role=='R' else 'W';pi,created=create(ctx,child,case,directory)
        packet=dict(creator=startup,child=created,process_handle=transfer(ctx,pi.hProcess,header['host']),
                    job_handle=transfer(ctx,j,header['host']),empty=empty,token=m['token'])
        ctx.write(directory/(child+'.window.json'),packet)
        ctx.wait_file(directory/(child+'.ack.json'))
        assigned=assign_resume(ctx,pi,j)
        ctx.write(directory/(child+'.assigned.json'),dict(identity=win.identity(pi.hProcess),member=member(win,pi.hProcess,j),accounting=assigned))
        if case!='normal':
            while True:ctx.guard();time.sleep(.01)  # H intentionally terminates this chain.
        result=wait_exit(ctx,pi.hProcess,0)
        ctx.write(directory/(role+'.done.json'),dict(child=result,accounting=account(win,j,'postexit',2 if role=='R' else 1)))
        complete=True;return 0
    finally:
        if not complete:
            if j:cleanup_job(win,j,'subordinate failure')
            if pi and pi.hProcess:cleanup_process(win,pi.hProcess,'subordinate original child')
        if pi:
            closed=[]
            for h in (pi.hThread,pi.hProcess):
                if h:closed.append(bool(win.CloseHandle(h)))
            if j:closed.append(bool(win.CloseHandle(j)))
            event(dict(kind='subordinate_close',success=all(closed)))
            if complete:need(all(closed),'subordinate handle close')
        elif j:win.CloseHandle(j)

def inspect_window(ctx,directory,child,host_job,narrow_ancestor,creator_identity,handles,jobs):
    win=ctx.win;packet=ctx.wait_file(directory/(child+'.window.json'))
    ph,jh=packet['process_handle'],packet['job_handle'];need(type(ph) is int and ph>0 and type(jh) is int and jh>0,'transferred handles')
    handles.append(ph);jobs.append(jh)
    actual=win.identity(ph);expected=packet['child']['identity']
    event(dict(kind='window_identity',child_role=child,packet=packet,actual=actual))
    need(packet['token']==load(ctx.manifest_path)['token'],'window token')
    need(packet['child']['argv']==[str(EXE),'-I','-S','-B',str(Path(__file__).resolve()),'--manifest',str(ctx.manifest_path),
                                  '--role',child,'--case',directory.name] and packet['child']['flags']==0x8000C,'window source/command')
    need(actual['valid'] and actual['pid']==expected['pid'] and actual['creation_filetime']==expected['creation_filetime']
         and actual['image']['path']==expected['image']['path'] and Path(actual['image']['path']).resolve()==EXE.resolve(),'duplicate original child')
    need(packet['creator']['pid']==creator_identity['pid'] and packet['creator']['creation_filetime']==creator_identity['creation_filetime'],'window creator')
    inherited=member(win,ph,host_job);ancestor=True if narrow_ancestor is None else member(win,ph,narrow_ancestor)
    premature=member(win,ph,jh)
    need(inherited and ancestor and not premature and win.WaitForSingleObject(ph,0)==258,'suspended inherited window')
    observation=dict(packet=packet,identity=actual,in_host=inherited,in_ancestor=ancestor,in_narrow=premature,
                     host_accounting=account(win,host_job,child+'_window',2 if child=='S' else 3),
                     narrow_accounting=account(win,jh,'empty_window',0))
    return ph,jh,observation

def startup(ctx,directory,role,expected):
    data=ctx.wait_file(directory/(role+'.startup.json'))
    need(set(data)=={'identity','source_sha256','token'} and data['source_sha256']==sha(Path(__file__)),'self source identity')
    m=load(ctx.manifest_path);need(data['token']==m['token'],'self token')
    actual=data['identity'];need(actual['valid'] and actual['pid']==expected['pid'] and actual['creation_filetime']==expected['creation_filetime']
         and actual['image']['path']==expected['image']['path'],'original/self identity')
    return data

def run_case(ctx,case,record):
    win=ctx.win;directory=ctx.root/case;directory.mkdir();deadline=min(ctx.deadline,time.monotonic_ns()+CAPS['case_seconds']*10**9)
    local=Context(win,ctx.root,deadline,ctx.manifest_path);handles=[];jobs=[];pi=None;j=None;success=False
    try:
        j=job(win,3);record['empty']=account(win,j,'empty',0)
        host=win.identity(win.GetCurrentProcess(),current=True)
        local.write(directory/'header.json',dict(host=host,deadline_ns=deadline))
        pi,rcreated=create(local,'R',case,directory);handles.append(pi.hProcess)
        record['R']=rcreated;record['R_assigned']=assign_resume(local,pi,j)
        record['R_self']=startup(local,directory,'R',rcreated['identity'])
        sp,rjob,sobs=inspect_window(local,directory,'S',j,None,rcreated['identity'],handles,jobs);record['windows']['S']=sobs
        if case=='gap_s':
            win.ok(win.TerminateProcess(pi.hProcess,KILL),'kill R during S gap');record['exits']['R']=wait_exit(local,pi.hProcess,KILL)
            need(win.WaitForSingleObject(sp,0)==258,'S survives owner exit before outer cleanup')
            record['outer_cleanup_required']=True
        else:
            local.write(directory/'S.ack.json',dict(allow=True))
            record['S_self']=startup(local,directory,'S',sobs['identity'])
            record['S_assigned']=local.wait_file(directory/'S.assigned.json')
            need(member(win,sp,rjob),'S assigned to R job')
            wp,sjob,wobs=inspect_window(local,directory,'W',j,rjob,sobs['identity'],handles,jobs);record['windows']['W']=wobs
            if case=='gap_w':
                win.ok(win.TerminateProcess(sp,KILL),'kill S during W gap');record['exits']['S']=wait_exit(local,sp,KILL)
                need(win.WaitForSingleObject(wp,0)==258,'W survives owner exit before outer cleanup')
                record['outer_cleanup_required']=True
            else:
                local.write(directory/'W.ack.json',dict(allow=True));record['W_self']=startup(local,directory,'W',wobs['identity'])
                record['W_assigned']=local.wait_file(directory/'W.assigned.json')
                need(member(win,wp,sjob),'W assigned to S job');local.write(directory/'release.json',dict(complete=True))
        if case!='normal':win.ok(win.TerminateJobObject(j,KILL),'explicit outer cleanup')
        for name,h in zip(['R','S','W'],handles):
            record['exits'][name]=wait_exit(local,h,0 if case=='normal' else KILL)
            expected=rcreated['identity'] if name=='R' else record['windows'][name]['identity']
            actual=record['exits'][name]['identity']
            need(actual['valid'] and all(actual[k]==expected[k] for k in ('pid','creation_filetime','image')),'retained postexit identity')
        record['host_final']=account(win,j,'postexit',2 if case=='gap_s' else 3)
        record['narrow_final']=[account(win,x,'postexit',n) for x,n in zip(jobs,[0] if case=='gap_s' else [2,0 if case=='gap_w' else 1])]
        peak_sum=local.peak+sum(x['postexit_memory']['peak'] for x in record['exits'].values())
        need(peak_sum<=CAPS['aggregate_peak_bytes'],'conservative aggregate peaks');record['peak_sum']=peak_sum
        record['status']='PASS';success=True;return record
    finally:
        if not success:
            if j:cleanup_job(win,j,'H case failure')
            if pi and pi.hProcess:
                event(dict(kind='terminate_original_R',success=bool(win.TerminateProcess(pi.hProcess,KILL)),
                           handle=int(pi.hProcess)))
            cleanup_until=time.monotonic_ns()+CAPS['cleanup_seconds']*10**9
            for h in handles:
                state=int(win.WaitForSingleObject(h,max(0,(cleanup_until-time.monotonic_ns())//1_000_000)))
                event(dict(kind='case_cleanup_wait',handle=int(h),wait_status=state,exit_observed=state==0))
        closed=[]
        if pi and pi.hThread:closed.append(bool(win.CloseHandle(pi.hThread)))
        for h in handles+jobs+([j] if j else []):closed.append(bool(win.CloseHandle(h)))
        if success and not all(closed):
            record['status']='INCOMPLETE';need(False,'final handle close')

def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--manifest',type=Path,required=True)
    parser.add_argument('--role',choices=['H','R','S','W'],default='H');parser.add_argument('--case',choices=CASES)
    args=parser.parse_args();m,mp=manifest(args.manifest)
    root=clean(HERE/('rational_j7_containment_'+m['token']))
    if args.role!='H':
        need(args.case is not None and root.is_dir(),'child context')
        try:return subordinate(m,mp,args.role,args.case,root)
        except BaseException as exc:
            try:failure_file(root,root/args.case,args.role+'.failure.json',exc,mp)
            except BaseException:pass
            return 1
    need(args.case is None and not root.exists(),'one attempt only');root.mkdir()
    win,_=native();ctx=Context(win,root,BOOT+CAPS['total_seconds']*10**9,mp)
    result=dict(schema='rational-j7-host-containment-capability-1',status='INCOMPLETE',topology=['H','R','S','W'],
                active_limits=[3,2,1],detached=True,suspended_assignment=True,pins=m['pins'],manifest_sha256=sha(mp),cases=[],raw_accounting=RAW_ACCOUNTING,raw_events=RAW_EVENTS)
    try:
        ctx.write(root/'attempt.json',dict(manifest_sha256=sha(mp),token=m['token']))
        for case in CASES:
            record=dict(case=case,status='INCOMPLETE',windows={},exits={});result['cases'].append(record)
            run_case(ctx,case,record)
        result['status']='PASS';ctx.guard()
    except BaseException as exc:result.update(status='FAIL',error=type(exc).__name__+': '+str(exc)[:2000])
    result['elapsed_ns']=time.monotonic_ns()-BOOT
    # A timed-out attempt must still preserve its bounded failure record. It can
    # never regain PASS, and the external coordinator must observe actual exit.
    if time.monotonic_ns()>=ctx.deadline:result['status']='FAIL';result['final_deadline_failed']=True
    raw=encode(result);need(len(raw)<=524288,'final record bound')
    size=sum(p.stat().st_size for p in root.rglob('*') if p.is_file())+mp.stat().st_size
    need(size+len(raw)<=CAPS['output_bytes'],'final output cap')
    with (root/'result.json').open('xb') as f:f.write(raw);f.flush();os.fsync(f.fileno())
    if result['status']=='PASS':ctx.guard()
    return 0 if result['status']=='PASS' else 1

if __name__=='__main__':
    try:code=main()
    except BaseException:code=1
    raise SystemExit(code)
