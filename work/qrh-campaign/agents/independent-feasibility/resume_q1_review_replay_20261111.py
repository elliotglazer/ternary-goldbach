"""Replay q1 scalar certificates without modifying producer artifacts."""
from pathlib import Path
from contextlib import redirect_stdout
from unittest.mock import patch
from fractions import Fraction as F
import hashlib, json

HERE=Path(__file__).resolve().parent
SRC=HERE.parent/'moebius'
write=Path.write_text
records={}
for stem in ['resume_q1_finite_budget','resume_q1_high_certificate']:
    source=SRC/(stem+'.py')
    saved=SRC/(stem+'.json')
    expected=saved.read_bytes()
    digest=hashlib.sha256(source.read_bytes()).hexdigest()
    output=HERE/(stem+'_independent_replay_20261111.json')
    def redirect(path, data, *args, **kwargs):
        assert path.resolve()==saved.resolve(), f'Unexpected producer write: {path}'
        return write(output, data, *args, **kwargs)
    namespace={'__file__':str(source),'__name__':'__independent_replay__'}
    with (HERE/(stem+'_independent_replay_20261111.log')).open('w',encoding='utf-8') as stream:
        with redirect_stdout(stream),patch.object(Path,'write_text',redirect):
            exec(compile(source.read_text(encoding='utf-8'),str(source),'exec'),namespace)
    assert json.loads(expected)==json.loads(output.read_bytes())
    assert saved.read_bytes()==expected
    records[stem]={'source_sha256':digest,'saved_sha256':hashlib.sha256(expected).hexdigest(),
                  'replay_matches_all_json_fields':True}
    if stem.endswith('high_certificate'):
        result=json.loads(output.read_bytes())
        for row in result['rows']:
            assert F(row['gap'])>0
            assert F(row['gap'])<=F(row['lower'])-F(row['upper'])+F(2,10**12)
        records[stem]['worst']=result['worst']
    print(stem,'PASS',flush=True)

# Independent scalar checks for variable-C monotonicity and q1 geometry.
assert F(3,6)+F(1,4)<1
assert F(8,1)*1200000/4 < 58000000/3
assert F(1200000,10**25)<F(1,2)
assert F(600000,49)*2==F(1200000,49)
records['scope']='Paper/scalar replay only; spectral input and analytic producers remain open.'
out=HERE/'resume_q1_review_replay_20261111.json'
write(out,json.dumps(records,indent=2)+'\n',encoding='utf-8')
print(json.dumps(records,indent=2))
