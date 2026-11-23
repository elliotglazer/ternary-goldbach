"""Count independent real character lanes and price sparse repair scenarios."""
from collections import Counter
from fractions import Fraction
from hashlib import sha256
from math import expm1, isqrt, log1p
import json
import sys
import re
from flint import dirichlet_char

from endpoint_policy import HERE, HOL
from rounded_coverage import target

sys.path.insert(0,str(HOL/'time-pruning'))
from count_time_fft import primitive_count


def quadratic_characters(q, squarefree):
    # Count signed fundamental discriminants of absolute value q. The
    # primitive principal character (q=1) has a separate certificate.
    total = 0
    for d in (q,-q):
        if d%4 == 1:
            total += squarefree[q]
        if d%4 == 0 and (d//4)%4 in (2,3):
            total += squarefree[q//4]
    return total


def census(routine_rate):
    bound = 265800
    squarefree = bytearray([1])*(bound+1)
    for k in range(2,isqrt(bound)+1):
        sq = k*k
        squarefree[sq::sq] = bytes(bound//sq)
    tested = sorted(set(range(3,257)) | {10000,10004,19940,65536,65537,132899,180180,265800})
    for q in tested:
        # The multiplicative Conrey index of a real character is self-inverse.
        # Ask FLINT about every such label rather than assuming its conductor.
        real=0
        for j in range(1,q):
            if j*j%q==1:
                chi=dirichlet_char(q,j)
                assert chi.is_real()
                real+=int(chi.is_primitive())
        assert real==quadratic_characters(q,squarefree)
    groups = {'small':Counter(), 'large':Counter()}
    fallback_rates = (0.0001,0.001,0.01,0.1,1.0)
    sweep = {f:Counter() for f in fallback_rates}
    for q in range(3,bound+1):
        if q%4 and (q%2==0 or q>132900):
            continue
        n, r = primitive_count(q), quadratic_characters(q,squarefree)
        assert r<=n and (n-r)%2==0
        h=(64*target(q)+4)//5+640
        p=groups['small' if q<=10000 else 'large']
        p.update(conductors=1,primitive=n,real_labels=r,nonreal_inverse_pairs=(n-r)//2,
                 coarse_cells=n*h,real_cells=r*h,internal_nodes=41*n if q>10000 else 0)
        if q>10000:
            for f,s in sweep.items():
                # Homogeneous sparse-job model. A failed job requires 12
                # source rows at one character; full-column replay affects
                # every character. Ignore <=11 boundary windows per lane.
                tap_probability=routine_rate*f
                independent=-expm1(12*n*log1p(-tap_probability))
                union=min(1,12*n*tap_probability)
                s.update(physical_columns=h,physical_outputs=n*h,
                         affected_columns=h*independent,affected_outputs=n*h*independent,
                         affected_outputs_union=n*h*union)
    # Compare exact group sizes against the previously verified source manifest.
    saved=json.loads((HERE/'rounded-coverage.json').read_bytes())['families']
    for name,g in groups.items():
        assert g['primitive'] == saved[name]['primitive_labels']
        assert g['conductors'] == saved[name]['conductors']
    occupancies={str(f):dict(
        fraction_columns=s['affected_columns']/s['physical_columns'],
        fraction_outputs_if_full_column_recomputed=s['affected_outputs']/s['physical_outputs'],
        union_bound_fraction_outputs=s['affected_outputs_union']/s['physical_outputs'])
        for f,s in sweep.items()}
    return groups,len(tested),occupancies


def main():
    panel=json.loads((HERE/'strip-repair-panel-stress.json').read_bytes())
    rate=Fraction(panel['total_jobs'],panel['total_coarse_intervals'])
    groups,flint_checks,occupancies = census(float(rate))
    all_groups=sum(groups.values(),Counter())
    cells=all_groups['coarse_cells']
    pilot_outputs=41_029_096_839_823
    assert cells+all_groups['primitive']+all_groups['internal_nodes'] == pilot_outputs
    jobs = cells*rate
    room = [1_600_000-788_543,1_600_000-776_249]
    # This allowance is shared with every other unpriced part of the campaign.
    def hours(seconds, population=jobs):
        return float(seconds*population/3600)
    costs = {str(ms):hours(Fraction(ms,1000)) for ms in (1,5,10,25,50,100,200,250,500)}
    kernel_dir=HERE.parents[2]/'grh-goldbach-20261120'/'team'/'q10004-short'
    measured={}
    for tag,n,label_marker in [('ShortBatch',13,'STRICT_ACTUAL_ROWS'),
                               ('PanelBatch',270,'ACTUAL_12_NODE_ROWS'),
                               ('PanelUnary',270,'ACTUAL_12_NODE_ROWS')]:
        raw=(kernel_dir/f'{tag}.log').read_bytes()
        log=raw.decode()
        timer=(kernel_dir/f'{tag}.time').read_text()
        assert f'{label_marker} {n}' in log and f'Exporting theory "{tag}" ... done.' in log
        assert 'Exit status: 0' in timer
        timings=re.findall(r'^KERNEL_WITH_ENCODING (\S+) (\S+)$',log,re.M)
        assert len(timings)==(n if tag=='PanelUnary' else 1)
        if tag=='PanelUnary':
            assert [name for name,_ in timings]==[f'proved_{i}' for i in range(n)]
        hot=sum(Fraction(x) for _,x in timings)
        cold=sum(Fraction(re.search(rf'{kind} time \(seconds\):\s*([\d.]+)',timer)[1]) for kind in ('User','System'))
        measured[tag]=dict(rows=n,log_sha256=sha256(raw).hexdigest(),inner_cpu=float(hot),
                           process_cpu=float(cold),inner_seconds_per_job=float(hot/n),
                           process_seconds_per_job=float(cold/n),transferred_inner_hours=hours(hot/n),
                           transferred_process_hours=hours(cold/n))
    joins=(kernel_dir/'PanelJoin.log').read_text()
    assert 'Exporting theory "PanelJoin" ... done.' in joins
    join_time=Fraction(re.search(r'^MATCHED_BATCH_FROM_270 (\S+)$',joins,re.M)[1])
    exact=(HOL/'strip-parameter-hol'/'param02.log').read_text()
    assert 'Exporting theory "StripParameterAcceptance" ... done.' in exact
    cumulative=dict((key,Fraction(t)) for key,t in re.findall(r'^PARAMETER_TIME (\S+) (\S+)$',exact,re.M))
    parameter_rows=cumulative['packets']-cumulative['mass']
    combined=Fraction(str(measured['PanelUnary']['inner_cpu']))+join_time+parameter_rows
    measured['separate_exact_parameters_and_join']=dict(
        aggregate_inner_cpu=measured['PanelUnary']['inner_cpu']+float(join_time),
        per_row_parameters_cpu=float(parameter_rows),
        estimated_increment_core_hours=hours(combined/270),
        nonprincipal_baseline_plus_increment=[round(b+hours(combined/270)) for b in (776249,788543)],
        scope='Inner time, separate passes, shared parameter setup excluded. Stationary eight-conductor repair incidence, no credit for possible small-family overlap. Still excludes low-precision source retries and other upstream proof.')
    result=dict(
        scope='Nonprincipal physical intervals through rounded target plus 50. Formal/direct producer, failures, and analytic closure must be priced separately where unmeasured. Pooled density is a scenario from eight purposive conductors; not an incidence estimate with a confidence interval.',
        group_census=groups,all_groups=all_groups,scheduled_outputs=pilot_outputs,
        flint_conductor_crosschecks=flint_checks,
        real_output_cell_fraction=all_groups['real_cells']/cells,
        real_lane_fraction=all_groups['real_labels']/all_groups['primitive'],
        panel_sha256=sha256((HERE/'strip-repair-panel-stress.json').read_bytes()).hexdigest(),
        sample_jobs=panel['total_jobs'],sample_intervals=panel['total_coarse_intervals'],
        whole_column_retry_sensitivity=occupancies,
        whole_column_model='If a fraction f of ordinary repair jobs each require rerunning a 12-node stencil at higher precision, model independent starts and uniform lambda*f per character-cell. Ignore clipped endpoints; union column uses no independence under the same marginal assumption. Output-weighting is a workload indicator, not a transform timing.',
        rates_by_conductor={str(r['q']):r['jobs']/r['coarse_intervals'] for r in panel['rows']},
        measured_short_stencil_runs=measured,
        transferred_routine_jobs=float(jobs),hours_at_milliseconds_per_routine_job=costs,
        available_hours_to_ten_times_used_historical=room,
        milliseconds_per_job_if_all_headroom_used=[float(3600000*h/jobs) for h in room],
        hours_per_one_percent_of_labels_at_extra_one_cpu_second=hours(Fraction(1,100),all_groups['primitive']),
        additional_hours_per_one_percent_of_jobs_at_one_second=hours(Fraction(1,100)),
        hours_per_microsecond_per_real_grid_cell=hours(Fraction(1,10**6),all_groups['real_cells']),
        hours_if_one_extra_second_per_real_character=hours(1,all_groups['real_labels']))
    (HERE/'repair-budget.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))


if __name__=='__main__':
    main()
