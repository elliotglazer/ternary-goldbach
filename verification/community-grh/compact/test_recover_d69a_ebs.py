"""Offline regression controls. An AWS account and network are unnecessary."""
import base64
import gzip
import json
from pathlib import Path
import random
import tempfile
import unittest
from unittest.mock import patch

import recover_d69a_ebs as recovery


class RetainedReceiptTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        (self.root / "run/evidence").mkdir(parents=True)
        self.log = b"source diagnostics\n" * 12
        self.intent = b'{"intent":"test SIGTERM"}\n'
        self.full = recovery.pack({"root": str(recovery.ROOT / "run"), "pin": recovery.PIN,
            "git_tree": recovery.TREE, "runner_sha256": recovery.WORKER, "status": "failed",
            "steps": [{"name": "joint-source-build", "exit": 143, "log_sha256": recovery.sha(self.log)}],
            "sample": random.Random(10).randbytes(55000).hex()})
        self.write(recovery.RECEIPT, self.full)
        self.write("run/evidence/joint-source-build.log", self.log)
        self.write(recovery.INTENT_PATH, self.intent)
        self.write("driver.exit", b"1\n")
        self.write("driver.log", b"")
        pins = patch.multiple(recovery, INTENT=recovery.sha(self.intent),
                              PREFIXES={25: recovery.sha(self.log[:25]), 50: recovery.sha(self.log[:50])})
        pins.start()
        self.addCleanup(pins.stop)

    def write(self, rel, raw):
        (self.root / rel).write_bytes(raw)

    def test_transfer_and_original_driver_frames(self):
        summary = recovery.pack({"commit": recovery.PIN, "tree": recovery.TREE, "driver_exit": 1,
            "receipt_path": str(recovery.ROOT / recovery.RECEIPT), "receipt_sha256": recovery.sha(self.full),
            "status": "failed"})
        ref = f"TG435_RECEIPT_REF {recovery.ROOT / recovery.RECEIPT} {recovery.sha(self.full)}"
        marker = "TG435_RECEIPT_V1 " + recovery.sha(summary) + " " + base64.b64encode(gzip.compress(summary)).decode()
        self.write("driver.log", (ref + "\n" + marker + "\n").encode())
        env = recovery.collect(self.root)
        packed = gzip.compress(recovery.pack(env), mtime=0)
        self.assertGreater(len(packed), recovery.CHUNK * 2)
        calls = []
        def read(offset):
            calls.append(offset)
            page = recovery.response(packed, offset)
            self.assertLess(len(recovery.pack(page)), 20500)
            return page
        files = recovery.validated_files(recovery.receive(read))
        self.assertGreater(len(calls), 2)
        self.assertEqual(files["receipt.json"], self.full)
        self.assertEqual(files["summary.json"], summary)
        self.assertEqual(files[recovery.INTENT_PATH], self.intent)
        self.assertEqual(json.loads(files["ebs-recovery.json"])["source_log_sha256"], recovery.sha(self.log))

    def test_missing_frames_are_explicit(self):
        env = recovery.collect(self.root)
        self.assertFalse(env["metadata"]["original_driver_summary_present"])
        self.assertNotIn("summary.json", recovery.validated_files(env))

    def test_digest_rejections(self):
        for rel, bad, expected in [(recovery.INTENT_PATH, b"{}", "intent digest mismatch"),
            ("run/evidence/joint-source-build.log", self.log+b"bad", "Full source log digest mismatch"),
            ("run/evidence/joint-source-build.log", b"bad"+self.log, "Saved log prefix mismatch"),
            ("driver.log", b"TG435_RECEIPT_REF wrong\n", "REF disagrees"),
            (recovery.RECEIPT, self.full.replace(recovery.WORKER.encode(), b"x"*64), "failed original attempt")]:
            with self.subTest(file=rel):
                original = (self.root/rel).read_bytes()
                self.write(rel, bad)
                with self.assertRaisesRegex(ValueError, expected):
                    recovery.collect(self.root)
                self.write(rel, original)

    def test_truncation_and_chunk_identity(self):
        payload = gzip.compress(recovery.pack(recovery.collect(self.root)), mtime=0)
        def bad(offset):
            page = recovery.response(payload, offset)
            if offset:
                page["sha256"] = "0"*64
            return page
        with self.assertRaisesRegex(ValueError, "identity changed"):
            recovery.receive(bad)
        def short(offset):
            page = recovery.response(payload, offset)
            page["base64"] = "AA=="
            return page
        with self.assertRaisesRegex(ValueError, "Incomplete or corrupt"):
            recovery.receive(short)


if __name__ == "__main__":
    unittest.main()
