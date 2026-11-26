#!/usr/bin/env python3
"""Exercise the actual immutable-copy worker on Linux, with two distinct source failures."""
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time

from warm_main import built_names, graph, run_lake, stage_seed

FILES = {
    "Base":"@[expose] public def baseValue : Nat := 1",
    "Stable":"public import Base\n@[expose] public def stable : Nat := baseValue",
    "Changed":"@[expose] public def changedValue : Nat := 1",
    "Reader":"public import Changed\n@[expose] public def reader : Nat := changedValue+1",
    "Intermediate":"public import Base\n@[expose] public def intermediate : Nat := firstMissing",
    "Deep":"public import Intermediate\n@[expose] public def deepValue : Nat := laterMissing",
    "Main":"public import Deep\npublic import Reader\npublic import Stable\n@[expose] public def z : Nat := 0",
}
CFG='name="diag"\n[[lean_lib]]\nname="GRH"\nsrcDir="CompactGRH/src"\nroots=["Main","Base","Stable","Changed","Reader","Intermediate","Deep"]\n[[lean_lib]]\nname="Finite"\n'
def prep(root, fixed=False):
    root.mkdir()
    for q in ["config","build","packages"]:(root/".lake"/q).mkdir(parents=True,exist_ok=True)
    (root/"lakefile.toml").write_text(CFG);(root/"lean-toolchain").write_text("leanprover/lean4:v4.35.0\n")
    (root/"lake-manifest.json").write_text('{"version":"1.1.0","packagesDir":".lake/packages","packages":[],"name":"diag","lakeDir":".lake"}')
    (root/"Finite.lean").write_text("module\n@[expose] public def finite : Nat := forbiddenFiniteCheck\n")
    rows={};blobs={}
    for n,v in FILES.items():
        if fixed and n=="Changed": v=v.replace(":= 1",":= 2")
        if fixed and n=="Intermediate": v=v.replace("firstMissing","baseValue")
        data=("module\n\n"+v+"\n").encode();rel="CompactGRH/src/"+n+".lean";f=root/rel
        f.parent.mkdir(exist_ok=True,parents=True);f.write_bytes(data);h=hashlib.sha256(data).hexdigest()
        rows[n]=(rel,h);blobs[h]=data
    return rows,blobs

def digest_dir(root):
    dig=hashlib.sha256()
    for f in sorted(root.rglob("*")):
        if f.is_file():
            dig.update(str(f.relative_to(root)).encode()+b"\0");dig.update(hashlib.sha256(f.read_bytes()).digest())
    return dig.hexdigest()

def test(tool,bwrap,output):
    with tempfile.TemporaryDirectory(prefix="tg-warm-Main-") as tmp:
        root=Path(tmp)
        old,new=root/"old",root/"new"
        log1=root/"first";log1.mkdir();log2=root/"second";log2.mkdir()
        ro,bo=prep(old);rn,bn=prep(new,True)
        first=run_lake(tool,old,old/".lake/packages",log1,bwrap,time.time()+900)
        s1=(log1/"warm-main.log").read_text()
        assert first["exit"]==1 and "firstMissing" in s1 and "laterMissing" not in s1,s1
        # Historical source worker removes these temporary compilation setups on every pass.
        for old_setup in (old/".lake/build/ir").rglob("*.setup.json"):
            if (old/".lake/build/lib/lean"/(old_setup.name.split(".")[0]+".trace")).is_file():
                old_setup.unlink()
        before=digest_dir(old)
        record=stage_seed(old,new,ro,rn,graph(bn,rn),built_names(s1),tool,
                          Path(__file__).with_name("WarmArtifactHashes.lean"),log2)
        assert set(record["accepted"])=={"Base","Stable"},record
        for name in record["accepted"]:
            src=old/".lake/build/lib/lean"/(name+".olean")
            dst=new/".lake/build/lib/lean"/(name+".olean")
            assert not os.path.samefile(src,dst) and src.read_bytes()==dst.read_bytes()
        second=run_lake(tool,new,old/".lake/packages",log2,bwrap,time.time()+900)
        s2=(log2/"warm-main.log").read_text()
        assert second["exit"]==1 and "laterMissing" in s2 and "firstMissing" not in s2,s2
        assert {"Changed","Reader","Intermediate"}<=set(second["newly_built"]),s2
        assert not set(record["accepted"])&set(second["newly_built"]) and "forbiddenFiniteCheck" not in s1+s2,s2
        assert before==digest_dir(old)
        # Keep the original immutable while exercising a false success sidecar on a private test copy.
        damaged=root/"damaged";shutil.copytree(old,damaged)
        suspect=damaged/".lake/build/lib/lean/Base.olean"
        with suspect.open("ab") as out:out.write(b"changed after original build")
        reject=root/"reject";reject.mkdir();reject_project=root/"reject-project";prep(reject_project,True)
        badseed=stage_seed(damaged,reject_project,ro,rn,graph(bn,rn),built_names(s1),tool,
                           Path(__file__).with_name("WarmArtifactHashes.lean"),reject)
        assert not badseed["accepted"] and "artifact bytes" in badseed["rejected"]["Base"],badseed
        # On the same boot another repaired candidate may consume the same original receipts.
        final=root/"final";rf,bf=prep(final,True);deep=final/"CompactGRH/src/Deep.lean"
        newtext=deep.read_text().replace("laterMissing","intermediate");deep.write_text(newtext)
        h=hashlib.sha256(deep.read_bytes()).hexdigest();rf["Deep"]=(rf["Deep"][0],h);bf[h]=deep.read_bytes()
        log3=root/"third";log3.mkdir();se3=stage_seed(old,final,ro,rf,graph(bf,rf),built_names(s1),tool,
                           Path(__file__).with_name("WarmArtifactHashes.lean"),log3)
        third=run_lake(tool,final,old/".lake/packages",log3,bwrap,time.time()+900)
        assert third["exit"]==0 and "Main" in third["newly_built"] and not set(se3["accepted"])&set(third["newly_built"]),third
        assert before==digest_dir(old)
        res={"scope":"Linux native warm diagnostic fixture","version":subprocess.check_output(
                [str(tool/"bin/lake"),"--version"],text=True).strip(),"old_failed":first,
                "warm_failed":second,"second_repaired_candidate":third,"corrupt_artifact_control":badseed,"seed_verification":record,"old_source_and_artifact_sha256_before_after":before,
                "old_and_new_objects_distinct_inodes":True,"used_persisted_traces_with_pruned_setups":True,"finite_module_untouched":True,
                "first_log":s1,"second_log":s2}
        output.write_text(json.dumps(res,indent=2,ensure_ascii=False)+"\n")
        print(json.dumps({k:v for k,v in res.items() if k not in {"first_log","second_log"}}))
if __name__=="__main__":
    test(Path(sys.argv[1]),Path(sys.argv[2]),Path(sys.argv[3]))
