"""Read-only identity and evidence probe for a single historical AWS attempt."""
import hashlib
import json
import os
from pathlib import Path
import re
import stat
import subprocess
import sys
import time

PIN = "0b68b493791e5f7569021f0cd13454151af47584"
TREE = "6d8764b58d1a41584cd5d43fd3e400f6ee55d18e"
ATTEMPT = "d69a0b0ad9464dbc84198f6c547221c7"
RUNNER_SHA = "70afda55bfd8f96bd8be043a092da4cd7d1d39aaf3438fe135a8e7964c4ff263"
MEMORY_SHA = "fa3ebad58d0bcc70bb822dc8694ae233b6433f2342b5ee6fa8cfce32d587ab7a"
BEFORE_SHA = "bfd8836e864b164ae5820b7d83d943f9b97dd6211dff116fa648eca80d1f6577"
ROOT = Path("/work/compact-joint-runs") / (PIN + "-" + ATTEMPT)
RUN = ROOT / "run"
SOURCE = RUN / "source"
EVIDENCE = RUN / "evidence"
LOG = EVIDENCE / "joint-source-build.log"
RUNNER = Path("/work/runner") / ("compact-joint-" + RUNNER_SHA[:16] + ".py")
TOOLS = Path("/work/compact-joint-435-verified-tools/lean-4.35.0-linux")
PROC = Path("/proc")
BWRAP_EXE = Path("/usr/bin/bwrap")
TIME_EXE = Path("/usr/bin/time")
PYTHON_EXE = Path("/usr/bin/python3")
STAGE = "joint-source-build"
INTENT = "operator-interrupt-joint-lake-intent-v1.json"
LAKE_ARGS = ["--no-cache", "build", "+Main", "GoldbachSolution"]
MIN_LAKE_AGE = 60
ORIGINAL = {
    "Lib.General.Analysis.ZpowSum", "Lib.General.Algebra.RingActions",
    "Lib.GaloisRep.Pseudocharacter.SemisimpleReps", "TernaryGoldbach.MajorArcs.HHFourier",
    "Lib.Shimura.Uniformisation.Frames", "Lib.General.Groups.ArtinDefs",
    "Lib.ClassField.GaloisCohomology.DiscreteUnits", "Lib.DiscreteSeries.Haar.CompactDualMeasure",
    "Lib.LocalGL.Green.MackeyFormula",
}
ANSI = re.compile(rb"\x1b\[[0-?]*[ -/]*[@-~]")
SOURCE_ERROR = re.compile(
    r"^(?P<prefix>error:\s*)?(?:/project/)?(?:\./)?(?:CompactGRH/src/)?"
    r"(?P<file>(?:Lib/|TernaryGoldbach/)[A-Za-z0-9_./'-]+|MajorEnergy)\.lean:"
    r"(?P<line>\d+):(?P<col>\d+):\s*(?P<message>.*)$")
FAILED_TARGET = re.compile(r"^✖\s+\[[^\]]+\]\s+(?:Building|Running|Replaying)\s+([^\s(:]+)")
DIRECT = {"Lib.General.Groups.ArtinDefs": (23, 2),
          "Lib.DiscreteSeries.Haar.CompactDualMeasure": (192, 43)}

class Refused(RuntimeError):
    pass

def require(ok, reason):
    if not ok:
        raise Refused(reason)

def regular_reader(path):
    require(path.resolve(strict=True) == path, f"unexpected file path: {path}")
    fd = os.open(path, os.O_RDONLY | os.O_CLOEXEC | os.O_NOFOLLOW)
    f = os.fdopen(fd, "rb")
    if not stat.S_ISREG(os.fstat(fd).st_mode):
        f.close()
        raise Refused(f"expected regular file: {path}")
    return f

def hash_file(path):
    with regular_reader(path) as f:
        return hashlib.file_digest(f, "sha256").hexdigest()

def json_file(path):
    with regular_reader(path) as f:
        return json.load(f)

def read_failures(path, expected_sha=None):
    """Hash one fixed prefix even if Lake appends diagnostics while it is read."""
    samples, coords = {}, set()
    digest = hashlib.sha256()
    with regular_reader(path) as f:
        before = os.fstat(f.fileno())
        remaining = before.st_size
        while remaining:
            raw = f.readline(remaining)
            require(raw, "log was truncated")
            digest.update(raw)
            remaining -= len(raw)
            for line in ANSI.sub(b"", raw).decode("utf-8", errors="replace").splitlines():
                line = line.strip()
                error = SOURCE_ERROR.match(line)
                target = FAILED_TARGET.match(line)
                if error and (error["prefix"] or error["message"].startswith("error")):
                    mod = error["file"].replace("/", ".")
                    samples[mod] = line[:380]
                    if DIRECT.get(mod) == (int(error["line"]), int(error["col"])):
                        coords.add(mod)
                elif target:
                    samples.setdefault(target[1], line[:380])
        after = os.fstat(f.fileno())
        require(after.st_size >= before.st_size, "log shrank during capture")
        require(os.path.samestat(after, os.stat(path, follow_symlinks=False)), "log file was replaced")
    hexdigest = digest.hexdigest()
    require(expected_sha is None or hexdigest == expected_sha, "pre-limit log digest mismatch")
    require(ORIGINAL <= samples.keys(), "missing original failures: " + ", ".join(sorted(ORIGINAL-samples.keys())))
    require(set(DIRECT) <= coords, "missing original ArtinDefs/CompactDualMeasure source coordinates")
    return {"prefix_bytes": before.st_size, "prefix_sha256": hexdigest,
            "device":before.st_dev,"inode":before.st_ino,"errors":samples}

def argv(pid):
    return [os.fsdecode(v) for v in (PROC/str(pid)/"cmdline").read_bytes().split(b"\0") if v]

def procrow(pid):
    base = PROC / str(pid)
    bits = (base/"stat").read_text().rsplit(")",1)[1].split()
    require(bits[0] not in ("X","Z"), "target or parent exiting")
    st = (base/"exe").stat()
    return {"pid":pid,"ppid":int(bits[1]),"start_ticks":int(bits[19]),"exe_inode":[st.st_dev,st.st_ino]}

def unique_lake(rows):
    hits = [pid for pid,cmd in rows if cmd in (["lake",*LAKE_ARGS],["/tool/bin/lake",*LAKE_ARGS])]
    require(len(hits)==1, f"expected exactly one matching inner Lake; found {len(hits)}")
    return hits[0]

def all_argv():
    for root in PROC.glob("[0-9]*"):
        try:
            yield int(root.name), argv(root.name)
        except (FileNotFoundError, ProcessLookupError):
            continue

def same_exe(row, file):
    expected = file.stat()
    return row["exe_inode"] == [expected.st_dev,expected.st_ino]

def bound(args, flag, src, dst):
    return any(args[i:i+3] == [flag,str(src),dst] for i in range(len(args)-2))

def source_pin():
    env={"PATH":"/usr/bin:/bin","HOME":"/nonexistent","GIT_CONFIG_NOSYSTEM":"1",
         "GIT_CONFIG_GLOBAL":"/dev/null","GIT_NO_REPLACE_OBJECTS":"1","GIT_OPTIONAL_LOCKS":"0"}
    values=subprocess.check_output(["/usr/bin/git","-c","safe.directory="+str(SOURCE),
        "-C",str(SOURCE),"rev-parse","HEAD","HEAD^{tree}"], text=True,env=env).splitlines()
    require(values == [PIN,TREE], "wrong actual Git source commit/tree")

def active_step():
    receipt=json_file(EVIDENCE/"receipt.json")
    require(receipt.get("status")=="running" and (receipt.get("pin"),receipt.get("git_tree"),
            receipt.get("root"),receipt.get("runner_sha256"))==(PIN,TREE,str(RUN),RUNNER_SHA),
            "wrong attempt, runner, or terminal receipt")
    latest=receipt["steps"][-1]
    require(latest["name"]==STAGE and "exit" not in latest and latest["cwd"]==str(RUN),
            "expected active joint-source-build")
    args=latest["argv"]
    require(args[0]=="bwrap" and args[-5:]==["lake",*LAKE_ARGS], "incorrect recorded stage command")
    require(all(v in args for v in ("--unshare-all","--die-with-parent","--new-session")) and
            bound(args,"--ro-bind",SOURCE,"/project") and bound(args,"--ro-bind",TOOLS,"/tool") and
            bound(args,"--bind",SOURCE/".lake/build","/project/.lake/build"),"wrong recorded sandbox")
    return args

def identity():
    step=active_step()
    pid=unique_lake(all_argv())
    lake=procrow(pid)
    require(same_exe(lake,TOOLS/"bin/lake"), "wrong Lake executable")
    ns=PROC/str(pid)
    require(os.path.samefile(ns/"root/project",SOURCE) and
            os.path.samefile(ns/"root/project/.lake/build",SOURCE/".lake/build"),"wrong project device/inode")
    require(any(l.split(":")[-1].endswith("/tg-source-replay.service") for l in (ns/"cgroup").read_text().splitlines()),
            "Lake not in the expected transient service")
    uptime=float((PROC/"uptime").read_text().split()[0])
    require(uptime-lake["start_ticks"]/os.sysconf("SC_CLK_TCK") >= MIN_LAKE_AGE,"Lake is too young")
    parents=[]; parent=procrow(lake["ppid"])
    while same_exe(parent,BWRAP_EXE):
        require(len(parents)<5,"unexpected bubblewrap ancestry")
        parents.append(parent);parent=procrow(parent["ppid"])
    require(parents and same_exe(parent,TIME_EXE),"timing or bwrap ancestor missing")
    timer=parent
    require(argv(timer["pid"]) == ["/usr/bin/time","-v","-o",str(EVIDENCE/(STAGE+".time")),*step],
            "wrong timing wrapper command")
    worker=procrow(timer["ppid"]);args=argv(worker["pid"])
    require(same_exe(worker,PYTHON_EXE) and len(args)>2 and args[1]==str(RUNNER),
            "wrong Python verifier or script")
    for flag,value in [("--run-dir",str(RUN)),("--commit",PIN),("--tree",TREE),("--toolchain-dir",str(TOOLS))]:
        require(args.count(flag)==1 and args[args.index(flag)+1]==value,"wrong worker "+flag)
    require(os.path.samefile(PROC/str(timer["pid"])/"fd/1",LOG),
            "timing process does not own the expected raw output")
    require(not (ROOT/"driver.exit").exists(),"driver already has a terminal status")
    return {"lake":lake,"bwrap":parents,"time":timer,"worker":worker,
            "boot_id":(PROC/"sys/kernel/random/boot_id").read_text().strip()}

def ready():
    require(sys.platform=="linux","Linux /proc required")
    require(hasattr(os,"pidfd_open"),"pidfd_open unavailable")
    require(ROOT.resolve(strict=True)==ROOT and SOURCE.resolve(strict=True)==SOURCE,"unexpected attempt/source path")
    require(not os.path.lexists(ROOT/INTENT),"an interruption intent already exists")
    source_pin()
    require(hash_file(RUNNER)==RUNNER_SHA,"installed runner digest mismatch")
    marker=ROOT/"diagnostic-memory-change.json"
    require(hash_file(marker)==MEMORY_SHA,"diagnostic memory marker digest mismatch")
    require(isinstance(json_file(marker),dict),"invalid memory marker")
    first=identity()
    before=read_failures(ROOT/"joint-source-build-before-memory-change.log",BEFORE_SHA)
    live=read_failures(LOG)
    require(identity()==first,"identity changed while recording diagnostics")
    return {"source":PIN,"tree":TREE,"attempt":ATTEMPT,"runner_sha256":RUNNER_SHA,
            "memory_marker_sha256":MEMORY_SHA,"historical":before,"live":live,
            "identity":first,"observed_unix":time.time()}

def main():
    try:
        require(len(sys.argv)==1,"this probe accepts no options")
        print(json.dumps({"ready":True,"read_only":True,"diagnosis":ready()},sort_keys=True))
        return 0
    except (Refused,OSError,ValueError,KeyError,IndexError,subprocess.SubprocessError) as e:
        print(json.dumps({"ready":False,"read_only":True,"reason":str(e)}))
        return 2

if __name__=="__main__":
    raise SystemExit(main())
