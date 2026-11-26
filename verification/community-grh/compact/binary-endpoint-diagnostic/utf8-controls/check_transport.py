"""Check both bound workers against the actual independent full Lean statement."""
import argparse
import ast
import hashlib
import importlib.util
from pathlib import Path
import subprocess
import tempfile

EXPECTED_EXPORT="553a79110caf1a369e4eb9b6d30bc797218c564d4afc01cd4aaf15fd8ca724f2"
BAD_SCHEDULED_WORKER="65609245d4427c36c6b5abc0e82405a441fead78cbaee32a4ac93020d3e176c4"
NAME="SmallGoldbach.ProductPrefix564386325504.binaryGoldbachUpTo"

def sha(data):
    return hashlib.sha256(data).hexdigest()

def required(ok,msg):
    if not ok:
        raise ValueError(str(msg))

def challenge(worker):
    vals=[ast.literal_eval(n.value) for n in ast.parse(worker).body if isinstance(n,ast.Assign)
          and len(n.targets)==1 and isinstance(n.targets[0],ast.Name) and n.targets[0].id=="CHALLENGE"]
    required(len(vals)==1,"exactly one challenge is required")
    return vals[0].encode("utf-8")

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--lean",type=Path,help="stock Lean 4.35; LEAN_PATH must supply the pinned Mathlib")
    p.add_argument("--leanexport",type=Path)
    a=p.parse_args()
    required(bool(a.lean)==bool(a.leanexport),"both stock binaries are required for the export test")
    here=Path(__file__).resolve().parent
    binder=here.parent/"bind_binary_source.py"
    spec=importlib.util.spec_from_file_location("bind_binary_source",binder)
    b=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(b)
    original=(here.parent/"binary_endpoint.py").read_bytes()
    reference=(here/"TrustedBinaryEndpoint.lean").read_bytes()
    required(sha(reference)==b.CHALLENGE,"independent full challenge hash")
    profiles={k:b.bind(original,k) for k in b.PROFILES}
    required(all(challenge(x)==reference for x in [original,*profiles.values()]),"full UTF-8 challenge mismatch")
    damaged=profiles["scheduled"].decode("cp1252").encode("utf-8")
    required(sha(damaged)==BAD_SCHEDULED_WORKER,"historical encoding error has not been reproduced")
    required(challenge(damaged)!=reference,"negative control must alter the full Lean statement")
    try:
        b.bind(damaged,"scheduled")
    except ValueError:
        pass
    else:
        raise ValueError("binder accepted the superseded worker")
    if a.lean:
        import os
        lean=a.lean.resolve()
        exporter=a.leanexport.resolve()
        version=subprocess.check_output([str(lean),"--version"],text=True)
        required("4.35.0" in version and "eb6cafb7290e8bd5f2937522d8d804f58f02bafc" in version,"stock Lean version")
        with tempfile.TemporaryDirectory() as tmp:
            work=Path(tmp)
            source=work/"TrustedBinaryEndpoint.lean"
            env={**os.environ,"LEAN_PATH":str(work)+os.pathsep+os.environ.get("LEAN_PATH",""),"LEAN_NUM_THREADS":"1"}
            source.write_bytes(challenge(damaged))
            negative=subprocess.run([str(lean),"-j1",source.name],cwd=work,env=env,capture_output=True)
            required(negative.returncode!=0,"the corrupted Lean statement unexpectedly parsed")
            source.write_bytes(challenge(profiles["scheduled"]))
            subprocess.run([str(lean),"-j1","-o","TrustedBinaryEndpoint.olean",source.name],cwd=work,env=env,check=True)
            keys=["Quot","Quot.mk","Quot.lift","Quot.ind",NAME,"propext","Quot.sound","Classical.choice"]
            extras="Nat.add Nat.sub Nat.mul Nat.pow Nat.gcd Nat.div Nat.mod Nat.beq Nat.ble Nat.land Nat.lor Nat.xor Nat.shiftLeft Nat.shiftRight String.ofList Char.ofNat List eagerReduce Nat String String.mk Char optParam autoParam semiOutParam outParam".split()
            exported=subprocess.check_output([str(exporter),"TrustedBinaryEndpoint","--",*keys,*extras],cwd=work,env=env)
            required(len(exported)==1134989 and sha(exported)==EXPECTED_EXPORT,"independent full challenge export mismatch")
    print("Verified both source profiles and the full UTF-8 negative control")
    if a.lean:
        print("Recompiled and exported the exact full challenge, 1134989 bytes")

if __name__=="__main__":
    main()
