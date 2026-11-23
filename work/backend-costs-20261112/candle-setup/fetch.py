from pathlib import Path
import hashlib,json,urllib.request,zipfile,tarfile
H=Path(__file__).resolve().parent
pin='6a9acd58867610c78fee0f3dd9ed4c4c14087b18'
records=[]
for name,url in [('candle.zip',f'https://codeload.github.com/CakeML/candle/zip/{pin}'),
                 ('cake-x64-64.tar.gz','https://cakeml.org/regression/artefacts/3286/cake-x64-64.tar.gz')]:
    dst=H/name
    if not dst.exists():
        with urllib.request.urlopen(url,timeout=60) as r, dst.with_suffix('.part').open('wb') as out:
            while chunk:=r.read(1024*1024):out.write(chunk)
        dst.with_suffix('.part').replace(dst)
    records.append(dict(url=url,bytes=dst.stat().st_size,sha256=hashlib.sha256(dst.read_bytes()).hexdigest()))
    print(records[-1],flush=True)
with zipfile.ZipFile(H/'candle.zip') as z:
    for name in z.namelist():
        target=(H/name).resolve()
        if not target.is_relative_to(H):raise ValueError(name)
    z.extractall(H)
with tarfile.open(H/'cake-x64-64.tar.gz') as t:t.extractall(H/'compiler',filter='data')
(H/'downloads.json').write_text(json.dumps(records,indent=2)+'\n')
