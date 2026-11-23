"""Summarize the measured stock HOL4 tile checks and verify archive coverage."""
from hashlib import sha256
from pathlib import Path
import json
import re

here=Path(__file__).resolve().parent
def digest(path):
    return sha256(path.read_bytes()).hexdigest()

def main():
    tag="all01"
    log=(here/f"{tag}.log").read_text()
    assert (here/f"{tag}.status").read_text().strip()=="0" and "SPARSE_RAW_STREAM_DONE" in log
    assert re.findall(r"STREAM_LABEL (\d+) ",log)==["3","6667","11","9091"]
    m=re.search(r"^STREAM_CPU ([^\n]+)$",log,re.M)
    timing=dict(zip(["setup","numerals","kernel","checks_and_negative_controls","archive","reload","total"],
                    map(float,m.group(1).split()),strict=True))
    expected=[*range(16,5325,16),5324]
    files=[here/"tiles"/f"ending-{n}.thms" for n in expected]
    assert len(files)==len(list((here/"tiles").glob("*.thms")))
    archives={p.name:dict(bytes=p.stat().st_size,sha256=digest(p)) for p in files}
    mf=json.loads((here/"manifest.json").read_text())
    assert mf["stream_sha256"]==digest(here/"stream.txt")
    for line in (here/f"{tag}.sha256").read_text().splitlines():
        h,fn=line.split(None,1)
        assert digest(here/fn.strip())==h
    t=(here/f"{tag}.time").read_text()
    field=lambda name: re.search(re.escape(name)+r":\s*([\d.]+)",t).group(1)
    result=dict(channels=mf["channels"],raw_inputs=sum(r[1] for r in mf["channels"]),
                coarse_signs=sum(r[2] for r in mf["channels"]),tiles=5324,
                wrong_sign_rejections=4,archive_files=len(files),archive_bytes=sum(v['bytes'] for v in archives.values()),
                cpu_seconds=timing,process_cpu_seconds=float(field("User time (seconds)"))+float(field("System time (seconds)")),
                max_rss_kib=int(field("Maximum resident set size (kbytes)")),archives=archives,
                log_sha256=digest(here/f"{tag}.log"),manifest=mf["stream_sha256"],
                scope="Strict signs at selected coarse sites; raw values for stencil neighborhoods are carried through the same masked records. This job does not evaluate the 103 off-grid dots, run the pair tests, or supply analytic input enclosures.")
    (here/"results.json").write_text(json.dumps(result,indent=2)+"\n")
    print({k:v for k,v in result.items() if k not in ("archives","scope","manifest","log_sha256")})

if __name__=="__main__":
    main()
