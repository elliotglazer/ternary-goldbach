"""Independently bind the initial inputs and completed band artifacts."""
import json
import sys
import extend as e


def audit(n):
    base = e.verify(["ExtendedPrefixB"], fingerprint_only=True)
    base["prior_object"] = e.check.sha(e.HERE/"ExtendedPrefixB.olean")
    frozen = e.HERE/"campaign-inputs.json"
    if n == 0 and not frozen.exists():
        frozen.write_text(json.dumps(base,indent=2))
    assert json.loads(frozen.read_text()) == base
    for j in range(1,n+1):
        tag = f"GoldbachBand{j:02d}"
        checkpoint = json.loads((e.HERE/(tag+"Receipt.json")).read_text())
        modules = checkpoint["modules"]
        fingerprints = e.verify(modules,fingerprint_only=True)
        for mod in modules:
            receipt = json.loads((e.HERE/(mod+".json")).read_text())
            assert receipt["exit"] == 0
            assert receipt["source_sha256"] == fingerprints[mod]["source"]
            obj = e.check.sha(e.HERE/(mod+".olean"))
            assert receipt["olean_sha256"] == obj
            fingerprints[mod]["object"] = obj
            if "dependency_hashes" in receipt:
                assert receipt["dependency_hashes"] == fingerprints[mod]["imports"]
        dest = e.HERE/(tag+"Fingerprints.json")
        if dest.exists():
            assert json.loads(dest.read_text()) == fingerprints
        else:
            dest.write_text(json.dumps(fingerprints,indent=2))
        print(tag,checkpoint["last_even"],checkpoint["produce_cpu_s"],checkpoint["verify_cpu_s"],flush=True)


if __name__ == "__main__":
    audit(int(sys.argv[1]))
