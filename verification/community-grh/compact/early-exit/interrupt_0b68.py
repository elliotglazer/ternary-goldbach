"""Without arguments this only reports readiness. Explicit commit mode targets one pinned pidfd."""
import sys
sys.dont_write_bytecode = True
import json
import os
import select
import signal
import subprocess
import time

import ready_0b68 as gate

INTENT = gate.INTENT

def assert_reusable_log(info):
    import hashlib
    digest=hashlib.sha256()
    with gate.regular_reader(gate.LOG) as f:
        st=os.fstat(f.fileno())
        gate.require((st.st_dev,st.st_ino) == (info["device"],info["inode"]) and
                     st.st_size >= info["prefix_bytes"], "live log identity/length changed")
        left=info["prefix_bytes"]
        while left:
            buf=f.read(min(left,1024*1024))
            gate.require(buf,"short live log before commit")
            digest.update(buf);left-=len(buf)
    gate.require(digest.hexdigest()==info["prefix_sha256"],"saved diagnostic prefix changed")

def save_intent(record):
    directory=os.open(gate.ROOT,os.O_RDONLY|os.O_DIRECTORY|os.O_NOFOLLOW|os.O_CLOEXEC)
    try:
        fd=os.open(INTENT,os.O_WRONLY|os.O_CREAT|os.O_EXCL|os.O_NOFOLLOW|os.O_CLOEXEC,
                   0o600,dir_fd=directory)
        with os.fdopen(fd,"w",encoding="utf-8") as stream:
            json.dump(record,stream,indent=2,sort_keys=True)
            stream.write("\n");stream.flush();os.fsync(stream.fileno())
        os.fsync(directory)
    finally:
        os.close(directory)

def commit():
    gate.require(hasattr(signal,"pidfd_send_signal"),"pidfd_send_signal unavailable")
    snapshot=gate.ready()
    expected=snapshot["identity"]
    fd=os.pidfd_open(expected["lake"]["pid"],0)
    try:
        gone=select.poll()
        gone.register(fd,select.POLLIN|select.POLLHUP|select.POLLERR)
        gate.require(not gone.poll(0) and gate.identity()==expected,"pinned Lake changed before intent")
        assert_reusable_log(snapshot["live"])
        record={"event":"intent_to_interrupt_only_inner_lake_after_prior_source_failure",
                "disposition":"Intent only. Consult the unmodified driver receipt and exit code for outcome.",
                "created_unix":time.time(),"proposed_signal":"SIGTERM","diagnosis":snapshot}
        save_intent(record)
        gate.source_pin()
        gate.require(gate.hash_file(gate.ROOT/"diagnostic-memory-change.json")==gate.MEMORY_SHA,
                     "memory marker changed after intent")
        assert_reusable_log(snapshot["live"])
        gate.require(not gone.poll(0) and gate.identity()==expected,"pinned Lake changed after intent")
        signal.pidfd_send_signal(fd,signal.SIGTERM,None,0)
    finally:
        os.close(fd)
    return {"signal_sent":"SIGTERM","target":"verified inner Lake only",
            "pid":expected["lake"]["pid"],"sidecar":str(gate.ROOT/INTENT),
            "terminal_receipt":"pending; allow the original wrappers to finish"}

def main(args):
    try:
        if not args:
            output={"read_only":True,"ready":True,"diagnosis":gate.ready()}
        else:
            gate.require(args==["--interrupt-after-recording",gate.ATTEMPT],
                         "exact opt-in and attempt token required")
            output=commit()
        print(json.dumps(output,sort_keys=True));return 0
    except (gate.Refused,OSError,ValueError,KeyError,IndexError,subprocess.SubprocessError) as e:
        print(json.dumps({"signal_sent":False,"reason":str(e)}));return 2

if __name__=="__main__":
    raise SystemExit(main(sys.argv[1:]))
