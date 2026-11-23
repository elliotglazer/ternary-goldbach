"""PREPARATION ONLY: external H for one separately authorized rational-j7 phase.

No native library or evaluator is imported by source/AST inspection. The runtime
request must bind this source, its review/contract, and additional nesting evidence.
"""
import time
HOST_START_NS = time.monotonic_ns()
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import sys

HERE = Path(__file__).resolve().parent
INTEGRATION = HERE.parent / 'integration'
PREFIX = 'rational_j7_supervision_20261111'
SOURCE_PINS = {
    PREFIX+'_common.py': '0BB49255BCF82307BACFB3BA353A3D83217C2023D37DCCDAFE6DDE98623CF154',
    PREFIX+'_managed.py': 'F90F2DCC39A2659C2AF372EFEC19CCA73A3E679CE2AFDDAC12DABC0E209423C9',
    PREFIX+'_native.py': 'CFC956B179C45AFAEAB5EA1DB42B05C06C643D0A10EC1682CBE0433248248E13',
    PREFIX+'_run.py': '755300B91BA4780D5713DEC6C192E6F60AF50ABE6330F1C258F95C59DD28486C',
}
CONTRACT = HERE / 'RATIONAL_J7_HOST_PREPARATION_2026-11-11.md'


def need(ok, why):
    if not ok:
        raise RuntimeError(why)


def digest(raw):
    return hashlib.sha256(raw).hexdigest().upper()


def unique(items):
    out = {}
    for key, value in items:
        need(key not in out, 'duplicate request key')
        out[key] = value
    return out


def load_sources(request):
    """Check bytes before importing only the reviewed infrastructure modules."""
    need(type(request) is dict and request.get('sources') == SOURCE_PINS, 'exact S/R source set')
    self_ref = request.get('host_source')
    need(self_ref == {'path':'audit/'+Path(__file__).name,
                     'sha256':digest(Path(__file__).read_bytes())}, 'host source reference')
    need(request.get('host_source_sha256') == self_ref['sha256'], 'host self hash')
    need(request.get('host_contract') == {'path':'audit/'+CONTRACT.name,
                     'sha256':digest(CONTRACT.read_bytes())}, 'host contract')
    for name, expected in SOURCE_PINS.items():
        path = INTEGRATION/name
        need(not path.is_symlink() and path.stat().st_size <= 131072, 'source path/size')
        need(digest(path.read_bytes()) == expected, 'source bytes: '+name)
    sys.dont_write_bytecode = True
    for suffix in ('_common', '_native', '_managed'):
        name = PREFIX+suffix
        need(name not in sys.modules, 'unexpected preloaded module')
        spec = importlib.util.spec_from_file_location(name, INTEGRATION/(name+'.py'))
        module = importlib.util.module_from_spec(spec)
        sys.modules[name] = module
        spec.loader.exec_module(module)
    return sys.modules[PREFIX+'_common'], sys.modules[PREFIX+'_managed']


def make_host_process_type(C, N):
    """Construct the native adapter only in an authorized runtime invocation."""
    c, w = N.c, N.w

    class HostProcess(N.Managed):
        # Inherit only reviewed API bindings, raw accounting and deadline checks.
        # H owns no phase-directory files until R exits or fails; streams buffer.
        def __init__(self, win, owner, guard, limit):
            super().__init__(win, owner, 'host', 3, 3, limit, 128*1024**2, guard)
            self.buffers = {'stdout':bytearray(), 'stderr':bytearray()}
            self.record['cleanup_observations'] = []
            self.record['stream_bytes_seen'] = {'stdout':0, 'stderr':0}
            self.record['limits_readback'] = None

        def start(self, argv, cwd):
            win = self.win
            class SA(c.Structure):
                _fields_ = [('nLength',w.DWORD),('lpSecurityDescriptor',c.c_void_p),('bInheritHandle',w.BOOL)]
            class EX(c.Structure):
                _fields_ = [('StartupInfo',win.START),('lpAttributeList',c.c_void_p)]
            need(c.sizeof(SA)==24 and c.sizeof(EX)==112, 'extended ABI')
            sa = SA(c.sizeof(SA),None,True)
            self.job = win.CreateJobObjectW(None,None)
            win.ok(self.job,'create H job')
            limits = win.LIMIT()
            limits.BasicLimitInformation.LimitFlags = 0x2008
            limits.BasicLimitInformation.ActiveProcessLimit = 3
            win.ok(win.SetInformationJobObject(self.job,9,c.byref(limits),c.sizeof(limits)),'H limits')
            actual = win.LIMIT()
            win.ok(win.QueryInformationJobObject(self.job,9,c.byref(actual),c.sizeof(actual),None),'H limits readback')
            self.record['limits_readback'] = dict(active_limit=int(actual.BasicLimitInformation.ActiveProcessLimit),
                                                 limit_flags=int(actual.BasicLimitInformation.LimitFlags))
            need(self.record['limits_readback']==dict(active_limit=3,limit_flags=8200),'H limit mismatch')
            self.account('empty',0)
            for name in self.buffers:
                rh, wh = w.HANDLE(), w.HANDLE()
                win.ok(self.create_pipe(c.byref(rh),c.byref(wh),c.byref(sa),4096),'H pipe')
                self.pipes[name] = dict(read=rh.value,write=wh.value,closed=False,count=0)
                win.ok(self.set_info(rh,1,0),'H reader noninheritance')
            self.null = self.create_file('NUL',0x80000000,3,c.byref(sa),3,0,None)
            need(self.null not in (None,c.c_void_p(-1).value),'H NUL stdin')
            size = c.c_size_t()
            need(not self.init_attr(None,1,0,c.byref(size)) and 0<size.value<=65536,'H attribute size')
            self.storage = c.create_string_buffer(size.value)
            self.attr = c.cast(self.storage,c.c_void_p)
            win.ok(self.init_attr(self.attr,1,0,c.byref(size)),'H attributes')
            self.attr_ready = True
            handles = (w.HANDLE*3)(self.null,self.pipes['stdout']['write'],self.pipes['stderr']['write'])
            win.ok(self.update_attr(self.attr,0,0x20002,c.cast(handles,c.c_void_p),c.sizeof(handles),None,None),'H handle allowlist')
            sx = EX(); sx.StartupInfo.cb = c.sizeof(sx); sx.StartupInfo.dwFlags = 0x100
            sx.StartupInfo.hStdInput = handles[0]; sx.StartupInfo.hStdOutput = handles[1]; sx.StartupInfo.hStdError = handles[2]
            sx.lpAttributeList = self.attr
            full = [str(C.EXE),'-I','-S','-B',*map(str,argv)]
            command = c.create_unicode_buffer(N.subprocess.list2cmdline(full))
            self.pi = win.PI(); self.check(); self.started = time.monotonic_ns()
            win.ok(win.CreateProcessW(str(C.EXE),command,None,None,True,0x8000C,None,str(cwd),
                                     c.cast(c.byref(sx),c.POINTER(win.START)),c.byref(self.pi)),'H suspended detached R')
            self.record.update(created=True,started_ns=self.started,argv=full,cwd=str(cwd),flags=0x8000C,
                               creator_pid=int(win.GetCurrentProcessId()),identity=win.identity(self.pi.hProcess))
            C.identity_valid(self.record['identity'])
            need(self.record['identity']['pid']==int(self.pi.dwProcessId),'original R PID')
            # The original handle remains owned even if assignment fails.
            win.ok(win.AssignProcessToJobObject(self.job,self.pi.hProcess),'H assign before resume')
            self.record['assigned'] = True
            member = w.BOOL()
            win.ok(win.IsProcessInJob(self.pi.hProcess,self.job,c.byref(member)),'H membership')
            need(member.value,'R not in H job')
            self.account('assigned_before_resume',1)
            self.check()  # A late CreateProcess must never resume after the deadline.
            for p in self.pipes.values():
                win.ok(win.CloseHandle(p['write']),'close H writer'); p['write'] = None
            win.ok(win.CloseHandle(self.null),'close H NUL'); self.null = None
            need(win.ResumeThread(self.pi.hThread)==1,'single R resume')
            self.record['resumed'] = True

        def drain(self):
            for name,p in self.pipes.items():
                if p['closed']: continue
                available = w.DWORD()
                if not self.peek(p['read'],None,0,None,c.byref(available),None):
                    need(c.get_last_error()==109,'H pipe peek')
                    p['closed'] = True; continue
                size = min(int(available.value),4096)
                if not size: continue
                data = c.create_string_buffer(size); got = w.DWORD()
                self.win.ok(self.read_file(p['read'],data,size,c.byref(got),None),'H pipe read')
                self.record['stream_bytes_seen'][name] += int(got.value)
                # Record overrun, but never retain more than 16 KiB per stream.
                remaining = max(0,16384-len(self.buffers[name]))
                self.buffers[name].extend(data.raw[:min(int(got.value),remaining)])
                need(self.record['stream_bytes_seen'][name]<=16384,'H stream cap')

        def wait(self):
            while True:
                self.check(); self.drain()
                state = self.win.WaitForSingleObject(self.pi.hProcess,20)
                need(state in (0,258),'H R wait')
                if state==0:
                    self.exited = True
                    self.record['observed_exit_ns'] = time.monotonic_ns()
                self.check()  # Late signaled exit also fails.
                if self.exited: break
            self.record['postexit_identity'] = self.win.identity(self.pi.hProcess)
            need(N.identity_match(self.record['postexit_identity'],self.record['identity']),'H R identity continuity')
            code = w.DWORD()
            self.win.ok(self.win.GetExitCodeProcess(self.pi.hProcess,c.byref(code)),'H R exit code')
            self.record['exit_code'] = int(code.value)
            self.record['final_accounting'] = self.account('postexit',3)
            C.accounting_valid(self.record['accounting'],3,self.record['final_accounting'],self.record['identity']['pid'])
            for _ in range(32):
                self.check(); self.drain()
                if all(p['closed'] for p in self.pipes.values()): break
            need(all(p['closed'] for p in self.pipes.values()),'H inherited writer remains')
            need(code.value==0,'R nonzero exit')
            need(not any(self.buffers.values()),'unexpected R console')
            self.record['status'] = 'HOST_R_EXIT_VALIDATED'

        def observe_cleanup(self):
            """Bounded job-member observation; no PID-based termination."""
            deadline = time.monotonic_ns()+2_000_000_000
            if self.job:
                self.record['terminate_job_success'] = bool(self.terminate_job(self.job,0xC8F2))
            if self.pi and self.pi.hProcess and not self.exited:
                # Covers failure before R's H-job assignment as well.
                self.record['terminate_original_success'] = bool(self.win.TerminateProcess(self.pi.hProcess,0xC8F2))
                state = self.win.WaitForSingleObject(self.pi.hProcess,max(0,(deadline-time.monotonic_ns())//1_000_000))
                self.record['cleanup_R_exit_observed'] = state==0
                if state==0: self.exited=True
            class IDS(c.Structure):
                _fields_ = [('assigned',w.DWORD),('listed',w.DWORD),('pids',c.c_size_t*8)]
            finished = False
            for _ in range(8):
                if not self.job or time.monotonic_ns()>=deadline: break
                ids=IDS(); size=w.DWORD(); c.set_last_error(0)
                ok=bool(self.win.QueryInformationJobObject(self.job,3,c.byref(ids),c.sizeof(ids),c.byref(size)))
                row=dict(success=ok,error_on_failure=None if ok else c.get_last_error(),returned_length=int(size.value),
                         assigned=int(ids.assigned),listed=int(ids.listed),raw_hex=c.string_at(c.byref(ids),c.sizeof(ids)).hex(),entries=[])
                self.record['cleanup_observations'].append(row)
                complete=ok and ids.assigned==ids.listed<=8 and 8+8*ids.listed<=size.value<=c.sizeof(ids)
                pids=[int(ids.pids[i]) for i in range(min(8,int(ids.listed)))]
                complete=complete and len(set(pids))==len(pids) and all(x>0 for x in pids)
                row['complete']=complete
                if not complete: break
                remaining=[pid for pid in pids if not self.pi or pid!=int(self.pi.dwProcessId)]
                if not remaining:
                    finished=True; break
                for pid in remaining:
                    h=self.win.OpenProcess(0x101000,False,pid)
                    entry=dict(pid=pid,opened=bool(h)); row['entries'].append(entry)
                    if not h: continue
                    try:
                        member=w.BOOL(); ok=bool(self.win.IsProcessInJob(h,self.job,c.byref(member)))
                        entry.update(membership_success=ok,member=bool(member.value),identity=self.win.identity(h))
                        if ok and member.value:
                            entry['wait_state']=int(self.win.WaitForSingleObject(h,max(0,(deadline-time.monotonic_ns())//1_000_000)))
                    finally: self.win.CloseHandle(h)
            self.record['cleanup_other_members_absent']=finished
            self.record['cleanup_complete']=finished and self.exited

        def release(self):
            # Cleanup waits belong only to observe_cleanup's shared two-second
            # budget. Never start the inherited close() method's extra wait.
            outcomes=[]
            def close(handle):
                if handle: outcomes.append(bool(self.win.CloseHandle(handle)))
            for p in self.pipes.values():
                for name in ('read','write'):
                    close(p[name]); p[name]=None
            close(self.null); self.null=None
            if self.attr_ready:
                self.delete_attr(self.attr); self.attr_ready=False
            if self.pi:
                close(self.pi.hThread); close(self.pi.hProcess)
                self.pi.hThread=None; self.pi.hProcess=None
            close(self.job); self.job=None
            self.record['handle_close_results']=outcomes
            self.record['handles_closed']=True
            return all(outcomes)

    return HostProcess


def main():
    sys.set_int_max_str_digits(21000)  # Match the reviewed S/R scientific parser.
    need(len(sys.argv)==3 and sys.argv[1]=='--request-json','exact H arguments')
    raw_request=sys.argv[2]
    need(len(raw_request.encode('utf-8'))<=24000,'bounded request argument')
    request=json.loads(raw_request,object_pairs_hook=unique,
                       parse_constant=lambda _: (_ for _ in ()).throw(RuntimeError('nonfinite request')))
    need(type(request) is dict and 'host_start_ns' not in request,'H alone supplies start timestamp')
    need(type(request.get('token')) is str and re.fullmatch('[a-f0-9]{32}',request['token']),'token')
    need(request.get('phase') in ('producer','independent'),'phase')
    C,N=load_sources(request)
    limit=750 if request['phase']=='producer' else 1050
    m=dict(request,host_start_ns=HOST_START_NS)
    authorization=C.clean(INTEGRATION/('rational_j7_authorization_'+m['token']+'.json'))
    owner=C.Ownership(m,authorization)
    need(not authorization.exists() and not owner.directory.exists() and not any(p.exists() for p in owner.worker),'exclusive phase namespace')
    record=dict(schema='rational-j7-host-failure-1',status='INCOMPLETE',host_started_ns=HOST_START_NS,
                host_source_sha256=digest(Path(__file__).read_bytes()),errors=[])
    child=None; auth_owned=False; success=False; streams_written=False
    def guard():
        elapsed=time.monotonic_ns()-HOST_START_NS
        need(0<=elapsed<limit*10**9,'H whole-phase deadline')
        if child is None or not child.record['resumed']:
            need(elapsed<30*10**9,'H/R prelaunch deadline')
        buffered=sum(len(x) for x in child.buffers.values()) if child and not streams_written else 0
        if auth_owned: owner.guard(65536+buffered)
    def streams():
        nonlocal streams_written
        if not owner.directory.exists(): owner.directory.mkdir()  # Only after R exit/failure cleanup.
        C.clean(owner.directory)
        for name in ('stdout','stderr'):
            p=owner.directory/('host.'+name)
            data=bytes(child.buffers[name]) if child else b''
            need(not p.exists(),'host stream already exists')
            with p.open('xb') as f: f.write(data); f.flush(); os.fsync(f.fileno())
        streams_written=True
    try:
        guard()
        raw=C.encode(m); need(len(raw)<=65536,'authorization size')
        with authorization.open('xb') as f:
            auth_owned=True; f.write(raw); f.flush(); os.fsync(f.fileno())
        auth_hash=C.sha(authorization)
        need(C.exact(C.validate_authorization(authorization),m),'authorization validation')
        guard()
        child=make_host_process_type(C,N)(N.Win(),owner,guard,limit)
        child.start([INTEGRATION/(PREFIX+'_run.py'),'--role','R','--authorization',authorization],INTEGRATION)
        child.wait(); guard()
        record['managed_R']=child.record
        need(child.release(),'H handle close')
        streams(); guard()
        need(C.sha(authorization)==auth_hash and C.exact(C.validate_authorization(authorization),m),'postexit source/authorization binding')
        seal_path=owner.directory/'r_seal.json'; seal=C.load(seal_path)
        C.identity_valid(seal['startup'])
        need(N.identity_match(seal['startup'],child.record['identity']),'actual R startup binding')
        need(seal.get('status')=='R_PROVISIONAL','R provisional seal')
        candidate=C.output_summary(m); need(candidate==seal.get('candidate'),'final candidate binding')
        ref=lambda p: dict(path=p.relative_to(C.AGENTS).as_posix(),sha256=C.sha(p))
        host=dict(schema='rational-j7-host-1',status='HOST_OBSERVED_COMPLETE',authorization=ref(authorization),
                  r_seal=ref(seal_path),r_identity=child.record['identity'],r_postexit_identity=child.record['postexit_identity'],
                  original_handle_exit_observed=True,exit_code=child.record['exit_code'],
                  host_started_ns=HOST_START_NS,r_observed_exit_ns=child.record['observed_exit_ns'],
                  elapsed_ns=time.monotonic_ns()-HOST_START_NS,aggregate_bytes=0,
                  host_contract=m['host_contract'],host_source_sha256=m['host_source_sha256'],
                  r_launch=dict(argv=child.record['argv'],cwd=child.record['cwd'],flags=child.record['flags'],
                                creator_pid=child.record['creator_pid'],assigned_before_resume=child.record['assigned']),
                  host_job=dict(active_limit=3,limit_flags=8200,assigned=child.record['assigned'],
                                accounting=child.record['accounting'],final_accounting=child.record['final_accounting']),
                  streams={name:dict(bytes=(owner.directory/('host.'+name)).stat().st_size,
                                     sha256=C.sha(owner.directory/('host.'+name))) for name in ('stdout','stderr')},
                  containment_capability=m['host_capability'])
        base=sum(x['bytes'] for x in owner.guard(0))
        for _ in range(8):
            count=base+len(C.encode(host))
            if count==host['aggregate_bytes']: break
            host['aggregate_bytes']=count
        need(base+len(C.encode(host))==host['aggregate_bytes'],'host size fixed point')
        guard(); path=owner.publish('host.json',host)
        chain=dict(authorization=ref(authorization),r_seal=ref(seal_path),host=ref(path),candidate=candidate)
        C.validate_host_chain(chain); guard()
        # No success stdout: the host file and actual H exit must both be checked.
        success=True
    except BaseException as exc:
        record['errors'].append(type(exc).__name__+': '+str(exc)[:1500])
    finally:
        if child is not None and not child.record.get('handles_closed'):
            try: child.observe_cleanup()
            except BaseException as exc: record['errors'].append('cleanup observation: '+str(exc)[:1000])
            try:
                need(child.release(),'H cleanup handle close')
            except BaseException as exc: record['errors'].append('cleanup close: '+str(exc)[:1000])
            record['managed_R']=child.record
        if not success and auth_owned:
            try:
                if not streams_written: streams()
                record['elapsed_ns']=time.monotonic_ns()-HOST_START_NS
                record['inventory']=owner.inventory()
                record['observed_aggregate_bytes']=sum(x['bytes'] for x in record['inventory'])
                record['within_cap']=record['observed_aggregate_bytes']<=C.CAP
                owner.publish('host_failure.json',record,cap=32768)
            except BaseException:
                # Missing final failure bytes never substitute for actual H exit 0.
                pass
    return 0 if success else 1


if __name__=='__main__':
    try:
        exit_code=main()
    except BaseException:
        # A pre-ownership failure has no right to create arbitrary error files.
        # Silence avoids unbounded, unaccounted H console output; exit is failure.
        exit_code=1
    raise SystemExit(exit_code)
