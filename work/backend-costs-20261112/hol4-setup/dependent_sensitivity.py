"""Arithmetic-only sensitivity. These are not complete TG cost estimates."""
from pathlib import Path
import hashlib
import json

home=Path(__file__).resolve().parent
result=json.loads((home/'DEPENDENT_RESULTS.json').read_text())
assert result['passed'] and result['exports_identical']
count=128941391789290+89858217607168
seconds_per_core_year=365.25*24*3600
rows=[]
for c in result['cases']:
    blocks=count/c['butterflies']
    setup=result['shared_literal_translation_cpu_median']
    rows.append({'depth':c['depth'],
                 'native_runtime_core_years':blocks*c['native_cpu_median']/seconds_per_core_year,
                 'hol_acceptance_core_years_without_literal_setup':
                     blocks*c['hol_cpu_median']/seconds_per_core_year,
                 'hol_literal_setup_and_acceptance_core_years_if_all_data_fresh_each_block':
                     blocks*(setup+c['hol_cpu_median'])/seconds_per_core_year})
out={'scope':'Illustrative small-family butterfly component ONLY, not a workload equivalence '
             'claim or full TG estimate. DependentBlock is not a certified FFT.',
     'count':count,'seconds_per_core_year':seconds_per_core_year,'scenarios':rows,
     'omitted':['Roots and coefficients generation/certification','Analytic source production',
                'Real-coordinate interpretation and global error propagation',
                'Additional small-family products/scales','Large-family branch',
                'Principal zeros and completeness','Finite Goldbach coverage',
                'Discovery/retries','Proof/library engineering','General setup, export and I/O'],
     'cautions':['Timing reuse requires the demonstrated named-input representation.',
                 'A real transform has different depth, permutations, memory and coefficients.',
                 'A fresh literal payload incurs substantial proved-translation cost.',
                 'No speed ratio transfers automatically to stock Lean, Candle or MM0.'],
     'measurement_sha256':hashlib.sha256((home/'DEPENDENT_RESULTS.json').read_bytes()).hexdigest()}
(home/'DEPENDENT_SENSITIVITY.json').write_text(json.dumps(out,indent=2)+'\n')
print(json.dumps(rows,indent=2))
