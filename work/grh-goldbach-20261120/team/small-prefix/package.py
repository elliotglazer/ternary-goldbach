"""Package source, pins and receipts after checking every published power."""
import hashlib
import json
from pathlib import Path
import re
from zipfile import ZIP_DEFLATED, ZipFile


HERE = Path(__file__).resolve().parent
PILOT = HERE.parent / "aws-pilot"
WORK = HERE.parents[2]


def main():
    files = {}
    for k in range(1,10):
        mod = f"Power{k}"
        receipt = json.loads((HERE/f"{mod}.json").read_text())
        src = HERE/f"{mod}.lean"
        if receipt["exit"] or hashlib.sha256(src.read_bytes()).hexdigest() != receipt["source_sha256"]:
            raise RuntimeError(f"unverified source: {mod}")
        files[src.name] = src
        for suffix in ["json","input.json"]:
            p = HERE/f"{mod}.{suffix}"
            files["receipts/"+p.name] = p
    for s in ["PrefixCheck","PrefixSource","PrefixJoin","PrefixFactorial","Controls","Audit9"]:
        files[s+".lean"] = HERE/(s+".lean")
        files["receipts/"+s+".json"] = HERE/(s+".json")
    files["receipts/Audit9.log"] = HERE/"Audit9.log"
    expected = "[propext, Classical.choice, Quot.sound]"
    if (HERE/"Audit9.log").read_text(encoding="utf-8").count(expected) != 9:
        raise RuntimeError("missing standard-axiom audit")
    for k in range(5,11):
        p = HERE/f"scan{k}.json"
        files["receipts/"+p.name] = p
    for fname in ["generate.py","replay.py","scan.py","README.md","Upstream9.lean","narrow_import.py"]:
        files[fname] = HERE/fname
    for fname in ["lakefile.lean","lake-manifest.json","lean-toolchain","PrimeBitmap.lean","PrimeSupport.lean"]:
        files[fname] = PILOT/fname
    files["Table.lean"] = PILOT/"wide/Table.lean"
    for fname in ["LICENSE","NOTICE","TernaryGoldbach/Statement.lean"]:
        files[fname] = WORK/"ternary-goldbach"/fname
    for s in ["TernaryGoldbach.Statement","Upstream9","AuditUpstream"]:
        p = HERE/"narrow"/(s+".json")
        if p.is_file() and json.loads(p.read_text())["exit"]==0:
            files["receipts/narrow/"+p.name] = p
    if "receipts/narrow/AuditUpstream.json" in files:
        files["AuditUpstream.lean"] = HERE/"AuditUpstream.lean"
        files["receipts/narrow/AuditUpstream.log"] = HERE/"narrow/AuditUpstream.log"
    files["receipts/regenerated.json"] = HERE/"regenerated.json"
    files["receipts/clean-replay.json"] = HERE/"replay-b9/.prefix-build/replay.json"
    for width in [32768,131072]:
        for suffix in ["json","input.json"]:
            n = f"width-{width}/Power8.{suffix}"
            files["receipts/"+n] = HERE/n
    shards = HERE/"ten-billion/compact"
    modules = json.loads((shards/"modules.json").read_bytes())
    split_report = shards/".split-build/replay.json"
    proof = json.loads(split_report.read_bytes())
    names = [*modules["blocks"],modules["base"],modules["public"],modules["audit"],"FastHex"]
    if proof["power"] != 10 or expected not in proof["stages"][modules["audit"]]["output"]:
        raise RuntimeError("missing ten-billion axiom audit")
    for name,stage in proof["stages"].items():
        source = shards/(name+".lean") if name in names else files[name+".lean"]
        obj = shards/".split-build"/(name+".olean")
        if (hashlib.sha256(source.read_bytes()).hexdigest() != stage["source_sha256"] or
            hashlib.sha256(obj.read_bytes()).hexdigest() != stage["olean_sha256"]):
            raise RuntimeError(f"source or object changed after verification: {name}")
        if name in names:
            files["shards/"+source.name] = source
    if set(names)-proof["stages"].keys():
        raise RuntimeError("a proof module has no receipt")
    files["shards/modules.json"] = shards/"modules.json"
    files["FastHex.lean"] = HERE/"FastHex.lean"
    if files["FastHex.lean"].read_bytes() != (shards/"FastHex.lean").read_bytes():
        raise RuntimeError("the regeneration copy of FastHex differs from the checked copy")
    files["receipts/Power10.replay.json"] = split_report
    split_receipt = HERE/"ten-billion/split-receipt.json"
    for fname,h in json.loads(split_receipt.read_bytes())["regenerated_files"].items():
        if hashlib.sha256((shards/fname).read_bytes()).hexdigest() != h:
            raise RuntimeError(f"regeneration hash mismatch for {fname}")
    files["receipts/Power10.split.json"] = split_receipt
    standard = HERE/"ten-billion/shards/.split-build/replay.json"
    standard_stages = json.loads(standard.read_bytes())["stages"]
    if expected not in standard_stages[modules["audit"]]["output"]:
        raise RuntimeError("missing original ten-billion audit")
    files["receipts/Power10.standard-replay.json"] = standard
    files["receipts/Power10.input.json"] = HERE/"ten-billion/Power10.input.json"
    fast = HERE/"ten-billion/fast"
    source_hash = hashlib.sha256((HERE/"ten-billion/Power10.lean").read_bytes()).hexdigest()
    if hashlib.sha256((fast/"Power10.lean").read_bytes()).hexdigest() != source_hash:
        raise RuntimeError("ten-billion producers disagree")
    row_pattern = re.compile(r"^def rows(\d+) : List Row := \[(.*?)\]",re.M|re.S)
    original = row_pattern.findall((fast/"Power10.lean").read_text(encoding="utf-8"))
    published = []
    for name in modules["blocks"]:
        src = (shards/(name+".lean")).read_text(encoding="utf-8")
        plain = re.sub(r'packedHex% "([0-9a-f]+)"',r'0x\1',src)
        published.extend(row_pattern.findall(plain))
    if len(published) != modules["intervals"] or published != original:
        raise RuntimeError("published rows differ from the original witnesses")
    files["receipts/Power10.fast-input.json"] = fast/"Power10.input.json"
    plain = HERE/"ten-billion/stdlib"
    if hashlib.sha256((plain/"Power10.lean").read_bytes()).hexdigest() != source_hash:
        raise RuntimeError("the standard-library generator changed the proof source")
    files["receipts/Power10.stdlib-input.json"] = plain/"Power10.input.json"
    upstream_receipt = shards/".split-build/adapter/adapter.json"
    adapter = json.loads(upstream_receipt.read_bytes())
    adapter_source = HERE/"Upstream10.lean"
    if (hashlib.sha256(adapter_source.read_bytes()).hexdigest() != adapter["Upstream10"]["source_sha256"]
            or expected not in adapter["audit"]["output"]):
        raise RuntimeError("upstream adapter has no matching proof receipt")
    files["receipts/Upstream10.json"] = upstream_receipt
    files["Upstream10.lean"] = adapter_source
    for name in ("replay_split.py","split_power.py"):
        files[name] = HERE/name
    compact = HERE/"compact-prefix"
    for k in (7,8,9):
        name = f"Power{k}"
        source = compact/(name+".lean")
        receipt = compact/(name+".json")
        stage = json.loads(receipt.read_bytes())
        if (stage["exit"] != 0 or hashlib.sha256(source.read_bytes()).hexdigest() != stage["source_sha256"]
                or hashlib.sha256((compact/(name+".olean")).read_bytes()).hexdigest() != stage["olean_sha256"]):
            raise RuntimeError(f"unverified compact prefix: {name}")
        files["compact-prefix/"+source.name] = source
        for path in [receipt,compact/(name+".input.json")]:
            files["receipts/compact/"+path.name] = path
    audit = compact/"AuditCompact.log"
    audit_source = compact/"AuditCompact.lean"
    audit_receipt = json.loads((compact/"AuditCompact.json").read_bytes())
    if (audit_receipt["exit"] or audit_receipt["source_sha256"] != hashlib.sha256(audit_source.read_bytes()).hexdigest()
            or audit_receipt["log_sha256"] != hashlib.sha256(audit.read_bytes()).hexdigest()):
        raise RuntimeError("compact audit files changed")
    printed = audit.read_text(encoding="utf-8").splitlines()
    if printed != [f"'SmallGoldbach.Power{k}.binaryGoldbachUpTo' depends on axioms: {expected}" for k in (7,8,9)]:
        raise RuntimeError("compact proof audit did not match the three declarations")
    files["compact-prefix/"+audit_source.name] = audit_source
    for name in ("AuditCompact.json","AuditCompact.log","FastHex.json"):
        files["receipts/compact/"+name] = compact/name
    for variant in ("tail-control","tail192-wide"):
        for name in ("Power8.json","Power8.input.json"):
            files[f"receipts/{variant}/{name}"] = HERE/variant/name
    regenerated = HERE/"compact-regenerate/regenerated.json"
    checksums = {f"Power{k}.lean":hashlib.sha256((compact/f"Power{k}.lean").read_bytes()).hexdigest()
                 for k in (7,8,9)}
    if json.loads(regenerated.read_bytes()) != checksums:
        raise RuntimeError("standard-library regeneration differs for the compact covers")
    files["receipts/compact/regenerated.json"] = regenerated
    clean = HERE/"compact-clean"
    clean_receipt = clean/".compact-build/replay.json"
    report = json.loads(clean_receipt.read_bytes())
    for module in report["stages"]:
        if module == "audit":
            continue
        name = module+".lean"
        relative = ("compact-prefix/"+name) if module == "Power9" else name
        if (clean/relative).read_bytes() != files[relative].read_bytes():
            raise RuntimeError(f"clean compact replay used a different {relative}")
    if (clean/"replay.py").read_bytes() != files["replay.py"].read_bytes() or report["stages"]["audit"]["output"].splitlines() != [printed[-1]]:
        raise RuntimeError("clean compact replay did not use this driver and declaration")
    files["receipts/compact/clean-replay.json"] = clean_receipt
    files["standalone.py"] = HERE/"standalone.py"
    for k, variant in ((6,None), (7,None), (8,None), (9,None), (8,"greedy768"), (9,"greedy-tail")):
        if variant is None:
            directory = HERE/".standalone"/str(k)
        else:
            directory = HERE/variant/"standalone"/str(k)
            proof_name = f"Power{k}.lean"
            variant_source = HERE/variant/proof_name
            if variant_source.read_bytes() != (HERE/variant/"stdlib"/proof_name).read_bytes():
                raise RuntimeError("greedy certificate regeneration failed")
            files[variant+"/"+proof_name] = variant_source
            files[f"receipts/{variant}/Power{k}.input.json"] = HERE/variant/f"Power{k}.input.json"
        single = directory/f"GoldbachThroughPower{k}.lean"
        receipt = directory/"receipt.json"
        data = json.loads(receipt.read_bytes())
        targets = [f"SmallGoldbach.Power{k}.{n}" for n in ("binaryGoldbachUpTo", "binaryGoldbachUpToPower")]
        if (data["power"] != k or data["proof"]["output"] or
            data["audit"]["output"].splitlines() != [f"'{n}' depends on axioms: {expected}" for n in targets] or
            hashlib.sha256(single.read_bytes()).hexdigest() != data["source_sha256"] or
            hashlib.sha256(single.with_suffix(".olean").read_bytes()).hexdigest() != data["olean_sha256"]):
            raise RuntimeError(f"standalone proof has no matching receipt: {single}")
        for name, digest in data["inputs"].items():
            relative = name
            if name == f"Power{k}.lean" and k >= 7:
                relative = (variant or "compact-prefix")+"/"+name
            if hashlib.sha256(files[relative].read_bytes()).hexdigest() != digest:
                raise RuntimeError(f"standalone input changed: {relative}")
        prefix = "standalone/"+((variant+"/") if variant else "")
        files[prefix+single.name] = single
        files[f"receipts/{prefix}Power{k}.json"] = receipt
        if (k,variant) in ((6,None),(8,"greedy768")):
            path = directory/"kernel-replay.json"
            replayed = json.loads(path.read_bytes())
            if (replayed["olean_sha256"] != data["olean_sha256"] or replayed["mode"] != "replayFromImports" or
                    replayed["output"].splitlines() != ["replaying "+single.stem]):
                raise RuntimeError(f"object replay does not match {single}")
            files[f"receipts/{prefix}Power{k}.kernel.json"] = path
    hashes = {n:hashlib.sha256(p.read_bytes()).hexdigest() for n,p in sorted(files.items())}
    out = WORK.parent/"outputs/small-binary-goldbach-lean.zip"
    out.parent.mkdir(exist_ok=True)
    staged = out.with_suffix(".partial.zip")
    with ZipFile(staged,"w",compression=ZIP_DEFLATED,compresslevel=6) as z:
        for n,p in sorted(files.items()):
            z.write(p,n)
        z.writestr("SHA256SUMS","".join(f"{h}  {n}\n" for n,h in hashes.items()))
    with ZipFile(staged) as z:
        if z.testzip() or any(hashlib.sha256(z.read(n)).hexdigest()!=h for n,h in hashes.items()):
            raise RuntimeError("archive readback failed")
    staged.replace(out)
    print(out,out.stat().st_size,hashlib.sha256(out.read_bytes()).hexdigest())


if __name__=="__main__":
    main()
