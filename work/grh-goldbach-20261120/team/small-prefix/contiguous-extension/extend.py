"""Produce two serial interval certificates and join the released prefix."""
import json
import hashlib
import re
import math
import os
import shutil
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
PREFIX = HERE.parent
RELEASE = PREFIX / "ten-billion/compact"
sys.path.insert(0, str(PREFIX))
import generate as g
import check
from flint import fmpz

width, halo, start, rows_per_shard = 262144, 3200, 10000000002, 128
cutoff = 101000
ns = "SmallGoldbach.ContiguousExtension"


def write_module(name, lines):
    (HERE / (name + ".lean")).write_text("\n".join(lines) + "\n", encoding="utf8")


def packed(number):
    return 'packedHex% "' + format(number, "x") + '"'


def join(parts):
    while len(parts) > 1:
        parts = [f"(SmallGoldbach.join {a} {b})" for a, b in zip(parts[::2], parts[1::2])] + (parts[-1:] if len(parts)%2 else [])
    return parts[0]


def generate(band=None):
    t = time.process_time()
    primes = g.primes_through(cutoff)
    flags = g.odd_sieve(3, width + halo, primes)
    bits, reverse_bits = g.bitmap(flags), g.bitmap(flags[::-1])
    fac = fmpz(math.factorial(cutoff))
    extended = "--milestone" in sys.argv
    common_mod = "ExtensionCommonB" if extended else "ExtensionCommon"
    prefix = "ExtensionB" if extended else "Extension"
    public_mod = "ExtendedPrefixB" if extended else "ExtendedPrefix"
    first = start + 2*width*256 if extended else start
    shard_rows = 512 if extended else rows_per_shard
    count = 4 if extended else 2
    if band:
        common_mod, prefix, public_mod, first, shard_rows, count, prior_module, prior = band
    write_module(common_mod, ["import Power10Common", "import FastHex", f"namespace {ns}",
        f"def fac : Nat := {packed(int(fac))}", f"theorem fac_eq : fac = Nat.factorial {cutoff} := SmallGoldbach.factorial_of_product {(cutoff//32).bit_length()} (by decide +kernel)", f"end {ns}"])
    common = time.process_time() - t
    metadata = []
    for shard in range(count):
        t = time.process_time()
        origin = first + 2*shard*shard_rows*width
        lines = ["import "+common_mod, f"namespace {ns}", "open SmallGoldbach", "set_option maxHeartbeats 0", "set_option maxRecDepth 20000"]
        parts = []
        anchors = 0
        for block in range(shard_rows//8):
            low = origin + 16*block*width
            rows = []
            for r in range(8):
                base = low + 2*r*width - 3 - 2*halo
                available = g.odd_sieve(base, halo+1, primes)
                uncovered = (1 << width)-1
                offsets = []
                for s, flag in enumerate(available):
                    if flag and (part := (bits >> (halo-s)) & uncovered):
                        offsets.append(s)
                        uncovered ^= part
                        if not uncovered:
                            break
                        if len(offsets)%4 == 0 and uncovered.bit_count() <= 192:
                            offsets.extend(g.cover_tail(uncovered, available, reverse_bits, len(flags), halo, False))
                            uncovered = 0
                            break
                assert not uncovered
                anchors += len(offsets)
                inv = int(pow(fac,-1,fmpz(math.prod(base+2*s for s in offsets))))
                rows.append(f"⟨{width}, {len(offsets)}, {packed(g.pack(offsets))}, {packed(inv)}⟩")
            name = f"r{shard}_{block}"
            parts.append("p"+name)
            lines.extend([f"def {name} : List Row := [" + ",\n".join(rows)+"]",
                f"theorem p{name} : Covered {low} {low+16*width} := checked_interval (halo := {halo}) Power10.certifiedSource fac_eq {name} (by decide) (by decide) (by decide +kernel) (by decide +kernel)"])
        end = origin + 2*width*shard_rows
        lines.extend([f"theorem shard{shard} : Covered {origin} {end} := {join(parts)}",f"end {ns}"])
        write_module(f"{prefix}{shard}",lines)
        metadata.append(dict(start=origin,end_exclusive=end,rows=shard_rows,anchors=anchors,producer_cpu_s=time.process_time()-t))
    bound = end-2
    if not band:
        prior = "SmallGoldbach.ContiguousExtension.binaryGoldbachUpTo" if extended else "SmallGoldbach.Power10.binaryGoldbachUpTo"
        prior_module = "ExtendedPrefix" if extended else "Power10Joined"
    write_module(public_mod,["import "+prior_module,*[f"import {prefix}{i}" for i in range(count)],f"namespace {ns}",
        f"theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ {bound} → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by",
        "  intro n he h4 hh", f"  by_cases h : n ≤ {first-2}", f"  · exact {prior} n he h4 h",
        "  · obtain ⟨k, hk⟩ := he", f"    exact {join(['shard'+str(i) for i in range(count)])} n (by omega) (by omega) (by omega)",
        "#print axioms binaryGoldbachUpTo",f"end {ns}"])
    output = public_mod+"Producer.json" if band else ("producerB.json" if extended else "producer.json")
    (HERE/output).write_text(json.dumps(dict(common_cpu_s=common,shards=metadata),indent=2))


def verify(selected=None, fingerprint_only=False):
    lean = Path.home()/".elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe"
    packages = Path.home()/"Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages"
    deps = [HERE,RELEASE/".split-build",PREFIX,check.WIDE/"b8192-02",check.WORK/"backend-costs-20261112/finite-lean",check.WORK/"formal-goldbach-bench/prime-cert"]
    deps.extend(sorted(p/".lake/build/lib/lean" for p in packages.iterdir() if p.is_dir()))
    env = dict(os.environ,LEAN_PATH=os.pathsep.join(map(str,deps)))
    dependency_cache = {}
    def dependencies(mod):
        relative = Path(*mod.split("."))
        src = next((d/relative.with_suffix(".lean") for d in [HERE,RELEASE,*deps] if (d/relative.with_suffix(".lean")).is_file()), None)
        if src is None:
            return {}
        result = {}
        imports = re.findall(r"^\s*(?:(?:public|private|meta)\s+)*import\s+([\w.]+)",src.read_text(encoding="utf8"),re.MULTILINE)
        for name in imports:
            if name not in dependency_cache:
                stem = Path(*name.split("."))
                obj = next((d/stem.with_suffix(".olean") for d in deps if (d/stem.with_suffix(".olean")).is_file()), None)
                dep_src = next((d/stem.with_suffix(".lean") for d in [HERE,RELEASE,*deps] if (d/stem.with_suffix(".lean")).is_file()), None)
                if obj is None:
                    builtin = lean.parents[1]/"lib/lean"/stem.with_suffix(".olean")
                    if not builtin.is_file():
                        raise FileNotFoundError(name)
                    obj = builtin
                entry = {"object":check.sha(obj)}
                if dep_src:
                    entry["source"] = check.sha(dep_src)
                entry["imports"] = dependencies(name)
                encoded = json.dumps(entry,sort_keys=True).encode()
                dependency_cache[name] = hashlib.sha256(encoded).hexdigest()
            result[name] = dependency_cache[name]
        return result
    modules = ["ExtensionCommonB",*[f"ExtensionB{i}" for i in range(4)],"ExtendedPrefixB"] if "--milestone" in sys.argv else ["ExtensionCommon","Extension0","Extension1","ExtendedPrefix"]
    fingerprints = {}
    for mod in (selected or modules):
        if shutil.disk_usage(HERE).free < 2*1024**3:
            raise RuntimeError("Less than 2 GiB available")
        dependency_hashes = dependencies(mod)
        fingerprints[mod] = dict(source=check.sha(HERE/(mod+".lean")),imports=dependency_hashes)
        if fingerprint_only:
            continue
        if "--resume" in sys.argv and (HERE/(mod+".json")).is_file() and (HERE/(mod+".olean")).is_file():
            receipt = json.loads((HERE/(mod+".json")).read_text())
            recorded_inputs = receipt.get("dependency_hashes")
            if recorded_inputs is None and (band_match := re.match(r"GoldbachBand\d+",mod)):
                audit_file = HERE/(band_match[0]+"Fingerprints.json")
                if audit_file.is_file():
                    historical = json.loads(audit_file.read_text()).get(mod,{})
                    if historical.get("source") == receipt.get("source_sha256") and historical.get("object") == receipt.get("olean_sha256"):
                        recorded_inputs = historical.get("imports")
            if receipt.get("exit")==0 and recorded_inputs == dependency_hashes and receipt["source_sha256"] == check.sha(HERE/(mod+".lean")) and receipt["olean_sha256"] == check.sha(HERE/(mod+".olean")):
                continue
        t = time.monotonic()
        with (HERE/(mod+".log")).open("wb") as log:
            proc = subprocess.Popen([lean,"-j1","-M3000","-t0","-o",mod+".olean",mod+".lean"],cwd=HERE,env=env,stdout=log,stderr=subprocess.STDOUT)
            rc = proc.wait()
            stats = check.windows_stats(proc)
        print(mod,rc,stats,flush=True)
        receipt = dict(exit=rc,wall_s=time.monotonic()-t,**stats,source_sha256=check.sha(HERE/(mod+".lean")),directory_bytes=sum(f.stat().st_size for f in HERE.iterdir() if f.is_file()))
        if rc == 0:
            receipt["olean_sha256"] = check.sha(HERE/(mod+".olean"))
            receipt["dependency_hashes"] = dependency_hashes
        (HERE/(mod+".json")).write_text(json.dumps(receipt,indent=2))
        if rc:
            print((HERE/(mod+".log")).read_text(encoding="utf8")[:1200].encode("ascii","backslashreplace").decode())
            sys.exit(rc)
    return fingerprints


if __name__ == "__main__":
    if "--milestone" in sys.argv:
        cutoff = 106000
        ns = "SmallGoldbach.ContiguousExtensionB"
    if "--resume" not in sys.argv or not (HERE/("producerB.json" if "--milestone" in sys.argv else "producer.json")).exists():
        generate()
    verify()
