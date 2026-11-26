"""Offline tests using stock Lake's real failed modules, append-only chunks and terminal digests."""
import base64
import hashlib
import json
import os
from pathlib import Path
import random
import subprocess
import sys
import tempfile
from unittest import TestCase, main

import watch_preflight_log as watch


class TestLog(TestCase):
    def test_live_goal_boundary(self):
        data=("\x1b[31m✖\x1b[0m [1/3] Building Lib.Left (1s)\n"
              "error: /project/Lib/Left.lean:3:5: unsolved goals\nh : 1 = 0\n⊢ False\n").encode()
        self.assertEqual(watch.findings(data),{"Lib.Left":{}})
        self.assertEqual(watch.findings(data+b"error: Lean ex"),{"Lib.Left":{}})
        result=watch.findings(data+b"error: Lean exited with code 1\n")
        self.assertEqual(result["Lib.Left"]["first_error"],data.decode().split("\n",1)[1])
        self.assertEqual(result["Lib.Left"]["first_goal"],result["Lib.Left"]["first_error"])

    def test_actual_lake_log_and_bound_receipt_transfer(self):
        with tempfile.TemporaryDirectory() as tmp:
            root=Path(tmp)
            (root/"lakefile.toml").write_text('name = "probe"\nversion = "0.1.0"\n[[lean_lib]]\nname = "Probe"\n')
            (root/"Probe").mkdir()
            for n in ["One","Two"]:
                (root/f"Probe/{n}.lean").write_text(
                    "theorem wrong : False := True.intro\n"
                    "theorem openGoal (h : 1 = 2) : False := by\n  skip\n")
            env=dict(os.environ, LEAN_NUM_THREADS="2",LAKE_ARTIFACT_CACHE="false")
            build=subprocess.run(["lake","--no-cache","build","+Probe.One","+Probe.Two"],
                                 cwd=root,env=env,stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
            self.assertNotEqual(build.returncode,0)
            results=watch.findings(build.stdout,terminal=True)
            self.assertEqual(set(results),{"Probe.One","Probe.Two"},build.stdout)
            for entry in results.values():
                self.assertIn("Type mismatch",entry["first_error"])
                self.assertIn("h : 1 = 2",entry["first_goal"])
                self.assertIn("⊢ False",entry["first_goal"])
            pin,tree,attempt="a"*40,"b"*40,"c"*32
            run=root/(pin+"-"+attempt)/"run"
            evidence=run/"evidence"
            evidence.mkdir(parents=True)
            random_text=base64.b64encode(random.Random(2026).randbytes(39000))+b"\n"
            raw=random_text+build.stdout
            (evidence/"source-preflight.log").write_bytes(raw)
            step={"name":"source-preflight"}
            receipt={"root":str(run),"pin":pin,"git_tree":tree,"steps":[step],"status":"running"}
            (evidence/"receipt.json").write_text(json.dumps(receipt))
            code=watch.REMOTE.replace("Path('/work/compact-joint-runs')","Path("+repr(str(root))+")")
            def get(size,digest,selected_tree=tree):
                cmd=[sys.executable,"-B","-c",code,pin,attempt,selected_tree,str(size),digest.hexdigest()]
                return json.loads(subprocess.check_output(cmd,stderr=subprocess.DEVNULL))
            size=0
            digest=hashlib.sha256()
            pages=[]
            while size<len(raw):
                page=get(size,digest)
                self.assertLess(len(json.dumps(page)),20000)
                chunk,digest,terminal=watch.decode_page(page,pin,tree,attempt,size,digest)
                self.assertFalse(terminal)
                pages.append(chunk)
                size+=len(chunk)
            self.assertGreater(len(pages),1)
            self.assertEqual(b"".join(pages),raw)
            step.update(exit=1,log_sha256=watch.sha(raw))
            (evidence/"receipt.json").write_text(json.dumps(receipt))
            final=get(size,digest)
            self.assertTrue(watch.decode_page(final,pin,tree,attempt,size,digest)[2])
            for k,v in [("prefix_sha256","x"*64),("terminal_log_sha256","0"*64),("chunk_bytes",77)]:
                with self.assertRaises(ValueError):
                    watch.decode_page(dict(final,**{k:v}),pin,tree,attempt,size,digest)
            with self.assertRaises(subprocess.CalledProcessError):
                get(size,digest,"e"*40)
            (evidence/"source-preflight.log").write_bytes(b"X"+raw[1:])
            with self.assertRaises(subprocess.CalledProcessError):
                get(size,digest)


if __name__=="__main__":
    main()
