"""Count the later source bands and measure how much of a two-Platt-run budget they can use."""
import json
from pathlib import Path

from schedule import PATH

HERE = Path(__file__).resolve().parent


def main():
    manifest = json.loads(PATH.read_bytes())
    rows = sorted((c, phi, j + 41) for c,phi,_,_,j,_,_ in manifest['conductors'])
    groups = [rows[i:i+32] for i in range(0,len(rows),32)]
    maximum = max(j for c,phi,j in rows)
    intervals = [(0,6401,1025),(6401,12801,2049),(12801,25601,4097),
                 (25601,64001,8193),(64001,maximum,16385)]
    old = json.loads((HERE/'schedule.json').read_bytes())
    base = next(s for s in old['schedules'] if s['conductors_per_group']==32 and s['heights_per_block']==8)
    fixed = [b['fixed_kernel_hours']*3600/base['band1_cell_block_calls'] for b in base['band1_kernel_sensitivities']]
    details = []
    for lo,hi,cells in intervals:
        count = lambda j: max(0,min(hi,j)-lo)
        units = sum(phi*count(j) for c,phi,j in rows)
        pad = sum(phi*((-count(j))%8) for c,phi,j in rows)
        calls = cells*sum((max(count(j) for c,phi,j in group)+7)//8 for group in groups)
        details.append(dict(height_indices=[lo,hi], cells=cells, units=units, pad=pad, calls=calls))
    assert details[0]['units']==base['active_units_band1'] and details[0]['calls']==base['band1_cell_block_calls']
    assert details[0]['pad']==base['unused_residue_height_lanes']
    assert sum(b['units'] for b in details)==sum(phi*j for c,phi,j in rows)
    late_positions=sum(b['units']+b['pad'] for b in details[1:])
    late_calls=sum(b['calls'] for b in details[1:])
    fallback=json.loads((HERE.parent/'price-check-20261120/precision-fallback.json').read_bytes())
    room=fallback['room_to_800000_at_zero_retries_before_unpriced_work']
    limits=[]
    for b,headroom,control in zip(base['band1_kernel_sensitivities'],room,fixed,strict=True):
        fixed_hours=late_calls*control/3600
        limits.append(dict(reference_band1_marginal_us=b['slope'], reference_control_seconds=control,
                           later_fixed_hours_if_transferred=fixed_hours,
                           later_total_hours_if_band1_rates_transferred=fixed_hours+b['slope']*late_positions/3.6e9,
                           remaining_hours_for_later_bands_and_all_omitted_work=headroom,
                           later_marginal_us_ceiling_if_no_other_cost=(headroom-fixed_hours)*3.6e9/late_positions))
    output=dict(heights_per_block=8,conductors_per_group=32,additional_heights=41,
                bands=details, later_padded_output_positions=late_positions, later_cell_blocks=late_calls,
                thresholds=limits, manifest_sha256=old['manifest_sha256'])
    (HERE/'later-band-budget.json').write_text(json.dumps(output,indent=2)+'\n')
    print(output)


if __name__=='__main__':
    main()
