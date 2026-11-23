"""Compare the 24- and 28-bit prices on identical sampled transform lengths."""
import json
from math import sqrt
from pathlib import Path
from statistics import mean, stdev

HERE=Path(__file__).resolve().parent


def load(path):
    return json.loads(path.read_bytes())


def main():
    axis=HERE.parent/'large-axis-sample'
    plan=load(axis/'sample.json')
    cheap=load(axis/'estimate-p24.json')
    safer=load(axis/'estimate-p28.json')
    assert cheap['plan_sha256']==safer['plan_sha256']
    a,b=[t['completed_sampling_strata'] for t in (cheap,safer)]
    assert a.keys()==b.keys()
    change=variance=0
    for k in a:
        unit=plan['strata'][k]['positions']/3.6e9
        diff=[v-u for u,v in zip(a[k]['per_position_us'],b[k]['per_position_us'],strict=True)]
        change+=unit*mean(diff)
        variance+=unit**2*stdev(diff)**2/len(diff)
    f24=load(HERE/'precision-fallback.json')
    f28=load(HERE/'precision-fallback-p28.json')
    base=f24['original_hours_in_measured_strata']
    assert abs(change-(f28['coarse_first_pass_hours_in_measured_strata']-
                       f24['coarse_first_pass_hours_in_measured_strata']))<1e-5
    weights=HERE.parent/'large-weighted-slab'
    bands=load(weights/'later-band-budget.json')
    occupancy=load(weights/'occupied-cells.json')
    assert bands['manifest_sha256']==occupancy['manifest_sha256']
    later=[r['later_total_hours_if_band1_rates_transferred']-saved
           for r,saved in zip(bands['thresholds'],occupancy['hours_saved_at_band1_controls'],strict=True)]
    subtotals={str(p):[x+y for x,y in zip(f['five_component_hours_by_original_cost_weighted_retry_fraction']['0'],later,strict=True)]
               for p,f in [(24,f24),(28,f28)]}
    result=dict(extra_first_pass_hours_28_over_24=change,paired_between_draw_se_hours=sqrt(variance),
                full_price_retry_fraction_to_save=change/base,
                later_source_hours_at_band1_rates_and_occupied_cells_only=later,
                subtotals_including_later_source_at_transferred_rates=subtotals,
                remaining_to_twice_historical_if_no_retries={p:[800000-h for h in v] for p,v in subtotals.items()})
    (HERE/'precision-choice.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))


if __name__=='__main__':
    main()
