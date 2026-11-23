"""Preserve selected existing HOL4 exports. No prover is invoked."""
from hashlib import sha256
import json
from pathlib import Path
import re
from zipfile import ZIP_DEFLATED, ZipFile, ZipInfo

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
HOL = ROOT / 'work/backend-costs-20261112/hol-platt'
TEAM = ROOT / 'work/grh-goldbach-20261120/team'
SELECTED = {
    'archive-loader':'ArchiveLoader', 'sector-mask':'SectorMask SectorScan',
    'endpoint-export':'EndpointExport', 'endpoint-export-panel':'EndpointPanel',
    'guard-compact':'CompactRadii CompactSign SpectralNode Q131071Node',
    'source-log-real':'BernoulliPhase SourceLogTail TuringSchedule', 'phase-integral':'PhaseMass',
    'phase-bernoulli-kernel':'PeriodicKernel PeriodicMass ComplexRemainder',
    'full-height-count':'FullCount CountReceipt ShortGuard Rumely167 OffLinePair GuardChoice Width25Coverage',
    'large-terminal-signs':'RootSignChain RoundedHeight ZeroFreeGap CofactorNeighbourhood IsolatedCells',
    'strip-parameter-hol':'StripParameter StripParameterAcceptance',
    'fallback-score':'FallbackScore', 'dispatched-score':'DispatchedScore DispatchedFixture InclusiveBracket RepairAmplitude',
}
TEAM_SELECTED = {'q10004-short':'ActualSign PanelBatch PanelJoin PanelKernel PanelUnary ShortBatch ShortKernel ShortUnary',
                 'high-conductor-full/hol':'Q265800Receipt Q265800Scan',
                 'q10004-gaussian/hol':'Q10004Scan Q10004Receipt Q10004Window Q10004All Q10004Fused Q10004Project Q10004Compressed'}

def main():
    directories = {base/name: theories.split() for base,groups in ((HOL,SELECTED),(TEAM,TEAM_SELECTED)) for name,theories in groups.items()}
    index={}
    for family in (HOL,TEAM):
        for directory in family.iterdir():
            for where in (directory,directory/'hol'):
                for s in where.glob('*Script.sml'):
                    if (where/'.hol/objs'/(s.name[:-10]+'Theory.dat')).is_file():
                        index.setdefault(s.name[:-10],[]).append(where)
    queue=[(d,n) for d,ns in directories.items() for n in ns];seen=set();rows=[]
    pack=HERE/'selected-theories.zip'
    with ZipFile(pack,'w',compression=ZIP_DEFLATED,compresslevel=9) as z:
        while queue:
            d,n=queue.pop(0)
            if (d,n) in seen:continue
            seen.add((d,n));base=d/'.hol/objs';script=d/(n+'Script.sml')
            generated=(base/(n+'Theory.sml')).read_text(encoding='utf8')
            parents=sorted(set(re.findall(r'\blocal open (\w+)Theory in end',generated)))
            for parent in parents:
                candidates=index.get(parent,[])
                if d in candidates:queue.append((d,parent))
                elif len(candidates)==1:queue.append((candidates[0],parent))
            row=dict(theory=n,source=script.relative_to(ROOT).as_posix(),source_sha256=sha256(script.read_bytes()).hexdigest(),
                     selected=n in directories.get(d,[]),parents=parents,files={})
            for ext in ('dat','sig','sml'):
                f=base/(n+'Theory.'+ext);b=f.read_bytes();name=(d.relative_to(ROOT)/f.name).as_posix()
                entry=ZipInfo(name);entry.compress_type=ZIP_DEFLATED;z.writestr(entry,b,compresslevel=9)
                row['files'][name]=dict(bytes=len(b),sha256=sha256(b).hexdigest())
            rows.append(row)
    with ZipFile(pack) as z:
        for row in rows:
            for name,v in row['files'].items():assert sha256(z.read(name)).hexdigest()==v['sha256']
    meta=dict(hol_commit='1de64f8521b4758508bd875fbaf11d1768261b92',zip_sha256=sha256(pack.read_bytes()).hexdigest(),
              zip_bytes=pack.stat().st_size,theory_count=len(rows),selected=sum(r['selected'] for r in rows),
              uncompressed_bytes=sum(f['bytes'] for r in rows for f in r['files'].values()),theories=rows)
    (HERE/'manifest.json').write_text(json.dumps(meta,indent=2)+'\n',encoding='utf8')
    print({k:v for k,v in meta.items() if k!='theories'})

if __name__=='__main__':main()
