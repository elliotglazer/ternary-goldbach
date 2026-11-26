"""Restore the public files in this notebook's index from a Goldbach Git checkout."""

import argparse
import csv
import hashlib
import re
import subprocess
from pathlib import Path, PurePosixPath


def restore(repo, destination, index):
    destination.mkdir(parents=True, exist_ok=False)
    count = 0
    with index.open(encoding="utf-8", newline="") as stream, subprocess.Popen(
        ["git", "-C", str(repo), "cat-file", "--batch"],
        stdin=subprocess.PIPE, stdout=subprocess.PIPE,
    ) as git:
        for row in csv.DictReader(stream, delimiter="\t"):
            path = PurePosixPath(row["repository_path"])
            commit, blob = row["source_commit"], row["git_blob"]
            if not all(re.fullmatch(r"[0-9a-f]{40}", value) for value in (commit, blob)):
                raise ValueError("Invalid object id in the public file index")
            if path.is_absolute() or not path.parts or ".." in path.parts or any(
                ":" in part or "\\" in part for part in path.parts
            ):
                raise ValueError(f"Invalid repository path {path}")
            # Resolve the name in its original tree as well as checking the bytes.
            git.stdin.write(f"{commit}:{path.as_posix()}\n".encode())
            git.stdin.flush()
            header = git.stdout.readline().decode().strip().split()
            if len(header) != 3 or header[:2] != [blob, "blob"]:
                raise ValueError(f"Missing or different Git object for {commit}:{path}")
            size = int(header[2])
            checksum = hashlib.sha1(f"blob {size}\0".encode())
            target = destination / commit / Path(*path.parts)
            target.parent.mkdir(parents=True, exist_ok=True)
            with target.open("xb") as output:
                remaining = size
                while remaining:
                    chunk = git.stdout.read(min(remaining, 1024 * 1024))
                    if not chunk:
                        raise EOFError(f"Incomplete Git object {blob}")
                    checksum.update(chunk)
                    output.write(chunk)
                    remaining -= len(chunk)
            if git.stdout.read(1) != b"\n" or checksum.hexdigest() != blob:
                raise ValueError(f"Content hash mismatch for {path}")
            count += 1
        git.stdin.close()
        if git.wait():
            raise RuntimeError("git cat-file failed")
    return count


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("repo", type=Path, help="Goldbach checkout with the indexed commits")
    parser.add_argument("destination", type=Path, help="new directory for the restored files")
    args = parser.parse_args()
    index = Path(__file__).resolve().parent / "evidence" / "public-artifacts.tsv"
    print(f"Restored {restore(args.repo, args.destination, index)} verified files.")
