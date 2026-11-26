#!/usr/bin/env python3
"""Temporarily bound the dedicated Palomar user manager and run the stock profile proof."""
import argparse
import hashlib
import json
import os
import pwd
import re
import secrets
import subprocess
import sys
import time
from pathlib import Path

NAME="grhreplay"
UID=1001
UNIT=f"user@{UID}.service"
CG=Path("/sys/fs/cgroup")/"user.slice"/f"user-{UID}.slice"/UNIT
RUNTIME=Path("/run/systemd/system.control")/(UNIT+".d")
STATE=Path("/run/tg-palomar-aggregate")
HERE=Path(__file__).resolve()
PROBE=HERE.with_name("probe-stock-32x64.py")
PY="/opt/palomar-verifier-14aa8d6b/venv/bin/python"
PROBE_SHA="a24992ee326a5314160ea0e5eece28116d8a08a7605396dd90da55e1411a5413"
PROFILE="palomar-namespace-32x64-v1"
ORIGINAL={"cpu.max":"max 100000","memory.max":"max","memory.swap.max":"max"}
BOUNDED={"cpu.max":"3200000 100000","memory.max":str(64*2**30),"memory.swap.max":"0"}
KEYS=("CPUQuota","MemoryMax","MemorySwapMax")
SET=("CPUQuota=3200%","MemoryMax=64G","MemorySwapMax=0")
RESET=("CPUQuota=","MemoryMax=infinity","MemorySwapMax=infinity")
def need(test,message):
    if not test:raise RuntimeError(message)
def run(argv,check=True):
    r=subprocess.run([str(x) for x in argv],text=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
    if check and r.returncode:raise RuntimeError(f"{argv[0]} failed ({r.returncode}): "+(r.stderr or r.stdout).strip()[-1300:])
    return r
def sha(f):return hashlib.sha256(f.read_bytes()).hexdigest()
def usercmd(*args):
    account=pwd.getpwnam(NAME)
    need(account.pw_uid==UID,"Dedicated UID differs")
    return ["/usr/bin/setpriv",f"--reuid={UID}",f"--regid={account.pw_gid}","--init-groups","--",
            "/usr/bin/env","-i",f"HOME={account.pw_dir}",f"USER={NAME}",f"LOGNAME={NAME}","PATH=/usr/local/bin:/usr/bin:/bin",
            f"XDG_RUNTIME_DIR=/run/user/{UID}",f"DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/{UID}/bus",*args]
def statefile(token):return STATE/(token+".json")
def save(path,value):
    temp=path.with_suffix(".tmp")
    with temp.open("w") as f:
        json.dump(value,f,sort_keys=True);f.flush();os.fsync(f.fileno())
    os.replace(temp,path)
def current():return {name:(CG/name).read_text().strip() for name in ORIGINAL}
def identity():return run(["systemctl","show",UNIT,"-p","InvocationID","--value"]).stdout.strip()
def raw_config():
    if not RUNTIME.exists():return {}
    need(RUNTIME.is_dir() and not RUNTIME.is_symlink(),"Invalid runtime control directory")
    files={}
    for f in RUNTIME.iterdir():
        st=f.lstat()
        need(f.is_file() and not f.is_symlink() and st.st_uid==0 and not st.st_mode&0o022,"Untrusted runtime override")
        files[f.name]=f.read_text()
    return files
def assignments(content):
    return [line.strip() for line in content.splitlines() if line.strip() and not line.lstrip().startswith(("#",";","["))]
def recognized(name,content):
    lines=assignments(content)
    if len(lines)!=1 or not re.fullmatch(r"50-(CPUQuota(?:PerSecUSec)?|MemoryMax|MemorySwapMax)\.conf",name):return False
    key,sep,value=lines[0].partition("=")
    if not sep:return False
    if key=="CPUQuota":return value in ("","infinity") or bool(re.fullmatch(r"3200(?:\.0+)?%",value))
    if key=="MemoryMax":return value in ("infinity",str(64*2**30),"64G")
    if key=="MemorySwapMax":return value in ("infinity","0")
    return False
def controlled_files(before):
    now=raw_config()
    need(all(now.get(n)==v for n,v in before.items()),"Pre-existing runtime drop-in changed concurrently")
    extra={n:v for n,v in now.items() if n not in before}
    need(all(recognized(n,v) for n,v in extra.items()),"Foreign or ambiguous runtime setting; retaining owner lease")
    return extra
def workloads():
    sessions=run(["loginctl","list-sessions","--no-legend","--no-pager"]).stdout
    need(not any(len(row.split())>=3 and (row.split()[1]==str(UID) or row.split()[2]==NAME) for row in sessions.splitlines()),"Dedicated UID has an active login session")
    jobs=run(usercmd("systemctl","--user","list-jobs","--no-legend","--no-pager")).stdout.strip()
    need(not jobs,"A user-manager job is already queued: "+jobs)
    observed=[]
    for procfile in CG.rglob("cgroup.procs"):
        try:pids=procfile.read_text().split()
        except FileNotFoundError:continue
        group=procfile.parent.relative_to(CG).as_posix()
        for pid in pids:
            try:exe=Path(os.readlink(f"/proc/{pid}/exe")).name
            except FileNotFoundError:continue
            okay=(group=="init.scope" and exe in ("systemd","(sd-pam)","sd-pam")) or (group.endswith("/dbus.service") and exe in ("dbus-daemon","dbus-broker","dbus-broker-launch"))
            need(okay,f"Dedicated user manager has another workload: {group} {pid} {exe}")
            observed.append((group,pid,exe))
    return observed
def set_runtime(values):run(["systemctl","set-property","--runtime",UNIT,*values])
def manager_scoped():
    path=run(["systemctl","show",UNIT,"-p","ControlGroup","--value"]).stdout.strip()
    need(path==CG.as_posix().removeprefix("/sys/fs/cgroup"),"Unexpected manager cgroup")
def trusted_file(path):
    need(path.is_file() and path.resolve()==path,"Unexpected trusted program path")
    for f in [path,*path.parents]:
        st=f.stat();need(st.st_uid==0 and not st.st_mode&0o022,"Trusted file writable by others: "+str(f))
def owned_directory(path):
    path.mkdir(mode=0o700,exist_ok=True);st=path.lstat()
    need(path.resolve()==path and path.is_dir() and st.st_uid==0 and not st.st_mode&0o077,"Untrusted state directory")
def make_lease(token):
    lease=STATE/"owner"
    with lease.open("x") as f:f.write(token);f.flush();os.fsync(f.fileno())
def read_lease(token):return (STATE/"owner").exists() and (STATE/"owner").read_text()==token
def root_entry(token,policy,scratch,command):
    orig=statefile(token);st=json.loads(orig.read_text())
    make_lease(token)
    manager_scoped();before=raw_config();load=workloads()
    need(current()==ORIGINAL,"User manager already has non-default resource bounds")
    need(not any(line.partition("=")[0].strip() in KEYS for text in before.values() for line in assignments(text)),"Existing runtime resource override")
    need(int((CG/"memory.current").read_text())<4*2**30,"Unexpected user-manager starting memory")
    st.update(before=before,invocation=identity(),preexisting_workloads=load,phase="armed")
    st["runtime_dir_existed"]=RUNTIME.exists();save(orig,st)
    set_runtime(SET);controlled_files(before);need(current()==BOUNDED and identity()==st["invocation"],"Kernel did not apply exact requested aggregate bounds")
    st["phase"]="bounded";save(orig,st)
    service="palomar-cold-"+token
    args=usercmd("systemd-run","--user","--wait","--pipe","--quiet","--collect","--service-type=exec","--unit="+service,
                 "--setenv=PALOMAR_EXECUTION_PROFILE="+PROFILE,"--",PY,"-I",str(HERE),"inner",token,policy,scratch,*command)
    return subprocess.call(args)
def inner(token,policy,scratch,command):
    need(os.geteuid()==UID and current()==BOUNDED,"Coordinator did not enter the bounded account")
    actual=Path("/proc/self/cgroup").read_text().strip()
    need(actual.endswith("/palomar-cold-"+token+".service") and "/user@1001.service/" in actual,"Coordinator is outside expected user service")
    need(sha(PROBE)==PROBE_SHA,"Stock measurement source digest differs")
    r=run([PY,"-I",PROBE,policy,scratch]);print(r.stdout,end="",flush=True)
    record=json.loads(r.stdout.strip().splitlines()[-1]);result=Path(record["report"]).resolve(strict=True)
    need(result.parent==Path(scratch).resolve(strict=True),"Unexpected probe output path")
    d=json.loads(result.read_bytes());c=d["classification"]
    need(d["profile"]==PROFILE and d["policy"]=="14aa8d6b3c2f14a8540605e37144560b9a00e7e7","Incorrect measured proof policy")
    for k in ("outer_selected_profile","stock_phase","phase_cpu_32","phase_memory_limits","phase_has_zero_swap_cgroup","aggregate_32x64_swap0"):
        need(c[k] is True,"Incomplete profile measurement: "+k)
    for k in ("common_memory64_enforced_by","common_cpu32_enforced_by","common_swap0_enforced_by"):
        need(str(CG) in c[k],"Wrong common ancestor for "+k)
    print(json.dumps({"qualified_aggregate_receipt":str(result),"sha256":sha(result),"manager":str(CG)}),flush=True)
    if command:os.execv(command[0],command)
    return 0
def restore(token):
    if not read_lease(token):return 0
    st=json.loads(statefile(token).read_text())
    clean=True
    if st["phase"] in ("armed","bounded"):
        before=st["before"];extra=controlled_files(before)
        if st["phase"]=="bounded":run(usercmd("systemctl","--user","stop","palomar-cold-"+token+".service"),check=False)
        # Stock's FIFO makes its delegated helpers exit if the coordinator dies.
        for _ in range(20):
            try:workloads();break
            except RuntimeError:time.sleep(1)
        else:
            clean=False;print("Unexpected or residual manager activity. Its processes are left untouched.",file=sys.stderr,flush=True)
        if current()!=ORIGINAL or extra:
            set_runtime(RESET)
            created=controlled_files(before)
            for name,body in created.items():
                f=RUNTIME/name;need(f.read_text()==body,"Changed during rollback");f.unlink()
            if not st["runtime_dir_existed"] and RUNTIME.is_dir():RUNTIME.rmdir()
            run(["systemctl","daemon-reload"])
        need(raw_config()==before and current()==ORIGINAL,"Original settings were not restored")
        st["restored"]=current();st["same_invocation_at_cleanup"]=(identity()==st["invocation"])
    if st.get("same_invocation_at_cleanup") is False:clean=False
    # If this operation brought up an inactive manager, release it only while
    # still idle and without an active system unit requiring or bound to it.
    if st.get("prior_manager")=="inactive" and clean:
        try:
            workloads()
            dependents=run(["systemctl","show",UNIT,"-p","RequiredBy","-p","BoundBy","--value"]).stdout.split()
            active=[d for d in dependents if d!=st["scope"]+".service"
                    and run(["systemctl","is-active","--quiet",d],check=False).returncode==0]
            need(not active,"Manager gained active external dependents: "+str(active))
            run(["systemctl","--no-block","stop",UNIT])
            st["prior_inactive_manager_shutdown_requested"]=True
        except RuntimeError as err:
            clean=False;print("Leaving the manager alive: "+str(err),file=sys.stderr,flush=True)
    st["phase"]="released";st["cleanup_clean"]=clean;save(statefile(token),st)
    print(json.dumps({"released":token,"restored":st.get("restored"),"same_invocation":st.get("same_invocation_at_cleanup")}),flush=True)
    (STATE/"owner").unlink()
    need(clean,"Aggregate measurement contaminated by a manager change or other work")
    return 0
def launch(seconds,policy,scratch,command):
    need(45<=seconds<=25200,"Invalid bounded operation length")
    trusted_file(HERE);trusted_file(PROBE);need(sha(PROBE)==PROBE_SHA,"Unexpected probe bytes")
    need(re.fullmatch(r"[/A-Za-z0-9_.-]+",str(HERE)),"Install trusted wrapper under a plain root-owned path")
    need(Path("/proc/1/comm").read_text().strip()=="systemd","Requires systemd as PID 1")
    owned_directory(STATE);token=secrets.token_hex(12);name="tg-palomar-aggregate-"+token
    prior=run(["systemctl","is-active",UNIT],check=False).stdout.strip()
    need(prior in ("active","inactive"),"Dedicated manager has a pending or failed transition")
    # If currently inactive, systemd can start it for the window; only the resource
    # settings are touched in cleanup. The distribution handles an idle user's lifecycle.
    save(statefile(token),{"phase":"new","token":token,"prior_manager":prior,"scope":name})
    stop="/usr/bin/python3 -I "+str(HERE)+" restore "+token
    args=["systemd-run","--wait","--pipe","--quiet","--collect","--unit="+name,
          "--property=Wants="+UNIT,"--property=After="+UNIT,"--property=RuntimeMaxSec="+str(seconds),
          "--property=TimeoutStopSec=75s","--property=ExecStopPost="+stop,"--",
          "/usr/bin/python3","-I",str(HERE),"hold",token,policy,scratch,*command]
    return subprocess.call(args)
def main():
    mode=sys.argv[1] if len(sys.argv)>1 else ""
    if mode!="inner":need(os.geteuid()==0,"Root controller required")
    if mode=="restore" and len(sys.argv)==3:
        need(re.fullmatch(r"[0-9a-f]{24}",sys.argv[2]),"Invalid token");return restore(sys.argv[2])
    if mode=="launch":
        a=argparse.ArgumentParser();a.add_argument("seconds",type=int);a.add_argument("policy");a.add_argument("scratch");a.add_argument("command",nargs=argparse.REMAINDER)
        x=a.parse_args(sys.argv[2:]);argv=x.command[1:] if x.command[:1]==["--"] else x.command
        need(not argv or os.path.isabs(argv[0]),"Handoff command must be absolute")
        return launch(x.seconds,x.policy,x.scratch,argv)
    if mode in ("hold","inner") and len(sys.argv)>=5:
        token,policy,scratch=sys.argv[2:5];need(re.fullmatch(r"[0-9a-f]{24}",token),"Invalid token")
        return (root_entry if mode=="hold" else inner)(token,policy,scratch,sys.argv[5:])
    raise SystemExit("Usage: stock_aggregate.py launch SECONDS POLICY SCRATCH [-- /absolute/handoff args...]")
if __name__=="__main__":sys.exit(main())
