"""Fold the four measured source panels into the adaptive 128-conductor schedule."""
import argparse
import hashlib
import json
import re
from pathlib import Path
from statistics import median

HERE=Path(__file__).resolve().parent
SLAB=HERE.parent/'large-weighted-slab'


def read(path):
    return json.loads(path.read_bytes())


def measured_rows(label,suffix,indices):
    log=HERE/(label+'.log')
    assert log.with_suffix('.status').read_text().strip()=='0'
    s=log.read_text()
    assert 'WEIGHTED_SLAB_DONE' in s
    assert 'BandSlab' in s
    fixture=read(HERE/('fixtures'+suffix+'.json'))
    assert fixture['input_sha256']==hashlib.sha256((HERE/('resident'+suffix+'.txt')).read_bytes()).hexdigest()
    receipt={row.split()[1]:row.split()[0] for row in log.with_suffix('.sha256').read_text().splitlines()}
    assert all(hashlib.sha256((HERE/n).read_bytes()).hexdigest()==digest for n,digest in receipt.items())
    assert all(r['amplified_fraction_of_budget']<1 for r in fixture['cases'])
    sample={(name,int(n),int(i)):float(cpu) for name,n,i,cpu in
            re.findall(r'^SLAB (\w+)_groups(\d+) (\d+) ([\d.]+) ',s,re.M)}
    ns={(name,int(n)):int(outputs) for name,n,outputs in re.findall(r'^SAMPLES (\w+) (\d+) (\d+)$',s,re.M)}
    band=read(SLAB/'later-band-budget.json')
    sched=read(SLAB/'adaptive-groups.json')['scenarios']['128']['bands']
    rows=[]
    for case,geometry,groups in zip(fixture['cases'],band['bands'][indices],sched[indices],strict=True):
        name=case['tag']; last=len(case['conductors'])
        outputs=case['outputs']
        assert ns[name,last]==outputs
        get=lambda n:[sample[name,n,i] for i in range(1,6)]
        control=median(get(0))
        slope=[(v-u)*1e6/outputs for u,v in zip(get(0),get(last),strict=True)]
        per=[(v-u)*1e6/(outputs-ns[name,32]) for u,v in zip(get(32),get(last),strict=True)]
        hrs_fixed=groups['calls_even_if_empty']*control/3600
        hrs=(geometry['units']+geometry['pad'])*median(slope)/3.6e9
        seq=[groups['calls_even_if_empty']*u/3600+(geometry['units']+geometry['pad'])*(v-u)/outputs/3600
             for u,v in zip(get(0),get(last),strict=True)]
        setup={k:float(v) for k,v in re.findall(rf'^SETUP {name}_groups(\d+) ([\d.]+)',s,re.M)}
        rows.append(dict(band=case['band'],tag=name,full=last,outputs=outputs,
                         setup_cpu=setup,calls=groups['calls_even_if_empty'],
                         hours_if_charging_full_panel_setup_per_call=groups['calls_even_if_empty']*setup[str(last)]/3600,
                         fixed_cpu=control,paired_marginal_us=slope,last_increment_us=per,
                         conditional_fixed_hours=hrs_fixed,conditional_marginal_hours=hrs,
                         trial_total_hours=seq))
    return rows


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--all',action='store_true')
    with_first=parser.parse_args().all
    log=HERE/'band01.log'
    band=read(SLAB/'later-band-budget.json')
    sched=read(SLAB/'adaptive-groups.json')['scenarios']['128']['bands']
    rows=measured_rows('band01','',slice(1,None))
    assert len(rows)==4
    if with_first:
        rows=measured_rows('first01','-first',slice(None,1))+rows
        kernel=sum(r['conditional_fixed_hours']+r['conditional_marginal_hours'] for r in rows)
        setup=sum(r['hours_if_charging_full_panel_setup_per_call'] for r in rows)
        folder=HERE.parent/'price-check-20261120'
        former=read(folder/'component-sensitivity.json')['parts']['band1_large_source_kernel_sensitivity']
        levels={}
        for p in [24,28]:
            fn='precision-fallback.json' if p==24 else 'precision-fallback-p28.json'
            five=read(folder/fn)['five_component_hours_by_original_cost_weighted_retry_fraction']['0']
            arithmetic=[x-y+kernel for x,y in zip(five,former,strict=True)]
            levels[p]=dict(partial_kernel_scenario=arithmetic,partial_with_same_setup_per_call=[x+setup for x in arithmetic])
        data=dict(rows=rows,source_kernel_hours=kernel,source_setup_if_charged_per_call_hours=setup,
                  other_components_and_source=levels,
                  log_sha256={n:hashlib.sha256((HERE/(n+'.log')).read_bytes()).hexdigest() for n in ['first01','band01']})
        (HERE/'all-costs.json').write_text(json.dumps(data,indent=2)+'\n')
        print(kernel,setup,levels)
        return
    late=sum(x['conditional_fixed_hours']+x['conditional_marginal_hours'] for x in rows)
    setup_total=sum(x['hours_if_charging_full_panel_setup_per_call'] for x in rows)
    base=read(SLAB/'schedule.json')
    old=next(r for r in base['schedules'] if r['conductors_per_group']==32 and r['heights_per_block']==8)
    delta=sched[0]['calls_even_if_empty']-old['band1_cell_block_calls']
    result={}
    for p in [24,28]:
        price=HERE.parent/'price-check-20261120'/('precision-fallback.json' if p==24 else 'precision-fallback-p28.json')
        five=read(price)['five_component_hours_by_original_cost_weighted_retry_fraction']['0']
        result[p]=[h+late+delta*r['reference_control_seconds']/3600 for h,r in zip(five,band['thresholds'],strict=True)]
    data=dict(rows=rows,estimated_later_band_kernel_hours=late,later_setup_if_charged_per_call_hours=setup_total,
              partial_no_retry_totals_with_band1_regrouping=result,
              remaining_to_800000_hours={p:[800000-h for h in r] for p,r in result.items()},
              fraction_of_measured_setup_affordable_if_all_other_missing_costs_were_zero={
                  p:[(800000-h)/setup_total for h in r] for p,r in result.items()},
              log_sha256=hashlib.sha256(log.read_bytes()).hexdigest(),
              scope='One cell at one eight-height interval per later band. The producer supplied rounded coefficients. The kernel checked a digest of every output. Arithmetic prices exclude input admission, coefficient proof and downstream processing.')
    (HERE/'costs.json').write_text(json.dumps(data,indent=2)+'\n')
    for row in rows:
        print(row['band'],row['fixed_cpu'],median(row['paired_marginal_us']),median(row['last_increment_us']),
              row['conditional_fixed_hours']+row['conditional_marginal_hours'])
    print('later hours',late,'partial',result)


if __name__=='__main__':
    main()
