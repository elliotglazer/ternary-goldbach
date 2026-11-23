"""Check research packaging integrity only. This does not verify any proof."""
import ast
import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'outputs/qrh-blueprint'
manifest = json.loads((OUT / 'manifest.json').read_text(encoding='utf-8'))
recorded = {item['path'] for item in manifest['files']}
actual = {p.relative_to(OUT).as_posix() for p in OUT.rglob('*')
          if p.is_file() and p.name != 'manifest.json'}
assert recorded == actual
for item in manifest['files']:
    data = (OUT / item['path']).read_bytes()
    assert len(data) == item['bytes'], item['path']
    assert hashlib.sha256(data).hexdigest() == item['sha256'], item['path']

# Evaluate only the literal chapter-list expression from our local assembler.
tree = ast.parse((ROOT / 'work/qrh-blueprint/assemble.py').read_text(encoding='utf-8'))
assignment = next(n for n in tree.body if isinstance(n, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'CHAPTERS' for t in n.targets))
chapters = eval(compile(ast.Expression(assignment.value), '<chapter-list>', 'eval'),
                {'__builtins__': {}, 'ROOT': ROOT, 'AGENTS': ROOT / 'work/qrh-campaign/agents'})
for name, source in chapters:
    assert (OUT / 'chapters' / name).read_bytes() == source.read_bytes(), name

readme = (OUT / 'README.md').read_text(encoding='utf-8')
links = re.findall(r'\]\((chapters/[^)]+)\)', readme)
for link in links:
    assert (OUT / link).is_file(), link
assert {f'chapters/{name}' for name, _ in chapters} <= set(links)

graph = json.loads((OUT / 'dependencies.json').read_text(encoding='utf-8'))
seen = set()
for node in graph['nodes']:
    assert node['id'] not in seen
    assert set(node['depends_on']) <= seen, node
    seen.add(node['id'])
assert graph['kind'] == 'proposed research map, not an approved proof graph'
assert 'leanok' not in (OUT / 'blueprint/src/content.tex').read_text(encoding='utf-8')
print(json.dumps({'status': 'packaging integrity only; no proof validation',
                  'files': len(actual), 'source_matched_chapters': len(chapters),
                  'readme_chapter_links': len(links), 'research_nodes': len(seen)}))
