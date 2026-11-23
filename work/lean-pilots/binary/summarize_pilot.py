from pathlib import Path
import hashlib,json

HERE=Path(__file__).resolve().parent
manifest=json.loads((HERE/'pilot_manifest.json').read_text())
runs=[]
for p in sorted(HERE.glob('run-*.json')):
    row=json.loads(p.read_text());row['receipt']=p.name
    row['log']=p.with_suffix('.log').name;runs.append(row)
required=['BinarySupport.lean','PilotPrimes.lean','BinaryPilot.lean','CompleteBinaryPilot.lean',
          'CompleteBinaryPilot.olean','ImportBaseline.lean','Audit.lean','CorruptCoverage.lean',
          'generate_pilot.py','assemble_complete.py','run_lean.py','pilot_manifest.json','lean-help.txt','lean-version.txt']
files={n:{'bytes':(HERE/n).stat().st_size,'sha256':hashlib.sha256((HERE/n).read_bytes()).hexdigest().upper()} for n in required}
for n in ['BinarySupport.lean','PilotPrimes.lean','BinaryPilot.lean','CompleteBinaryPilot.lean']:
    src=(HERE/n).read_text(encoding='utf-8')
    assert not any(t in src for t in ['sorry','native_decide','decide +native','maxHeartbeats','maxRecDepth','axiom '])
roots=manifest['prime_roots'];anchors=[x['anchor'] for x in manifest['sources']]
sources=sorted(set(p for x in manifest['sources'] for p in x['primes']))
out={'scope':'Complete internal high-end finite binary pilot, not full range or forecast',
     'target':{'lower':manifest['origin'],'upper':manifest['upper'],'even_count':64,'tiles':2,'width':32},
     'provenance':{k:manifest[k] for k in ['fixture_sha256','pratt_fixture_sha256','word_id']},
     'data':{'anchors':len(anchors),'unique_source_primes':len(sources),
             'source_positive_occurrences':sum(len(x['primes']) for x in manifest['sources']),
             'prime_roots':len(roots),'pratt_nodes':len(manifest['pratt_nodes']),
             'new_pratt_nodes':len(manifest['new_pratt_nodes']),
             'anchor_bit_range':[min(p.bit_length() for p in anchors),max(p.bit_length() for p in anchors)],
             'source_bit_range':[min(p.bit_length() for p in sources),max(p.bit_length() for p in sources)]},
     'generator':{k:manifest[k] for k in ['generation_wall_seconds','generation_cpu_seconds']},
     'runs':runs,'files':files,
     'limitations':['One fixed fixture, no all-range success evidence','No source/anchor search timing',
       'No standalone kernel-only time separated from elaboration','Strict imported-library overhead included',
       'No peak-memory trace','No extrapolation of 64-target average to full range']}
(HERE/'results.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({'data':out['data'],'files':{n:files[n] for n in ['CompleteBinaryPilot.lean','CompleteBinaryPilot.olean']},
                 'runs':[(x['command'][-1],x['exit'],x['wall_seconds'],x['process_cpu_seconds']) for x in runs]},indent=2))
