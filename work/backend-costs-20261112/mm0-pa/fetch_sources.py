"""Fetch pinned MM0 sources and official portable Rust component metadata."""
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import hashlib
import json
import urllib.request
import zipfile

home = Path(__file__).resolve().parent
commit = '0d414c0bfdaaeb7fea571895127abc1fa5a3d956'
downloads = [
    ('mm0-source.zip', f'https://codeload.github.com/digama0/mm0/zip/{commit}'),
    ('rust-stable.toml', 'https://static.rust-lang.org/dist/channel-rust-stable.toml')]


def fetch(item):
    name, url = item
    path = home/name
    if not path.exists():
        request = urllib.request.Request(url, headers={'User-Agent':'TG-backend-comparison'})
        with urllib.request.urlopen(request, timeout=90) as response:
            data = response.read()
        path.write_bytes(data)
    return {'name': name, 'url': url, 'bytes': path.stat().st_size,
            'sha256': hashlib.sha256(path.read_bytes()).hexdigest()}


with ThreadPoolExecutor(max_workers=2) as pool:
    records = list(pool.map(fetch, downloads))
with zipfile.ZipFile(home/'mm0-source.zip') as archive:
    for item in archive.infolist():
        target = (home/item.filename).resolve()
        assert target.is_relative_to(home.resolve())
    archive.extractall(home)
(home/'source_downloads.json').write_text(json.dumps({'commit':commit,'files':records},indent=2)+'\n')
print(json.dumps(records,indent=2))
