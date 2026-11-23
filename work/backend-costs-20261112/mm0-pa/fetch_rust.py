"""Install only portable compiler components inside this experiment directory."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path, PurePosixPath
import hashlib
import json
import shutil
import tarfile
import tomllib
import urllib.request

home = Path(__file__).resolve().parent
manifest = tomllib.loads((home/'rust-stable.toml').read_text())
target = 'x86_64-unknown-linux-musl'


def fetch(name):
    record = manifest['pkg'][name]['target'][target]
    assert record['available']
    url = record['xz_url']
    path = home/url.rsplit('/',1)[-1]
    if not path.exists():
        with urllib.request.urlopen(url, timeout=120) as response, path.open('wb') as out:
            shutil.copyfileobj(response,out)
    with path.open('rb') as stream:
        sha = hashlib.file_digest(stream,'sha256').hexdigest()
    assert sha == record['xz_hash']
    component = 'rust-std-'+target if name == 'rust-std' else name
    portable = home/'rust'
    copied = 0
    with tarfile.open(path,'r:xz') as archive:
        for member in archive.getmembers():
            parts = PurePosixPath(member.name).parts
            if len(parts)<4 or parts[1] != component or parts[2] not in ['bin','lib']:
                continue
            destination = portable.joinpath(*parts[2:]).resolve()
            assert destination.is_relative_to(portable.resolve())
            if member.isdir():
                destination.mkdir(parents=True, exist_ok=True)
            elif member.isfile() or member.issym() or member.islnk():
                destination.parent.mkdir(parents=True, exist_ok=True)
                with archive.extractfile(member) as inp, destination.open('wb') as out:
                    shutil.copyfileobj(inp,out)
                copied += 1
    return {'component':name, 'version':manifest['pkg'][name]['version'],
            'url':url, 'sha256':sha,'archive_bytes':path.stat().st_size,'files':copied}


with ThreadPoolExecutor(max_workers=3) as pool:
    records = list(pool.map(fetch,['rustc','rust-std','cargo']))
(home/'rust_downloads.json').write_text(json.dumps(records,indent=2)+'\n')
print(json.dumps(records,indent=2))
