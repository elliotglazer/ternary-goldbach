import hashlib
import json
import re
from pathlib import Path
H=Path(__file__).resolve().parent
build=(H/'batchprime_build06.log').read_text()
assert 'HOL4_BATCH_PRIME_THEORY_DONE' in build
assert 'Exporting theory "BatchPrime" ... done.' in build
assert '\tExit status: 0' in (H/'batchprime_build06.time').read_text()
text=(H/'batch_probe02.log').read_text(encoding='utf-8')
assert 'BATCH_PRIME_GOOD_ACCEPTED' in text and 'BATCH_PRIME_PROBE_DONE' in text
assert re.search(r'Exception-|error:|Uncaught exception',text,re.I) is None
assert re.findall(r'BATCH_PRIME_REJECTED,([a-z_]+)',text)==[
    'bad_base','missing_factor','wrong_product','composite','self_reference']
axioms=set(re.search(r'BATCH_PRIME_AXIOMS,([^\r\n]+)',text)[1].split(';'))
assert axioms=={'bool.ETA_AX','bool.SELECT_AX','bool.INFINITY_AX','bool.BOOL_CASES_AX'}
assert '\tExit status: 0' in (H/'batch_probe02.time').read_text()
out=dict(passed=True,scope='Compiled generic batch-prime soundness, evaluator translation and three-prime probe only',
         probe_primes=[2,3,7],rejected_controls=5,axioms=sorted(axioms),
         full_fixture_measured=False,
         artifacts={name:hashlib.sha256((H/name).read_bytes()).hexdigest() for name in
             ('BatchPrimeScript.sml','.hol/objs/BatchPrimeTheory.dat','batch_probe.sml','batch_probe02.log')})
(H/'BATCH_PROBE_RESULTS.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(out))
