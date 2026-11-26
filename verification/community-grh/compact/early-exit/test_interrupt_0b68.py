"""Linux tests. The only real signal recipient can be a sleep process created by this test."""
import contextlib
import hashlib
import io
import json
import os
from pathlib import Path
import signal
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch
sys.dont_write_bytecode = True
import ready_0b68 as g
import interrupt_0b68 as interrupt

def write(p, data):
    p.parent.mkdir(parents=True,exist_ok=True)
    p.write_bytes(data if isinstance(data,bytes) else data.encode())

def link(path,target):
    path.parent.mkdir(parents=True,exist_ok=True);path.symlink_to(target)

def cmdline(path,args):
    write(path,b'\0'.join(os.fsencode(v) for v in args)+b'\0')

class Guard(unittest.TestCase):
    def setUp(self):
        self.cleanup=contextlib.ExitStack();self.addCleanup(self.cleanup.close)
        base=Path(self.cleanup.enter_context(tempfile.TemporaryDirectory()))
        root=base/"attempt";run=root/"run";src=run/"source";ev=run/"evidence";log=ev/(g.STAGE+".log")
        proc=base/"proc";tools=base/"tool";runner=base/"worker.py"
        src.mkdir(parents=True);ev.mkdir(parents=True);(src/".lake/build").mkdir(parents=True)
        subprocess.run(["git","init","-q",str(src)],check=True)
        subprocess.run(["git","-C",str(src),"-c","user.name=Probe","-c","user.email=probe@example.invalid",
                        "commit","--allow-empty","-qm","Fixture"],check=True)
        pin,tree=subprocess.check_output(["git","-C",str(src),"rev-parse","HEAD","HEAD^{tree}"],text=True).split()
        self.sleep=subprocess.Popen(["/bin/sleep","180"])
        def clean_child():
            if self.sleep.poll() is None:
                self.sleep.terminate()
            self.sleep.wait(timeout=5)
        self.addCleanup(clean_child)
        self.pid=self.sleep.pid
        self.logger=log
        self.original=root/"joint-source-build-before-memory-change.log"
        self.marker=root/"diagnostic-memory-change.json"
        self.rcpt=ev/"receipt.json"
        records=[]
        for mod in sorted(g.ORIGINAL):
            path=mod.replace(".","/")+".lean"
            if mod.startswith("Lib."):path="CompactGRH/src/"+path
            row,col=g.DIRECT.get(mod,(1,3))
            records.append(f"\x1b[31merror: {path}:{row}:{col}: fixture error\x1b[0m\n")
        write(self.original,"".join(records));write(log,"".join(records)+"later output\n")
        write(self.marker,'{"diagnostic":true}\n');write(runner,"test driver")
        executables={"BWRAP_EXE":base/"bwrap","TIME_EXE":base/"time","PYTHON_EXE":base/"python"}
        for f in [*executables.values(),tools/"bin/lake"]:write(f,"mock executable "+f.name)
        for k,v in dict(ROOT=root,RUN=run,SOURCE=src,EVIDENCE=ev,LOG=log,RUNNER=runner,TOOLS=tools,PROC=proc,
                        PIN=pin,TREE=tree,RUNNER_SHA=g.hash_file(runner),BEFORE_SHA=g.hash_file(self.original),
                        MEMORY_SHA=g.hash_file(self.marker),**executables).items():
            self.cleanup.enter_context(patch.object(g,k,v))
        self.step=["bwrap","--unshare-all","--die-with-parent","--new-session","--ro-bind",str(src),"/project",
                   "--ro-bind",str(tools),"/tool","--bind",str(src/".lake/build"),"/project/.lake/build",
                   "lake",*g.LAKE_ARGS]
        self.rec={"status":"running","pin":pin,"git_tree":tree,"root":str(run),"runner_sha256":g.RUNNER_SHA,
                  "steps":[{"name":g.STAGE,"argv":self.step,"cwd":str(run)}]}
        write(self.rcpt,json.dumps(self.rec))
        self.wid,self.tid,self.bwid=[self.pid+300000+i for i in range(3)]
        def fakeproc(pid,ppid,exe,args):
            d=proc/str(pid);cmdline(d/"cmdline",args);link(d/"exe",exe)
            write(d/"stat",f"{pid} (fixture) S {ppid} "+"0 "*17+"100 0\n")
        fakeproc(self.wid,1,g.PYTHON_EXE,["python3",str(runner),"--run-dir",str(run),"--commit",pin,
                                         "--tree",tree,"--toolchain-dir",str(tools)])
        fakeproc(self.tid,self.wid,g.TIME_EXE,["/usr/bin/time","-v","-o",str(ev/(g.STAGE+".time")),*self.step])
        fakeproc(self.bwid,self.tid,g.BWRAP_EXE,self.step)
        fakeproc(self.pid,self.bwid,tools/"bin/lake",["lake",*g.LAKE_ARGS])
        write(proc/"uptime","200 0\n");write(proc/"sys/kernel/random/boot_id","fixture-boot\n")
        write(proc/str(self.pid)/"cgroup","0::/system.slice/tg-source-replay.service\n")
        link(proc/str(self.pid)/"root/project",src);link(proc/str(self.tid)/"fd/1",log)

    def test_read_only_is_default(self):
        with patch("signal.pidfd_send_signal",side_effect=AssertionError),contextlib.redirect_stdout(io.StringIO()):
            self.assertEqual(interrupt.main([]),0)
        self.assertFalse((g.ROOT/interrupt.INTENT).exists());self.assertIsNone(self.sleep.poll())

    def test_requires_exact_confirmation(self):
        with contextlib.redirect_stdout(io.StringIO()):
            self.assertEqual(interrupt.main(["--interrupt-after-recording","incorrect"]),2)
        self.assertFalse((g.ROOT/interrupt.INTENT).exists());self.assertIsNone(self.sleep.poll())

    def test_refuses_duplicate_exact_inner_argv(self):
        cmdline(g.PROC/"999999/cmdline",["/tool/bin/lake",*g.LAKE_ARGS])
        with self.assertRaisesRegex(g.Refused,"exactly one"):g.ready()

    def test_marker_is_byte_exact(self):
        write(self.marker,'{"same":"idea"}')
        with self.assertRaisesRegex(g.Refused,"marker digest mismatch"):g.ready()

    def test_prelimit_hash_must_match(self):
        write(self.original,self.original.read_bytes()+b"additional")
        with self.assertRaisesRegex(g.Refused,"pre-limit log digest"):g.ready()

    def test_all_9_are_required(self):
        write(g.LOG,"".join(l for l in g.LOG.read_text().splitlines(True) if "RingActions" not in l))
        with self.assertRaisesRegex(g.Refused,"missing original failures"):g.ready()

    def test_target_text_is_not_source_coordinate(self):
        write(g.LOG,g.LOG.read_text().replace("ArtinDefs.lean:23:2:","ArtinDefs.lean:23:3:"))
        with self.assertRaisesRegex(g.Refused,"coordinates"):g.ready()

    def test_wrong_commit_refused(self):
        with patch.object(g,"PIN","0"*40),self.assertRaisesRegex(g.Refused,"actual Git"):g.ready()

    def test_new_lake_refused(self):
        write(g.PROC/"uptime","3 0\n")
        with self.assertRaisesRegex(g.Refused,"too young"):g.ready()

    def test_wrong_mount_refused(self):
        p=g.PROC/str(self.pid)/"root/project";p.unlink();p.symlink_to(g.ROOT)
        with self.assertRaisesRegex(g.Refused,"device/inode"):g.ready()

    def test_wrong_timing_argv_refused(self):
        cmdline(g.PROC/str(self.tid)/"cmdline",["time","-v"])
        with self.assertRaisesRegex(g.Refused,"timing wrapper command"):g.ready()

    def test_finished_stage_refused(self):
        self.rec["steps"][-1]["exit"]=1;write(self.rcpt,json.dumps(self.rec))
        with self.assertRaisesRegex(g.Refused,"active joint-source"):g.ready()

    def test_changed_identity_after_intent_never_signals(self):
        save=interrupt.save_intent
        def change(record):
            save(record)
            write(g.PROC/str(self.pid)/"cgroup","0::/some/other.service\n")
        with patch.object(interrupt,"save_intent",change),patch("signal.pidfd_send_signal",side_effect=AssertionError):
            with self.assertRaisesRegex(g.Refused,"transient service"):interrupt.commit()
        self.assertTrue((g.ROOT/interrupt.INTENT).is_file());self.assertIsNone(self.sleep.poll())

    def test_preexisting_intent_not_overwritten(self):
        write(g.ROOT/interrupt.INTENT,"guard fixture")
        with self.assertRaisesRegex(g.Refused,"already exists"):interrupt.commit()
        self.assertEqual((g.ROOT/interrupt.INTENT).read_text(),"guard fixture");self.assertIsNone(self.sleep.poll())

    def test_targeted_pidfd_and_durable_presignal_record(self):
        send=signal.pidfd_send_signal
        def inspect_then_signal(fd,sig,info,flags):
            snap=json.loads((g.ROOT/interrupt.INTENT).read_bytes())
            self.assertEqual(snap["diagnosis"]["live"]["prefix_sha256"],g.hash_file(g.LOG))
            self.assertEqual(snap["diagnosis"]["identity"]["lake"]["pid"],self.pid)
            self.assertEqual(sig,signal.SIGTERM)
            return send(fd,sig,info,flags)
        with patch("signal.pidfd_send_signal",inspect_then_signal):
            output=interrupt.commit()
        self.assertEqual(output["pid"],self.pid);self.assertEqual(self.sleep.wait(timeout=4),-signal.SIGTERM)
        self.assertTrue((g.ROOT/interrupt.INTENT).is_file())

if __name__=="__main__":unittest.main(verbosity=2)
