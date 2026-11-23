import hashlib,json,re
from pathlib import Path

HERE=Path(__file__).resolve().parent
def report():
    channels={}
    discharge=0.
    hashes={}
    for tag in ("even01","odd01","project01"):
        assert (HERE/f"{tag}.status").read_text().strip()=="0"
        for line in (HERE/f"{tag}.sha256").read_text().splitlines():
            digest,name=line.split(maxsplit=1)
            # Holmakefile gained one additional include for the independent
            # projection phase after the two checked pair theorems were exported.
            if name!="Holmakefile":
                assert hashlib.sha256((HERE/name).read_bytes()).hexdigest()==digest
        text=(HERE/f"{tag}.log").read_text()
        hashes[tag]=hashlib.sha256((HERE/f"{tag}.log").read_bytes()).hexdigest()
        for lab,sec in re.findall(r"^HEAD_CHANNEL (\d+) ([.\d]+)$",text,re.M):
            channels[lab]=float(sec)
        discharge+=sum(map(float,re.findall(r"^HEAD_PAIR_DONE \w+ ([.\d]+)$",text,re.M)))
    assert set(channels)=={"3","6667","11","9091"}
    p=re.search(r"^RETAINED_PROJECTION (\d+) (\d+) (\d+) ([.\d]+) ([.\d]+) ([.\d]+) ([.\d]+)",text,re.M)
    assert p and tuple(map(int,p.groups()[:3]))==(5312,71325,5)
    sparse=sum(channels.values())+discharge
    n=1791987359885
    f=n/(340484*3600)
    both=sparse+float(p[7])
    out=dict(channels=channels,pair_discharge=discharge,compressed_total=sparse,
        projection=dict(tiles=5312,samples=71325,negative_controls=5,setup=float(p[4]),numerals=float(p[5]),
                        evaluate=float(p[6]),worker=float(p[7])),
        process_cpu={tag:sum(float(re.search(rf"{key} time \(seconds\): ([.\d]+)",(HERE/f"{tag}.time").read_text())[1])
                    for key in ["User","System"]) for tag in hashes},
        log_hashes=hashes,explicit_inner_seconds=both,conditional_extra640_hours=both*f,
        extra640_remainder=[800000-629001.3830343093-both*f,800000-628472.0262959333-both*f])
    (HERE/"results.json").write_text(json.dumps(out,indent=2)+"\n")
    print(json.dumps(out))

if __name__=="__main__":
    report()
