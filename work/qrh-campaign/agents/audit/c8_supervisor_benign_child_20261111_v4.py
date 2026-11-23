"""Fixed benign child. Preparation only; the reviewed supervisor launches it."""
import gc
import hashlib
import json
from pathlib import Path
import sys
import time


def self_identity():
    """Native observations only; caller logs failure/inconclusive data as well."""
    import ctypes as c
    from ctypes import wintypes as w
    k=c.WinDLL("kernel32",use_last_error=True)
    def bind(name,args,result):
        f=getattr(k,name);f.argtypes=args;f.restype=result;return f
    current=bind("GetCurrentProcess",[],w.HANDLE)()
    own_pid=bind("GetCurrentProcessId",[],w.DWORD)()
    get_pid=bind("GetProcessId",[w.HANDLE],w.DWORD)
    get_times=bind("GetProcessTimes",[w.HANDLE,c.c_void_p,c.c_void_p,c.c_void_p,c.c_void_p],w.BOOL)
    image=bind("QueryFullProcessImageNameW",[w.HANDLE,w.DWORD,w.LPWSTR,c.POINTER(w.DWORD)],w.BOOL)
    module=bind("GetModuleFileNameW",[w.HMODULE,w.LPWSTR,w.DWORD],w.DWORD)
    c.set_last_error(0);pid=int(get_pid(current));pid_error=c.get_last_error() if not pid else None
    times=[w.FILETIME() for _ in range(4)]
    c.set_last_error(0);ts=bool(get_times(current,*[c.byref(t) for t in times]));te=c.get_last_error() if not ts else None
    values=[(int(t.dwHighDateTime)<<32)|t.dwLowDateTime for t in times]
    cap=4096;buf=c.create_unicode_buffer(cap);n=w.DWORD(cap)
    c.set_last_error(0);ok=bool(image(current,0,buf,c.byref(n)));error=c.get_last_error() if not ok else None
    image_record=dict(success=ok,error_on_failure=error,capacity=cap,returned_length=int(n.value),path=buf.value,complete=ok and 0<n.value<cap)
    mbuf=c.create_unicode_buffer(cap);c.set_last_error(0);mn=int(module(None,mbuf,cap));me=c.get_last_error() if not 0<mn<cap else None
    module_record=dict(success=0<mn<cap,error_on_failure_or_truncation=me,capacity=cap,returned_length=mn,path=mbuf.value,complete=0<mn<cap)
    return dict(pid=pid,pid_error=pid_error,current_pid=int(own_pid),creation_filetime=values[0],times_success=ts,times_error=te,
                image=image_record,current_module=module_record,valid=pid>0 and pid==own_pid and ts and values[0]>0 and image_record['complete'] and module_record['complete'])


def main():
    case, directory, token = sys.argv[1:]
    if case not in ("normal", "timeout") or len(token) != 32:
        raise ValueError("invalid fixed fixture")
    directory = Path(directory)
    log = directory / (case + ".jsonl")
    source = hashlib.sha256(Path(__file__).read_bytes()).hexdigest().upper()
    prefix = hashlib.sha256()
    with log.open("xb", buffering=0) as stream:
        def emit(stage, **fields):
            obj = dict(case=case, token=token, source_sha256=source, stage=stage, **fields)
            raw = (json.dumps(obj, sort_keys=True, separators=(",", ":")) + "\n").encode()
            stream.write(raw)
            import os
            os.fsync(stream.fileno())
            prefix.update(raw)

        def await_ack(stage):
            deadline = time.monotonic_ns() + 5_000_000_000
            path = directory / ("normal." + stage + ".ack")
            while time.monotonic_ns() < deadline:
                try:
                    if path.read_bytes() == token.encode():
                        return
                    raise ValueError("bad acknowledgment")
                except FileNotFoundError:
                    time.sleep(.01)
            raise TimeoutError("bounded acknowledgment wait")

        if case == "timeout":
            emit("idle")
            time.sleep(60)  # supervisor must terminate this harmless idle process
            raise RuntimeError("timeout supervisor did not terminate")
        emit("baseline",self_identity=self_identity())
        await_ack("baseline")
        block = bytearray(16 * 1024 * 1024)
        for index in range(0, len(block), 4096):
            block[index] = 1
        block[-1] = 1
        emit("held", allocation_bytes=len(block))
        await_ack("held")
        del block
        gc.collect()
        emit("released")
        late = bytearray(32 * 1024 * 1024)
        for index in range(0, len(late), 4096):
            late[index] = 2
        late[-1] = 2
        emit("finished", allocation_bytes=len(late), prefix_sha256=prefix.hexdigest().upper())
        # Keep `late` alive through final log write and normal interpreter exit.
        return late


if __name__ == "__main__":
    retained_late_allocation = main()
