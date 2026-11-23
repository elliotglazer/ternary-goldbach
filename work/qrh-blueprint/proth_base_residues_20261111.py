"""Finite residue-class arithmetic only; no primality search or prime density estimate."""
from math import prod
from pathlib import Path
import json

F = 2**45
BASES = (3, 5, 7, 11, 13, 17)


def main():
    tables=[]
    for ell in BASES:
        nonres={r for r in range(1,ell) if pow(r,(ell-1)//2,ell)==ell-1}
        assert len(nonres)==(ell-1)//2
        indices=[k for k in range(ell) if (F*k+1)%ell in nonres]
        tables.append(dict(base=ell,F_mod_base=F%ell,
                           candidate_nonresidues=sorted(nonres),
                           k_classes=indices))
    rows=[]
    for m in range(1,len(BASES)+1):
        bases=BASES[:m]
        wheel=prod(bases)
        admissible=0
        selected=[0]*m
        unselected=0
        for k in range(wheel):
            residues=[(F*k+1)%ell for ell in bases]
            if 0 in residues:
                continue
            admissible+=1
            choices=[i for i,r in enumerate(residues)
                     if r in tables[i]['candidate_nonresidues']]
            if choices:
                selected[choices[0]]+=1
            else:
                unselected+=1
        assert admissible == prod(ell-1 for ell in bases)
        assert unselected * 2**m == admissible
        for i,n in enumerate(selected):
            assert n * 2**(i+1) == admissible
        assert sum(selected)+unselected==admissible
        rows.append(dict(bases=bases,wheel=wheel,admissible=admissible,
                         first_base_counts=selected,no_selected_base=unselected,
                         covered_fraction=f'{2**m-1}/{2**m}'))
    assert tables[0]['k_classes']==[2]
    assert tables[1]['k_classes']==[1,3]
    assert tables[2]['k_classes']==[2,4,5]
    # Changing the sign condition to '+1' for base 3 selects the other
    # admissible class, so this explicit wrong selector is detected.
    wrong=[k for k in range(3) if pow((F*k+1)%3,1,3)==1]
    assert wrong != tables[0]['k_classes']
    data=dict(scope='Residue counts, not actual prime or window frequencies',
              F=F,tables=tables,rows=rows,negative_controls=1)
    Path(__file__).with_suffix('.json').write_text(
        json.dumps(data,indent=2)+'\n',encoding='utf-8')
    print(json.dumps(data))


if __name__=='__main__':
    main()
