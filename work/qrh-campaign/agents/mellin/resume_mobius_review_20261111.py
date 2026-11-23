"""Independent audit harness: replay author arithmetic, add endpoint/domain checks.

No Lean and no source mutations. All output is written next to this harness.
"""
from pathlib import Path
import hashlib, json

HERE = Path(__file__).resolve().parent
author = HERE.parent / 'integration' / 'resume_mobius_input_20261111.py'
code = author.read_text(encoding='utf-8')
code = code.replace(
    "return [(v,g['lo_cert'](v),g['up_cert'](v)) for v in pts]",
    "assert pts[0] == 10**9 and pts[-1] == A\n"
    "        assert all(10**9 <= v <= A for v in pts)\n"
    "        assert all(v < w for v,w in zip(pts,pts[1:]))\n"
    "        return [(v,g['lo_cert'](v),g['up_cert'](v)) for v in pts]")
code = code.replace(
    "for idx,(A,B,Y) in enumerate(pieces,1):",
    "assert len(pieces) == 214\n"
    "    assert all(a[1] == b[0] for a,b in zip(pieces,pieces[1:]))\n"
    "    assert sum(B == 10**9 for A,B,Y in pieces) == 1\n"
    "    assert sum(A == 10**9 for A,B,Y in pieces) == 1\n"
    "    assert all(12 <= Y <= 10**6 for A,B,Y in pieces)\n"
    "    for idx,(A,B,Y) in enumerate(pieces,1):")
code = code.replace(
    "ub=g['up_cert'](B)",
    "assert g['endC'](cs) == A\n"
    "        assert I >= 0 and S >= 0 and d['eta'] >= 0 and d['nu'] >= 0\n"
    "        ll=d['L']; dd=F(B-A,B); xx=Xnew(cs,d)\n"
    "        assert ll > 1 and xx >= 0 and 1-1/ll-dd/ll**2 > 0\n"
    "        assert xx+(626+I)/A+d['nu']*dd/ll**2 <= d['nu']*(1-1/ll)\n"
    "        assert d['nu']/ll+(626+I)/A+d['nu']*dd/ll**2 <= d['eta']\n"
    "        assert I+d['nu']*F(B-A)/ll**2 <= d['I2']\n"
    "        ub=g['up_cert'](B)")
code = code.replace(
    "assert worst<F('.10')",
    "assert g['logLo'](F('160.54'),TT) and g['logUp'](F('160.55'),TT)\n"
    "        assert worst<F('.10')")
old_output = "(HERE/'resume_mobius_input_20261111.json').write_text(json.dumps(result,indent=2)+'\\n')"
assert old_output in code
code = code.replace(old_output, "")
namespace = {'__file__':str(author), '__name__':'__audit__'}
exec(compile(code,str(author)+':audited-replay','exec'),namespace)
result = namespace['result']
expected = json.loads(author.with_suffix('.json').read_text(encoding='utf-8'))
assert result == expected, 'Replay differs from frozen author JSON'
F=namespace['F']; L=namespace['L']; cuts=namespace['cuts']
assert all(0 < c <= 1 for c in cuts)
assert all(c < d for c,d in zip(cuts,cuts[1:]))
assert cuts[0]*L >= 28
assert F('131.25')+F('.18')*L+F('1e-9') <= L
assert F('.82')*L-F('.6933') > 0
assert F('.36')*L-F('13.8155') > 0
out={'author_script_sha256':hashlib.sha256(author.read_bytes()).hexdigest(),
     'author_json_sha256':hashlib.sha256(author.with_suffix('.json').read_bytes()).hexdigest(),
     'replay_matches_author_json':True,'added_domain_checks':True,'result':result}
(HERE/'resume_mobius_review_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
print('AUDIT PASS: exact replay agrees; all 214 cells and terminal/domain checks passed.')
