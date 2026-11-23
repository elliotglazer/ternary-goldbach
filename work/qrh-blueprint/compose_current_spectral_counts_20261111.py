"""Compose reviewed operation categories, not execution times."""
from pathlib import Path
from hashlib import sha256
from fractions import Fraction as F
import json

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent/'qrh-campaign/agents'
pins={
 'zero-sum/CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md':'7AA9BF4D456CE25685D69427966DC7F61D0914DD091A95B74F9C242B95CADB27',
 'major-constants/REVIEW_CONDITIONAL_R132900_SPECTRAL_PRUNING_INVENTORY_2026-11-11.md':'6B36841BB9BD406E7DE65170AAC29D00F4575970A16F4D1C78B4CAD5FD4AAEEF',
 'zero-sum/MIXED_RADIX_CHARACTER_TRANSFORM_EFFICIENCY_2026-11-11.md':'C2DF53947BA4EC8B401148F63EBDE8EAB95C5C6EA029317EDF4C326D38A87E01',
 'zero-sum/R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md':'3151FEBCBE953FA458CBFE437222B810468B2E4F173C723F159F67285601D853',
 'independent-feasibility/REVIEW_R138000_HURWITZ_SEED_CONTRACTION_EFFICIENCY_2026-11-11.md':'CCA39412B798FA2A49AFD56755D67F527D745A8EB8EF43BB83D4CBCB2CD96201',
 'integration/SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'861CA2C6F326C57AABDA40B72D723D537223BC0986F0AC25AAE5C6CD37DB2895',
 'independent-feasibility/REVIEW_SHIFTED_HURWITZ_JET_SEED_EFFICIENCY_2026-11-11.md':'F190270EC3A359A1251E24C1039826EFE13897499DE540EA9F877331804748BB',
}
for name,h in pins.items():assert sha256((AGENTS/name).read_bytes()).hexdigest().upper()==h,name
g_old,a_old,n_old=4890157406463512,11446911736111484,114223068442718
g_new,a_new,n_new=1849018578634950,3808420069398260,99513098256768
def row(g,a,n,p,mult,adds):
    h=(p-1)*n
    return {'G':g,'A':a,'residue_inputs':n,'P':p,'Horner_stages':h,
            'real_products':mult*g+2*h,'real_additions':2*a+adds*g+2*h}
rows={
 'R150000_whole_axis_P24_four':row(g_old,a_old,n_old,24,4,2),
 'R132900_fixed_pruned_P24_four':row(g_new,a_new,n_new,24,4,2),
 'R132900_fixed_pruned_P20_four':row(g_new,a_new,n_new,20,4,2),
 'R132900_fixed_pruned_P20_fixed_three':row(g_new,a_new,n_new,20,3,3),
 'R132900_fixed_pruned_P20_Gauss':row(g_new,a_new,n_new,20,3,5),
}
baseline=rows['R150000_whole_axis_P24_four']
for r in rows.values():
    for category in ('real_products','real_additions'):
        ratio=F(r[category],baseline[category])
        r[category+'_ratio']={'num':ratio.numerator,'den':ratio.denominator,'display':float(ratio)}
out={'scope':'large-branch transform and residue-Horner operation categories only',
     'pins':pins,'rows':rows,'excluded':['seeds','elementary heads and phases','coefficient setup',
     'quarter turns, negations, dyadic scales','input or displacement enclosures','rounding proofs',
     'interpolation, signs and completeness','small conductor branch','binary proof and ladder',
     'foundations, serialization and assembly'],'runtime_claim':False}
(HERE/'compose_current_spectral_counts_20261111.json').write_text(json.dumps(out,indent=2)+'\n',encoding='utf-8')
for name,r in rows.items():print(name,r['real_products'],r['real_additions'],r['real_products_ratio']['display'],r['real_additions_ratio']['display'])
