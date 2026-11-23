"""Check exact output receipts and report separate arithmetic, conversion and process times."""
from hashlib import sha256
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent


def checked(label, marker, status=True):
    for row in (HERE/f"{label}.sha256").read_text().splitlines():
        digest, name = row.split(maxsplit=1)
        assert sha256((HERE/name).read_bytes()).hexdigest()==digest, (label,name)
    if status:
        assert (HERE/f"{label}.status").read_text().strip()=="0"
    log = (HERE/f"{label}.log").read_text()
    meter = (HERE/f"{label}.time").read_text()
    assert marker in log and "Exit status: 0" in meter, label
    def value(key):
        return float(re.search(r"^\s*"+re.escape(key)+r":\s*([0-9.]+)$",meter,re.M)[1])
    return log, dict(cpu=value("User time (seconds)")+value("System time (seconds)"),
                     peak_kib=int(value("Maximum resident set size (kbytes)")))


def typed(label):
    log, proc = checked(label,"FUSED_DONE")
    stages = {name:list(map(float,(p,k,d))) for name,p,k,d in
              re.findall(r"^TIMED (\w+) (\S+) (\S+) (\S+)$",log,re.M)}
    assert set(stages)=={"fused","buckets","after"}
    merge = float(re.search(r"^COMPOSE ([0-9.]+)$",log,re.M)[1])
    fused = sum(stages["fused"])
    split = sum(stages["buckets"])+sum(stages["after"])+merge
    return dict(process=proc,stages=stages,composition=merge,fused=fused,split=split,ratio=split/fused)


def encoded(label, theory, marker, missing_wrapper=False):
    log, proc = checked(label,marker,status=not missing_wrapper)
    artifact = HERE/".hol/objs"/(theory+"Theory.dat")
    assert f'Exporting theory "{theory}" ... done.' in log and artifact.is_file()
    rows = {n:[float(a),float(b)] for n,a,b in re.findall(r"^ENCODED (\w+) (\S+) (\S+)$",log,re.M)}
    tables = {n:float(x) for n,x in re.findall(r"^TABLE (\w+) (\S+)$",log,re.M)}
    diagnostic = re.search(r"^DIAGNOSTIC (\S+)$",log,re.M)
    return dict(process=proc,encoded_stages=rows,tables=tables,
                independent_check_cpu=float(diagnostic[1]) if diagnostic else None,
                data_bytes=artifact.stat().st_size,data_sha256=sha256(artifact.read_bytes()).hexdigest())


def main():
    reference=json.loads((HERE/"matched.json").read_bytes())
    assert reference["primitive_labels"]==1600 and reference["transform_precision"]==307
    assert reference["sha256"]["matched.txt"]==sha256((HERE/"matched.txt").read_bytes()).hexdigest()
    result=dict(original=typed("actual01"),matched=typed("matched02"),
                tables=encoded("tables01","ConductorTables","NAMED_TABLES_DONE"),
                source=encoded("publish01","GaussianTransfer","SOURCE_RECEIPT_DONE",missing_wrapper=True),
                consumer=encoded("consume01","PrimitiveTransfer","CONSUMER_RECEIPT_DONE"),
                direct=encoded("direct01","DirectTransfer","DIRECT_RECEIPT_DONE"),
                readback=encoded("read01","ReadTransfer","READBACK_RECEIPT_DONE"),
                reference=reference)
    (HERE/"results.json").write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k!="reference"},indent=2))


if __name__=="__main__":
    main()
