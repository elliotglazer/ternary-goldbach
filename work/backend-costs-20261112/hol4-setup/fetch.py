from pathlib import Path
import hashlib
import json
import urllib.request
import zipfile

home = Path(__file__).resolve().parent
commit = json.loads((home / 'source_commit.json').read_text())['sha']
url = f'https://codeload.github.com/HOL-Theorem-Prover/HOL/zip/{commit}'
archive = home / f'HOL-{commit}.zip'
if not archive.exists():
    urllib.request.urlretrieve(url, archive)
with zipfile.ZipFile(archive) as z:
    z.extractall(home)
record = {'commit': commit, 'url': url, 'bytes': archive.stat().st_size,
          'sha256': hashlib.sha256(archive.read_bytes()).hexdigest()}
(home / 'source.json').write_text(json.dumps(record, indent=2) + '\n')
print(json.dumps(record))
