"""Write explicit propositions/proof scripts from untrusted rational candidates."""
from pathlib import Path
import json
here=Path(__file__).resolve().parent
rows=json.loads((here/'input_centers.json').read_text())['rows']
lines=['import FiniteInputs','import Mathlib.Tactic.FinCases','noncomputable section',
       'open Complex','namespace SpectralPilot','']
for row in rows:
    n,k,re,im=(row[x] for x in ['n','k','real_numerator','imag_numerator'])
    lines += [f'def rounded{n} : ℂ := ({re} : ℂ) / 1048576 + Complex.I * ({im} / 1048576)',
      f'lemma round{n}_error : ‖powerCenter {n} {k} - rounded{n}‖ ≤ (1 / 1048576 : ℝ) := by',
      '  apply (Complex.norm_le_abs_re_add_abs_im _).trans',
      f'  norm_num [rounded{n}, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,',
      '    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,',
      '    Complex.normSq, pow_succ]',
      f'lemma input{n}_error : ‖({n} : ℂ) ^ (-sampleS) - rounded{n}‖ ≤ (1 / 500000 : ℝ) := by',
      f'  have hp := powerCenter_error (n := {n}) (k := {k}) (by norm_num) (by norm_num)',
      '    (by norm_num) (by norm_num) (by norm_num)',
      f'  have ht := norm_sub_le_norm_sub_add_norm_sub (({n} : ℂ) ^ (-sampleS))',
      f'    (powerCenter {n} {k}) rounded{n}',
      f'  linarith [round{n}_error]','']
lines += ['def roundedInput (j : Fin 8) : ℂ :=',
          '  !['+', '.join('rounded'+str(r['n']) for r in rows)+'] j','',
          'lemma roundedInput_error (j : Fin 8) :',
          '    ‖((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) - roundedInput j‖ ≤ (1 / 500000 : ℝ) := by',
          '  fin_cases j']
for row in rows:
    lines += [f'  · simpa [roundedInput] using input{row["n"]}_error']
lines += ['','end SpectralPilot','']
with (here/'RoundedInputs.lean').open('x',encoding='utf8') as f: f.write('\n'.join(lines))
print('Wrote eight explicit source-connected rounding certificates; Lean verification required.')
