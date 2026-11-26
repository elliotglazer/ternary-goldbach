"""Local tests of immutable submissions, serial work, host identity and hard-stop guards."""
import fcntl
import hashlib
import json
from pathlib import Path
import shlex
import subprocess
import tempfile
import unittest
from unittest.mock import patch

import warm_dispatch as d
import warm_supervisor as s


class Lifecycle(unittest.TestCase):
    def setUp(self):
        self.tmp=tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.path=Path(self.tmp.name)
        self.job={"token":"a"*32,"commit":"b"*40,"tree":"c"*40,"receipt_sha":s.PARENT_SHA,"main":True,"checks":[]}

    def test_real_git_commit_tree(self):
        work=self.path/"upstream"
        work.mkdir()
        def git(*cmd):
            return subprocess.check_output(["git","-C",str(work),*cmd],text=True).strip()
        git("init","-q")
        (work/"Main.lean").write_text("theorem fixture : True := True.intro\n")
        git("add","Main.lean")
        git("-c","user.name=Local","-c","user.email=fixture@example.invalid","commit","-qm","fixture")
        commit=git("rev-parse","HEAD")
        tree=git("rev-parse","HEAD^{tree}")
        for name,expected,success in [("real",tree,True),("wrong","f"*40,False)]:
            folder=self.path/name
            folder.mkdir()
            with patch.object(s,"URL",str(work)),patch.object(s.time,"time",return_value=s.DEADLINE-10000):
                if success:
                    repo=s.prepare_repo(commit,expected,folder)
                    self.assertEqual(subprocess.check_output(["git","--git-dir="+str(repo),"show",commit+":Main.lean"],text=True),
                                     (work/"Main.lean").read_text())
                else:
                    with self.assertRaisesRegex(ValueError,"tree differs"):
                        s.prepare_repo(commit,expected,folder)

    def test_atomic_claim_and_single_lock(self):
        (self.path/"pending").mkdir()
        (self.path/"claimed").mkdir()
        with patch.object(s,"QUEUE",self.path):
            (self.path/"pending/a.json").write_text(json.dumps(self.job))
            self.assertEqual(s.next_job(),self.job)
            self.assertIsNone(s.next_job())
            self.assertTrue((self.path/"claimed/a.json").is_file())
        with s.lock_file(self.path/"lock") as first:
            with self.assertRaises(BlockingIOError):
                s.lock_file(self.path/"lock",True)

    def test_bound_guards(self):
        old="e"*64
        for changes in ({"receipt_sha":old},{"commit":"main"},{"main":False},{"token":"../unsafe"}):
            with self.assertRaises(ValueError):
                s.validate_request(dict(self.job,**changes))
        command=d.enqueue_shell(self.job,"vol-"+"1"*17,"1"*64,self.job["token"])
        prefix=shlex.split(command)
        self.assertEqual(prefix[:5],["flock","-x","/run/lock/tg-joint-dispatch.lock","sh","-ec"])
        subprocess.run(["sh","-n"],input=prefix[5],text=True,check=True)
        self.assertIn("RuntimeMaxSec=",prefix[5])
        self.assertIn("cold_idle ||",prefix[5])
        self.assertIn("tg-warm-main-queue.lock",prefix[5])
        self.assertNotIn("stop-instances",command)
        self.assertNotIn("tg-source-replay.service --",command)
        self.assertIn("CPUQuota=1600%",d.PROPERTIES)
        self.assertIn("MemoryHigh=48G",d.PROPERTIES)
        self.assertIn("MemoryMax=64G",d.PROPERTIES)
        self.assertIn("MemorySwapMax=0",d.PROPERTIES)
        self.assertEqual(s.IDLE,480)

    def test_cloud_fixed_stop(self):
        vol="vol-"+"1"*17
        def responses(*args):
            pair=args[:2]
            if pair==("cloudformation","describe-stacks"):
                return {"Stacks":[{"Outputs":[{"OutputKey":"Instance","OutputValue":d.HOST},
                                              {"OutputKey":"Evidence","OutputValue":vol}]}]}
            if pair==("ec2","describe-instances"):
                return {"Reservations":[{"Instances":[{"InstanceId":d.HOST,"InstanceType":"r7i.8xlarge","State":{"Name":"stopped"},
                                                         "BlockDeviceMappings":[{"Ebs":{"VolumeId":vol}}]}]}]}
            if pair==("ec2","describe-volumes"):
                return {"Volumes":[{"VolumeId":vol,"Size":600,"Attachments":[{"InstanceId":d.HOST,"State":"attached"}]}]}
            if pair==("cloudformation","describe-stack-resource"):
                return {"StackResourceDetail":{"PhysicalResourceId":"default/Deadline"}}
            if pair==("scheduler","get-schedule"):
                return self.sched
            self.fail(pair)
        base={"State":"ENABLED","ScheduleExpression":d.SCHEDULE,"Target":{
            "Arn":"arn:aws:scheduler:::aws-sdk:ec2:stopInstances","Input":json.dumps({"InstanceIds":[d.HOST]})}}
        with patch.object(d,"aws",side_effect=responses),patch.object(d.time,"time",return_value=s.DEADLINE-1000):
            self.sched=base
            self.assertEqual(d.validate_cloud(),("stopped",vol))
            self.sched=dict(base,ScheduleExpression="at(2030-11-26T10:17:24)")
            with self.assertRaisesRegex(ValueError,"Original fixed"):
                d.validate_cloud()
            self.sched=dict(base,State="DISABLED")
            with self.assertRaisesRegex(ValueError,"Original fixed"):
                d.validate_cloud()
        with patch.object(d,"aws",side_effect=responses),patch.object(d.time,"time",return_value=s.DEADLINE-240):
            self.sched=base
            with self.assertRaisesRegex(ValueError,"Fewer than"):
                d.validate_cloud()


if __name__=="__main__":
    unittest.main()
