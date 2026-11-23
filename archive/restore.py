"""Verify the snapshot and optionally restore its large files at their recorded paths."""
import argparse
import csv
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import tarfile
import tempfile

def digest(path):
    with path.open("rb") as stream:
        return hashlib.file_digest(stream, "sha256").hexdigest()

def destination(root, name):
    path = PurePosixPath(name)
    if path.as_posix() != name or path.is_absolute() or ".." in path.parts or ":" in name or "\\" in name or not path.parts:
        raise ValueError(f"Unsafe manifest path {name!r}")
    target = (root / path).resolve()
    if not target.is_relative_to(root):
        raise ValueError(f"Path escapes archive root {name!r}")
    return target

def verify_git(root, rows):
    for row in rows:
        target = destination(root, row["path"])
        if target.stat().st_size != int(row["bytes"]) or digest(target) != row["sha256"]:
            raise ValueError(f"Mismatch in {row['path']}")

def restore_asset(root, archive, rows, extract):
    expected = {r["path"]: r for r in rows}
    with tarfile.open(archive, "r|gz") as tar:
        for member in tar:
            row = expected.pop(member.name, None)
            if row is None or not member.isfile() or member.size != int(row["bytes"]):
                raise ValueError(f"Unexpected member {member.name!r} in {archive.name}")
            target = destination(root, member.name)
            create = extract and not target.exists()
            temp = None
            h = hashlib.sha256()
            try:
                if create:
                    target.parent.mkdir(parents=True, exist_ok=True)
                    temp = tempfile.NamedTemporaryFile(dir=target.parent, delete=False)
                with tar.extractfile(member) as data:
                    while block := data.read(1024 * 1024):
                        h.update(block)
                        if temp:
                            temp.write(block)
                if temp:
                    temp.close()
                if h.hexdigest() != row["sha256"]:
                    raise ValueError(f"Member digest mismatch for {member.name}")
                if extract and target.exists() and digest(target) != row["sha256"]:
                    raise FileExistsError(f"Existing file differs from snapshot: {target}")
                if create and not target.exists():
                    os.link(temp.name, target)
            finally:
                if temp:
                    temp.close()
                    Path(temp.name).unlink(missing_ok=True)
    if expected:
        raise ValueError(f"{archive.name} is missing {len(expected)} members")

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--assets", type=Path, help="directory containing downloaded release assets")
    parser.add_argument("--restore", action="store_true", help="restore files from the supplied assets")
    args = parser.parse_args()
    if args.restore and not args.assets:
        parser.error("--restore requires --assets")
    root = Path(__file__).resolve().parent.parent
    with (root / "archive/manifest.tsv").open(encoding="utf-8", newline="") as fp:
        rows = list(csv.DictReader(fp, delimiter="\t"))
    assets = json.loads((root / "archive/release-assets.json").read_text(encoding="utf-8"))
    names = {a["name"] for a in assets}
    if len(names) != len(assets) or "git" in names:
        raise ValueError("Duplicate or reserved asset name")
    for name in names:
        if name != PurePosixPath(name).name or not name.endswith(".tar.gz"):
            raise ValueError(f"Invalid asset name {name!r}")
        destination(root, name)
    paths = set()
    groups = {"git": [], **{n: [] for n in names}}
    for row in rows:
        destination(root, row["path"])
        if row["path"] in paths or row["storage"] not in groups:
            raise ValueError(f"Duplicate path or unknown storage in {row!r}")
        paths.add(row["path"])
        groups[row["storage"]].append(row)
    if any(len(groups[a["name"]]) != a["files"] for a in assets):
        raise ValueError("Manifest and asset member counts disagree")
    git_rows = groups["git"]
    verify_git(root, git_rows)
    print(f"Verified {len(git_rows):,} files from Git", flush=True)
    if args.assets:
        for a in assets:
            path = args.assets / a["name"]
            if path.stat().st_size != a["bytes"] or digest(path) != a["sha256"]:
                raise ValueError(f"Release digest mismatch for {path}")
            data = groups[a["name"]]
            restore_asset(root, path, data, args.restore)
            print(f"Verified {a['name']} ({len(data):,} files)", flush=True)

if __name__ == "__main__":
    main()

