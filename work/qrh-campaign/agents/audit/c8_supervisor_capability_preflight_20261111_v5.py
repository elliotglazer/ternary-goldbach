"""PREPARATION ONLY. One hash-authorized benign Windows capability attempt.

No Windows API is imported/called before manifest validation. This is not an
evaluator and does not establish a universal post-exit memory-query guarantee.
"""
import time
BOOT_NS = time.monotonic_ns()  # excludes interpreter startup; external timing is required
import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import sys

HERE = Path(__file__).resolve().parent
CHILD = HERE / "c8_supervisor_benign_child_20261111_v4.py"
SPEC = HERE / "C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V5_2026-11-11.md"
EXE = Path("C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe")
EXE_SHA = "4942B86A6597E5AEE0128DAA00050ED79BC21F6E709A78EB19CBFEB0C2F39AC9"
DESIGN = "EF2EF80F930AA029DE7418C9759A01465A867A40DFACAA0F9FE9B67ED8FC6B19"
DESIGN_REVIEW = "AEA656CCB32B74151CB570EDFA58A63104771AF7E764DE9B95789299856251DF"
CAPS = dict(total_ns=30_000_000_000, normal_ns=15_000_000_000,
            timeout_ns=1_000_000_000, cleanup_ns=2_000_000_000,
            peak_bytes=256*1024*1024, aggregate_peak_bytes=256*1024*1024,
            output_bytes=4*1024*1024,
            explicit_allocation_bytes=48*1024*1024)
KILL_CODE = 0xC8F1


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def sha(raw):
    return hashlib.sha256(raw).hexdigest().upper()


def encoded(obj):
    return (json.dumps(obj, sort_keys=True, separators=(",", ":")) + "\n").encode()


def bounded_read(path, cap):
    with path.open("rb") as stream:
        raw = stream.read(cap + 1)
    require(len(raw) <= cap, "oversized input: " + str(path))
    return raw


def unique_keys(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, "duplicate JSON key")
        result[key] = value
    return result


def load_manifest(path):
    raw = bounded_read(path, 16384)
    m = json.loads(raw, object_pairs_hook=unique_keys)
    require(set(m) == {"schema", "authorize", "token", "attempt_name", "pins", "static_review", "caps", "outer_runner_sha256"}, "manifest fields")
    require(m["schema"] == "c8-benign-preflight-v5" and m["authorize"] == "RUN_ONE_C8_SUPERVISOR_CAPABILITY_PREFLIGHT_V5", "not authorized")
    require(isinstance(m["outer_runner_sha256"],str) and re.fullmatch("[0-9A-F]{64}",m["outer_runner_sha256"]),"outer runner pin format")
    require(sha((HERE/"coordinator_c8_capability_run_20261111_v5.py").read_bytes())==m["outer_runner_sha256"],"outer runner pin")
    require(isinstance(m["token"], str) and re.fullmatch("[0-9a-f]{32}", m["token"]), "token")
    require(isinstance(m["attempt_name"], str) and re.fullmatch("c8_benign_attempt_[A-Za-z0-9_-]{1,48}", m["attempt_name"]), "attempt name")
    require(m["caps"] == CAPS, "caps changed")
    expected = dict(supervisor=sha(Path(__file__).read_bytes()), child=sha(CHILD.read_bytes()),
                    specification=sha(SPEC.read_bytes()), executable=EXE_SHA,
                    accepted_design=DESIGN, accepted_design_review=DESIGN_REVIEW)
    require(m["pins"] == expected and sha(EXE.read_bytes()) == EXE_SHA, "source/executable pin mismatch")
    review = m["static_review"]
    require(isinstance(review, dict) and set(review) == {"path", "sha256"}, "static review fields")
    rp = Path(review["path"]).resolve()
    require(rp.is_relative_to(HERE.parent) and rp.suffix == ".md", "static review location")
    require(sha(bounded_read(rp, 256*1024)) == review["sha256"], "static review pin")
    return m, sha(raw), len(raw)


class Win:
    def __init__(self):
        import ctypes as c
        from ctypes import wintypes as w
        self.c, self.w = c, w
        require(c.sizeof(c.c_void_p) == 8, "only reviewed 64-bit ABI")
        U64, SIZE = c.c_ulonglong, c.c_size_t
        class PMC(c.Structure):
            _fields_ = [("cb", w.DWORD), ("PageFaultCount", w.DWORD)] + [(n, SIZE) for n in ("PeakWorkingSetSize", "WorkingSetSize", "QuotaPeakPagedPoolUsage", "QuotaPagedPoolUsage", "QuotaPeakNonPagedPoolUsage", "QuotaNonPagedPoolUsage", "PagefileUsage", "PeakPagefileUsage")]
        class BASIC(c.Structure):
            _fields_ = [("PerProcessUserTimeLimit", c.c_longlong), ("PerJobUserTimeLimit", c.c_longlong), ("LimitFlags", w.DWORD), ("MinimumWorkingSetSize", SIZE), ("MaximumWorkingSetSize", SIZE), ("ActiveProcessLimit", w.DWORD), ("Affinity", SIZE), ("PriorityClass", w.DWORD), ("SchedulingClass", w.DWORD)]
        class IO(c.Structure):
            _fields_ = [(n, U64) for n in ("ReadOperationCount", "WriteOperationCount", "OtherOperationCount", "ReadTransferCount", "WriteTransferCount", "OtherTransferCount")]
        class LIMIT(c.Structure):
            _fields_ = [("BasicLimitInformation", BASIC), ("IoInfo", IO)] + [(n, SIZE) for n in ("ProcessMemoryLimit", "JobMemoryLimit", "PeakProcessMemoryUsed", "PeakJobMemoryUsed")]
        class ACCOUNT(c.Structure):
            _fields_ = [(n, c.c_longlong) for n in ("TotalUserTime", "TotalKernelTime", "ThisPeriodTotalUserTime", "ThisPeriodTotalKernelTime")] + [(n, w.DWORD) for n in ("TotalPageFaultCount", "TotalProcesses", "ActiveProcesses", "TotalTerminatedProcesses")]
        class START(c.Structure):
            _fields_ = [("cb", w.DWORD), ("lpReserved", w.LPWSTR), ("lpDesktop", w.LPWSTR), ("lpTitle", w.LPWSTR)] + [(n, w.DWORD) for n in ("dwX", "dwY", "dwXSize", "dwYSize", "dwXCountChars", "dwYCountChars", "dwFillAttribute", "dwFlags")] + [("wShowWindow", w.WORD), ("cbReserved2", w.WORD), ("lpReserved2", c.c_void_p), ("hStdInput", w.HANDLE), ("hStdOutput", w.HANDLE), ("hStdError", w.HANDLE)]
        class PI(c.Structure):
            _fields_ = [("hProcess", w.HANDLE), ("hThread", w.HANDLE), ("dwProcessId", w.DWORD), ("dwThreadId", w.DWORD)]
        self.PMC, self.LIMIT, self.ACCOUNT, self.START, self.PI = PMC, LIMIT, ACCOUNT, START, PI
        require((c.sizeof(PMC), c.sizeof(LIMIT), c.sizeof(ACCOUNT), c.sizeof(START), c.sizeof(PI)) == (72,144,48,104,24), "ABI sizes")
        k = c.WinDLL("kernel32", use_last_error=True)
        p = c.WinDLL("psapi", use_last_error=True)
        def bind(lib, name, args, result=w.BOOL):
            fn = getattr(lib, name); fn.argtypes = args; fn.restype = result
            setattr(self, name, fn)
        P, H, D = c.c_void_p, w.HANDLE, w.DWORD
        bind(k, "CreateJobObjectW", [P,w.LPCWSTR], H)
        bind(k, "GetCurrentProcess", [], H)
        bind(k, "GetCurrentProcessId", [], D)
        bind(k, "GetProcessId", [H], D)
        bind(k, "QueryFullProcessImageNameW", [H,D,w.LPWSTR,c.POINTER(D)])
        bind(k, "GetModuleFileNameW", [H,w.LPWSTR,D], D)
        bind(k, "OpenProcess", [D,w.BOOL,D], H)
        bind(k, "SetInformationJobObject", [H,c.c_int,P,D])
        bind(k, "QueryInformationJobObject", [H,c.c_int,P,D,P])
        bind(k, "AssignProcessToJobObject", [H,H])
        bind(k, "IsProcessInJob", [H,H,c.POINTER(w.BOOL)])
        bind(k, "CreateProcessW", [w.LPCWSTR,w.LPWSTR,P,P,w.BOOL,D,P,w.LPCWSTR,c.POINTER(START),c.POINTER(PI)])
        bind(k, "ResumeThread", [H], D)
        bind(k, "WaitForSingleObject", [H,D], D)
        bind(k, "TerminateProcess", [H,D])
        bind(k, "CloseHandle", [H])
        bind(k, "GetExitCodeProcess", [H,c.POINTER(D)])
        bind(k, "GetProcessTimes", [H,P,P,P,P])
        bind(p, "GetProcessMemoryInfo", [H,c.POINTER(PMC),D])

    def ok(self, result, what):
        require(bool(result), what + " failed: " + str(self.c.get_last_error()))

    def memory(self, handle):
        m = self.PMC(); m.cb = self.c.sizeof(m)
        self.c.set_last_error(0)
        success = bool(self.GetProcessMemoryInfo(handle, self.c.byref(m), m.cb))
        return dict(success=success, error=self.c.get_last_error(), peak=int(m.PeakWorkingSetSize), working_set=int(m.WorkingSetSize))

    def valid_memory(self, value, previous=0):
        require(value["success"] and 0 < value["peak"] <= CAPS["peak_bytes"] and value["peak"] >= max(previous,value["working_set"]), "INCOMPLETE_TELEMETRY")

    def account_snapshot(self, job, logical_job, stage):
        """Return native observations WITHOUT imposing a semantic count predicate."""
        c,w=self.c,self.w
        account=self.ACCOUNT(); length=w.DWORD()
        c.set_last_error(0)
        success=bool(self.QueryInformationJobObject(job,1,c.byref(account),c.sizeof(account),c.byref(length)))
        error=c.get_last_error() if not success else None
        return dict(stage=stage,logical_job=logical_job,job_handle=hex(int(job)),
                    observed_ns=time.monotonic_ns(),information_class=1,buffer_size=c.sizeof(account),
                    returned_length=int(length.value),success=success,error_on_failure=error,
                    raw_hex=c.string_at(c.byref(account),c.sizeof(account)).hex(),decoded_valid=success,
                    decoded={name:int(getattr(account,name)) for name,_ in self.ACCOUNT._fields_},
                    layout={name:dict(offset=getattr(self.ACCOUNT,name).offset,size=c.sizeof(typ)) for name,typ in self.ACCOUNT._fields_})

    def identity(self,handle,current=False):
        c,w=self.c,self.w
        c.set_last_error(0);pid=int(self.GetProcessId(handle));pe=c.get_last_error() if not pid else None
        times=[w.FILETIME() for _ in range(4)]
        c.set_last_error(0);ts=bool(self.GetProcessTimes(handle,*[c.byref(t) for t in times]));te=c.get_last_error() if not ts else None
        values=[(int(t.dwHighDateTime)<<32)|t.dwLowDateTime for t in times]
        cap=4096;buf=c.create_unicode_buffer(cap);n=w.DWORD(cap)
        c.set_last_error(0);ok=bool(self.QueryFullProcessImageNameW(handle,0,buf,c.byref(n)));err=c.get_last_error() if not ok else None
        im=dict(success=ok,error_on_failure=err,capacity=cap,returned_length=int(n.value),path=buf.value,complete=ok and 0<n.value<cap)
        result=dict(pid=pid,pid_error=pe,creation_filetime=values[0],times_success=ts,times_error=te,image=im,
                    valid=pid>0 and ts and values[0]>0 and im['complete'])
        if current:
            result['current_pid']=int(self.GetCurrentProcessId())
            mbuf=c.create_unicode_buffer(cap);c.set_last_error(0);mn=int(self.GetModuleFileNameW(None,mbuf,cap));me=c.get_last_error() if not 0<mn<cap else None
            result['current_module']=dict(success=0<mn<cap,error_on_failure_or_truncation=me,capacity=cap,returned_length=mn,path=mbuf.value,complete=0<mn<cap)
            result['valid']=result['valid'] and pid==result['current_pid'] and result['current_module']['complete']
        return result

    def pid_snapshot(self,job,logical_job,stage,original_handle,original_identity,publish):
        c,w=self.c,self.w
        class IDS(c.Structure):
            _fields_=[('assigned',w.DWORD),('listed',w.DWORD),('pids',c.c_size_t*8)]
        ids=IDS();returned=w.DWORD()
        c.set_last_error(0)
        ok=bool(self.QueryInformationJobObject(job,3,c.byref(ids),c.sizeof(ids),c.byref(returned)))
        error=c.get_last_error() if not ok else None
        complete=ok and ids.assigned==ids.listed and ids.listed<=8 and 8+int(ids.listed)*c.sizeof(c.c_size_t)<=returned.value<=c.sizeof(ids)
        listed=[int(ids.pids[i]) for i in range(min(int(ids.listed),8))]
        complete=complete and len(set(listed))==len(listed) and all(pid>0 for pid in listed)
        record=dict(logical_job=logical_job,stage=stage,job_handle=hex(int(job)),information_class=3,
                    capacity=8,buffer_size=c.sizeof(ids),returned_length=int(returned.value),success=ok,error_on_failure=error,
                    assigned=int(ids.assigned),listed=int(ids.listed),pids=listed,complete=complete,
                    raw_hex=c.string_at(c.byref(ids),c.sizeof(ids)).hex(),entries=[],valid=False)
        publish(record)  # raw list survives exceptions during per-entry inspection
        if not complete:return record
        for pid in listed:
            retained=pid==original_identity.get('pid')
            ph=original_handle if retained else self.OpenProcess(0x101000,False,pid)
            entry=dict(snapshot_pid=pid,continuity='original_retained_handle' if retained else 'later_opened_candidate_only',open_success=bool(ph))
            record['entries'].append(entry)
            if not ph:
                entry['open_error']=c.get_last_error();publish(record);continue
            try:
                publish(record)
                belongs=w.BOOL();c.set_last_error(0)
                member_ok=bool(self.IsProcessInJob(ph,job,c.byref(belongs)));member_error=c.get_last_error() if not member_ok else None
                entry.update(membership_success=member_ok,membership_error=member_error,member=bool(belongs.value),identity=self.identity(ph))
                entry['matches_original']=retained and identity_match(entry['identity'],original_identity)
                publish(record)
            finally:
                if not retained:self.CloseHandle(ph)
        # Unknown/reused/failed identities never count as evidence of absence.
        record['valid']=listed==[original_identity.get('pid')] and all(e.get('membership_success') and e.get('member') and e.get('matches_original') for e in record['entries'])
        publish(record)
        return record


def identity_match(actual,expected):
    """Strict diagnostic continuity; image spellings are not binary-hash proof."""
    return bool(actual.get('valid') and expected.get('valid') and
                actual.get('pid')==expected.get('pid') and
                actual.get('creation_filetime')==expected.get('creation_filetime') and
                actual.get('image',{}).get('path')==expected.get('image',{}).get('path'))


def run_case(win, case, directory, token, guard, case_record, checkpoint):
    import subprocess  # list2cmdline only; launch is exclusively CreateProcessW below
    c, w = win.c, win.w
    pi = win.PI(); job = None; exited = False; observations = []; live_peak = 0
    case_record.update(status="INCOMPLETE",observations=observations,accounting=[],handshake_snapshots=[],predicates={})
    checkpoint()
    def snapshot(stage):
        item=win.account_snapshot(job,"inner_"+case,stage)
        case_record["accounting"].append(item)
        checkpoint()  # raw bytes and decoded fields survive native/semantic failure
        require(item["success"],"QueryJob accounting failed: "+str(item["error_on_failure"]))
        return item
    def checked(name,condition):
        case_record["predicates"][name]=bool(condition)
        checkpoint()
        require(condition,name)
    case_start = time.monotonic_ns(); deadline = case_start + CAPS[case + "_ns"]
    try:
        job = win.CreateJobObjectW(None,None); win.ok(job,"CreateJobObject")
        limit = win.LIMIT(); limit.BasicLimitInformation.LimitFlags = 0x2008; limit.BasicLimitInformation.ActiveProcessLimit = 1
        win.ok(win.SetInformationJobObject(job,9,c.byref(limit),c.sizeof(limit)),"SetInformationJobObject")
        check = win.LIMIT()
        win.ok(win.QueryInformationJobObject(job,9,c.byref(check),c.sizeof(check),None),"QueryJob limits")
        require(check.BasicLimitInformation.LimitFlags == 0x2008 and check.BasicLimitInformation.ActiveProcessLimit == 1,"job limits")
        case_record["job_handle"]=hex(int(job)); case_record["job_limits"]=dict(flags=int(check.BasicLimitInformation.LimitFlags),active_limit=int(check.BasicLimitInformation.ActiveProcessLimit))
        snapshot("fresh_job_preassignment")
        start = win.START(); start.cb = c.sizeof(start)
        command = c.create_unicode_buffer(subprocess.list2cmdline([str(EXE),"-I","-S",str(CHILD),case,str(directory),token]))
        guard()
        launch = time.monotonic_ns()
        win.ok(win.CreateProcessW(str(EXE),command,None,None,False,0x0000000C,None,str(directory),c.byref(start),c.byref(pi)),"CreateProcessW")
        case_record.update(pid=int(pi.dwProcessId),process_handle=hex(int(pi.hProcess)),thread_handle=hex(int(pi.hThread)),launch_ns=launch)
        checkpoint()
        expected_identity=win.identity(pi.hProcess)
        case_record['original_handle_identity']=expected_identity;checkpoint()
        checked('original_identity_valid',expected_identity['valid'] and expected_identity['pid']==pi.dwProcessId)
        win.ok(win.AssignProcessToJobObject(job,pi.hProcess),"AssignProcessToJobObject")
        in_job = w.BOOL()
        win.ok(win.IsProcessInJob(pi.hProcess,job,c.byref(in_job)),"IsProcessInJob")
        require(in_job.value,"job membership")
        case_record["membership_after_assignment"]=bool(in_job.value)
        snapshot("postassignment_before_resume")
        guard(); require(time.monotonic_ns() < deadline,"creation/setup deadline")
        require(win.ResumeThread(pi.hThread) == 1,"single resume from suspended")
        acked = set(); termination_requested = False
        while True:
            guard()
            state = win.WaitForSingleObject(pi.hProcess,20)
            require(state in (0,258),"wait failed")
            now = time.monotonic_ns()
            if state == 0:
                exited = True; observed_exit = now
                break
            if now >= deadline:
                require(case == "timeout", "normal fixture timeout")
                termination_requested = True
                win.ok(win.TerminateProcess(pi.hProcess,KILL_CODE),"TerminateProcess timeout")
                require(win.WaitForSingleObject(pi.hProcess,2000) == 0,"INCOMPLETE_TERMINATION")
                exited = True; observed_exit = time.monotonic_ns()
                break
            value = win.memory(pi.hProcess)
            case_record["last_live_memory"]=value; checkpoint()
            win.valid_memory(value,live_peak)
            observer=guard(value)
            if value["peak"] > live_peak:
                require(len(observations)<128,"diagnostic observation count cap")
                observations.append(dict(stage="new_peak",elapsed_ns=now-launch,observer=observer,**value))
            live_peak = max(live_peak,value["peak"])
            require(len(observations)<=128,"diagnostic observation count cap")
            log = directory / (case + ".jsonl")
            if case == "normal" and log.exists():
                lines = bounded_read(log,16384).splitlines(keepends=True)
                for line in lines:
                    if not line.endswith(b"\n"): continue
                    row = json.loads(line,object_pairs_hook=unique_keys)
                    stage = row["stage"]
                    if stage in ("baseline","held") and stage not in acked:
                        case_record['last_handshake_row']=row;checkpoint()
                        require(row["token"] == token and row["source_sha256"] == sha(CHILD.read_bytes()),"handshake identity")
                        raw_account=win.account_snapshot(job,'inner_'+case,'handshake_'+stage)
                        require(len(case_record['handshake_snapshots'])<2,'handshake snapshot count')
                        packet=dict(stage=stage,accounting=raw_account)
                        case_record['handshake_snapshots'].append(packet)
                        if stage=='baseline':case_record['child_self_identity']=row.get('self_identity')
                        checkpoint()
                        def publish_pid(item):
                            packet['pid_snapshot']=item;checkpoint()
                        raw_pids=win.pid_snapshot(job,'inner_'+case,'handshake_'+stage,pi.hProcess,expected_identity,publish_pid)
                        if stage=='baseline':
                            child_id=row.get('self_identity') or {}
                            case_record['predicates']['child_self_matches_original']=bool(isinstance(child_id,dict) and identity_match(child_id,expected_identity) and child_id.get('current_module',{}).get('path')==child_id.get('image',{}).get('path'))
                            checkpoint()
                        checked('handshake_'+stage+'_account_query_valid',raw_account['success'])
                        checked('handshake_'+stage+'_pid_identity_valid',raw_pids['valid'])
                        if stage=='baseline':
                            require(case_record['predicates']['child_self_matches_original'],'child_self_matches_original')
                        value=win.memory(pi.hProcess)
                        case_record["last_handshake_memory"]=dict(stage=stage,value=value)
                        checkpoint(); win.valid_memory(value,live_peak)
                        observer=guard(value)
                        live_peak=max(live_peak,value["peak"])
                        require(len(observations)<128,"diagnostic observation count cap")
                        observations.append(dict(stage=stage,elapsed_ns=time.monotonic_ns()-launch,observer=observer,**value))
                        with (directory / ("normal."+stage+".ack")).open("xb") as out:
                            out.write(token.encode()); out.flush(); os.fsync(out.fileno())
                        acked.add(stage)
        case_record.update(observed_exit_ns=observed_exit,original_handle_exit_observed=exited,live_peak=live_peak)
        checkpoint()
        account=snapshot("postexit_before_handle_close")["decoded"]
        guard()
        require(case == "timeout" or observed_exit < deadline,"late normal exit")
        final = win.memory(pi.hProcess); case_record["postexit"]=final; checkpoint()
        win.valid_memory(final,live_peak)
        final_observer=guard(final)
        case_record["postexit_observer"]=final_observer; checkpoint()
        exit_code = w.DWORD()
        c.set_last_error(0); exit_success=bool(win.GetExitCodeProcess(pi.hProcess,c.byref(exit_code)))
        exit_error=c.get_last_error() if not exit_success else None
        case_record["exit_query"]=dict(success=exit_success,error_on_failure=exit_error,code=int(exit_code.value)); checkpoint()
        require(exit_success,"GetExitCodeProcess failed")
        checked("exit_code_expected",exit_code.value == (KILL_CODE if case == "timeout" else 0))
        checked("timeout_control_expected",termination_requested == (case == "timeout"))
        times = [w.FILETIME() for _ in range(4)]
        c.set_last_error(0)
        times_success=bool(win.GetProcessTimes(pi.hProcess,*[c.byref(t) for t in times]))
        times_error=c.get_last_error() if not times_success else None
        vals = [(int(t.dwHighDateTime)<<32)|t.dwLowDateTime for t in times]
        case_record["process_times_query"]=dict(success=times_success,error_on_failure=times_error,values=vals)
        case_record["creation_exit_kernel_user_filetimes"]=vals; checkpoint()
        require(times_success,"GetProcessTimes failed")
        checked("process_times_valid",0 < vals[0] <= vals[1])
        # Record BOTH results before rejecting either, preserving the exact failure.
        case_record["predicates"].update(total_processes_equals_one=account["TotalProcesses"]==1,
                                         limit_terminations_equals_zero=account["TotalTerminatedProcesses"]==0)
        checkpoint()
        require(case_record["predicates"]["total_processes_equals_one"],"total_processes_equals_one")
        require(case_record["predicates"]["limit_terminations_equals_zero"],"limit_terminations_equals_zero")
        raw = bounded_read(directory/(case+".jsonl"),16384)
        lines = raw.splitlines(keepends=True)
        require(all(x.endswith(b"\n") for x in lines),"partial log")
        rows = [json.loads(x,object_pairs_hook=unique_keys) for x in lines]
        require([r["stage"] for r in rows] == (["baseline","held","released","finished"] if case=="normal" else ["idle"]),"fixture stages")
        require(all(r["case"]==case and r["token"]==token and r["source_sha256"]==sha(CHILD.read_bytes()) for r in rows),"fixture identity")
        if case=="normal":
            require(rows[1]["allocation_bytes"]==16*1024*1024 and rows[-1]["allocation_bytes"]==32*1024*1024,"allocations")
            require(rows[-1]["prefix_sha256"]==sha(b"".join(lines[:-1])),"child prefix seal")
            require(acked=={"baseline","held"} and final["peak"]>=32*1024*1024,"allocation/peak plausibility")
        case_record.update(status="PASS",case=case,outcome="EXPECTED_TIMEOUT" if case=="timeout" else "NORMAL_EXIT",pid=pi.dwProcessId,
                    original_handle_retained=True,exit_code=exit_code.value,launch_to_exit_ns=observed_exit-launch,
                    case_total_ns=time.monotonic_ns()-case_start,postexit=final,postexit_observer=final_observer,
                    conservative_peak_sum=final["peak"]+final_observer["peak"],live_peak=live_peak,observations=observations,
                    creation_exit_kernel_user_filetimes=vals,total_processes=account["TotalProcesses"],
                    active_processes_at_query=account["ActiveProcesses"],limit_terminated_processes=account["TotalTerminatedProcesses"],
                    log_sha256=sha(raw),log_bytes=len(raw),child_records=rows)
        checkpoint()
        return case_record
    except BaseException as exc:
        case_record["status"]="FAIL"
        case_record.setdefault("first_error",type(exc).__name__+": "+str(exc)[:2000])
        try: checkpoint()
        except BaseException as later: case_record["checkpoint_error"]=type(later).__name__+": "+str(later)[:1000]
        raise
    finally:
        cleanup_state=0
        if pi.hProcess and not exited:
            win.TerminateProcess(pi.hProcess,KILL_CODE)
            # Cleanup is bounded; failure remains failure, never a PASS receipt.
            cleanup_state=win.WaitForSingleObject(pi.hProcess,2000)
        if pi.hThread: win.CloseHandle(pi.hThread)
        if pi.hProcess: win.CloseHandle(pi.hProcess)
        if job: win.CloseHandle(job)  # kill-on-close backstop; no retry
        case_record["cleanup_wait_state"]=int(cleanup_state)
        if cleanup_state!=0:
            case_record["status"]="FAIL"
            case_record.setdefault("first_error","RuntimeError: INCOMPLETE_TERMINATION during cleanup")
        try: checkpoint()
        except BaseException as later: case_record["cleanup_checkpoint_error"]=type(later).__name__+": "+str(later)[:1000]
        require(cleanup_state==0,"INCOMPLETE_TERMINATION during cleanup")


def main():
    parser=argparse.ArgumentParser(); parser.add_argument("--manifest",required=True)
    args=parser.parse_args(); overall_start=BOOT_NS
    require(os.name=="nt","Windows only")
    m,mhash,manifest_bytes=load_manifest(Path(args.manifest))
    directory=HERE/m["attempt_name"]
    directory.mkdir(exist_ok=False)  # one attempt, no overwrite or retry
    result_path=directory/"completion.json"
    result=dict(schema="c8-benign-completion-v5",status="INCOMPLETE",manifest_sha256=mhash,pins=m["pins"],
                token=m["token"],caps=CAPS,tests=[])
    allowed={"attempt.json","completion.json","normal.jsonl","normal.baseline.ack","normal.held.ack","timeout.jsonl"}
    with (directory/"attempt.json").open("xb") as out: out.write(encoded(m))
    with result_path.open("xb") as out: out.write(encoded(result))
    win=None; supervisor_peak=0
    def checkpoint():
        result["last_checkpoint_elapsed_ns"]=time.monotonic_ns()-overall_start
        result["supervisor_sampled_peak_bytes"]=supervisor_peak
        data=encoded(result)
        require(len(data)<=65536,"bounded diagnostic checkpoint")
        with result_path.open("wb") as out:
            out.write(data); out.flush(); os.fsync(out.fileno())
    def guard(child_memory=None):
        nonlocal supervisor_peak
        own=None
        require(time.monotonic_ns()-overall_start<CAPS["total_ns"],"total preflight deadline")
        if win is not None:
            own=win.memory(win.GetCurrentProcess()); result["observer_last_query"]=own
            win.valid_memory(own,supervisor_peak)
            supervisor_peak=max(supervisor_peak,own["peak"])
            if child_memory is not None:
                require(own["working_set"]+child_memory["working_set"]<=CAPS["aggregate_peak_bytes"],"observed working-set sum cap")
                require(own["peak"]+child_memory["peak"]<=CAPS["aggregate_peak_bytes"],"conservative cumulative-peak sum cap")
            for previous in result["tests"]:
                if previous.get("postexit",{}).get("success"):
                    require(own["peak"]+previous["postexit"]["peak"]<=CAPS["aggregate_peak_bytes"],"final observer plus prior-child peak cap")
        files=list(directory.iterdir())
        require(all(p.is_file() and not p.is_symlink() and p.name in allowed for p in files),"unexpected output")
        require(manifest_bytes+sum(p.stat().st_size for p in files)<CAPS["output_bytes"]-65536,"output cap/reserve")
        return own
    try:
        guard(); win=Win()
        startup_identity=win.identity(win.GetCurrentProcess(),current=True)
        result['startup']=dict(identity=startup_identity,token=m['token'],source_sha256=m['pins']['supervisor'])
        checkpoint()
        require(startup_identity['valid'] and startup_identity['current_module']['path']==startup_identity['image']['path'],'supervisor self identity incomplete')
        invalid=win.memory(None)
        require(not invalid["success"],"invalid query unexpectedly succeeded")
        rejected=False
        try: win.valid_memory(invalid)
        except RuntimeError: rejected=True
        require(rejected,"invalid memory was not rejected")
        result["invalid_query_control"]=dict(**invalid,rejected=rejected)
        checkpoint()
        for case in ("normal","timeout"):
            case_record=dict(case=case,status="INCOMPLETE")
            result["tests"].append(case_record); checkpoint()
            run_case(win,case,directory,m["token"],guard,case_record,checkpoint)
        guard()
        result["status"]="PASS"
    except BaseException as exc:
        result["status"]="FAIL"; result["error"]=type(exc).__name__+": "+str(exc)[:2000]
        result["first_error"]=next((t["first_error"] for t in result["tests"] if "first_error" in t),result["error"])
    result["elapsed_before_seal_ns"]=time.monotonic_ns()-overall_start
    result["supervisor_sampled_peak_bytes"]=supervisor_peak
    result["files"]=[dict(name=p.name,bytes=p.stat().st_size,sha256=sha(bounded_read(p,65536))) for p in directory.iterdir() if p!=result_path]
    raw=encoded(result)
    require(len(raw)<=65536,"seal exceeds reservation")
    # Only this attempt's exclusively created completion file may be replaced.
    with result_path.open("wb") as out: out.write(raw); out.flush(); os.fsync(out.fileno())
    actual=manifest_bytes+sum(p.stat().st_size for p in directory.iterdir())
    if time.monotonic_ns()-overall_start>=CAPS["total_ns"] or actual>CAPS["output_bytes"]:
        result["status"]="FAIL"; result["error"]="finalization deadline/output cap"
        raw=encoded(result)
        with result_path.open("wb") as out: out.write(raw); out.flush(); os.fsync(out.fileno())
    final_observer=None; final_peak_sums=[]
    if win is not None:
        final_observer=win.memory(win.GetCurrentProcess()); win.valid_memory(final_observer,supervisor_peak)
        final_peak_sums=[final_observer["peak"]+test["postexit"]["peak"] for test in result["tests"] if test.get("postexit",{}).get("success")]
        require(all(n<=CAPS["aggregate_peak_bytes"] for n in final_peak_sums),"final conservative aggregate peak cap")
    final=dict(status=result["status"],receipt_sha256=sha(raw),manifest_sha256=mhash,
               supervisor_sha256=m["pins"]["supervisor"],child_sha256=m["pins"]["child"],
               final_observer_memory=final_observer,conservative_peak_sums=final_peak_sums,
               elapsed_ns=time.monotonic_ns()-overall_start,aggregate_disk_bytes=manifest_bytes+sum(p.stat().st_size for p in directory.iterdir()))
    # A reserved 64 KiB also dominates this single bounded final console line.
    console=json.dumps(final,sort_keys=True)
    require(len(console.encode())+2<=65536,"console reserve")
    require(final["aggregate_disk_bytes"]+len(console.encode())+2<=CAPS["output_bytes"],"final aggregate including console")
    require(time.monotonic_ns()-overall_start<CAPS["total_ns"],"final console deadline")
    print(console,flush=True)
    return 0 if result["status"]=="PASS" else 1


if __name__=="__main__":
    sys.exit(main())
