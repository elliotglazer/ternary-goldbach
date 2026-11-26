"""Exercise the stopped-host dispatcher against a local AWS response double."""
import importlib.util
import json
import sys
import tempfile
import datetime as dt
from pathlib import Path
from unittest.mock import patch
import subprocess

def exercise(mod, lake_threads=None, modules=(), **override):
    calls=[]
    commands=[]
    def fake(service,action,*args):
        calls.append(action)
        if action=='describe-stacks':return {'Stacks':[{'Outputs':[{'OutputKey':'Instance','OutputValue':'i-test'},{'OutputKey':'Evidence','OutputValue':'vol-test'}]}]}
        if action=='describe-instances':return {'Reservations':[{'Instances':[{'State':{'Name':override.get('state','stopped')},'InstanceType':'r7i.8xlarge','BlockDeviceMappings':[{'Ebs':{'VolumeId':'vol-test'}}]}]}]}
        if action=='describe-volumes':return {'Volumes':[{'Size':override.get('size',600),'Attachments':[{'InstanceId':'i-test','State':'attached'}]}]}
        if action=='describe-stack-resource':return {'StackResourceDetail':{'PhysicalResourceId':'group/schedule'}}
        if action=='get-schedule':return {'State':override.get('schedule','ENABLED'),'Target':{'Arn':'arn:aws:scheduler:::aws-sdk:ec2:stopInstances','Input':json.dumps({'InstanceIds':['i-test']})},'ScheduleExpression':'at('+(dt.datetime.now(dt.timezone.utc)+dt.timedelta(hours=override.get('window_hours',10))).strftime('%Y-%m-%dT%H:%M:%S')+')'}
        if action=='start-instances':return {}
        if action=='describe-instance-information':return {'InstanceInformationList':[{'PingStatus':'Online'}]}
        if action=='send-command':
            cmd=json.loads(args[args.index('--parameters')+1])['commands'][0]
            subprocess.run(['sh','-n'],input=cmd.encode(),check=True)
            commands.append(cmd)
            return {'Command':{'CommandId':str(len(commands))}}
        if action=='list-command-invocations':return {'CommandInvocations':[{'Status':'Success','CommandPlugins':[{}]}]}
        if action=='get-command-invocation':return {'StandardOutputContent':'online'}
        raise AssertionError(action)
    arguments = ['compact_joint_stack.py', '--commit', '1'*40, '--tree', '2'*40]
    for module in modules:
        arguments += ['--preflight-module', module]
    if lake_threads is not None:
        arguments += ['--lake-threads', str(lake_threads)]
    with patch.object(mod,'aws',fake),patch.object(mod,'public_pin',lambda commit,tree,modules: None),patch.object(sys,'argv',arguments):
        try: mod.main()
        except SystemExit:
            assert override and 'start-instances' not in calls
            return
    assert not override
    import base64, re, shlex
    dispatch = shlex.split(commands[-1])[-1]
    transport = re.search(r"echo '([A-Za-z0-9+/=]+)' \| base64 -d > [^\n]+/launch", dispatch)
    assert transport, 'Missing captured driver transport'
    uploaded = base64.b64decode(transport.group(1)).decode()
    assert '--threads 32 ' in uploaded and '--profile palomar-32x64 ' in uploaded
    assert ('--lake-threads ' in uploaded) == (lake_threads is not None)
    if lake_threads is not None:
        assert f'--lake-threads {lake_threads} ' in uploaded
    for module in modules:
        assert '--preflight-module ' + module + ' ' in uploaded
    assert uploaded.count('--preflight-module ') == len(modules)
    assert len(commands[-1].encode()) < 24000
    assert 'CPUQuota=3200%' in dispatch and 'MemorySwapMax=0' in dispatch
    assert calls.count('start-instances')==1
    assert sum('systemd-run --collect --unit=tg-source-replay' in c for c in commands)==1
    assert '/work/compact-joint' in mod.DRIVER
    assert any('MemoryMax=67345087201' in c and 'MemoryHigh=65283502899' in c for c in commands)
    assert '/work/compact-joint-mathlib-cache-56a00585' in mod.DRIVER
    assert 'setpriv --reuid=grhreplay' in mod.DRIVER
    assert 'test ! -e /work/compact-joint' not in mod.DRIVER
    subprocess.run(['bash','-n'],input=mod.DRIVER.replace('@GUARD@',mod.GUARDS).encode(),check=True)
def failure_summary_control():
    import base64, gzip, hashlib, tempfile
    from pathlib import Path
    from compact_joint import failed_build_details
    from compact_joint_stack import DRIVER
    with tempfile.TemporaryDirectory() as tmp:
        root = Path(tmp)
        source, evidence = root / "run/source", root / "run/evidence"
        evidence.mkdir(parents=True)
        lib = source / ".lake/build/lib/lean"
        for name, compact, traced in [("Lib/Alpha", True, True), ("Totient", False, True), ("Pending", False, False)]:
            lean = (source / "CompactGRH/src" if compact else source) / (name + ".lean")
            lean.parent.mkdir(parents=True, exist_ok=True)
            lean.write_text("-- fixture")
            artifact = lib / (name + ".olean")
            artifact.parent.mkdir(parents=True, exist_ok=True)
            artifact.write_bytes(b"fixture")
            if traced:
                artifact.with_suffix(".trace").write_text("{}")
        lines = ["✖ [10/12] Building Lib.Alpha (0.5s)",
                 "error: /project/CompactGRH/src/Lib/Alpha.lean:3:12: Unknown identifier",
                 "error: /project/CompactGRH/src/Lib/Alpha.lean:4:10: Another error",
                 "./Totient.lean:8:2: error: unsolved goals",
                 "./Totient.lean:9:0: warning: ignored",
                 "error: Lean exited with code 1"] + [
                     f"error: Module{i}.lean:5:0: extra" for i in range(15)]
        (evidence / "joint-source-build.log").write_text("\n".join(lines))
        steps = [{"name": "joint-source-build", "exit": 1, "wall_seconds": 11}]
        details = failed_build_details(source, evidence, steps)
        assert details["completed_oleans"] == {"compact": 1, "goldbach": 1}
        assert details["source_error_count"] == 18 and details["source_error_modules"] == 17
        assert len(details["representative_errors"]) == 12 and details["failed_lake_targets"] == ["Lib.Alpha"]
        assert details["representative_errors"][1] == {"path": "Totient.lean", "line": 8, "column": 2, "message": "unsolved goals"}
        payload = {"status": "failed", "failure_details": details, "steps": steps}
        receipt = evidence / "receipt.json"
        serializer = DRIVER.split("<<'TG_SUMMARY'\n", 1)[1].split("\nTG_SUMMARY\n", 1)[0]
        for result in [payload, {"status": "verified", "steps": []}]:
            receipt.write_text(json.dumps(result))
            wire = subprocess.check_output([sys.executable, "-", str(root), "1"*40, "2"*40,
                                            "1" if result is payload else "0"], input=serializer, text=True)
            ref, marker = wire.splitlines()
            assert ref.split()[-1] == hashlib.sha256(receipt.read_bytes()).hexdigest()
            label, digest, encoded = marker.split()
            msg = gzip.decompress(base64.b64decode(encoded))
            assert label == "TG435_RECEIPT_V1" and hashlib.sha256(msg).hexdigest() == digest
            recovered = json.loads(msg)
            if result is payload:
                assert recovered["failure_details"] == details and recovered["status"] == "failed"
            else:
                assert "failure_details" not in recovered and recovered["status"] == "verified"


if __name__=='__main__':
    failure_summary_control()
    import compact_joint_stack as compact_stack
    exercise(compact_stack, lake_threads=4, modules=("Lib.Alpha", "Beta"))
    for case in [{},{'state':'running'},{'size':601},{'schedule':'DISABLED'},{'window_hours':200}]:
        exercise(compact_stack,**case)
    print('Mock compact dispatch, four pre-start refusals, and failure receipt round-trips passed.')

