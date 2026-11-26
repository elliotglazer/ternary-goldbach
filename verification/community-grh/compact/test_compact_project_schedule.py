#!/usr/bin/env python3
"""Offline controls for the optional early-source milestone and scheduling override."""
import argparse
import ast
import contextlib
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
from unittest.mock import patch

import compact_joint as worker
import compact_joint_stack as launcher
from test_compact_joint_stack import exercise

FAILED_TARGETS = ["Lib.General.Analysis.ZpowSum","Lib.General.Algebra.RingActions","Lib.GaloisRep.Pseudocharacter.SemisimpleReps","TernaryGoldbach.MajorArcs.HHFourier","Lib.Shimura.Uniformisation.Frames","Lib.General.Groups.ArtinDefs","Lib.ClassField.GaloisCohomology.DiscreteUnits","Lib.DiscreteSeries.Haar.CompactDualMeasure","Lib.LocalGL.Green.MackeyFormula"]

def check_source_inputs():
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        compact_dir = root / "CompactGRH"
        path = compact_dir / "src/Lib/A.lean"
        path.parent.mkdir(parents=True)
        path.write_text("def a := 1\n")
        good = root / "B.lean"
        good.write_text("def b := 1\n")
        manifest = {"files": [{"path": "Lib/A.lean", "converted_sha256": worker.digest(path)}]}
        (compact_dir / "source-manifest.json").write_text(json.dumps(manifest))
        (root / "source-manifest.json").write_text(json.dumps({"sources": {"B.lean": {"sha256": worker.digest(good)}}}))
        assert set(worker.verified_preflight_modules(root, ["Lib.A", "B"])) == {"Lib.A", "B"}
        assert worker.verified_preflight_modules(root, []) == {}
        for module in ["Missing", "B"]:
            if module == "B":
                good.write_text("def b := 2\n")
            try:
                worker.verified_preflight_modules(root, [module])
            except RuntimeError:
                continue
            raise AssertionError("Absent or changed early source was accepted")


def check_cli_refusals():
    argv = ["compact_joint_stack.py", "--commit", "1"*40, "--tree", "2"*40]
    invalid = [
        ["--lake-threads","0"], ["--lake-threads","33"], ["--preflight-module","--"],
        ["--preflight-module","A;B"], ["--preflight-module","../A"],
        ["--preflight-module","A","--preflight-module","A"],
        [x for n in range(33) for x in ("--preflight-module",f"A{n}")],
    ]
    for extra in invalid:
        with patch.object(sys, "argv", argv+extra), patch.object(launcher, "aws", side_effect=AssertionError), \
                patch.object(launcher, "public_pin", side_effect=AssertionError), contextlib.redirect_stderr(io.StringIO()):
            try:
                launcher.main()
            except SystemExit as exc:
                assert exc.code == 2
            else:
                raise AssertionError("Invalid input reached the launcher")


def check_public_pin():
    commit, tree = "1" * 40, "2" * 40
    commit_record = {"sha": commit, "tree": {"sha": tree}}
    entry = {"path": "CompactGRH/src/Lib/A.lean", "type": "blob", "mode": "100644"}
    for pass_expected, truncated, files in [(True,False,[entry]),(False,True,[entry]),(False,False,[])]:
        replies = [io.BytesIO(json.dumps(x).encode()) for x in [
            commit_record, {"sha": tree, "truncated": truncated, "tree": files}]]
        with patch.object(launcher.urllib.request, "urlopen", side_effect=replies):
            try:
                launcher.public_pin(commit,tree,["Lib.A"])
            except SystemExit:
                assert not pass_expected
            else:
                assert pass_expected


def check_stage_arguments():
    tree = ast.parse(Path(worker.__file__).read_text())
    box = next(node for node in ast.walk(tree) if isinstance(node, ast.FunctionDef) and node.name == "box")
    steps = {node.args[0].value: node for node in ast.walk(tree) if isinstance(node, ast.Call)
             and isinstance(node.func, ast.Name) and node.func.id == "step" and node.args
             and isinstance(node.args[0], ast.Constant)}
    assert steps["challenge-export"].lineno < steps["source-preflight"].lineno < steps["joint-source-build"].lineno
    assert steps["joint-source-build"].lineno < steps["axioms"].lineno < steps["solution-export"].lineno < steps["comparator"].lineno
    for explicit in (None, 4):
        scope = {"args": argparse.Namespace(threads=32,lake_threads=explicit), "os":os, "hostpaths":[],
                 "tc":Path("/tool"), "source":Path("/source"), "challenge":Path("/challenge"), "empty":Path("/empty"),
                 "pack":Path("/packages"), "early_targets":["+A","+B"], "targets":["Theorem"]}
        exec(compile(ast.Module(body=[box], type_ignores=[]), "actual-box", "exec"), scope)
        for stage in ["source-preflight", "joint-source-build", "compact-main-shard", "challenge-export"]:
            command = eval(compile(ast.Expression(steps[stage].args[1]), "actual-argv", "eval"), scope)
            expected = 32 if stage == "challenge-export" or explicit is None else 4
            assert command[command.index("LEAN_NUM_THREADS")+1] == str(expected)
            if stage == "source-preflight":
                assert command[-5:] == ["lake", "--no-cache", "build", "+A", "+B"]
            if stage == "joint-source-build":
                assert command[-5:] == ["lake", "--no-cache", "build", "+Main", "GoldbachSolution"]


def main():
    check_source_inputs()
    check_cli_refusals()
    check_public_pin()
    check_stage_arguments()
    exercise(launcher, lake_threads=4, modules=FAILED_TARGETS)
    print("Verified nine-target transport, default/tuned stage arguments, source hashes, and launch refusals.")


if __name__ == "__main__":
    main()
