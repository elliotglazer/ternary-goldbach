"""Copy the entire original Statement module, changing just its umbrella import."""
from hashlib import sha256
from pathlib import Path
import sys


def narrow(source, destination):
    original = source.read_bytes()
    if sha256(original).hexdigest() != "3f61837d2c3a0dde3a1997f05af21c20c7fe6ee13e29891125495f6947596bf8":
        raise ValueError("unexpected upstream Statement source")
    first,sep,rest = original.partition(b"\n")
    if first.rstrip(b"\r") != b"import Mathlib":
        raise ValueError("unexpected upstream imports")
    destination.parent.mkdir(exist_ok=True,parents=True)
    destination.write_bytes(b"import Mathlib.NumberTheory.LSeries.DirichletContinuation"+sep+rest)
    assert destination.read_bytes().partition(b"\n")[2] == rest


if __name__=="__main__":
    narrow(*map(Path,sys.argv[1:]))
