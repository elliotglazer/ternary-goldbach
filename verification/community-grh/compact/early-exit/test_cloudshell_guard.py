"""Offline unit and subprocess tests. No AWS client or external network."""
from contextlib import redirect_stdout
import gzip
from io import BytesIO, StringIO
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import unittest
from unittest.mock import Mock, patch

import cloudshell_guard as wrapper


HERE = Path(__file__).parent
REV = "a" * 40


class GuardWrapperTests(unittest.TestCase):
    def setUp(self):
        self.helper = Mock(REGION="us-east-1")
        self.helper.host_and_volume.return_value = {"Instance": wrapper.HOST}
        self.helper.aws.return_value = {"Reservations": [{"Instances": [
            {"InstanceId": wrapper.HOST, "State": {"Name": "running"}}
        ]}]}
        self.sources = {name: (HERE / name).read_bytes() for name in wrapper.GUARD_HASHES}

    def local_fetch(self, revision, path, digest):
        self.assertEqual(revision, REV)
        name = Path(path).name
        self.assertEqual(path, wrapper.GUARDS + name)
        self.assertEqual(hashlib.sha256(self.sources[name]).hexdigest(), digest)
        return self.sources[name]

    def test_stopped(self):
        self.helper.aws.return_value["Reservations"][0]["Instances"][0]["State"]["Name"] = "stopped"
        output = StringIO()
        with redirect_stdout(output):
            self.assertEqual(wrapper.run(self.helper, REV, False, Mock(side_effect=AssertionError)), 0)
        self.assertFalse(json.loads(output.getvalue())["ssm_sent"])
        self.helper.ssm.assert_not_called()

    def test_wrong_stack_or_region(self):
        self.helper.host_and_volume.return_value["Instance"] = "different"
        with self.assertRaises(ValueError):
            wrapper.run(self.helper, REV, False, self.local_fetch)
        self.helper.aws.assert_not_called()

    def test_wrong_response_id(self):
        self.helper.aws.return_value["Reservations"][0]["Instances"][0]["InstanceId"] = "different"
        with self.assertRaises(ValueError):
            wrapper.run(self.helper, REV, False, self.local_fetch)
        self.helper.ssm.assert_not_called()

    def test_run_pinned_default(self):
        self.assertEqual(wrapper.run(self.helper, REV, False, self.local_fetch), 0)
        (host, command), kwargs = self.helper.ssm.call_args
        self.assertEqual(host, wrapper.HOST)
        self.assertEqual(kwargs, {"timeout": 90})
        self.assertIn("'interrupt': False", command)
        self.assertLess(len(command.encode()), 24 * 1024)

    def test_render_requires_both_digests(self):
        for name in self.sources:
            with self.subTest(name=name), self.assertRaises(ValueError):
                wrapper.render({**self.sources, name: b"replaced"}, False)

    def test_download_digest_and_revision(self):
        data = self.sources["ready_0b68.py"]
        path = wrapper.GUARDS + "ready_0b68.py"
        with patch.object(wrapper, "urlopen", return_value=BytesIO(data)) as fetch:
            self.assertEqual(wrapper.download(REV, path, hashlib.sha256(data).hexdigest()), data)
            fetch.assert_called_once_with(wrapper.RAW + REV + "/" + path, timeout=20)
        with patch.object(wrapper, "urlopen", return_value=BytesIO(b"bad")):
            with self.assertRaises(ValueError):
                wrapper.download(REV, path, hashlib.sha256(data).hexdigest())

    def test_reject_token_or_mutable_ref_before_network(self):
        for argv in (["main"], [REV, "--interrupt-after-recording", "wrong"]):
            with patch.object(wrapper, "download", side_effect=AssertionError), self.assertRaises(SystemExit):
                wrapper.main(argv)

    @unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0, "offline root Linux fixture")
    def test_real_transported_guards_refuse_missing_historical_attempt(self):
        self.assertFalse(Path("/work/compact-joint-runs", wrapper.PIN+"-"+wrapper.ATTEMPT).exists(),
                         "operate only on a clean local machine")
        before = set(Path("/tmp").glob("tg-0b68-guard-*"))
        for opt_in in (False, True):
            with self.subTest(opt_in=opt_in):
                run = subprocess.run(["sh", "-c", wrapper.render(self.sources, opt_in)],
                                     capture_output=True, text=True)
                self.assertEqual(run.returncode, 2, run.stderr)
                result = json.loads(run.stdout)
                self.assertFalse(result["signal_sent"])
                self.assertIn("reason", result)
                self.assertEqual(result["mode"], "interrupt" if opt_in else "probe")
        self.assertEqual(before, set(Path("/tmp").glob("tg-0b68-guard-*")))

    @unittest.skipUnless(sys.platform == "linux" and os.geteuid() == 0, "offline root Linux fixture")
    def test_readable_success_summary(self):
        # A local dummy imitates stdout only. The previous test runs both actual guard files.
        dummy = b'import json,os,sys\nassert os.getcwd().startswith("/tmp/tg-0b68-guard-")\nassert os.stat(".").st_mode & 0o777 == 0o700\nassert sys.argv[1:] == []\nd={"live":{"errors":{"A":"x","B":"y"},"prefix_bytes":30,"prefix_sha256":"abc"},"identity":{"lake":{"pid":123,"start_ticks":1}}}\nprint(json.dumps({"ready": True, "diagnosis": d}))\n'
        with patch.dict(wrapper.GUARD_HASHES, {"ready_0b68.py": hashlib.sha256(dummy).hexdigest()}):
            command = wrapper.render({**self.sources, "ready_0b68.py": dummy}, False)
        run = subprocess.run(["sh", "-c", command], capture_output=True, text=True)
        self.assertEqual(run.returncode, 0, run.stderr)
        result = json.loads(run.stdout)
        self.assertEqual((result["failed_target_count"], result["pid"], result["log_prefix_sha256"]), (2, 123, "abc"))
        self.assertTrue(result["ready"])


if __name__ == "__main__":
    unittest.main()
