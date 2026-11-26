"""Check that queued CLI jobs hand authenticated predecessor tokens, in order, to the worker."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

import warm_dispatch as dispatch
import warm_supervisor as supervisor


class LayerDispatch(unittest.TestCase):
    def setUp(self):
        self.commit = "a" * 40
        self.tree = "b" * 40
        self.predecessors = ["1" * 32, "2" * 32]

    def cli_job(self, previous):
        argv = ["warm_dispatch.py", "--commit", self.commit, "--tree", self.tree]
        for token in previous:
            argv.extend(["--previous-job", token])
        recorded = []
        validate = supervisor.validate_request

        def capture(job):
            validate(job)
            recorded.append(job.copy())

        with patch.object(sys, "argv", argv), patch.object(supervisor, "validate_request", capture), \
                patch.object(dispatch, "public_candidate", side_effect=InterruptedError("after CLI validation")):
            with self.assertRaises(InterruptedError):
                dispatch.main()
        return recorded[0]

    def test_immutable_v1_and_v2_requests(self):
        first = self.cli_job([])
        self.assertNotIn("previous_jobs", first)
        second = self.cli_job(self.predecessors)
        self.assertEqual(second["previous_jobs"], self.predecessors)
        self.assertNotEqual(second["token"], first["token"])
        self.assertEqual(second, self.cli_job(self.predecessors))
        self.assertNotEqual(second["token"], self.cli_job(self.predecessors[::-1])["token"])
        for previous in [["bad"], [first["token"], first["token"]], [str(i) * 32 for i in range(9)]]:
            with self.assertRaises(ValueError):
                self.cli_job(previous)
        with self.assertRaisesRegex(ValueError, "full warm Main"):
            supervisor.validate_request(dict(second, checks=[["Main", "a" * 64]], main=False))
        with self.assertRaisesRegex(ValueError, "self-referencing"):
            supervisor.validate_request(dict(second, previous_jobs=[second["token"]]))

    def test_path_from_saved_queue_to_argv_and_finished_status(self):
        job = self.cli_job(self.predecessors)
        actual = []

        def recorded_run(command, **options):
            actual.append(command)
            return subprocess.CompletedProcess(command, 1)

        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp)
            for folder in ("jobs", "pending", "claimed"):
                (root / folder).mkdir()
            (root / "pending" / (job["token"] + ".json")).write_text(json.dumps(job))
            with patch.object(supervisor, "QUEUE", root), \
                    patch.object(supervisor, "parent_receipt", return_value=supervisor.PARENT_SHA), \
                    patch.object(supervisor, "prepare_repo", return_value=root / "jobs"), \
                    patch.object(supervisor, "run", side_effect=recorded_run):
                admitted = supervisor.next_job()
                self.assertEqual(admitted, job)
                supervisor.handle(admitted)
            self.assertEqual(len(actual), 1)
            cmd = actual[0]
            self.assertEqual(cmd[-4:], ["--previous-job", self.predecessors[0], "--previous-job", self.predecessors[1]])
            self.assertEqual(cmd[cmd.index("--receipt-sha") + 1], supervisor.PARENT_SHA)
            self.assertEqual(cmd[cmd.index("--deadline-epoch") + 1], str(supervisor.DEADLINE))
            status = json.loads((root / "jobs" / job["token"] / "status.json").read_bytes())
            self.assertEqual(status["job"], job)
            self.assertEqual(status["warm_main_exit"], 1)
            self.assertIn("finished_unix", status)
            rendered = dispatch.enqueue_shell(job, "vol-" + "5"*17, "6"*64, job["token"])
            self.assertIn("Other warm supervisor version active", rendered)


if __name__ == "__main__":
    unittest.main()
