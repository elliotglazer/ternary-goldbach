"""Run the isolated tests from an extracted bundle. No network or AWS SDK required."""
import base64
from datetime import timedelta
import gzip
import hashlib
import io
import json
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile
from types import SimpleNamespace

import pilot
import report


def fake_price(value):
    product={"terms":{"OnDemand":{"test":{"priceDimensions":{"test":{"unit":"Hrs","pricePerUnit":{"USD":value}}}}}}}
    pag=SimpleNamespace(paginate=lambda **k:[{"PriceList":[json.dumps(product)]}])
    return SimpleNamespace(get_paginator=lambda k:pag)


def main():
    payload=pilot.package()
    with tarfile.open(fileobj=io.BytesIO(payload)) as tar:
        assert set(tar.getnames())=={"worker.sh","report.py",pilot.ARCHIVE}
        wide=tar.extractfile(pilot.ARCHIVE).read()
        assert hashlib.sha256(wide).hexdigest()==pilot.PIN
        with tarfile.open(fileobj=io.BytesIO(wide)) as contents:
            for key,folder in (("small","w8192"),("large","w262144")):
                raw=contents.extractfile("goldbach-wide/wide/"+folder+"/workload.json").read()
                assert hashlib.sha256(raw).hexdigest()==pilot.FIXTURES[key][0]
    print("Pinned wide archive and both exact fixture manifests match.")
    bash=shutil.which("bash")
    if not bash:
        raise SystemExit("bash is required for this offline test")
    end=pilot.utc()+timedelta(hours=3)
    post={k:{"url":"https://unused.invalid","fields":{"key":k+".json.gz"}} for k in ("progress","final")}
    data=pilot.bootstrap("abc","https://unused.invalid",post,end)
    shell=gzip.decompress(base64.b64decode(data))
    for code in (shell,(pilot.ROOT/"worker.sh").read_bytes()):
        subprocess.run([bash,"-n"],input=code,check=True)
    assert b"set -eu" in shell and b"DEADLINE" not in shell and b"GETURL" not in shell
    assert shell.count(b"systemctl poweroff")==1
    obj=pilot.template(("subnet-test","vpc-test","ami-test","/dev/sda1"),"goldbach-test",end,data)["Resources"]
    fleet=obj["Fleet"]["Properties"]
    assert fleet["Type"]=="request" and fleet["TerminateInstancesWithExpiration"] is True and fleet["ValidUntil"]==pilot.z(end)
    cap=fleet["TargetCapacitySpecification"]
    assert (cap["TotalTargetCapacity"],cap["OnDemandTargetCapacity"],cap["SpotTargetCapacity"])==(1,1,0)
    launch=obj["Launch"]["Properties"]["LaunchTemplateData"]
    assert launch["InstanceType"]=="c7a.4xlarge" and "IamInstanceProfile" not in launch and "KeyName" not in launch
    assert launch["InstanceInitiatedShutdownBehavior"]=="terminate"
    disk=launch["BlockDeviceMappings"][0]["Ebs"]
    assert disk["VolumeSize"]==96 and disk["Encrypted"] and disk["DeleteOnTermination"] and disk["VolumeType"]=="gp3"
    assert obj["Group"]["Properties"]["SecurityGroupIngress"]==[]
    assert len(pilot.quote(fake_price("0.82112")).as_tuple().digits)>0
    try:
        pilot.quote(fake_price("1.01"))
    except ValueError:
        pass
    else:
        raise AssertionError("high price accepted")
    print("Guest scripts parse; expiration, one-worker limit, root deletion, no-ingress and price guards pass.")
    with tempfile.TemporaryDirectory() as d:
        root=Path(d)
        partial=report.collect("progress",0,root)
        assert not pilot.both_audits(partial)
        for name,(digest,lower) in pilot.FIXTURES.items():
            run=root/"goldbach-wide"/("run-"+name)
            run.mkdir(parents=True)
            receipt={"passed":True,"fixture_sha256":digest,"stages":[{"module":m,"exit_code":0}
                     for m in ("Shared","ReadTable","Shard0","Shard1","WideAudit")]}
            (run/"receipt.json").write_text(json.dumps(receipt))
            (run/"WideAudit.log").write_text(f"{lower} ≤ n → n ≤ 4000000000000000\n"+pilot.EXPECTED,encoding="utf-8")
        final=report.collect("final",0,root)
        assert pilot.both_audits(final)
        final["fixtures"]["large"]["audit"]=final["fixtures"]["small"]["audit"]
        assert not pilot.both_audits(final)
        assert not pilot.both_audits(report.collect("final",1,root))
        (root/"goldbach-wide"/"run-large"/"WideAudit.log").write_text("unknown axiom")
        assert not pilot.both_audits(report.collect("final",0,root))
    print("Partial receipt, worker failure, wrong theorem boundary and changed axioms all fail acceptance.")
    print("Offline checks passed. These test records are synthetic; no EC2 job was launched.")


if __name__=="__main__":
    main()
