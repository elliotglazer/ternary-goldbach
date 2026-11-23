"""Export the kernel-checked bridge on the same Lean and exporter pins as the GRH proof."""
import hashlib
import json
import os
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
GRH = Path('/verification/lean')
BIN = Path('/verification/lean-4.33.1-linux/bin')
EXPORT = Path('/tmp/goldbach-lean4export-15f6055e')


def digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def main():
    witness = json.loads((HERE.parent/'adapter/linux_port_8g.json').read_bytes())
    built = Path(witness['workdir'])
    decl = 'plattGRH_of_release_statement'
    for row in witness['jobs']:
        module = row['module']
        if row['exit_code'] or digest(built/(module+'.olean')) != row['sha256_olean']:
            raise ValueError(f'Adapter object differs from receipt: {module}')
    revision = subprocess.check_output(['git','-C',EXPORT,'rev-parse','HEAD'],text=True).strip()
    if revision != '15f6055e299ad5b89345e533cc2192f4cc00f659':
        raise ValueError('Exporter revision differs from the published run')
    version = subprocess.check_output([BIN/'lean','--version'],text=True).strip()
    if version != witness['lean']:
        raise ValueError('Compiler differs from the audited adapter')
    paths = [built,GRH/'.lake/build/lib/lean',*sorted((GRH/'.lake/packages').glob('*/.lake/build/lib/lean'))]
    env = dict(os.environ,PATH=f'{BIN}:/usr/bin:/bin',LEAN_PATH=os.pathsep.join(map(str,paths)))
    raw = built/'goldbach-adapter.ndjson'
    with raw.open('wb') as f:
        subprocess.run([EXPORT/'.lake/build/bin/lean4export','PortAudit','--',decl],cwd=built,env=env,stdout=f,check=True)
    archive = HERE/'goldbach-adapter.ndjson.zst'
    partial = archive.with_suffix('.partial')
    with partial.open('wb') as f:
        subprocess.run(['zstd','-q','-T1','-3','-c',raw],stdout=f,check=True)
    partial.replace(archive)
    result = dict(compiler=version,exporter=revision,declaration=decl,bytes=raw.stat().st_size,
                  sha256=digest(raw),compressed_bytes=archive.stat().st_size,compressed_sha256=digest(archive))
    (HERE/'export-adapter.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result),flush=True)


if __name__=='__main__':
    main()
