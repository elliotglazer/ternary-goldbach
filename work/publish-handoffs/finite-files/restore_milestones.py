"""Verify the six milestone archives and optionally extract to a new directory."""
import argparse
from hashlib import sha256
import json
from pathlib import Path
from zipfile import ZipFile

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('destination',type=Path,nargs='?',help='new directory; omit for verification only')
    dest=parser.parse_args().destination
    here=Path(__file__).resolve().parent/'milestones'
    manifest=json.loads((here/'manifest.json').read_bytes())
    seen=set()
    if dest is not None:
        dest.mkdir(parents=True,exist_ok=False)
    for file,expected in manifest['archives'].items():
        path=here/file
        if sha256(path.read_bytes()).hexdigest()!=expected:
            raise ValueError(f'archive digest mismatch: {file}')
        with ZipFile(path) as z:
            for name in z.namelist():
                if Path(name).is_absolute() or '..' in Path(name).parts or ':' in name or '\\' in name:
                    raise ValueError(f'unsafe member: {name}')
                data=z.read(name)
                if name in seen or sha256(data).hexdigest()!=manifest['files'][name]:
                    raise ValueError(f'duplicate or digest mismatch: {name}')
                seen.add(name)
                if dest is not None:
                    target=dest/name
                    target.parent.mkdir(parents=True,exist_ok=True)
                    target.write_bytes(data)
    if seen!=manifest['files'].keys():
        raise ValueError('incomplete archive')
    print(f"Verified {len(seen)} files for {len(manifest['modules'])} project modules.")

if __name__=='__main__':
    main()
