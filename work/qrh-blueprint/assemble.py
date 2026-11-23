"""Assemble the research deliverable. This does not run Lean."""
from pathlib import Path
from hashlib import sha256
import json
import shutil
import html
import markdown

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / 'outputs/qrh-blueprint'
AGENTS = ROOT / 'work/qrh-campaign/agents'
CHAPTERS = [
    ('00-scope.md', ROOT / 'work/qrh-blueprint/CORE.md'),
    ('01-provider.md', AGENTS / 'integration/BLUEPRINT_QRH_PROVIDER.md'),
    ('02-principal.md', AGENTS / 'mellin/BLUEPRINT_PRINCIPAL.md'),
    ('03-averages.md', AGENTS / 'major-constants/BLUEPRINT_AVERAGES.md'),
    ('04-mixed-moment.md', AGENTS / 'zero-sum/BLUEPRINT_MIXED_MOMENT.md'),
    ('05-prime-estimates.md', AGENTS / 'prime-estimates/BLUEPRINT_PRIME_ESTIMATES.md'),
    ('06-minor-finite.md', AGENTS / 'moebius/BLUEPRINT_MINOR_FINITE.md'),
    ('07-statement-audit.md', AGENTS / 'audit/BLUEPRINT_REQUIREMENTS.md'),
    ('08-independent-review.md', AGENTS / 'independent-feasibility/BLUEPRINT_STRATEGY_REVIEW.md'),
    ('09-certificate-plan.md', AGENTS / 'mellin/FORMAL_CERTIFICATE_PLAN.md'),
    ('10-minor-update.md', ROOT / 'work/qrh-blueprint/MINOR_UPDATE.md'),
    ('11-energy-qrh.md', AGENTS / 'mellin/MINOR_ENERGY_QRH.md'),
    ('12-energy-tolerance.md', AGENTS / 'major-constants/MINOR_ENERGY_TOLERANCE.md'),
    ('13-prime-power-error.md', AGENTS / 'moebius/EBOUND_UNCONDITIONAL.md'),
    ('14-minor-review.md', AGENTS / 'audit/MINOR_REPLACEMENT_AUDIT.md'),
    ('15-minor-interfaces.md', AGENTS / 'integration/MINOR_INTERFACE_MAP.md'),
    ('16-scalar-energy-review.md', AGENTS / 'independent-feasibility/SCALAR_ENERGY_CHECK.md'),
    ('17-compute-estimates.md', ROOT / 'work/qrh-blueprint/COMPUTE_ESTIMATE.md'),
    ('18-base-gap.md', AGENTS / 'zero-sum/BASE_GAP_QRH.md'),
    ('19-energy-alternative.md', AGENTS / 'independent-feasibility/MINOR_ENERGY_UNCONDITIONAL.md'),
    ('20-base-gap-update.md', ROOT / 'work/qrh-blueprint/BASE_GAP_UPDATE.md'),
    ('21-base-gap-budget.md', AGENTS / 'major-constants/BASE_GAP_VARIABLE_BUDGET.md'),
    ('22-base-gap-direct.md', AGENTS / 'independent-feasibility/BASE_GAP_ALTERNATIVES.md'),
    ('23-base-gap-hybrid.md', AGENTS / 'mellin/BASE_GAP_HYBRID.md'),
    ('24-base-gap-typeii.md', AGENTS / 'moebius/BASE_GAP_TYPEII.md'),
    ('25-family-detector.md', AGENTS / 'zero-sum/FAMILY_DETECTOR_TEST.md'),
    ('26-base-gap-review.md', AGENTS / 'audit/BASE_GAP_REVIEW.md'),
    ('27-family-detector-review.md', AGENTS / 'integration/FAMILY_DETECTOR_REVIEW.md'),
    ('28-direct-branch-review.md', AGENTS / 'audit/BASE_GAP_DIRECT_REVIEW.md'),
    ('29-base-gap-classifier.md', ROOT / 'work/qrh-blueprint/BASE_GAP_CLASSIFIER.md'),
    ('30-base-gap-binned.md', AGENTS / 'major-constants/BASE_GAP_BINNED.md'),
    ('31-base-gap-raw.md', AGENTS / 'moebius/BASE_GAP_RAW_COMPARISON.md'),
    ('32-base-gap-stationary.md', AGENTS / 'mellin/BASE_GAP_STATIONARY.md'),
    ('33-smooth-conductors.md', AGENTS / 'zero-sum/BASE_GAP_SMOOTH_CONDUCTORS.md'),
    ('34-global-totient.md', AGENTS / 'independent-feasibility/GLOBAL_TOTIENT_ROUTE.md'),
    ('35-typeii-inputs.md', AGENTS / 'integration/TYPEII_REMAINING_INPUTS.md'),
    ('36-classifier-review.md', AGENTS / 'audit/BASE_GAP_CLASSIFIER_REVIEW.md'),
    ('37-totient-power.md', ROOT / 'work/qrh-blueprint/TOTIENT_POWER_BOUND.md'),
    ('38-totient-update.md', ROOT / 'work/qrh-blueprint/TOTIENT_UPDATE.md'),
    ('39-totient-finite-review.md', AGENTS / 'integration/GLOBAL_TOTIENT_FINITE_REVIEW.md'),
    ('40-totient-tail.md', AGENTS / 'independent-feasibility/GLOBAL_TOTIENT_TAIL.md'),
    ('41-totient-tail-review.md', AGENTS / 'zero-sum/GLOBAL_TOTIENT_TAIL_REVIEW.md'),
    ('42-typeii-totient.md', AGENTS / 'independent-feasibility/TYPEII_TOTIENT.md'),
    ('43-second-choice-weak.md', AGENTS / 'independent-feasibility/SECOND_CHOICE_WEAK_TOTIENT.md'),
    ('44-base-gap-q1.md', AGENTS / 'mellin/BASE_GAP_Q1_ALTERNATIVE.md'),
    ('45-base-gap-parameters.md', AGENTS / 'moebius/BASE_GAP_90090_PARAMETERS.md'),
    ('46-base-gap-small-rectangle.md', AGENTS / 'major-constants/BASE_GAP_90090_CERTIFICATE.md'),
    ('47-raw-tangent-review.md', AGENTS / 'audit/RAW_TANGENT_REVIEW.md'),
    ('48-upper-principal.md', AGENTS / 'mellin/MAJOR_UPPER_PRINCIPAL.md'),
    ('49-region-s-elementary.md', ROOT / 'work/qrh-blueprint/REGION_S_ELEMENTARY.md'),
    ('50-resumed-status.md', ROOT / 'work/qrh-blueprint/RESUME_STATUS_2026-11-11.md'),
    ('51-resumed-audit.md', AGENTS / 'audit/RESUME_AUDIT_2026-11-11.md'),
    ('52-pointwise-totient-complete.md', AGENTS / 'independent-feasibility/RESUME_STRATEGY_2026-11-11.md'),
    ('53-provider-reconciliation.md', AGENTS / 'integration/RESUME_PROVIDER_2026-11-11.md'),
    ('54-prime-power-complete.md', AGENTS / 'prime-estimates/RESUME_PRIMES_2026-11-11.md'),
    ('55-prime-totient-review.md', AGENTS / 'audit/RESUME_REPAIRS_REVIEW_2026-11-11.md'),
    ('56-small-twist-all-scales.md', AGENTS / 'moebius/RESUME_MINOR_2026-11-11.md'),
    ('57-translated-zero-mass.md', AGENTS / 'mellin/RESUME_PRINCIPAL_2026-11-11.md'),
    ('58-conductor-mixed-operator.md', AGENTS / 'zero-sum/RESUME_MIXED_2026-11-11.md'),
    ('59-all-scale-and-principal-review.md', AGENTS / 'audit/RESUME_MINOR_REVIEW_2026-11-11.md'),
    ('60-hybrid-spectral-certificate.md', AGENTS / 'independent-feasibility/RESUME_HYBRID_CERTIFICATE_2026-11-11.md'),
    ('61-harmonic-lambda-upper.md', AGENTS / 'prime-estimates/RESUME_PRIME_NEXT_2026-11-11.md'),
    ('62-harmonic-lambda-review.md', AGENTS / 'zero-sum/RESUME_P2_REVIEW_2026-11-11.md'),
    ('63-principal-source-review.md', AGENTS / 'integration/RESUME_PRINCIPAL_REVIEW_2026-11-11.md'),
    ('64-mixed-operator-review.md', AGENTS / 'audit/RESUME_MIXED_REVIEW_2026-11-11.md'),
    ('65-conductor-three-finite-task.md', AGENTS / 'major-constants/RESUME_MAJOR_2026-11-11.md'),
    ('66-conductor-three-review.md', AGENTS / 'audit/RESUME_MAJOR_REVIEW_2026-11-11.md'),
    ('67-hybrid-tail-review.md', AGENTS / 'mellin/RESUME_HYBRID_REVIEW_2026-11-11.md'),
    ('68-implementation-order.md', AGENTS / 'integration/RESUME_IMPLEMENTATION_ORDER_2026-11-11.md'),
    ('69-middle-twist-all-scales.md', AGENTS / 'moebius/RESUME_MIDDLE_2026-11-11.md'),
    ('70-current-strategy.md', ROOT / 'work/qrh-blueprint/CURRENT_STRATEGY.md'),
    ('71-middle-twist-review.md', AGENTS / 'audit/RESUME_MIDDLE_REVIEW_2026-11-11.md'),
    ('72-finite-contour-pilot.md', AGENTS / 'independent-feasibility/RESUME_FINITE_PILOT_2026-11-11.md'),
    ('73-harmonic-lambda-lower-review.md', AGENTS / 'mellin/RESUME_P3_REVIEW_2026-11-11.md'),
    ('74-harmonic-lambda-lower.md', AGENTS / 'prime-estimates/RESUME_P3_2026-11-11.md'),
    ('75-prime-envelope-assembly.md', ROOT / 'work/qrh-blueprint/PRIME_ENVELOPE_ASSEMBLY.md'),
    ('76-prime-envelope-review.md', AGENTS / 'prime-estimates/RESUME_ENVELOPE_ASSEMBLY_REVIEW_2026-11-11.md'),
    ('77-mobius-shared-input.md', AGENTS / 'integration/RESUME_MOBIUS_INPUT_2026-11-11.md'),
    ('78-mobius-shared-input-review.md', AGENTS / 'mellin/RESUME_MOBIUS_REVIEW_2026-11-11.md'),
    ('79-full-family-second-moments.md', AGENTS / 'major-constants/RESUME_FAMILY_CAPS_2026-11-11.md'),
    ('80-full-family-mixed.md', AGENTS / 'zero-sum/RESUME_FAMILY_MIXED_2026-11-11.md'),
    ('81-full-family-review.md', AGENTS / 'audit/RESUME_FAMILY_REVIEW_2026-11-11.md'),
    ('82-denominator-rectangle.md', AGENTS / 'moebius/RESUME_COVERAGE_EXTENSION_2026-11-11.md'),
    ('83-denominator-rectangle-review.md', AGENTS / 'audit/RESUME_COVERAGE_REVIEW_2026-11-11.md'),
    ('84-smaller-heights-and-lower-energy.md', AGENTS / 'major-constants/RESUME_CUTOFF_OPTIMIZATION_2026-11-11.md'),
    ('85-cutoff-and-lower-energy-review.md', AGENTS / 'mellin/RESUME_CUTOFF_REVIEW_2026-11-11.md'),
    ('86-psi-from-finite-strip.md', AGENTS / 'integration/RESUME_PSI_FROM_FINITE_STRIP_2026-11-11.md'),
    ('87-psi-strip-review.md', AGENTS / 'independent-feasibility/RESUME_PSI_STRIP_REVIEW_2026-11-11.md'),
    ('88-finite-prime-gap-design.md', AGENTS / 'prime-estimates/RESUME_PSI_FINITE_GAP_2026-11-11.md'),
    ('89-finite-prime-gap-review.md', AGENTS / 'integration/RESUME_PSI_GAP_REVIEW_2026-11-11.md'),
    ('90-weighted-spectral-alternative.md', AGENTS / 'zero-sum/RESUME_WEIGHTED_CERTIFICATE_2026-11-11.md'),
    ('91-weighted-spectral-review.md', AGENTS / 'major-constants/RESUME_WEIGHTED_REVIEW_2026-11-11.md'),
    ('92-q1-hybrid.md', AGENTS / 'moebius/RESUME_Q1_GAP_2026-11-11.md'),
    ('93-q1-hybrid-review.md', AGENTS / 'independent-feasibility/RESUME_Q1_FINITE_REVIEW_2026-11-11.md'),
    ('94-base-gap-finite-family.md', AGENTS / 'zero-sum/RESUME_BASE_GAP_FINITE_FAMILY_2026-11-11.md'),
    ('95-base-gap-family-review.md', AGENTS / 'audit/RESUME_BASE_GAP_FAMILY_REVIEW_2026-11-11.md'),
    ('96-small-q-high.md', AGENTS / 'moebius/RESUME_SMALL_Q_HIGH_2026-11-11.md'),
    ('97-small-q-high-review.md', AGENTS / 'independent-feasibility/RESUME_SMALL_Q_HIGH_REVIEW_2026-11-11.md'),
    ('98-low-zeta-psi-refinement.md', AGENTS / 'mellin/RESUME_PSI_LOW_ZERO_REFINEMENT_2026-11-11.md'),
    ('99-low-zeta-psi-review.md', AGENTS / 'major-constants/RESUME_PSI_LOW_REVIEW_2026-11-11.md'),
    ('100-selected-closure-audit.md', AGENTS / 'integration/RESUME_SELECTED_CLOSURE_AUDIT_2026-11-11.md'),
    ('101-full-base-gap-join-review.md', AGENTS / 'audit/RESUME_FULL_BASE_GAP_JOIN_REVIEW_2026-11-11.md'),
    ('102-short-prime-gap-pilot.md', AGENTS / 'prime-estimates/RESUME_PSI_SHORT_GAP_2026-11-11.md'),
    ('103-short-prime-gap-review.md', AGENTS / 'moebius/RESUME_PSI_SHORT_GAP_REVIEW_2026-11-11.md'),
    ('104-checkpoint-review.md', AGENTS / 'audit/RESUME_SYNTHESIS_104_REVIEW_2026-11-11.md'),
    ('105-follow-on-research.md', ROOT / 'work/qrh-blueprint/POST_104_RESEARCH.md'),
    ('106-base-gap-interface-ledger.md', AGENTS / 'integration/RESUME_BASE_GAP_INTERFACE_LEDGER_2026-11-11.md'),
    ('107-base-gap-interface-review.md', AGENTS / 'audit/RESUME_BASE_GAP_INTERFACE_REVIEW_2026-11-11.md'),
    ('108-platt-domain-comparison.md', AGENTS / 'major-constants/PLATT_DOMAIN_COMPARISON_2026-11-11.md'),
    ('109-platt-domain-review.md', AGENTS / 'moebius/PLATT_DOMAIN_COMPARISON_REVIEW_2026-11-11.md'),
    ('110-spectral-certificate-strategy.md', AGENTS / 'zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_2026-11-11.md'),
    ('111-spectral-strategy-erratum.md', AGENTS / 'zero-sum/RESUME_SPECTRAL_CERTIFICATE_STRATEGY_ERRATUM_2026-11-11.md'),
    ('112-spectral-strategy-review.md', AGENTS / 'moebius/SPECTRAL_CERTIFICATE_STRATEGY_REVIEW_2026-11-11.md'),
    ('113-multi32-prime-pilot.md', AGENTS / 'prime-estimates/RESUME_PSI_MULTI32_2026-11-11.md'),
    ('114-multi32-prime-review.md', AGENTS / 'independent-feasibility/REVIEW_PSI_MULTI32_NEW_2026-11-11.md'),
    ('115-prime-checkpoint-stress.md', AGENTS / 'prime-estimates/RESUME_PSI_STRESS512_2026-11-11.md'),
    ('116-relaxed-prime-checkpoint.md', AGENTS / 'prime-estimates/RESUME_PSI_RELAXED_CHECKPOINT_2026-11-11.md'),
    ('117-stress-repair-review.md', AGENTS / 'audit/RESUME_PSI_STRESS_REPAIR_REVIEW_2026-11-11.md'),
    ('118-low-zeta-spectral-leaf.md', AGENTS / 'mellin/RESUME_PSI_SPECTRAL_LEAF_2026-11-11.md'),
    ('119-low-zeta-spectral-review.md', AGENTS / 'integration/RESUME_PSI_SPECTRAL_LEAF_REVIEW_2026-11-11.md'),
    ('120-common-height-major.md', AGENTS / 'major-constants/RESUME_COMMON_HEIGHT_MAJOR_2026-11-11.md'),
    ('121-common-height-review.md', AGENTS / 'independent-feasibility/REVIEW_COMMON_HEIGHT_NEW_2026-11-11.md'),
    ('122-full-prime-candidate.md', AGENTS / 'prime-estimates/RESUME_PSI_FULL_CANDIDATE_2026-11-11.md'),
    ('123-full-prime-protocol-review.md', AGENTS / 'audit/RESUME_PSI_FULL_PROTOCOL_REVIEW_2026-11-11.md'),
    ('124-full-prime-recount-review.md', AGENTS / 'audit/RESUME_PSI_FULL_RECOUNT_REVIEW_2026-11-11.md'),
    ('125-c3-contour-pilot.md', AGENTS / 'zero-sum/C3_RIGHT_RECTANGLE_PILOT_2026-11-11.md'),
    ('126-c3-contour-review.md', AGENTS / 'moebius/C3_RIGHT_RECTANGLE_REVIEW_2026-11-11.md'),
    ('127-analytic-zeta-count.md', AGENTS / 'mellin/RESUME_PSI_ANALYTIC_COUNT_2026-11-11.md'),
    ('128-analytic-zeta-count-review.md', AGENTS / 'major-constants/RESUME_PSI_ANALYTIC_COUNT_REVIEW_2026-11-11.md'),
    ('129-zeta14-certificate.md', AGENTS / 'zero-sum/ZETA14_RECTANGLE_CERTIFICATE_2026-11-11.md'),
    ('130-zeta14-review.md', AGENTS / 'moebius/ZETA14_RECTANGLE_REVIEW_2026-11-11.md'),
]
OUT.mkdir(parents=True, exist_ok=True)
(OUT / 'chapters').mkdir(exist_ok=True)
for name, source in CHAPTERS:
    shutil.copyfile(source, OUT / 'chapters' / name)

README = (ROOT / 'work/qrh-blueprint/OVERVIEW.md').read_text(encoding='utf-8')
README += '\n\n## Research archive\n\n'
for i, (name, source) in enumerate(CHAPTERS, 1):
    lines = source.read_text(encoding='utf-8-sig').splitlines()
    title = next((line.lstrip('# ').strip() for line in lines if line.startswith('# ')), name)
    README += f'{i}. [{title}](chapters/{name})\n'
README += '\nThe chapters retain source-relative workspace references. Their exact bytes and all copied evidence are pinned in manifest.json.\n'
(OUT / 'README.md').write_text(README, encoding='utf-8')
shutil.copyfile(AGENTS / 'audit/check_blueprint_budget.py', OUT / 'check_blueprint_budget.py')
(OUT / 'evidence').mkdir(exist_ok=True)
for source in [AGENTS/'mellin/minor_energy_constants.py',
               AGENTS/'major-constants/minor_energy_tolerance.py',
               AGENTS/'moebius/ebound_rational_audit.py',
               AGENTS/'major-constants/base_gap_variable_budget.py',
               ROOT/'work/qrh-campaign/base_gap_direct_audit.py',
               ROOT/'work/qrh-campaign/base_gap_classifier.py',
               ROOT/'work/qrh-campaign/base_gap_classifier.json',
               AGENTS/'major-constants/base_gap_binned.py',
               AGENTS/'major-constants/base_gap_binned_results.json',
               AGENTS/'moebius/base_gap_raw_comparison.py',
               AGENTS/'moebius/base_gap_raw_comparison_results.json',
               AGENTS/'zero-sum/base_gap_smooth_conductors.py',
               AGENTS/'zero-sum/base_gap_smooth_conductors.csv',
               AGENTS/'zero-sum/smooth_conductor_certificates.py',
               AGENTS/'audit/check_base_gap_classifier.py',
               AGENTS/'audit/replay_base_gap_binned.py',
               AGENTS/'major-constants/base_gap_coverage_counts.py',
               AGENTS/'major-constants/base_gap_coverage_counts.json',
               ROOT/'work/qrh-campaign/totient_second_budget.py',
               AGENTS/'independent-feasibility/second_choice_weak_totient_check.ps1',
               AGENTS/'independent-feasibility/global_totient_tail_check.ps1',
               AGENTS/'mellin/base_gap_q1_pnt_constants.py',
               AGENTS/'major-constants/base_gap_90090_certificate.py',
               AGENTS/'major-constants/base_gap_90090_certificate.json',
               AGENTS/'major-constants/base_gap_raw_tangent.py',
               ROOT/'work/qrh-campaign/region_s_finite.py',
               ROOT/'work/qrh-campaign/region_s_finite.json',
               ROOT/'work/qrh-campaign/region_s_rational.py',
               ROOT/'work/qrh-campaign/region_s_rational.json',
               AGENTS/'independent-feasibility/resume_totient_check_2026_11_11.py',
               AGENTS/'prime-estimates/resume_primes_20261111_cert.py',
               AGENTS/'moebius/resume_minor_allscale_certificate.py',
               AGENTS/'moebius/resume_minor_allscale_certificate.json',
               AGENTS/'mellin/resume_principal_20261111_constants.py',
               AGENTS/'integration/RESUME_EVIDENCE_2026-11-11.json',
               AGENTS/'integration/RESUME_ALTERNATIVE_PROVIDERS_2026-11-11.json',
               AGENTS/'integration/RESUME_PLATT_OCCURRENCES_2026-11-11.txt',
               AGENTS/'zero-sum/resume_mixed_operator_20261111.py',
               AGENTS/'zero-sum/resume_mixed_operator_20261111.json',
               AGENTS/'independent-feasibility/hybrid_tail_check_2026_11_11.py',
               AGENTS/'prime-estimates/resume_prime_next_20261111_cert.py',
               AGENTS/'major-constants/resume_major_c3_20261111.py',
               AGENTS/'major-constants/resume_major_c3_20261111.json',
               AGENTS/'moebius/resume_middle_certificate.py',
               AGENTS/'moebius/resume_middle_certificate.json',
               ROOT/'work/qrh-campaign/base_gap_coverage_2026_11_11.py',
               ROOT/'work/qrh-campaign/base_gap_coverage_2026_11_11.json',
               AGENTS/'independent-feasibility/finite_contour_pilot_2026_11_11.py',
               AGENTS/'independent-feasibility/finite_contour_pilot_2026_11_11.json',
               AGENTS/'independent-feasibility/finite_high_pilot_2026_11_11.py',
               AGENTS/'independent-feasibility/finite_high_pilot_2026_11_11.json',
               AGENTS/'prime-estimates/resume_p3_exact_kernel_20261111.json',
               AGENTS/'mellin/resume_p3_review_exact_20261111.py',
               AGENTS/'prime-estimates/resume_p3_verify_20261111.py',
               AGENTS/'prime-estimates/resume_p3_log_certificate_20261111.json',
               ROOT/'work/qrh-campaign/prime_envelope_assembly.py',
               AGENTS/'integration/resume_mobius_input_20261111.py',
               AGENTS/'integration/resume_mobius_input_20261111.json',
               AGENTS/'mellin/resume_mobius_review_20261111.py',
               AGENTS/'mellin/resume_mobius_review_20261111.json',
               AGENTS/'major-constants/resume_family_caps_20261111.py',
               AGENTS/'major-constants/resume_family_caps_20261111.json',
               AGENTS/'zero-sum/resume_family_mixed_20261111.py',
               AGENTS/'zero-sum/resume_family_mixed_20261111.json',
               AGENTS/'moebius/resume_coverage_wide_certificate.py',
               AGENTS/'moebius/resume_coverage_wide_certificate.json',
               ROOT/'work/qrh-campaign/base_gap_wide_union_2026_11_11.py',
               ROOT/'work/qrh-campaign/base_gap_wide_union_2026_11_11.json',
               AGENTS/'major-constants/resume_cutoff_optimization_20261111.py',
               AGENTS/'major-constants/resume_cutoff_optimization_20261111.json',
               AGENTS/'mellin/resume_cutoff_review_20261111.py',
               AGENTS/'integration/resume_psi_finite_strip_20261111.py',
               AGENTS/'integration/resume_psi_finite_strip_20261111.json',
               AGENTS/'independent-feasibility/resume_psi_strip_audit_20261111.py',
               AGENTS/'prime-estimates/resume_psi_finite_gap_20261111.py',
               AGENTS/'prime-estimates/resume_psi_finite_gap_20261111.json',
               AGENTS/'integration/resume_psi_gap_review_20261111.py',
               AGENTS/'integration/resume_psi_gap_review_20261111.json',
               AGENTS/'zero-sum/resume_weighted_certificate_20261111.py',
               AGENTS/'zero-sum/resume_weighted_certificate_20261111.json',
               AGENTS/'moebius/resume_q1_finite_budget.py',
               AGENTS/'moebius/resume_q1_finite_budget.json',
               AGENTS/'moebius/resume_q1_high_certificate.py',
               AGENTS/'moebius/resume_q1_high_certificate.json',
               AGENTS/'zero-sum/resume_base_gap_finite_family_20261111.py',
               AGENTS/'zero-sum/resume_base_gap_finite_family_20261111.json',
               AGENTS/'moebius/resume_small_q_high_certificate.py',
               AGENTS/'moebius/resume_small_q_high_certificate.json',
               ROOT/'work/qrh-campaign/base_gap_full_join_2026_11_11.py',
               ROOT/'work/qrh-campaign/base_gap_full_join_2026_11_11.json',
               AGENTS/'mellin/resume_psi_low_zero_refinement_20261111.py',
               AGENTS/'mellin/resume_psi_low_zero_refinement_20261111.json',
               AGENTS/'prime-estimates/resume_psi_short_gap_20261111.py',
               AGENTS/'prime-estimates/resume_psi_short_gap_20261111.json',
               AGENTS/'moebius/resume_psi_short_gap_review_20261111.py',
               AGENTS/'moebius/resume_psi_short_gap_review_20261111.json']:
    shutil.copyfile(source, OUT/'evidence'/source.name)

# Frozen follow-on arithmetic and contour artifacts. These are external
# evidence copies; the scripts still document their original workspace paths.
extra_artifacts = {
    'prime-estimates': ['resume_psi_multi32_20261111', 'resume_psi_stress512_20261111',
                       'resume_psi_relaxed_checkpoint_20261111',
                       'resume_psi_full_candidate_20261111',
                       'resume_psi_full_candidate_validate_20261111',
                       'resume_psi_full_candidate_validation_20261111'],
    'independent-feasibility': ['review_psi_multi32_new_20261111', 'review_common_height_new_20261111'],
    'major-constants': ['platt_domain_comparison_20261111', 'resume_common_height_major_20261111',
                        'review_psi_analytic_count_20261111'],
    'moebius': ['platt_domain_review_20261111', 'spectral_strategy_review_20261111',
                'c3_rectangle_review_20261111', 'zeta14_rectangle_review_20261111'],
    'zero-sum': ['resume_spectral_strategy_20261111', 'c3_right_rectangle_20261111',
                 'c3_right_rectangle_checks_20261111', 'zeta14_right_rectangle_20261111'],
    'mellin': ['resume_psi_spectral_leaf_20261111', 'resume_psi_analytic_count_20261111'],
    'audit': ['resume_psi_stress_repair_review_20261111', 'resume_psi_full_protocol_review_20261111',
               'resume_psi_independent_full_recount_20261111'],
}
for folder, stems in extra_artifacts.items():
    for stem in stems:
        matches = [p for p in (AGENTS/folder).glob(stem+'*')
                   if p.is_file() and p.suffix in {'.py', '.json', '.csv'}]
        assert matches, (folder, stem)
        for source in matches:
            shutil.copyfile(source, OUT/'evidence'/source.name)
for source in [AGENTS/'prime-estimates/psi_full_candidate_20261111',
               AGENTS/'audit/psi_independent_full_recount_20261111']:
    assert (source/'COMPLETE.json').is_file(), source
    assert not any('ERROR' in p.name or 'STOPPED' in p.name or p.suffix=='.tmp'
                   for p in source.iterdir()), source
    shutil.copytree(source, OUT/'evidence'/source.name, dirs_exist_ok=True)

# A deliberately coarse research map. Detailed mathematical edges are in chapters.
nodes = [
    ('provider', 'Validate global seven-eighths QRH', []),
    ('strip', 'Actual zero carriers and multiplicities', ['provider']),
    ('mass', 'Positive zeta zero mass at two', []),
    ('smoothing', 'Actual etaPlus versus compact smoothing', []),
    ('finite_spectral', 'Prove finite beta<=.555 through min(old Hp,1e8/c) for the entire active primitive family', []),
    ('zeta_low_strip', 'Prove zeta strip (.499,.501) through 1e6 and replay the height14 exclusion', []),
    ('zeta_head', 'Prove complete positive-ordinate reciprocal head Q1500<=2', []),
    ('zeta_count', 'Formalize reviewed analytic N(t)<=F(t)+5 log(t)+20 for t>=1500', []),
    ('low_zeta_moment', 'Prove W35<24 from the narrow strip, head and analytic count', ['zeta_low_strip','zeta_head','zeta_count']),
    ('moment_bridges', 'Actual-smoothing Gram and explicit-formula bridges', ['smoothing']),
    ('family_moments', 'Reviewed finite-strip implication for all upper and mixed caps', ['strip','finite_spectral','moment_bridges']),
    ('certificate', 'Rational replay of quartet kernel bounds', ['smoothing']),
    ('principal', 'Local principal L2 error <= 8e-6 via q1 Ep restriction', ['family_moments']),
    ('lower_j', 'Lower major energy >= 8.6296 via weighted reverse Minkowski', ['family_moments']),
    ('upper_j', 'Upper major energy <= 10', ['family_moments']),
    ('averages', 'Coprime Aplus and Astar contributions', ['family_moments']),
    ('cross', 'Coprime same-modulus Cross contribution', ['family_moments']),
    ('major', 'Major lower contribution >= 1.0404', ['upper_j','averages','cross']),
    ('elementary_producers', 'Reviewed P2/P3/P6 and finite table repairs', []),
    ('psi_finite_gap', 'Kernel-replay complete candidate data and prove finite psi envelope on [1e9,5e9]', ['elementary_producers']),
    ('psi_tail', 'Prove refined Gaussian-sandwich bound from 5e9', ['strip','finite_spectral','low_zeta_moment']),
    ('prime_envelope', 'Prove abs(psiN(v)-v)<=.01 v/log(v) for all integer v>=1e9', ['psi_finite_gap','psi_tail']),
    ('prime', 'All-range psi, theta, and Lambda inputs', ['prime_envelope','elementary_producers']),
    ('mobius', 'Relaxed Mobius profile and direct Liouville inputs', ['prime']),
    ('mertens', 'Mertens window and totient inputs', ['strip','prime']),
    ('minor_energy', 'Relaxed minor smoothed energy <= .65 x log x', ['strip','mass']),
    ('base_gap', 'Reviewed full-domain etaStar base-gap implication', ['strip','finite_spectral','moment_bridges','prime','mobius','mertens']),
    ('prime_power', 'Prime-power and small-prime energy', []),
    ('off_arcs', 'Pointwise off-larger-arcs bound from Type I/II and global totient', ['prime','mobius','mertens']),
    ('quotient_sieve', 'Integrated quotient large sieve including separate LSQuot3 totient use', ['prime','mertens']),
    ('minor', 'Minor absolute contribution <= 1.0376', ['lower_j','off_arcs','quotient_sieve','minor_energy','base_gap','prime_power']),
    ('nonprime', 'Nonprime reserve < .00271', []),
    ('large', 'Ternary Goldbach from 10^27', ['major','minor','nonprime']),
    ('finite', 'Ternary Goldbach up to 10^27 from retained binary input', []),
    ('full', 'Original statement with only BinaryGoldbachInput', ['large','finite']),
]
ids = {n[0] for n in nodes}
seen = set()
for key, title, deps in nodes:
    assert set(deps) <= seen, (key, deps)
    seen.add(key)
dependency_data = {'kind':'proposed research map, not an approved proof graph',
    'nodes':[{'id':k,'title':t,'depends_on':d,'status':'existing conditional source' if k=='finite' else 'research obligation'} for k,t,d in nodes]}
dependency_data['alternative_routes'] = [{
    'target':'prime_envelope',
    'source':'chapters/86-psi-from-finite-strip.md',
    'status':'older reviewed conditional exp35 route; long finite gap data remain absent',
    'requires':['principal finite .555 through60343058','global7/8','analytic bridges','85721 long-gap checkpoint counts and replay']
}, {
    'target':'principal',
    'source':'chapters/02-principal.md',
    'status':'historical independent local route; not required by selected finite-family branch',
    'requires':['strip','mass','certificate']
}, {
    'target':'quotient_sieve',
    'source':'chapters/49-region-s-elementary.md',
    'status':'paper route reviewed; exact external rational checks; uncompiled',
    'replaces':['prime','mertens'],
    'requires':['Mathlib elementary Chebyshev bound',
                'Euler-product logarithmic-moment estimate',
                'finite lambda and theta certificate replay',
                'existing finite Mertens certificate and exact source adapters']
}]
dependency_data['producer_frontier'] = {
    'scope': 'Source-level research status; no newly compiled producer is claimed',
    'P6': {'status':'complete independently reviewed paper replacement',
           'domain':'every real y>0', 'constant':'1.4262',
           'source':'chapters/54-prime-power-complete.md',
           'review':'chapters/55-prime-totient-review.md'},
    'P1_P4_P5_P7': {'status':'reviewed reduction to unproved shared envelope E plus P6 and finite tables',
                    'source':'chapters/75-prime-envelope-assembly.md',
                    'review':'chapters/76-prime-envelope-review.md',
                    'finite_table_subrange':'strict y<1e9; original lower domains retained',
                    'conditional_conclusion':'all original source domains, if E and reviewed repairs are proved'},
    'P2': {'status':'complete independently reviewed paper replacement',
           'domain':'every real x>=1',
           'source':'chapters/61-harmonic-lambda-upper.md',
           'review':'chapters/62-harmonic-lambda-review.md'},
    'P3': {'status':'complete independently reviewed paper replacement',
           'domain':'integer N>=1 with log(N+1); real x>=1',
           'review':'chapters/73-harmonic-lambda-lower-review.md'},
    'M1_M2': {'status':'reviewed conditional .03/.10 profile from E; E and downstream adapters remain obligations',
              'source':'chapters/77-mobius-shared-input.md',
              'review':'chapters/78-mobius-shared-input-review.md'},
    'R1_consumers': {'status':'reviewed paper repairs; unrestricted R1 not proved',
                     'source':'chapters/52-pointwise-totient-complete.md',
                     'review':'chapters/55-prime-totient-review.md'},
    'regionS': {'status':'separate reviewed paper repair',
                'source':'chapters/49-region-s-elementary.md'},
    'base_gap_q90090': {'status':'reviewed conditional all-scale, all permitted twists',
                        'u_interval':['1200000/49','1200000'],
                        'source':'chapters/69-middle-twist-all-scales.md',
                        'review':'chapters/71-middle-twist-review.md',
                        'conditional_covered_count':73579},
    'base_gap_wide_rectangle': {'status':'historical direct route; reviewed conditional all-scale and all permitted twists',
                                'q_interval':[90090,100000],
                                'source':'chapters/82-denominator-rectangle.md',
                                'review':'chapters/83-denominator-rectangle-review.md',
                                'new_denominators':5063,
                                'conditional_covered_count':78642,
                                'remaining_count':71358},
    'base_gap_full_domain': {'status':'complete reviewed conditional paper coverage; spectral and producer inputs unproved',
                            'primary_profile':'uniform finite beta<=111/200 through min(old Hp,1e8/c)',
                            'source':'chapters/94-base-gap-finite-family.md',
                            'review':'chapters/95-base-gap-family-review.md',
                            'high_branch_review':'chapters/97-small-q-high-review.md',
                            'q1_review':'chapters/93-q1-hybrid-review.md',
                            'join_review':'chapters/101-full-base-gap-join-review.md',
                            'minimum_height_review':'chapters/112-spectral-strategy-review.md',
                            'conditional_covered_count':150000,
                            'remaining_uncovered_denominators':0},
    'principal_upper_alternative': {'status':'alternative finite nonvanishing task remains unproved',
                        'sufficient_beta':'2/3', 'height':40000000,
                        'source':'chapters/57-translated-zero-mass.md'},
    'full_family': {'status':'reviewed conditional implication; finite spectral assertion unproved',
                    'sufficient_beta':'111/200',
                    'height':'min(old Hp(c),100000000/c)',
                    'primitive_character_count':5543640188,
                    'source':'chapters/120-common-height-major.md',
                    'review':'chapters/121-common-height-review.md'},
    'lower_j': {'status':'reviewed consequence of selected family Ep; no separate local kernel needed',
                'source':'chapters/84-smaller-heights-and-lower-energy.md',
                'review':'chapters/85-cutoff-and-lower-energy-review.md'},
    'psi_tail': {'status':'selected reviewed conditional deduction; additional low-zeta contract and analytic bridges require proofs',
                 'domain':'x>=5000000000', 'coefficient':'.00981',
                 'source':'chapters/98-low-zeta-psi-refinement.md',
                 'review':'chapters/99-low-zeta-psi-review.md'},
    'psi_finite_gap': {'status':'all candidate data generated and independently recounted; formal count and recurrence replay remain open',
                      'integer_interval':[1000000000,5000000000],
                      'total_window_counts':6439,
                      'missing_window_counts':0,
                      'subcounts':125271,
                      'lean_count_proofs':0,
                      'source':'chapters/122-full-prime-candidate.md',
                      'review':'chapters/124-full-prime-recount-review.md',
                      'interpolation_review':'chapters/117-stress-repair-review.md'},
    'psi_short_gap_selected': {'status':'selected route; complete external finite data; extra spectral contract still unproved',
                                  'requires':'additional complete zeta strip [.49,.51] and weighted reciprocal moment <=24 through height1e6, plus selected original inputs',
                                  'integer_interval':[1000000000,5000000000],
                                  'total_window_counts':6439,
                                  'externally_counted_windows':6439,
                                  'missing_external_window_counts':0,
                                  'source':'chapters/122-full-prime-candidate.md',
                                  'review':'chapters/124-full-prime-recount-review.md',
                                  'analytic_source':'chapters/98-low-zeta-psi-refinement.md',
                                  'analytic_review':'chapters/99-low-zeta-psi-review.md'},
    'low_zeta_moment': {'status':'reviewed analytic implication; narrow-strip and head certificates remain absent; height14 externally certified only',
                       'analytic_count':'N(t)<=F(t)+5log(t)+20 for t>=1500',
                       'moment_upper': '23.990',
                       'review':'chapters/128-analytic-zeta-count-review.md',
                       'height14_review':'chapters/130-zeta14-review.md'},
    'mixed': {'status':'genuine fourth-moment and revised minimum-height remainder implication reviewed; finite .555 input unproved',
              'operator_squared_norm_upper':25,
              'mixed_remainder_norm_upper':'.000160001',
              'source':'chapters/120-common-height-major.md',
              'review':'chapters/121-common-height-review.md'}
}
(OUT/'dependencies.json').write_text(json.dumps(dependency_data, indent=2)+'\n', encoding='utf-8')

tex = OUT / 'blueprint/src'
(tex / 'macros').mkdir(parents=True, exist_ok=True)
(tex / 'macros/common.tex').write_text(r'''\newtheorem{theorem}{Proposed theorem}[chapter]
\newtheorem{definition}[theorem]{Definition}
\newcommand{\R}{\mathbb R}
\newcommand{\C}{\mathbb C}
\newcommand{\NN}{\mathbb N}
''', encoding='utf-8')
(tex / 'macros/print.tex').write_text(r'''\newcommand{\uses}[1]{\par\smallskip\noindent\textit{Research dependencies: }\texttt{\detokenize{#1}}\par}
\newcommand{\notready}{\par\noindent\textbf{Research obligation; not formalized.}\par}
''', encoding='utf-8')
for kind in ('print', 'web'):
    extras = '\\input{macros/print}\n' if kind=='print' else '\\usepackage{blueprint}\n'
    (tex/f'{kind}.tex').write_text(r'''\documentclass{report}
\usepackage[T1]{fontenc}
\usepackage{amsmath,amssymb,amsthm,hyperref}
\input{macros/common}
'''+extras+r'''\title{QRH replacement: research blueprint}
\author{Eight-agent research and coordinating review}
\date{November 2026}
\begin{document}
\maketitle
\tableofcontents
\input{content}
\end{document}
''', encoding='utf-8')
CONTENT = r'''\chapter{Scope and conventions}
This outline targets the original ternary Goldbach statement in
\texttt{calr3/ternary-goldbach}, commit
\texttt{23b2d68ca344203d4384e0aff7affa4ec034bef9}.
The endpoint is $10^{27}$. The only retained mathematical premise is binary
Goldbach through $4\cdot10^{18}$. The QRH theorem must be supplied by a checked proof.
Every proposed theorem below is an obligation, not a formalization claim.
The detailed mathematical definitions, existing Lean identifiers, proof sketches,
and reviews are in the numbered Markdown chapters accompanying this outline.
This is not a frozen declaration manifest.

Set $x_0=4.9\cdot10^{26}$ and $\kappa=49$. For an odd $N\ge10^{27}$ let
\[d=2+\frac{9}{196\sqrt{2\pi}},\qquad x=N/d.\]
The source supplies $x\ge x_0$. All major, minor, and final error coefficients
below are in units $x^2/49$. We retain the actual source smoothing functions,
arc sets, coprime corrections, and character Gauss weights.

\chapter{Provider and full-family finite spectral route}
\begin{theorem}[Actual zero strip]\label{strip}\notready
Every nontrivial zeta zero has real part in $[1/8,7/8]$.
The corresponding primitive-character zero statement must be transferred
to the exact finite zero carriers and multiplicities of the explicit formula.
\end{theorem}
\begin{proof}[Research route]
Validate the pinned global seven-eighths provider, then use the functional
equation and prove the nonvanishing of the auxiliary factors. The global
provider is present as source; its 2,943-module closure has not been checked here.
The smaller $23/24$ provider is insufficient for this statement.
See chapters 01 and 02.
\end{proof}

\begin{theorem}[Positive weighted mass]\label{mass}\notready
For each relevant finite zeta zero rectangle, with source multiplicity $m_\rho$,
\[\sum_\rho m_\rho\frac{2-\Re\rho}{(2-\Re\rho)^2+(\Im\rho)^2}\le .07.\]
\end{theorem}
\begin{proof}[Research route]
Use positive real parts in the finite partial-fraction approximation at $2$.
The required bound on $\Re(\xi'/\xi)(2)$ has a reviewed, uncompiled draft using
333 prime-power terms through 2000. See chapters 02 and 05.
\end{proof}

\begin{theorem}[Actual smoothing comparison]\label{smoothing}\notready
For $t>0$, the source actual smoothing and compact model satisfy
\[|\eta_+(t)-\eta_O(t)|\le .00221t e^{-t^2/2}.\]
\end{theorem}
\begin{proof}[Research route]
Extract the weighted Fourier energy bound $368$, apply Cauchy--Schwarz at
bandlimit $200$, and supply Fourier inversion for the actual functions.
Retain the full Gaussian remainder. See chapter 02.
\end{proof}

\begin{theorem}[Finite spectral obligation]\label{finitespectral}\notready
For every Gauss-active primitive character of conductor $c$, every actual
nontrivial zero with $|\gamma|\le H_{\rm cert}(c)$ has $\beta\le111/200$, where
\[D_c=1200000/\widetilde c,\quad
 H_{+,\rm old}(c)=\lceil200+\max(1000,(704/7)D_c)\rceil,\]
\[H_{\rm cert}(c)=\min(H_{+,\rm old}(c),100000000/c).\]
Here $\widetilde c=2c$ for odd $c$, and $c$ otherwise. Retain the complete
active family and true multiplicities. This assertion is unproved.
\end{theorem}
\begin{proof}[Research route]
Supply finite nonvanishing/completeness certificates for the actual
L-functions. The global seven-eighths theorem alone does not prove this
finite condition. Chapters 120--121 give the revised major-tail implication;
chapters 110--112 check the separate base-gap height containment.
The conductor-three pilot in chapters 125--126 reaches requested height32
only, not its production height.
\end{proof}

\begin{theorem}[Full-family moment implication]\label{familymoments}\notready
The finite spectral obligation, global QRH and the actual-smoothing
analytic bridges imply, at every $x\ge x_0$, the coprime residual caps
$A'_+<5\cdot10^{-7}$ and $A'_*+\mathrm{Cross}'<9.5\cdot10^{-7}$,
the nonprincipal cap $\mathcal N<1.23$, and
$\sqrt{E_p}<.00020001$.
\end{theorem}
\begin{proof}[Reviewed conditional research implication]\uses{strip,smoothing,finitespectral}
Use actual Gram row bounds 23000 and $49\cdot102000$, source Jensen
counts, and exact Gauss weights. Genuine fourth moments give
$I_{\rm low}<10^{-8}$; the induction operator has squared norm below25.
Retain those hereditary positive low-set envelopes at the smaller cutoffs.
The new Fourier L1 split and exact Gauss-weighted tail aggregation give
full mixed remainder norm below $.000160001$ without assuming $J\le10$.
Chapters 120--121 give this revised proof and independent review.
The old $2\cdot10^{-10}$ allowance does not apply to this profile.
The etaU explicit formula, Gram/inversion bridges and finite certificate
remain proof obligations. This conditional implication is never a new
premise of the final Goldbach statement.
\end{proof}

\begin{theorem}[Quartet kernel certificate]\label{quartet}\notready
For $x\ge x_0$ and a quartet representative $\rho=\beta+i\gamma$ with
$1/2\le\beta\le7/8$ and $\gamma\ge0$, the normalized local
$L^2([-4,4])$ contribution of its conjugation/reflection quartet is at most
$85$ times its positive mass,
after extracting $x^{-1/8}$ as specified in chapter 02.
\end{theorem}
\begin{proof}[Alternative local route, not required by the selected family route]\uses{smoothing}
The external interval run has 2,750 passing cells, maximum $83.571300906<85$.
Analytic bounds cover the remaining height ranges. Replace the external
Arb computation with a proved rational interval checker and moment-defect
quadrature. The complete replay design is chapter 09. This external
certificate is evidence for the proposed inequality, not a Lean proof.
\end{proof}

\begin{theorem}[Local principal error]\label{principal}\notready
For the actual smoothing and all $x\ge x_0$,
\[\int_{-4}^4\left|S_{\eta_+}(\delta/x,x)/x-
 \widehat{\eta_+}(-\delta)\right|^2\,d\delta\le8\cdot10^{-6}.\]
\end{theorem}
\begin{proof}[Selected research route]\uses{familymoments}
The nonnegative $q=1$ summand of $E_p$ is exactly the raw principal
residual on $[-600000,600000]$. Restrict to $[-4,4]$ and use
$.00020001^2<8\cdot10^{-6}$. Chapters 84--85 verify the weights,
Fourier sign and normalization. The older quartet argument in chapter02
remains a separate alternative, not a dependency of this branch.
\end{proof}

\begin{theorem}[Lower major energy]\label{lowerj}\notready
For the source normalized major energy, $J(x)\ge8.6296$ for $x\ge x_0$.
\end{theorem}
\begin{proof}[Selected research route]\uses{familymoments}
Unconditional Fourier and weight estimates give main principal energy
$M\ge .6392\cdot13.597558>2.94^2$. Reverse Minkowski, exact character
Parseval and the full/coprime norm correction below $10^{-9}$ give
$J>(2.94-.00020001-10^{-9})^2>8.6296$. Chapters 84--85 check that no
existing Platt-dependent L2 wrapper is invoked. This integrated bound
does not supply the pointwise etaStar base-gap estimate.
\end{proof}

\chapter{Major contribution}
Use exactly the residuals defined in chapter 03. In particular, the
imprimitive Gauss weight is the conductor when the complementary quotient
is squarefree and coprime to it, and zero otherwise. The mixed term sums
over two independent characters at the same modulus.

\begin{theorem}[Upper major energy]\label{upperj}\notready
For all $x\ge x_0$, $J(x)\le10$.
\end{theorem}
\begin{proof}[Research route]\uses{familymoments}
It suffices to prove the separate broad-twist principal energy
$E_p\le10^{-4}$ and nonprincipal energy $\mathcal N\le1.23$ of chapter 03.
Chapters 120--121 give an independently reviewed sufficient implication
from the finite $\beta\le111/200$ condition for every active primitive
character through its specified conductor-dependent height. That finite
condition and the actual-smoothing analytic bridges remain unproved.
The alternative $J(x)<1.4\log(2x)$ requires different residual budgets.
\end{proof}

\begin{theorem}[Coprime residual budget]\label{residual}\notready
For every $x\ge x_0$, with the exact chapter 03 integrals,
\[A'_+\le5\cdot10^{-7},\qquad A'_*+\mathrm{Cross}'\le9.5\cdot10^{-7}.\]
\end{theorem}
\begin{proof}[Research route]\uses{familymoments}
Chapters 120--121 give a sufficient full-family finite condition with
$\beta\le111/200$. Actual-smoothing Gram estimates and genuine fourth
moments give $I_{\rm low}<10^{-8}$, while the full joint mixed remainder
is below $.000160001$ without assuming $J\le10$.
The full coprime $A'_*+\mathrm{Cross}'$ is below $6.769\cdot10^{-7}$,
inside the retained target $9.5\cdot10^{-7}$.
The finite zero assertion remains unproved. Independent second moments
alone do not control the mixed product, and the analytic bridges still
need formal proofs. No new root premise is permitted.
\end{proof}

\begin{theorem}[Major coefficient]\label{major}\notready
The major contribution is at least $1.0404x^2/49$.
\end{theorem}
\begin{proof}[Research route]\uses{upperj,residual}
Coprime removal gives $A_+\le5.050000000000330\cdot10^{-7}$ and
$A_*+\mathrm{Cross}\le9.817952468\cdot10^{-7}$. Thus
\[\sqrt{(2J+17.41053338496)A_+}+
\sqrt{2J(A_*+\mathrm{Cross})}<.008778.\]
Subtract this and fixed loss $.002834895$ from main coefficient
$1.052105346$. The result exceeds $1.0404$. The rational implication has
been checked externally; its analytic premises remain open.
\end{proof}

\chapter{Minor contribution and final assembly}
\begin{theorem}[Relaxed minor energy]\label{minorenergy}\notready
For the actual source coefficients and every $x\ge x_0$,
\[\sum_n\|a_1(x,n)\|^2\le .65x\log x.\]
\end{theorem}
\begin{proof}[Research route]\uses{strip,mass}
The new argument in chapter 11 treats the actual squared smoothing directly.
Fourier cutoff contracts the first two derivative energies. Two integrations
by parts give Mellin bounds $172w_2$ and $566w_2$ for the squared smoothing
and its logarithmic multiple. The positive mass bound then gives normalized
error less than $.006$, with a negligible vertical remainder. Summability
comes from the existing smoothing theorems and the log split. Chapter 12
checks that the relaxed coefficient $.65$, even without a negative offset,
preserves the final minor bound after recomputing the coefficient-dependent
numerical values. These arguments still need Lean formalization.
\end{proof}

\begin{theorem}[All remaining minor inputs]\label{minorinputs}\notready
Discharge each source Platt-dependent consumer with its full quantified
range: the prime and von Mangoldt estimates, direct Mobius and Liouville
inputs, Mertens window and totient bound, etaStar base gap,
and prime-power energy. See chapters 05--07 for exact source declarations.
\end{theorem}
\begin{proof}[Research route]\uses{strip,smoothing}
P2, P3 and P6 have complete independently reviewed paper replacements.
The common totient transport and separate quotient-sieve consumer repair
also pass paper review; all still require Lean implementation.
Chapters 75--78 reduce P1/P4/P5/P7 and the relaxed Mobius profile to
the shared unproved envelope $|\psi_N(v)-v|\le .01v/\log v$ for integer
$v\ge10^9$, together with the specified elementary and finite repairs.
The Mobius profile is $.03$ on $[11815,10^8+1)$ and $.10$ thereafter.
Its 214 cells and matching infinite tail pass independent exact replay.
The earlier range uses existing finite source proofs; smaller arguments
retain their own finite treatment. Downstream adapters remain required.

Chapters 98--99 give the selected conditional psi tail from $5\cdot10^9$,
requiring an additional low-zeta strip and reciprocal moment through $10^6$.
All 6,439 finite-gap windows now have candidate data, independently recounted
across all four billion integers and 125,271 subcells (chapters 122--124).
On the unchanged $a/4000$ grid, the reviewed condition
$|\theta(a)-a|\le a/10000$ preserves the required finite psi bound.
Every new Lean count proof remains open. The older $\exp(35)$ route and its
much longer finite gap are a separate alternative.

For the principal moment, chapters 127--128 derive the purely analytic bound
$N(t)\le F(t)+5\log t+20$ for $t\ge1500$, with no finite-count calibration.
Here $N(t)$ counts positive ordinates at most $t$, with full multiplicity, and
\[F(t)=\frac{t}{2\pi}\bigl(\log(t/(2\pi))-1\bigr)+\frac78,\qquad
 Q_{1500}=\sum_{0<\gamma\le1500}m_\rho(1/\gamma-1/1500).\]
Together with the still-unproved narrow strip $(.499,.501)$ through $10^6$
and complete reciprocal head $Q_{1500}\le2$, it gives $W_{35}<23.990<24$.
The required moment includes both signs and true multiplicities:
\[W_{35}=\sum_{|\Im\rho|\le10^6}m_\rho
 \frac{\exp(35\max(\Re\rho-1/2,0))}{|\rho|}.\]
The closed height14 exclusion has a complete external rectangle certificate
and independent review (chapters 129--130), but needs formal replay.

The pointwise etaStar base-gap argument now has reviewed conditional
coverage for every reduced denominator $1\le q\le150000$, all permitted
twists, and every $y\ge10^{25}$. The actual allowance
$y\widehat g(y,150000)$ exceeds $.04712y$. Chapters 94--95 derive
a bound below $.044797y$ for every $q\ge4$ from a finite $.555$ strip,
global QRH and actual-smoothing bridges. The dynamic cutoff fits the old
height and $10^8/c$ separately, hence the selected minimum $H_{\rm cert}$.
The spectral prefixes for $q=1,2,3$ end at
$u=486477,972954,1068377$, respectively. Reviewed Type I/II high branches
start at $190000,300000,300000$; chapter 101 checks their overlaps.
Original modulus $m$, reduced $q=m/\gcd(m,2)$ and physical twist
$\delta=u/(2q)$ must retain their parity and scale adapters.
The finite spectrum, analytic bridges and Type I/II producers remain
unproved. Off the larger arcs the source theorem retains those producer
dependencies too. No numerical coverage certificate discharges them.

Chapter13 supplies the independently reviewed Chebyshev argument for
prime-power energy below $8\cdot10^{-11}x$. The other energy and
nonprime contributions remain separately tracked in the fixed budget.
\end{proof}

\begin{theorem}[Minor coefficient]\label{minor}\notready
The absolute minor contribution is at most $1.0376x^2/49$.
\end{theorem}
\begin{proof}[Research route]\uses{lowerj,minorenergy,minorinputs}
Preserve the existing numerical-cell inputs or reprove the full changed
numerical inequality. The relaxed Mobius route preserves $T_2\le.37273$
using an internal tail bound $.0089$. No other consumer is discharged by
that single replacement.
\end{proof}

\begin{theorem}[Nonprime reserve]\label{nonprime}\notready
For odd $N\ge10^{27}$, the source nonprime bound obeys
\[6.7\cdot10^6N\sqrt N\log N<.00271x^2/49.\]
\end{theorem}
\begin{proof}[Research route]
Reuse the source crude comparison with $d\le2.02$ and $N^{1/64}\ge2.64$.
The remaining rational comparison is
$1.589\cdot10^8\cdot4.0804\cdot49/2.64^{31}<.00271$.
The revised Lean numerical lemma remains to be written.
\end{proof}

\begin{theorem}[Large ternary Goldbach]\label{large}\notready
Every odd natural number $N\ge10^{27}$ is the sum of three primes,
without a PlattGRH premise.
\end{theorem}
\begin{proof}[Research route]\uses{major,minor,nonprime}
Apply the existing circle identity and extraction argument. The normalized
positive reserve is $1.0404-1.0376-.00271=.00009$.
\end{proof}

\begin{theorem}[Original full statement]\label{full}\notready
Assume only binary Goldbach for even $4\le n\le4\cdot10^{18}$.
Then every odd natural number greater than $5$ is a sum of three primes.
\end{theorem}
\begin{proof}[Research route]\uses{large}
Combine with the existing finite-range theorem and its certified prime
ladder. Audit expanded types and transitive axioms of both roots. Proving
the binary input itself is a separate extension; see the finite-proof
appendix of chapter 08. It is not removed by the QRH work above.
\end{proof}
'''
(tex / 'content.tex').write_text(CONTENT, encoding='utf-8')

css = '''body{font:17px/1.6 system-ui,sans-serif;max-width:1050px;margin:auto;padding:2rem;color:#19252c;background:#fafbf9}h1,h2,h3{line-height:1.2;color:#153e43}h1{margin-top:2rem}a{color:#126b7a}table{border-collapse:collapse;display:block;overflow:auto}td,th{border:1px solid #cedbd9;padding:.5rem;text-align:left}pre{white-space:pre-wrap;overflow-wrap:anywhere;background:#eef2f0;padding:1rem}code{font-size:.88em;overflow-wrap:anywhere}section{border-top:3px solid #bdd6d1;margin-top:4rem}nav{padding:1rem;background:#e7efec}'''
main = markdown.markdown(README, extensions=['tables','fenced_code','toc'])
parts = [main]
for name,_ in CHAPTERS:
    contents = (OUT/'chapters'/name).read_text(encoding='utf-8-sig')
    parts.append('<section id="'+name[:-3]+'">'+markdown.markdown(contents, extensions=['tables','fenced_code'])+'</section>')
body = '\n'.join(parts)
for name,_ in CHAPTERS:
    body = body.replace('href="chapters/'+name+'"', 'href="#'+name[:-3]+'"')
(OUT/'index.html').write_text('<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>QRH replacement research blueprint</title><style>'+css+'</style></head><body>'+body+'</body></html>', encoding='utf-8')
manifest = {'kind':'research deliverable, not proof validation', 'source_pin':'23b2d68ca344203d4384e0aff7affa4ec034bef9', 'files':[]}
for p in sorted(OUT.rglob('*')):
    if p.is_file() and p.name!='manifest.json':
        manifest['files'].append({'path':p.relative_to(OUT).as_posix(),'bytes':p.stat().st_size,'sha256':sha256(p.read_bytes()).hexdigest()})
(OUT/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n',encoding='utf-8')
print(json.dumps({'output':str(OUT),'chapters':len(CHAPTERS),'files':len(manifest['files']),'research_nodes':len(nodes),'dag':'acyclic'},indent=2))
