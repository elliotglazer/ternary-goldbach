"""Verify the supplement's checksums, optional source repository, or an original receipt."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
CANDIDATE = "3ca2fcf7e3dd1897ff242d8e482aa7f82abe263b"

def require(ok, message):
    if not ok:
        raise ValueError(message)

def digest(data):
    return hashlib.sha256(data).hexdigest()

def json_data(path):
    return json.loads(path.read_bytes())

def retained(original, shown):
    if type(original) is not type(shown):
        return False
    if isinstance(shown, dict):
        return all(k in original and retained(original[k], v) for k, v in shown.items())
    if isinstance(shown, list):
        items = iter(original)
        return all(any(retained(old, requested) for old in items) for requested in shown)
    return original == shown

def verify_source(repo, native):
    expected = {r["matches_candidate_source_git_blob"]: r["source_sha256"]
                for r in native if "matches_candidate_source_git_blob" in r}
    git = ["git", "-C", str(repo)]
    tree = subprocess.check_output(git + ["ls-tree", "-r", CANDIDATE], text=True).splitlines()
    enrolled = {line.split("\t", 1)[0].split()[-1] for line in tree if line.endswith(".lean")}
    require(expected.keys() <= enrolled, "Some source blobs are missing from the candidate tree")
    with subprocess.Popen(git + ["cat-file", "--batch"], stdin=subprocess.PIPE, stdout=subprocess.PIPE) as proc:
        for blob, checksum in sorted(expected.items()):
            proc.stdin.write((blob + "\n").encode()); proc.stdin.flush()
            header = proc.stdout.readline().decode().strip().split()
            require(len(header) == 3 and header[:2] == [blob, "blob"], "Missing Git object " + blob)
            size = int(header[2])
            raw = proc.stdout.read(size)
            require(len(raw) == size and proc.stdout.read(1) == b"\n", "Truncated Git object " + blob)
            require(digest(raw) == checksum, "Source SHA-256 mismatch for " + blob)
            require(hashlib.sha1(b"blob " + str(size).encode() + b"\0" + raw).hexdigest() == blob, "Git object mismatch")
        proc.stdin.close()
        require(proc.wait() == 0, "Git object reader failed")
    return len(expected)

def verify_original(path, native, groups):
    raw = path.read_bytes()
    checksum = digest(raw)
    matched = 0
    for row in native:
        if row["source_receipt_sha256"] != checksum:
            continue
        value = json.loads(raw)
        if "receipt_record" in row:
            value = value["modules"][row["receipt_record"].split("/", 2)[2]]
        require(row["source_sha256"] in (value.get("source_sha256"), value.get("lean_source_sha256")), "Source hash mismatch")
        require(value[row["time_field"]] == row["time"], "Timing mismatch")
        require(row["compiler_exit"] in [value[k] for k in ("exit","returncode","exit_code","return_code","compiler_exit") if k in value], "Exit mismatch")
        if "olean_sha256" in row:
            require(row["olean_sha256"] in json.dumps(value), "Object hash missing")
        matched += 1
    for group in groups:
        matched += sum(checksum == public["original_sha256"] for public in group["public_originals"])
        if not group.get("extract"):
            continue
        extract = json_data(HERE / group["extract"])
        for record in extract.get("records", []):
            if record["original_sha256"] == checksum:
                require(retained(json.loads(raw), record["measurements"]), "Curated measurements differ")
                matched += 1
        if extract.get("original_sha256") == checksum and "cases" in extract:
            original = [json.loads(l) for l in raw.splitlines() if l]
            require(len(original) == len(extract["cases"]), "Wrong number of sandbox cases")
            for rawcase, case in zip(original, extract["cases"]):
                require(all(rawcase[k] == case[k] for k in ("exit","stock_seccomp","bwrap_status_present","policy")), "Sandbox result differs")
                if "missing_shared_library" in case:
                    require(case["missing_shared_library"] in rawcase["stderr"], "Wrong missing library")
            matched += 1
    require(matched, "Supplied bytes do not match a recorded original")
    return matched

def verify_files():
    for line in (HERE / "SHA256SUMS").read_text().splitlines():
        checksum, name = line.split("  ", 1)
        path = (HERE / name).resolve(strict=True)
        require(path.is_relative_to(HERE) and digest(path.read_bytes()) == checksum, "Bad checksum " + name)
    native = [json.loads(line) for line in (HERE / "native-module-measurements.jsonl").read_text().splitlines()]
    summary = json_data(HERE / "native-module-summary.json")
    require(len(native) == summary["rows"] and len({r["module"] for r in native}) == summary["unique_modules"], "Native count mismatch")
    groups = json_data(HERE / "experiment-index.json")["groups"]
    for group in groups:
        if "extract" in group:
            require(digest((HERE / group["extract"]).read_bytes()) == group["extract_sha256"], "Experiment checksum mismatch")
    return native, groups

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-repo", type=Path, help="Local Git checkout containing the candidate source")
    parser.add_argument("--original", type=Path, action="append", default=[], help="Optional original receipt; repeat as needed")
    options = parser.parse_args()
    rows, groups = verify_files()
    result = {"native_measurements": len(rows), "experiments": len(groups)}
    if options.source_repo:
        result["source_blobs_verified"] = verify_source(options.source_repo, rows)
    if options.original:
        result["matching_original_records"] = sum(verify_original(p, rows, groups) for p in options.original)
    print(json.dumps(result, sort_keys=True))
