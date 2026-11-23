"""Prepared detached/suspended lifecycle. Imported only after source pin checks."""
import ctypes as c
from ctypes import wintypes as w
import subprocess  # list2cmdline only; no Popen
import time
from pathlib import Path
from rational_j7_supervision_20261111_common import need, EXE
from rational_j7_supervision_20261111_native import Win, identity_match

def memory(win,handle,cap,previous=0):
    value=win.memory(handle)
    need(value['success'] and 0<value['peak']<=cap and value['peak']>=max(previous,value['working_set']), 'memory query/cap')
    return value

class Managed:
    def __init__(self,win,owner,role,active_limit,expected_total,seconds,peak_cap,guard):
        self.win=win; self.owner=owner; self.role=role; self.active=active_limit
        self.total=expected_total; self.seconds=seconds; self.cap=peak_cap; self.guard=guard
        self.job=None; self.pi=None; self.attr=None; self.attr_ready=False; self.pipes={}; self.null=None
        self.record=dict(role=role,status='INCOMPLETE',accounting=[],peak_samples_max=0,
                         created=False,assigned=False,resumed=False)
        self.started=None; self.exited=False; self.logs={}
        k=c.WinDLL('kernel32',use_last_error=True)
        def bind(name,args,result=w.BOOL):
            f=getattr(k,name); f.argtypes=args; f.restype=result; return f
        H,D,P=w.HANDLE,w.DWORD,c.c_void_p
        self.create_pipe=bind('CreatePipe',[c.POINTER(H),c.POINTER(H),P,D])
        self.set_info=bind('SetHandleInformation',[H,D,D])
        self.peek=bind('PeekNamedPipe',[H,P,D,P,c.POINTER(D),P])
        self.read_file=bind('ReadFile',[H,P,D,c.POINTER(D),P])
        self.create_file=bind('CreateFileW',[w.LPCWSTR,D,D,P,D,D,H],H)
        self.init_attr=bind('InitializeProcThreadAttributeList',[P,D,D,c.POINTER(c.c_size_t)])
        self.update_attr=bind('UpdateProcThreadAttribute',[P,D,c.c_size_t,P,c.c_size_t,P,P])
        self.delete_attr=bind('DeleteProcThreadAttributeList',[P],None)
        self.terminate_job=bind('TerminateJobObject',[H,w.UINT])
    def account(self,stage,expected=None):
        r=self.win.account_snapshot(self.job,self.role,stage); self.record['accounting'].append(r)
        class IDS(c.Structure):
            _fields_=[('assigned',w.DWORD),('listed',w.DWORD),('pids',c.c_size_t*8)]
        ids=IDS(); size=w.DWORD()
        ok=bool(self.win.QueryInformationJobObject(self.job,3,c.byref(ids),c.sizeof(ids),c.byref(size)))
        r['pid_list']=dict(success=ok,assigned=int(ids.assigned),listed=int(ids.listed),returned_length=int(size.value),
                          raw_hex=c.string_at(c.byref(ids),c.sizeof(ids)).hex(),pids=[int(ids.pids[i]) for i in range(min(8,ids.listed))])
        need(r['success'] and r['returned_length']==c.sizeof(self.win.ACCOUNT),'accounting query')
        need(ok and ids.assigned==ids.listed and ids.listed<=8 and 8+8*ids.listed<=size.value<=c.sizeof(ids),'complete PID list')
        pids=r['pid_list']['pids']; need(all(pid>0 for pid in pids) and len(set(pids))==len(pids),'positive unique PIDs')
        if stage=='empty': need(pids==[],'empty job')
        if stage=='assigned_before_resume': need(pids==[self.pi.dwProcessId],'original PID singleton')
        if expected is not None:
            need(r['decoded']['TotalProcesses']==expected and r['decoded']['TotalTerminatedProcesses']==0,'job lifetime totals')
        return r['decoded']
    def check(self):
        self.guard(); self.owner.guard()
        if self.started is not None: need(time.monotonic_ns()-self.started<self.seconds*10**9,'managed deadline')
    def start(self,argv,cwd):
        win=self.win
        class SA(c.Structure):
            _fields_=[('nLength',w.DWORD),('lpSecurityDescriptor',c.c_void_p),('bInheritHandle',w.BOOL)]
        class EX(c.Structure):
            _fields_=[('StartupInfo',win.START),('lpAttributeList',c.c_void_p)]
        need(c.sizeof(SA)==24 and c.sizeof(EX)==112,'extended ABI')
        sa=SA(c.sizeof(SA),None,True)
        self.job=win.CreateJobObjectW(None,None); win.ok(self.job,'create job')
        limits=win.LIMIT(); limits.BasicLimitInformation.LimitFlags=0x2008
        limits.BasicLimitInformation.ActiveProcessLimit=self.active
        win.ok(win.SetInformationJobObject(self.job,9,c.byref(limits),c.sizeof(limits)),'set job limits')
        actual=win.LIMIT(); win.ok(win.QueryInformationJobObject(self.job,9,c.byref(actual),c.sizeof(actual),None),'read job limits')
        need(actual.BasicLimitInformation.LimitFlags==0x2008 and actual.BasicLimitInformation.ActiveProcessLimit==self.active,'job limits mismatch')
        self.account('empty',0)
        for name in ('stdout','stderr'):
            self.logs[name]=(self.owner.directory/(self.role+'.'+name)).open('xb',buffering=0)
            rh,wh=w.HANDLE(),w.HANDLE()
            win.ok(self.create_pipe(c.byref(rh),c.byref(wh),c.byref(sa),4096),'pipe')
            self.pipes[name]=dict(read=rh.value,write=wh.value,closed=False,count=0)
            win.ok(self.set_info(rh,1,0),'reader inheritance')
        self.null=self.create_file('NUL',0x80000000,3,c.byref(sa),3,0,None)
        need(self.null not in (None,c.c_void_p(-1).value),'stdin NUL')
        size=c.c_size_t()
        need(not self.init_attr(None,1,0,c.byref(size)) and 0<size.value<=65536,'attribute sizing')
        self.storage=c.create_string_buffer(size.value); self.attr=c.cast(self.storage,c.c_void_p)
        win.ok(self.init_attr(self.attr,1,0,c.byref(size)),'attribute initialization'); self.attr_ready=True
        handles=(w.HANDLE*3)(self.null,self.pipes['stdout']['write'],self.pipes['stderr']['write'])
        win.ok(self.update_attr(self.attr,0,0x20002,c.cast(handles,c.c_void_p),c.sizeof(handles),None,None),'handle allowlist')
        sx=EX(); sx.StartupInfo.cb=c.sizeof(sx); sx.StartupInfo.dwFlags=0x100
        sx.StartupInfo.hStdInput=self.null; sx.StartupInfo.hStdOutput=handles[1]; sx.StartupInfo.hStdError=handles[2]; sx.lpAttributeList=self.attr
        command=c.create_unicode_buffer(subprocess.list2cmdline([str(EXE),'-I','-S','-B',*map(str,argv)]))
        self.pi=win.PI(); self.check(); self.started=time.monotonic_ns()
        win.ok(win.CreateProcessW(str(EXE),command,None,None,True,0x8000C,None,str(cwd),c.cast(c.byref(sx),c.POINTER(win.START)),c.byref(self.pi)),'detached suspended create')
        self.record['created']=True
        self.record.update(started_ns=self.started,argv=[str(EXE),'-I','-S','-B',*map(str,argv)],cwd=str(cwd),flags=0x8000C,
                           creator_pid=int(win.GetCurrentProcessId()),identity=win.identity(self.pi.hProcess))
        identity=self.record['identity']; need(identity['valid'] and identity['pid']==self.pi.dwProcessId and Path(identity['image']['path']).resolve()==EXE.resolve(),'created image/identity')
        win.ok(win.AssignProcessToJobObject(self.job,self.pi.hProcess),'assign before resume')
        self.record['assigned']=True
        belongs=w.BOOL(); win.ok(win.IsProcessInJob(self.pi.hProcess,self.job,c.byref(belongs)),'explicit job membership'); need(belongs.value,'membership false')
        self.account('assigned_before_resume',1); self.check()
        for p in self.pipes.values():
            win.ok(win.CloseHandle(p['write']),'close parent pipe writer before resume')
            p['write']=None
        win.ok(win.CloseHandle(self.null),'close parent NUL before resume')
        self.null=None
        need(win.ResumeThread(self.pi.hThread)==1,'single resume')
        self.record['resumed']=True
    def drain(self):
        for name,p in self.pipes.items():
            if p['closed']: continue
            available=w.DWORD()
            if not self.peek(p['read'],None,0,None,c.byref(available),None):
                need(c.get_last_error()==109,'pipe peek'); p['closed']=True; continue
            size=min(available.value,4096)
            if not size: continue
            data=c.create_string_buffer(size); got=w.DWORD()
            self.win.ok(self.read_file(p['read'],data,size,c.byref(got),None),'pipe read')
            p['count']+=got.value; need(p['count']<=16384,'per-stream cap')
            self.logs[name].write(data.raw[:got.value])
    def wait(self):
        while True:
            self.check(); self.drain()
            mem=memory(self.win,self.pi.hProcess,self.cap,self.record['peak_samples_max']); self.record['peak_samples_max']=mem['peak']
            state=self.win.WaitForSingleObject(self.pi.hProcess,20); need(state in (0,258),'wait result')
            self.check()  # Also rejects late signaled exits.
            if state==0:
                self.exited=True; self.record['observed_exit_ns']=time.monotonic_ns(); break
        self.record['postexit_memory']=memory(self.win,self.pi.hProcess,self.cap,self.record['peak_samples_max'])
        self.record['postexit_identity']=self.win.identity(self.pi.hProcess)
        need(identity_match(self.record['postexit_identity'],self.record['identity']),'postexit identity')
        code=w.DWORD(); self.win.ok(self.win.GetExitCodeProcess(self.pi.hProcess,c.byref(code)),'exit query')
        self.record['exit_code']=code.value
        self.record['final_accounting']=self.account('postexit',self.total)
        for _ in range(32):
            self.guard(); self.drain()
            if all(p['closed'] for p in self.pipes.values()): break
        need(all(p['closed'] for p in self.pipes.values()),'inherited writer remains')
        need(code.value==0,'managed child exit failure')
        self.record['status']='MANAGED_EXIT_VALIDATED'; return self.record
    def close(self,success):
        closed=[]
        def close_handle(handle):
            if handle: closed.append(bool(self.win.CloseHandle(handle)))
        if not success and self.job:
            self.record['terminate_job_success']=bool(self.terminate_job(self.job,0xC8F2))
        if not success and self.record['created'] and not self.exited:
            # Creation may succeed before assignment fails. The retained original
            # handle also covers that suspended process outside the inner job.
            self.record['terminate_original_success']=bool(self.win.TerminateProcess(self.pi.hProcess,0xC8F2))
        if self.pi and self.pi.hProcess and not self.exited:
            # Cleanup is bounded independently of an already expired scientific timer.
            self.record['cleanup_exit_observed']=self.win.WaitForSingleObject(self.pi.hProcess,2000)==0
        for p in self.pipes.values():
            for k in ('read','write'):
                if p[k]: close_handle(p[k]); p[k]=None
        for f in self.logs.values(): f.close()
        if self.null: close_handle(self.null)
        if self.attr_ready: self.delete_attr(self.attr)
        if self.pi:
            for h in (self.pi.hThread,self.pi.hProcess):
                if h: close_handle(h)
        if self.job: close_handle(self.job)
        return all(closed)
