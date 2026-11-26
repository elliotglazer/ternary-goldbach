"""Check the recorded source costs and protected verifier receipts for the original binary endpoint."""

import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent
SOURCE = "f17b38415535507fe31ba15eba396ef7fbd863af"
TREE = "c5d1fc25d678af056f4b23e4a3d89b1f916ea371"
THEOREM = "SmallGoldbach.ProductPrefix564386325504.binaryGoldbachUpTo"
CHALLENGE = "553a79110caf1a369e4eb9b6d30bc797218c564d4afc01cd4aaf15fd8ca724f2"
AXIOMS = {"propext", "Classical.choice", "Quot.sound"}
MARKERS = {
    "nanoda kernel accepts the solution",
    "Lean default kernel accepts the solution",
    "Your solution is okay!",
}


def digest(path):
    with path.open("rb") as handle:
        return hashlib.file_digest(handle, "sha256").hexdigest()


def read_json(name):
    return json.loads((ROOT / name).read_bytes())


def require(value, message):
    if not value:
        raise ValueError(message)


def check_sources(repo, source_dir, rows):
    command = ["git", "-C", str(repo)]
    tree = subprocess.check_output(command + ["rev-parse", SOURCE + "^{tree}"], text=True)
    require(tree.strip() == TREE, "unexpected source tree")
    listing = subprocess.check_output(command + ["ls-tree", "-r", "-z", TREE])
    blob_ids = {}
    for entry in listing.split(b"\0"):
        if entry:
            meta, path = entry.split(b"\t", 1)
            blob_ids[path] = meta.split()[2]
    for row in rows:
        path = row["module"].replace(".", "/") + ".lean"
        raw = (source_dir / path).read_bytes()
        object_header = b"blob " + str(len(raw)).encode() + b"\0"
        require(hashlib.sha1(object_header + raw).hexdigest().encode() == blob_ids[path.encode()],
                "source does not match Git tree: " + path)
        require(hashlib.sha256(raw).hexdigest() == row["source_sha256"], "source digest: " + path)


def check_source_receipt(repo=None, source_dir=None):
    receipt = read_json("source-build.json")
    cost = read_json("source-cost.json")
    require(receipt["source_commit"] == cost["source_commit"] == SOURCE, "source commit")
    require(receipt["theorem"] == cost["theorem"] == THEOREM, "source theorem")
    require(cost["sourcebuild_receipt_sha256"] == digest(ROOT / "source-build.json"),
            "source receipt digest")
    require(receipt["source_sha256"] == digest(ROOT / "ProductPrefix564386325504.lean"),
            "root source digest")
    require(receipt["axiom_log_sha256"] == digest(ROOT / "axioms.log"), "axiom report")
    rows = receipt["accepted_source_and_object_hashes"]
    require(len(rows) == len({row["module"] for row in rows}) == 415, "source count")
    cpu = sum(row["user_cpu_s"] + row["system_cpu_s"] for row in rows)
    require(cpu == cost["total_successful_producer_cpu_seconds"]
            == receipt["unique_producer_cpu_s_including_root"], "source CPU accounting")
    if repo is not None:
        check_sources(repo, source_dir or repo, rows)
    return receipt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--proof-git", type=Path, help="read all 415 sources from the original Git tree")
    parser.add_argument("--proof-source", type=Path, help="path to a separate copy of the 415 pinned sources")
    parser.add_argument("--exports", type=Path, help="compare the locally retained exports with the receipt")
    args = parser.parse_args()
    require(args.proof_git or args.proof_source is None, "--proof-source requires --proof-git")
    source = check_source_receipt(args.proof_git, args.proof_source)
    policy = read_json("comparator.json")
    require(policy["challenge_module"] == "TrustedBinaryEndpoint"
            and policy["solution_module"] == "ProductPrefix564386325504"
            and policy["theorem_names"] == [THEOREM] and policy["definition_names"] == []
            and set(policy["permitted_axioms"]) == AXIOMS
            and len(policy["permitted_axioms"]) == 3
            and policy["external_kernels"] == {"nanoda": ["nanoda_bin"]},
            "unexpected comparator policy")
    native = read_json("native-export.json")
    judge = read_json("protected-kernels.json")
    stage = judge["stages"]["protected-kernels"]
    require(native["theorem"] == judge["theorem"] == THEOREM, "checked theorem")
    require(native["commit"] == SOURCE and native["eligible_modules"] == 415, "export source")
    require(native["status"] == "exported" and native["exit"] == 0, "export result")
    require(native["target_object_sha256"] == source["facets_sha256"][".olean"], "root object")
    require(native["challenge_sha256"] == digest(ROOT / "TrustedBinaryEndpoint.lean")
            == "8b8cfbc6c2727fd9c509c559af6ffaa6f5e764e2409dbad0ea1ab60bc529b523",
            "trusted challenge source")
    require(native["challenge_export_sha256"] == judge["challenge_sha256"] == CHALLENGE,
            "trusted challenge export")
    require(native["solution"]["sha256"] == judge["solution_sha256"], "solution export")
    require(set(native["observed_axioms"]) == AXIOMS, "observed axioms")
    require(judge["native_receipt_sha256"] == digest(ROOT / "native-export.json"), "native receipt")
    if judge.get("retained_nanoda"):
        first = read_json("first-protected-kernels.json")
        retained = judge["retained_nanoda"]
        require(digest(ROOT / "first-protected-kernels.json") == retained["prior_receipt_sha256"],
                "original positive NanoDa receipt")
        for key in ("native_receipt_sha256", "theorem", "solution_sha256", "challenge_sha256",
                    "tools", "bwrap_sha256", "checker", "uid"):
            require(first[key] == judge[key], "mismatched protected inputs: " + key)
        require(first["policy_sha256"] == retained["prior_policy_sha256"]
                == digest(ROOT / "comparator.json"), "original two-kernel policy")
        require(read_json("default-only-policy.json") == {**policy, "external_kernels": {}}
                and judge["policy_sha256"] == digest(ROOT / "default-only-policy.json"),
                "default-only recovery policy")
        prior_log = ROOT / "first-protected-kernels.log"
        require(first["stages"]["protected-kernels"]["log_sha256"]
                == retained["prior_log_sha256"] == digest(prior_log), "original kernel log")
        require(first["status"] == "incomplete" and "host" in first["reason"]
                and first["observed_kernel_markers"]["nanoda kernel accepts the solution"]
                and not first["observed_kernel_markers"]["Lean default kernel accepts the solution"],
                "first attempt must record the actual NanoDa acceptance")
        require("nanoda kernel accepts the solution" in prior_log.read_text().splitlines(),
                "first attempt NanoDa verdict")
        needed = MARKERS - {"nanoda kernel accepts the solution"}
        require(not judge["current_kernel_markers"]["nanoda kernel accepts the solution"],
                "recovery reran external kernel")
    else:
        require(judge["policy_sha256"] == digest(ROOT / "comparator.json"), "comparator policy")
        needed = MARKERS
    require(judge["success"] is True and judge["status"] == "accepted" and stage["exit"] == 0,
            "protected comparator result")
    require(stage["log_sha256"] == digest(ROOT / "protected-kernels.log"), "protected log")
    log = (ROOT / "protected-kernels.log").read_bytes().decode().splitlines()
    require(needed <= set(log) and all(judge["kernel_markers"].get(m) for m in MARKERS),
            "protected kernel verdicts")
    if args.exports:
        require(digest(args.exports / "challenge.export") == CHALLENGE, "challenge bytes")
        require(digest(args.exports / "solution.export") == judge["solution_sha256"], "proof bytes")
    print("Verified the source accounting and recorded verdicts of both protected kernels.")


if __name__ == "__main__":
    main()
