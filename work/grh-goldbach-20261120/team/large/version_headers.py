"""Add compatibility imports to precisely the files using a backported name."""

import re

from mertens_chunks import split_mertens


def replace_once(raw, old, new):
    old = old.encode()
    if raw.count(old) != 1:
        raise ValueError(f'Expected one source occurrence of {old!r}')
    return raw.replace(old, new.encode())


ADAPTERS = {
    'GoldbachDigamma': re.compile(rb'\bdigamma_apply_add_nat\b'),
    'GoldbachZetaConj': re.compile(rb'\bcompletedRiemannZeta_conj\b'),
    'GoldbachVersionAliases': re.compile(rb'\bite_eq_(?:left|right)\b'),
    'GoldbachDependentIfAlias': re.compile(rb'\bdite_eq_left\b'),
    'GoldbachFinsetProductAliases': re.compile(rb'\bprod_le_prod_of_subset_of_one_le'),
    'GoldbachOrderAndLogDeriv': re.compile(rb'\blogDeriv_(?:prod|mul)\b|\bprod_le_prod' + '₀'.encode()),
    'GoldbachExpSubstitution': re.compile(rb'\b(?:integrable|integral)_comp_exp\b'),
}


def with_version_imports(raw, module=None):
    if module == 'TernaryGoldbach.Prelim.SmallLogSq':
        raw = replace_once(raw, '  have hc : 1 ≤ l.count x :=',
            '  letI : BEq (ℕ × ℕ) := instBEqOfDecidableEq\n  have hc : 1 ≤ l.count x :=')
    if module == 'TernaryGoldbach.Explicit.WeilNumB':
        for conversion in ['    convert h1 using 1\n', '\n  convert h using 1\n',
                           '    convert h using 1\n']:
            raw = replace_once(raw, conversion, conversion.rstrip('\n') + ' <;> try rfl\n')
        raw = replace_once(raw, '  · funext v; simp only [PhiC, Pi.add_apply, Pi.sub_apply, Pi.neg_apply, Pi.mul_apply, Pi.pow_apply]\n', '')
    if module == 'TernaryGoldbach.Explicit.WeilNumA':
        raw = replace_once(raw, '    convert h2 using 1\n    unfold fz; field_simp',
                           '    convert h2 using 1 <;> first | rfl | (unfold fz; field_simp)')
    imports = [b'import ' + mod.encode() + b'\n' for mod,uses in ADAPTERS.items() if uses.search(raw)]
    if module == 'TernaryGoldbach.Prelim.SmallG':
        raw = replace_once(raw, 'theorem PL_chain : PL.IsChain', 'set_option maxRecDepth 100000 in\ntheorem PL_chain : PL.IsChain')
    if module == 'TernaryGoldbach.Prelim.RamareWalk':
        raw = replace_once(raw, 'theorem Inv_step ', 'set_option maxHeartbeats 800000 in\ntheorem Inv_step ')
    if module == 'TernaryGoldbach.Prelim.GaussInduced':
        old = 'by simp [ψ, ZMod.stdAddChar_apply]'.encode()
        if raw.count(old) != 1:
            raise ValueError('GaussInduced unit-circle proof differs from pinned source')
        raw = raw.replace(old, 'by simp [ψ, ZMod.stdAddChar_apply, Circle.norm_coe]'.encode())
    raw = raw.replace(b'Real.norm_fourier_le_integral_norm',
        'VectorFourier.norm_fourierIntegral_le_integral_norm 𝐞 volume (innerₗ ℝ)'.encode())
    if module == 'TernaryGoldbach.Prelim.PNTMertens':
        raw = replace_once(raw, 'import Mathlib.Analysis.SpecialFunctions.Integrability.Log\n',
                                'import Mathlib.Analysis.SpecialFunctions.Integrability.LogMeromorphic\n')
        raw = replace_once(raw, 'integrableOn_indicator_iff measurableSet_Ici.nullMeasurableSet',
                                'integrableOn_indicator_iff measurableSet_Ici')
    raw = raw.replace(b'memLp_indicator_iff_restrict measurableSet_Icc.nullMeasurableSet',
                      b'memLp_indicator_iff_restrict measurableSet_Icc')
    if module == 'TernaryGoldbach.MajorArcs.Eta2Moments':
        for following in ['have hs : 0 < √r', 'field_simp']:
            raw = replace_once(raw, '  convert this using 1\n  ' + following,
                               '  apply this.congr_deriv\n  ' + following)
        raw = replace_once(raw, 'convert this using 1; push_cast; ring',
                           'apply this.congr_deriv\n  push_cast\n  ring')
    if module == 'TernaryGoldbach.MinorArcs.TypeIINumerics':
        raw = replace_once(raw, '    convert h using 1\n    · funext s; simp [div_eq_mul_inv]\n    · field_simp; ring',
                           "    convert (config := { postTransparency := .default }) h using 1\n"
                           "    field_simp [ht.ne'] <;> ring")
    if module == 'TernaryGoldbach.MinorArcs.Eta2Fourier':
        raw = re.sub(rb'\bconvert (?=this\b|\(+hasDerivAt)', b'convert (config := { postTransparency := .default }) ', raw)
    if module == 'TernaryGoldbach.MinorArcs.TrigSums':
        raw = replace_once(raw, '    convert h using 1\n    field_simp\n    rw [← Real.sin_sq_add_cos_sq',
            '    apply h.congr_deriv\n    field_simp\n    rw [← Real.sin_sq_add_cos_sq')
        for suffix, arg, target, cast in (
            ('(hτ (q - 1 - k))', 'k + 1', '↑k + 1 / 2 - s', True),
            ('(hτ (q - 1 - (1 + i)))', 'i + 2', '3 / 2 - s + ↑i', True),
            ('(hτ (2 + i))', '2 + i', '3 / 2 + s + ↑i', False)):
            step = 'rw [hcast]; ' if cast else ''
            sign = '-' if cast else '+'
            raw = replace_once(raw, suffix + '\n      ' + step + 'convert this using 2; push_cast; ring',
                suffix + '\n      have he : ((' + arg + ' : ℕ) : ℝ) - 1 / 2 ' + sign + ' s = ' + target +
                ' := by push_cast; ring\n      rw [he] at this\n      ' +
                ('rwa [hcast]' if cast else 'exact this'))
        raw = re.sub(rb'(?m)^  convert (?=\(+hasDerivAt_)',
                     b'  convert (config := { postTransparency := .default }) ', raw)
    if module == 'TernaryGoldbach.Prelim.SmallPsiTable':
        raw = replace_once(raw, '(n ∈ P1000 ↔ isPrimeSlow n = true) := by decide +kernel',
            '(n ∈ P1000 ↔ isPrimeSlow n = true) := by\n'
            '  have h : P1000 = (List.range 1001).filter isPrimeSlow := by decide +kernel\n'
            '  intro n hn\n  rw [h, List.mem_filter]\n  exact and_iff_right hn')
    if module == 'TernaryGoldbach.Prelim.SmallNonprime':
        # Keep positivity and linarith from unfolding the entire table T at n.
        start = raw.index(b'theorem block_ok {')
        split = raw.index('  refine (nonprime_le_T hn).trans_lt'.encode(), start)
        body = raw.index('  have hn0 :'.encode(), split)
        end = raw.index(b'\n\n', body)
        algebra = raw[body:end].replace(b'T n', b'x').replace(b'T c', b'y')
        helper = """private theorem block_sqrt_bound {a n : ℕ} (x y : ℕ)
    (hblk : y ^ 2 * 10 ^ 8 < 203404644 * a * 10 ^ 18) (hT : x ≤ y)
    (han : a ≤ n) (ha : 1 ≤ a) : (x : ℝ) / 10 ^ 9 < 1.4262 * √n := by
""".encode()
        proof = '  exact (nonprime_le_T hn).trans_lt (block_sqrt_bound (T n) (T c) hblk (T_mono hnc) han ha)'.encode()
        raw = raw[:start] + helper + algebra + b'\n\n' + raw[start:split] + proof + raw[end:]
    if module == 'TernaryGoldbach.Prelim.SmallMertensLower':
        raw = split_mertens(raw)
    if module == 'TernaryGoldbach.Explicit.ZeroSumBound':
        raw = replace_once(raw, '      convert this using 3; push_cast; ring',
            '      have he : (2 : ℝ) * (0.1 * (u - u0)) = 0.2 * (u - u0) := by ring\n'
            '      push_cast at this\n      rwa [he] at this')
    if module == 'TernaryGoldbach.Explicit.GrExtend':
        raw = replace_once(raw, '/-- **Uniform bound on',
                           'set_option maxHeartbeats 600000 in\n/-- **Uniform bound on')
        raw = replace_once(raw,
            '    have := Real.rpow_nonneg (by linarith : (0:ℝ) ≤ c / 4) (-(1 / 4 : ℝ))\n'
            '    have := Real.rpow_nonneg (by linarith : (0:ℝ) ≤ c / 4) (-(3 / 2 : ℝ))\n    positivity',
            '    have hc4 : 0 ≤ c / 4 := div_nonneg hc0.le (by norm_num)\n'
            '    have half : (0 : ℝ) ≤ 1 / 2 := by norm_num\n'
            "    exact add_nonneg (mul_nonneg (mul_nonneg (Real.rpow_nonneg hc4 _) half) hG14')\n"
            "      (mul_nonneg (mul_nonneg (Real.rpow_nonneg hc4 _) half) hG32')")
    if module == 'TernaryGoldbach.Explicit.Xi':
        raw = replace_once(raw,
            '    convert this using 1\n    · rfl\n    · rw [show (1 : ℂ) - 1 / 2 = 1 / 2 by norm_num]; ring',
            '    convert (config := { postTransparency := .default }) this using 1\n'
            '    rw [show (1 : ℂ) - 1 / 2 = 1 / 2 by norm_num]; ring')
        marker = '  have hp0 : (π : ℂ) ^ (-s / 2) ≠ 0 := by'
        raw = replace_once(raw, marker,
            '  have hcomp : logDeriv (fun w : ℂ => Complex.Gamma (w / 2)) s =\n'
            '      1 / 2 * Complex.digamma (s / 2) := by\n'
            '    change logDeriv (Complex.Gamma ∘ fun w : ℂ => w / 2) s = _\n'
            '    rw [logDeriv_comp (f := Complex.Gamma) (g := fun w : ℂ => w / 2) (x := s)\n'
            '      (differentiableAt_Gamma _ hm) hd2.differentiableAt, hd2.deriv, Complex.digamma_def]\n'
            '    exact mul_comm _ _\n' + marker)
        raw = replace_once(raw, 'hd2.logDeriv_Gamma hm, logDeriv_apply', 'hcomp, logDeriv_apply')
    if module == 'TernaryGoldbach.Explicit.GaussSmooth':
        raw = replace_once(raw, '      convert this using 1; ring)',
                           '      convert (config := { postTransparency := .default }) this using 1 <;> ring)')
    if module == 'TernaryGoldbach.Helfgott.HHBound':
        raw = replace_once(raw, '    convert this using 1\n    · rfl\n    · simp\n',
                           '    convert this using 1 <;> simp\n')
    if module in ('TernaryGoldbach.MinorArcs.FourierSums','TernaryGoldbach.Helfgott.HHBound'):
        raw = raw.replace(b'convert this using 1',b'convert (config := { postTransparency := .default }) this using 1')
    if module == 'TernaryGoldbach.Explicit.Digamma':
        for needle, assumption in (('have h := (h1.exp.neg).div_const u', 'hu'),
                                   ('have h := (h1.cos.neg).div_const L', 'hL')):
            raw = replace_once(raw, needle + '\n    convert h using 1\n    field_simp',
                needle + '\n    apply h.congr_deriv\n    field_simp [' + assumption + '] <;> ring')
        raw = replace_once(raw, 'have hd := (Complex.hasDerivAt_Gamma_of_re_pos hs0).deriv',
            'have heq : Complex.Gamma =ᶠ[𝓝 s] Complex.GammaIntegral := by\n'
            '    have ho : IsOpen {z : ℂ | 0 < z.re} := Complex.continuous_re.isOpen_preimage _ isOpen_Ioi\n'
            '    filter_upwards [ho.mem_nhds hs0] with z hz using Complex.Gamma_eq_integral hz\n'
            '  have hd := heq.deriv_eq.trans (Complex.hasDerivAt_GammaIntegral hs0).deriv')
        raw = replace_once(raw, 'convert h using 1\n    field_simp\n    push_cast; ring',
            "apply h.congr_deriv\n    dsimp\n    field_simp [hp.ne'] <;> ring")
        raw = replace_once(raw, '  congr 2\n  field_simp\n',
            "  congr 2\n  rw [add_div, div_self ha.ne']\n")
    terms = {
        'TernaryGoldbach.Explicit.RectResidue': (
            ('S', 'i', 'F i (φ t)', '        '),
            ('Z', 'u', '((divB f c R u).toNat : ℂ) * (h (φ t) * (φ t - u)⁻¹)', '      ')),
        'TernaryGoldbach.Explicit.RectResidue2': (
            ('Z', 'u', '((divB f c R u).toNat : ℂ) * (u - p)⁻¹ * (φ t - u)⁻¹', '      '),),
    }
    if module in terms:
        # Lean 4.33 convert descends into the norm instance of IntervalIntegrable.
        # Change only the integrand, using extensional equality of the functions.
        original = raw.decode()
        for ident, index, summand, indent in terms[module]:
            needle = indent + 'convert this using 1\n' + indent + 'ext t; simp [Finset.sum_apply]'
            replacement = (
                f'{indent}have heq : (fun t : ℝ => ∑ {index} ∈ {ident}, {summand}) =\n'
                f'{indent}    ∑ {index} ∈ {ident}, (fun t : ℝ => {summand}) := by\n'
                f'{indent}  ext t\n{indent}  simp only [Finset.sum_apply]\n'
                f'{indent}rw [heq]\n{indent}exact this'
            )
            if original.count('\n' + needle + '\n') != 1:
                raise ValueError('RectResidue integrand proof differs from pinned source')
            original = original.replace('\n' + needle + '\n', '\n' + replacement + '\n')
        raw = original.encode()
    return b''.join(reversed(imports)) + raw
