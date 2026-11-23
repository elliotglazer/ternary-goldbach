"""Save only native modules with successful, hash-matching receipts for transfer."""

import argparse
import gzip
import hashlib
import io
import json
from pathlib import Path
import tarfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('cache', type=Path)
    parser.add_argument('archive', type=Path)
    args = parser.parse_args()
    receipt = (args.cache/'receipt.json').read_bytes()
    state = json.loads(receipt)
    repo = Path(__file__).resolve().parents[3] / 'ternary-goldbach'
    files = {'receipt.json':receipt, 'LICENSE':(repo/'LICENSE').read_bytes(), 'NOTICE':(repo/'NOTICE').read_bytes()}
    for module, entry in state['passed'].items():
        path = module.replace('.', '/') + '.olean'
        raw = (args.cache/path).read_bytes()
        if hashlib.sha256(raw).hexdigest() != entry['olean']:
            raise ValueError(f'Changed native file: {module}')
        files[path] = raw
    target = args.archive.with_suffix('.tmp')
    with target.open('wb') as stream, gzip.GzipFile(fileobj=stream, filename='', mode='wb', mtime=0) as gz:
        with tarfile.open(fileobj=gz, mode='w') as bundle:
            for filename,raw in sorted(files.items()):
                member = tarfile.TarInfo(filename)
                member.size = len(raw)
                bundle.addfile(member, io.BytesIO(raw))
    target.replace(args.archive)
    print(json.dumps({'modules':len(state['passed']), 'bytes':args.archive.stat().st_size,
                      'archive_sha256':hashlib.sha256(args.archive.read_bytes()).hexdigest()}))


if __name__ == '__main__':
    main()
