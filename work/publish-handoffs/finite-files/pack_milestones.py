"""Collect checked project imports and their sources from the original workspace."""
from hashlib import sha256
import json
from pathlib import Path
import re
from zipfile import ZipFile, ZIP_DEFLATED


def main():
    out=Path(__file__).resolve().parent/'milestones'
    root=Path(__file__).resolve().parents[3]
    team=root/'work/grh-goldbach-20261120/team'
    prefix=team/'small-prefix'
    extension=prefix/'contiguous-extension'
    release=prefix/'ten-billion/compact'
    object_dirs=[extension,release/'.split-build',prefix,team/'aws-pilot/wide/b8192-02',
                 root/'work/backend-costs-20261112/finite-lean',root/'work/formal-goldbach-bench/prime-cert']
    source_dirs=[extension,release,*object_dirs,prefix/'compact-clean',prefix/'replay-b9',team/'aws-pilot/wide',team/'aws-pilot']
    roots=[f'GoldbachBand{i:02d}Prefix' for i in range(1,7)]
    entries={}
    modules={}
    external=set()
    def add(name,source):
        if name in entries: assert entries[name]==source
        entries[name]=source
    def visit(module):
        if module in modules: return
        assert module not in external
        name=module.replace('.','/')
        src=next((d/(name+'.lean') for d in source_dirs if (d/(name+'.lean')).exists()),None)
        obj=next((d/(name+'.olean') for d in object_dirs if (d/(name+'.olean')).exists()),None)
        if not obj and not src:
            assert module.split('.')[0] in ('Mathlib','Lean','Std','Init','Batteries','Qq','Aesop'),module
            external.add(module)
            return
        assert src and obj,(module,src,obj)
        receipt=obj.with_suffix('.json')
        if receipt.is_file():
            pin=json.loads(receipt.read_bytes())
            if 'source_sha256' in pin:
                assert pin['source_sha256']==sha256(src.read_bytes()).hexdigest(),module
            if 'olean_sha256' in pin:
                assert pin['olean_sha256']==sha256(obj.read_bytes()).hexdigest(),module
        direct=re.findall(r'^\s*(?:(?:public|private|meta)\s+)*import\s+([\w.]+)',src.read_text(encoding='utf8'),re.M)
        modules[module]=dict(source=src.relative_to(root).as_posix(),object=obj.relative_to(root).as_posix(),imports=direct)
        add('src/'+name+'.lean',src)
        add('lib/'+name+'.olean',obj)
        for side in obj.parent.glob(obj.name+'.*'):
            add('lib/'+name+'.olean'+side.name[len(obj.name):],side)
        for dep in direct:
            if dep not in external: visit(dep)
    for module in roots: visit(module)
    for i in range(1,7):
        tag=f'GoldbachBand{i:02d}'
        for suffix in ('Receipt.json','Fingerprints.json','Prefix.log'):
            add('receipts/'+tag+suffix,extension/(tag+suffix))
        pins=json.loads((extension/(tag+'Fingerprints.json')).read_bytes())
        for mod,pin in pins.items():
            assert sha256(entries['src/'+mod+'.lean'].read_bytes()).hexdigest()==pin['source'],mod
            assert sha256(entries['lib/'+mod+'.olean'].read_bytes()).hexdigest()==pin['object'],mod
    add('receipts/campaign-inputs.json',extension/'campaign-inputs.json')
    with ZipFile(root/'outputs/small-binary-goldbach-lean.zip') as z:
        for name in ['lean-toolchain','lake-manifest.json','lakefile.lean']:
            add('pins/'+name,z.read(name))
    out.mkdir(exist_ok=True)
    assert not list(out.glob('part-*.zip')),'Use an empty milestones directory.'
    hashes={}
    parts=[]
    part=None
    size=0
    try:
        for name,source in sorted(entries.items()):
            data=source if isinstance(source,bytes) else source.read_bytes()
            # Keep portable artifacts free of local user-directory strings.
            for marker in (b'C:\\Users\\',b'/home/',b'/mnt/host/c/Users/'):
                assert marker not in data,(name,marker)
            if part is None or size+len(data)>40*1024**2:
                if part: part.close()
                dest=out/f'part-{len(parts)+1:02d}.zip'
                parts.append(dest)
                part=ZipFile(dest,'x',compression=ZIP_DEFLATED,compresslevel=3)
                size=0
            part.writestr(name,data)
            hashes[name]=sha256(data).hexdigest()
            size+=len(data)
    finally:
        if part: part.close()
    report=dict(roots=roots,modules=modules,external_imports=sorted(external),files=hashes,
                archives={p.name:sha256(p.read_bytes()).hexdigest() for p in parts})
    (out/'manifest.json').write_text(json.dumps(report,indent=2)+'\n')
    print(len(modules),len(hashes),len(parts),sum(p.stat().st_size for p in parts))

if __name__=='__main__':
    main()
