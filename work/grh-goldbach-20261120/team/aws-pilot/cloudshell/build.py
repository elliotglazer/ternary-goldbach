"""Produce the single CloudShell upload with reproducible paths, timestamps and bytes."""
from pathlib import Path
from hashlib import sha256
from zipfile import ZipFile, ZipInfo, ZIP_DEFLATED

here=Path(__file__).resolve().parent
archive="goldbach-4e15-wide-linux.tar.gz"
out=here.parent/"goldbach-cloudshell.zip"
with ZipFile(out,"w") as z:
    for name in ["README.md","pilot.py","report.py","worker.sh","check_offline.py",archive]:
        f=here.parent/"wide"/archive if name==archive else here/name
        raw=f.read_bytes()
        if name!=archive:
            raw=raw.replace(b"\r\n",b"\n")
        info=ZipInfo("goldbach-cloudshell/"+name, date_time=(2026,11,20,0,0,0))
        info.external_attr=0o100644 << 16
        z.writestr(info,raw,compress_type=ZIP_DEFLATED,compresslevel=9)
print(out.name,out.stat().st_size,sha256(out.read_bytes()).hexdigest())
