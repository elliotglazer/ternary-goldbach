"""Regenerate every certificate in a fresh temporary directory and compare its source."""
from contextlib import redirect_stdout
from hashlib import sha256
from io import StringIO
import json
from pathlib import Path
from tempfile import TemporaryDirectory
from generate import build, HERE


with TemporaryDirectory(prefix="goldbach-prefix-") as scratch:
    results = {}
    for k in range(1,10):
        with redirect_stdout(StringIO()):
            build(k,out=Path(scratch))
        name = f"Power{k}.lean"
        actual = sha256((Path(scratch)/name).read_bytes()).hexdigest()
        expected = json.loads((HERE/f"Power{k}.json").read_text())["source_sha256"]
        if actual != expected:
            raise ValueError(f"regenerated proof differs for {name}")
        results[name] = actual
    (HERE/"regenerated.json").write_text(json.dumps(results,indent=2)+"\n")
    print(f"Regenerated {len(results)} kernel-checked sources byte for byte.")
