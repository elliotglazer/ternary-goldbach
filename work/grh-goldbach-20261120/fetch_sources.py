"""Pin small public source files. Never downloads the large GRH proof archive."""
from pathlib import Path
from urllib.request import Request, urlopen
import hashlib
import json

HERE = Path(__file__).resolve().parent
DEST = HERE / 'sources'
DEST.mkdir(exist_ok=True)

def get(url):
    with urlopen(Request(url, headers={'User-Agent': 'Goldbach-Lean-source-research'}), timeout=35) as r:
        return r.read()

records = []
def save(name, url):
    try:
        data = get(url)
        (DEST / name).write_bytes(data)
        records.append(dict(file=name, url=url, bytes=len(data), sha256=hashlib.sha256(data).hexdigest()))
    except Exception as exc:
        records.append(dict(file=name, url=url, error=str(exc)))

try:
    info = json.loads(get('https://api.github.com/repos/Deicyde/riemann-hypothesis/commits/main'))
    commit = info['sha']
    for name in ['src/Statements.lean', 'src/Main.lean', 'lean-toolchain', 'README.md']:
        save('grh-' + name.replace('/', '-'),
            'https://raw.githubusercontent.com/Deicyde/riemann-hypothesis/' + commit + '/' + name)
except Exception as exc:
    records.append(dict(source='GRH mirror commit pin', error=str(exc)))

save('detz1997.pdf', 'https://ir.cwi.nl/pub/1330/1330D.pdf')
save('schoenfeld1976.pdf', 'https://www.ams.org/journals/mcom/1976-30-134/S0025-5718-1976-0457374-X/S0025-5718-1976-0457374-X.pdf')
save('zinoviev-openalex.json', 'https://api.openalex.org/works/https://doi.org/10.1006/jnth.1997.2141')
(DEST / 'manifest.json').write_text(json.dumps(records, indent=2) + '\n', encoding='utf-8')
print(json.dumps(records, indent=2))
