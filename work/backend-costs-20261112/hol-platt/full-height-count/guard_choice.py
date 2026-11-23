"""Select the shortest passing archived guard for each fixed conductor, pair and T."""

from fractions import Fraction
from hashlib import sha256
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
TEAM = HERE.parents[2] / 'grh-goldbach-20261120' / 'team'
PANELS = [(10000, HERE), (10004, TEAM / 'q10004-gaussian'),
          (65536, TEAM / 'gaussian-panel-q65536'),
          (265800, TEAM / 'high-conductor-full')]


def selections(q, folder):
    raw = (folder / 'counts.json').read_bytes()
    panel = json.loads(raw)
    for pair, variants in panel['counts'].items():
        widths = sorted(variants['fixed'], key=lambda row: row['extra'])
        assert len({r['K'] for r in widths}) == 1
        assert len({r['extra'] for r in widths}) == len(widths)
        assert all(Fraction(r['allowance']['moderate']) == 18 for r in widths)
        margins = [(r['extra'], Fraction(r['exact_margin']['moderate'])) for r in widths]
        yield dict(q=q, T=panel['T'], labels=pair, K=widths[0]['K'],
                   strict=next((w for w, gap in margins if gap > 0), None),
                   with_proved_parity=next((w for w, gap in margins if gap > -1), None),
                   strict_margins={str(w): str(gap) for w, gap in margins},
                   source_sha256=sha256(raw).hexdigest())


if __name__ == '__main__':
    print(json.dumps([row for q, folder in PANELS for row in selections(q, folder)], indent=2))
