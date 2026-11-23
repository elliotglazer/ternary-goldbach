"""Exact postprocessing of saved bounds. No new panel evaluations."""
from pathlib import Path
from fractions import Fraction as F
import hashlib,json,sys

SOURCE=Path(__file__).with_name('c5_residual_width_ladder_20261111.json')
OUT=Path(__file__).with_suffix('.json')


def calculate():
    d=json.loads(SOURCE.read_text())
    assert d['panel_evaluations']==32 and d['full_rectangle_certified'] is False
    rows=[]
    for center in d['centers']:
        tests=[]
        for r in center['widths']:
            q1,q16=F(r['l1_upper']),F(r['T16_upper'])
            propagated=3*q1**32
            best=min(q16,propagated)
            tests.append({'half_width':r['half_width'],'l1_upper':str(q1),
              'raw_T16_upper':str(q16),'l1_implied_T16_upper':str(propagated),
              'best_T16_upper':str(best),'l1_pass':q1<1,'raw_T16_pass':q16<1,
              'best_T16_pass':best<1,
              'finite_g_Taylor_tail':r['finite_g_Taylor_tail'],
              'actual_L_minus_g_panel_bound':r['actual_L_minus_g_panel_bound'],
              'max_B_tail':str(max(map(F,r['rational_Taylor_tails']))),
              'max_residual_analytic_error':str(max(map(F,r['residual_analytic_errors'])))})
        rows.append({'attempt_index':center['attempt_index'],'tests':tests,
          'largest_l1_half_width':str(max(F(r['half_width']) for r in tests if r['l1_pass'])),
          'largest_raw_T16_half_width':str(max(F(r['half_width']) for r in tests if r['raw_T16_pass'])),
          'largest_best_T16_half_width':str(max(F(r['half_width']) for r in tests if r['best_T16_pass']))})
    return {'status':'EXACT_POSTPROCESSING_ONLY','new_panel_evaluations':0,
            'source_receipt_sha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),
            'formula':'T16 <= 3 * (l1_upper)^32, using exactly three primitive characters',
            'centers':rows}


if __name__=='__main__':
    result=calculate()
    if '--recompute' in sys.argv:assert json.loads(OUT.read_text())==result
    else:OUT.write_text(json.dumps(result,indent=2)+'\n')
    print(result['status'])
    for c in result['centers']:
        print(c['attempt_index'],c['largest_l1_half_width'],c['largest_raw_T16_half_width'],c['largest_best_T16_half_width'])
        for r in c['tests'][-3:]:
            print(r['half_width'],'Lerr',float(F(r['actual_L_minus_g_panel_bound'])),
                'Gtail',float(F(r['finite_g_Taylor_tail'])),
                'Btail',float(F(r['max_B_tail'])),'Rerr',float(F(r['max_residual_analytic_error'])))
