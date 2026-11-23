"""Independently check all short-packet weights and analytic ceilings with integers."""
from fractions import Fraction
from hashlib import sha256
from math import ceil, prod
from pathlib import Path
import json

from endpoint_policy import HERE


def coefficient_evidence(x, denominator, size, scale, weights):
    differences = [x-j*denominator for j in range(size)]
    for i, k in enumerate(weights):
        num = prod(d for j,d in enumerate(differences) if j!=i)*scale
        den = denominator**(size-1)*prod(i-j for j in range(size) if j!=i)
        if 2*abs(num-k*den)>abs(den):
            return False
    return True


def radical_ceiling(num, den):
    # An integer-interval search independent of the producer's isqrt formula.
    lo, hi = 0, 1
    while hi*hi*den<num:
        hi *= 2
    while hi-lo>1:
        mid=(hi+lo)//2
        if mid*mid*den<num:
            lo=mid
        else:
            hi=mid
    assert lo*lo*den<num<=hi*hi*den
    return hi


def ceil_log2(x):
    n,d=x.numerator,x.denominator
    assert n>0
    e=n.bit_length()-d.bit_length()
    return e + int((n<<max(0,-e))>(d<<max(0,e)))


def certificate_mass(q, parity, b, last):
    assert 2<=b<=5 and 0<=parity<=1
    power=b+parity
    d=64*(b+2)+5*last
    n=q**power*d**(power-1)
    den=3**power*64**(power-1)
    root=radical_ceiling(n,den)
    exponent_num=9*(power-1)*(2*b-1)
    exponent_den=16*(b+2)
    exponent=(exponent_num+exponent_den-1)//exponent_den
    return 6*(1<<exponent)*root,root,exponent


def main():
    order=12
    source=HERE/'strip-repair-panel-stress.json'
    panel=json.loads(source.read_bytes())
    packed=(HERE/'strip-repair-packets-stress.tsv').read_bytes()
    assert sha256(packed).hexdigest()==panel['packet_sha256']
    rows = {r['q']:r for r in panel['rows']}
    bands,geometries,refs = {},{},[]
    tolerances=[]
    shift_only_passes=0
    shift_and_uniform_passes=0
    maximum_increase=Fraction(1)
    whole_cell_passes=0
    whole_cell_rows=[]
    weight_rows={}
    mass_rows={}
    for line in packed.splitlines():
        q,label,tick,sub,exp,bits,claimed,sign,*values=map(int,line.split())
        vec,weights = values[:order],tuple(values[order:])
        assert len(weights)==len(vec)==order
        row=rows[q]
        channels={c['label']:c['parity'] for c in row['channels']}
        parity=channels[label]
        last, rem=divmod(row['coarse_intervals'],len(channels))
        assert rem==0
        j=tick//sub
        start=min(max(0,j-(order//2-1)),last-order+1)
        offset=tick-start*sub
        key=(offset,sub,bits)
        if key not in geometries:
            assert coefficient_evidence(offset,sub,order,1<<bits,weights)
            bad=(weights[0]+2,*weights[1:])
            assert not coefficient_evidence(offset,sub,order,1<<bits,bad)
            delta=prod(abs(offset-i*sub) for i in range(order))
            geometries[key]=(len(geometries),weights,delta)
        g,prior,delta=geometries[key]
        assert prior==weights
        options=[]
        shift_options=[]
        cell_options=[]
        for b in (2,3,4,5):
            key=(q,parity,b,last)
            if key not in bands:
                m,rt,eshift=certificate_mass(q,parity,b,last)
                bands[key]=(len(bands),m,rt,eshift)
            h,m,_,_=bands[key]
            numerator=m*delta*10**order*(1<<max(0,bits-exp))
            denominator=(64*sub*(2*b-1))**order*(1<<max(0,exp-bits))
            options.append((Fraction(numerator,denominator),h))
            geometry=Fraction(delta*10**order,(64*sub*(2*b-1))**order)
            power=ceil_log2(m)+ceil_log2(geometry)+bits-exp
            shifted=1<<max(0,power)
            assert Fraction(numerator,denominator)<=shifted
            shift_options.append(shifted)
            # Paired factors for a centered stencil satisfy
            # (k+x)(k+1-x) <= (k+1/2)^2 for 0 <= x <= 1.
            if start==j-order//2+1:
                node_max=prod(Fraction(2*k+1,2)**2 for k in range(order//2))
            else:
                # Use the stronger exact-distance table at clipped edges.
                node_max=Fraction(delta,sub**order)
            uniform_geom=node_max*Fraction(10,64*(2*b-1))**order
            assert uniform_geom>=geometry
            mg,gg=ceil_log2(m),ceil_log2(uniform_geom)
            cell_options.append((mg+gg,b,mg,gg))
        exact,h=min(options)
        assert (claimed-1)*exact.denominator<exact.numerator<=claimed*exact.denominator
        assert claimed==ceil(exact)
        dot=sum(v*w for v,w in zip(vec,weights))
        margin=2*abs(dot)-2*(claimed+sum(map(abs,weights)))-sum(map(abs,vec))-order
        assert margin>0 and dot*sign>0
        upper=min(shift_options)
        assert claimed<=upper
        maximum_increase=max(maximum_increase,Fraction(upper,claimed))
        shift_only_passes+=int(margin>2*(upper-claimed))
        shift_and_uniform_passes+=int(2*abs(dot)>2*(upper+sum(map(abs,weights)))+order*((1<<16)+1))
        ce,b,mg,gg=min(cell_options)
        radius=1<<max(0,ce+bits-exp)
        assert radius>=claimed
        whole_cell_passes+=int(2*abs(dot)>2*(radius+sum(map(abs,weights)))+order*((1<<16)+1))
        whole_cell_rows.append([q,label,tick,parity,b,ce,exp,radius])
        mass_rows[f'{q},{parity},{b}']=mg
        weight_rows[f'{b},{start==j-order//2+1},{gg}']=gg
        # Extra node uncertainty beyond the existing absolute unit. Each
        # unknown exact coefficient times 2^bits has size <= |w|+1/2.
        abs_gain=sum(2*abs(w)+1 for w in weights)*(max(map(abs,vec))+1)
        rel_gain=sum((2*abs(w)+1)*(abs(v)+1) for w,v in zip(weights,vec))
        assert 0<rel_gain<=abs_gain
        tolerances.append((Fraction(margin,abs_gain),Fraction(margin,rel_gain)))
        refs.append([q,label,tick,g,h,exp])
    data=dict(scope='Integer verification of the coefficient rounding and global rational remainder used by every 12-node stress packet. The strip theorem, correspondence to Hardy amplitudes, and source quantization still need formal transfer.',
              packet_sha256=sha256(packed).hexdigest(),panel_sha256=sha256(source.read_bytes()).hexdigest(),
              geometries=[dict(id=i,offset=x,sub=sub,bits=bits,weights=w,node_distance_product=p)
                          for (x,sub,bits),(i,w,p) in geometries.items()],
              mass_bounds=[dict(id=i,q=q,parity=a,b=b,last=last,mass=m,radical_upper=rt,damping_exponent=e)
                           for (q,a,b,last),(i,m,rt,e) in bands.items() if any(r[4]==i for r in refs)],
              refs=refs,
              source_radius_sensitivity={str(bits):dict(
                  local_max=sum(2**bits*ab>1 for ab,_ in tolerances),
                  local_node=sum(2**bits*rel>1 for _,rel in tolerances))
                  for bits in range(3,19)})
    (HERE/'strip-parameter-witnesses.json').write_text(json.dumps(data,separators=(',',':'))+'\n')
    shortcut=dict(rows=len(refs),passes=shift_only_passes,packet_sha256=data['packet_sha256'],
                  passes_with_constant_sample_sum_bound=shift_and_uniform_passes,
                  passes_with_whole_cell_and_constant_sample_sum=whole_cell_passes,
                  selected_mass_exponents=mass_rows,geometry_exponents=weight_rows,
                  whole_cell_rows=whole_cell_rows,
                  worst_ratio_to_exact_integer_ceiling=str(maximum_increase),
                  rule='Store ceil-log2 integer mass per q/parity/strip width and ceil-log2 rational geometry per offset/strip width. One power of two per row bounds the full scaled remainder.')
    (HERE/'strip-shortcut.json').write_text(json.dumps(shortcut,indent=2)+'\n')
    print(len(refs),'packet ceilings',len(geometries),'weight tables',len(data['mass_bounds']),'distinct mass bounds')
    print(data['source_radius_sensitivity'])
    print('shift and whole-cell passes',shift_only_passes,whole_cell_passes,
          'mass/geometry exponent groups',len(mass_rows),len(weight_rows))


if __name__=='__main__':
    main()
