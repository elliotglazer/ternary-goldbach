"""Exact conductor-count metadata, not L-function/zero evaluation or a runtime model."""
import json
from fractions import Fraction
from pathlib import Path

LIMIT=400000
SCALE=10**6


def inverted_divisor_sum(values):
    out=values.copy()
    for d in range(1,len(out)):
        value=out[d]
        for n in range(2*d,len(out),d):
            out[n]-=value
    return out


def ceildiv(a,b):
    return (a+b-1)//b


def original_height(c):
    return (100000000 if c%2 else max(100000000,200*c+75000000),c)


def strip_height(c):
    if c>100000:
        return (50000000 if c%2 else 99000000,c)
    qt=2*c if c%2 else c
    h=200+max(1000,ceildiv(844800000,7*qt))
    return (min(h*c,100000000),c)


def main():
    # sum_{d|n} phi(d)=n; sum_{d|n} primitive(d)=phi(n).
    # This uses only integer divisor inversion, without a primality oracle.
    phi=inverted_divisor_sum(list(range(LIMIT+1)))
    primitive=inverted_divisor_sum(phi)
    assert primitive[1:13]==[1,0,1,1,3,0,5,2,4,0,9,1]
    assert all(a>=0 for a in primitive)
    assert all(primitive[c]==0 for c in range(2,LIMIT+1,4))
    profiles={
        'declared_original':(300000,400000,original_height),
        'consumed_original_candidate':(150000,300000,original_height),
        'selected_qrh_strips':(150000,300000,strip_height),
    }
    out={}
    for name,(oddmax,evenmax,height) in profiles.items():
        rows=labels=lo=hi=0
        oddlabels=evenlabels=0
        for c in range(1,LIMIT+1):
            a=primitive[c]
            if not a or c>(oddmax if c%2 else evenmax):
                continue
            rows+=1
            labels+=a
            if c%2: oddlabels+=a
            else: evenlabels+=a
            hn,hd=height(c)
            scaled=a*hn*SCALE
            lo+=scaled//hd
            hi+=ceildiv(scaled,hd)
        out[name]=dict(nonempty_conductors=rows,labels=labels,
                      odd_labels=oddlabels,even_labels=evenlabels,
                      weighted_height_lower=f'{lo}/{SCALE}',
                      weighted_height_upper=f'{hi}/{SCALE}')
    assert out['consumed_original_candidate']['labels']==5543640188
    assert out['selected_qrh_strips']['labels']==5543640188
    comparisons={}
    for a,b in [('consumed_original_candidate','declared_original'),
                ('selected_qrh_strips','consumed_original_candidate')]:
        x,y=out[a],out[b]
        vlo=Fraction(x['weighted_height_lower'])/Fraction(y['weighted_height_upper'])
        vhi=Fraction(x['weighted_height_upper'])/Fraction(y['weighted_height_lower'])
        comparisons[f'{a}_over_{b}']=dict(
            label_ratio=str(Fraction(x['labels'],y['labels'])),
            volume_ratio_lower=str(vlo),volume_ratio_upper=str(vhi),
            ratio_ppm_lower=(vlo*10**6).__floor__(),
            ratio_ppm_upper=(vhi*10**6).__ceil__())
    result=dict(scope='Metadata only; no zero counts, timings or proof of domain sufficiency',
                definition='V=sum primitive_character_count(c)*positive_height(c)',
                profiles=out,comparisons=comparisons)
    Path(__file__).with_suffix('.json').write_text(json.dumps(result,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(result,indent=2))


if __name__=='__main__':main()
