import base64, hashlib, importlib, json, os, random, subprocess, sys, tempfile, unittest
from pathlib import Path
import recover_preflight_5d9a as recovery
import recover_d69a_ebs as wire

class RecoveryTests(unittest.TestCase):
    def test_full_log_round_trip_and_rejections(self):
        previous = recovery.ROOT
        try:
            with tempfile.TemporaryDirectory() as folder:
                root = Path(folder).resolve()
                recovery.ROOT = root
                evidence = root / 'run/evidence'
                evidence.mkdir(parents=True)
                log = random.Random(30).randbytes(28000)
                full = {"root": str(root / "run"), "pin": recovery.PIN, "git_tree": recovery.TREE,
                        "runner_sha256": recovery.WORKER, "status": "failed",
                        "steps": [{"name": "source-preflight", "exit": 1, "log_sha256": wire.sha(log)}]}
                log_path=evidence / 'source-preflight.log'
                log_path.write_bytes(log)
                (evidence/'receipt.json').write_text(json.dumps(full))
                (root/'driver.exit').write_text('1\n')
                script=root/'worker.py'
                script.write_bytes(recovery.worker_script())
                requests=[]
                def page(offset):
                    requests.append(offset)
                    return json.loads(subprocess.check_output([sys.executable, '-B', str(script), '--worker', str(offset)]))
                got = wire.receive(page)
                self.assertEqual(set(got),set(recovery.FILES))
                self.assertGreater(len(requests),1)
                files={k:base64.b64decode(v,validate=True) for k,v in got.items()}
                recovery.validate(files)
                self.assertEqual(files['source-preflight.log'],log)
                wrong=dict(full,git_tree='0'*40)
                with self.assertRaisesRegex(ValueError,'identity'): recovery.validate({**files,'receipt.json':json.dumps(wrong).encode()})
                with self.assertRaisesRegex(ValueError,'nonzero'): recovery.validate({**files,'driver.exit':b'0\n'})
                with self.assertRaisesRegex(ValueError,'digest'): recovery.validate({**files,'source-preflight.log':log[1:]})
                log_path.write_bytes(log[1:])
                with self.assertRaisesRegex(ValueError,'digest'): recovery.collect()
        finally:
            recovery.ROOT=previous

if __name__=='__main__': unittest.main()
