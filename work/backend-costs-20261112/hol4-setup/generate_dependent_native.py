"""Generate exact C++ fixture strings from the same pinned block data."""
from pathlib import Path
import hashlib
import json

home=Path(__file__).resolve().parent
data=json.loads((home/'dependent_fixture.json').read_text())

def array(name, xs):
    return ('const char* const '+name+'[][2]={\n'+
            ',\n'.join('{'+','.join(json.dumps(str(a)) for a in xy)+'}' for xy in xs)+'\n};\n')

lines=['const char* const scale_text='+json.dumps(data['scale'])+';\n',
       array('input_data',data['inputs']),
       array('coefficient_data',data['coefficients'])]
for c in data['cases']:
    lines.append(array('output_'+str(c['depth']),c['output']))
lines += ['struct Case {unsigned depth; const char* bound; const char* checksum; '
          'const char* const (*outputs)[2];};\nconst Case cases[]={\n',
          ',\n'.join('{'+str(c['depth'])+','+json.dumps(c['bound'])+','+
                     json.dumps(c['checksum'])+',output_'+str(c['depth'])+'}'
                     for c in data['cases']), '\n};\n']
(home/'dependent_data.hpp').write_text(''.join(lines),newline='\n')
(home/'dependent_native_fixture_pin.json').write_text(json.dumps({
    'fixture_sha256':hashlib.sha256((home/'dependent_fixture.json').read_bytes()).hexdigest(),
    'header_sha256':hashlib.sha256((home/'dependent_data.hpp').read_bytes()).hexdigest()},indent=2)+'\n')
print('Generated matching GMP fixture and exact full-vector reference outputs.')
