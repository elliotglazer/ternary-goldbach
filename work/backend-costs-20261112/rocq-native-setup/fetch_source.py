from pathlib import Path
import hashlib
import json
import tarfile
import urllib.request

home = Path(__file__).resolve().parent
url = 'https://github.com/coq/coq/releases/download/V9.0.0/rocq-9.0.0.tar.gz'
archive = home / 'rocq-9.0.0.tar.gz'
if not archive.exists():
    with urllib.request.urlopen(url) as incoming, archive.open('wb') as output:
        while chunk := incoming.read(1024*1024):
            output.write(chunk)
digest = hashlib.sha512(archive.read_bytes()).hexdigest()
expected = ('f4f76a6a178e421c99ee7a331a2fd97a06e9c5d0168d7e60c44e3820d8e1a124370ea'
            '104ad90c7f87a9a1e9d87b2d0d7d2d387c998feeaed4a75ed04e176a4be')
assert digest == expected, 'Release differs from the Alpine package source pin'
with tarfile.open(archive) as incoming:
    incoming.extractall(home, filter='data')
(home / 'source.json').write_text(json.dumps({'url': url,
    'bytes': archive.stat().st_size, 'sha512': digest}, indent=2) + '\n')
print('Fetched and hash-checked Rocq 9.0.0 source.')
