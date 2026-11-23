"""One short high-height zeta contour, using FLINT 3.6.0 as external verifier.

This deliberately does NOT use the slow explicit Euler--Maclaurin acceptance
path of the low pilot, and does not certify any other height interval.
"""
from fractions import Fraction as F
from pathlib import Path
import hashlib, importlib.util, json
import flint

parent=Path(__file__).parent
module_path=parent/'finite_contour_pilot_2026_11_11.py'
spec=importlib.util.spec_from_file_location('finite_low_pilot', module_path)
pilot=importlib.util.module_from_spec(spec);spec.loader.exec_module(pilot)

def builtin(kind,s):
    assert kind=='zetaF'
    return (s-1)*s.zeta()

pilot.evaluate=builtin
result=pilot.contour('zetaF',F(2,3),F(40000000),F(40000000)+F(1,16),max_segments=20000)
out={'status':'PASS_EXTERNAL_FLINT_HIGH_CONTOUR_ONLY','flint_version':flint.__FLINT_VERSION__,
     'python_flint_version':flint.__version__,'precision_bits':flint.ctx.prec,
     'evaluator':'FLINT builtin zeta, not the explicit EM pilot evaluator',
     'script_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
     'contour_driver_sha256':hashlib.sha256(module_path.read_bytes()).hexdigest(),
     'result':result}
Path(__file__).with_suffix('.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps({**out,'result':{k:v for k,v in result.items() if k!='partition'}},indent=2))
