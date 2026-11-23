"""Independent single-edge representation diagnosis; no reduction or series."""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import json
import flint
from flint import arb,acb,ctx

HERE=Path(__file__).resolve().parent
AGENTS=HERE.parent
PINS={
 'mellin/MODULAR_ENDPOINT_EXPORT_DIAGNOSIS_2026-11-11.md':'C25E171FBDF9A8689CD7D2ACB99F85828534F6C6286D82A895384343109C4DC3',
 'mellin/modular_endpoint_export_diagnosis_20261111.py':'59B922F743FC3906E944A459D873F5FA4A545A880E0FE37ED9D3C6E7ABE3822F',
 'mellin/modular_endpoint_export_diagnosis_20261111.json':'6CEA85CA705494E5DD20751722FF620CB6F7AF72EE898EE8C3D680F77DE4011F',
 'prime-estimates/principal_theta_modular_pilot_20261111.json':'C39982174CAC9C51E9F816275082BCE322CA2AD143D9FCE61081DF72E57B11EF'}
checks=[]
def check(label,p):
    assert p,label
    checks.append(label)
def value(d):
    e=d['exponent'];assert type(e)is int and abs(e)<=1024
    return F(int(d['mantissa']))*F(2)**e
def arb_value(a):
    m,e=a.man_exp();assert abs(int(e))<=1024
    return F(int(m))*F(2)**int(e)
def exact_arb(d):
    return arb(int(d['mantissa']))*arb(2)**d['exponent']
def ends(a):return [arb_value(a.lower()),arb_value(a.upper())]

def run():
    for p,h in PINS.items():check('pin '+p,hashlib.sha256((AGENTS/p).read_bytes()).hexdigest().upper()==h)
    diag=json.loads((AGENTS/'mellin/modular_endpoint_export_diagnosis_20261111.json').read_text())
    original=json.loads((AGENTS/'prime-estimates/principal_theta_modular_pilot_20261111.json').read_text())
    edge=original['points'][0]['steps'][0]
    oldprec=ctx.prec
    try:
        ctx.prec=256
        eta=arb(1)/arb(1000001)
        er=(2*arb(0)).exp()
        actual_input=acb(-er*(2*eta).cos(),er*(2*eta).sin())
        actual_output=actual_input+1
        for coord,shift in [('re',F(1)),('im',F(0))]:
            c=diag['components'][coord]
            for label,a in [('input',actual_input),('output',actual_output)]:
                x=a.real if coord=='re' else a.imag
                fields=c[label]
                vals={k:value(v) for k,v in fields.items()}
                check(f'{coord}/{label}/mid',arb_value(x.mid())==vals['mid'])
                check(f'{coord}/{label}/rad',arb_value(x.rad())==vals['rad'])
                check(f'{coord}/{label}/radius nonnegative',vals['rad']>=0)
                check(f'{coord}/{label}/exact lo',vals['exact_lo']==vals['mid']-vals['rad'])
                check(f'{coord}/{label}/exact hi',vals['exact_hi']==vals['mid']+vals['rad'])
                check(f'{coord}/{label}/lower inflation',vals['lower_export_inflation']==vals['exact_lo']-vals['export_lo'])
                check(f'{coord}/{label}/upper inflation',vals['upper_export_inflation']==vals['export_hi']-vals['exact_hi'])
                check(f'{coord}/{label}/frozen export',ends(x)==list(map(value,edge[label]['binary_'+coord])))
                check(f'{coord}/{label}/diagnostic export',ends(x)==[vals['export_lo'],vals['export_hi']])
                lossless=diag['lossless_proposed_payload'][coord][label]
                check(f'{coord}/{label}/lossless payload',value(lossless['lo'])==vals['exact_lo'] and value(lossless['hi'])==vals['exact_hi'] and value(lossless['mid'])==vals['mid'] and value(lossless['rad'])==vals['rad'])
            inp,out=c['input'],c['output']
            check(f'{coord}/exact translation midpoint',value(out['mid'])==value(inp['mid'])+shift)
            check(f'{coord}/exact translation radius',value(out['rad'])==value(inp['rad']))
            check(f'{coord}/exact endpoint translation',value(out['exact_lo'])==value(inp['exact_lo'])+shift and value(out['exact_hi'])==value(inp['exact_hi'])+shift)
        re=diag['components']['re']
        delta=F(133693435)*F(2)**-283
        check('real lower deficit',value(re['exported_hull_lower_deficit'])==delta)
        check('real upper deficit',value(re['exported_hull_upper_deficit'])==delta)
        check('real radius',value(re['input']['rad'])==F(134742021)*F(2)**-283)
        check('export radius ratio',(value(re['input']['export_hi'])-value(re['input']['export_lo']))/(2*value(re['input']['rad']))==F(268435456,134742021))
        check('input endpoints283bits',all(abs(int(re['input'][k]['mantissa'])).bit_length()==283 for k in ['exact_lo','exact_hi']))
        check('output endpoints245bits',all(abs(int(re['output'][k]['mantissa'])).bit_length()==245 for k in ['exact_lo','exact_hi']))
        ctx.prec=283
        check('same existing ball exact reexport',ends(actual_input.real)==[value(re['input']['exact_lo']),value(re['input']['exact_hi'])])
        for name in ['mid','rad','lower','upper','man_exp']:
            check('API contract '+name,getattr(arb,name).__doc__==diag['local_api_contracts'][name])
    finally:
        ctx.prec=oldprec
    output={'status':'PASS single-edge external representation diagnosis only','flint_version':flint.__version__,
            'pins':PINS,'checks':checks,'check_count':len(checks),'full_original_operation_trace_repaired':False,
            'scope':'Only points[0].steps[0]. No reduction loop, series, full pilot, Lean or analytic truth certification.'}
    HERE.joinpath('review_endpoint_export_20261111.json').write_text(json.dumps(output,indent=2)+'\n')
    print(json.dumps({'status':output['status'],'check_count':len(checks)}))

if __name__=='__main__':run()
