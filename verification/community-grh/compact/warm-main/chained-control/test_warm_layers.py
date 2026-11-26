#!/usr/bin/env python3
"""Verify chained diagnostic seed use with real git commits and a root-owned completed job."""
import hashlib,json,os,shutil,subprocess,sys,tempfile,time
from pathlib import Path as P
from warm_main import graph,stage_seed,run_lake,hashfile,validate_previous,RECEIPT,list_sources,read_blobs
from test_warm_main import prep,digest_dir

def call(args,cwd=None):
    return subprocess.check_output(args,cwd=cwd,text=True).strip()
def commit(stage,folder,repo):
    for src in [folder/"lakefile.toml",folder/"lean-toolchain",folder/"lake-manifest.json",*(folder/"CompactGRH/src").glob("*.lean")]:
        dest=repo/src.relative_to(folder);dest.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(src,dest)
    call(["git","add","."],repo)
    call(["git","-c","user.name=Fixture","-c","user.email=fixture@localhost","commit","-qm",stage],repo)
    pin=call(["git","rev-parse","HEAD"],repo);tree=call(["git","rev-parse","HEAD^{tree}"],repo)
    rows=list_sources(repo,pin);blobs=read_blobs(repo,[x for _,x in rows.values()])
    return pin,tree,rows,graph(blobs,rows)

def main(tool,bwrap,output):
    helper=P(__file__).with_name("WarmArtifactHashes.lean")
    with tempfile.TemporaryDirectory() as tmp, tempfile.TemporaryDirectory(dir="/var/lib") as trust:
        b=P(tmp);trusted=P(trust);repo=b/"repo";call(["git","init","-q",str(repo)])
        old=b/"old";prep(old);base,bt,orig,og=commit("base",old,repo)
        flog=b/"old-log";flog.mkdir()
        a=run_lake(tool,old,old/".lake/packages",flog,bwrap,time.time()+600)
        assert a["exit"]==1
        basedig=digest_dir(old)
        s=b/"stage1";prep(s,True);pin,tr,rows,g=commit("first repair",s,repo)
        token="1"*32;job=trusted/token;job.mkdir();wk=b/(pin+"-"+token);wk.mkdir();s.rename(wk/"source");s=wk/"source"
        call(["git","clone","-q","--bare",str(repo),str(job/"candidate.git")])
        o=stage_seed(old,s,orig,rows,g,set(a["newly_built"]),tool,helper,wk)
        first=run_lake(tool,s,old/".lake/packages",wk,bwrap,time.time()+600)
        assert first["exit"]==1 and set(first["newly_built"])=={"Changed","Reader","Intermediate"}
        first.update(source_commit=pin,source_tree=tr,parent_receipt=RECEIPT,eligible=len(o["accepted"]))
        (wk/"result.json").write_text(json.dumps(first))
        status={"kind":"warm diagnostics only","job":{"token":token,"main":True,"receipt_sha":RECEIPT,"commit":pin,"tree":tr},
                "finished_unix":time.time(),"old_receipt_sha256":RECEIPT,"warm_main_exit":1,"warm_main_output":str(wk)}
        (job/"status.json").write_text(json.dumps(status))
        driver={k:first[k] for k in ("kind","root","exit","log_sha256","eligible")}
        (job/"warm-main-driver.log").write_text(json.dumps(driver)+"\n")
        prevdig=digest_dir(wk)
        def prepnew(label,change,oldtext,newtext):
            new=b/label;new.mkdir();sf=new/"source";prep(sf,True)
            src=sf/"CompactGRH/src"/(change+".lean");src.write_text(src.read_text().replace(oldtext,newtext))
            _,_,r,g=commit(label,sf,repo)
            original=stage_seed(old,sf,orig,r,g,set(a["newly_built"]),tool,helper,new)
            layer=validate_previous(token,new,r,g,tool,set(original["accepted"]),queue=trusted)
            return new,r,g,original,layer
        new,_,_,ori,layer=prepnew("fixed","Deep","laterMissing","intermediate")
        assert set(ori["accepted"])=={"Base","Stable"} and set(layer["accepted"])=={"Changed","Reader","Intermediate"},layer
        final=run_lake(tool,new/"source",old/".lake/packages",new,bwrap,time.time()+600)
        assert final["exit"]==0 and set(final["newly_built"])=={"Deep","Main"},final
        change,r,g,_,lc=prepnew("changed-ancestor","Changed",":= 2",":= 5")
        assert set(lc["accepted"])=={"Intermediate"},lc
        # Mutate only a private clone of the prior job log, while retaining its root-owned original digest.
        bad="2"*32;bd=trusted/bad;bd.mkdir();bw=b/(pin+"-"+bad);shutil.copytree(wk,bw)
        control=json.loads(json.dumps(status));control["job"]["token"]=bad;control["warm_main_output"]=str(bw)
        (bd/"status.json").write_text(json.dumps(control));(bd/"warm-main-driver.log").write_text(json.dumps(driver))
        with (bw/"warm-main.log").open("a") as fp:fp.write("changed")
        try:validate_previous(bad,change,r,g,tool,set(),queue=trusted)
        except ValueError as e:
            why=str(e);assert "identity differs" in why
        else:raise AssertionError("Corrupted previous log accepted")
        assert basedig==digest_dir(old) and prevdig==digest_dir(wk)
        result={"scope":"local stock Linux Lake chained diagnostic","version":call([tool/"bin/lake","--version"]),
             "first_exit":a["exit"],"first_warm_new":first["newly_built"],"first_warm_exit":first["exit"],"second_warm":final,
             "original_seeds":ori["accepted"],"previous_additional_seeds":layer["accepted"],
             "after_ancestor_changed":lc["accepted"],"tampered_log_rejected":why,
             "original_preserved":basedig,"first_warm_preserved":prevdig}
        output.write_text(json.dumps(result,indent=2)+"\n");print(json.dumps(result))
if __name__=="__main__":main(P(sys.argv[1]),P(sys.argv[2]),P(sys.argv[3]))
