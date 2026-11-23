from pathlib import Path
import sys,csv
here=Path(__file__).resolve().parent
old=here.parent/'c10000-bluestein'
sys.path.insert(0,str(old))
import blue as b
def pairs(name,rows):
    (here/(name+'.tsv')).write_text(''.join(f'{a}\t{c}\n' for a,c in rows),encoding='ascii')
units=[1+16*((pow(2,j,625)-1)*pow(16,-1,625)%625) for j in range(500)]
pairs('inputs',[b.quantize(b.acb.exp_pi_i(b.acb(2*r)/10000)) for r in units])
pairs('chirps',[b.quantize(b.acb.exp_pi_i(b.acb(j*j%1000)/500)) for j in range(500)])
pairs('roots',[b.quantize(b.acb.exp_pi_i(b.acb(2*j)/1024)) for j in range(512)])
for source,dest in [('kernel','kernel'),('outputs','expected')]:
    rows=csv.DictReader((old/(source+'.tsv')).open(),delimiter='\t')
    pairs(dest,[(r['re'],r['im']) for r in rows])

