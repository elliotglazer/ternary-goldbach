"""Source preparation only. Native declarations are inert until Win() is called.
Win and identity_match are verbatim from V5 source SHA256
882762361FC9E3AE2AF876CB604E6EA8CCDA2E6C2251872DD79B2593F0953A85.
The legacy valid_memory method is unused; explicit per-role caps are checked by caller.
"""
import time
CAPS = {"peak_bytes": 256 * 1024 * 1024}
def require(ok, message):
    if not ok:
        raise RuntimeError(message)
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


