"""Reassemble the checked source ZIP from the parts stored in this branch."""
import argparse
import hashlib
from pathlib import Path
import shutil
import tempfile


SIZE = 208483891
SHA256 = "3e491000b9437b13806dda59b111ad4a4c73f3f1329646c1d35e93ee6524f92c"


def verify(path):
    digest = hashlib.sha256()
    with path.open("rb") as file:
        for block in iter(lambda: file.read(1024 * 1024), b""):
            digest.update(block)
    if path.stat().st_size != SIZE or digest.hexdigest() != SHA256:
        raise ValueError(f"Proof bundle checksum mismatch for {path}")


def restore(output):
    if output.exists():
        verify(output)
    else:
        parts = Path(__file__).resolve().parent / "bundle"
        with tempfile.TemporaryDirectory(dir=output.parent) as temp:
            candidate = Path(temp) / "lean-sources.zip"
            with candidate.open("wb") as archive:
                for index in range(50):
                    with (parts / f"part-{index:03d}").open("rb") as part:
                        shutil.copyfileobj(part, archive)
            verify(candidate)
            candidate.replace(output)
    print(f"Verified {output} ({SIZE} bytes, SHA-256 {SHA256})")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", nargs="?", type=Path, default=Path("lean-sources.zip"))
    restore(parser.parse_args().output)
